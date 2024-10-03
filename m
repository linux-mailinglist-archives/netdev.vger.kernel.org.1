Return-Path: <netdev+bounces-131829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989198FAAF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BDC1C224D3
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AD1ABEAB;
	Thu,  3 Oct 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkC2pYo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84B1B85C5
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998767; cv=none; b=BQArKQAqTlFRw3eKEx2/70oyUPPDvFl+mKwkzgvbM74E3tJ2xo35sZ+zhFI2opvo4uONaS+DiYQzjezFjkcw4DEavpT5srASZZydbz1NOA8zEAd/LZzxYy+oOqhjk5CHkEoytnnnkn/ZZqhwJ+ggPixO3vd2lJO1VsIl3vh7DJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998767; c=relaxed/simple;
	bh=3j81f5lui+gXBKhBYm7AUmRCCQ0KxlHLc+jFPWSdEPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjZcgcmalfkrxZXpyUtocSeTD3542LkfBYPRJW3jJb4OhAsam92mVKacQBfgl+Erg3XLhQHiqSWWBCh4e3+Y4Omt4b6hnFBy6ZaJSpmg0h6nAzIECZ8V96xKf48X27NPFZ2ur+vlujbWklIuds/ZQTflRKvgR/NmhpbL8WASBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkC2pYo/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so13226225e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727998764; x=1728603564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXarCceFCTUatiBtIDJC98Arnae4jY2pLkbB45iBfPI=;
        b=ZkC2pYo/Wfp2Eu9VMUYfB1YxCtSl0ZRWSLoFNRKYFTCmxPqRsjkSGtvr2RFjdRa0dp
         nHOABTNBpQIbtPQrun4RXeYbBaJK7IS1peQCtOdUG3SsRHcJhC2CJQn8AbkmfzbcOq/5
         9eHUdWRnIkBmejsbqbaeO6ZUV7zFcQfXJeCAzGkSXLnuXXaAlg+gvDrPZej1+NSMoVu9
         YHE8gO0a6yAEJvhigWeGBB7aAIL7EM2nvEQCKwvswgj/Y8xgl/21jONcfdnsd2iwCVmM
         Z4xd1Ua/WAOLXAwBktY1Y6MxvFwqRJnZ1r5mXKA2bc3JNtsrBvJmFYJ88Phmu6ory9/X
         pF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998764; x=1728603564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXarCceFCTUatiBtIDJC98Arnae4jY2pLkbB45iBfPI=;
        b=sIooi6A0Lcgp6+mEjI9rVlS0lp1s3LeFFazCy9JWSoCxtSyV/3KgvfPn54H2wuFDGr
         F5WLWHmG7kq8bUrdQAEH4znaEGM1Rq7qNiZgE8cidyAZTUalFusHTwMiCewn2Zrd+zL8
         voYFjWEmfNuJSVYMoiAGM947D7m9jazl/H56DRDVQByzV8w3FjFfwYOEG89F3NbYmJhA
         15BMku9VF3pigMwDx3+ZjYm2R5pY66flFMrFUPxGN/t+y6F0O5ZInfKGWtqqBOFrz23C
         MXw84BeYW984d/4wH3itdr/XeqCzJAlMrS9yQd0dw4r58e0Fu3jMrnG/47/DWA4+DbHj
         LjOg==
X-Forwarded-Encrypted: i=1; AJvYcCWymFS4RS8fqiS9npn1s7MlWpIHFB81HN2WhisFysLEw0565bZNL5NlMMDq7iHfLof8laYM5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxepdfe+WDr/bE27z1H+FryGHsGem89D2p/3iFEUgXTA3YZynSb
	mFK4bvfgG8HSVJwhNnABk4FcUVgNkCyAPhPP9SHYFPOAd78y7Rgi
X-Google-Smtp-Source: AGHT+IHog/Fp7a60sdaRCV3cSF39t9PYQrfZY21r78vA2oppUu9fGCT3obyxlMYmGdrOhQZk7Vt6Pw==
X-Received: by 2002:a05:600c:b8d:b0:42f:7639:d88d with SMTP id 5b1f17b1804b1-42f85af56f9mr2968605e9.35.1727998763493;
        Thu, 03 Oct 2024 16:39:23 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20589sm1272655e9.20.2024.10.03.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:39:22 -0700 (PDT)
Date: Fri, 4 Oct 2024 02:39:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <ln7fzih6nobyqhzi46juwxg24btm3usgkjsrljaxn5jeywxxjo@tlu46r6nhprs>
References: <ZvwdKIp3oYSenGdH@shell.armlinux.org.uk>
 <E1svfMA-005ZI3-Va@rmk-PC.armlinux.org.uk>
 <fp2h6mc2346egjtcshek4jvykzklu55cbzly3sj3zxhy6sfblj@waakp6lr6u5t>
 <ZvxxJWCTD4PgoMwb@shell.armlinux.org.uk>
 <68bc05c2-6904-4d33-866f-c828dde43dff@lunn.ch>
 <pm7v7x2ttdkjygakcjjbjae764ezagf4jujn26xnk7driykbu3@hfh4lwpfuowk>
 <84c6ed98-a11a-42bf-96c0-9b1e52055d3f@lunn.ch>
 <zghybnunit6o3wq3kpb237onag2lycilwg5abl5elxxkke4myq@c72lnzkozeun>
 <acdc1443-15ca-4a35-aee0-ddf760136efa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdc1443-15ca-4a35-aee0-ddf760136efa@lunn.ch>

On Thu, Oct 03, 2024 at 02:04:36AM GMT, Andrew Lunn wrote:
> > Anyway the Russell' patch set in general looks good to me. I have no
> > more comments other than regarding the soft-reset change I described in
> > my previous message.
> 
> Sorry, i've not been keeping track. Have you sent reviewed-by: and
> Tested-by: for them?

I have reviewed the series twice on the RFC and v1 stages. But I
haven't sent the Rb-tag for the series, just the standard phrase
above. I was and still am going to test it out today, when I get to
reach my hardware treasury (alas, I couldn't do that earlier this week
due to my time-table).

Regarding the tags, sorry for not explicitly submitting them. I was
going to send them after testing the series out. Seeing the patch set
has already been merged in it won't much of importance to do that now
though, but I'll send at least Tb-tag anyway after the testing.

-Serge(y)

> 
> 	Andrew

