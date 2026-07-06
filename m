Return-Path: <netdev+bounces-305160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xjrnNKjlS2pbcQEAu9opvQ
	(envelope-from <netdev+bounces-305160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:28:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9F713DC3
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:28:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=To8b1O14;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305160-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305160-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E1593049E23
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1C23A5E67;
	Mon,  6 Jul 2026 17:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B53B0AF5
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358369; cv=none; b=munSpgDGweH9mO0CfNCGTF6n0BtrUChbbb2pKkwqr9FG0jIqO+pYR46Ihjn+aH97hHW1J4w9bfbxw+4q16cPVJ7iwPVxClM8QTCoY9sHdKAd2VXQmxz63murvow2dW8tW2zhLRINFu9cuwAOmQX6NiMU2Z/ZesEi1+K2TkpQgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358369; c=relaxed/simple;
	bh=j5v+4rfRWYmK9xMD+3s3hNqe1DrB6fyG8+zp9FCaGiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV233K3B5bkbygn44084biovrfzNjaPxnrufxV9ijo18vf6VmlR0wQpPUaMXiln//YeZs02oEkdfSxXYedzG7POPWAEcoHhbYYOiiYR9EfG1zKbwnc/cjRUGdP0HOKi2lKjxgDLPJPPwkVYHLhPz9icm9w8ThJd+cS5hHYCt5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To8b1O14; arc=none smtp.client-ip=209.85.210.42
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb4d532e65so948913a34.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358367; x=1783963167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6ebsQ3u+aphWKso80NIQ5E2cNKzLpEI4R/i6vR6OPA=;
        b=To8b1O14NgQSG1ACdzmIUzwMwg9/sFQmYNKZWl0MXgR80iLVgbkerHuWfRYZ6kAGWd
         SysHX7LPEpO9oGlj4R3uYuAMiRCqwC5+w0yY8jhW8iZ27PC0WKUWWbfWU0+FOoprjFn5
         mGRjuncAM9B8kyEVmi2Y18vfAaNYTsn37LwdDbkT+cOkfaHj136PawG8urpOfSRAc5/T
         Dr10vju0XBZwikva+2tQzhCyyJNFqUJcpUhgLUj0AdFSmvVhdODmoLpOFAaL3T2ZDwKP
         0Td0zXU2HT6KfkEDe7eVjE8kUa5xdqBwMnES3giUV/Yh0yVnZoU8he4I5FG1+7mZuiS0
         qVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358367; x=1783963167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6ebsQ3u+aphWKso80NIQ5E2cNKzLpEI4R/i6vR6OPA=;
        b=sIoz6GENHLIs4px4prOI2L0/8lJvvWL6HdE8owvu2Trch1WD2lSQNcZ0Hz2EUq4itP
         RlxZcjaCSplXoBOUHcesfG1Fvs7zJwKB/ggHfvnxk43INqRm2uTnKSG8kxEBcAQXeHwl
         8J8de0yM+SDyxOUOn3eb3wFsgsyAr9hclX2sKeCzHYTyhwGkklT9bUytezcbh6tGxdp5
         G0+YnFIOejichLJsBVJv3PvdQqFGtXheRMam6kDKj8bXiFDptCGiKjE9olDGqtWi7uvR
         NPoWBXj+zJEkqJtZbRWhXPhF/AvS1IS6DTJCdj/utarAtMC73VrCYZNkEwbbRzYVtw5I
         HPhQ==
X-Gm-Message-State: AOJu0YyGSVShbpemXhp+RhAt6aw9pP2e7zzABQ/9WSu3OWoZ0q9Ix8lg
	1G+P/JqpWoNiwkOKyeupykcGBLKNuivE48lPDn/cy3zOzZ/SzcUdUv+l
X-Gm-Gg: AfdE7cn0o5Hl9cTi3tPLohz2Gxs47dB6xEQT3v7KTVA2iJ0HC+g6hN5hS8XZUYvu4DK
	xwcxclijiCbBabHHaqZuxaopot6hFFHgf+weiISMOSuVxWIRFycZ2VChB7gtQ1/6VuRMjdwDrWJ
	Q1McKmTgGDMg0K4moHSm5zkAiDUySmh9Ck8hb9IWE6+/URqsWWspJ5I56X/gLLzVV3hQO/KNwQu
	D0PsQidYorO2Or0vb6zbBX9qXtx9MZ8EUDbUbhdCKisSzfW3Ty9Ah5fDgTezEXe/uYqUyydVR/2
	KTOxehxG4IVhSrWB6oOYIxIcy2q4I3Cn0izX+p1Ixuqv9UHiOwN7+pRnT+n1RQJ9UGXIAgUGOzC
	I4vdqwirNbr2lOYK7OtLjFhKlGcFDwUoBOB02nHXWVBiBcYb60UvkntwywiQIiPzvBUx0p5RCpv
	3tdoP8JfqTW7oHkQ==
X-Received: by 2002:a05:6820:4b88:b0:6a1:50e7:5c13 with SMTP id 006d021491bc7-6a355762385mr924668eaf.62.1783358366523;
        Mon, 06 Jul 2026 10:19:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a30ff8e0a0sm9343029eaf.3.2026.07.06.10.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:25 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 02/15] bpf: Make struct_ops tasks_rcu grace period optional
Date: Mon,  6 Jul 2026 10:19:04 -0700
Message-ID: <20260706171918.317102-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E9F713DC3

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_struct_ops_map_free() currently waits for both a regular RCU grace
period and a tasks RCU grace period for every struct_ops map through
synchronize_rcu_mult(call_rcu, call_rcu_tasks).

A regular RCU grace period is still required for all struct_ops maps
because the struct_ops trampoline ksyms requires a rcu grace period
(take a look at the list_del_rcu in __bpf_ksym_del).
Add a map_free_pre_rcu() callback so the struct_ops map can remove
ksyms before bpf_map_put() wait for the regular rcu grace period.

The tasks RCU grace period is only needed by tcp_congestion_ops.
Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
of the bpf_map.

When CONFIG_TASKS_RCU=n, synchronize_rcu_tasks() is the same as
synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
grace period before bpf_struct_ops_map_free() runs, skip the extra
synchronize_rcu_tasks() call in this case.

This cleanup prepares for a later patch that needs to support
free_after_mult_rcu_gp.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         |  7 +++++++
 kernel/bpf/bpf_struct_ops.c | 31 +++++++++++++------------------
 kernel/bpf/syscall.c        |  3 +++
 net/ipv4/bpf_tcp_ca.c       | 16 ++++++++++++++++
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..7ac8873839f4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -90,6 +90,7 @@ struct bpf_map_ops {
 	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
 	void (*map_release)(struct bpf_map *map, struct file *map_file);
 	void (*map_free)(struct bpf_map *map);
+	void (*map_free_pre_rcu)(struct bpf_map *map);
 	int (*map_get_next_key)(struct bpf_map *map, void *key, void *next_key);
 	void (*map_release_uref)(struct bpf_map *map);
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
@@ -2099,6 +2100,11 @@ struct btf_member;
  *	   unloaded while in use.
  * @name: The name of the struct bpf_struct_ops object.
  * @func_models: Func models
+ * @free_after_tasks_rcu_gp: Set to true if it needs the bpf core to wait for
+ *                           a tasks_rcu gp before freeing the struct_ops map
+ *                           and its progs. It is unnecessary if the @unreg
+ *                           has waited for the correct rcu gp or the @unreg
+ *                           has ensured all struct_ops prog has finished running.
  */
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
@@ -2117,6 +2123,7 @@ struct bpf_struct_ops {
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
+	bool free_after_tasks_rcu_gp;
 };
 
 /* Every member of a struct_ops type has an instance even a member is not
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d06b3d9bcc13..c422ce41873e 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -984,9 +984,18 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 	bpf_map_area_free(st_map);
 }
 
+static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	bpf_struct_ops_map_del_ksyms(st_map);
+}
+
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	struct bpf_struct_ops *st_ops = st_map->st_ops_desc->st_ops;
+	bool tasks_rcu = st_ops->free_after_tasks_rcu_gp;
 
 	/* st_ops->owner was acquired during map_alloc to implicitly holds
 	 * the btf's refcnt. The acquire was only done when btf_is_module()
@@ -997,24 +1006,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 
 	bpf_struct_ops_map_dissoc_progs(st_map);
 
-	bpf_struct_ops_map_del_ksyms(st_map);
-
-	/* The struct_ops's function may switch to another struct_ops.
-	 *
-	 * For example, bpf_tcp_cc_x->init() may switch to
-	 * another tcp_cc_y by calling
-	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
-	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
-	 * and its refcount may reach 0 which then free its
-	 * trampoline image while tcp_cc_x is still running.
-	 *
-	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
-	 * to finish. bpf-tcp-cc prog is non sleepable.
-	 * A rcu_tasks gp is to wait for the last few insn
-	 * in the tramopline image to finish before releasing
-	 * the trampoline image.
-	 */
-	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
+	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
+		synchronize_rcu_tasks();
 
 	__bpf_struct_ops_map_free(map);
 }
@@ -1123,6 +1116,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
+	map->free_after_rcu_gp = true;
 
 	return map;
 
@@ -1155,6 +1149,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
 	.map_alloc_check = bpf_struct_ops_map_alloc_check,
 	.map_alloc = bpf_struct_ops_map_alloc,
 	.map_free = bpf_struct_ops_map_free,
+	.map_free_pre_rcu = bpf_struct_ops_map_free_pre_rcu,
 	.map_get_next_key = bpf_struct_ops_map_get_next_key,
 	.map_lookup_elem = bpf_struct_ops_map_lookup_elem,
 	.map_delete_elem = bpf_struct_ops_map_delete_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..b07acf37ad1d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -956,6 +956,9 @@ void bpf_map_put(struct bpf_map *map)
 		/* bpf_map_free_id() must be called first */
 		bpf_map_free_id(map);
 
+		if (map->ops->map_free_pre_rcu)
+			map->ops->map_free_pre_rcu(map);
+
 		WARN_ON_ONCE(atomic64_read(&map->sleepable_refcnt));
 		/* RCU tasks trace grace period implies RCU grace period. */
 		if (READ_ONCE(map->free_after_mult_rcu_gp))
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 791e15063237..e224ecafbd69 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -339,6 +339,22 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
 	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
+	/* The struct_ops's function may switch to another struct_ops.
+	 *
+	 * For example, bpf_tcp_cc_x->init() may switch to
+	 * another tcp_cc_y by calling
+	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
+	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
+	 * and its refcount may reach 0 which then free its
+	 * trampoline image while tcp_cc_x is still running.
+	 *
+	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
+	 * to finish. bpf-tcp-cc prog is non sleepable.
+	 * A rcu_tasks gp is to wait for the last few insn
+	 * in the tramopline image to finish before releasing
+	 * the trampoline image.
+	 */
+	.free_after_tasks_rcu_gp = true,
 	.owner = THIS_MODULE,
 };
 
-- 
2.52.0


