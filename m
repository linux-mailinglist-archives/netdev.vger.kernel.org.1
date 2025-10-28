Return-Path: <netdev+bounces-233545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07FBC154D7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9643AC1F4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC23370E3;
	Tue, 28 Oct 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONDFyyJs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84802E7BAA
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663405; cv=none; b=R8FG0EqqRJumvfwYfatlapnPtHBqNBFAfTNiZBaROBuW3lkqHQFL3dy88v6OXyeM6PEE0GuwePENR5keutAC6RatDim3adBS1JCij8bN42yBocIEJ/T5nSs3bIFyQ3gNAQ+N0LrwnDs+xy4qkl2hHmj/ELwvbI8y5KfARiq3LFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663405; c=relaxed/simple;
	bh=er2CNC3QcaaVpEVwyaeUqrEOigVeBx2t4bAbwKskTPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffVZCaJwPaGuxFnR7aygXbr2h+Y0J6v6hOoGv2A4MheE4jq6Ukkil9G4a2Hnn2P1ljdjWV8+3+i8dR29ZxgOpDjIQyiQUHrGQlLhhHxBk0kZ4ga65jCZ6JyUHgAwVHNSe2BsgjGlWTEWr2Aly11bBqPCKBVKUESvhofk+qxb940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONDFyyJs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781010ff051so4118654b3a.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761663403; x=1762268203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpT9v3vZsTqou8arP0DXWnWYqvjSdGYFzEcyXBF9plY=;
        b=ONDFyyJsOaEgCxKnEb685WtU5/NKT4nAcUb/D0YPlI+K/+oUNTkjaH0LxaE7Ks7h63
         u9N07qCf5xb4zKJbmfrHisaUrUWKRPYP/nN1kBmKqA4kT1KRdzNeySTm72b+wee2CWM1
         RRs2RMn9VONZqzRV/4uN6sTUFT2uWliR2gdIWaPW6KcT0O7sWzvYJvTmiGk8+9097qFD
         VUvVHm+Yy3H7zShT//YAF1jBLgCJnR8xyFc2k9STW84HWx0WEA+gAEG5ymuk9RKq4anl
         kiCYcseaH01j/XTsEJhvKaWKe+7NFLKi0lnJqmms41jJgre2zPK8OXcU6q0nKQH4DrMK
         Ez5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663403; x=1762268203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpT9v3vZsTqou8arP0DXWnWYqvjSdGYFzEcyXBF9plY=;
        b=IFlToustMEdrp5+D3kUTAXK/IQQnHs+d44eEViqGll1wYdMUD5iLyZmRZkr1jVyZuN
         EKbIaisxfwlogbC9vuFDloqYv/vjhOzisRr++6FfP3lhFBmI3qm+xFvwzDyQWWBJbgYC
         2bAVYMhF53aj4zQNWs3n1FOHfoBX6rEDPf2cFIS2MGIzUNovmjopRNTNI1Zoeu1CmFdq
         2dsuOSGaaNAp56Frb0WZSnd0Oqqh0tmfcfUat9OYMSzFrbVi9Z4VEwhsCJfcQsm7nvms
         KY43gYkRpqq5NOQoTluq6OpPdklRNOrE3v0qwTlGRUmb419KEIf7lm62CExFLjczoc90
         eFIg==
X-Forwarded-Encrypted: i=1; AJvYcCXAbMAq1liiYsk2snAxQeXITN/IXEt8HR4IDeAW5OfIJQjZ+44KID0Qh6yzoS5oXLwWL23CQA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcIgX35TzSbI6ftyax5Y2/sPhG4H0VuWxSscSb0G0F1qWUgxH
	6oPypW0Nitku37akQgaG3entrwZ6sET0Dmmv6Gnx0XoTt1PDvwtyWO/V
X-Gm-Gg: ASbGncvy2P1EvnD8QoDedUskq5nWr1NTs+LnF/qtaDEEf8z4kcKJcT37yqA2bima0/j
	+lMgLk90WI7bz/u7Ge2idZLa0vi3ddRITS+oyF5Q+YILrJeuvLnbf8tD/QWDVqoFZDrOtOR+pds
	qRntiet2dOcCvVlBdx8zPFro5P2BwGK2lC1Ff7IV6/y4SJ3L8+rC5HTfwN8miTEjBmT/Jjp3fQO
	m97Y308OuxXQUqn24RQ9jLAAvFBH94HBsdM7B9uBJkbz8m3K5MtKaW/7tKf4YxeFFaS82mEzlfc
	u1wpsT0PiIi9/kdJ9ukxu1RN3RKSjg/cLCruTozJGHXfRkfPbN7k0ucFFRnEjvLtVrCs/GWg2rE
	bM6K3dsF9W6sqMZmLl3ICR5rFLxBSkIhodUfJQ94KkXt4xw3uo0Dmg2J71IwqbHIIHa/6zruR23
	DMLcubwtiLfgDhNeYZEU4ncGbdn7sP7SEgQBoQwjBOCOptEEupDnsz/ASoO03UfxH/8DEPTpMSj
	E2WLMZHMvGwPA==
X-Google-Smtp-Source: AGHT+IGfeHgVIMC0VHfcmG+idW723Hz2pg/WUGXn0Avn4tmBgDpRwGVIyyi/7yWZfkVRxwppZsPQWw==
X-Received: by 2002:a05:6a20:1582:b0:340:d065:c8b3 with SMTP id adf61e73a8af0-344d375663amr6595914637.36.1761663402796;
        Tue, 28 Oct 2025 07:56:42 -0700 (PDT)
Received: from [192.168.99.24] (i223-218-244-253.s42.a013.ap.plala.or.jp. [223.218.244.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a414069164sm12135669b3a.45.2025.10.28.07.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:56:42 -0700 (PDT)
Message-ID: <aacc9c56-bea9-44eb-90fd-726d41b418dd@gmail.com>
Date: Tue, 28 Oct 2025 23:56:38 +0900
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
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <176159553930.5396.4492315010562655785.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/10/28 5:05, Jesper Dangaard Brouer wrote:

> (1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
> are removed. Instead, after stopping the queue, we unconditionally call
> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
> making it solely responsible for re-waking the TXQ.

Maybe another option is to use !ptr_ring_full() instead of ptr_ring_empty()?
I'm not sure which is better. Anyway I'm ok with your approach.

...

> (3) Finally, the NAPI completion check in veth_poll() is updated. If NAPI is
> about to complete (napi_complete_done), it now also checks if the peer TXQ
> is stopped. If the ring is empty but the peer TXQ is stopped, NAPI will
> reschedule itself. This prevents a new race where the producer stops the
> queue just as the consumer is finishing its poll, ensuring the wakeup is not
> missed.
...

> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   	if (done < budget && napi_complete_done(napi, done)) {
>   		/* Write rx_notify_masked before reading ptr_ring */
>   		smp_store_mb(rq->rx_notify_masked, false);
> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {

Not sure if this is necessary.
 From commitlog, your intention seems to be making sure to wake up the queue,
but you wake up the queue immediately after this hunk in the same function,
so isn't it guaranteed without scheduling another napi?

>   			if (napi_schedule_prep(&rq->xdp_napi)) {
>   				WRITE_ONCE(rq->rx_notify_masked, true);
>   				__napi_schedule(&rq->xdp_napi);
> @@ -998,6 +992,13 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   		veth_xdp_flush(rq, &bq);
>   	xdp_clear_return_frame_no_direct();
>   
> +	/* Release backpressure per NAPI poll */
> +	smp_rmb(); /* Paired with netif_tx_stop_queue set_bit */
> +	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
> +		txq_trans_cond_update(peer_txq);
> +		netif_tx_wake_queue(peer_txq);
> +	}
> +
>   	return done;
>   }

--
Toshiaki Makita

