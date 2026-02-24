Return-Path: <netdev+bounces-260574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHI1D23InWk8SAQAu9opvQ
	(envelope-from <netdev+bounces-260574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:49:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD4F1894AC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37C3E31FF3A7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51A3A4F47;
	Tue, 24 Feb 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ktwy5w5H"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0D1A9F93;
	Tue, 24 Feb 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947743; cv=none; b=bcyd5CjO6plzu3N2bX7ZaZVr4FhABS1EZCuAylA06f1w3Y79EBdJRBYwwqiN6TZz9EUjMsoyokNDramuQFbzCDXIvSUiPUuMG9YmLjGcSSti3P0kg3NMIGCOV9JdHwYUGayPxLoFapzpbtgiLdv3xA6zm8OV/iVZmN/D77w+jHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947743; c=relaxed/simple;
	bh=XlIzMybjjeNU4KyEifGFEeHLenW/genbPa7xSqDl1vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7c4Ii+G9WxdfwrwmB9IvHE++uxeJGp/SJKeMnqTYmZRqTw1ZeGB0dpjNGScDugfo4iSu6KdLkcOLcNcMIejodS/33TLUWMiOgBOz7KLTA7R4F2XmZkcGzQD1cM+Ia1NMv5klqOEOS7UGxm6MDTl26Y0P42MO9y7K8KSyhLZI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ktwy5w5H; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QH8l6CJx3ffsF93aY6sNBfg1kIlQOkrhZPP2sAud1g=;
	b=ktwy5w5HYvk9AKnoffWJTP1u6gtyHleZfgMoGkHzx4Rx9+fkLGYPfCjqgPLQeqNuDQiv44
	GoCDWK68O37mgblx4U70PeC8Bu1knRozeEI1Ia2c0NQ560AkxrPVwWcNc3UM5U1sFZ9MIh
	Csz5qnMSv7ZbM8NzWwWzxn5xCx7OJYg=
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
Subject: [PATCH bpf-next 4/8] bpf: Disallow !call_session_cookie progs tail-calling call_session_cookie progs
Date: Tue, 24 Feb 2026 23:40:20 +0800
Message-ID: <20260224154024.12504-5-leon.hwang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-260574-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CAD4F1894AC
X-Rspamd-Action: no action

bpf_session_cookie() depends on consistent session metadata stored on
stack for fsession programs. Mixing fsession programs that do and do not
rely on these helpers in tail calls can violate that runtime contract.

Disallow the combination of !call_session_cookie progs and
call_session_cookie progs in __bpf_prog_map_compatible() to address the
issue.

Fixes: eeee4239dbb1 ("bpf: support fsession for bpf_session_cookie")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 3 ++-
 kernel/bpf/core.c   | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 65793fd146c5..c74db70f9be1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -289,7 +289,8 @@ struct bpf_map_owner {
 	    xdp_has_frags:1,
 	    sleepable:1,
 	    kprobe_write_ctx:1,
-	    call_get_func_ip:1;
+	    call_get_func_ip:1,
+	    call_session_cookie:1;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 01fce3fba0be..904a8dbfd56f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2404,6 +2404,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->sleepable = fp->sleepable;
 		map->owner->kprobe_write_ctx = aux->kprobe_write_ctx;
 		map->owner->call_get_func_ip = fp->call_get_func_ip;
+		map->owner->call_session_cookie = fp->call_session_cookie;
 		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
@@ -2422,6 +2423,9 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		if (ret && (!map->owner->call_get_func_ip && fp->call_get_func_ip &&
 			    prog_type == BPF_PROG_TYPE_TRACING))
 			ret = false;
+		if (ret && (!map->owner->call_session_cookie && fp->call_session_cookie &&
+			    prog_type == BPF_PROG_TYPE_TRACING))
+			ret = false;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 		    map->owner->expected_attach_type != fp->expected_attach_type)
-- 
2.52.0


