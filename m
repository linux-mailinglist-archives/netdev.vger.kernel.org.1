Return-Path: <netdev+bounces-239706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D4C6BB2A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF834FE43
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56EF29DB6E;
	Tue, 18 Nov 2025 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rk/yOqsi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgswrHE2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A527FB0E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500520; cv=none; b=inO/LWWRfcLh7uieLBPWCM+Cu5rl9E7oRKg1BvK/3HKxgreW4kBK9kR8qaNQVRJ1318punpHyj+cabkcizsQ1efoIBiNI/zs9Q4OqWcVJfk1BeXGymPpuAccxlB41CrNZstkXIBbi1fS5vLZ1ojJrbE7h4+RUq2/gP4rc4DUvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500520; c=relaxed/simple;
	bh=gUKAHhJa0ZMQW5AgiINC35nhedPVGun2aD9qelHr/CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIC/YQWUd42UIFK6TPSs0pCGpBN1wTgy4mWkRRVAg5E8gGF4jdJntMJOQZhefrgnGFzRpRSraJtD08hFTdB5qu8wW4BcMooyKs8K4zQjokC4Mf1ErjGveABMC0wCICWD9tcIN9p8KsAb2VKV6KH/sRSuglbKNyjagY/Z3lBUmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rk/yOqsi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgswrHE2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763500517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmHcaFDgCdtGaaDs6Sv5kqpJoxEZlT/+NNgtsu8d3A8=;
	b=Rk/yOqsi8Svy8CLB9nXqd08ysRzefbqgeMK4z9OHEOjqnaNUJEJ7iIohN2eWcRWTpeq9u0
	EVDW4md1Dsc+eBu9ud5BlTuDdPf8GGDu5yyyuLdJ3HB25JlDgMe3WBrD+3j0wBQr1K1DRB
	4Wbmn97BMStCiSUtSk48OlfgzEFzQhA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-v3MhZnUSP0CrZgbaaiXP-A-1; Tue, 18 Nov 2025 16:15:00 -0500
X-MC-Unique: v3MhZnUSP0CrZgbaaiXP-A-1
X-Mimecast-MFC-AGG-ID: v3MhZnUSP0CrZgbaaiXP-A_1763500499
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so19934085e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763500499; x=1764105299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmHcaFDgCdtGaaDs6Sv5kqpJoxEZlT/+NNgtsu8d3A8=;
        b=QgswrHE2JSkEE0DW4NxOXCyesn/Boey+Z/1ee2GucGxV1w7/kybdQvv2P8rJimd5N5
         DWdT5WazGBoqi9cZV0PUOJI21al2YKqpGRtG878GF1GftFmlT6SmIpC8rcY69+bXr0cn
         glZV76WbUpybPQaRm/Ibg1TZMrV3IyeGLLUXMdhKU+PUUyoQjpBrnwLHQ2TjB78YTAVp
         rGY+agcP7XEO06we91pFFpzuQTPY1+ytyMFKb0NFUhY+tEp8NSehRpBTTctEaphKsllv
         0J0LezrxBNE0J2JsR2TV4Ut+KHzCws2Fg2KU+X7ol+DCUrTR/A3zHrhD5EZ63C4+tCAu
         lMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500499; x=1764105299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmHcaFDgCdtGaaDs6Sv5kqpJoxEZlT/+NNgtsu8d3A8=;
        b=wJIPLYtnKX2EvYa2G9bE0MMZErk+8a80LDYrzyEucxELTCdthjOb2maXh26KiqCZ6P
         Dw7VjrYDcGXCbVUwyM6/OKlZj/awWIrqv1Uy/9eOD3Tv3VXckTMRFn/RVbIA/kfTs4oz
         dig213zMcsODMiAzRwrLc7e1sXzmVU6ze1EpViBirhVtFfBHm7j5C0B+apOrzC9EZbHF
         MSF6uAnn1hDWe48AXxY6O9gs9smKG1e4Iei02JaihEsBYdJMJlvGrkKvpGIPdpo+H8/e
         aojcB6v8MeTEMmSsaivkcGF0Wt2PaSnXKeVPi1EMcgXxi3NZ3tCOMdpdkxizxL7ZG7yl
         3N8g==
X-Forwarded-Encrypted: i=1; AJvYcCUqGrogXhW6pdtF2wnrk/yU7rpfMIaw30UBoGNOKkm0TtSUsjracOHn5tI+/5gHxu59qCH9TNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHdaFpM5S7TCav2eGEYrekm6NFfVmUzFFZI+LsXUhoNSIigNU
	X4yF0XQJoOnq9+OObK6+Mz4ANiaUzl6nidWhox0ZR2FmsonDk2pbNQcFCJTG16FzQL1rWsQViei
	J9kH0ULhy/ke5LbosJwt2REVvk5A5mPlx0EyAGxsPu7d+m41QU/Yu2Y5q7A==
X-Gm-Gg: ASbGncut9IAlOWMOH06E6rK3K/3WT+LKXtHzG0n14/TDw9KXfgpQNsKBVp7GIzkNMoc
	dO7PcMz381IoWwIDzlEub+ZcGUHA75UGy8gwitcPgCNXvgbG20mzePUekQB1h7PF9zymI5Y4Lof
	bFvnn4kYhEqG19yRPl0Y4hNeB8Qrn4oBdZiU0Vbi1QqIDYGuAYAnIDTh8fCMKxwFuDYWHbp0Uie
	SRWwgUHHxRKOgmASyjls3Igxjdjrod0uZDTYUvYmmmSn7VYWyMrkIRcwdwVvhmnY4w49XV37UMa
	5rbRlSzxLQFQZQhEn3b0yGJJsNVh24mjIMY/LCZdXzmTKzNKYQm5KsE1dZV8RK55Q8LHuCqSZV+
	pHlwZIb7yzdPC
X-Received: by 2002:a05:600c:2059:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477952dfc54mr91064075e9.12.1763500498965;
        Tue, 18 Nov 2025 13:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLNe1fd/+aXWV0izrtVs31KeHvoSG4W6mfllz/B4RhTNVrzpWEOIipwOrZZHSALNGEB6aSaQ==
X-Received: by 2002:a05:600c:2059:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477952dfc54mr91063975e9.12.1763500498593;
        Tue, 18 Nov 2025 13:14:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9deb126sm24210625e9.9.2025.11.18.13.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 13:14:58 -0800 (PST)
Message-ID: <c1a44dde-376c-4140-8f51-aeac0a49c0da@redhat.com>
Date: Tue, 18 Nov 2025 22:14:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251117132802.2083206-1-edumazet@google.com>
 <20251117132802.2083206-3-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251117132802.2083206-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/17/25 2:28 PM, Eric Dumazet wrote:
> This is a follow up of commit aa251c84636c ("tcp: fix too slow
> tcp_rcvbuf_grow() action") which brought again the issue that I tried
> to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> 
> We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
> ("tcp: increase tcp_rmem[2] to 32 MB")
> 
> Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> force NIC driver to not recycle pages from the page pool, and also
> can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> are usually slower than senders.
> 
> Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1 ms)
> If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshold
> ratio to control sk_rcvbuf inflation.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I gave this series a spin in my test-bed: 2 quite old hosts b2b
connected via 100Gbps links. RTT is < 100us. Doing bulk/iperf3 tcp
transfers, with irq and user-space processes pinned.

The average tput for 30s connections does not change measurably: ~23Gbps
per connection. WRT the receiver buffer, in 30 runs prior to this patch
I see:

min 1901769, max 4322922 avg 2900036

On top of this series:

min 1078047 max 3967327 avg 2465665.

So I do see smaller buffers on average, but I'm not sure I'm hitting the
 reference scenario (notably the lowest value here is considerably
higher than the theoretical minimum rcvwin required to handle the given
B/W).

Should I go for longer (or shorter) connections?

Thanks,

Paolo


