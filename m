Return-Path: <netdev+bounces-165708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DB0A332EA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444823A5C3D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61820011F;
	Wed, 12 Feb 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QQ+RRQ6a"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB41FCF62
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400809; cv=none; b=GkkMF6xlxIHZVOAMpokFwlEU8af7KKvgafU9tWQWJj0WhkLAYjgH1HoX+j4GkiKENj1vSMIw0Pgv19Xr6KdTncHfTv/ePzJ3YmKQ5PYKGoE01HbTPY1+wPxqBDvd21LzsG/yEM68XP2gVmCqe40g7LiYaS9YfeuXaYD2mCIOe5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400809; c=relaxed/simple;
	bh=gxKItFK5yntfBgD9HTyPP5mBsnaxVwFhxLihPPu5kvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAk/U/pU/+JSiAmaQh2Zw8DL4ml2usaITFq+G0PI07Pn68naUU7SS83QCcnnlxEU68mnp0lg7mMmL2U0h0ryLmUS9rkMKeNrMuCCpDvgyVCYNH3IWdUBHeINPmPqYj/WDIycCADmkPiwCm3Ap3j5lfsjatvKSrmW0wyOdLg8TIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QQ+RRQ6a; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+pGLI11s/B3BgT8AU67fYEi7zb4zitoTFZtr4wbKotA=; b=QQ+RRQ6a9AywCAnr8rTFfUjnZ4
	iiOj+yPrxyRbftWGM7aW9Gg+07Rh/X9YnqZu74gRn+29ttNiSTBAa3bsNV6UGuMQRjuN7mWOQcH8p
	A3Wm+TPcDHpHwU/t/aO8zR8LroAq1oXN7UGfbNhXLlFQWNKBsjH5E5ASySrpv8LnzoIMcOwnLT0Pp
	dFwkbOHwrCbwjdWB2eqF1MIL39ns7hUopeLJOYcuRCu3RN/VVRo/HVhmh1ph+o1Ns4fmsB3IwcNnz
	PiZomiFZffyEhiBPBNiI69N5QuhRRmTIzNBJOVL3Oluayw89kY3NSts6h25o6H0K9IIi8FO2rnYVj
	iaCJS9dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58598)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiLba-0007Sx-2K;
	Wed, 12 Feb 2025 22:53:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiLbX-0001Um-2Q;
	Wed, 12 Feb 2025 22:53:15 +0000
Date: Wed, 12 Feb 2025 22:53:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v6 6/7] net: selftests: Export
 net_test_phy_loopback_*
Message-ID: <Z60mWzm0gkMlKNEe@shell.armlinux.org.uk>
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-7-gerhard@engleder-embedded.com>
 <d6cb7957-1a54-4386-8e10-17cea49851df@lunn.ch>
 <b18971f2-0edf-4fa7-be1b-eec8392665f0@engleder-embedded.com>
 <c1229fd9-2f65-40dd-bbb5-9f0f3e3b2c2c@lunn.ch>
 <09a4cd33-3170-4f87-a84b-5e1734d97206@engleder-embedded.com>
 <464ec7ed-2943-4696-a198-2495d4035f91@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464ec7ed-2943-4696-a198-2495d4035f91@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 12, 2025 at 11:34:14PM +0100, Andrew Lunn wrote:
> It might however be that we cannot rename reserved, it is now part of
> the kAPI, and changing it to another name would break the compilation
> of something. That is one of the advantages of netlink API, you can
> add new attributes without having to worry about breaking older
> builds. Unfortunately, the self test is still using the IOCTL, it has
> not been converted to netlink.

If you wanted to introduce "speed" where "reserved" is, then could be
done is:

struct ethtool_test {
	__u32	cmd;
	__u32	flags;
	union {
		__u32	reserved;
		__u32	speed;
	};
	__u32	len;
	__u64	data[];
};

That would mean anyone assigning to ethtool_test.reserved would still
continue to work as the union is anonymous.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

