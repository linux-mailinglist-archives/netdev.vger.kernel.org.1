Return-Path: <netdev+bounces-225805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96A3B98885
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD274A6AC3
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13830274FE8;
	Wed, 24 Sep 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohyQTZ3q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1443AA4
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698834; cv=none; b=uTpYJb55HMO8achJyvxJtIbYeD+rs/7+HAN58Y9xxojdHVWabplgQCyhIbzip36p6iBZwOoF64WXzTIFx+0GnxiXpHGTkfv8F7gLxhR9ZgxE4Ow5YicVG1uCi8Fz12/rv4D2yG/W/5WcPaNNBjhjX/9AenIGGzDLtMxk6jsuQWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698834; c=relaxed/simple;
	bh=YNphk3mB4ivfNu3QKEs10XGiMwMxpi1YPo4dtv7YWgw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WqvXlFSdr0vcBMtfKaBx7bvdJqDOovkZOakfPDTyZsoepUtqMl91gKSnAgiiVmg7XDgVzm01E/oTOcnJFa+bVTCTxuOSoY2d7GyPsEWerBbQGOdBdI3xorbqpnKFwrHiY+A36++uYDE39zbg8jk5HiSPRYNfcriQQSFAPuzvOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohyQTZ3q; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8589058c59bso43023585a.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758698831; x=1759303631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6K5fm+QUCrwoVlxEjRVdfqv7MdLli6zI+B4E/bRgTXA=;
        b=ohyQTZ3q2fraYCAMhNK3QabeQtpo8SHjb+wiVksTOG3j+P6RcrUpKXRP+OeQj9Axf1
         E9mUrgSV2BGuoMtP3N+wOLqX9rMJDMOBAzivKwZ+q1cdqniESFmbLVKXKiKdva90nq9w
         lcqyzBtBfqKyvLogZ6Af925AgM2IHhYPu0j3PGccqVGhG6zywo1QOGRjv/LmyAt5H7g5
         NBlmPDpn8ue9R8qf6Z2W+Lxx/fr3NNZL+0YbWGxGQIJ8tuPbRgxxt8AUCb866gJOie3D
         PgJpzzpHUYlnY1QHzvrOunkbQjvFasE3ZFeD8uQ5awquqYKiCQfACn40lD0PBb3uxYp4
         2B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698831; x=1759303631;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K5fm+QUCrwoVlxEjRVdfqv7MdLli6zI+B4E/bRgTXA=;
        b=UgY7Gfdyo/7Vz0lEMvO8FGLDHD2julzH7NQx81/9Ly04BTNhTotZpVNNmWfBvQluyg
         DoWZlymuPlxTGyQ9TZ/SFGpx7v2T6kgZ7pKXNuJSsc2vA86I6rNRXXwQ7Gv9wprQstC4
         jK4uEvAhohLYZgLV1yctTwXTfb//E0Uhz3v0dEqgncvjjF8k0hN6Q3hzCqgLhHgp9zwG
         4WohdfUiH3coCPubLpYJYtVwXHd2quzNsF19E7VfOe+XpdofPmT2DEGq07B4noXO+jBT
         xN0ZpX/grNTYZg4kwUdJJsxAUh6TqtclPLR5+5YfWYwwjnFyPDAaV9Dl2SZQU1PVDjIn
         CBjA==
X-Gm-Message-State: AOJu0Yzy7+y0P6kuOFhbDEi9mq8ALnDuWcZEvfeSgd15YxAfo1Uao64q
	88fsWtixI67tiNX6D8GRWnhZbPCb6gp9uVsN0wIJJvbABgBbFwL7U/8BzQPiHa3de5zlVhqiwX3
	KIb/dGqGPk5m/nA==
X-Google-Smtp-Source: AGHT+IHbInjHcu8+g2yR5s/vHlw8EvDs5k3IxMOhdo2jXUPw2zbEl2OhrziWz6q5iYS5mQWH4t6sJSc2lQWqVA==
X-Received: from qknqj10.prod.google.com ([2002:a05:620a:880a:b0:84f:d9a2:d24d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4627:b0:84d:9f49:6898 with SMTP id af79cd13be357-85173700769mr688877485a.61.1758698831223;
 Wed, 24 Sep 2025 00:27:11 -0700 (PDT)
Date: Wed, 24 Sep 2025 07:27:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924072709.2891285-1-edumazet@google.com>
Subject: [PATCH nf] netfilter: nf_conntrack: do not skip entries in /proc/net/nf_conntrack
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ct_seq_show() has an opportunistic garbage collector :

if (nf_ct_should_gc(ct)) {
    nf_ct_kill(ct);
    goto release;
}

So if one nf_conn is killed there, next time ct_get_next() runs,
we skip the following item in the bucket, even if it should have
been displayed if gc did not take place.

We can decrement st->skip_elems to tell ct_get_next() one of the items
was removed from the chain.

Fixes: 58e207e4983d ("netfilter: evict stale entries when user reads /proc/net/nf_conntrack")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netfilter/nf_conntrack_standalone.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 1f14ef0436c65fccc8e64956a105d5473e21b55e..708b79380f047f32aa8e6047c52c807b4019f2b9 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -317,6 +317,9 @@ static int ct_seq_show(struct seq_file *s, void *v)
 	smp_acquire__after_ctrl_dep();
 
 	if (nf_ct_should_gc(ct)) {
+		struct ct_iter_state *st = s->private;
+
+		st->skip_elems--;
 		nf_ct_kill(ct);
 		goto release;
 	}
-- 
2.51.0.534.gc79095c0ca-goog


