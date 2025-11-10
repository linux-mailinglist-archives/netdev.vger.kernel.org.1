Return-Path: <netdev+bounces-237126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983FC45B29
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085683B7166
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC7A301464;
	Mon, 10 Nov 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qP0Qwwq1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F530102F
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767911; cv=none; b=ttjaDWLUhiUqQRg9dR0SdAEJtR3DuLWdoa6/dL3RTrhmwnhuFjD8pG4uaibVKIE6AQbSMltvlm939Aa/Q+opZ6n8HojoleD+aXQSw0oCx5i9V2zYttqpuY5RN/BPTsOe3yFj1vxKMab67L9pHY/SzqUsW+600R7JUBlC9kzTLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767911; c=relaxed/simple;
	bh=d7YEs3D1WRNO0tb62bshJvwqoYNTXknfCQ7BRk+EvLk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QoZnwQrvX85SRjfcmb1PKCD2UxBlqhQ15FZaSt7eqDd/W7hE88xT9gFA++sFkJ/G8Jp9QWHMLrjpKH6i9OxGtho9oceCverT/ODB2O/iDdSemRaNA5V1DhLBVPDXBrs1k/BXBgBAuxXzk3Bqii/hFwk3BGP/DrCkG3P6emcsyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qP0Qwwq1; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8a5b03118f4so732177685a.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 01:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762767909; x=1763372709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PzgLNpii6iUXKl+MFq609WhcQqn2fD0WO/Cen+8bMh0=;
        b=qP0Qwwq1Vsga2UANDx0F0bGd0sCH05QUet6kArV4pmTEEzj375FtRMX6Vq4SCo0NJX
         hzkkrBg7XkpxssYEJ1rGTIjNmd4V4s8U9N1uVy5rjuKdQ8KXRwcfiLrqJjhfAgqKXWv7
         aalS+wgK+3YKgpOVJEQs7L6e7jfwNfmT+ekp+bhxO3DMZr5RbRhLWclZ16jtGvV4unwp
         Ff1KpgdH2wA5FkuWKOybvuuYqZyUrkqZDyqkLDeHOL2bUlVwdhNpu8b7oDDI8rQGhqUk
         GSKylvj86Acxb2EURYFMPGZe3U85ysEE98ifHG6GE5TcVpNUxdoC0hhu2+CyMxsuJc0U
         /WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767909; x=1763372709;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzgLNpii6iUXKl+MFq609WhcQqn2fD0WO/Cen+8bMh0=;
        b=F4t2BVsHz9Oj5RVy0m5cUvar2hjNvneHhLIDjUQf7ZUOnKhrBiACZh2nly7aynTGEP
         BVgmzVwHd0j6Bwx+UjuS+zRBZAaxh9eAPWp1qWBmKg7xvtsCx02tmydKIqT+g7BxpRBJ
         MMOjuwDewp1S74XvbODsrcrljC6lAymI8HnyioFsM0B3yNW/DzoqESancq/+PBgeWTXR
         O3cg+6jmtcIuwc7hNvjb8PPH3rS+a2T035CbzOjtW/m/WvUvMqlr55hB3YcdFIy6m3kq
         RV2VrzmpA18ZZiVuQoVkDzC6SIfF9L3VTjovrOxYe6eTasWZLS8MVnRF3tLD1o3Je3Ry
         4geA==
X-Forwarded-Encrypted: i=1; AJvYcCUJJlVhGxszwIoiAf987OKxRQnV4se1/6cn7rwhs2jAtl+Pr9mvAHBvgFZ0vnHZ8FA9Yxly1Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFJBJBhicqNCUGwXX8mqyjwllQ0xDMmNF/a4v9mUZPd9yQkBx
	JVzaoY8KOkLHUL5464mHUdbacIKRoVhPF1Z+jV7VOf0JdtyvDqHbDJa6piXZ90TrhU8bXDjm1nE
	AOS8U+o5quTW+Hw==
X-Google-Smtp-Source: AGHT+IHhvW/HJ+WFRTIP3djHr5JY6a9PUVyTXUCz2UuLXkZqK036rLoBrw97ynxE2z+jwAOu7bQCs2Ts8LVv7Q==
X-Received: from qkd15.prod.google.com ([2002:a05:620a:a00f:b0:8b2:24a7:8232])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1724:b0:8b2:73f0:bd20 with SMTP id af79cd13be357-8b273f0c191mr484506285a.39.1762767908948;
 Mon, 10 Nov 2025 01:45:08 -0800 (PST)
Date: Mon, 10 Nov 2025 09:44:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110094505.3335073-1-edumazet@google.com>
Subject: [PATCH net-next 00/10] net_sched: speedup qdisc dequeue
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid up to two cache line misses in qdisc dequeue() to fetch
skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.

Idea is to cache gso_segs at enqueue time before spinlock is
acquired, in the first skb cache line, where we already
have qdisc_skb_cb(skb)->pkt_len.

This series gives a 8 % improvement in a TX intensive workload.

(120 Mpps -> 130 Mpps on a Turin host, IDPF with 32 TX queues)

Eric Dumazet (10):
  net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
  net: init shinfo->gso_segs from qdisc_pkt_len_init()
  net_sched: initialize qdisc_skb_cb(skb)->pkt_segs in
    qdisc_pkt_len_init()
  net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
  net_sched: cake: use qdisc_pkt_segs()
  net_sched: add Qdisc_read_mostly and Qdisc_write groups
  net_sched: sch_fq: move qdisc_bstats_update() to fq_dequeue_skb()
  net_sched: sch_fq: prefetch one skb ahead in dequeue()
  net: prefech skb->priority in __dev_xmit_skb()
  net: annotate a data-race in __dev_xmit_skb()

 include/net/sch_generic.h | 60 ++++++++++++++++++++++++---------------
 net/core/dev.c            | 23 ++++++++++-----
 net/sched/act_ct.c        |  8 +++---
 net/sched/cls_api.c       |  6 ++--
 net/sched/cls_flower.c    |  2 +-
 net/sched/sch_cake.c      | 13 +++------
 net/sched/sch_dualpi2.c   |  1 +
 net/sched/sch_fq.c        |  9 ++++--
 net/sched/sch_netem.c     |  1 +
 net/sched/sch_qfq.c       |  2 +-
 net/sched/sch_taprio.c    |  1 +
 net/sched/sch_tbf.c       |  1 +
 12 files changed, 76 insertions(+), 51 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog


