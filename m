Return-Path: <netdev+bounces-262689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE6MG/OopWmpDgAAu9opvQ
	(envelope-from <netdev+bounces-262689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:12:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C71DB909
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BA0311388E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E428411619;
	Mon,  2 Mar 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WJCIV5j0"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B640B6D4
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463914; cv=none; b=gfjee1rIfrXAePYqCzyEh8+oapeKvYmD5Br67/Sbl3KRozfOjgIBf8J/+v1Ep1XIr9dfTyTSJk9/UMb9gqZQRnKpkgfkdn5P6CR9I///U+9wBE89P4IrOQmt8EXPqd50RUqvYcyijBNlKJoPBfXRXbiFBTtYWZ2S4xUu5O75cQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463914; c=relaxed/simple;
	bh=nEWKuoSdePm95rFgEKVllhx1pMSJsEpr7/UWYSW+dXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl48Y5ZelxTYLc62rJeqPV2isw7JlLaM2/S2KU/wvY/FCc6GHtrzh1jdZuo7/Lp9pfKAyUJxnKA5dPwnT79jpDI27x5jdT+3SkCFSEB/CkDdccJ42ryvtgm09I0Yq7cLWIHWnJeAHFh2P5iu3mPu+gI8MbyiK3yH+frZo6ybKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WJCIV5j0; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772463909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNJfA3Xf+e4vt84NatwltvsAO0vxWfNT/RjgAWRYZ18=;
	b=WJCIV5j0PMJLfL1brDaqfMtiYBDrrsR6JwkwcQCZU/6iorBSLDg/kAXFoLPWuxnh+C0RhW
	e5HKOSiuUd+4MW3QTZu/Z6L/MHlTnWcg+zP0dwBURxC+7ifJv18cWP5RlgXmp43jAy924/
	mc4stwme4HLtCpuW7gY2geNMQkv45MY=
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
Subject: [PATCH bpf-next v2 5/6] bpf: Disallow !call_session_cookie progs tail-calling call_session_cookie progs
Date: Mon,  2 Mar 2026 23:03:41 +0800
Message-ID: <20260302150342.55709-6-leon.hwang@linux.dev>
In-Reply-To: <20260302150342.55709-1-leon.hwang@linux.dev>
References: <20260302150342.55709-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 059C71DB909
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262689-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Fsession progs that call bpf_session_cookie() kfunc depend on
consistent session metadata stored on the stack. Mixing
!call_session_cookie progs with call_session_cookie progs via tail
calls could break this assumption.

To address this, reject the combination of !call_session_cookie progs
with call_session_cookie progs in bpf_map_owner_matches(), which
prevents the tail callee from accessing a bogus session cookie.

Also reject call_session_cookie mismatches during initialization to
prevent bypassing the above restriction.

Without this check, the above restriction can be bypassed as follows.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("?fsession")
int BPF_PROG(prog_a)
{
	u64 *cookie = bpf_session_cookie(ctx);

        *cookie = 42;
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

SEC("?fsession")
int BPF_PROG(prog_b)
{
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

* Load prog_a first.
  At this point, owner->call_session_cookie=true.
* Load prog_b next.
  At this point, prog_b passes the compatibility check.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, prog_a will get a u64 pointer to the
first arg slot on the trampoline stack, and will modify the arg via this
pointer.

Fixes: eeee4239dbb1 ("bpf: support fsession for bpf_session_cookie")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fb978650b169..3931fdbca3a7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -290,6 +290,7 @@ struct bpf_map_owner {
 	u32 sleepable:1;
 	u32 kprobe_write_ctx:1;
 	u32 call_get_func_ip:1;
+	u32 call_session_cookie:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1b88878fe5c5..03d2d8f244c8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2392,6 +2392,7 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
 	owner->sleepable = fp->sleepable;
 	owner->kprobe_write_ctx = aux->kprobe_write_ctx;
 	owner->call_get_func_ip = fp->call_get_func_ip;
+	owner->call_session_cookie = fp->call_session_cookie;
 	owner->expected_attach_type = fp->expected_attach_type;
 	owner->attach_func_proto = aux->attach_func_proto;
 	for_each_cgroup_storage_type(i)
@@ -2425,6 +2426,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 			return false;
 		if (owner->call_get_func_ip != fp->call_get_func_ip)
 			return false;
+		if (owner->call_session_cookie != fp->call_session_cookie)
+			return false;
 		break;
 
 	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
@@ -2433,6 +2436,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 		if (bpf_prog_has_trampoline(fp)) {
 			if (!owner->call_get_func_ip && fp->call_get_func_ip)
 				return false;
+			if (!owner->call_session_cookie && fp->call_session_cookie)
+				return false;
 		}
 		break;
 	}
-- 
2.52.0


