Return-Path: <netdev+bounces-260572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBcsHkzInWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:48:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09561189486
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 643EA308E86B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554D3A4F5A;
	Tue, 24 Feb 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+YeBNLv"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1CA3A4F39
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947713; cv=none; b=P7gHa0VFKEQOOrKzxehvkoBV/7+hOEngp8a5NkMCpcoXzGyBarnrH9fLqf/fiqiqwwBba3M1W+GTlc2e2kuX+Ygne4htQrsNgJOx5Dw0lOWmE2pMeEq3rvug2nUs9+91Kb2+qNvU+0lHROlyCZGu1pM+vKZvCL3Ywn7fMjLG3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947713; c=relaxed/simple;
	bh=EUskLKncGN6F8VI22eEL+Udchk5d/0odV1f99i2e4Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9X5bJ4BCGj8aI8nJMWM1Q670gg844BQEe59IQ+6mIT0d8fRyOP2DjRqA0kAhutoG0b4rRXfgFBywtiFhBqqK2nZnKlvvsgCuM9UG3glPRgnD958Fujq0AXKKyeCqsj2ZNPgP1nOy2DkwirS6DaodXb0RpzQigBhgZ0E9EFOyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+YeBNLv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cOL5Wb4sgredTy87bpW5d+Y+NrZLlqF3fUGuWvVJO0=;
	b=A+YeBNLvkz0x5/Xcs+YiJgOUOdD2hUtekrZe2eaTx3qFUj8bBvegW77N78dTlZ0xqbp7Cx
	JoSrejSze62FIadruV+nVbVxRhl1CkASPwZ+dL77mim8xCJCY88Ik7XNZA4+gbui/rnKAE
	Bi2zIfKZqfZRqdbyqNVpr4/EVtetFe8=
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
Subject: [PATCH bpf-next 2/8] bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs
Date: Tue, 24 Feb 2026 23:40:18 +0800
Message-ID: <20260224154024.12504-3-leon.hwang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-260572-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09561189486
X-Rspamd-Action: no action

uprobe programs that can modify pt_regs require different runtime
assumptions than pt_regs-read-only uprobe programs. Mixing both in
one prog_array can make owner expectations diverge from callee behavior.

Reject the combination of !kprobe_write_ctx progs with kprobe_write_ctx
progs in __bpf_prog_map_compatible() to address the issue.

Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 7 ++++---
 kernel/bpf/core.c   | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b78b53198a2e..2a2f6448a5fb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -285,9 +285,10 @@ struct bpf_list_node_kern {
  */
 struct bpf_map_owner {
 	enum bpf_prog_type type;
-	bool jited;
-	bool xdp_has_frags;
-	bool sleepable;
+	u32 jited:1,
+	    xdp_has_frags:1,
+	    sleepable:1,
+	    kprobe_write_ctx:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..f99a901b5e48 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2402,6 +2402,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
 		map->owner->sleepable = fp->sleepable;
+		map->owner->kprobe_write_ctx = aux->kprobe_write_ctx;
 		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
@@ -2415,6 +2416,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		      map->owner->jited == fp->jited &&
 		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
 		      map->owner->sleepable == fp->sleepable;
+		if (ret && (!map->owner->kprobe_write_ctx && aux->kprobe_write_ctx))
+			ret = false;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 		    map->owner->expected_attach_type != fp->expected_attach_type)
-- 
2.52.0


