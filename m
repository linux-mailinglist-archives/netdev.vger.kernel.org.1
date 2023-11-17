Return-Path: <netdev+bounces-48776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5B7EF790
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318DF28102E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBF3715F;
	Fri, 17 Nov 2023 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="VzC+640G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDFE6
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 10:51:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso3291961e87.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 10:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700247102; x=1700851902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQGatBI0OkqUrIpIX0xAokAM84axFAYGBfdfsPOdbwQ=;
        b=VzC+640Gqkmtp1CvnLYfrD4xzLHiZRN37M8ENthOc8Cu3tfu4wGytMNlPCvQWbeDLr
         50tnGzFS4JSlPRtHXFndqFp4PbFcYBdRMCWGguvO2y1C4V22hgfcZoB6OHtV5sS5DFRt
         Va8z/AIafXSFapEJBuXJAqmamNeZAb+eh1u2GqL4txgntIyqgsmsYxW6367ip1vxayw2
         gw3YiavtZrDroGKFMWHniN5mM7D8TjvRYY1SBTSo7rg5pSZDNMkM5WkQba04ADuS9nYV
         exRPMoqmWHXLW4KsEBcfhvEcweNV+KVgm/V+ew5rgqksAA7YMdElvS7qM6DHjV5hOl3E
         BrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247102; x=1700851902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQGatBI0OkqUrIpIX0xAokAM84axFAYGBfdfsPOdbwQ=;
        b=HnydGNq9XV+H4Gz4t6z1P2GnCxngyMpqA3/EwXZZddtvDYD5qxoJ4g9FBLqnBkpdu5
         KPR0B8wCDioIylPStKT3m0Vkp9bzi8v0UPvu2z46sU/TnVeQEH5/rsCiL3sf3RBdD/Ua
         MNmTm2wcopavZnfotREdhCZY+ENhagoHEGxZZdjAjAyYARUsuuuuZAB0M/H2m2RwxoZF
         wjGIZNes7yYhVpOXDw8EGM1tBDQwjp40UtVRIxv3Bi+B58IKOr5rHv+hrwh2QMySCjmk
         B1PNkJiFRNN4OabfsvVtsrInrfFQ1Vtsx3qbJoHdXokfhZ6Q6v2pSOuakmx9754Mq1L9
         92BA==
X-Gm-Message-State: AOJu0YymMqmGny26t1Wd7cYKGZHU3Br8yilgAbF0kjvq5T1wnkmGb5eW
	RTKRsOURsPS3GK9ggXsjcYpG6Q==
X-Google-Smtp-Source: AGHT+IGYHEM4uNeVtCO/gTZ0ewg2WFggdTQ5QwKVNBQCQEAOYbFeawwn3Nrq6gMLZoEU7DRPDeB94A==
X-Received: by 2002:ac2:532f:0:b0:509:4d7a:ab05 with SMTP id f15-20020ac2532f000000b005094d7aab05mr324793lfh.11.1700247102044;
        Fri, 17 Nov 2023 10:51:42 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id 26-20020ac2483a000000b004ff973cb14esm308572lft.108.2023.11.17.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:51:41 -0800 (PST)
Date: Fri, 17 Nov 2023 19:51:40 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Wolfram Sang <wsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [net-next 4/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H
 clock setting
Message-ID: <ZVe2PJVQVZgKSFuE@oden.dyn.berto.se>
References: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
 <20231117164332.354443-5-niklas.soderlund+renesas@ragnatech.se>
 <ZVeqSsfBEMsQ+8mP@shikoro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVeqSsfBEMsQ+8mP@shikoro>

Hi Wolfram,

Thanks for your review.

On 2023-11-17 13:00:42 -0500, Wolfram Sang wrote:
> 
> > +#define RCAR_GEN4_PTP_CLOCK_V4H		PTPTIVC_INIT_200MHZ
> 
> Is this easier right now or could it be added together with the TSN
> driver?
> 

I could not make up my mind, I think ether is fine. I opted to put it in 
this series to group all gPTP changes in one series. If you think it's 
better moved to the upcoming TSN series I can move it there.

-- 
Kind Regards,
Niklas Söderlund

