Return-Path: <netdev+bounces-132523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66B99200C
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 19:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245B41F21397
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA60189BA4;
	Sun,  6 Oct 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qOI+hYx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A2184F
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236542; cv=none; b=sCSS+k7dXsKRo5ETd7FCSmtyNOTV0kp16XmZPLeuSFCYO2JTiCjgnQjeeEHh8xH8Qi4fkKodtZhIgBka0iIBTtKicZbJKgYZAIvOOKsiOb54GkKlxoMJEK7L5PXhonWLx3MhQ1olU5vaRSQjFhgIf2irpPbJzledVms0A0FmhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236542; c=relaxed/simple;
	bh=bOvz4pYabcDoZLoEs0sff0Pn88xmVja7LCwJGlH+9Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjqOQDLvxVGNgAXEPJZn/arQgIbhQ92aXRsBzr1JMuTPdlemGQo0L3dl3JtLHteGLOUh2Jdt0ug1f/2yAIgaaqaRfANSPOA+dL8xscDlnohCPzDi/n/zLTAZ+sYoEI+jG+Uw06fbjSuzzh1xs7MwpDQFfS5oKkA4Oy82P95SmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qOI+hYx2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so27715225e9.3
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728236539; x=1728841339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0ZI6ioZn3DighbuW3Kr9aBRm249nRfxXwsbXRgrMZs=;
        b=qOI+hYx2QQsBlGGLUVVFR3hF7nq8GTAtr4p87OkG2zyqvaeJJ+jhY7XEogaWZ+spbe
         hmhPD9cGUcr5kHmtMfTLCTMPRf8y1tbDF79xMuAFgh0EarYyGmN5r9Hf6afc6ZGU1Q8d
         /HCfecavwP+Ddf/6cu0FxLZJoGrvzEq68tGLri32Hs/kfp5dmBtkstE+2/p6LJzSlnQo
         abXHdc2u+bllu6XkhC362VUemxf5L5mu1MaAXWHFK/084N2IWD7uOsQv4uH0r7oRMREq
         27fj/rCPBQKaxy/2StSQHMKpj5RLPpMIkwlx617zz372bmnlaM/6mxrBuHcwxiFq5uJp
         ItcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728236539; x=1728841339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0ZI6ioZn3DighbuW3Kr9aBRm249nRfxXwsbXRgrMZs=;
        b=p/H12Ge5c073qDUoRRhfElEXdxfKvums8pzIzABOdTtjOSLGllxilU83Q3Ak2Ui+d+
         DOB2CEYXahI7Qr/Sat7tDbhCxteqwqfqYAAwEVdN9yf0P8SCCH0UGGEk/lkxOQS6Hd4y
         u2VwCGPl5dobBOGBmJnMo5WLmxgS0TxHi9bmkRKudrOJLVswec68741o2HOtxuPD0ghg
         NZDs+UM4W+ZIWQJUNxDfmqT/OD/kMh/cixu+ThB/bLREicaHzy0l/bSaVYPHRRS1arTC
         xBQcSMByAhNF+9ys4nwGu6YyCIeD2tS1ZGVsaSJL/642zNKrUvSSEVVHy8Aw/LyaCVXN
         kTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4LIl1SgYWaE9PEZ5cbAJeoHE6roSe85vBaQ+D2Iuq8U9ZnCr+yBTNBC1Agzd9EgaWf4HTuYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuxt8v2MhHauZlC7lN5bNPISZth4qgKCMFaFfMr9hp5r+KmsB
	Pl+07lh8iwYJOtUBGhRhPoUi/FFznyojnLj0b4cI7cs0etdnu78PSLleYLaqQlwu0Wf6aujTyGr
	O
X-Google-Smtp-Source: AGHT+IGoaSO8mXybmttjE0PjfTON2+lvsPgF+pKcE8RcfrFzGQ87t9Lb+0HugsiuUxPHtdIqWev3Uw==
X-Received: by 2002:a05:600c:4514:b0:42c:a802:a8b4 with SMTP id 5b1f17b1804b1-42f859b0f48mr64493895e9.0.1728236539304;
        Sun, 06 Oct 2024 10:42:19 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8d133b73sm38697715e9.9.2024.10.06.10.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 10:42:18 -0700 (PDT)
Message-ID: <8f815f67-b0e7-4425-8c0e-6a6449ee35ca@blackwall.org>
Date: Sun, 6 Oct 2024 20:42:17 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Amedeo Baragiola <ingamedeo@gmail.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
 <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
 <CAK_HC7bOe2KhVnDiG4Z3tpkodiCkewEct7r2gXanjGBC8WwFsQ@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAK_HC7bOe2KhVnDiG4Z3tpkodiCkewEct7r2gXanjGBC8WwFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2024 20:24, Amedeo Baragiola wrote:
> I agree, just patch actually changes the behaviour when a BR_FDB_LOCAL
> dst is found and drops the traffic because promisc is *always* set to
> false when a BR_FDB_LOCAL dst is found in br_handle_frame_finish().
> I guess the problem I was trying to solve was that since the
> introduction of the promisc flag we still use brdev->flags &
> IFF_PROMISC in br_pass_frame_up() which is essentially the value of
> promisc (except in the BR_FDB_LOCAL case above) instead of promisc
> itself.
> 
> Amedeo
> 
> 
[snip]

Please don't top post on netdev@. 
The current code works correctly, my question to Pablo was more about if the warn
can still be triggered by adding a BR_FDB_LOCAL fdb and setting bridge
promisc on, then we'll hit that codepath with promisc == false and it's
kind of correct because traffic would've been passed up anyway, but the
promisc flag can be actually set on the device..

Cheers,
 Nik



