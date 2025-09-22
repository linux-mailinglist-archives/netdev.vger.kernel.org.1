Return-Path: <netdev+bounces-225327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C2B9242F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30449444C44
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF03126BC;
	Mon, 22 Sep 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0fHnClN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6A311959;
	Mon, 22 Sep 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559299; cv=none; b=qsJHNKsm9rHAvZsTyvkTgbYaTtZ9Ct/GFyr/jNsQ3/qHA+DXBhmRG4CJRqskv8ThgXUWWxhCjqJq93k26buZ13Mz6ZPl/91nxm8icPOY778bY2MR7s/kr0FnOQO1Y0yQc4/plxcA2QnpnRXtkK8Q97mL6fOPH0GNuQ5cvFDF7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559299; c=relaxed/simple;
	bh=Oq+iY8xfZXLrht7GmRXk39veUta17dfgNesQDmKGwkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QEZmGuaPkD32BhxOUmTdgOmTwVcGXQpMFGbsV/xCnt5ds002MPv4JRFM18zXySMWeTu92dsuKLedGDrtQWDYZtYhej87EzAbfmx1tqp5OfwJilqaik7AN/EQvDrTGJ3ox8wHtFhN4vdamMevUIQpSFKNTkc/sXNgYJlXZ+yLePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0fHnClN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1031AC4CEF0;
	Mon, 22 Sep 2025 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758559299;
	bh=Oq+iY8xfZXLrht7GmRXk39veUta17dfgNesQDmKGwkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g0fHnClNyyKjyVWt8ziTMZu/Gf3tPeDCUmMblwd6FnGHlGiiv0uV9zzEFkgFl4DW3
	 7cYddj86fnykabFzk/SPQ/ab6ABguuVij2KQ4PKgglmn/eajaD3oFYo+pIs85zadKg
	 l/19CoEKCJj/Oj2dL+TG18AkZER+eK1EIazBtfCzYU07yGmjZ9f8xxLWvqmfCtRaH5
	 4vegZjqOTE/QIl9QZ+z4hGcEpnoILkEhzq32U9OXGkFFnOIqRGd5N1mcyTQyAvmMB0
	 UZ2dMaMKfw8wkx481IlfA1hC+vulewrChRWWiqP/jJWMUwJ8e8YoMVBuqJosEdFSKQ
	 llyO3bzGz+hFw==
Date: Mon, 22 Sep 2025 11:41:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Wang, Crag" <Crag.Wang@dell.com>,
	"Chen, Alan" <Alan.Chen6@dell.com>,
	"Alex Shen@Dell" <Yijun.Shen@dell.com>,
	ChunHao Lin <hau@realtek.com>, Hayes Wang <hayeswang@realtek.com>
Subject: Re: [PATCH] r8169: enable ASPM on Dell platforms
Message-ID: <20250922164137.GA1977049@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc91f4ab-e5be-4e7c-abcc-9cc399021e23@gmail.com>

[+cc ChunHao, Hayes, nic_swsd]

On Fri, Sep 12, 2025 at 05:30:52PM +0200, Heiner Kallweit wrote:
> On 9/12/2025 9:29 AM, Chia-Lin Kao (AceLan) wrote:
> > Enable PCIe ASPM for RTL8169 NICs on Dell platforms that have been
> > verified to work reliably with this power management feature. The
> > r8169 driver traditionally disables ASPM to prevent random link
> > failures and system hangs on problematic hardware.
> > 
> > Dell has validated these product families to work correctly with
> > RTL NIC ASPM and commits to addressing any ASPM-related issues
> > with RTL hardware in collaboration with Realtek.
> > 
> > This change enables ASPM for the following Dell product families:
> > - Alienware
> > - Dell Laptops/Pro Laptops/Pro Max Laptops
> > - Dell Desktops/Pro Desktops/Pro Max Desktops
> > - Dell Pro Rugged Laptops

Kudos to Dell for validating their products.

> I'd like to avoid DMI-based whitelists in kernel code. If more system
> vendors do it the same way, then this becomes hard to maintain.
> There is already a mechanism for vendors to flag that they successfully
> tested ASPM. See c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor
> flags it as safe").
> Last but not least ASPM can be (re-)enabled from userspace, using sysfs.

I don't maintain r8169, but I agree that a DMI-based list is a
maintenance headache.

Such a list also screws up the incentives: Realtek and OEMs benefit by
selling these products, so they should bear the burden when they don't
work correctly.  Adding a DMI list unfairly shifts that burden to the
maintainer.

"Random link failures and system hangs" are probably not actually
random, just not understood completely.  If they're due to broken
RTL8169 hardware or firmware, we should have quirks to disable ASPM
when necessary.  Same if there are broken Root Ports, although that
seems unlikely since it would affect many devices.

If the problems are due to misconfiguration, we should debug that.  Do
we have any concrete bug reports?  Are there cases where RTL8169 works
correctly with Windows but not Linux, where we could compare the ASPM
configuration?

> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >  drivers/net/ethernet/realtek/r8169_main.c | 29 +++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 9c601f271c02..63e83cf071de 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -5366,6 +5366,32 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
> >  	rtl_rar_set(tp, mac_addr);
> >  }
> >  
> > +bool rtl_aspm_new_dell_platforms(void)
> > +{
> > +	const char *family = dmi_get_system_info(DMI_PRODUCT_FAMILY);
> > +	static const char * const dell_product_families[] = {
> > +		"Alienware",
> > +		"Dell Laptops",
> > +		"Dell Pro Laptops",
> > +		"Dell Pro Max Laptops",
> > +		"Dell Desktops",
> > +		"Dell Pro Desktops",
> > +		"Dell Pro Max Desktops",
> > +		"Dell Pro Rugged Laptops"
> > +	};
> > +	int i;
> > +
> > +	if (!family)
> > +		return false;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(dell_product_families); i++) {
> > +		if (str_has_prefix(family, dell_product_families[i]))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  /* register is set if system vendor successfully tested ASPM 1.2 */
> >  static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
> >  {
> > @@ -5373,6 +5399,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
> >  	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
> >  		return true;
> >  
> > +	if (rtl_aspm_new_dell_platforms())
> > +		return true;
> > +
> >  	return false;
> >  }
> >  
> 

