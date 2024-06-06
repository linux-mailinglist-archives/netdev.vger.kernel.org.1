Return-Path: <netdev+bounces-101354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB648FE3E2
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A811F23E07
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8F190484;
	Thu,  6 Jun 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4NhDUa3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282018FDCB;
	Thu,  6 Jun 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668704; cv=none; b=uV4EjvjMsrZmRBxayXfJncfkoNNNK0Ni6TLkjyOkl81kDN4nKDtOM6msTuPGRbpAU7qCBj9Kt8Lb9/EXrUlOqN/V+rSYWtnJG3as4CspOj9DGzvlmxX17R/mVKjPR6uQl7zHVaf6OnzteFuEIq3xYlU61t9kwQ/1hdYWaA5+dfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668704; c=relaxed/simple;
	bh=iagq9VWE8nM656J21wEWgyXfeacc0MmduRHfGZz1I20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVmIqhIPiTw+rsprxaGFhbk3WQD7R7yfpRmTikl7nNkuvY8DIe0YO+S+CiS9L+3jSSeFtBG8pWlvxdjNkGBvgmJNEDMziDMhXVwhkZXIEMJKPss15A6QWA+D1GENSRaAALLOcqAPdltrLObq773UIyP+jO8ss3IpY1jM78MqDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4NhDUa3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b894021cbso1046675e87.0;
        Thu, 06 Jun 2024 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668701; x=1718273501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrPn0o3FIz2PkjKVCMtEeALM6vIfsW/w5ARZz9TMBEw=;
        b=Z4NhDUa3Zoe7/TVdPNCggMMhL991hNr96U4HAFE9AygQx/M9HmFCzsAni2GIKg5WQ7
         794LUoGZZk/bx4UK85X5ZEKGBPvRnvIz+LWknXn6SEDDE4Vdkqk1VAM/P/75XROlGvwx
         nCD9HTO1PTloaZrBzo6xliWHg0BR7VS9VsaHF5MZ4VBbVY6zqWBozPlDEx0dr+2pjZxt
         XC9GAClJIJrUUGSmi8An67ZdJhegQ0JaqiXV+97N5/z5utekRZjBWNlSpdiY8PU5bdUz
         CZe7vuTN0pI4DcZCyq18PK6osnBweMhi8H2O6xOSLLebksDbcBGHJsYq9Kh1kaUDHEi3
         dIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668701; x=1718273501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrPn0o3FIz2PkjKVCMtEeALM6vIfsW/w5ARZz9TMBEw=;
        b=IA7JXnyvk/rMqpwl1JR+4Jim87rWblc7OcmpRdEYSGSvA1+oDWblzv8+m9wo0zQh46
         hj4Bg8Eva8V3t678ReH4WPfZbjx7DJtg5o2n2kaN6+mqQpba7kIN2f/Geu81hLFpjsvp
         84KtF3xWZuHagEMRuN+ThdNwjSvrgLG1khj/geqT/MHbcKxdDNMFo+ytYI/iq8KEyLdg
         qf6OY5cU+cSCvSta69wBcBOUzU0/fnDn35+03ko0Mz6vY0O79YWMQ7TxG7fchHLKOjSX
         icoEZePi1UHM2zpeScelBGhodvYgE5Mq+Kho1ZPMX1XBOUDDR/mXCPnPgtl1KgmMGK1t
         uHOg==
X-Forwarded-Encrypted: i=1; AJvYcCUL/0HjOPoGyDMXd0//+8jj9loCdS3DI5BcTqFbJ1z53amf/q9cX0ArpdFJlfoDyr6C3LwYUVjtk++ZThHrfW/11q7v/MUqqrhbD/nJuF3Ak1h+aatMFBOf4bWAuMo/zTEvSTIRSI5hvOe6sbQk0x+I59qi8GRHYc/eWGiAGof9mw==
X-Gm-Message-State: AOJu0YyJCtpIK5R8u6EWcRh92xU6Z3R92cHEEGFynGqsmHZ1vRUZmQgv
	0AQy/IwRH79oo1OrQpR0X0S9qvUDRo/QALmdtK+rAR/uvFttAb/B
X-Google-Smtp-Source: AGHT+IEEoqSkrVdBo2sNxkzEhLKa+IkjxB5/wea+iqN3AAdUYp+ngznvDLJ0MMRnkvR2DhdNRmqauA==
X-Received: by 2002:a05:6512:31c9:b0:52b:b30e:a775 with SMTP id 2adb3069b0e04-52bb30ea865mr1328523e87.24.1717668700955;
        Thu, 06 Jun 2024 03:11:40 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb4216726sm148695e87.174.2024.06.06.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:11:40 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:11:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/10] net: pcs: xpcs: Convert xpcs_compat to
 dw_xpcs_compat
Message-ID: <dwustofr63k6d76oayale5w6smjjjy43clu2hjphav2i5fro7q@gy65zuplacxx>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-5-fancer.lancer@gmail.com>
 <4a6aa0ba-a5ff-4d28-8ad4-12d461e44381@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6aa0ba-a5ff-4d28-8ad4-12d461e44381@quicinc.com>

Hi Abhishek

On Wed, Jun 05, 2024 at 12:15:54PM -0700, Abhishek Chauhan (ABC) wrote:
> 
> > @@ -482,7 +482,7 @@ static int xpcs_config_aneg_c73(struct dw_xpcs *xpcs,
> >  
> >  static int xpcs_aneg_done_c73(struct dw_xpcs *xpcs,
> >  			      struct phylink_link_state *state,
> > -			      const struct xpcs_compat *compat, u16 an_stat1)
> > +			      const struct dw_xpcs_compat *compat, u16 an_stat1)
> >  {
> >  	int ret;
> >  
> > @@ -607,7 +607,7 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
> >  			 const struct phylink_link_state *state)
> >  {
> >  	__ETHTOOL_DECLARE_LINK_MODE_MASK(xpcs_supported) = { 0, };
> > -	const struct xpcs_compat *compat;
> > +	const struct dw_xpcs_compat *compat;
> >  	struct dw_xpcs *xpcs;
> >  	int i;
> >  
> > @@ -633,7 +633,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
> >  	int i, j;
> >  
> >  	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
> > -		const struct xpcs_compat *compat = &xpcs->desc->compat[i];
> > +		const struct dw_xpcs_compat *compat = &xpcs->desc->compat[i];
> >  
> >  		for (j = 0; j < compat->num_interfaces; j++)
> >  			__set_bit(compat->interface[j], interfaces);
> > @@ -850,7 +850,7 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
> >  int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
> >  		   const unsigned long *advertising, unsigned int neg_mode)
> >  {
> > -	const struct xpcs_compat *compat;
> > +	const struct dw_xpcs_compat *compat;
> >  	int ret;
> >  
> >  	compat = xpcs_find_compat(xpcs->desc, interface);
> > @@ -915,7 +915,7 @@ static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> >  
> >  static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
> >  			      struct phylink_link_state *state,
> > -			      const struct xpcs_compat *compat)
> > +			      const struct dw_xpcs_compat *compat)
> >  {
> >  	bool an_enabled;
> >  	int pcs_stat1;
> > @@ -1115,7 +1115,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
> >  			   struct phylink_link_state *state)
> >  {
> >  	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
> > -	const struct xpcs_compat *compat;
> > +	const struct dw_xpcs_compat *compat;
> >  	int ret;
> >  
> >  	compat = xpcs_find_compat(xpcs->desc, state->interface);
> > @@ -1269,7 +1269,7 @@ static u32 xpcs_get_id(struct dw_xpcs *xpcs)
> >  	return 0xffffffff;
> >  }
> >  
> > -static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> > +static const struct dw_xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> >  	[DW_XPCS_USXGMII] = {
> >  		.supported = xpcs_usxgmii_features,
> >  		.interface = xpcs_usxgmii_interfaces,
> > @@ -1314,7 +1314,7 @@ static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> >  	},
> >  };
> >  
> Serge, Thank you for raising these patches. Minor comments which shows warning on my workspace. 
> 

> WARNING: line length of 82 exceeds 80 columns
> #153: FILE: drivers/net/pcs/pcs-xpcs.c:1272:
> +static const struct dw_xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> 
> WARNING: line length of 85 exceeds 80 columns
> #162: FILE: drivers/net/pcs/pcs-xpcs.c:1317:
> +static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> 
> WARNING: line length of 85 exceeds 80 columns
> #171: FILE: drivers/net/pcs/pcs-xpcs.c:1327:
> +static const struct dw_xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> 

My checkpatch didn't warn about that even with the strict argument
specified.

Note there is just 3 and 6 characters over the preferable limit.
Splitting the lines will make the code less readable (in some extent).

So from that perspective it's ok to exceed 80 characters limit in this
case and not to break the generic kernel coding style convention.
Unless the networking subsystem has a more strict requirement in this
matter.

-Serge(y)

> > -static const struct xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> > +static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> >  	[DW_XPCS_SGMII] = {
> >  		.supported = xpcs_sgmii_features,
> >  		.interface = xpcs_sgmii_interfaces,
> > @@ -1324,7 +1324,7 @@ static const struct xpcs_compat nxp_sja1105_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
> >  	},
> >  };
> >  
> > -static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> > +static const struct dw_xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
> >  	[DW_XPCS_SGMII] = {
> >  		.supported = xpcs_sgmii_features,
> >  		.interface = xpcs_sgmii_interfaces,
> > @@ -1418,7 +1418,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
> >  
> >  static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
> >  {
> > -	const struct xpcs_compat *compat;
> > +	const struct dw_xpcs_compat *compat;
> >  
> >  	compat = xpcs_find_compat(xpcs->desc, interface);
> >  	if (!compat)

