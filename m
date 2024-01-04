Return-Path: <netdev+bounces-61578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F406824515
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC69D2874EC
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50146241E0;
	Thu,  4 Jan 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sNIqqdAL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067D249E5
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Q5kl5TqYQBPlo0/mLGXwSKpCb7JYsVSVpTv1keIGScQ=; b=sN
	IqqdALhELpbo1a1VWxb7jE9ZADAtfGwMdcPWJwc+StzGmaWWvZCUdUdKIFDNDzWudvgGIAiAo3ldg
	jUEyoqYfgCe7iHFU2HhAoKVovwp9fid7saCXPTh088Vu208Z6FRcgCVxvziSJ68iNT5Hh7h2BWJKK
	3w6B9ePmE9gRER8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLPm8-004Mak-13; Thu, 04 Jan 2024 16:36:52 +0100
Date: Thu, 4 Jan 2024 16:36:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: ethtool ioctl ABI: preferred way to expand uapi structure
 ethtool_eee for additional link modes?
Message-ID: <d3f3fca4-624c-4001-9218-6bf69ca911b3@lunn.ch>
References: <20240104161416.05d02400@dellmb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104161416.05d02400@dellmb>

On Thu, Jan 04, 2024 at 04:14:16PM +0100, Marek Behún wrote:
> Hello,
> 
> the legacy ioctls ETHTOOL_GSET and ETHTOOL_SSET, which pass structure
> ethtool_cmd, were superseded by ETHTOOL_GLINKSETTINGS and
> ETHTOOL_SLINKSETTINGS.
> 
> This was done because the original structure only contains 32-bit words
> for supported, advertising and lp_advertising link modes. The new
> structure ethtool_link_settings contains member
>   s8 link_mode_masks_nwords;
> and a flexible array
>   __u32 link_mode_masks[];
> in order to overcome this issue.
> 
> But currently we still have only legacy structure ethtool_eee for EEE
> settings:
>   struct ethtool_eee {
>     __u32 cmd;
>     __u32 supported;
>     __u32 advertised;
>     __u32 lp_advertised;
>     __u32 eee_active;
>     __u32 eee_enabled;
>     __u32 tx_lpi_enabled;
>     __u32 tx_lpi_timer;
>     __u32 reserved[2];
>   };
> 
> Thus ethtool is unable to get/set EEE configuration for example for
> 2500base-T and 5000base-T link modes, which are now available in
> several PHY drivers.
> 
> We can remedy this by either:
> 
> - adding another ioctl for EEE settings, as was done with the GSET /
>   SSET
> 
> - using the original ioctl, but making the structure flexible (we can
>   replace the reserved fields with information that the array is
>   flexible), i.e.:
> 
>   struct ethtool_eee {
>     __u32 cmd;
>     __u32 supported;
>     __u32 advertised;
>     __u32 lp_advertised;
>     __u32 eee_active;
>     __u32 eee_enabled;
>     __u32 tx_lpi_enabled;
>     __u32 tx_lpi_timer;
>     s8 link_mode_masks_nwords; /* zero if legacy 32-bit link modes */
>     __u8 reserved[7];
>     __u32 link_mode_masks[];
>     /* filled in if link_mode_masks_nwords > 0, with layout:
>      * __u32 map_supported[link_mode_masks_nwords];
>      * __u32 map_advertised[link_mode_masks_nwords];
>      * __u32 map_lp_advertised[link_mode_masks_nwords];
>      */
>   };
> 
>   this way we will be left with another 7 reserved bytes for future (is
>   this enough?)
> 
> What would you prefer?

There are two different parts here. The kAPI, and the internal API.

For the kAPI, i would not touch the IOCTL interface, since its
deprecated. The netlink API for EEE uses bitset32. However, i think
the message format for a bitset32 and a generic bitset is the same, so
i think you can just convert that without breaking userspace. But you
should check with Michal Kubecek to be sure.

For the internal API, i personally would assess the work needed to
change supported, advertised and lp_advertised into generic linkmode
bitmaps. Any MAC drivers using phylib/phylink probably don't touch
them, so you just need to change the phylib helpers. Its the MAC
drivers not using phylib which will need more work. But i've no idea
how much work that is. Ideally they all get changed, so we have a
uniform clean API.

    Andrew

