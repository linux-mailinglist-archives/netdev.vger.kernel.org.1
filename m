Return-Path: <netdev+bounces-262688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PPXIryopWmpDgAAu9opvQ
	(envelope-from <netdev+bounces-262688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:11:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839BA1DB89D
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 897BC300B50E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B6E40B6ED;
	Mon,  2 Mar 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LtiQJZDB"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0C3FD15D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463906; cv=none; b=DJJoWBZ/qiWuXYg8MvmEyL746s/eOAhhKOzrrr1oVMTD0sVZ9J9m2s1AkfGj1vbI4VeTGfUcvLH3L37BpKgyyC99op6G3MiqQ5xq93jjedGOgv2vrXAglipqZ2z24v/W187Uvrpc1Mn7TzPwlI+pCKubLaPJihb7dmjcYyMf3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463906; c=relaxed/simple;
	bh=g8iFQt8PutO9ez9QZhPdi2ZlJazN1/pZxoozXBn3C6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baoWRvYuVdbz8UtfwITHZtIHdv0GcoC90jKN9/sUIdOQ8YjInuKCDgkkuJ4gFw28rsk8cQuB5kB0UxH92Q7PHmrBGc0Fx4aI2WdCKFObDh1ffoL9j8lRQtsFYNDHlYLRaNG7UCR2jBNQHYbDBFDLFIlpdsTsGEmlNaoNz9DObUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LtiQJZDB; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772463901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+PWWkwazjgxzegEXu2v7YMpb7U2FHOXq8Nh1mdAOFE=;
	b=LtiQJZDBVu1SJwdRRouZ70fq6wxNk92yLmHsbbZ+531nmHWqAS5Vuy9FtkOVQq/fEJPjt/
	GvdbEkqNLGv0ovEBqlw88Tu+fPMfKPVIqxoGA4h3/LjH9oIJsxylPoQpvVV/rueIIauCIe
	lilecwkNCo6/TixA2a9GJJoCvK9HMVs=
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
Subject: [PATCH bpf-next v2 4/6] bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip progs
Date: Mon,  2 Mar 2026 23:03:40 +0800
Message-ID: <20260302150342.55709-5-leon.hwang@linux.dev>
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
X-Rspamd-Queue-Id: 839BA1DB89D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262688-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Trampoline-based tracing programs that call bpf_get_func_ip() rely on
the func IP stored on the stack. Mixing !call_get_func_ip progs with
call_get_func_ip progs via tail calls could break this assumption.

To address this, reject the combination of !call_get_func_ip progs with
call_get_func_ip progs in bpf_map_owner_matches(), which prevents the
tail callee from getting a bogus func IP.

Also reject call_get_func_ip mismatches during initialization to
prevent bypassing the above restriction.

Without this check, the above restriction can be bypassed as follows.

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

SEC("?fentry")
int BPF_PROG(prog_a)
{
	bpf_printk("FUNC IP: 0x%llx\n", bpf_get_func_ip());
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

SEC("?fentry")
int BPF_PROG(prog_b)
{
	bpf_tail_call_static(ctx, &jmp_table, 0);
	return 0;
}

The jmp_table is shared between prog_a and prog_b.

* Load prog_a first.
  At this point, owner->call_get_func_ip=true.
* Load prog_b next.
  At this point, prog_b passes the compatibility check.
* Add prog_a to jmp_table.
* Attach prog_b to a kernel function.

When the kernel function runs, prog_a will get a bogus func IP because
no func IP is prepared on the trampoline stack.

Fixes: 1e37392cccde ("bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dbafed52b2ba..fb978650b169 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -289,6 +289,7 @@ struct bpf_map_owner {
 	u32 xdp_has_frags:1;
 	u32 sleepable:1;
 	u32 kprobe_write_ctx:1;
+	u32 call_get_func_ip:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 121a697d4da5..1b88878fe5c5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2391,6 +2391,7 @@ static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_pro
 	owner->xdp_has_frags = aux->xdp_has_frags;
 	owner->sleepable = fp->sleepable;
 	owner->kprobe_write_ctx = aux->kprobe_write_ctx;
+	owner->call_get_func_ip = fp->call_get_func_ip;
 	owner->expected_attach_type = fp->expected_attach_type;
 	owner->attach_func_proto = aux->attach_func_proto;
 	for_each_cgroup_storage_type(i)
@@ -2422,11 +2423,17 @@ static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_pr
 	case BPF_MAP_OWNER_MATCH_FOR_INIT:
 		if (owner->kprobe_write_ctx != aux->kprobe_write_ctx)
 			return false;
+		if (owner->call_get_func_ip != fp->call_get_func_ip)
+			return false;
 		break;
 
 	case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
 		if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx)
 			return false;
+		if (bpf_prog_has_trampoline(fp)) {
+			if (!owner->call_get_func_ip && fp->call_get_func_ip)
+				return false;
+		}
 		break;
 	}
 
-- 
2.52.0


