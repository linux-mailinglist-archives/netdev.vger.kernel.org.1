Return-Path: <netdev+bounces-260575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BaSN4LHnWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:45:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 742031893CA
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 230073073EE0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5F3A63ED;
	Tue, 24 Feb 2026 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrCx26Eg"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCD3A4F58
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947748; cv=none; b=AxSwNSJxLW18A6kpQkxs2OO8OnHAzEyqlY+GqjIR/6D8b1zfRVXjKLKXz2+AMyA1rP6dvniSYFVRmS/NGVZaU+yE0ByYyvhWB+WB4ZPeX+Drd+aobnZHnFF9j6IdbvD9XefdiSOIkiBqwZP7cWvJInpR+/zYEkBfIRL03Oyy2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947748; c=relaxed/simple;
	bh=MnFhEKNIzjXvigv4lxIPNTGgFi/zYkk/xBW6Z/qPfVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idkTdto7kl9aEf7fK7MLdyKHm5YQrRgiQhvLS4UsDwnoDjX3rBj0zl60v0bLlwTrIBARhmDtjbeCkbc+3YDX+gggOl/LeDEWuYEbONqHucyjRD5aDOECraw9OuRm9E+HUd0A7q3DHU1dWX08HcCc7voklt/DYaXg9bNqV2Q7YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrCx26Eg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/b+70PPkY/pfbfwzHHp1MTkubPK3K5BdD6G2vC79gfY=;
	b=vrCx26Eg2houGeS4NexccmEm22FNdHtVz5G+g/Sjm2mJvX/nP/+HkunFUwk5ONLwk/jVX4
	lcpWGFzfdS7VG0z3b9Mr9uLh8pBItyBG8fiApzWSki+jC3J5IsvoKC21psNEV0RUKyvI8I
	J9unfd3UUprSA0mXC04TwPg72ajaZFA=
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
Subject: [PATCH bpf-next 5/8] bpf: Disallow !call_session_is_return progs tail-calling call_session_is_return progs
Date: Tue, 24 Feb 2026 23:40:21 +0800
Message-ID: <20260224154024.12504-6-leon.hwang@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260575-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 742031893CA
X-Rspamd-Action: no action

bpf_session_is_return() depends on consistent session metadata stored on
stack for fsession programs. Mixing fsession programs that do and do not
rely on these helpers in tail calls can violate that runtime contract.

Disallow the combination of !call_session_is_return progs and
call_session_is_return progs in __bpf_prog_map_compatible() to address
the issue.

Fixes: 27d89baa6da8 ("bpf: support fsession for bpf_session_is_return")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   | 4 +++-
 kernel/bpf/core.c     | 4 ++++
 kernel/bpf/verifier.c | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c74db70f9be1..6be5f81b61e7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -290,7 +290,8 @@ struct bpf_map_owner {
 	    sleepable:1,
 	    kprobe_write_ctx:1,
 	    call_get_func_ip:1,
-	    call_session_cookie:1;
+	    call_session_cookie:1,
+	    call_session_is_return:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
@@ -1699,6 +1700,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	bool call_session_is_return; /* Do we call bpf_session_is_return */
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 904a8dbfd56f..44aeb49b2d1b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2405,6 +2405,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->kprobe_write_ctx = aux->kprobe_write_ctx;
 		map->owner->call_get_func_ip = fp->call_get_func_ip;
 		map->owner->call_session_cookie = fp->call_session_cookie;
+		map->owner->call_session_is_return = aux->call_session_is_return;
 		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
@@ -2426,6 +2427,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		if (ret && (!map->owner->call_session_cookie && fp->call_session_cookie &&
 			    prog_type == BPF_PROG_TYPE_TRACING))
 			ret = false;
+		if (ret && (!map->owner->call_session_is_return && aux->call_session_is_return &&
+			    prog_type == BPF_PROG_TYPE_TRACING))
+			ret = false;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 		    map->owner->expected_attach_type != fp->expected_attach_type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e9c04e08fba..919075ee3479 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14409,6 +14409,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
 		env->prog->call_session_cookie = true;
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_is_return])
+		env->prog->aux->call_session_is_return = true;
 
 	return 0;
 }
-- 
2.52.0


