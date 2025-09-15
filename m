Return-Path: <netdev+bounces-222897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7FBB56DF6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78101755E0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B448A1F8ACA;
	Mon, 15 Sep 2025 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rr1pCl5C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B813DDAA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757900612; cv=none; b=GmfEF5WtMMd3bz48vZDw4s66O2jQUMnG+K8bWNSAJfXs/2n2JAIm8nlJDJ0XVuC6ZPunaeYG4VCNo3IK+QEcJQFenhMb4SWWtNwQ9A4lZH9XcEsYRtNniArFZ0RKpnXqK4AC1wuVrMbzKQLCWYRXCYU074HlBIJebC3A3Ohqh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757900612; c=relaxed/simple;
	bh=zCsK6BlJ82HSf/uw1ZZxY8/o0y2bDbRzIHZtI3om1z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhonm2DrqS4YfmxfC6OzhUuD289Y5gT6rPOJDP/CHVLKvlCXon4Da5q+TJEcEXkGl4FahRdRfddSvUJNMXAZe+3SRSZWan+k9ZXMFxlRvc4CnYGQj2vuJiJcBjTM3guyRzQBaIfdaCpX8LgQdk8vE7p2ydHRLYeNRGwb/7jq8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rr1pCl5C; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 738473F2CA
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757900278;
	bh=hcIzuhKiKNm6JVHXa92r6htbz03BDwVBOL/bRK53VK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=rr1pCl5Ckyu5hnZS3I+3Tv21XQIKVns+TdoBGgdGci8e2xiMfKh46392MfrDjXShb
	 Tu0IEuj+KFMENbnwf4cJBFCLc14+HywYfMl7PUh6sD/sVG51t80QpF4OXPtLgy+luT
	 bGiOfr6ebEHX6olOGT4a+4ruyJ8Uka4fP3+7495HtLIzsaOczhXYtfeNXYWTbPLxDu
	 4/Xhjvp2RbMNIaL0zcPsvDX7uJsIX1GG7XJoCTTt5nr8/ZBhPoVPeApN/JZcsYgxK9
	 jrF5LfE6Mv4dWFMnaW1FD2SIxwXKHA7wwIg9OqlbI/gGGa5bF+CbOcBRrjc3dbuHne
	 XcrqulH4sGT3A==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7725a76dcb4so2733284b3a.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 18:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757900276; x=1758505076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcIzuhKiKNm6JVHXa92r6htbz03BDwVBOL/bRK53VK4=;
        b=YGta/1I8Sfq/YBDkXlRItGcf+1CQXZDmkXTT+iij1PYQXiUTFimU1VeUs2MD6bdi8+
         8DlXPWjTiHXd/wxs3yV/ivFp5JbXW7gkRlHAoPM99iJq8MJ1MPKk+A3x+BrOOd/bwMuo
         I938eezsN3gC9nXv1mHiQZbcUrq4k7QxM26DpkVrw/VpGxc+O09FnV5sXM0RPFZsLiWp
         SGDh/OFxsz5R2rhTsLMciCf2zd1eSXI6zZRLZs3rGMeFmB3UM5IcTZVThM8tN7mOSJTR
         nejtvb9bbRekVbwz0f8Zzj9hM0/uYUAZgJ3HjK+6N21qOk5vK3Ia+B/bso+MXFf1nkuo
         fC7g==
X-Forwarded-Encrypted: i=1; AJvYcCWbvlaCG9ARBopjuli8Lc/UqBrrD7O4DYMIeYGuITs4WpzyrJRIzpbczRwXBDlcw5qkQNvz8Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqz9aVSTQQS9QjFoxYOgEFYcaDy/5DzBrH1WLa++gs46NoJvb
	S72Y4JagHkq2Bc74vQYaMzze5cRBCWWvn/S7fhB5wvYJeVw0YKixYuQOd0t8ludjc35DYZhmlWs
	I30HaqBYQjrXxS/5ATytI8Me532OAvlbx0sqSIdHAjz6MDEeeQoXp1Z2q/Wff0SL0s5GDVhQtbw
	==
X-Gm-Gg: ASbGnct7FLjJw7mSyNTENv6CilDcHD1RlDpiDFpPWPNuRzMkCF4mMURIf8HQWFmLiV9
	zh5lzmj2ppqwJmAYzy49rsm+yvAdWtYsXZ+UJtwrm3x8PHzEaFD6p16BZ+ZSeMYvPCBZoOOLLi+
	n6Y0cX0mU+uut+/aG8pWItfBDwfav0Fp+t1Z1f3I3MI+e0ejB9FHClVXIuAF9DB2MwCNhBnbsSd
	VxCf8MlGHqutjCw7jy7opQ3vSMuYu86VHgL+FAPsIqoAA+lGxBbVQknpKYDb5HxYz1/j0vgnp27
	MhlBy5iHtuj39AfuNvU4AnLgS04hMlFY6xoz0D++VaLy0DmJ
X-Received: by 2002:a05:6a21:e097:b0:243:b62c:8a7d with SMTP id adf61e73a8af0-26024f5fa39mr14292919637.0.1757900276525;
        Sun, 14 Sep 2025 18:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8+m1tT1GvSiNg/KYeKheOGpPJ5Kqk1MCOil0ukcnoPVBiEdtHbuWNT13Zum2HA/ItideTPg==
X-Received: by 2002:a05:6a21:e097:b0:243:b62c:8a7d with SMTP id adf61e73a8af0-26024f5fa39mr14292900637.0.1757900276135;
        Sun, 14 Sep 2025 18:37:56 -0700 (PDT)
Received: from acelan-precision5470 ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776210c4a5bsm5747436b3a.47.2025.09.14.18.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:37:55 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:37:37 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Wang, Crag" <Crag.Wang@dell.com>, 
	"Chen, Alan" <Alan.Chen6@dell.com>, "Alex Shen@Dell" <Yijun.Shen@dell.com>
Subject: Re: [PATCH] r8169: enable ASPM on Dell platforms
Message-ID: <rqeme247cojqejerkedcj7m6t6zglks3pe2wcro3xvprit6npt@s4ymo5357hiv>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Wang, Crag" <Crag.Wang@dell.com>, 
	"Chen, Alan" <Alan.Chen6@dell.com>, "Alex Shen@Dell" <Yijun.Shen@dell.com>
References: <20250912072939.2553835-1-acelan.kao@canonical.com>
 <cc91f4ab-e5be-4e7c-abcc-9cc399021e23@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc91f4ab-e5be-4e7c-abcc-9cc399021e23@gmail.com>

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
> > 
> I'd like to avoid DMI-based whitelists in kernel code. If more system
> vendors do it the same way, then this becomes hard to maintain.
I totally understand your point; I also don’t like constantly adding DMI
info to the list. But this list isn’t for a single product name, it’s a
product family that covers a series of products, and it probably won’t
change anytime soon.

> There is already a mechanism for vendors to flag that they successfully
> tested ASPM. See c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor
> flags it as safe").
Right, but writing the flag is not applicable for Dell manufacturing
processes.

> Last but not least ASPM can be (re-)enabled from userspace, using sysfs.
That doesn't sound like a good solution to push the list to userspace.

Dell has already been working with Canonical for more than a decade to
ship their products with r8169 ASPM enabled. Dell has also had lengthy
discussions with Realtek to have this feature enabled by default in the
r8169 driver. I think this is a good opportunity for Dell to work with
Realtek to spot bugs and refine the r8169 driver.

BTW, I found the dmi.h header file is missing in the patch, so I
submitted a v2 patch.
https://lore.kernel.org/lkml/20250915013555.365230-1-acelan.kao@canonical.com/T/#u
> 
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

