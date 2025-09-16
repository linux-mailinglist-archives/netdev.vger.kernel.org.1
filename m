Return-Path: <netdev+bounces-223499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0ECB595BB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D410432251D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4BD2D7DD1;
	Tue, 16 Sep 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w1AydtUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFD2D321A
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024295; cv=none; b=bAYB7mMxObeHqZGG4itHwGtqHmih+BaTgRuUk7oRYDvxq2vC6bMyE2Mqjx6e315r5ApKJVlXKThK2yUHHuDCN5+1KXbp94U+fzXCTRl2TINcntqnOv6k1gbCHSVinFc79vkPjVN1TcpPIlyxzMMxEIEnFypFd6KQsNWWgFSdu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024295; c=relaxed/simple;
	bh=u4CfRJpIWWLJaKotLpqpvXU4ru0ppt8Mlv2oE2Y8GFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv1fzKM1kAeO2gA3eBqen4eMgnSJM6XAA0LadoL1HdvZ/yoYaRJx7LA+DIzMh1B/tX9enQiih/zbr3TAJFaaK7/+IHWonRVKriPb8jvvbwM53x9XxWkG2lQAimN8b1EMcjZOQws2kCqCbkcq/vPlZbya0Br54gf8q/LJlTOIK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w1AydtUN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so24674465e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1758024291; x=1758629091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IFlVJcArwRuB5pQMhIHpC2dkGPMYzDZIC1g0hf8SJZw=;
        b=w1AydtUNiyUjwPMvF1lH5FXjXpB941D1LiWpqxBlc0LcN1HzWVtmIVTq2QDqW29pji
         3lPjdIz/l1dRdOOSBFWBFizIDUp0XtOO2pV2mHXGaozyw1wPilvJtP1TToJT7GBgqvqM
         Ba6R1Czw/TY4o2e5e/W2NYIzqAoHinjBUFJoGpAoaA0xGfbyFFhAhHjdJiES0C8L+Oue
         hwJIN7ts7BqyS3BdIwJK5ttfiGNIMpgKPrqpu7JlNUfGwA72n9tYzDaFHjYfeCOfl7vl
         XWZ31M+ihz44VqQOhP1G3vNqU1DhpxxADkKGOxRFJs8sEaXflhbkZ5AhRWwY+u/+gyZx
         Fnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758024291; x=1758629091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFlVJcArwRuB5pQMhIHpC2dkGPMYzDZIC1g0hf8SJZw=;
        b=hO8bNN16Sqae3mj/mk9s+3E+f5yeoAA2e+YJckPgRODN+c0rCL0u6IrMh78A6LysZu
         vQIrwe3Whs+BXqEjyAIPapaOtNCml/z5WB3P9b91ogx/U88EpaAR6+ZtmCw7ix4dVVu+
         ST8bB0n+HKHJiS536Up4d1M4D60wxlIqdeoixhvNqYzzaFHaPnbgtloiK3OhMlXsb3zP
         jDiE+246Q/79tjaGIglmCNDbb8EyREaYE1JREOHSpm8imXVqMQu0XA9b7di3BAozaL2g
         mxj31E9kiDq2cBDY6K0ZwwVzMdr/qgG8xloDirRbI9OXitWfKbsfrWlmCerE+bvPXbOa
         +nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkXiiQLqOdn3XWUqZoKOMwwA/kZt6m+PTw6ZJhM9lj/sVSMIfkzl6Xgx+MJvi9FGwoTdGcyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxnXFKc2TMacqmR1Gm2Uw0FrBVGVQViy3rkWN9uUpoBR3tCKEh
	zcKP6EFKhuLm/6jCxFQiIrAa/5V1VFVwmJcXXwK3b/igqk4nm9S1Y/bZHwIKmDI4cQA=
X-Gm-Gg: ASbGnctW81wgJYBLNenVtGUVSjGRRTlHhLeBKSgLl4aEtyf7/C7eByQ+vNmxDjVl5P5
	MYCXbBpzmYxRmYR6HnZGIq77/1mLY05+ZlkpV3nAYqf8DFd0GpAyzHC82j1FQLJoVmFBkpo+HG/
	zK5Y1ZXDlqll7YPeYsjpEe3N1B0mOmhlgMOOObcdSlqJvhZNaunVxC9zovSkyFwjl4J442DRjfZ
	YNI9LWZxaqXwLXIdKOuKhNVkCcYx787OfFfGKLmdsSGJTb076FWueKP9CYvQXrd0mkWhfqjLAVf
	WYT1lsHpyVB1XxQ2OnaynBFPmMnATPIo1PuIZ1aWwwUqYC9tZDnz7EGhOEIuODhIPXl7RMEKAls
	nHmlW/Ku/eX27ZJ4X+ctVr2CVkNUm/8N5uyM=
X-Google-Smtp-Source: AGHT+IHXZCY8k+7hYQ8XiEwjomG782rdKfYg9mbN/tQoUYffmZEo0KfqDGcVU/8jZ68nDml+ck/41g==
X-Received: by 2002:a05:600c:1994:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-45f2cf9c56fmr68757235e9.4.1758024291301;
        Tue, 16 Sep 2025 05:04:51 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ec486e6193sm3410937f8f.25.2025.09.16.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:04:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:04:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Mina Almasry <almasrymina@google.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"leitao@debian.org" <leitao@debian.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Vecera, Ivan" <ivecera@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Message-ID: <42xbm6obaa22qoictrgaeqza76iucvasquthb3igqhozrlxmbl@dtspujve2njn>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
 <CAHS8izPU7beTCQ+nKAU=P=i1nF--DcYMcH0wM1OygpvAYi5MiA@mail.gmail.com>
 <SJ2PR11MB8452C5DFFFDDF084EE1C066B9B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR11MB8452C5DFFFDDF084EE1C066B9B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>

Fri, Aug 29, 2025 at 09:05:02AM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Mina Almasry <almasrymina@google.com>
>>Sent: Thursday, August 28, 2025 6:58 PM
>>
>>On Thu, Aug 28, 2025 at 9:50 AM Arkadiusz Kubalewski
>><arkadiusz.kubalewski@intel.com> wrote:
>>> ---
>>>  Documentation/netlink/specs/netdev.yaml     |  61 +++++
>>>  drivers/net/ethernet/intel/ice/Makefile     |   1 +
>>>  drivers/net/ethernet/intel/ice/ice.h        |   5 +
>>>  drivers/net/ethernet/intel/ice/ice_lib.c    |   6 +
>>>  drivers/net/ethernet/intel/ice/ice_main.c   |   6 +
>>>  drivers/net/ethernet/intel/ice/ice_tx_clk.c | 100 +++++++
>>> drivers/net/ethernet/intel/ice/ice_tx_clk.h |  17 ++
>>>  include/linux/netdev_tx_clk.h               |  92 +++++++
>>>  include/linux/netdevice.h                   |   4 +
>>>  include/uapi/linux/netdev.h                 |  18 ++
>>>  net/Kconfig                                 |  21 ++
>>>  net/core/Makefile                           |   1 +
>>>  net/core/netdev-genl-gen.c                  |  37 +++
>>>  net/core/netdev-genl-gen.h                  |   4 +
>>>  net/core/netdev-genl.c                      | 287 ++++++++++++++++++++
>>>  net/core/tx_clk.c                           | 218 +++++++++++++++
>>>  net/core/tx_clk.h                           |  36 +++
>>>  tools/include/uapi/linux/netdev.h           |  18 ++
>>>  18 files changed, 932 insertions(+)
>>
>>Consider breaking up a change of this size in a patch series to make it a
>>bit easier for reviewers, if it makes sense to you.
>>
>>--
>>Thanks,
>>Mina
>
>Yes, will surely do for non-RFC submission.

Please, do it always. You request for comment of something you make hard
to read. Does not make sense to me :/


>
>Thank you!
>Arkadiusz

