Return-Path: <netdev+bounces-195485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D00AD0706
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6C17B72C
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F4289820;
	Fri,  6 Jun 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhjmohV0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0E2882A8
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749228692; cv=none; b=DrlPjRqp7S0+V+4vgqc6Z51kpYOs/DJXd9WiHlvp8C4l0KeUKGGI50VyDdcnG4G8msXuZl7PENI64Iho2vilul9bl6Ff49TKFM2AI3fJqTtAXboZuTVQmiTZlXC/tj+UfDBQnaOEWSmWYKerB7EhD/mJtX0Y9gSP1gWU7BM1Txc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749228692; c=relaxed/simple;
	bh=Y21lMjJDigGVFVfJOQIkH71KMk6waDoKjLfQQjfaGDA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qctdgg8CV/VgdvFDueWu/CC0/dGyqkZk8+rf+q+S+hZ8hZOMv5QcLzCALlrPPnd++8LciRta/fBsnQdw+AEvl9vPycA1wEdHStRJPWojGf+aMs1l4CwNhQMSlUZnzuHCMxN5Vw7j6KduzYIcpcbkW7oROxtoZMJ6NtV65EB7uFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhjmohV0; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7ceb5b5140eso422275985a.2
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749228689; x=1749833489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tWL2EOOX20dV8pCuhscba6Nsz1aYwCx65sZmPVK7JDI=;
        b=nhjmohV0CbsJjXRzN4nZGUV2Ug/qo9BDE6XSKCuBDOt8xOWUJSByrWqJAWrLH3mN+I
         22y71CWgJAeBYJ9Ta5kP3fK/j9tL26fwv33kp4axjbfzZ+8Ymy//YIH/5HegZ6h3CeHo
         J8Zz9qc20dRiZT9I1TtGryI8LRn2v3mrcMUrqUdfPUt4MKjl/cmY8I1Ttpd4lFg0s1+M
         FFz0echMDKtDZOzcd0eB/YHanBusyhqjcZnVFhol+ry+SEuNIg7Krq90SnsakVcpDlrn
         GhTzjrUxYRs3pIS2GBK9eE1pHx/dZbQ5kvQRj45M0VfzHkxlVmWaZ4wIk/BERY+bTzIB
         7BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749228689; x=1749833489;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWL2EOOX20dV8pCuhscba6Nsz1aYwCx65sZmPVK7JDI=;
        b=Z/QFtXJ5IlxdNT6rU3kZuU8Q1Y1q1eXw7XhpwP28szNtugsB+nYmDmYuOjwslTQ1hK
         q6xrNl1l/Hj0ZDdLw430UmgRUbm6IuWfUrv/lojK4B37Rw6H/cIoeAL0DSchMdZjDh1p
         Vt3c/n5hKvmlMN6TNaWxC62+H0Zhy46TYUXGr5e4vA+mpPZs3D+RZPwuXSvIudEgUuWF
         NLn7pms4T+oCa+PSbfcS2FOEg3CssKTugOd0hxUteFn6y+kcCfOtwPI+vHwlJ0+wWPS5
         OTl5jKlEjB16dIG3kLUqDg6Z5FMjUDEkE31EYJVLtBQFN51Y4+qOOEdpNF2orP/vi/V+
         vIiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7qGEKnTy5WMMFpy06kAxWLryfVayXEYPzhHyzvZNzhzh9bWT8Vl8K/GRIDDdaBhkY3IddbmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71OqeqSaat5i6AEd6JcQ1C1KwAeGNi1iGnv/S+d7gnq2e2ny2
	I/A2WphEuQKvwZwOSOQQrInTN0cly1v2o8lj/UN0ELkjmX0HkBEH9wOoivwefS6OYvSm49ZoTJx
	iGywYS+JK9eJQhw==
X-Google-Smtp-Source: AGHT+IF5d1lMtADXCWGrkEXmH9sKp6C+WJUdKZNWnk5j/XgtyzUBsForRGtB0HRMpizeeIklLzWCx6B5gBZ99Q==
X-Received: from qknvm4.prod.google.com ([2002:a05:620a:7184:b0:7ce:be7e:bd83])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4494:b0:7d0:97b1:bfa with SMTP id af79cd13be357-7d229851bdemr630860585a.8.1749228689451;
 Fri, 06 Jun 2025 09:51:29 -0700 (PDT)
Date: Fri,  6 Jun 2025 16:51:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250606165127.3629486-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_sfq: fix a potential crash on gso_skb handling
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Content-Type: text/plain; charset="UTF-8"

SFQ has an assumption of always being able to queue at least one packet.

However, after the blamed commit, sch->q.len can be inflated by packets
in sch->gso_skb, and an enqueue() on an empty SFQ qdisc can be followed
by an immediate drop.

Fix sfq_drop() to properly clear q->tail in this situation.

Tested:

ip netns add lb
ip link add dev to-lb type veth peer name in-lb netns lb
ethtool -K to-lb tso off                 # force qdisc to requeue gso_skb
ip netns exec lb ethtool -K in-lb gro on # enable NAPI
ip link set dev to-lb up
ip -netns lb link set dev in-lb up
ip addr add dev to-lb 192.168.20.1/24
ip -netns lb addr add dev in-lb 192.168.20.2/24
tc qdisc replace dev to-lb root sfq limit 100

ip netns exec lb netserver

netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &

Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/netdev/9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_sfq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index b912ad99aa15d95b297fb28d0fd0baa9c21ab5cd..77fa02f2bfcd56a36815199aa2e7987943ea226f 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		/* It is difficult to believe, but ALL THE SLOTS HAVE LENGTH 1. */
 		x = q->tail->next;
 		slot = &q->slots[x];
-		q->tail->next = slot->next;
+		if (slot->next == x)
+			q->tail = NULL; /* no more active slots */
+		else
+			q->tail->next = slot->next;
 		q->ht[slot->hash] = SFQ_EMPTY_SLOT;
 		goto drop;
 	}
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


