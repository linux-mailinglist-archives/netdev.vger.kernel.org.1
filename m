Return-Path: <netdev+bounces-302703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDkEKzeWQmrK+AkAu9opvQ
	(envelope-from <netdev+bounces-302703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:58:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E7D6DD070
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:58:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Serf3lh9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302703-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302703-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A71630086BB
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1037C108;
	Mon, 29 Jun 2026 15:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF603B3884
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 15:41:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747686; cv=none; b=CZGTrw5Uja3Skw6/Hn91kjG7pzR6ZdSWGJt/Owhl8PC+Mbj8qcqHGIVlqaX4M0BuMFc64NbmsjmLvqotxZJrIFwdgR1pVE8QNeP3mL7KeB28HanVukn6rH6fBkOzeZQyF0BHcooa5yF3c43/uKhF7CfDkwh0NZRox4J7R6IOmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747686; c=relaxed/simple;
	bh=Dkt4xyF9DYeMcPtu8Ou/ovRcY3msWhNc1z9UbNdyt48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABrtOlm3dG1R8qnjIG7/SQ7yJERY5i880RQmrAYR9MiHJ622kzybQa1xA492hWxrPP/JAYip7vKX6CQAEWkzJuOhC9n+QjOdDXeeqvkyQTdummOeFaO3DpOE6GKcpPE8vwAErWMPnREGRFAaq2mkznETIUI6uXDJAXjA5P4qi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Serf3lh9; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9e8a1d256so13698955ad.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782747684; x=1783352484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YIeSNB3QalYM3yBkSuJQ+f9h4G1uu1ooOSnkLkitYM=;
        b=Serf3lh9RB79Iy7hxZmlXGxKsFKH0fnigf1JBqGEAWPfaK20UCoZP9mY5LuttX2bS4
         R+B50Au7V32dPlTdKs8uMBAWg0nC5De2Kt2+HIKPsdPTCGhwb8zr9p8do7xtmp+XzsJ8
         lZVu6qkEPRDpmZt+HgzP6QEbg4T4IxdyrVnGfvYcirAaU447HpC5amzqk9JvqAJ5TxlS
         aX7/bq9AR4KG9g3wKFwiJLzPpgKp1kqpEN2fPqMksZZU7Nf1qDDBekzs6DBykfjNrhIx
         HlpXYmiYbXx1Dv/HQnxHwSRfo8dHKmpT/8ijF+ZnDubwRY5AI5mLmYPpdnVFbqSiz5zD
         tCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747684; x=1783352484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YIeSNB3QalYM3yBkSuJQ+f9h4G1uu1ooOSnkLkitYM=;
        b=dMONjE2M5VB5B0FOKS/k53TlkKtNxSewDIdb1oANyoqur0l8WRQUZn5QPKbS7FmuoU
         2aVTTOGCI2ai3zRM22vmHBnbYOEycRONBFeBbgkkONCuEJC6sbFjm2ogNsy5uZ7ZaQ3n
         +jT0OZLoRC+liSIK5Y4tBbdnT3Gh7TaiyTVFFy1a9GvdjwYuwSJG+agLVDVgA/i+WVay
         Dn/fOLZsqlbSl2SlxU4twQU7/lxQ+pBuhUgem/iGs0TIKl6yMgn7A/rHIqxidNASBbuM
         JnoALNrFmIQeaM5gxMiOd61Ma0DNh6fCITi5ZXFscRLfIc7bjy7Yl/A0HJFnTzLJpAw+
         LnTA==
X-Forwarded-Encrypted: i=1; AHgh+RpAtPZh85UC0FNpdoeszPCaCJkvolTr/y+jHTbtmZjsLYAPQCc24CqwV4F75yuRQEO5XZC6Fwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fr9ScX3Ma4jjomXxXH5AR8WFTH8MJBKzLgespacjmFtC5Rfu
	aIeZZVNy42eiq5biY0ZDukmW2wp6KvnKTQWUuwdZlJ3AUwx0Ax3KVVRM190dPw==
X-Gm-Gg: AfdE7cm62vSGhed7tZ3/B29rfCe3asOi7wUC8NyLMs+0MNZ02FiavSuO0lLlrP/eRj+
	5OK/RS64I/PQn8IpqEz+Yz6amdD4+U26xO92q4N6PK1ituKmtQ8TKMCkT5bDAQQFLST/rKHLfmd
	uiFaEZmsL3wSuVJvI0/psrkZzb+Cfbz6/YHO1ze9p7L91+/2DqN15i2lxFzNLmGkHcva9lXY0AR
	18jPLmgVCra+CsSp+UmoPvghG09qqeUL5xgb2XNH8VF8eheGSiJe79z2YT02nZZt+G2z0xySeWR
	kfNNHfViyEn66hEhCG22Kbua4MKvYtg/wV5VQ3EDw8LVt93YhZ3Bihf/HTbdZmkSnGn2B2fb9qb
	Ef22h1HT53obyYTsugSNqTFagCVjfosBevdeDyvOdEo4fasbhvNfVSy5+25t5jBC3KxD/wdvkml
	cT/r8j+T9XWMvIinryhmFJuC7l43qn0DSLHOi8Pkw+sYey3bpCAau/qzFyaL5OUw==
X-Received: by 2002:a17:902:e545:b0:2c9:f0c5:98d6 with SMTP id d9443c01a7336-2c9f0c59ccfmr38873085ad.6.1782747683960;
        Mon, 29 Jun 2026 08:41:23 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9d886668esm37040605ad.58.2026.06.29.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:41:23 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: act_bpf: use rcu_dereference_bh() to read the filter
Date: Mon, 29 Jun 2026 15:41:06 +0000
Message-ID: <20260629154112.1164986-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302703-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:andrii@kernel.org,m:martin.lau@linux.dev,m:horms@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8E7D6DD070

tcf_bpf_act() can run from the tc egress path, which holds only
rcu_read_lock_bh(), but reads prog->filter with rcu_dereference() and
trips lockdep:

  WARNING: suspicious RCU usage
  net/sched/act_bpf.c:47 suspicious rcu_dereference_check() usage!
  1 lock held by syz.2.1588/12756:
   #0: (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit net/core/dev.c:4792
   tcf_bpf_act+0x6ae/0x940 net/sched/act_bpf.c:47
   tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
   sch_handle_egress net/core/dev.c:4545 [inline]
   __dev_queue_xmit+0x2185/0x2c00 net/core/dev.c:4808
   packet_sendmsg+0x3dfa/0x5120 net/packet/af_packet.c:3114

The other tc actions and cls_bpf already use rcu_dereference_bh() here.
Do the same.

Fixes: 1f211a1b929c ("net, sched: add clsact qdisc")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/sched/act_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 58a074651176..09d46e195e33 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -44,7 +44,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 	tcf_lastuse_update(&prog->tcf_tm);
 	bstats_update(this_cpu_ptr(prog->common.cpu_bstats), skb);
 
-	filter = rcu_dereference(prog->filter);
+	filter = rcu_dereference_bh(prog->filter);
 	if (at_ingress) {
 		__skb_push(skb, skb->mac_len);
 		filter_res = bpf_prog_run_data_pointers(filter, skb);
-- 
2.43.0


