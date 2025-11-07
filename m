Return-Path: <netdev+bounces-236838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC5C4094B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EF6434CE86
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3965A328B40;
	Fri,  7 Nov 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmEQbmy6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSjUa8eu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5253271EF
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529308; cv=none; b=iNaqhJBeKDsYwBsDa6ZAwaA6sNmM57RefmKze2ZzixbTNKze5bWElnIU2jbd1ZZHYaFOZGOBE8vKHaJyB9Sx28zbXib3RfGbCodW+WRGpHnQqQmQX82K/rB8IIH6Zp0CfS4LFjr36pFKNAtmqxGJ6cREBrcRxqX5IpGMkp9FMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529308; c=relaxed/simple;
	bh=Im9sHIYxGsoxQVm45ItxopR8ioLz3Y0EbShVaETk5S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MgyG8SWglY7pzp+7oUJyR6twmw72/vWr9d6NM7Id0B62LQSRXsY1SyggGSchsrJQiQF6QucD5KWUPqVgG09ty7Hn2oKrh6vv+Y9oKITrf3Vm+ZpsPB/76r2vRDlMHl90afY8AxCG8DZ0N91M/TSZ/ZCrS3WB6+2hMTReETMGd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmEQbmy6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSjUa8eu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762529304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OJDJfEwaDZ/XADINRPs5L+kT4Za/560MLuM0eA8QiU=;
	b=WmEQbmy65LZltecnHjP4/ic5DPVXYgc9lLST/ek/GRRYTA9Bvnhb+LwtpSpxXC+O3vuzyf
	eOxMhzJYsRC8ShM1+VOItIqFRoM8CtiJjQVXDStdOKbNyYV1CuA2cMMtIsCvMyQu1m69tt
	R0rQJmJESjqSkLhX6UPOdpdztbFat/4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-ER_UWQDgNfC_2cHDmVWFkg-1; Fri, 07 Nov 2025 10:28:23 -0500
X-MC-Unique: ER_UWQDgNfC_2cHDmVWFkg-1
X-Mimecast-MFC-AGG-ID: ER_UWQDgNfC_2cHDmVWFkg_1762529299
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b71043a0e4fso86960066b.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762529299; x=1763134099; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OJDJfEwaDZ/XADINRPs5L+kT4Za/560MLuM0eA8QiU=;
        b=WSjUa8euL2147aJG/Yk17LITx71vflHgoY6SssMn0JhUw6LBvPA+H6ZJPbLso1mFrw
         r9bStWpa1BfBTlt+yjnOHGBM4+oN229wt7o8Vmvq6YjQoxpPBfLhGZxThDwr7M48qEIo
         lR8m0c9zzmaSvmCR5bW7QVmiqkVd1oyl54cg63SeBS9QAAsXf6g1ZvAumi27WRP/2Kb0
         PkbgEq3sXbUKFzlW6fTinrEmXmPzTHOW4KHVmXz+YGnz37BIG+yMGDM+Tu0QS7hUrpCx
         tqplMjCjBAZS/MtlNt3Zt8TS0Jrgj0mYJAd9aKBeSA8rwZl7um93CBIPGxRccoRQK36H
         oB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529299; x=1763134099;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OJDJfEwaDZ/XADINRPs5L+kT4Za/560MLuM0eA8QiU=;
        b=eu7y+LsrJd7xG/oLq1Wa0VUo7WIVPQIHYsFqXTWzAjqK0psRwbcN/lzRX3Sf19KS6A
         iX129bg/6gJFOity57oqge2rSc5g4U288g12O9C19oU62p1Yal8n5rb0Obk0aVqzdulJ
         R4R4Wx8B14AblPMXUa2nSCApj012wTzq7EF3+IKfnDnOKbpi28wFS007jZMu92XRStwT
         ifLikHFWU1/l4BzSUEzfsPRsiUHkGA3YtbUEYIcbdraVW5+xX/vLHuyfLuqb1xcSHs5r
         Se3SDD7coWZYEHNCKPt73gdVRnc4eFJWVOUdDT86bJICjpFedayb2BlZrUWqlkdxtVpL
         Xjxw==
X-Forwarded-Encrypted: i=1; AJvYcCULwl+zMqY7YcWceBgMRRaAn8Z1aG9mVBfRIew0sFCgzESgPRAAoFSIxifOpcxGpmm0oa9iwk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9O9m39j6DMIly8Z+bBOacwjj+5xcssbxuDL2kQznd9D1SSol
	t3aC3ejDjqXvBlfa4h06uXYIdymf//WB629pe8Q+m5lwek1LvfOsonCFPBSxW0b4qRV2HOPadOB
	nE6REw+hpXJE9RdqpRT8y0u3cTa91i9dUiRktWXylHsVIYs3H4en+otYFVw==
X-Gm-Gg: ASbGncturNyCS9OREExL8YNOGLQvQp9xN9I2WQj/33Af1g78uGBkrqJ3XDBi6RHYovd
	BzLKfR2Ow8w2utW11dCr95D8aEP84rauXVANkpKemhr+zbzmJxDJpysBP0QtWOthJJNMiXVldmx
	xTvZkUjiD5QoifjS+61e4EwKUD5omzUoF6RtoYAT8Swcb9xGSLOZXkrRvgKre5GMj277tOYEW3F
	DJK/HVp9GkLWTWWga0n4XC3+LQbitwRVLcxHAvVCZDePbsNUCS5uPMVWhLkZrEGzCW01WqeJe8Y
	gDXqlPbRSkTau+KNoHbDlrbNpeCZZ33SVIr+YFVAmWq3EAoJq8G8CnDOYnYo+O8o9kK7GDujrMj
	JfAuRHzFIgY5Jm5cOk2d8MYL78w==
X-Received: by 2002:a17:906:7953:b0:b04:c373:2833 with SMTP id a640c23a62f3a-b72c0a6c2b7mr377273466b.32.1762529299191;
        Fri, 07 Nov 2025 07:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcjevYgg+1eJCEHXMYjDze/hIlwEDtewLt9AVMk9znI2kGRB2IbOXmncyQGJL2eqacir6e1Q==
X-Received: by 2002:a17:906:7953:b0:b04:c373:2833 with SMTP id a640c23a62f3a-b72c0a6c2b7mr377269266b.32.1762529298713;
        Fri, 07 Nov 2025 07:28:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f37csm266705766b.64.2025.11.07.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:28:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C80C6328C6B; Fri, 07 Nov 2025 16:28:16 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <20251013145416.829707-6-edumazet@google.com>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Nov 2025 16:28:16 +0100
Message-ID: <877bw1ooa7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> Remove busylock spinlock and use a lockless list (llist)
> to reduce spinlock contention to the minimum.
>
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
>
> After this patch, we get a 300 % improvement on heavy TX workloads.
> - Sending twice the number of packets per second.
> - While consuming 50 % less cycles.
>
> Note that this also allows in the future to submit batches
> to various qdisc->enqueue() methods.
>
> Tested:
>
> - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid contention in mm)
> - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"

Hi Eric

While testing this with sch_cake (to get a new baseline for the mq_cake
patches as Jamal suggested), I found that this patch completely destroys
the performance of cake in particular.

I run a small UDP test (64-byte packets across 16 flows through
xdp-trafficgen, offered load is ~5Mpps) with a single cake instance on
as the root interface qdisc.

With a stock Fedora (6.17.7) kernel, this gets me around 630 Kpps across
8 queues (on an E810-C, ice driver):

Ethtool(ice0p1  ) stat:     40321218 (     40,321,218) <= tx_bytes /sec
Ethtool(ice0p1  ) stat:     42841424 (     42,841,424) <= tx_bytes.nic /sec
Ethtool(ice0p1  ) stat:      5248505 (      5,248,505) <= tx_queue_0_bytes /sec
Ethtool(ice0p1  ) stat:        82008 (         82,008) <= tx_queue_0_packets /sec
Ethtool(ice0p1  ) stat:      3425984 (      3,425,984) <= tx_queue_1_bytes /sec
Ethtool(ice0p1  ) stat:        53531 (         53,531) <= tx_queue_1_packets /sec
Ethtool(ice0p1  ) stat:      5277496 (      5,277,496) <= tx_queue_2_bytes /sec
Ethtool(ice0p1  ) stat:        82461 (         82,461) <= tx_queue_2_packets /sec
Ethtool(ice0p1  ) stat:      5285736 (      5,285,736) <= tx_queue_3_bytes /sec
Ethtool(ice0p1  ) stat:        82590 (         82,590) <= tx_queue_3_packets /sec
Ethtool(ice0p1  ) stat:      5280731 (      5,280,731) <= tx_queue_4_bytes /sec
Ethtool(ice0p1  ) stat:        82511 (         82,511) <= tx_queue_4_packets /sec
Ethtool(ice0p1  ) stat:      5275665 (      5,275,665) <= tx_queue_5_bytes /sec
Ethtool(ice0p1  ) stat:        82432 (         82,432) <= tx_queue_5_packets /sec
Ethtool(ice0p1  ) stat:      5276398 (      5,276,398) <= tx_queue_6_bytes /sec
Ethtool(ice0p1  ) stat:        82444 (         82,444) <= tx_queue_6_packets /sec
Ethtool(ice0p1  ) stat:      5250946 (      5,250,946) <= tx_queue_7_bytes /sec
Ethtool(ice0p1  ) stat:        82046 (         82,046) <= tx_queue_7_packets /sec
Ethtool(ice0p1  ) stat:            1 (              1) <= tx_restart /sec
Ethtool(ice0p1  ) stat:       630023 (        630,023) <= tx_size_127.nic /sec
Ethtool(ice0p1  ) stat:       630019 (        630,019) <= tx_unicast /sec
Ethtool(ice0p1  ) stat:       630020 (        630,020) <= tx_unicast.nic /sec

However, running the same test on a net-next kernel, performance drops
to round 10 Kpps(!):

Ethtool(ice0p1  ) stat:       679003 (        679,003) <= tx_bytes /sec
Ethtool(ice0p1  ) stat:       721440 (        721,440) <= tx_bytes.nic /sec
Ethtool(ice0p1  ) stat:       123539 (        123,539) <= tx_queue_0_bytes /sec
Ethtool(ice0p1  ) stat:         1930 (          1,930) <= tx_queue_0_packets /sec
Ethtool(ice0p1  ) stat:         1776 (          1,776) <= tx_queue_1_bytes /sec
Ethtool(ice0p1  ) stat:           28 (             28) <= tx_queue_1_packets /sec
Ethtool(ice0p1  ) stat:         1837 (          1,837) <= tx_queue_2_bytes /sec
Ethtool(ice0p1  ) stat:           29 (             29) <= tx_queue_2_packets /sec
Ethtool(ice0p1  ) stat:         1776 (          1,776) <= tx_queue_3_bytes /sec
Ethtool(ice0p1  ) stat:           28 (             28) <= tx_queue_3_packets /sec
Ethtool(ice0p1  ) stat:         1654 (          1,654) <= tx_queue_4_bytes /sec
Ethtool(ice0p1  ) stat:           26 (             26) <= tx_queue_4_packets /sec
Ethtool(ice0p1  ) stat:       222026 (        222,026) <= tx_queue_5_bytes /sec
Ethtool(ice0p1  ) stat:         3469 (          3,469) <= tx_queue_5_packets /sec
Ethtool(ice0p1  ) stat:       183072 (        183,072) <= tx_queue_6_bytes /sec
Ethtool(ice0p1  ) stat:         2861 (          2,861) <= tx_queue_6_packets /sec
Ethtool(ice0p1  ) stat:       143322 (        143,322) <= tx_queue_7_bytes /sec
Ethtool(ice0p1  ) stat:         2239 (          2,239) <= tx_queue_7_packets /sec
Ethtool(ice0p1  ) stat:        10609 (         10,609) <= tx_size_127.nic /sec
Ethtool(ice0p1  ) stat:        10609 (         10,609) <= tx_unicast /sec
Ethtool(ice0p1  ) stat:        10609 (         10,609) <= tx_unicast.nic /sec

Reverting commit 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
(and the followon f8a55d5e71e6 ("net: add a fast path in
__netif_schedule()"), but that alone makes no difference) gets me back
to the previous 630-650 Kpps range.

I couldn't find any other qdisc that suffers in the same way (tried
fq_codel, sfq and netem as single root qdiscs), so this seems to be some
specific interaction between the llist implementation and sch_cake. Any
idea what could be causing this?

-Toke


