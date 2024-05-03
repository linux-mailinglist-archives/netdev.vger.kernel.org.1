Return-Path: <netdev+bounces-93292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 877708BAF38
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE84AB20D5B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC3242056;
	Fri,  3 May 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOFxI8Hk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339381BF31
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747630; cv=none; b=sy3yrnTKdcDUJDNcJivDrIo7U34bplE54PDXHQ7pjSK7VXtao82svAMfVQuTMWnjFsfsqG/y0UOdsS0vaam9HKXXxgM9Al1BnGsfT5omPI3Qm4qnyfecWLcbZ8jQ9Y7p09tTzM3yGJJCdQYF/7oEojfbRw2M8KaE91D7SUQTwGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747630; c=relaxed/simple;
	bh=OKQa1ET/dSC2khhq+he2a9BcOSS1/d4fHN6CtY2VDSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDJEKVotdNmPjxwRKJou7tRka6+Z0huCM/dOA0wNO5KQx2MrEfBTBdIGR+hLNgRXdywrBBB5AjcaIM5z8nwLymRMtdnoC54RiqJqUBF6HUXKH/7gqPf9Q8SQ09s4x5duFHgAwI02eKEWLXFSr1Qeehm7uvB4zcijvMwcTGB2LFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOFxI8Hk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so292998e87.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714747627; x=1715352427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNMxFi20gdNs26d1hDPoYYUuIklx6+2jjtZga2sOHuo=;
        b=GOFxI8HkpCNIgoKDuth/r9JL/C1IPmmQKUUVQUhQM1K2mO07dI8r8r6iCQLRJlQO5Z
         aULjFAq+YqEzcyefmK1FKoRefkNZ642XgqXutP/bYtQwy3DoJl3lXGCcyuQ/leA8mKH6
         3HWPrnQB08YEQ377dQNUjGIBGME6sMeB49pdg0s31T+WH3te2wTHa169sOvPUWpeXNgv
         Nk3ZkomBDIGKitcuJHt9MoAA1vev4d+Hnr5gfSRL6iSqzs34W3Ift2H5PiQOgeJpD8DA
         WSA2gBH9biIdP6I1rP6n/4rGhzypH22Q3hpTO6J8F+jTyRTteKLLINOr95GpOkWe0VvW
         UvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714747627; x=1715352427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNMxFi20gdNs26d1hDPoYYUuIklx6+2jjtZga2sOHuo=;
        b=Cyed4Tev5gvS7agakDGY6QWXQCXfpWM3Ny0cWAO39cBEEOUG/CmY274SJLgTaKRc6/
         Xq9AWNNjOrSi/ZVlRAsCVpIBG8rsMXSG7v409JY5aCZr8kFboa8+MpjiZObrEpjH7Mpt
         Hk1TNQy95To54xuCMc7kktSLi7SyWs9ck/Cz0VOY1tdnF/v+5Kx/ugpyfPO4bMl/7ke/
         UbqWCRchib5fEKQNY740JihvFRTI9dXSiXwvjH85zl/eqYmlKlHFVXbPRQXlxZDQhMpN
         ifOPsk2aFZJfrguPk1jcdVR1bChkGdiM+/WbFGkw8QsZlpCh/yq2Pw9gON4g0vXK+3Jk
         uw4A==
X-Forwarded-Encrypted: i=1; AJvYcCXJUxLxJNLQwCEDtW5GayM2XaQNtkDSHZRvOUltcPBLv/y7ICnf4g2Me3fE3ymnA5jbwXrTBlPbGqnYanHAuSkXrfgCJFq+
X-Gm-Message-State: AOJu0YwuHfPaH2ANY2bMScUIlIwjgwf88Az4TSQIEnzfW2nT9nZovjww
	anGgQAc2wa+8XwfVj/SKji6dtxqqm+f6CQrPRiaNpOV1oNfyDHt7
X-Google-Smtp-Source: AGHT+IEEoN/pXIhaSwD7uyn1mV4ESrlBZQBGVzOedjQ2AIWF/wBsdUvZyAJLk1GgzrNDQJIuIL5fNQ==
X-Received: by 2002:ac2:548a:0:b0:51b:4204:2f51 with SMTP id t10-20020ac2548a000000b0051b42042f51mr2162223lfk.8.1714747627021;
        Fri, 03 May 2024 07:47:07 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m4-20020ac24284000000b00513c253696csm552882lfh.187.2024.05.03.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:47:06 -0700 (PDT)
Date: Fri, 3 May 2024 17:47:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop
 useless platform data
Message-ID: <d6swg4bxrzvs7cpn3hd6xfji2cr6vnb7z7fvd4dkuyrufm4el7@qj3minrgctyt>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <37949d69a2b35018dd418f5ee138abf217a82550.1714046812.git.siyanteng@loongson.cn>
 <wpr6eabfksol2sqmvifnivndnixberpoexcoskq5vbknvvadq3@4thpqbkkcyh5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wpr6eabfksol2sqmvifnivndnixberpoexcoskq5vbknvvadq3@4thpqbkkcyh5>

On Fri, May 03, 2024 at 01:55:38PM +0300, Serge Semin wrote:
> On Thu, Apr 25, 2024 at 09:04:35PM +0800, Yanteng Si wrote:
> > The multicast_filter_bins is initialized twice, it should
> > be 256, let's drop the first useless assignment.
> 
> Please drop the second plat_stmmacenet_data::multicast_filter_bins
> init statement and just change the first one to initializing the
> correct value - 256. Thus you'll have
> 1. the multicast and unicast filters size inits done in the same place;
> 2. the in-situ comments preserved (it's not like they're that much
> helpful, but seeing the rest of the lines have a comment above it
> would be nice to have the comment preserved here too);
> 3. dropped the statement closely attached to the return statement
> (in kernel it's a widespread practice to separate the return
> statement with an empty line).
> 
> The unit 1. is the main reason of course.
> 
> A bit more readable commit log would be:
> 

> "The plat_stmmacenet_data::multicast_filter_bins field is twice
> initialized in the loongson_default_data() method. Drop the redundant
> initialization, but for the readability sake keep the filters init
> statements defined in the same place of the method."

[PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop useless platform data

The patch subject is too generic. Just make it:

[PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop duplicated hash-based filter size init

-Serge(y)

> 
> -Serge(y)
> 
> > 
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 9e40c28d453a..19906ea67636 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -15,9 +15,6 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
> >  	plat->has_gmac = 1;
> >  	plat->force_sf_dma_mode = 1;
> >  
> > -	/* Set default value for multicast hash bins */
> > -	plat->multicast_filter_bins = HASH_TABLE_SIZE;
> > -
> >  	/* Set default value for unicast filter entries */
> >  	plat->unicast_filter_entries = 1;
> >  
> > -- 
> > 2.31.4
> > 

