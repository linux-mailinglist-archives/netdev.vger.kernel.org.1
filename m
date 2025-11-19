Return-Path: <netdev+bounces-239888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE4C6DA11
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E754F4E367C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D633436F;
	Wed, 19 Nov 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZVZ6x1C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS/i2tkl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4633375E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543121; cv=none; b=pVV+THZEjUQ3mS0xpww1VBShExgO+yVMVW8TsotPSb0PmRb7aJ/qpNLKIRS2HyQYjHsVBDaZxYq46WRU0E9M7Qu2Rt4n4QzGYNz02PRUu5Q0q8T0q0LVA0tB0ASYLFfG7ihHOz+mst1SNjBOpkjiSjV9/jonLhjkYcHSGwE9fQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543121; c=relaxed/simple;
	bh=vUdRmeRkR1Sic0vFERO+c65P4WSSzlgLf+kR0Zto560=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poulPRUosojISqNLvWlZQeC8tXfZDi85TnO26Qu9qFe68TQqPTEHfqyaCd0Q21uzw5AphM5Rkc012dappIjayk1g/FW+EnaIr0JhCXe/0Qky3vP7zsD9yR8pKJ/8SQGKFu6J3IFsgEFuYLtiTQrtnMdnMqD3jf5U7tExRzRblXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZVZ6x1C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AS/i2tkl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763543117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=st/lacsc6niuYoE7DSoWjNBoFYdmnwECFBXbRm0DT6k=;
	b=XZVZ6x1CR8ebcwu8TzXplh8aEm1AHErmPQIR/1rUVAJny+gBmGwWUwG9HyQ06IMWD6BYMW
	ZOZGgOxAayh2fT3pZD/8yuyBUsgw1j4YGxGX2mDNwI3hIVl510sw3dVz/6VI3OJWs7Xgx3
	8NElY8uL/6ihr7SHPFw2tDDCZNTD2mU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-o70UreYpO3GuqzIK2JA5OQ-1; Wed, 19 Nov 2025 04:05:16 -0500
X-MC-Unique: o70UreYpO3GuqzIK2JA5OQ-1
X-Mimecast-MFC-AGG-ID: o70UreYpO3GuqzIK2JA5OQ_1763543115
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so2956926f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763543115; x=1764147915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=st/lacsc6niuYoE7DSoWjNBoFYdmnwECFBXbRm0DT6k=;
        b=AS/i2tklNFANFpI5oB0uVzX+Ygx6SJQNEKFszTRVf9IdgCXV9o6tjVUw47XTZKkTRz
         zAEb9wUPpdJ8XF5Zjh8np0nHeWZByUlaSM2CvHICo2C9pwumIlLDUHmxJfa6BnzPStcy
         sqnq/1oW+uBLSwD0/+kFHb/hlLrPWti7UwbfofiMVOuGxXvO7xPug5frU7v2QF8Ju0+R
         WaRmCQxqU7pWXuhBW7/ZpheCQ7pHvODO6V1mRdoPQNAtUSBOLSDN1PTgQ0d4LNmTWncL
         Yf6oiYBW6VXL/Qz0vItMA0TBV/2PBBcD+ZfgY1Xbpj55wa1lAm70L6wV9TZFx+Iqgjx4
         dpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543115; x=1764147915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st/lacsc6niuYoE7DSoWjNBoFYdmnwECFBXbRm0DT6k=;
        b=TONcR1F4Rei/dvOApUWmyJRxfYyCoQZQOARxAFxhhvT+whefwEloUlPRBHV0Aq4QQI
         V7tE17xjoVgrueUP3yrXfWr6tOoIjow4i6sBea5Eb7yWXTv/TnxO6iNnoJvfDgohqDpB
         VJxtQ5JGqzdFUlYclma1rmEOUDpS0CDmn0F5B3spR/bj0ImDeeFgQAtoVUsd9Zm1/gUt
         VnRhe8rdHXIiBmKT9M6yDQqDrF3l05eflbRkd1WJ6O5EvaR2qkPqzg5GJ+2IaDZyHNmG
         m6UsBdbdzS7RtqDRP7WPCANg5m0HZkknK7G61a18aXsSAiXavmSjFoJKuKEK9u2JPjgA
         yqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/3Mv+kD42V2GubLvnrAocmW1+yRhnqvTGB9lzeB1oV4FVj7jnuyc14qt3lcvAorkwLShncZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAkUuViU/yE5bwxpizFA+7fx9z0DRq+CBxKKvrp3wRKMk0yXb2
	e3kMTHDJiub18fuHYk+lCTHn4q1+wWkF4uhYVwZg8RBbso+p0qSw8oyTdXV+MuW2zDdvh2OfQP6
	vTXpcsZL9K+XNV5JO9nidbcxuCMGw0T8F7llzcQqmWPtM7w6fTRFgA04i/A==
X-Gm-Gg: ASbGncvUXXtgm/JnF8VzUxt7JQRZgos4j+K7S6aVOyMyY9j2OtkZFUtUuJDBwSR1qUT
	zfPx0v2F8n4LgejbpVhwwj+LtUiNFj1Htp4gkRVmwMSwlLhyhPy9B/uS03B8gCCZAbXn4yzttlt
	I2TOSVGMf4EwqMq1yWF2rgc3UmrPh3t/uBig+hNBVBWSVrhMk5fOD+jDWjd6+eqBfkKXPKMuWla
	fMpIUYHSYtBfVisiabZWRNR7WqLBa2BuKG6wI0FKTigrYwIFf+8w6sjtn5VsmPRX9rw+OIOzqio
	kNuuPEBeJYu9++BDP5F/xDueR1P4nZ6oLiqKXj6bHRW6HJd9kugtfIwfUFRsxxfvh/cb+AH6h/L
	6qRj4CY8bGqRN
X-Received: by 2002:a05:6000:26d3:b0:429:d3c9:b889 with SMTP id ffacd0b85a97d-42b5935df5fmr19818670f8f.1.1763543114970;
        Wed, 19 Nov 2025 01:05:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo7beDDn9H8iHhYeh4PJ0bWu4CG/GA7G+HhTHawitTKldTiJcNqPdi7LYaI5n8LXHKtwGC8A==
X-Received: by 2002:a05:6000:26d3:b0:429:d3c9:b889 with SMTP id ffacd0b85a97d-42b5935df5fmr19818625f8f.1.1763543114508;
        Wed, 19 Nov 2025 01:05:14 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm36875660f8f.35.2025.11.19.01.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 01:05:14 -0800 (PST)
Message-ID: <46dee7e9-121d-42c5-9658-c6b1a5fe4363@redhat.com>
Date: Wed, 19 Nov 2025 10:05:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] tcp: add net.ipv4.tcp_rcvbuf_low_rtt
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Rick Jones <jonesrick@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251119084813.3684576-1-edumazet@google.com>
 <20251119084813.3684576-3-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251119084813.3684576-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 9:48 AM, Eric Dumazet wrote:
> This is a follow up of commit aa251c84636c ("tcp: fix too slow
> tcp_rcvbuf_grow() action") which brought again the issue that I tried
> to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> 
> We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
> ("tcp: increase tcp_rmem[2] to 32 MB")
> 
> Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> force NIC driver to not recycle pages from their page pool, and also
> can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> are usually slower than senders.
> 
> Add net.ipv4.tcp_rcvbuf_low_rtt sysctl, set by default to 1000 usec (1 ms)
> 
> If RTT if smaller than the sysctl value, use the RTT/tcp_rcvbuf_low_rtt
> ratio to control sk_rcvbuf inflation.
> 
> Tested:
> 
> Pair of hosts with a 200Gbit IDPF NIC. Using netperf/netserver
> 
> Client initiates 8 TCP bulk flows, asking netserver to use CPU #10 only.
> 
> super_netperf 8 -H server -T,10 -l 30
> 
> On server, use perf -e tcp:tcp_rcvbuf_grow while test is running.
> 
> Before:
> 
> sysctl -w net.ipv4.tcp_rcvbuf_low_rtt=1
> perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script|tail -20|cut -c30-230
>  1153.051201: tcp:tcp_rcvbuf_grow: time=398 rtt_us=382 copied=6905856 inq=180224 space=6115328 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25600000 famil
>  1153.138752: tcp:tcp_rcvbuf_grow: time=446 rtt_us=413 copied=5529600 inq=180224 space=4505600 ooo=0 scaling_ratio=240 rcvbuf=23068672 rcv_ssthresh=21571860 window_clamp=21626880 rcv_wnd=21286912 famil
>  1153.361484: tcp:tcp_rcvbuf_grow: time=415 rtt_us=380 copied=7061504 inq=204800 space=6725632 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25600000 famil
>  1153.457642: tcp:tcp_rcvbuf_grow: time=483 rtt_us=421 copied=5885952 inq=720896 space=4407296 ooo=0 scaling_ratio=240 rcvbuf=23763511 rcv_ssthresh=22223271 window_clamp=22278291 rcv_wnd=21430272 famil
>  1153.466002: tcp:tcp_rcvbuf_grow: time=308 rtt_us=281 copied=3244032 inq=180224 space=2883584 ooo=0 scaling_ratio=240 rcvbuf=44854314 rcv_ssthresh=41992059 window_clamp=42050919 rcv_wnd=41713664 famil
>  1153.747792: tcp:tcp_rcvbuf_grow: time=394 rtt_us=332 copied=4460544 inq=585728 space=3063808 ooo=0 scaling_ratio=240 rcvbuf=44854314 rcv_ssthresh=41992059 window_clamp=42050919 rcv_wnd=41373696 famil
>  1154.260747: tcp:tcp_rcvbuf_grow: time=652 rtt_us=226 copied=10977280 inq=737280 space=9486336 ooo=0 scaling_ratio=240 rcvbuf=31165538 rcv_ssthresh=29197743 window_clamp=29217691 rcv_wnd=28368896 fami
>  1154.375019: tcp:tcp_rcvbuf_grow: time=461 rtt_us=443 copied=7573504 inq=507904 space=6856704 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25288704 famil
>  1154.463072: tcp:tcp_rcvbuf_grow: time=494 rtt_us=408 copied=7983104 inq=200704 space=7065600 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25579520 famil
>  1154.474658: tcp:tcp_rcvbuf_grow: time=507 rtt_us=459 copied=5586944 inq=540672 space=4718592 ooo=0 scaling_ratio=240 rcvbuf=17852266 rcv_ssthresh=16692999 window_clamp=16736499 rcv_wnd=16056320 famil
>  1154.584657: tcp:tcp_rcvbuf_grow: time=494 rtt_us=427 copied=8126464 inq=204800 space=7782400 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25878235 window_clamp=25937095 rcv_wnd=25600000 famil
>  1154.702117: tcp:tcp_rcvbuf_grow: time=480 rtt_us=406 copied=5734400 inq=180224 space=5349376 ooo=0 scaling_ratio=240 rcvbuf=23068672 rcv_ssthresh=21571860 window_clamp=21626880 rcv_wnd=21286912 famil
>  1155.941595: tcp:tcp_rcvbuf_grow: time=717 rtt_us=670 copied=11042816 inq=3784704 space=7159808 ooo=0 scaling_ratio=240 rcvbuf=19581357 rcv_ssthresh=18333222 window_clamp=18357522 rcv_wnd=14614528 fam
>  1156.384735: tcp:tcp_rcvbuf_grow: time=529 rtt_us=473 copied=9011200 inq=180224 space=7258112 ooo=0 scaling_ratio=240 rcvbuf=19581357 rcv_ssthresh=18333222 window_clamp=18357522 rcv_wnd=18018304 famil
>  1157.821676: tcp:tcp_rcvbuf_grow: time=529 rtt_us=272 copied=8224768 inq=602112 space=6545408 ooo=0 scaling_ratio=240 rcvbuf=67000000 rcv_ssthresh=62793576 window_clamp=62812500 rcv_wnd=62115840 famil
>  1158.906379: tcp:tcp_rcvbuf_grow: time=710 rtt_us=445 copied=11845632 inq=540672 space=10240000 ooo=0 scaling_ratio=240 rcvbuf=31165538 rcv_ssthresh=29205935 window_clamp=29217691 rcv_wnd=28536832 fam
>  1164.600160: tcp:tcp_rcvbuf_grow: time=841 rtt_us=430 copied=12976128 inq=1290240 space=11304960 ooo=0 scaling_ratio=240 rcvbuf=31165538 rcv_ssthresh=29212591 window_clamp=29217691 rcv_wnd=27856896 fa
>  1165.163572: tcp:tcp_rcvbuf_grow: time=845 rtt_us=800 copied=12632064 inq=540672 space=7921664 ooo=0 scaling_ratio=240 rcvbuf=27666235 rcv_ssthresh=25912795 window_clamp=25937095 rcv_wnd=25260032 fami
>  1165.653464: tcp:tcp_rcvbuf_grow: time=388 rtt_us=309 copied=4493312 inq=180224 space=3874816 ooo=0 scaling_ratio=240 rcvbuf=44854314 rcv_ssthresh=41995899 window_clamp=42050919 rcv_wnd=41713664 famil
>  1166.651211: tcp:tcp_rcvbuf_grow: time=556 rtt_us=553 copied=6328320 inq=540672 space=5554176 ooo=0 scaling_ratio=240 rcvbuf=23068672 rcv_ssthresh=21571860 window_clamp=21626880 rcv_wnd=20946944 famil
> 
> After:
> 
> sysctl -w net.ipv4.tcp_rcvbuf_low_rtt=1000
> perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script|tail -20|cut -c30-230
>  1457.053149: tcp:tcp_rcvbuf_grow: time=128 rtt_us=24 copied=1441792 inq=40960 space=1269760 ooo=0 scaling_ratio=240 rcvbuf=2960741 rcv_ssthresh=2605474 window_clamp=2775694 rcv_wnd=2568192 family=AF_I
>  1458.000778: tcp:tcp_rcvbuf_grow: time=128 rtt_us=31 copied=1441792 inq=24576 space=1400832 ooo=0 scaling_ratio=240 rcvbuf=3060163 rcv_ssthresh=2810042 window_clamp=2868902 rcv_wnd=2674688 family=AF_I
>  1458.088059: tcp:tcp_rcvbuf_grow: time=190 rtt_us=110 copied=3227648 inq=385024 space=2781184 ooo=0 scaling_ratio=240 rcvbuf=6728240 rcv_ssthresh=6252705 window_clamp=6307725 rcv_wnd=5799936 family=AF
>  1458.148549: tcp:tcp_rcvbuf_grow: time=232 rtt_us=129 copied=3956736 inq=237568 space=2842624 ooo=0 scaling_ratio=240 rcvbuf=6731333 rcv_ssthresh=6252705 window_clamp=6310624 rcv_wnd=5918720 family=AF
>  1458.466861: tcp:tcp_rcvbuf_grow: time=193 rtt_us=83 copied=2949120 inq=180224 space=2457600 ooo=0 scaling_ratio=240 rcvbuf=5751438 rcv_ssthresh=5357689 window_clamp=5391973 rcv_wnd=5054464 family=AF_
>  1458.775476: tcp:tcp_rcvbuf_grow: time=257 rtt_us=127 copied=4304896 inq=352256 space=3346432 ooo=0 scaling_ratio=240 rcvbuf=8067131 rcv_ssthresh=7523275 window_clamp=7562935 rcv_wnd=7061504 family=AF
>  1458.776631: tcp:tcp_rcvbuf_grow: time=200 rtt_us=96 copied=3260416 inq=143360 space=2768896 ooo=0 scaling_ratio=240 rcvbuf=6397256 rcv_ssthresh=5938567 window_clamp=5997427 rcv_wnd=5828608 family=AF_
>  1459.707973: tcp:tcp_rcvbuf_grow: time=215 rtt_us=96 copied=2506752 inq=163840 space=1388544 ooo=0 scaling_ratio=240 rcvbuf=3068867 rcv_ssthresh=2768282 window_clamp=2877062 rcv_wnd=2555904 family=AF_
>  1460.246494: tcp:tcp_rcvbuf_grow: time=231 rtt_us=80 copied=3756032 inq=204800 space=3117056 ooo=0 scaling_ratio=240 rcvbuf=7288091 rcv_ssthresh=6773725 window_clamp=6832585 rcv_wnd=6471680 family=AF_
>  1460.714596: tcp:tcp_rcvbuf_grow: time=270 rtt_us=110 copied=4714496 inq=311296 space=3719168 ooo=0 scaling_ratio=240 rcvbuf=8957739 rcv_ssthresh=8339020 window_clamp=8397880 rcv_wnd=7933952 family=AF
>  1462.029977: tcp:tcp_rcvbuf_grow: time=101 rtt_us=19 copied=1105920 inq=40960 space=1036288 ooo=0 scaling_ratio=240 rcvbuf=2338970 rcv_ssthresh=2091684 window_clamp=2192784 rcv_wnd=1986560 family=AF_I
>  1462.802385: tcp:tcp_rcvbuf_grow: time=89 rtt_us=45 copied=1069056 inq=0 space=1064960 ooo=0 scaling_ratio=240 rcvbuf=2338970 rcv_ssthresh=2091684 window_clamp=2192784 rcv_wnd=2035712 family=AF_INET6
>  1462.918648: tcp:tcp_rcvbuf_grow: time=105 rtt_us=33 copied=1441792 inq=180224 space=1069056 ooo=0 scaling_ratio=240 rcvbuf=2383282 rcv_ssthresh=2091684 window_clamp=2234326 rcv_wnd=1896448 family=AF_
>  1463.222533: tcp:tcp_rcvbuf_grow: time=273 rtt_us=144 copied=4603904 inq=385024 space=3469312 ooo=0 scaling_ratio=240 rcvbuf=8422564 rcv_ssthresh=7891053 window_clamp=7896153 rcv_wnd=7409664 family=AF
>  1466.519312: tcp:tcp_rcvbuf_grow: time=130 rtt_us=23 copied=1343488 inq=0 space=1261568 ooo=0 scaling_ratio=240 rcvbuf=2780158 rcv_ssthresh=2493778 window_clamp=2606398 rcv_wnd=2494464 family=AF_INET6
>  1466.681003: tcp:tcp_rcvbuf_grow: time=128 rtt_us=21 copied=1441792 inq=12288 space=1343488 ooo=0 scaling_ratio=240 rcvbuf=2932027 rcv_ssthresh=2578555 window_clamp=2748775 rcv_wnd=2568192 family=AF_I
>  1470.689959: tcp:tcp_rcvbuf_grow: time=255 rtt_us=122 copied=3932160 inq=204800 space=3551232 ooo=0 scaling_ratio=240 rcvbuf=8182038 rcv_ssthresh=7647384 window_clamp=7670660 rcv_wnd=7442432 family=AF
>  1471.754154: tcp:tcp_rcvbuf_grow: time=188 rtt_us=95 copied=2138112 inq=577536 space=1429504 ooo=0 scaling_ratio=240 rcvbuf=3113650 rcv_ssthresh=2806426 window_clamp=2919046 rcv_wnd=2248704 family=AF_
>  1476.813542: tcp:tcp_rcvbuf_grow: time=269 rtt_us=99 copied=3088384 inq=180224 space=2564096 ooo=0 scaling_ratio=240 rcvbuf=6219470 rcv_ssthresh=5771893 window_clamp=5830753 rcv_wnd=5509120 family=AF_
>  1477.738309: tcp:tcp_rcvbuf_grow: time=166 rtt_us=54 copied=1777664 inq=180224 space=1417216 ooo=0 scaling_ratio=240 rcvbuf=3117118 rcv_ssthresh=2874958 window_clamp=2922298 rcv_wnd=2613248 family=AF_
> 
> We can see sk_rcvbuf values are much smaller, and that rtt_us (estimation of rtt
> from a receiver point of view) is kept small, instead of being bloated.
> 
> No difference in throughput.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Whoops, I replied in the old thread too late. I also see good numbers in
the scenario above.

Tested-by: Paolo Abeni <pabeni@redhat.com>


