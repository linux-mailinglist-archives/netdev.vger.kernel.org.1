Return-Path: <netdev+bounces-263267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ3gMVb6pmkVbwAAu9opvQ
	(envelope-from <netdev+bounces-263267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:12:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 887061F2268
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 798E031208CB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A94480354;
	Tue,  3 Mar 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gdpeXpxT"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35123480DC9
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550508; cv=none; b=p5XL9c/yK+Q5judh1bIrGvupMyz8RMPPR+5794UfIyPtRmlPYKczm0rYkj82lZ9X8FWYJBfrOY4QTfnz1pwW7lVmpetVCSwRaj7O2FFlX41qSOhfGVHnfiVDiL4JBy979/BKH6Io+Vs/Xx/qexrsjoyrlo0ylXgrYZNIc+IbWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550508; c=relaxed/simple;
	bh=0L0CZRR5yaZjUnkGUuTJtr8n6o/HzHfEIlbHobJvreM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mv0QnppkJVPo3goW9J1WZcZztD2AcaUJhNDEO5/hofhUr54KCCcp+fNiE+dIhnN+zm9lVxy/+zwe3S69d8UYD6Rh7m5PmVz7pXvPyH9zithXAxTHMmdVoQDsJmb0FK6hTNlMd7yCi8DFip6iLunlwOGbakXApYu5lXvXFBkF8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gdpeXpxT; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3gwaQ0eVXEyMgQ4Qe+myf5VQ4j4Q5VbSSpgZqEgTR8=;
	b=gdpeXpxT5I4veVauhc8vwnxI8JHYuIGhKitU5Xlwo39BdxtAMAkXkwlfFUyGFNDbN69Twu
	58Noc5IchGPtkC1nb5OKHIXyhuLyhxLqrf0onWEVUW9z1T1yDhPajZUbWx6x86PQV33bMM
	FUkDSTgqkC3wJGIJSff+dd+KHBFYvCA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs
Date: Tue,  3 Mar 2026 23:06:36 +0800
Message-ID: <20260303150639.85007-4-leon.hwang@linux.dev>
In-Reply-To: <20260303150639.85007-1-leon.hwang@linux.dev>
References: <20260303150639.85007-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 887061F2268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Uprobe programs that modify regs require different runtime assumptions
than those that do not. Mixing !kprobe_write_ctx progs with
kprobe_write_ctx progs via tail calls could break these assumptions.

To address this, reject the combination of !kprobe_write_ctx progs with
kprobe_write_ctx progs in bpf_map_owner_matches(), which prevents the
tail callee from modifying regs unexpectedly.

Also reject kprobe_write_ctx mismatches during initialization to
prevent bypassing the above restriction.

Without this check, the above restriction can be bypassed as follows.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, 4);
	__uint(value_size, 4);
} jmp_table SEC(".maps");

SEC("?kprobe")
int prog_a(struct pt_regs *regs)
{
	regs->ax = 0;
	bpf_tail_call_static(regs, &jmp_table, 0);
	return 0;
}

SEC("?kprobe")
int prog_b(struct pt_regs *regs)
{
	bpf_tail_call_static(regs, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

* Load prog_a.
  At this point, owner->kprobe_write_ctx=true.
* Load prog_b.
  At this point, prog_b passes the compatibility check.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, prog_a will unexpectedly modify regs.

Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h |  7 ++++---
 kernel/bpf/core.c   | 30 +++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b0..dbafed52b2ba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -285,9 +285,10 @@ struct bpf_list_node_kern {
  */
 struct bpf_map_owner {
 	enum bpf_prog_type type;
-	bool jited;
-	bool xdp_has_frags;
-	bool sleepable;
+	u32 jited:1;
+	u32 xdp_has_frags:1;
+	u32 sleepable:1;
+	u32 kprobe_write_ctx:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b24a613d99f2..121a697d4da5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2390,6 +2390,7 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
 	owner->jited = fp->jited;
 	owner->xdp_has_frags = aux->xdp_has_frags;
 	owner->sleepable = fp->sleepable;
+	owner->kprobe_write_ctx = aux->kprobe_write_ctx;
 	owner->expected_attach_type = fp->expected_attach_type;
 	owner->attach_func_proto = aux->attach_func_proto;
 	for_each_cgroup_storage_type(i)
@@ -2397,8 +2398,14 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
 			aux->cgroup_storage[i]->cookie : 0;
 }
 
+enum bpf_map_owner_match_type {
+	BPF_MAP_OWNER_MATCH_FOR_INIT,
+	BPF_MAP_OWNER_MATCH_FOR_UPDATE,
+};
+
 static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_prog *fp,
-				  enum bpf_prog_type prog_type)
+				  enum bpf_prog_type prog_type,
+				  enum bpf_map_owner_match_type match)
 {
 	struct bpf_map_owner *owner = map->owner;
 	struct bpf_prog_aux *aux = fp->aux;
@@ -2411,6 +2418,18 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 	    owner->sleepable != fp->sleepable)
 		return false;
 
+	switch (match) {
+	case BPF_MAP_OWNER_MATCH_FOR_INIT:
+		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
+			return false;
+		break;
+
+	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
+		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
+			return false;
+		break;
+	}
+
 	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 	    owner->expected_attach_type != fp->expected_attach_type)
 		return false;
@@ -2436,7 +2455,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 }
 
 static bool __bpf_prog_map_compatible(struct bpf_map *map,
-				      const struct bpf_prog *fp)
+				      const struct bpf_prog *fp,
+				      enum bpf_map_owner_match_type match)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret = false;
@@ -2453,7 +2473,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		bpf_map_owner_init(map->owner, fp, prog_type);
 		ret = true;
 	} else {
-		ret = bpf_map_owner_matches(map, fp, prog_type);
+		ret = bpf_map_owner_matches(map, fp, prog_type, match);
 	}
 err:
 	spin_unlock(&map->owner_lock);
@@ -2470,7 +2490,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
 	if (bpf_prog_is_dev_bound(fp->aux))
 		return false;
 
-	return __bpf_prog_map_compatible(map, fp);
+	return __bpf_prog_map_compatible(map, fp, BPF_MAP_OWNER_MATCH_FOR_UPDATE);
 }
 
 static int bpf_check_tail_call(const struct bpf_prog *fp)
@@ -2485,7 +2505,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 		if (!map_type_contains_progs(map))
 			continue;
 
-		if (!__bpf_prog_map_compatible(map, fp)) {
+		if (!__bpf_prog_map_compatible(map, fp, BPF_MAP_OWNER_MATCH_FOR_INIT)) {
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.52.0


