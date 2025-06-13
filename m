Return-Path: <netdev+bounces-197338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22557AD82AE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFE3B67F6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B9248F6F;
	Fri, 13 Jun 2025 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="0BC/xyCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6831EB5E5
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793407; cv=none; b=HBkOd280o1QZsvciq5AJskEsXCnCvtrqoyNYiFr72IhtpUPgsQ/N755mcmrOwWVLSwNXipIH7GlB45uvaXCSmXcdyitcGSVynKM/QGsAwFREUTDFCBdDGmGzdsmDfuoLAtoEnKtrZoTTc5rjVXFZjRogPMI3blh3PwUgaFrJ8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793407; c=relaxed/simple;
	bh=sXAT8ctTP9IbddpnEz+KTnjlv2skjI0nKsYoiKEG7SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCxrWA3ZS4KEfBzqO7pTdZu323eUskfElOEFdQlr8IJDdG0373CRAz5cmMgB48Xhpp3MwLw2tcTtV8Cm0t6Yv/K/cmAvnW2VLZPGm6XcFYljEoTOeN+/LPMzepVHWXMahtO0XG31Kaco3NA//NrLqvhbRIQ2CC+/EY5yhZLs7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=0BC/xyCv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d3f72391so22628625e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749793404; x=1750398204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3435kYLA9wFlF8SNOcs53XbvVp6eAORHpcfv9oWBQ8Q=;
        b=0BC/xyCviDYKQOw0K/KSiSbMrZgSDg9PXhEagFMtqfmBdlmbtltCvZd4dKyQ1eu7Uh
         1GGU5g0WXQfLoM9awWF5bV/oFDx4yisdhwh59lAJmz4/Ik5f7aoSUEcNkNr3RVDV/mNR
         DwMBj0sh6krMDargpOQWaJeZ4iyapUaTCPLUjHZxlVSf3V2rdeoSZeL0xegCiR6h3tAl
         jBQ/T7zdpHs//V0hdc/WXaq2A/LifcGEgNL5+oaU8WgQUW/A+6AiKswQY4HIdJ/hbaYb
         AbH8wWtd0Md1iXJuoSp8TDzsX3PNhotpuuhS3i4TpKnO438Zbedd2Yx7yoKyoYzz8CHW
         AWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749793404; x=1750398204;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3435kYLA9wFlF8SNOcs53XbvVp6eAORHpcfv9oWBQ8Q=;
        b=dDh7ZiQXHf+to0BgmZct/XEdFelTYJtBapK8zHiVY4Gsq+fI8yiWQ3TBUFx4cZxgh0
         hA1T3s8cyRTyo4mS+WcOrJ5wOssiE5TLyydqyoQ2VgrJSXcrDlWaZAFY/amW8yqlxOk1
         zfd5Q9X9gOMSquNW9qc00vR4Hyt4CAPMpPIMrIeXuP7AwjAWqoE9aqM25xN4R2KZTE2Y
         xSV4V19rqccOgvMAbMEdkX3kPmIPkvYDBtbJCyoQKdNEnkKpG7rfsgwzV8A4/b2t0cXF
         0WUsOKoZEq0M1GgkuMIH0RqHnmDUKKe8EmvdzLbJVEWvSD1g84IJsUdcUN1cxtvrjSic
         fRPw==
X-Forwarded-Encrypted: i=1; AJvYcCVC54i9rZ2vjJqjfGhOviRJc+odJ+OGjLgoZRM22SKAEXyJwUoobYrgMsFyT/nC62hcaqw8w/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXV+kew98ckejJHRR9ANpobpLTU8e/BO8DFXvwy0VpAE+F0p6E
	npQrV5b+dxUnJkMwFCmUAZnlBefDCRpMvf6qjpj1GsSZtjaGky2lKV0gAY4DyOaC5lg=
X-Gm-Gg: ASbGncsjv1fEKPR2OejYBnubhYXGRl9zK7XdfozxGLJGQ0fNyQvH7iXVSmzOqU3L7aO
	U2XECiAcV06vilRuawn4ex0NNe4d4QweJBrxpS7o9UJp577V3RzKvDJG+s10mV4RO3no17QLaU5
	5Y6h0F+yniY8G/OsSf1A8ul7HJvYZjygvg2e06xE2Fe7f0N7Hm0REafllkBTsduyuuvsT7BiHZ8
	mMNH/sWH3SWB9OHa04p1IFCbvk21FC/zDHrFBPKOqnvqGn835LZnHJVMf6qXrqzA/TOBFNjcxJI
	9MgZKDAs2p1oV2+c3AxM/gvbqeA6grFN3mx/a9kb8Qa6LLnxP3eTSSal3vG3Krg/isc=
X-Google-Smtp-Source: AGHT+IEJFuFqUOnlnGjQjN5WVFL6UkUwlFwEqG0OO5kQPnwz42x6Pj+XObkjiX2VL5pxxrvm4wOE5g==
X-Received: by 2002:a05:600c:45c8:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-45334ad46e0mr14604425e9.9.1749793404493;
        Thu, 12 Jun 2025 22:43:24 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e184724sm40465025e9.39.2025.06.12.22.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:43:24 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:43:20 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
	xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com, rosenp@gmail.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/6] eth: cxgb4: migrate to new RXFH callbacks
Message-ID: <aEu6eGlVvNzZnpk0@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bharat@chelsio.com,
	benve@cisco.com, satishkh@cisco.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com, ecree.xilinx@gmail.com,
	rosenp@gmail.com, imx@lists.linux.dev
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613005409.3544529-3-kuba@kernel.org>

On Thu, Jun 12, 2025 at 05:54:05PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is purely factoring out the handling into a helper.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 105 +++++++++---------
>  1 file changed, 55 insertions(+), 50 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

