Return-Path: <netdev+bounces-230501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8CBE95A2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25EB5661D8
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DE3370F8;
	Fri, 17 Oct 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6+2aGo/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5043370F6
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712818; cv=none; b=k7ns5sElfWl1SWiuGlTTIiVNqGMJh+QHFPbS0uLFbvDZ0gOE8PpVj1lsI/5tRHNzbXen1MtpeO7OqzFXNiDE0AEHqrjYtqnTpGBfrZ8uFKqqGOZdVmAZPmBcZK6YftbB/D2apy9LrQH5pN/hwwzkzN+9PlKYERZxSM9mekjT69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712818; c=relaxed/simple;
	bh=GLdvcB53I6QSHtII7wQc2vFdNrJRFtvIdxxMp8SWWro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TUiUevSk120ARGPDCEvkK3Tim/H77592QSd1On5d7Ppn1x1p1LLrg7YE58PXA+lTnZ4ohwBpJb9kJ2gIRUtsxlRcTy5PntFA9Stjc3ZGWOT1Q5CfiY7Xjpe3JeWcV3DZVJAXh5lcOoetPbOXerNHEwXCb5Of4YwcQfBCHRJPkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6+2aGo/; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8900dedd50aso299870885a.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760712816; x=1761317616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V18M6uFTXp6FNGRgm01bh+NPJo/gRE377qY3psDIoK8=;
        b=o6+2aGo/7FyAwG8xEQTLRJCnqtCi4p6zljywTJs9A1ferh+lhG5PMtsJTEup/pg/Nv
         nRIK1UxJ5zwhgrrKW3a7A4Iy4LqcUMg4CapYa/n2LUgnfBRDBlEn4wpparj17A8dg7nw
         belVOCocwywdVsxtB0dGvRChH2Z7GcqG7Cfuk08gT8duofakn34OsRv+vBJ2VLxuvcbU
         T50lVVQ/nJFHJfW+RtwMArCoPsXWdYKVdgNC226kDCoGNW4ILz+VghYVtHf+rloa4thD
         KsCDLn8eITeZK7jMOznVAQvJiH0Onps5cc8/1FXv0lR/FmOXGeAGMOMUSyMYqKY9NMKD
         xaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712816; x=1761317616;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V18M6uFTXp6FNGRgm01bh+NPJo/gRE377qY3psDIoK8=;
        b=RD2LAA3iWoZXC8oSrKuDoJThNimNMo3IGH4M4vKvSS/c4dwosWgrE8bqtOV2fjsV6N
         49vCFNybjtA2xAhGdwtklayXlsYRHm/4xb2yuU/bICGO6W08XD48gRPZawtwK1Ed4F+J
         93tc3G+j/cA142/Gcbm+vDrN536YnHYsC8jvcnr+h2u9q5Vau7rpfT+k+dViZM6tDPO6
         ESLpfHwGkcKIp0WJtEE65EdZNv1IcwKHwqZyru6lyeHr+8nrcM4TGqEfdBtd82lR7i9Y
         EmhpVdrTdI6G9c7pbI61K8C97TGEcdnrCOCToSYJOA9GCDZJprNSc2CiurXVWGAODjqx
         8dkg==
X-Forwarded-Encrypted: i=1; AJvYcCUht1/X23eC07SSMV9ET7WfgEZdOTf2Xb0nW6nI72zvlsU8Jo1uQVk3QtoIiOXqJWwyqultTV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxotXVNk9ZvD4NTvWBEjUeu2PPKRe9w9sLSaWq7q0KJ7Vz2m2wY
	7mSxvU/9QLh4sJaoUzEGs7ZOq/dqEYm0k3THK85aKrH9yiQrKEU3apYvjLXn0wvD4fVVfM4TR5w
	51gK6WdrTLA5cpA==
X-Google-Smtp-Source: AGHT+IFHOCsSWUOyj/YwvlWXgiohjOU82kWuv+Ubs5fZnjPaa7tnY2PfB/P9v36t3SFlgSQSCQSh3ZGpoBi0pQ==
X-Received: from qtbki17.prod.google.com ([2002:a05:622a:7711:b0:4e8:aa77:8b08])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:64f:b0:4e7:2d8b:ce5f with SMTP id d75a77b69052e-4e89d2cc403mr61424051cf.36.1760712815637;
 Fri, 17 Oct 2025 07:53:35 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:53:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017145334.3016097-1-edumazet@google.com>
Subject: [PATCH net-next] net: add a fast path in __netif_schedule()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Cpus serving NIC interrupts and specifically TX completions are often
trapped in also restarting a busy qdisc (because qdisc was stopped by BQL
or the driver's own flow control).

When they call netdev_tx_completed_queue() or netif_tx_wake_queue(),
they call __netif_schedule() so that the queue can be run
later from net_tx_action() (involving NET_TX_SOFTIRQ)

Quite often, by the time the cpu reaches net_tx_action(), another cpu
grabbed the qdisc spinlock from __dev_xmit_skb(), and we spend too much
time spinning on this lock.

We can detect in __netif_schedule() if a cpu is already at a specific
point in __dev_xmit_skb() where we have the guarantee the queue will
be run.

This patch gives a 13 % increase of throughput on an IDPF NIC (200Gbit),
32 TX qeues, sending UDP packets of 120 bytes.

This also helps __qdisc_run() to not force a NET_TX_SOFTIRQ
if another thread is waiting in __dev_xmit_skb()

Before:

sar -n DEV 5 5|grep eth1|grep Average
Average:         eth1   1496.44 52191462.56    210.00 13369396.90      0.00      0.00      0.00     54.76

After:

sar -n DEV 5 5|grep eth1|grep Average
Average:         eth1   1457.88 59363099.96    205.08 15206384.35      0.00      0.00      0.00     62.29

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 821e7c718924405d0a7c10e41f677b98aa2d070b..9482b905c66a53501ad3b737ad4461533b9e7a4e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3373,6 +3373,13 @@ static void __netif_reschedule(struct Qdisc *q)
 
 void __netif_schedule(struct Qdisc *q)
 {
+	/* If q->defer_list is not empty, at least one thread is
+	 * in __dev_xmit_skb() before llist_del_all(&q->defer_list).
+	 * This thread will attempt to run the queue.
+	 */
+	if (!llist_empty(&q->defer_list))
+		return;
+
 	if (!test_and_set_bit(__QDISC_STATE_SCHED, &q->state))
 		__netif_reschedule(q);
 }
-- 
2.51.0.858.gf9c4a03a3a-goog


