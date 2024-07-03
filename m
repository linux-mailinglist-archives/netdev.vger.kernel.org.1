Return-Path: <netdev+bounces-108989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C57A92670E
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AD6B23320
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC31849CF;
	Wed,  3 Jul 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn4s+aY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22A1849C4
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027578; cv=none; b=abMK2gOf6cctwl7RT5e70gG2QRmL3OFhrdo20cdCiuzjO4LZ7IEcXqXVVAuK1l6GhoLAYP92piDmvWDYCowoD05TmeW62dqg+rUVz2R8NEEoQEya/p/8HtUzBk/VfdSvKAH7ckJkDfLQ+uVSvB1cAFQ1haI59zk8VqlLxZasnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027578; c=relaxed/simple;
	bh=UfGsnDSZM90be584DX8Ic9VjOARHXIFEmQDdgTLnk0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC4WrJw8GCrldrUs1GCQ9lC+ZSy1k/LPVf9D0fD6xav5JOfeoRTA8z7DNDKTKnAm3JFnQg96PlL/5m+gB0dtQuGhd7AAwvcyqH2xKGGNn1YvkWzzpAQ0pRHYFI5FF3tlkBKE8JiuZXsIc9x2lbe+M2zDV+OlWJumfcV3riaSs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn4s+aY2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so61078341fa.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720027574; x=1720632374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awH1SWyz5m9EzuY1Ye/qOXDti6nfQfIz3/fc3+URhls=;
        b=Mn4s+aY2Ckt+K0zREN6EMPgzvLi0VQJMKF7jqo3Z5Mmin7d5WDz1dotauKrxzw8clV
         WEqMPxL7cwxTUxIJgYekTaWi/x9J0HCfET4Yb2D3yLFLWiO/JAZ/VLNl6/wIkvaeBuUe
         V6k3+jhhNC7SZkg8OtkscPt4/UKla7NfsQ9oNUvA2cS/I+35bc6iSZoL2plHSaXNCcmr
         DbY2fH64LRq8XSVZmhJXLavcMFzj0VZDWWi3rM88uoWD17LBwhSon6NeqGqVSUXy2VbL
         tpsaJZ6BkTxdyxe3yIjsQUU++tFLPw88mN6bLOfgW0hCp4EEjimNEaueycxmrJOvZmMs
         yKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027574; x=1720632374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awH1SWyz5m9EzuY1Ye/qOXDti6nfQfIz3/fc3+URhls=;
        b=CzF3VsqcATb16qGyVStrXEmw1OghddhLL1mVJIDpUcbuRLqQHhchrPEgVUMmelr8rj
         Fw8ypsCpIEzzbK8faobtuuGED5iu6//4ySbKrK0cq1tDiUeTbgKkOsZxA5O7OHDn6Oot
         Ph7GwYpjGaZL4j4GcWTxKLy+LRKVN08bMJQ3oDXPYB8aN7P31IEyu4RIURx8JJ1jM2RG
         SuFWbPjqOzivPCC5SEEGXB6e1giD8pZTWHxpeByU6plOfc5aT7j2hi8uFEuYhyKsLuZL
         rBofhiOjM7xL7/mShSyWV/6LiqLtcibHGmII5lxKjlCwA4IRiax37oVdKr8mnjSPmUqa
         K0jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBM13VJQEL89StlG3R9o4K0cRaTgkWIjl3CTfhvsoa+oJC6ZUiOncE0OrRjCkgpqE4UCsuKXY8O1yM85tInLeoqUUVRzjq
X-Gm-Message-State: AOJu0YwsFVUyq6QHpRFNaMgRG9dtkflSwbDh35AeghD3puxa1sFDpLvX
	wgtpIHAnDw4BFzmK7ZqOGVmrPenT1sZSNsuUeTFTxvmYiyFKLk06
X-Google-Smtp-Source: AGHT+IEfGmX259PPpjYgqeqmNjrrAOvOamyTRhyLKlXX3E3wq1o2xz6+Y6bmL/+OSPdFa1d/FzKziA==
X-Received: by 2002:a2e:8e81:0:b0:2ee:8644:8253 with SMTP id 38308e7fff4ca-2ee864484e6mr13351641fa.22.1720027574343;
        Wed, 03 Jul 2024 10:26:14 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5168cf1fsm20223341fa.116.2024.07.03.10.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:26:13 -0700 (PDT)
Date: Wed, 3 Jul 2024 20:26:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Halaney <ahalaney@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Message-ID: <4sseitixno7uegbpufcqbutgqjywkmqi7tc3xoy5g6kr75be2w@zm3symrbpzcm>
References: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
 <c26867af-6f8c-412a-bdd4-5ac9cc6a721c@lunn.ch>
 <xgqybykasoilqq2dufnffnlrqhph2w2tb7f3s4lnmh3urbx4jd@2e7nl2qkxtrb>
 <ZoVuVDhCDxr/wKKE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVuVDhCDxr/wKKE@shell.armlinux.org.uk>

On Wed, Jul 03, 2024 at 04:29:24PM +0100, Russell King (Oracle) wrote:
> On Wed, Jul 03, 2024 at 06:07:54PM +0300, Serge Semin wrote:
> > On Wed, Jul 03, 2024 at 04:06:54PM +0200, Andrew Lunn wrote:
> > > On Wed, Jul 03, 2024 at 01:24:40PM +0100, Russell King (Oracle) wrote:
> > > > dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> > > > register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> > > > rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.
> > > 
> > > This appears to be the only use of
> > > GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK. Maybe it should be removed after
> > > this change?
> > 
> > There is a PCS-refactoring work initiated by Russell, which besides of
> > other things may eventually imply dropping this macro:
> > https://lore.kernel.org/netdev/20240624132802.14238-6-fancer.lancer@gmail.com/
> > So unless it is strongly required I guess there is no much need in
> > respinning this patch or implementing additional one for now.
> 
> Nevertheless, a respin is worth doing with Andrew's suggested change
> because this patch will impact the refactoring work even without that
> change. We might as well have a complete patch for this change.
> 
> (Besides, I've already incorporated Andrew's feedback!)

Ok. I just noted that that the respinning wasn't required due to the
same change implied by another patchset. But since you have already
implemented the change to make the patch more complete, then it's even
better than waiting for our STMMAC PCS discussions over.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

