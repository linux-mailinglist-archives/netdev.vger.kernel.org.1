Return-Path: <netdev+bounces-237975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBEC5257C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B15188FEED
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD63002D4;
	Wed, 12 Nov 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBqw4pgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA63358CE
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952130; cv=none; b=dXk+kg9ggGXB6HybJdglFKkJXPfsrfJbLPfKerfH0rcPNqeUqsVNVKH+msZHfVPe5E87PQ77i/odWPnf6aK7JEd/eRE6Wtfubr275KJ+Ug4G8nM4Im9xRnzfvnDYPzun5Zm29fKxqb/6wNChjTR8JljJkBX4FzdoKwNy83Jk4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952130; c=relaxed/simple;
	bh=wl6Xo0IXSzmb0uTVxkVrEryJxhav9P1MiVf1FF2pDsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HdN/gi2w41nybK7wmYX280ad2+gtYW3aWlTBw0KSJgPj0+ROOZQN1P3TLtnGww/WCDmRhCEylqQ2voT+iJpeyb+6Ax+fopPx08zzYYWizIFeH2Tm/odiLjsaFLCCPk+CwaIN4PqGF42gw8wHHckxK1MjxybeFnB4NnjAgoZJM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBqw4pgo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7868561eb2dso10160637b3.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762952127; x=1763556927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1VGJUzn5WtQBVoTTrQyM2FX5ydLOnFLFtVi21N9cUAY=;
        b=HBqw4pgobZwj+V0UGfwqcjoY609yUgTZZ7Q0/3yC4pOZGfMkJBQ872wbJKbVmUuZnn
         Mxdx6S8dIuzoTKXXfp3FVdCD7fQpOnaUcRQ/ITEBWc8LUxGC87DaTyiMSLNnXg6WN1na
         sdcD4felEuEVxkYAEpTBdAEOBOpPHHmGckCiNlYrnkBMQ/mAf/JU1KKXtgfWoZMU+iRC
         i+UD7hnJgpABsHhzYO73NLQal4dgU1/7B8RdTboVCIwnxqpoqjzera3XKaDKq2J7v3ZO
         1O8D86cJs4tF3fIsMbnuZTDlupUQ8pObkLMXlBrbkGrXWmSpg+DlJcU1TLhHm4T8pwZT
         x1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952127; x=1763556927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VGJUzn5WtQBVoTTrQyM2FX5ydLOnFLFtVi21N9cUAY=;
        b=fErM4Anvc16bpBzB7YwoC3L/WxzjjZU6INsSbz1Jyfy/UPGhjr5vrhJqNh+vRB1vRZ
         r/6bxZf22SfEVqzO3/nvxUbtqAAJcsyWrH6f2vfhx71tn0aQKVNEnLjUnHY5JO1cOoCU
         kwfUSfLiLU75rROjnB+8JkUJcZjDAhgDZM+4CWq8u+ThPR9yxUjlCf295+UXzlAJonMm
         /yNo70LlJSyxfcukDjFMLlxA9G/j6hr6xY7ffUSO+XUhfkXnuasn85zhOhThuRkIqJGD
         iqiii/T0PYeb+f7rXyEFZCInyL2iUXUGVetxODjlC5i/urH3iuB/h/pytLKbPcIZz90W
         1m2Q==
X-Gm-Message-State: AOJu0YxcdXJv0dzyR8A7SWAECb2DYN9qNeLPpd2koiR6HMUupcRqCKUS
	IygZ5hqZbQMUQMYVRVj6023ekg7E2bgec7MyuUt4vbh/ChXssFpWYa08b8E3xvjrQg5YP6E1MQa
	j/wX0QDOZb699Mw==
X-Google-Smtp-Source: AGHT+IFKfHvm1zPt56Z+EIU7I8V5Sxnqk8D6FIACRhXohV4MLib7Je6Hv9q4Dbu8q6IiXFWl/QnGz62pdOGScQ==
X-Received: from ywll26.prod.google.com ([2002:a05:690c:a1da:b0:787:ce47:7423])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:9692:b0:787:f043:1eed with SMTP id 00721157ae682-788136e4a15mr20671387b3.53.1762952126885;
 Wed, 12 Nov 2025 04:55:26 -0800 (PST)
Date: Wed, 12 Nov 2025 12:55:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112125516.1563021-1-edumazet@google.com>
Subject: [PATCH net/bpf] bpf: add bpf_prog_run_data_pointers()
From: Eric Dumazet <edumazet@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Paul Blakey <paulb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found that cls_bpf_classify() is able to change
tc_skb_cb(skb)->drop_reason triggering a warning in sk_skb_reason_drop().

WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214

struct tc_skb_cb has been added in commit ec624fe740b4 ("net/sched:
Extend qdisc control block with tc control block"), which added a wrong
interaction with db58ba459202 ("bpf: wire in data and data_end for
cls_act_bpf").

drop_reason was added later.

Add bpf_prog_run_data_pointers() helper to save/restore the net_sched
storage colliding with BPF data_meta/data_end.

Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc control block")
Reported-by: syzbot <syzkaller@googlegroups.com>
Closes: https://lore.kernel.org/netdev/6913437c.a70a0220.22f260.013b.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Paul Blakey <paulb@nvidia.com>
---
 include/linux/filter.h | 20 ++++++++++++++++++++
 net/sched/act_bpf.c    |  7 +++----
 net/sched/cls_bpf.c    |  6 ++----
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a3e5fa5111b60cc291cedd44f096d..973233b82dc1fd422f26ac221eeb46c66c47767a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -901,6 +901,26 @@ static inline void bpf_compute_data_pointers(struct sk_buff *skb)
 	cb->data_end  = skb->data + skb_headlen(skb);
 }
 
+static inline int bpf_prog_run_data_pointers(
+	const struct bpf_prog *prog,
+	struct sk_buff *skb)
+{
+	struct bpf_skb_data_end *cb = (struct bpf_skb_data_end *)skb->cb;
+	void *save_data_meta, *save_data_end;
+	int res;
+
+	save_data_meta = cb->data_meta;
+	save_data_end = cb->data_end;
+
+	bpf_compute_data_pointers(skb);
+	res = bpf_prog_run(prog, skb);
+
+	cb->data_meta = save_data_meta;
+	cb->data_end = save_data_end;
+
+	return res;
+}
+
 /* Similar to bpf_compute_data_pointers(), except that save orginal
  * data in cb->data and cb->meta_data for restore.
  */
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 396b576390d00aad56bca6a18b7796e5324c0aef..3f5a5dc55c29433525b319f1307725d7feb015c6 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -47,13 +47,12 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 	filter = rcu_dereference(prog->filter);
 	if (at_ingress) {
 		__skb_push(skb, skb->mac_len);
-		bpf_compute_data_pointers(skb);
-		filter_res = bpf_prog_run(filter, skb);
+		filter_res = bpf_prog_run_data_pointers(filter, skb);
 		__skb_pull(skb, skb->mac_len);
 	} else {
-		bpf_compute_data_pointers(skb);
-		filter_res = bpf_prog_run(filter, skb);
+		filter_res = bpf_prog_run_data_pointers(filter, skb);
 	}
+
 	if (unlikely(!skb->tstamp && skb->tstamp_type))
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 7fbe42f0e5c2b7aca0a28c34cd801c3a767c804e..a32754a2658bb7d21e8ceb62c67d6684ed4f9fcc 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -97,12 +97,10 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 		} else if (at_ingress) {
 			/* It is safe to push/pull even if skb_shared() */
 			__skb_push(skb, skb->mac_len);
-			bpf_compute_data_pointers(skb);
-			filter_res = bpf_prog_run(prog->filter, skb);
+			filter_res = bpf_prog_run_data_pointers(prog->filter, skb);
 			__skb_pull(skb, skb->mac_len);
 		} else {
-			bpf_compute_data_pointers(skb);
-			filter_res = bpf_prog_run(prog->filter, skb);
+			filter_res = bpf_prog_run_data_pointers(prog->filter, skb);
 		}
 		if (unlikely(!skb->tstamp && skb->tstamp_type))
 			skb->tstamp_type = SKB_CLOCK_REALTIME;
-- 
2.51.2.1041.gc1ab5b90ca-goog


