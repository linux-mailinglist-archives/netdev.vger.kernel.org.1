Return-Path: <netdev+bounces-131040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E132998C6AF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6242F1F23BF7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF91CCB58;
	Tue,  1 Oct 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC7DVb2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E51925B8
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814058; cv=none; b=kId3Z1DbDvLcL+DmYxAYbMGtv7+a6T9JsT/Tv7+fJ3kADYFFCPucSNNqkUD2z+t0JKLzVBzG0+hZfukkG11yZL/qC+JWoPlbR41EdXE5H6U8OBB6lu/VPGmb1FZnxP7SHQ9b8zSu3ouKpFFiTSmT0tvBbDNALkZbpkI8WGJ/718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814058; c=relaxed/simple;
	bh=f3uxoRsp0o1ViZrjM9qiuuUpern1A3CXKB9dZm4OPMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7EE4DmCQMuS/wK9CQAApO1Z2OPHRh4aoJvUl7YrrJSPDRhLr0ftQxr1DpI/GgjbMnvHJrdpjJzh/fVL2cb3iR1ciECAgXGDgSOASqCwFqKM3PdnmI31kY8ZzrLe3RaocgHfONLcXBI415yp5EV66/KEOECyVVDXHpKlcwgtfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC7DVb2w; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-537a399e06dso6885772e87.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814055; x=1728418855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ73CcQvi1PQ+XEgRkwDCiOtDJhUD8sj5gWpktchgqE=;
        b=aC7DVb2wj19KWDrBOAHqvCccEeM4sLDZ4fT10puAgV3H3/PBrL+02emGO40e260P9I
         O0+Bnyr4k8+d7pXHqXxdOo/hx0iLe9I4LlilGfs48DjN/bXfyhi19q4tLVKgXbwX8i2G
         itjLfIWeJYErcVBc1VJUkPzPVgjC6EVYa47IT9qZlDWdJR49fHuoiGOv5FSCSGkuUL2U
         0pWhoi8OctNWuQMJrCwyX7Y64ToiAKEuXgP1O2U+Gz6lXtPmm0fX7PyvejwWoo1XJSTE
         oJXQwuwGfnGaq/Dm2ADHxP8/7+ZvBmGtmQWCRB9eJ8DmgHxsA2ls7DAnUd8dONOVNnfR
         Ldow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814055; x=1728418855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ73CcQvi1PQ+XEgRkwDCiOtDJhUD8sj5gWpktchgqE=;
        b=v13GaFyBKAwQIqL6EnabC2LMAYQjrO6yG5HmMrpNOL7FOYahLpBR9c9hNxAbc16WxA
         UNnPvFLVWuG90GNkfbw2+ZdWL/Te7ya9D22MTShFJVl8jCrN39wn3S2eBUPGKS8ZpbF6
         JNMylahL1aa9xAuql517rbIMhYlepcMT9I2BsewLipBy5PBAd/Z0MLxajbkl3ANtllQc
         TY7lQUQY4SnUudOXTQwC6lP8XbPYz5urSQ8OGvSj868d+dMXjvqIy0UOTJ4rLTcqK2LO
         cR0UMbiIyrr9v8fU5LpcMGQXvRBep4ASC+ib39u31w+7d/05yHkPnObp1knge7W7V66h
         wtNg==
X-Forwarded-Encrypted: i=1; AJvYcCUWXvCJC1ju8ZAtuR5yR7YDX0Yv+IHbMb41oo87Gs32kLq9pCDNq75INiMOZbH+babIepOb/UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOSn7nhqEi+SRDPcRtK/uO64TbR2j5N2U/pCW55iR5l4lR8sJ
	el8DMP5FsTRLFm4H3byvUeMQPJbfGlsDa0W57g3PXESYa+GuwlIF
X-Google-Smtp-Source: AGHT+IFApS0/WtALkW3Qi+48Aew2ZvtyMeOfMCb8CRdV8LudxHG1ORDpdi8RYFS2Cc/aayUDMXCAQw==
X-Received: by 2002:a05:6512:68a:b0:535:63a9:9d8c with SMTP id 2adb3069b0e04-539a0664ff6mr399889e87.17.1727814054194;
        Tue, 01 Oct 2024 13:20:54 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5398ff6996csm1124907e87.170.2024.10.01.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:20:53 -0700 (PDT)
Date: Tue, 1 Oct 2024 23:20:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <7drrlatwrjf3x77k3fswobcmbquye5luu2thoxwahqmodsm3ur@c6vqwcgtwnot>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
 <mykeabksgikgk6otbub2i3ksfettbozuhqy3gt5vyezmemvttg@cpjn5bcfiwei>
 <Zvp59w0kId/t8CZs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvp59w0kId/t8CZs@shell.armlinux.org.uk>

On Mon, Sep 30, 2024 at 11:14:15AM GMT, Russell King (Oracle) wrote:
> On Mon, Sep 30, 2024 at 01:16:57AM +0300, Serge Semin wrote:
> > Hi Russell
> > 
> > On Mon, Sep 23, 2024 at 03:00:59PM GMT, Russell King (Oracle) wrote:
> > > +static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
> > > +{
> > > +	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
> > > +	const struct dw_xpcs_compat *compat;
> > > +	int ret;
> > > +
> > > +	if (!xpcs->need_reset)
> > > +		return;
> > > +
> > 
> > > +	compat = xpcs_find_compat(xpcs->desc, interface);
> > > +	if (!compat) {
> > > +		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
> > > +			phy_modes(interface));
> > > +		return;
> > > +	}
> > 
> > Please note, it's better to preserve the xpcs_find_compat() call even
> > if the need_reset flag is false, since it makes sure that the
> > PHY-interface is actually supported by the PCS.
>
 
> Sorry, but I strongly disagree. xpcs_validate() will already have dealt
> with that, so we can be sure at this point that the interface is always
> valid. The NULL check is really only there because it'll stop the
> "you've forgotten to check for NULL on this function that can return
> NULL" brigade endlessly submitting patches to add something there -
> just like xpcs_get_state() and xpcs_do_config().

Thanks for the detailed answer. Indeed, I missed the part that the
pcs_validate() already does the interface check.

> 
> > > +	bool need_reset;
> > 
> > If you still prefer the PCS-reset being done in the pre_config()
> > function, then what about just directly checking the PMA id in there?
> > 
> > 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
> > 		return 0;
> > 
> > 	return xpcs_soft_reset(xpcs);
> 
> I think you've missed what "need_reset" is doing as you seem to
> think it's just to make it conditional on the PMA ID. That's only
> part of the story.
> 
> In the existing code, the reset only happens _once_ when the create
> happens, not every time the PCS is configured. I am preserving this
> behaviour, because I do _NOT_ wish to incorporate multiple functional
> changes into one patch - and certainly in a cleanup series keep the
> number of functional changes to a minimum.

Ok. So the goal is to preserve the semantics. Seems reasonable. But... 

> 
> So, all in all, I don't see the need to change anything in my patch.

I'll get back to this patch discussion in the v1 series since you have
already submitted it.

-Serge(y)

> 
> Thanks for the feedback anyway.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

