Return-Path: <netdev+bounces-129585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BCB984A39
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 19:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED16A1F23FE0
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437E1AB511;
	Tue, 24 Sep 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsyBbn2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7C11CA0
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198333; cv=none; b=qe+8Wempj325cRWRYiqC+mIh49ep9Ush6LmybOOj/c1RmolsnTaPP7Hh5FgCV0iKiluilRi8BVeqC5lgZaBQKYZsL+3v83mLXgKWuzhlHs5k2IQ+Hgejq6HDyl+iFXleTUENSdIsy3/HUSSQkCqOIZPU3Zkahzkq/9pLySVttoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198333; c=relaxed/simple;
	bh=5SfRPYcbs3erJfqYysBZeHkOYT59U/3nOrf3HK9cIeQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V6lyRETZa8fLeWmcr+0Dj+0Eo6YOKE1Cym1EeL+0w3sRJEoRS/TPhOOd+/MCfCmsv/MxljGghHwUEtRDAtc2EJZTJAEwDMN/4BhiLVY1lQzcrNg31LB+3zIXY6GAwyJwgRrcV03dZcVJBkeQPVO9ehEjB6q1Xc+NcJbIINvWV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsyBbn2U; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5356ab89665so6899933e87.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727198330; x=1727803130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w/b9eHZlMlOiHVd8qpnfg+g8POQJ+Z67yQz7kiwdlhs=;
        b=JsyBbn2UMrAfHwN7k2+ozaOjcmJnq5qYmqWGIW0cgKi0onyDtdDjmAOiq8pBGktsLl
         fMgZStu8A5z90/5++SWTC8PspGNIiauvVgQd4j85xX6doZen2AiGvflTmeQqfLQorwkH
         e28J4DEjWid1LuihbOHz0SirXBpJ5JL/2/krXn/DqJcqjkHZnYVd8t9dutTGw1NFF9nw
         y9Doa1DfWTOO03O2gd5S9tjkLHI5FaViH+Hgfh5C/0ciu5JaO8fdlY6vQaG2NdqPvwnk
         yqT3i3bUA1jiP1Agq4zm2jb1t1YXoN3cvHC9avuWydt7tm2rv4tWEZT5VEFi3tq6g6MB
         +VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727198330; x=1727803130;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/b9eHZlMlOiHVd8qpnfg+g8POQJ+Z67yQz7kiwdlhs=;
        b=aCOwp97qpBJU2kineByhghfxK6P3DwCa+rWUWet9LnRU0PPJNFUuXrXUy38FfY3Ias
         VwNe6DsZaLVFrHI+tncLRdw0rfj09M7R8gaSPg1ArwtF7IHypEwmNkI6ZaKGH6Qq6G+m
         nRRQaFT7sFexep56/vkH59Ojz34nQoM+a6TNN7ulhrbJ0E2/RupypG657GN2ITRAp9Nr
         8Coum3gyfYLC9lcpxmfv6aodsaZ3lJVERqOz8M85sHINEQligPguWRF1vtCPWyFGFiz7
         7fZIMbJlLcF/PhNLQNMqLN35kB+fplRtdxx+xIabBKT4osaKeUqFoWQ3+NpCpqun5Sgj
         t7/g==
X-Forwarded-Encrypted: i=1; AJvYcCWYQK81/RMjV/6F8dK3rrQaGtYT4mU4ywDXZW7tr5i45M5Ks2x9US2x8lQdIF63txJJ9840lHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6q35SNzL23OXADguyc9G0AE+pmxlgRgNGnVP26KUHpiiOxnt
	ey2o4kxXD7ReEr70uLIf9kNVnEapeJWzyyOCoCSwdULeNyZf0pA6orPwrQ==
X-Google-Smtp-Source: AGHT+IFWQX22UsqtIW6BJ5djbL41DZEkNYZkOXsoBnvs1c76j7OsMr4Vyn3IYClto8mjjVOKkJzNmg==
X-Received: by 2002:a05:6512:3a84:b0:536:550e:7804 with SMTP id 2adb3069b0e04-536ad161b01mr7512085e87.18.1727198329959;
        Tue, 24 Sep 2024 10:18:49 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930caf2fsm107107266b.116.2024.09.24.10.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 10:18:49 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com>
Date: Tue, 24 Sep 2024 19:18:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Massive hash collisions on FIB
To: Eric Dumazet <edumazet@google.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
 <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2024 16:36, Eric Dumazet wrote:
> 
>> [...] the single FIB
>> hashtable, shared by all netns, lends itself to massive collision if many netns
>> contain the same local address.
> 
> Shocking
>>
>> To solve this, I'd naively inject a few bits of entropy from the netns itself
>> (inode number, middle bits of (struct net *) address, etc.), by XORing them to
>> the hash value. Unless I'm mistaken, the netns is always unambiguous when a FIB
>> decision is made, be it for a packet or for some interface configuration task.
>>
>> Would that be acceptable ?
> 
> Sure, but please use the standard way : net_hash_mix(net)

I see you did the work for the two other hashes (laddr and devindex).
I tried to inject the dispersion the same way as you did, just before the final
scrambling. Is this what you'd do ?


diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..49fea7cf0860 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -347,10 +347,12 @@ static unsigned int fib_info_hashfn_1(int init_val, u8
protocol, u8 scope,
        return val;
 }

-static unsigned int fib_info_hashfn_result(unsigned int val)
+static unsigned int fib_info_hashfn_result(struct net *net, unsigned int val)
 {
        unsigned int mask = (fib_info_hash_size - 1);

+       val ^= net_hash_mix(net);
+
        return (val ^ (val >> 7) ^ (val >> 12)) & mask;
 }

@@ -370,7 +372,7 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
                } endfor_nexthops(fi)
        }

-       return fib_info_hashfn_result(val);
+       return fib_info_hashfn_result(fi->fib_net, val);
 }

 /* no metrics, only nexthop id */
@@ -385,7 +387,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
                                 cfg->fc_protocol, cfg->fc_scope,
                                 (__force u32)cfg->fc_prefsrc,
                                 cfg->fc_priority);
-       hash = fib_info_hashfn_result(hash);
+       hash = fib_info_hashfn_result(net, hash);
        head = &fib_info_hash[hash];

        hlist_for_each_entry(fi, head, fib_hash) {

