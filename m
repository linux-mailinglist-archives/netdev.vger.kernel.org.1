Return-Path: <netdev+bounces-61604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EAD824607
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931B41C22006
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3324A06;
	Thu,  4 Jan 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMzGv5OP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C624B23
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E8BC433C7;
	Thu,  4 Jan 2024 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385312;
	bh=iH8UgEIlNkKCU0Tg/9cOcjjbRM1pXAEumLOFHccMkAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YMzGv5OPzSka865f1SXwQQmYH2a7h7BwJ1ax0ZNAQZaYswUe8yu+Ro1GHx6VBn6AE
	 GD4PowWOz9vG7DM+011ggsDyweZuCMfP+//Wwm8qRSxWeyZ4Eg4vWh6zZ2TCpwZJ5L
	 +TfIGdDXTQk2edI/HQyu9XOt1moJsHQZyAi0lI+eQTB3GpJxbPH/94a/UMLBedF+of
	 camfkqrY/nWr0A2idMfZz18Hyk4SOfKZl97EYUplxphLa62PxUQxxLuzOGb/fFZDvo
	 45d3Vlr03NGzYmm/tYq1AZqR7XBV6rVc27qn5ouVcNchgmdGKo1inBj1p99HG/px3/
	 yMiIAGpxW/Iuw==
Date: Thu, 4 Jan 2024 17:21:48 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: ethtool ioctl ABI: preferred way to expand uapi structure
 ethtool_eee for additional link modes?
Message-ID: <20240104172148.65ab4ac3@dellmb>
In-Reply-To: <ceaee76d-d785-4931-ad4a-ddba06365308@gmail.com>
References: <20240104161416.05d02400@dellmb>
	<d3f3fca4-624c-4001-9218-6bf69ca911b3@lunn.ch>
	<ceaee76d-d785-4931-ad4a-ddba06365308@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jan 2024 17:06:54 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 04.01.2024 16:36, Andrew Lunn wrote:
> > On Thu, Jan 04, 2024 at 04:14:16PM +0100, Marek Beh=C3=BAn wrote: =20
> >> Hello,
> >>
> >> the legacy ioctls ETHTOOL_GSET and ETHTOOL_SSET, which pass structure
> >> ethtool_cmd, were superseded by ETHTOOL_GLINKSETTINGS and
> >> ETHTOOL_SLINKSETTINGS.
> >>
> >> This was done because the original structure only contains 32-bit words
> >> for supported, advertising and lp_advertising link modes. The new
> >> structure ethtool_link_settings contains member
> >>   s8 link_mode_masks_nwords;
> >> and a flexible array
> >>   __u32 link_mode_masks[];
> >> in order to overcome this issue.
> >>
> >> But currently we still have only legacy structure ethtool_eee for EEE
> >> settings:
> >>   struct ethtool_eee {
> >>     __u32 cmd;
> >>     __u32 supported;
> >>     __u32 advertised;
> >>     __u32 lp_advertised;
> >>     __u32 eee_active;
> >>     __u32 eee_enabled;
> >>     __u32 tx_lpi_enabled;
> >>     __u32 tx_lpi_timer;
> >>     __u32 reserved[2];
> >>   };
> >>
> >> Thus ethtool is unable to get/set EEE configuration for example for
> >> 2500base-T and 5000base-T link modes, which are now available in
> >> several PHY drivers.
> >>
> >> We can remedy this by either:
> >>
> >> - adding another ioctl for EEE settings, as was done with the GSET /
> >>   SSET
> >>
> >> - using the original ioctl, but making the structure flexible (we can
> >>   replace the reserved fields with information that the array is
> >>   flexible), i.e.:
> >>
> >>   struct ethtool_eee {
> >>     __u32 cmd;
> >>     __u32 supported;
> >>     __u32 advertised;
> >>     __u32 lp_advertised;
> >>     __u32 eee_active;
> >>     __u32 eee_enabled;
> >>     __u32 tx_lpi_enabled;
> >>     __u32 tx_lpi_timer;
> >>     s8 link_mode_masks_nwords; /* zero if legacy 32-bit link modes */
> >>     __u8 reserved[7];
> >>     __u32 link_mode_masks[];
> >>     /* filled in if link_mode_masks_nwords > 0, with layout:
> >>      * __u32 map_supported[link_mode_masks_nwords];
> >>      * __u32 map_advertised[link_mode_masks_nwords];
> >>      * __u32 map_lp_advertised[link_mode_masks_nwords];
> >>      */
> >>   };
> >>
> >>   this way we will be left with another 7 reserved bytes for future (is
> >>   this enough?)
> >>
> >> What would you prefer? =20
> >=20
> > There are two different parts here. The kAPI, and the internal API.
> >=20
> > For the kAPI, i would not touch the IOCTL interface, since its
> > deprecated. The netlink API for EEE uses bitset32. However, i think
> > the message format for a bitset32 and a generic bitset is the same, so
> > i think you can just convert that without breaking userspace. But you
> > should check with Michal Kubecek to be sure.
> >=20
> > For the internal API, i personally would assess the work needed to
> > change supported, advertised and lp_advertised into generic linkmode
> > bitmaps. Any MAC drivers using phylib/phylink probably don't touch
> > them, so you just need to change the phylib helpers. Its the MAC
> > drivers not using phylib which will need more work. But i've no idea
> > how much work that is. Ideally they all get changed, so we have a
> > uniform clean API.
> >  =20
> In case you missed it: Few days ago I posted a series that adds full
> EEE linkmode bitmap support to the ethtool netlink interface.
> The good news is that no changes to the userspace tool are needed.
>=20
> https://lore.kernel.org/netdev/783d4a61-2f08-41fc-b91d-bd5f512586a2@gmail=
.com/T/

I did indeed miss it :) Thanks

