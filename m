Return-Path: <netdev+bounces-262686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF4kKJqopWngCwAAu9opvQ
	(envelope-from <netdev+bounces-262686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:11:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132F1DB863
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 16:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A402305F503
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D641160D;
	Mon,  2 Mar 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IBhDUvLg"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613640B6C0
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463871; cv=none; b=XwDYCcwbaYGob9PJTwPTKjSCJcWFk7W8SyT7Iin4oFNG4OIZBVxZhVATpgpd75l2tfmCtt40AbHFWEJaTeGySfkAAxc/+7iu0wXWqjMpZIUtcdM6y98gcdyQEo59uaqTKoYZWcLqY5J4Y+wctXzFlSnKtMNQfoKzNDJ1CVJ528Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463871; c=relaxed/simple;
	bh=wetn+BhjoCd6GaTj6qsiXs+0U3i59ctE0mLs/xexuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3wu+s5cqpzw3FtgfdfbWoNAcDU3NHYY+tLsaheqvUWWgpcJbxVEOAN8pUDL6BnNUrHof7L4Xdn3aKv5QjhKCz6MyrrTb5/C+KN2qr2j9QPX/T2fgKoC6ENYe77sa7d95Dwn7iIyRw4Eu21rrZ3chMRS8Xrx+6zZihA1HZAWLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IBhDUvLg; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772463868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfTsEtc+4MDeNoDV9HupmgjRya/Vhl9qu21qBDHMts0=;
	b=IBhDUvLgAnjupfk/5LeC5EY0ZnpODYNDk1UY4orVXPxHP20MMuRAUyGqloOEOpBdusKQZE
	uL0IZ443w43enf4oiqlBzoKN7RPAJPcJkx6ln1Ob1q83D6Ot6SjVbNJyxQSr3KIePsi7AE
	clu3NS2KpRsio7eO6ls4obSesmB0Qek=
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
Subject: [PATCH bpf-next v2 2/6] bpf: Factor out bpf_map_owner_[init,matches]() helpers
Date: Mon,  2 Mar 2026 23:03:38 +0800
Message-ID: <20260302150342.55709-3-leon.hwang@linux.dev>
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
X-Rspamd-Queue-Id: 4132F1DB863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-262686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

When adding more attributes to validate in __bpf_prog_map_compatible(),
both the if and else code blocks become harder to read.

To improve readability, factor out bpf_map_owner_init() and
bpf_map_owner_matches() helpers.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/core.c | 100 ++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 229c74f3d6ae..b24a613d99f2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2380,14 +2380,66 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 	return 0;
 }
 
+static void bpf_map_owner_init(struct bpf_map_owner *owner, const struct bpf_prog *fp,
+			       enum bpf_prog_type prog_type)
+{
+	struct bpf_prog_aux *aux = fp->aux;
+	enum bpf_cgroup_storage_type i;
+
+	owner->type  = prog_type;
+	owner->jited = fp->jited;
+	owner->xdp_has_frags = aux->xdp_has_frags;
+	owner->sleepable = fp->sleepable;
+	owner->expected_attach_type = fp->expected_attach_type;
+	owner->attach_func_proto = aux->attach_func_proto;
+	for_each_cgroup_storage_type(i)
+		owner->storage_cookie[i] = aux->cgroup_storage[i] ?
+			aux->cgroup_storage[i]->cookie : 0;
+}
+
+static bool bpf_map_owner_matches(const struct bpf_map *map, const struct bpf_prog *fp,
+				  enum bpf_prog_type prog_type)
+{
+	struct bpf_map_owner *owner = map->owner;
+	struct bpf_prog_aux *aux = fp->aux;
+	enum bpf_cgroup_storage_type i;
+	u64 cookie;
+
+	if (owner->type  != prog_type ||
+	    owner->jited != fp->jited ||
+	    owner->xdp_has_frags != aux->xdp_has_frags ||
+	    owner->sleepable != fp->sleepable)
+		return false;
+
+	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
+	    owner->expected_attach_type != fp->expected_attach_type)
+		return false;
+
+	for_each_cgroup_storage_type(i) {
+		cookie = aux->cgroup_storage[i] ? aux->cgroup_storage[i]->cookie : 0;
+		if (cookie && cookie != owner->storage_cookie[i])
+			return false;
+	}
+
+	if (owner->attach_func_proto != aux->attach_func_proto) {
+		switch (prog_type) {
+		case BPF_PROG_TYPE_TRACING:
+		case BPF_PROG_TYPE_LSM:
+		case BPF_PROG_TYPE_EXT:
+		case BPF_PROG_TYPE_STRUCT_OPS:
+			return false;
+		default:
+			break;
+		}
+	}
+	return true;
+}
+
 static bool __bpf_prog_map_compatible(struct bpf_map *map,
 				      const struct bpf_prog *fp)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
-	struct bpf_prog_aux *aux = fp->aux;
-	enum bpf_cgroup_storage_type i;
 	bool ret = false;
-	u64 cookie;
 
 	if (fp->kprobe_override)
 		return ret;
@@ -2398,48 +2450,10 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner = bpf_map_owner_alloc(map);
 		if (!map->owner)
 			goto err;
-		map->owner->type  = prog_type;
-		map->owner->jited = fp->jited;
-		map->owner->xdp_has_frags = aux->xdp_has_frags;
-		map->owner->sleepable = fp->sleepable;
-		map->owner->expected_attach_type = fp->expected_attach_type;
-		map->owner->attach_func_proto = aux->attach_func_proto;
-		for_each_cgroup_storage_type(i) {
-			map->owner->storage_cookie[i] =
-				aux->cgroup_storage[i] ?
-				aux->cgroup_storage[i]->cookie : 0;
-		}
+		bpf_map_owner_init(map->owner, fp, prog_type);
 		ret = true;
 	} else {
-		ret = map->owner->type  == prog_type &&
-		      map->owner->jited == fp->jited &&
-		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
-		      map->owner->sleepable == fp->sleepable;
-		if (ret &&
-		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
-		    map->owner->expected_attach_type != fp->expected_attach_type)
-			ret = false;
-		for_each_cgroup_storage_type(i) {
-			if (!ret)
-				break;
-			cookie = aux->cgroup_storage[i] ?
-				 aux->cgroup_storage[i]->cookie : 0;
-			ret = map->owner->storage_cookie[i] == cookie ||
-			      !cookie;
-		}
-		if (ret &&
-		    map->owner->attach_func_proto != aux->attach_func_proto) {
-			switch (prog_type) {
-			case BPF_PROG_TYPE_TRACING:
-			case BPF_PROG_TYPE_LSM:
-			case BPF_PROG_TYPE_EXT:
-			case BPF_PROG_TYPE_STRUCT_OPS:
-				ret = false;
-				break;
-			default:
-				break;
-			}
-		}
+		ret = bpf_map_owner_matches(map, fp, prog_type);
 	}
 err:
 	spin_unlock(&map->owner_lock);
-- 
2.52.0


