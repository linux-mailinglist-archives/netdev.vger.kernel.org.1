Return-Path: <netdev+bounces-80544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702887FBC6
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DC71C22057
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3B7E111;
	Tue, 19 Mar 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TmPDWK5u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACC7E101
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843999; cv=none; b=cw9fXLE7vBENyEObir0AK//EpFdMZvFXZiYLyaDEYLnr/Z2fTI1GIPD4/Yq0PciAVLX5pBBF2twnVGwx3LTLl5GJ3weovxRAm/3FyWmAXRfW7AbCPoEMTkIFxVDZVBaXCX5kPUGelxIRDDTtrbBbkFiYXk3Zhn0ko86kdYnADqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843999; c=relaxed/simple;
	bh=KnD+vRO//djJswqeZEr1YaSQjYy0/EtwXfN/5kheUCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSxaK5sbBnfXBmD2Arx68MKU0BAgIripHUcJ3g4FrDdY05Ar7NqAT5aESgzQHLFHfKNHfaoJb3LOTPVNghCh6WtaWikWZVrsecBgerBEBEeIlhLtcpKx+KtLrzzE0y7QYM0oVL3592+f92lQdHZM0cRcJCM/Daecllw2iuEoY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TmPDWK5u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413f76fcf41so39991435e9.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843996; x=1711448796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/kY3ymT6Kq+NxxS6XmsIb0q0NFxAdsmufViWTvlYek=;
        b=TmPDWK5u7bwVWGpEtr4Rmq9FZZEiaCgG9QeBvSQ/zpP/aiQ6TXkFm4ktETWtKPZ+VI
         pqv5RUtOnUt69C+6UKT6a81W10CeT+aIKqVW+9ei6O6OkpeXrSqAMX5WutYOECezPZvl
         mJomE++giVcY+iamV8pePUz9nsWAWODBUAoquqXj7QysiUvtHoaTdZifI/LbkPHjwrd9
         Ps+7+JmiKjyTDjQ8nwdaiIEVbY+EBBKMSmw2/F1h7Fv0+sOwyAF2BfD7PQNhQ/MFcMJQ
         vni0aZKzK3JjCx2ncNRRn03052Q8YodzXxoN+OBMqD68nL5zRo3RLat0gZOIv4BrpQfR
         cylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843996; x=1711448796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/kY3ymT6Kq+NxxS6XmsIb0q0NFxAdsmufViWTvlYek=;
        b=E7iECvtSsNZrCNdirpLZM7Io46s/tW+DkEv0oJa1Ho1WaSafCMIfhYT3gL1cf2uq/p
         ebPZqQgY9XsopKX+kfuZJ62QV+1poY7y3xevIcSOT/D1Va+yj9+p0f76iEzLoFlCgKqG
         VCnRiwA0g+V1Cn6ALVgxnVH+Fz6RXxvg5iKPy3KW88Yzokr8w/Dv1Bq1NboBxETeC93O
         lFPoBAHzdHzwsOK+bq9qPB6LZD4czDRbNgzWWHr9MYhFCEqOACT/vlnIu06Jkh4gH1ai
         4gKaDkX51xqJ7S10Z8gsqI1KxMss6xnSEU9sX+RTbo7NptizJ4+hDijkRvasrMIkMT1P
         eK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtgrYFOA+/UMoRjORwHr+pVqfFphYtYVJgCM3l/Q/3DesBqoE2EslqmQf7eA/kYWeA+ukjVefqv40PE6CXwyKqR5vfspVx
X-Gm-Message-State: AOJu0Yyb+4fNKBluIQ10YwRB7FlZ3X5fUxOmk1CG3Ovw8w3EqhRBwHLx
	W5cvXYWkRO+OTmQ+rxXjMd56HUdJietF+xFTM0+4wLSIi5rZXUkHy8KFUiahb+I=
X-Google-Smtp-Source: AGHT+IHIjYnO7QiQBrJZrPf4r2Een7JWME1nf9x6uC1++VadonVxo6i1A8GJYvEMNu8cP8iehDdUUg==
X-Received: by 2002:a05:600c:46c9:b0:414:64c8:5523 with SMTP id q9-20020a05600c46c900b0041464c85523mr1057390wmo.3.1710843996416;
        Tue, 19 Mar 2024 03:26:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033e7eba040dsm12133681wrp.97.2024.03.19.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:26:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:26:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <ZfloWPxw_iFJvLDs@nanopsycho>
References: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

Mon, Mar 18, 2024 at 06:32:08PM CET, lnimi@hotmail.com wrote:
>From: Min Li <min.li.xe@renesas.com>
>
>The main porpose of this series is [PATCH 1/5], which is to support read/write
>to the whole 32-bit address space. Other changes are increamental since
>[PATCH 1/5].

net-next is closed, send again next week.

> 
>
>Min Li (5):
>  ptp: clockmatrix: support 32-bit address space
>  ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
>  ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
>  ptp: clockmatrix: Fix caps.max_adj to reflect
>    DPLL_MAX_FREQ_OFFSET[MAX_FFO]
>  ptp: clockmatrix: move register and firmware related definition to
>    idt8a340_reg.h
>
> drivers/ptp/ptp_clockmatrix.c    | 120 ++++--
> drivers/ptp/ptp_clockmatrix.h    |  66 +--
> include/linux/mfd/idt8a340_reg.h | 664 ++++++++++++++++++-------------
> 3 files changed, 482 insertions(+), 368 deletions(-)
>
>-- 
>2.39.2
>
>

