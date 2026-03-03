Return-Path: <netdev+bounces-263269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKvMGzf7pmk7bgAAu9opvQ
	(envelope-from <netdev+bounces-263269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:16:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E591F24F3
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 16:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 064EB30BBFA0
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94548122C;
	Tue,  3 Mar 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c60CHyuJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082B47ECD9
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550526; cv=none; b=o/X5KR12/CHcPojbkYXCQhYXC5aMl4IAN18Whjuv32mIE1dvxJUFaPT8hBeKksHcNh99Tlaa2baL0M0oMbZQ/lvowsuLGJtq0D7y0escR9p/UOSv/4TOkJNRD2aJqel812M7gZIC/UHHmghat4clcA0J0ELU7M4cAmkAURRY42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550526; c=relaxed/simple;
	bh=L2Qr5aAsgygODzuECKeOy83yrIyy1pX5bOXrf2pkTFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST1ErfpBdDXfDWeebMTh0JZKiweWf3dtHcZKpQF3rgCx2NJ/QB9rK0ZXQcCXTBSyNVb6qKp9jADwZTvhHCMW0IRqEu9WsK8DE/LI4X2LAmgTHk4P52+SVqQlMp5lg+gPCYT/OXkS4Ce32z4B1QdH5BZuJfIX68wM0fsfuumAOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c60CHyuJ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772550522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=To4DK5qCEnIcL4mbKSZPBkRD+y6r23+cgxWeg9hvTJ8=;
	b=c60CHyuJ+i4Mmd4UnShODEixRvSpLZDuNZn4FBK4c6Zuy5DgFpzQa6zV7pogm2VUNc9wek
	GPW+iqMkzYEQdJSzzP0YapdHyQkHsgNG+dIJJa0GMwPwOVRk0keAyd3zOUoJFKkbjF03Nd
	CMVG0ZBqeUdcwL+g6vBEwVDdCwyO+kk=
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
Subject: [PATCH bpf-next v3 5/6] bpf: Disallow !call_session_cookie progs tail-calling call_session_cookie progs
Date: Tue,  3 Mar 2026 23:06:38 +0800
Message-ID: <20260303150639.85007-6-leon.hwang@linux.dev>
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
X-Rspamd-Queue-Id: E2E591F24F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263269-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
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
index d20a90bd1d2b..5f46ac2c869b 100644
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
@@ -2427,6 +2428,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 		if (has_trampoline) {
 			if (owner->call_get_func_ip != fp->call_get_func_ip)
 				return false;
+			if (owner->call_session_cookie != fp->call_session_cookie)
+				return false;
 		}
 		break;
 
@@ -2436,6 +2439,8 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 		if (has_trampoline) {
 			if (!owner->call_get_func_ip && fp->call_get_func_ip)
 				return false;
+			if (!owner->call_session_cookie && fp->call_session_cookie)
+				return false;
 		}
 		break;
 	}
-- 
2.52.0


