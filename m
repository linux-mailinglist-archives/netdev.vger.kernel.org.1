Return-Path: <netdev+bounces-260573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO59Kl7InWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39C18949C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17710309579C
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683C73A4F26;
	Tue, 24 Feb 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SN5vFkDC"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF63A1CE7
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947737; cv=none; b=UdYxbCxoAP9P9GoQwQG0Oz2n7Y32AASMs8qaq+yksF+Ws2a2laIFDZRg38jAZK+L6pliFyAmJBUk8z8aUO5Icydiid1lVoxNCqjFiVptoFQ3IDxbgD4KvZry0z3/ozqItzjBorcK4rKQlIWUA9wGvcz1luae5TStUn0jjvQUXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947737; c=relaxed/simple;
	bh=i77qiDOJwVYNU0fXo1gf5ZhKDZtHcHKLVVhBz9+ewlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0v+9Zho4crwgljmxZXQ69LITC3C+PymplRyxZ6d6SsLGOmt7oSSYvpFLSZjzyc61yxBPvRdVI87l0H6L5kaPVWrk2C/J5s4dPaOVN4ZZXJB4ZvKX53EwKk2oE0UquvRUklTK0wKXw9d727+rVEQEL1nV3p5aK5fl8F40QbcQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SN5vFkDC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20Bmo9nBK2Cr9h1IHwRqI0WnKsF7kVCkMXCL3S8USXg=;
	b=SN5vFkDCuMfeygOOygxlOHwnxdCLHMQp4YP+7O6SK+wYVg6mejn1zQM+x6vQBnsTk/vgGH
	hfOUbkcRzhTeFz1JvHPY8LB4wOZHbXtkjtytMi7cr8L+y0AE1AuqvMPrgXFpHDPu1R1tvQ
	NjkdWEdrWax6E2KAfDtml4w4DOxD7uY=
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
Subject: [PATCH bpf-next 3/8] bpf: Disallow !call_get_func_ip progs tail-calling call_get_func_ip progs
Date: Tue, 24 Feb 2026 23:40:19 +0800
Message-ID: <20260224154024.12504-4-leon.hwang@linux.dev>
In-Reply-To: <20260224154024.12504-1-leon.hwang@linux.dev>
References: <20260224154024.12504-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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
	TAGGED_FROM(0.00)[bounces-260573-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B39C18949C
X-Rspamd-Action: no action

Trampoline-based tracing programs that call bpf_get_func_ip() rely on
func_ip stored on stack. Mixing them with tracing programs that do not
share this requirement creates asymmetric expectations in tail calls.

Reject the combination of !call_get_func_ip progs with call_get_func_ip
progs in __bpf_prog_map_compatible() to address the issue.

Fixes: 1e37392cccde ("bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 3 ++-
 kernel/bpf/core.c   | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2a2f6448a5fb..65793fd146c5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -288,7 +288,8 @@ struct bpf_map_owner {
 	u32 jited:1,
 	    xdp_has_frags:1,
 	    sleepable:1,
-	    kprobe_write_ctx:1;
+	    kprobe_write_ctx:1,
+	    call_get_func_ip:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f99a901b5e48..01fce3fba0be 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2403,6 +2403,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
 		map->owner->sleepable = fp->sleepable;
 		map->owner->kprobe_write_ctx = aux->kprobe_write_ctx;
+		map->owner->call_get_func_ip = fp->call_get_func_ip;
 		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
@@ -2418,6 +2419,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		      map->owner->sleepable == fp->sleepable;
 		if (ret && (!map->owner->kprobe_write_ctx && aux->kprobe_write_ctx))
 			ret = false;
+		if (ret && (!map->owner->call_get_func_ip && fp->call_get_func_ip &&
+			    prog_type == BPF_PROG_TYPE_TRACING))
+			ret = false;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 		    map->owner->expected_attach_type != fp->expected_attach_type)
-- 
2.52.0


