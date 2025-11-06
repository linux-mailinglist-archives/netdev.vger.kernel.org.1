Return-Path: <netdev+bounces-236392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9895BC3BA04
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D5F1AA569F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883B3370F0;
	Thu,  6 Nov 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn4OgOPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5D30EF8F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438459; cv=none; b=GraXtgXy4U1h8Efar+ruQSZ7KdcsdNbjuEZupF9bxWEFle+N9Anraa6BKRcve6JMtXIORGuje0wvSidORNHsYz1zU5hC7gcOiILiVaL+x4JzNZVKfG09LklbwqGSNFYUVOWQsThnm1Mf9xqqFnTKnFYoWhDB2AFmRbRu/F5whws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438459; c=relaxed/simple;
	bh=U/AKouqgbPl/F0fdOW+C39rwVERBZcpoopfH3BTj9CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBKU/RjM0KJPtpQup+gWb0FBmWHAbfHCKZm//n8X7sdMJMQJ92nJ7NsC5vyiZifhXuJdWrDn0k8DKTANhx86eObxwl6J5+V5qxMHG7l88mRwdhRN+b0DnAujWtHUJZ/v+CqkYqTOXUvUBBNiWqlAJJBrp4wXCtISB0nq1RZZXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn4OgOPK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aea19fd91cso1352979b3a.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762438456; x=1763043256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72EH5m1JIiQ8HjYUz65OXp9Zw63/fhkgRyPRxQjDTxo=;
        b=Jn4OgOPKRgLDj62PXrzsFsImmbUkS5m2UTPGpXPU9NumtPGQYGnSlTZfIuTvL2XZDe
         ElGv7aMYeFoq9+k+8qZRblvrPdX8ub/6PY3dDDBD7pqxxHOstxjtqosynbGr3yMk5OOE
         n/YC12LEEThowyOiq6CkOoVlPpjqkyL+aIAJEU70G5VTmFb22Zvv3I8sCjRKB9F/Ykcc
         Hqm8cc0ZoxK2coycvPmP1nM8QSNA9F7y7ymqPvBEX/mcruvLprW0inRoEgns1vvuFKoa
         hUZ3Ubd932KKvxNi+bmSw73YKatlfx8cS040R7PQJeyRhPnG3gRhcqpW552a7jzhPSr6
         oWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438456; x=1763043256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72EH5m1JIiQ8HjYUz65OXp9Zw63/fhkgRyPRxQjDTxo=;
        b=SpG+qVy6Gxli3JVU9fZWPyWt/tY7D+89AyUXjTk+3mXWt+tkW31hRl8J4PZJJUFEXi
         vxjUcojEmEc0IFCGSekzSzowPHCNcIy8CErGzXS01MdtcN1huZjrgl7VCxjSG5h3wtBl
         2sbeH2c9Q1lP7J8e9P4Qk3VxHdmkQvaks/u0j2BhZRCs2S0u5pPNsfhLzu7GIjhVIH88
         7NXHpH9/wj91fLOvGDd5ZTxJhatY0R3pGPT3M9PK4Yib9RUY1fUKlbpnFL6yayXfuedb
         I/1wZojJhZ+aRieeHvr7aDGa7/A8cNLwu2H72zzsE3mnPk8cQQPvtA7KvukIRcI8DPkn
         LLAg==
X-Forwarded-Encrypted: i=1; AJvYcCUERRe122XQ8oa62tJOZ0owNAmwcwifoN4EvCEEVSetbNfVDfOXZEBLuyRssXeaNLTB0IXSn/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx9pdd59RgoRIG99N26J9HEooPEZWc94Ns/g4xecpCQ60r25P
	cTEkGDijRYNi0Opfmm5SNSRftQgv8tWjmYvxOylmf9Ytw+ugPTioc3Q2
X-Gm-Gg: ASbGncuNxqIdsHQC7O4dUuoBC9k0BUFRLOalzQDVt06wYCDAtBUlzcW2nKVqbn4T7PI
	Ta/FDJblNTHOzb2Mb8RfuoX0WavGjkmnxoDpIbj0BcaBYml0vtqrityESptF3uTGrKy3wjwslEA
	MEMsq0kRbVv0lLSTGVmsCQTF6/bkBKftIcn4AfZKZX92vdovVKgI+gBmTKY81EfCAQ8cTu/JVSr
	8DI/GW6WDOrULPZ0SYyqJEq44G4zrz7xueQ5LPkuXxkr2PdQY8+O3Cbs3sUzUT0jCTfNMrr2Z1K
	IcnxK5ZdCE/2TaHgL8CjNxKWj5rHVoRcnlsXrbXt92cxgMrS9lnBBJ4R+hBehEcG1WPVDlgqowt
	aD3JuHxGBknHBJFLpiuIQjAf97nDTe/Bj/badgtIN39HRhUbFnW5UvNJC/qgZs3ooS5ICGxRONk
	jeoy/hwVBMBNQMeA5iExE32syauQy6qTAHYIdS1zO7hrOrX7pWG8zxUy4b0xZHJiSTkA4Wqtef
X-Google-Smtp-Source: AGHT+IEo3lyx4SSF6ocI62uHYt7YAX7f4+Hxtin616U9H0IjwoISSx5SOupuX9cHRYryvyjl4G9V4w==
X-Received: by 2002:a05:6a20:9186:b0:341:c4e5:f626 with SMTP id adf61e73a8af0-34f838e271dmr8901776637.7.1762438456066;
        Thu, 06 Nov 2025 06:14:16 -0800 (PST)
Received: from [192.168.99.24] (i218-47-167-230.s42.a013.ap.plala.or.jp. [218.47.167.230])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7af82208befsm2890508b3a.39.2025.11.06.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:14:15 -0800 (PST)
Message-ID: <4abd5327-ccb7-4dbc-9b09-e98069312e2f@gmail.com>
Date: Thu, 6 Nov 2025 23:14:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 2/2] veth: more robust handing of race to avoid txq
 getting stuck
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, makita.toshiaki@lab.ntt.co.jp,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 netdev@vger.kernel.org
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
 <176236369968.30034.1538535221816777531.stgit@firesoul>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <176236369968.30034.1538535221816777531.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/11/06 2:28, Jesper Dangaard Brouer wrote:
> Commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
> reduce TX drops") introduced a race condition that can lead to a permanently
> stalled TXQ. This was observed in production on ARM64 systems (Ampere Altra
> Max).
> 
> The race occurs in veth_xmit(). The producer observes a full ptr_ring and
> stops the queue (netif_tx_stop_queue()). The subsequent conditional logic,
> intended to re-wake the queue if the consumer had just emptied it (if
> (__ptr_ring_empty(...)) netif_tx_wake_queue()), can fail. This leads to a
> "lost wakeup" where the TXQ remains stopped (QUEUE_STATE_DRV_XOFF) and
> traffic halts.
> 
> This failure is caused by an incorrect use of the __ptr_ring_empty() API
> from the producer side. As noted in kernel comments, this check is not
> guaranteed to be correct if a consumer is operating on another CPU. The
> empty test is based on ptr_ring->consumer_head, making it reliable only for
> the consumer. Using this check from the producer side is fundamentally racy.
> 
> This patch fixes the race by adopting the more robust logic from an earlier
> version V4 of the patchset, which always flushed the peer:
> 
> (1) In veth_xmit(), the racy conditional wake-up logic and its memory barrier
> are removed. Instead, after stopping the queue, we unconditionally call
> __veth_xdp_flush(rq). This guarantees that the NAPI consumer is scheduled,
> making it solely responsible for re-waking the TXQ.
>    This handles the race where veth_poll() consumes all packets and completes
> NAPI *before* veth_xmit() on the producer side has called netif_tx_stop_queue.
> The __veth_xdp_flush(rq) will observe rx_notify_masked is false and schedule
> NAPI.
> 
> (2) On the consumer side, the logic for waking the peer TXQ is moved out of
> veth_xdp_rcv() and placed at the end of the veth_poll() function. This
> placement is part of fixing the race, as the netif_tx_queue_stopped() check
> must occur after rx_notify_masked is potentially set to false during NAPI
> completion.
>    This handles the race where veth_poll() consumes all packets, but haven't
> finished (rx_notify_masked is still true). The producer veth_xmit() stops the
> TXQ and __veth_xdp_flush(rq) will observe rx_notify_masked is true, meaning
> not starting NAPI.  Then veth_poll() change rx_notify_masked to false and
> stops NAPI.  Before exiting veth_poll() will observe TXQ is stopped and wake
> it up.
> 
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toshiaki Makita <toshiaki.makita1@gmail.com>


