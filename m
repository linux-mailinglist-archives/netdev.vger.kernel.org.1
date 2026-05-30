Return-Path: <netdev+bounces-293346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGZoIZfQGmqM9AgAu9opvQ
	(envelope-from <netdev+bounces-293346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3B60CAB5
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082DB304A85E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977303ACEEA;
	Sat, 30 May 2026 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="RTL/Hy76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738C3AC0FA
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142128; cv=none; b=FY71rnhXk2Qdgdxjych5U7SHBiWEVv3/Q6KEuudhnQIG15ELZPf/TGNGxJB1hbxCeml0o5jL8HoKVrPmptl2eZ4Z9dI20KKH5jOLDHkW1gItD/gbrMpvKGxtS5ty45KRFfjpue2n76F5Uv/QobTYCnfivu1iKVDN0eYCdbu9dHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142128; c=relaxed/simple;
	bh=j8cQshrqlQFfBIrBBx7EnVSk63H2NPCcqoNVgMFtt5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MoqZwkDphIcBVJCrqUmfWClWycsai/x6ca3fzRIDHqzCEgpEktdrQSdwOc+fYLw0pBkZva1hpCDXEd3EXe3bS8A71YnGMS9/gGa1T5CgDoKtGCDF/vv3oe019b7C/59SqadYVD1KV13Rze1YZcb8x5L17ipCgvshbFfLe3Es1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=RTL/Hy76; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so33500276d6.2
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780142126; x=1780746926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0aHalIWa9LgwPX5NOAnIxiWCrKl/1HF5yowPhKACGc=;
        b=RTL/Hy76XDPjhe9CrkiZQAfSwLztSJ7e1jMC+JP2AhfE0nrdxr51ZuStbB0hfljEo4
         t1sZNMh8EknAtPcVB9qy2/YIXKsShn2VKZ3MIkAm5ba5mrjZCpmuK2MqIzRN6H4dnzKx
         nBtLwOZZSnaf5TMqFpyYo/HIY+HPDXtFt5Xpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780142126; x=1780746926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0aHalIWa9LgwPX5NOAnIxiWCrKl/1HF5yowPhKACGc=;
        b=AZmsSClVtyRinYB7+JkUVePBG2xzXxyC05+QKS7KhXqxUug4eCscs+NeJGepDZG77r
         wXHTHQ+ccJbIjAQ4yDUKKpnEZapacP7mQAmFmf6SQtd25g3gIbFaAkzjC3Nv0sLacy3g
         +BJ/ZoKgVCRK1TWeesXKyCP6iHxu5/HTR6e/UbHb7Ruvn3/8KIbaFUl4uGfmTHkmRdUS
         NzFoZLkIJZKod4CyhHYtrXTlZs3fpEZiSG6tsvHclLlDXrF7f71AsglDhrlVoU7DZFiz
         qWJFmfFvjO+29PSZhlNaTZhkr9rFV10EWlNUcsoK7tK4Uv6um2R3/21PtYuejba+LHU3
         TvCg==
X-Gm-Message-State: AOJu0YzdmZ3WX39j1FzhsMeJSnjclvBCsrCJpgH9rBNs2hhy921DfLYM
	N4cf17l6uS37uIDburJp6V4eBbeU91AlHhSu7mbduoVA6sAQEpecEaFXI2CNdLgzphTJI+OP4Y/
	XML61kQ==
X-Gm-Gg: Acq92OEs2KICnPcIN0XvoSjuXsjRaEhgZa/hkylPRwtF3DFG57jLt6eBi3GxIFjc1dr
	RESq/oUITKBzyl/lLXKSIa9ZnP6HhnPyCrsZUx20O/MJRwhp5SR8suskuY6dfOJuYPZwfTtOigd
	AzRDsHOAzWY02SZ70bEZ81GPRbM4DZCUdy4n+CDQee6OhT/8hlqQW+Nz/NSEEuVOOQSWvEKgDA2
	jFICK7vtcltMfeLqTkoIcWqqzCqIl/h8SAp1CW4Ben5bZ8FcSZERpe/VTwzwYhqmG2YIKSER93/
	D5f8VQF447h3C+ykN5QhJzmOGpkMN4GU8dugcYOqWX8IpUHCxVa1GhP4w1xfgCJJCst8fDBFdBc
	IMyOvqsEgYnBynb4IOGMUtEaXH1k57HuPKrieOyuwQA/vD6jfp3wceUkWMLhEezfHBuavPTgAb1
	ZZrQuYxNMhHmlHAMzyKvVKOaHEDYM=
X-Received: by 2002:a05:6214:4114:b0:89a:90e:3a1b with SMTP id 6a1803df08f44-8ccefd989f8mr48758356d6.25.1780142126084;
        Sat, 30 May 2026 04:55:26 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042368sm43705386d6.10.2026.05.30.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:55:25 -0700 (PDT)
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
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: act_api: use RCU with deferred freeing for action lifecycle
Date: Sat, 30 May 2026 07:55:11 -0400
Message-Id: <20260530115511.1352487-1-jhs@mojatatu.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293346-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:dkim]
X-Rspamd-Queue-Id: DEC3B60CAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When NEWTFILTER and DELFILTER are run concurently it is possible to create a
race with an associated action.

Let's illustrate with CPU0 running NEWTFILTER and CPU1 running DELFILTER:

 0: mutex_lock() <-- holds the idr lock
 0: rcu_read_lock()
 0: p = idr_find(idr, index) <-- action p is valid (RCU protects IDR)
 0: mutex_unlock() <-- releases the idr lock
 1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
 1: idr_remove(idr, index) <-- Action removed from IDR
 1: mutex_unlock() <-- mutex released allowing us to delete the action
 1: tcf_action_cleanup(p) <-- Kfrees p immediately, no deferral
 0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- ouch, UAF p points to freed memory

This patch fixes the race condition between NEWTFILTER and DELTFILTER by
adding struct rcu_head to tc_action used in the deferral and introducing a
kfree_cpu() in the delete path to defer the delete.

Let's illustrate the new code path:

 0: rcu_read_lock()
 1: refcount_dec_and_mutex_lock() <-- refcnt 1->0, mutex held
 1: idr_remove(idr, index)
 1: mutex_unlock()
 1: kfree_rcu(p, rcu_head) <-- defer to eventually call tcf_action_cleanup()
 0: p = idr_find(idr, index)
 0: refcount_inc_not_zero(&p->tcfa_refcnt) <-- refcnt 0->1 (object stay alive)
 1: rcu_read_unlock() <-- release so freeing can run after grace period

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h |  1 +
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

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
index 332fd9695e54..3148142bb543 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -370,6 +370,14 @@ static void tcf_action_cleanup(struct tc_action *p)
 	free_tcf(p);
 }
 
+/* RCU callback to free action after grace period */
+static void tcf_action_rcu_free(struct rcu_head *rcu)
+{
+	struct tc_action *p = container_of(rcu, struct tc_action, tcfa_rcu);
+
+	tcf_action_cleanup(p);
+}
+
 static int __tcf_action_put(struct tc_action *p, bool bind)
 {
 	struct tcf_idrinfo *idrinfo = p->idrinfo;
@@ -379,8 +387,8 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 			atomic_dec(&p->tcfa_bindcnt);
 		idr_remove(&idrinfo->action_idr, p->tcfa_index);
 		mutex_unlock(&idrinfo->lock);
+		call_rcu(&p->tcfa_rcu, tcf_action_rcu_free);
 
-		tcf_action_cleanup(p);
 		return 1;
 	}
 
@@ -620,7 +628,7 @@ static int tcf_idr_release_unsafe(struct tc_action *p)
 
 	if (refcount_dec_and_test(&p->tcfa_refcnt)) {
 		idr_remove(&p->idrinfo->action_idr, p->tcfa_index);
-		tcf_action_cleanup(p);
+		call_rcu(&p->tcfa_rcu, tcf_action_rcu_free);
 		return ACT_P_DELETED;
 	}
 
@@ -761,7 +769,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 						p->tcfa_index));
 			mutex_unlock(&idrinfo->lock);
 
-			tcf_action_cleanup(p);
+			call_rcu(&p->tcfa_rcu, tcf_action_rcu_free);
 			module_put(owner);
 			return 0;
 		}
-- 
2.34.1


