Return-Path: <netdev+bounces-198778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E919BADDC46
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA886402411
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9628AAEE;
	Tue, 17 Jun 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kDYkmXbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999ED2EF9AB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188468; cv=none; b=Qh23AWzs+5xnawN2LWafV2d6MpUI194Vvrf1r/vLJjq3IR1hGafWUF3uPEisgg0m/2MOPvU7kXR1tdL1ZOwH8sStgrLL6J2fSWrZf4Zfbgvm/mP0wDjA2qEBEUKDwrVhjdGJL/ZMEINHew/fn9vmiZOh7+vjemfeGV9luleNU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188468; c=relaxed/simple;
	bh=sBoSrzzJ9TQel0ZEmeUvsOG7TaXdYVw2Mk2ffMY5Cjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGp5QNGDjDAT021kFNpCYmLju6aC5NL6co4jdUvPOl4gjjBdjBWYAqZPh1hipwSlRdPkTmplm4anCZFK1sLzNDK/0VlMTuEWaxrzGx6+QcLUFKMg+XOc/wTF32ckuw2fXOIs8zXb4eWwg3cT2m7qVJejCDdM7pC727i83uRzLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kDYkmXbN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so36757635e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188465; x=1750793265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9CZ4k/E2o1410l7yviN39nKLTKJN0Lc1UNjbJBxGm4=;
        b=kDYkmXbNWiG3Gwi1UhQMznwBsc2XZKXBI9/VagNSeJ2T6j8NuCg2qx93BeovO8vDT6
         v6n0caEvhuNxqh56MPLvklMYcQ9NmTJByr1jfjtOyRlJ6hKgtMBL8Cp5RhQ18GskdoHk
         0V8jLrSli5ncayXlJP4+TgzZGHdkM5cqcYhI8RFPPfyx55kjJXH4flXtvvmKfz2NqP0k
         vpi5zO42s48+sa6c/ICtV744tLEoge6+vXfk3W6NEpLdmlOAQHJAhZmcvv9UvMKeOjle
         mRiTUF2X1kIJ/6tbqDSQw0CW3BPRdFCHMCVXZ3xnlwAcY1zylusSsmY7qBjpp/n0fgQx
         0GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188465; x=1750793265;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9CZ4k/E2o1410l7yviN39nKLTKJN0Lc1UNjbJBxGm4=;
        b=MDyN8jmpEdKONleAub2yrciCiMKVbmMLNIOJTE/2/OLSoEvERPyp+knS0QwlB9hwD9
         rG9+Qh+CaViCmwrTyKumjtwHlSqANTd9LNRi74fjwBm8T/VDBD394Xq27dhN3xnbhKh7
         826+aAryQJf3Ge1WPJRH0GMVvxvyJ1I8gQXACmSvXj3NZkZ9/gQCfsraqDdmrihSp1C1
         tn9Eee4cuSPYTFJm7qVClnyhVOVcBATJ/AUDivYJ/9BH1pFwgspvTs+WLEgHlsUAV4O5
         bP4WIPoJKOlWcciUlXqT962Vib9LASMamuYP3lKYd5f79sam8mLBXmD9ctccCznMukdk
         F3dA==
X-Forwarded-Encrypted: i=1; AJvYcCVjP/GMpVDxl1r37mCtKRypoGh9gNDrTeyNO/0VlFY79JHV4/kdF/5Aw4pZ/oDSvCdzPKJz2D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZgPsulSqKMrgzSVehQgKJCFUpSS74rYkkkE0YTTmr+wUEao5
	zkziLttioNTSgg/ZZ+TQ2SCh7tE+Jp1uWV+iMHLm22Z5vtpfMgB0Vv4DgxsCrVCpr0I=
X-Gm-Gg: ASbGncsbkPwLQIsNywM4n6/yGMfM+aW0bWwhE9P1QA2mVFupqyphFrqngglD+kCEozB
	ahJM5MArdncv/axxTWp2QIsvpSkgY1Z+Y2MaGGZj7ONVP+qBEi2+eB2HRELq+34YqITuihCOym5
	/r2qh0hDWzRXlwbHMqKMlEkKML/X0SHQB+6t+DOkMGHzN4+3tz4dtG9tGMzNi21X8mjstMtJU62
	W+4j/Cw9iXkzeEpcQPaN01n2CJ9f4DdeBP0c/rpo+Y45JgU05244I5q/t3jh1Y7v6OQ8mbkj90R
	L1q7pEabycUu3TvFLdb5v0UmEDPrh/Ux4XbHnrvxr4E6m9iAxOHrmG14pi33uJ+0qIw=
X-Google-Smtp-Source: AGHT+IEUPTiWy+qBTZJO/XkS0HvEyV0uXmvCfrAxikCn3df+VhwLFA0luE9q7yUvoHBtT4NEgMugEA==
X-Received: by 2002:a05:6000:4024:b0:3a4:fc52:f5d4 with SMTP id ffacd0b85a97d-3a572e58f3bmr11571455f8f.47.1750188464834;
        Tue, 17 Jun 2025 12:27:44 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a589092d1asm2600843f8f.24.2025.06.17.12.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:27:44 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:27:40 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	madalin.bucur@nxp.com, ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com, bh74.an@samsung.com
Subject: Re: [PATCH net-next 4/5] eth: dpaa2: migrate to new RXFH callbacks
Message-ID: <aFHBrCZQqAyY_-aT@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com, marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com
References: <20250617014848.436741-1-kuba@kernel.org>
 <20250617014848.436741-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617014848.436741-5-kuba@kernel.org>

On Mon, Jun 16, 2025 at 06:48:47PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 36 ++++++++++++-------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

