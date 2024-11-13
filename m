Return-Path: <netdev+bounces-144356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF319C6C78
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6809B1F22CE1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4B1FB894;
	Wed, 13 Nov 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBaayW6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF914EC59
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492739; cv=none; b=Z8nPWFQrGrhPBBcvfI3cltZvT9CozAFVLGK0UeEr82/in3+9/oTiWIK/HgZHyZY24LD8KkLGSqMR3l6QqAqJS5Flt+bsXfO7OiOCKq8kWMFJk32BPuW2VRCI9fBtnS6ASpgGOzUpPYKGdwLAdYBQN2V6fG1VLJn8nRin0jUngoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492739; c=relaxed/simple;
	bh=uQ27wrlt7X3vmV1LoqsnGCMOVkuSMQPA54mK4oKMubI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rAaxHdBdYbmJle/QBrEOvCn+GVjQ9zlt4SPINBGDylxus6u5ICtzSsfoIHkoCpnBG+ukgElKAp73kjUCTsWoPUcatgXGg00pGcZsLqw0+Kv+Leq8v6YcvveSH1YbNlYJy8u4SRzi/eb09Yf2BiwoKa7j7aRuwd/hMODBKm7p50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBaayW6Z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf71986b67so51038a12.2
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731492735; x=1732097535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uikttd2797TNyvD045s97c9BUTWXqDISmvC5ewnSDkg=;
        b=TBaayW6Z3rj3Y8Hcfzr5zy0z2hTGIsaqq+jHgF/K3Wl3HggZUUmitLroIopJou+Ki1
         K4zBE3rU1ROtk1EH6Y/rABP9cKwHuw7xVtEiTkQ71HvAFCWrNVoN15f+Uf7pxrgBfJe1
         WOp4X39VqWHkIzgMopneEyh1npY6XJvvT/BmbmK2vMyHVZD5L5Hl+oFWcXNYBxW+/IZq
         wTvwcdNSU+zWcTirKA8p6RX6T/+efWl5CwOSyGnz0IIrXSo5XJpL1TLocYH5hizd3/up
         HoueQACt4z4k6HbH2A9KwD4lZ++aTcToPWV6dcuRoogE6cNxrlvzyX21AWswtG7Mnd0v
         tNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492735; x=1732097535;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uikttd2797TNyvD045s97c9BUTWXqDISmvC5ewnSDkg=;
        b=wD+5Bsp6U8Awm11YivUOrum/5d8eZUd3y/UjvKJezokp2Hlss1HGKrtlOPoNKKevOB
         Xf8VVVYm65jfYr+D+LyIuJ0YDEpmfZfPUAKoPN0f3x2sYYLxoArm4PyTn/oRd2fAxcbv
         T2mKp0iBICLhWN83HXskj/FHuWmI6L5cR1XKyhlmneuaEch8HQK37hvmbr6Q+1eFlnf1
         j3ps0SRGDeSTzweSY47cImlyEBjCeTTeCeUI6CH91CpkO5uOxZWKgzPtz0M8V3K5bM9v
         qNvD6ihku1p+PUjIAo4j0vnCsc/lf5mYeRlS+nbngvbx4wJA1fgJtGshLAPYl6hQd7Sc
         yoWw==
X-Forwarded-Encrypted: i=1; AJvYcCWrvkctoYng6KXIqer74pMwM0+UD3tIXTqsyf48Z8dP2iei9tPfnvSYMS+Vt3MPgQNtRjS0W9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Wf6KTGHngwuzwwgkpCc+RiLURAJeENafg7+FqmsMMMRQeaU+
	ER4Y/GXDSFzYyo71VYg82GXSuzbrMhbIecTNikzvLtcRZcz20UGQ
X-Google-Smtp-Source: AGHT+IF5BwXBZBY0QljLpD92D3DS69OxPrM8D+Q+2UB00X5xptaYfvLODDPRVmowXBbC3EJ0nhEI3A==
X-Received: by 2002:a05:6402:34cf:b0:5ce:d4ff:606 with SMTP id 4fb4d7f45d1cf-5cf0a471a69mr14280413a12.34.1731492735243;
        Wed, 13 Nov 2024 02:12:15 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb7c7dsm7023502a12.50.2024.11.13.02.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:12:14 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <6adbbb73-cc0f-48e4-bae0-825209a0eb05@orange.com>
Date: Wed, 13 Nov 2024 11:12:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Simon Horman <horms@verge.net.au>, Andrew Lunn <andrew@lunn.ch>
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
 <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
 <20241111102632.74573faa@kernel.org>
 <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
 <20241112071822.1a6f3c9a@kernel.org>
 <CAM0EoMkQUqpkGJADfYUupp5zP7vZdd7=4MVo5TTJbWqEYDkq7g@mail.gmail.com>
 <20241112175713.6542a5cf@kernel.org>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <20241112175713.6542a5cf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 02:57, Jakub Kicinski wrote:
> 
>   Co-posting selftests
>   --------------------
> 
>   Selftests should be part of the same series as the code changes.
>   Specifically for fixes both code change and related test should go into
>   the same tree (the tests may lack a Fixes tag, which is expected).
>   Mixing code changes and test changes in a single commit is discouraged.

Hi Jakub,

In accordance to this, I've just posted the test as a separate patch:

 [PATCH net] net: sched: u32: Add test case for systematic hnode IDR leaks



