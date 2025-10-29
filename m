Return-Path: <netdev+bounces-234034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB80C1B895
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC86188485A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBB2D592F;
	Wed, 29 Oct 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JthmCSd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F621FECB0
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750039; cv=none; b=nLqR0B/HX3CtqJOVNcHmYBCotX3vrrrioZMyAJHJ7l+z/Ifi0PhQ2p7+BddYArzEIWjPTmT/urHDEuLvYO7Jn3D66rA7z0DmSIwQK+BDq1fTh4eTIf2XtzvZdeN8fazkK5N8HGIpfafEph6BqPpgToFRVv6ph9bWx4bEejYH1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750039; c=relaxed/simple;
	bh=OU7d3RNlZHbgqky5nkbb0GWdBoezrjqgdpc9Zk0XHJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYA9esPGVbZ2qruPTlZbkLXO2ll3vGI82g9ndzKRlbfjqr473eWD2leJy3yVwEN37qh8XbauyMgX15LqrVXxtkp6G7lzkWsrlqO23FkwqVQCpCKKqdSCrIrQL5Lodjo52QpNh3P57s5cwEaXDbyM+2fvy97BgsJkZbrCK1DVTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JthmCSd6; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso23203a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750037; x=1762354837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT40LJu6oxRypwozP+xYaDg978cHnaPf0JK9Yp1+9Sw=;
        b=JthmCSd6T5+D70NIaEGorYjojBmv6HXgTRmj629Er1wzGMXtOr/uwyqRU6re7+3FFr
         lDoeIinP6fEHyA9qJL5nNsUF6wjPTzopnHXfunLN3iAKck4NghqsiEskZG/m8WQr2qT9
         2jhitxKGTOiZSQC76Z0MUJA+T0wju6Gsadj2AdQdPAn1cSfocQTvhSyCOQxPgCMZ+gMN
         JqOBGTDb6OxJM4OL6xsUmqxX9SdG2y7YoyhTmDVGlaXi5a4BhXR9YlGgn+C18HAomAv8
         B/n5VXw17P7sleWEyVVmVY7fOzrZg6Vm3DxH0uTdDkckp7RXbcWparu9+WDXrS61O3oK
         /u0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750037; x=1762354837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT40LJu6oxRypwozP+xYaDg978cHnaPf0JK9Yp1+9Sw=;
        b=WYefOBmLD6QDuoeAD4H4yibspf+YRcF5lHMXh5YYuEOceki1zSl0/5OPuY8dckTACM
         cqBiwrDFtt3h5PYMFiwtckVxtI1DoOHR2xMIYsm2G29ShT5digrVhtjYZdkntoB7S38T
         UNPXgW7tHEKOgHiZIbrkeuoeqXiYvfnueZ/Yhn+o0WFdveg0wBzZy2hZRknZMH2hjtQd
         5yPE6baIFIqWvk5sJ4ub7ZK8/skPtFk80eDofUCNuLNJh0F23gmboAVelhjMGOAo1spG
         4zj4s0GgooIWmmTH01WiFhUllbo+ava7i3JQtaAqvn+ve/1+cEAncLZXyihcK9FbTseQ
         D+yA==
X-Forwarded-Encrypted: i=1; AJvYcCVve+TLL/Yk5soTxbb67Oknm67lHqiqRaVJlsVUW+Pb8KVSHkqYWqDoHnL1VdrZDFDhQCQeSpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFemwSkJXYTg+Fa0gVSyfeak7EIaMJIhjUivF+X2oBEFzwqFK7
	BT3YMRKZVYK0hYXeW3auaScYC6AzreiGQzflfqxEKQnNWSgdsxjE2cXJ
X-Gm-Gg: ASbGncsuuovemkgk5LIlepVGWMWq772ei0akae+202dyN3BAVhZJQq4STRW9RQB+ZMk
	4F0Mr6hO9MaXDbcsSEOK8wb+rNH6NA3PAfAKbUkX7ZRxCWkXviOcA995a1lcExfzyfN+gZkCEuS
	gjbXKMyXzXOUlgLQ8+M6OkTTJH8mUsgk2unqhQLdabp/1DdJCx84W5c4Xv1LMoueSsXREwa8d1Q
	oMo3hv8afWBS5qMgEKU6b10dxct+KLbaS/P8ePtr1aIHbSGe4T6e7QaPkJKOEk0ptxS6TdvPlbt
	7dNYjT3ry4pcsTZw/bCBNBj1NfGII0MSf9YBXW8jXSrPEBrgyNO+zWqfDeXE8sjCvYZJcwGvqQ4
	SQ+IF59Mioa1XCfp3D6Ov6vx8RAtm0x8vzMXSBGykjzvA5hxepTvMetLQYqdbfuCed4ZVvzTnw+
	8yTNsCaM69S6LNR0sZ8XcMNxlEthTh5/sm/jLY8V6AotT7NdcJuCLyee0TVHjrWQEjUDNpltbMz
	Aw=
X-Google-Smtp-Source: AGHT+IHTkNofjDYYCSUvcwrFzhudLkajYIpTI8Ehsx/uXD1wcmUENfXD8vGHxIX5mKjdzFiMwoBquQ==
X-Received: by 2002:a17:90b:3d0b:b0:335:2b15:7f46 with SMTP id 98e67ed59e1d1-3403a2a68dcmr3998093a91.21.1761750036781;
        Wed, 29 Oct 2025 08:00:36 -0700 (PDT)
Received: from [192.168.99.24] (i223-218-244-253.s42.a013.ap.plala.or.jp. [223.218.244.253])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3402a5540absm3353475a91.5.2025.10.29.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:00:36 -0700 (PDT)
Message-ID: <4aa74767-082c-4407-8677-70508eb53a5d@gmail.com>
Date: Thu, 30 Oct 2025 00:00:28 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 netdev@vger.kernel.org, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553930.5396.4492315010562655785.stgit@firesoul>
 <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
 <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <27e74aeb-89f5-4547-8ecc-232570e2644c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/10/29 19:33, Jesper Dangaard Brouer wrote:
> On 28/10/2025 15.56, Toshiaki Makita wrote:
>> On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:
>>> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
>>> about to complete (napi_complete_done), it now also checks if the peer TXQ
>>> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
>>> reschedule itself. This prevents a new race where the producer stops the
>>> queue just as the consumer is finishing its poll, ensuring the wakeup is not missed.
>> ...
>>
>>> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>>>       if (done < budget && napi_complete_done(napi, done)) {
>>>           /* Write rx_notify_masked before reading ptr_ring */
>>>           smp_store_mb(rq->rx_notify_masked, false);
>>> -        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
>>> +        if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
>>> +                 (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>>
>> Not sure if this is necessary.
> 
> How sure are you that this isn't necessary?
> 
>>  From commitlog, your intention seems to be making sure to wake up the queue,
>> but you wake up the queue immediately after this hunk in the same function,
>> so isn't it guaranteed without scheduling another napi?
>>
> 
> The above code catches the case, where the ptr_ring is empty and the
> tx_queue is stopped.  It feels wrong not to reach in this case, but you
> *might* be right that it isn't strictly necessary, because below code
> will also call netif_tx_wake_queue() which *should* have a SKB stored
> that will *indirectly* trigger a restart of the NAPI.

I'm a bit confused.
Wrt (3), what you want is waking up the queue, right?
Or, what you want is actually NAPI reschedule itself?

My understanding was the former (wake up the queue).
If it's correct, (3) seems not necessary because you have already woken up the queue 
in the same function.

First NAPI
  veth_poll()
    // ptr_ring_empty() and queue_stopped()
   __napi_schedule() ... schedule second NAPI
   netif_tx_wake_queue() ... wake up the queue if queue_stopped()

Second NAPI
  veth_poll()
   netif_tx_wake_queue() ... this is what you want,
                             but the queue has been woken up in the first NAPI
                             What's the point?

> I will stare some more at the code to see if I can convince myself that
> we don't have to catch this case.
> 
> Please, also provide "How sure are you that this isn't necessary?"

I could not find the case we need (3) as I explained above.

--
Toshiaki Makita

