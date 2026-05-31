Return-Path: <netdev+bounces-293456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAZ3BwhdHGpbNQkAu9opvQ
	(envelope-from <netdev+bounces-293456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:08:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85409617117
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A4BC3003826
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B1390C8B;
	Sun, 31 May 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="XKaIedBg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFB26E706
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780243709; cv=none; b=JfnfdEXIhMM3KeLtll5eaYdPgVIW4ym4ANvSmJNg0r5m/ZMtHnG1SkM3DRhHLI2fp53eioION67lZTgDZYj/XjlbkspxEi3/crWqgXiF18VvrOpxDIudlYq0F6UFZBYxLI2jVR7hkc0SDaqODvBgdIrB+utyjJrC3cELDvX5ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780243709; c=relaxed/simple;
	bh=NZAk/NQffnhKvUzHdC/M3HmCJBR2dhcZ3rt40bHMxcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BLrlAupJK8zXi+phY6Xicy8NAZcLfsRIv89p4jSsfusjEyUgFr15EQomOyCmHBIKYuBZuDThcUtMUn8X3a9TuxKAu4sxeTz9S0BgyS5G10g4SwCLH3o3Enb6eqBpBWlqgMI0PJfDKH+w/BRTv95CGEepNKcV7edcwPGSJaUQrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=XKaIedBg; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-914cf9248ceso681567985a.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780243707; x=1780848507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2rM08K6wlvMUSf0iG62AiOoujitM782b+cZ3eygLYw=;
        b=XKaIedBgwGQYx+hkqo20n6QVgyeJC2BY1BCVVXri1rghn4cEFV8ZCQqaOKSL62ctqO
         G5Qk1B7YJTIH5rAHpB8W9wmpwlrCl7C5j2MrC1HuGWJ4ZLvJXdMzk1kl4/jlY42DBU2I
         Slr9v1ir9fQNL2h1U2w8IvvsJyH78taOUJnIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780243707; x=1780848507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2rM08K6wlvMUSf0iG62AiOoujitM782b+cZ3eygLYw=;
        b=Iy29O9/c1FoxpaqXZazdhQpbH3Km0U5c7oj6tti+iF1vdZE3gQeZ7M8Pvmru34REzR
         PHy09CYyWOhCFTOw/cUAq1cwhEluqiLfl/jODnKB2aMGLCI4vhGoLRzePI58uQ2w04jX
         SUSENrYqDDeU1zm32/njoBmzvCFpRXObtpcms0hi3JGsu7Po2ahaQ8Cua7DEGMqHBG7B
         Bvuc3vL0GymJl6vvyxB3JEjUhs8BG/w2oxeKOX7RxGNORiJQy5X6VyvWLil3xN1OSFrk
         JeEETeNY/kp0y7wUqZSiZf3dS4vA+axIyFQl1u5skM/xLxsmghnOk3FcicbAAqvLAcwN
         s4dw==
X-Gm-Message-State: AOJu0YzU+uQYxqMfeDOIj7vE5ME2B9tZIL1QLufI67paSdbL/E5kz/jw
	t+BeouXcHDe6INLewCl5gqzhSUE1IpprLjIit8g1/KrSv8KjmCwBfmo8EOvrZvx70kMaCyFjOI9
	uuAX63g==
X-Gm-Gg: Acq92OGSMlD0w9hJ+H1aj4Cnuvs0USM66PqdLqn6NgGUnMokCEyEUEJoG2qJY/QphfJ
	5ubF3MOLl6qNUrbmJDX+vnQZD9SSxlzM0a0qyD1OX3lGcjAOBx0ZZOGBI7zRRaX104CIuqtYPjM
	R3HcsQbZCjmHugfYUnLQyLU0La8h8DZEf6IAdSW4o4xkPxljUfZKufCk+A/fuz8f+ti7Mi8SpZt
	L/j9/NpGTp3vTAOwOPrt3vQm8kuxbslnjfIFDxVUWKr5eqqcCFHrHSsYaN1oeFVjOg6b5WHvTgJ
	UJAVq5/z91PoLgqacy/I0yjbj0EB8DaQnvfKaCJkWeXitH02oMCack8jQMR63Zp97AY+Pi9TbCb
	he7amL6G0kj89Odr3LlIdADXl6/AxutjubzYOztbrwiKoX9miqV7ZNJ38zDMEOdl4TkyPkYa9+5
	vYY06cSvpiVV3rsqzMQDF96z7FUqg=
X-Received: by 2002:a05:620a:31a6:b0:914:b225:8c54 with SMTP id af79cd13be357-9153dc9a1f0mr1224464685a.54.1780243706972;
        Sun, 31 May 2026 09:08:26 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153249a5fbsm822157985a.20.2026.05.31.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:08:25 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	kylebot@openai.com,
	jiri@resnulli.us,
	vladbu@nvidia.com,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	syzbot@syzkaller.appspotmail.com
Subject: [PATCH net v2 1/1] net/sched: act_api: use RCU with deferred freeing for action lifecycle
Date: Sun, 31 May 2026 12:08:12 -0400
Message-Id: <20260531160812.68020-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293456-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,openai.com:email,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:dkim]
X-Rspamd-Queue-Id: 85409617117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When NEWTFILTER and DELFILTER are run concurrently it is possible to create a
race with an associated action.

Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:

 0: mutex_lock() <-- holds the idr lock
 0: rcu_read_lock()
 0: p = idr_find(idr, index) <-- action p is valid (RCU protects IDR)
 0: mutex_unlock() <-- releases the idr lock
 1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
 1: idr_remove(idr, index) <-- Action removed from IDR
 1: mutex_unlock() <-- mutex released allowing us to delete the action
 1: tcf_action_cleanup(p); kfree(p) <-- Kfrees p immediately, no deferral
 0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to freed memory

This patch fixes the race condition between NEWTFILTER and DELFILTER by
adding struct rcu_head to tc_action used in the deferral and introducing a
call_rcu() in the delete path to defer the final kfree().

Note: this is a revert of commit d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
but also modernization/simplification to directly use kfree_rcu().

Let's illustrate the new restored code path:

 0: rcu_read_lock()
 1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
 1: idr_remove(idr, index)
 1: mutex_unlock()
 1: call_rcu(&p->tcfa_rcu, tcf_action_rcu_free) <-- defer kfree after grace period
 0: p = idr_find(idr, index)
 0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- fails, refcnt already 0
 1: rcu_read_unlock() <-- release so freeing can run after grace period

After CPU1 calls idr_remove(), the object is no longer reachable through the IDR.
CPU0's subsequent idr_find() will return NULL, and even if it still held a
stale pointer, the immediate kfree() is now deferred until after the RCU grace
period, so no UAF can occur.

Fixes: d7fb60b9cafb ("net_sched: get rid of tcfa_rcu")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1->v2
1) syzbot ci found revealed that the cleanup code could be called under
   softirq/atomic context. Because tcf_action_cleanup() calls  __tcf_chain_put()
   which grabs a mutex (which can sleep). Fix is to move tcf_action_cleanup()
   to be invoked before call to rcu.
2) And while looking closely i noticed a bad comment on action code which
   claims that "actions are always connected to filters" ;-> Tracing back
   on git i noticed that infact we did have exactly this new change circa 2017
   that was erronously removed by commit d7fb60b9cafb. Well, at least I
   am certain what the "Fixes" tag should be now ;->
3) Patch is much much simpler now than it was in v1
---
 include/net/act_api.h | 1 +
 net/sched/act_api.c   | 7 +------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index d11b79107930..fd2967ee08f7 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -45,6 +45,7 @@ struct tc_action {
 	struct tc_cookie	__rcu *user_cookie;
 	struct tcf_chain	__rcu *goto_chain;
 	u32			tcfa_flags;
+	struct rcu_head         tcfa_rcu;
 	u8			hw_stats;
 	u8			used_hw_stats;
 	bool			used_hw_stats_valid;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 332fd9695e54..04ea11c90e03 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -112,11 +112,6 @@ struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 }
 EXPORT_SYMBOL(tcf_action_set_ctrlact);
 
-/* XXX: For standalone actions, we don't need a RCU grace period either, because
- * actions are always connected to filters and filters are already destroyed in
- * RCU callbacks, so after a RCU grace period actions are already disconnected
- * from filters. Readers later can not find us.
- */
 static void free_tcf(struct tc_action *p)
 {
 	struct tcf_chain *chain = rcu_dereference_protected(p->goto_chain, 1);
@@ -129,7 +124,7 @@ static void free_tcf(struct tc_action *p)
 	if (chain)
 		tcf_chain_put_by_act(chain);
 
-	kfree(p);
+	kfree_rcu(p, tcfa_rcu);
 }
 
 static void offload_action_hw_count_set(struct tc_action *act,
-- 
2.34.1


