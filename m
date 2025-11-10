Return-Path: <netdev+bounces-237141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE0C45D9F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60FC188DA08
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB8289378;
	Mon, 10 Nov 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9Kdnr1I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbbdYAeu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6EF2EC090
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769688; cv=none; b=uHzsVWaAAgnqRXWKtmFROcEX4fnExFs+tNyLDXTBKNxM80eLhs7dTqenMog88IBiI6NTgL78yDzA4pyoTkWYwX3JXjelDusQxcU+E44uwI2+3b+pErhl0h3/CvlM3/1VZmX2oyqpou57P4AFkIlLRi8qG4I9f2BeZlSJtdlAIps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769688; c=relaxed/simple;
	bh=AZKUEGgjNpZfOXzOrP7zZL+C4dkyk8mLuG3m85G4guM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bc16sDZ/UpCNTiBwrAmGz2M9NLrL2GlvRIPsv7JK057ZryLpMKAf/d02Ut5LvNB+TOTIVonC74SO/mKariVoRwZ7c+wy5j0cNqkv8cwWiYmZM3TN8X2LHKfHihq/gSNvZSi5faJQox93r2xsRJJFFkOZW3R0qjVd/41KRR3WMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9Kdnr1I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbbdYAeu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762769685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZRctZ7eCZieZVgnN5anpOxD0A/JDN7MJ2QsqWkfo3I=;
	b=R9Kdnr1IdiYMf6kT4NXeXDVfCv8GzI2QYQMs16727mlFa4YVDP2BRpLo1cMaYu3YrOGBDE
	3F69Znw5z/EHkezmvfJwHPo4ITC2pBy9Z5zT2M8/2VyTJKcTdkfHLdKbmc7G3KM+wpAMA1
	po8T9ADHAGxDE21ToI9sTau2U70Av0Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-e5zbUB2iO7uuWKw1il8ijA-1; Mon, 10 Nov 2025 05:14:44 -0500
X-MC-Unique: e5zbUB2iO7uuWKw1il8ijA-1
X-Mimecast-MFC-AGG-ID: e5zbUB2iO7uuWKw1il8ijA_1762769683
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7267543bc9so221275366b.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 02:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762769683; x=1763374483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZRctZ7eCZieZVgnN5anpOxD0A/JDN7MJ2QsqWkfo3I=;
        b=AbbdYAeuBM6zOuiPafVwE5eBCQ+L8yuX2UaeIiAJJo5bTuMwecXYWGrxwPaSjkLPRj
         uUc8VRnAJtcaU6/iMtqCiuFKUqO96M2t9X+67I5qiTZ3XHg5nRiEHA1I5eJaKzONspY8
         V4MPWfHWzF8C3fI6OVgoVyF6qlDaU0+tS+RCVDM3t2XKx4zPfcPYrUizF/wGVYaenbrz
         PKGfqd+kgaH6Ouy6ZvpARXAFy+6ScM3D+JofNBFDfIrMOvgs2r2oGOtc9raBYv6+bLB2
         nTgIKIHyiWx2gbfm3f18KB9cv77p41glhTI/tESidbPZtmPtSRxBxlFr5xOJE5xwmTcr
         nrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769683; x=1763374483;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bZRctZ7eCZieZVgnN5anpOxD0A/JDN7MJ2QsqWkfo3I=;
        b=lZov61uH42czH3Gi/pu56D2mDKnPvtAoQ+zB6OwSPl/+1mUdRkEiDy8rYJGnkFBCKv
         GgmU+InnTq+d/XlarkXEnDiJTODZFFqjhhlJG8ME4bZNWTlyFjrLPs4vbyuaIb8NtPEy
         3DzNx1ROL9GoN91dQvcTS+th+fIh2XqbLHL8UgP7Kv128iGVhGxPbPcTcZvxR24hvzl1
         T2o1BVFVAVou+j+mzyljOLfEFQyHKyGnjKMDSTF6Na40LRRXlGgmAt5P/zGy/VEw/iU2
         FZsH3SRmlA6iG0NrEu/FdSFB3wrqOsyHWnF1jYG3C0+vL9H9OGuJnMst0c0lb16+ocpT
         9XcA==
X-Forwarded-Encrypted: i=1; AJvYcCVJr35dvnmFfIniq44PbgOt8Fpx+FWe52cyaqmn75PB8d82AX6mphlg5j1evDypWeDcSUgGB+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLceZ+RrmItSgpRhYOhiHL2O7cXmTjSrvx0fqUCxdEjrXrdUt
	kLhkEQBYUfeB3zbC/0MmKUiXVq1jvQdgrahhw1bCI2hgHEbd8ZuBEVTPMar+Uq6AA2wOHO+NNIm
	79tfJnazdMU15+bwbjuIVbnhTp1DARGoyuOnIMDOS/YQn0VF598lqM9MUug==
X-Gm-Gg: ASbGnctQtg9b5e5j9ZgzqIdPFN5wQUaEbEafO/K7OeiZ8/DEazR1/Xlv1R2575LnLx8
	sq/Ny0O3jf6t9oWubyRozgsrAfgqAoVbs9qE0xho2ahfI5MWqjxDBjBzswIX8+o9V60h/x9G7b7
	OZPnZNnofBsTnwuLaFU1criuCGPPlk5t/7zu2KBvQ7ee6oVf90mzj1qA8iIa6uwnyHSictKpseZ
	+/UlJIR+XTFewIrMSNfBoggH8nn/Ih8q02AfjKuEVhNNDJkn/AIPzBawNR76hqDckmSLbhL8JoG
	adU8MefL0A3wSwwtP7VJbs9n7o+T8HeJ5J8kdX5NrfZ8a7DiWQrrAoAndAXD8LGHbzK9oET7Ce1
	IHvbKV632h6Hq+Py82pDnSi4GSg==
X-Received: by 2002:a17:907:841:b0:b72:67c2:6eb0 with SMTP id a640c23a62f3a-b72e0562e6dmr832813166b.62.1762769683354;
        Mon, 10 Nov 2025 02:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1nYy/FiP33oJYhV2poDNXyP32kiRanu9dHI2J75JSQDJScWo7uy5J9kqi3CrvoiYPtNSz/A==
X-Received: by 2002:a17:907:841:b0:b72:67c2:6eb0 with SMTP id a640c23a62f3a-b72e0562e6dmr832810466b.62.1762769682934;
        Mon, 10 Nov 2025 02:14:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbce8f9sm1051975166b.2.2025.11.10.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:14:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6597A3291F8; Mon, 10 Nov 2025 11:14:41 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
In-Reply-To: <20251109161215.2574081-1-edumazet@google.com>
References: <20251109161215.2574081-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 10 Nov 2025 11:14:41 +0100
Message-ID: <87v7jimbxq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
> I started seeing many qdisc requeues on IDPF under high TX workload.
>
> $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle 1:
> qdisc mq 1: root
>  Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 requ=
eues 3532840114)
>  backlog 1056Kb 6675p requeues 3532840114
> qdisc mq 1: root
>  Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 requ=
eues 3537737653)
>  backlog 781164b 4822p requeues 3537737653
>
> This is caused by try_bulk_dequeue_skb() being only limited by BQL budget.
>
> perf record -C120-239 -e qdisc:qdisc_dequeue sleep 1 ; perf script
> ...
>  netperf 75332 [146]  2711.138269: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
292 skbaddr=3D0xff378005a1e9f200
>  netperf 75332 [146]  2711.138953: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
213 skbaddr=3D0xff378004d607a500
>  netperf 75330 [144]  2711.139631: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
233 skbaddr=3D0xff3780046be20100
>  netperf 75333 [147]  2711.140356: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
093 skbaddr=3D0xff37800514845b00
>  netperf 75337 [151]  2711.141037: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
353 skbaddr=3D0xff37800460753300
>  netperf 75337 [151]  2711.141877: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
367 skbaddr=3D0xff378004e72c7b00
>  netperf 75330 [144]  2711.142643: qdisc:qdisc_dequeue: dequeue ifindex=
=3D5 qdisc handle=3D0x80150000 parent=3D0x10013 txq_state=3D0x0 packets=3D1=
202 skbaddr=3D0xff3780045bd60000
> ...
>
> This is bad because :
>
> 1) Large batches hold one victim cpu for a very long time.
>
> 2) Driver often hit their own TX ring limit (all slots are used).
>
> 3) We call dev_requeue_skb()
>
> 4) Requeues are using a FIFO (q->gso_skb), breaking qdisc ability to
>    implement FQ or priority scheduling.
>
> 5) dequeue_skb() gets packets from q->gso_skb one skb at a time
>    with no xmit_more support. This is causing many spinlock games
>    between the qdisc and the device driver.
>
> Requeues were supposed to be very rare, lets keep them this way.
>
> Limit batch sizes to /proc/sys/net/core/dev_weight (default 64) as
> __qdisc_run() was designed to use.
>
> Fixes: 5772e9a3463b ("qdisc: bulk dequeue support for qdiscs with TCQ_F_O=
NETXQUEUE")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Makes sense!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


