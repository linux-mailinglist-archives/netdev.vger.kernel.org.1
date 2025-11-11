Return-Path: <netdev+bounces-237699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F036C4F1C7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E58564F2291
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0CD35BDBC;
	Tue, 11 Nov 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvEOmuVy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rP2/lLAP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F227603F
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879429; cv=none; b=mEgPu5jI+RI5Rh4eaE7tJvgwBmhaFHEvxz5CVR5zxE6V8HLVX3CzfhutrGwuNkvrDvIH/I/Fo3guaYLdEKvKLrgBL14sBhmp06RGXYJ435uYcUq/DVY1JXX8GX9lRJLKoMzqp28sHJX42n/zjRsvqD5VscUe/JBxkDx7KAbeWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879429; c=relaxed/simple;
	bh=C0hH0kd/s8alj5OmACmIXR8p1iF/WylUpzyEAhZdlH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWD1GHZkLy6rlayb/lyrGPNJUqm+dVr8k53Z4TyOxalnnEtIPpDu4BUIraWKUtIFA98qDZIisa1k+qO7OvgPUXbStm8EYPyCWlddGytfsMYJdGYA7eowRm/9pEwieLqczxkFjDvy8ZtvCIF7wHLDerAUKQKeM9goAQ9GsuDypuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvEOmuVy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rP2/lLAP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762879425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sM+fc+deVDMLxSX4u6IU5Rd++OwnpBqCoCImK6/v/g0=;
	b=VvEOmuVyLs76Gt+F/mDbZJsISxfEjzJ2p6O6p5C+C4RgRL9xc3TTsAzdOeHIGS7CDNnTyu
	L/n0f9/+E1T0dv+JUHUST8bq7ruXT+JXXnZr9LMwcRekcyvdYGoZ6QaIfK7cOxqkdEaTOQ
	1KuX/+VC1/ZuHSv+Vrf7BtzC46Km3k0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-czu3RsHQP0SG1xrs25ux1g-1; Tue, 11 Nov 2025 11:43:43 -0500
X-MC-Unique: czu3RsHQP0SG1xrs25ux1g-1
X-Mimecast-MFC-AGG-ID: czu3RsHQP0SG1xrs25ux1g_1762879423
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d7405e6a8so101214566b.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762879423; x=1763484223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sM+fc+deVDMLxSX4u6IU5Rd++OwnpBqCoCImK6/v/g0=;
        b=rP2/lLAPi6pLuT+Kan5pl5dW89+r79bugvJlBu67YkhX0UbByZDi77oZHIC5o5cnWC
         qKBKen+EaRiTB7lB0StFIrsQ5yxN1IsLv8TVsZ/q05/5qZQPtZvSBGP3omVDt4SWrS6K
         NhkZmT8fjmK+v71cG9XnND+BnMWbtYDO65nUGEd/vWH0UquSCKmDuE/bvwl9ecmypnOn
         A6wzvo/TCSSac7b4KLrK325qxzrknLyNApJ9isOaeDHnRWtCEtekWsmT7TxoM6NuE30k
         mfX9D9PZZ4urWmMqneoZHcrODwCxDGLwXBSRIo2HCmPfn6YdItYKh1K/yLng9+/hkGkV
         FPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762879423; x=1763484223;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sM+fc+deVDMLxSX4u6IU5Rd++OwnpBqCoCImK6/v/g0=;
        b=tE1NMcGZwDhpt7viAiSHnu2gaW1Nxsy8d/PDU3c9RFEEu9m6mh/t3ZPu6H3G+QTkt5
         SzWXj6UePB0d115hwvXLnT/b7eL4mLn3jUw6TSwxvFElZkRnL3JLRgpIVUQyWg7FPLM7
         ezhShDVa1gMtthzCVPwn+CsYBSdLdPzh+CdM+Aa2jEFfTjv/9bvinHmkRjlqVRL4X/+g
         iDPX+mfxWPme9W42d5Xm4mHM9+Htw6JyFjGrbHiv8i30n66fDAf+4Ni+IapOxuAn6tEA
         8W120uBDmXhHMcVXDMiMmY9aKJGfB2zPAonQMqXx18LyJnVVxHX8HVcklcbgUiBNRDkO
         6njQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOb+5x53lXFFmou/nAf5HZlfX6UeFXPbXLA45E+XFtxchiam1kGcHFStF12qgL+9KbBFgRpaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHeWj1IA8E2nEPBuTvvoR751EiJgDOPDyFMBBBOIsXfGiUcIG
	fS5EpXlEUMra74scIXcVhneH02jUwY9WKQt+OWIFLvR0WVa7XpZ2Am5rLugH3GI0qhsmyASJol5
	EGuo53YLhIv+kIziSZSdSEwEmpCIRSYI3d3pDjM0q6OdG7a4xyXe4Z4tDpg==
X-Gm-Gg: ASbGnct4dILeR/UbH281sid2/eEINLR0cc8NboAVSatywIRqw8iqOX7DaBvHfF8EcV5
	FDdJ5RLDJFPigS+JkUtgrJByHu5xtjrds2Y+q7PHiiHw/eGpZiKH9e0C25WiHTDepd3kRbph1a2
	z0x/Kz7dra/ASnXa7j331/h9hwgWhmHpkpOuzB4bqfXmWNZ2M4Z3lPkYVZ4zox9cy5Mfqe2GTZW
	etH3iElL80aGpAMrjT/9v7M9wqXEPdqISsTV9sj2RZqqB+XyvGAYB77fGmI8XPnh4sC5KszRCOt
	Fn5++bVCQS4/AOliPjVI8n91Zlh6XJXZ1BZifxRqDbv631aMnYb+sjev/tkV1Pkrr10m7XilDkE
	YbStjDNQfjfO4kOrQno4ETkYlqg==
X-Received: by 2002:a17:907:728c:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b731d179197mr473929266b.5.1762879422680;
        Tue, 11 Nov 2025 08:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn/OmwHX5cDv/9JnlRZqjtiLqaRfEADKBnCqKcHAmflwiKKynmBzsvFlQj/FP7HBtXrEX3UQ==
X-Received: by 2002:a17:907:728c:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b731d179197mr473926566b.5.1762879422275;
        Tue, 11 Nov 2025 08:43:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7327a48bc7sm127747566b.71.2025.11.11.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:43:41 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A897C329611; Tue, 11 Nov 2025 17:43:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 00/14] net_sched: speedup qdisc dequeue
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
References: <20251111093204.1432437-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Nov 2025 17:43:40 +0100
Message-ID: <87jyzwldtv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Avoid up to two cache line misses in qdisc dequeue() to fetch
> skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
>
> Idea is to cache gso_segs at enqueue time before spinlock is
> acquired, in the first skb cache line, where we already
> have qdisc_skb_cb(skb)->pkt_len.
>
> This series gives a 8 % improvement in a TX intensive workload.
>
> (120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)
>
> v2: - Fixed issues reported by Jakub (thanks !)
>     - Added three patches adding/using qdisc_dequeue_drop() after
>       recent regressions with CAKE qdisc reported by Toke.
>       More fixes to come later.
>
> v1: https://lore.kernel.org/netdev/20251110094505.3335073-1-edumazet@goog=
le.com/T/#m8f562ed148f807c02fd02c6cd243604d449615b9
>
> Eric Dumazet (14):
>   net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
>   net: init shinfo->gso_segs from qdisc_pkt_len_init()
>   net_sched: initialize qdisc_skb_cb(skb)->pkt_segs in
>     qdisc_pkt_len_init()
>   net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
>   net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
>   net_sched: cake: use qdisc_pkt_segs()
>   net_sched: add Qdisc_read_mostly and Qdisc_write groups
>   net_sched: sch_fq: move qdisc_bstats_update() to fq_dequeue_skb()
>   net_sched: sch_fq: prefetch one skb ahead in dequeue()
>   net: prefech skb->priority in __dev_xmit_skb()
>   net: annotate a data-race in __dev_xmit_skb()
>   net_sched: add tcf_kfree_skb_list() helper
>   net_sched: add qdisc_dequeue_drop() helper
>   net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel

As mentioned in the other thread[0], I tested this series and it
definitely seems to improve things, so feel free to add my:

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


