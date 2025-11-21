Return-Path: <netdev+bounces-240692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F5C77EB5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 6C3262933E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F333BBDB;
	Fri, 21 Nov 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOnuCchJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF033C532
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713992; cv=none; b=NuOrFkUJ8n4xNqcp/FtdiSVd0Q8gO7vzU3W0/bLt1vDqDFQt+rptpLgeqkxXark5TcWsk0iBKXEGuRVFElK4/nwfIt0f/VK/+63RgyIjwSabbgGZ6LohLzotpGQT7OuoywGqxWCThWkH9o6hzp23TjRI3miGKc5Eh3x++CUeis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713992; c=relaxed/simple;
	bh=3VH05zcRa4HuFxizXHS+a3cxOK13F64Z5QDYEREmRPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPh5EqwvI3pJ/SCGANQ0SDW7S+JXDTv8lL+RwMb5lTxgprJ12ZPNKlarL1rDrFT37ISVvUfQumvV9Lbai4Wddk9jU/kRJKCtJ4d/wFFXeAkgAA499SdtwtUzbUlQY8yBvD2+HjE8j1OddLjmrY2lmIXSnO3CuG6Glvwmg0mSfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOnuCchJ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8804b991a54so71692526d6.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713989; x=1764318789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2hka/+AdBAhXkep3TVAngEU7q9dYpSswZCFnUJHLtg=;
        b=JOnuCchJ6rxOZMDl85kOFZrCRFjYY2OtIGgqmYLPdyjgndQGj6KHmJfjEmhBwbiy8g
         mebU6Ss7pyzPvN/+jXskE3RzZBvnlgp/KIfbyftBpmQYo4gdelYxk2xbRmmORFGomP2R
         ewkCCAiDsYwWhkh1X7qv/0j4YJgnOhbeEFb4p7wSbSi2oecSZMqAweehgoEN2vk/jWx6
         13ee//KacDiIF4DhN/B6FB8yjxsInVE+Jahs+VzsKbXmXAkMXpGUHNAdsK6WR1lSpd0l
         giDgwCbuD5E1eWYVUIHZ93vwDtE/7LmzhJ17nZfUmUgeVbvyM4YPm/RAQvd/eVSqR//T
         94Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713989; x=1764318789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2hka/+AdBAhXkep3TVAngEU7q9dYpSswZCFnUJHLtg=;
        b=ayzzc04OraVlZBAJZKBSig7aNCp64N8tEyMm7tb0KQ79M4CqszOsuUby08IqOIcxcP
         MILwK6KYbU7o9mumYZJtyKKzeSgowHU5bPyQctjAP0dkEqfC/u2w4N63vIfizn6V7Cwy
         dpqKiEzKjtLW1IREPI28ZOnm+LOJcLb1Tu/+rkgV+XTajhTp5JbDP6xEDTkzEPez+28x
         pqfiM+lU6gzZ/rdm+Utld+X+VoQ4WuuJ/Inao22ZjqtSUVWac9YwSI7oBY9YjKfAJkPf
         STjUC93DRQublQS06l2VCI2iPjaiMb6P3ojkT3qEvOZOqqEYtsdBuXQONP3o3kIuDW+G
         pBPA==
X-Forwarded-Encrypted: i=1; AJvYcCXqPpcCO6OHv/JzqudVkUA92J2DElnUo1pT1KRTi2iMziZdRV6Z0awHcQknc0az5QqXrk+Sbhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdC7ZEydANaEj+Iy5oyMJCz51Ql2iZEMFHh6FFQT1vbb0LdFl
	AtuHMDPgN9/7Nj40kWXGwG6k3weIqbM7kk4pgXv7forKPqC+331MbFTO/XhM4XsU3TdooH3TDKh
	OnCTqw1+aOeZKNQ==
X-Google-Smtp-Source: AGHT+IHIEKtE6LwbQXYb3i7e7Q/8WhNNlBYHl1ICUZ6xaWVfiKpXWRhGM6lTr30xOH7nquMr1fw0GvQvPysiuQ==
X-Received: from qvbmf10.prod.google.com ([2002:a05:6214:5d8a:b0:882:2f2f:9db])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:19c5:b0:880:4a49:75d0 with SMTP id 6a1803df08f44-8847c3e408fmr18506546d6.0.1763713989102;
 Fri, 21 Nov 2025 00:33:09 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:50 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-9-edumazet@google.com>
Subject: [PATCH v3 net-next 08/14] net_sched: sch_fq: move qdisc_bstats_update()
 to fq_dequeue_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Group together changes to qdisc fields to reduce chances of false sharing
if another cpu attempts to acquire the qdisc spinlock.

  qdisc_qstats_backlog_dec(sch, skb);
  sch->q.qlen--;
  qdisc_bstats_update(sch, skb);

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index fee922da2f99c0c7ac6d86569cf3bbce47898951..0b0ca1aa9251f959e87dd5dc504fbe0f4cbc75eb 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -497,6 +497,7 @@ static void fq_dequeue_skb(struct Qdisc *sch, struct fq_flow *flow,
 	skb_mark_not_on_list(skb);
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
+	qdisc_bstats_update(sch, skb);
 }
 
 static void flow_queue_add(struct fq_flow *flow, struct sk_buff *skb)
@@ -776,7 +777,6 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		f->time_next_packet = now + len;
 	}
 out:
-	qdisc_bstats_update(sch, skb);
 	return skb;
 }
 
-- 
2.52.0.460.gd25c4c69ec-goog


