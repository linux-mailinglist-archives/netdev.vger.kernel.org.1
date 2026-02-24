Return-Path: <netdev+bounces-260570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHmLGcPGnWkkSAQAu9opvQ
	(envelope-from <netdev+bounces-260570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:41:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B0189306
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AE55301488F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871C3A4F3C;
	Tue, 24 Feb 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IPsfAJWJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085F3A4F2F;
	Tue, 24 Feb 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947705; cv=none; b=FO7DPiTgF2E9ApsD2tQUUHe/SLObwRzsFbwdy2guAfRb6rH91lJrs47u7Or9TVPyx1uUuNh+ZpWp52SrvNk0gYgz4oi+lS4ve6JZ+YB5FeK+tnGyfFAsej3dImIKrQZff6aYeMLeFRXSnPUyuUf+A3DQXlaq/9o9YwLuqpZ+O74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947705; c=relaxed/simple;
	bh=bmVgVbbAsIpP/rmDfom1zRhish8zs46PI2CTp495ax0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REMf2PIylaV0e05J4BzmafOZGqdPRnY6oqnJ3VbIisjAmwF1oBLCGbyywdZ5+9FxQY1qbp/RWxnWA9z/Hfzn89o8ERitZv8ubpzQATJWs5jA1hTBBf8ofGkwaSptrGhsG8fmXYEm41uUBdZabMDcAi8OasDdLlIs5o2vqUJ5RIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPsfAJWJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUijMo22lEst1QalzzO5DxpySqFjsbDhvTZO2rndGXo=;
	b=IPsfAJWJ+bwSmfJa/MvtuBb3vU1duUHYq7tVA2apCx+uCk6ajzEFMZhX9kj2o08gLCf1vU
	8VrDFqd6fluPrDLF51sYVcR9gx29Jjn1ypzGzs/3onukFNtvyYWM8B/007eucABm4yd5sD
	X6dYtvVdD5IzOUSkzXF82m3G3/6Rujs=
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
Subject: [PATCH bpf-next 1/8] bpf: Add fsession to verbose log in check_get_func_ip()
Date: Tue, 24 Feb 2026 23:40:17 +0800
Message-ID: <20260224154024.12504-2-leon.hwang@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-260570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326B0189306
X-Rspamd-Action: no action

Since bpf_get_func_ip() is supported for fsession intuitively, add
fsession to the verbose log in check_get_func_ip().

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..9e9c04e08fba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11463,7 +11463,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
 
 	if (type == BPF_PROG_TYPE_TRACING) {
 		if (!bpf_prog_has_trampoline(env->prog)) {
-			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
+			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
 				func_id_name(func_id), func_id);
 			return -ENOTSUPP;
 		}
-- 
2.52.0


