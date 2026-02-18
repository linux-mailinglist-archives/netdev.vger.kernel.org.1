Return-Path: <netdev+bounces-259365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMUeMNY1lmkkcQIAu9opvQ
	(envelope-from <netdev+bounces-259365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:57:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C9315A758
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E02203004DA9
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1F3346B6;
	Wed, 18 Feb 2026 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xnJ2uaJo"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672633291C
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451845; cv=none; b=fFjzwoyEs1rvnBn9DYNol67HaCTstUyhQ2IoCvilDQvyk8hXXYwo7yc1Y36l3rprQ1kAxaaTo758GCsI5NM15DmtXH0NyQ3ZsExCEMWuUsyln4xfgr4z4w1dI3A1AtKEJdX063jhxqzohov78CtduYFiK7cvi+QbKudreVC7Ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451845; c=relaxed/simple;
	bh=c+WDXqM8sDVsswRFsMkOu3/2l2Qz9rVh8qUGLDvOZ/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk2U5DDy09w5cHwFjg6hYF7MIn1puufyYoDubfSOaB2gvbK2HTsWQPIBXGc8b2dC5UwrVK0nwgHqeqEuFHDJwKHb/PAy39VzNRNuDZniGalKeoTlJ5pf6zzeWKD5RFodl6cMuior9xZ/QAG1qFZmB3efTrJtsURFr+ekajWzpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xnJ2uaJo; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771451841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikI0dMYoKsLjRMmywjlbASCgYtr3sLlx0NAOlszAzGE=;
	b=xnJ2uaJoL+Wf0+IH7biH3dk9oy5Vgqi87x30B9JUVeK5HwNlrFnsMV+6FLDxF2yTgfEDzC
	eHtrIuWrsPiWzB0PgA5Rh/IWWbGkSIDrwMV3UWjRrIiEcuXzkBY7ee6g5XxfQ8r9h9zwIp
	9G4WWxIYW0WTA+daBlU3gBoJHlAvHs0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] selftests/bpf: Use vmlinux.h in test_xdp_meta
Date: Wed, 18 Feb 2026 13:56:50 -0800
Message-ID: <20260218215651.2057673-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
References: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259365-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ihor.solodrai@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 32C9315A758
X-Rspamd-Action: no action

- Replace linux/* includes with vmlinux.h
- Include errno.h
- Include bpf_tracing_net.h for TC_ACT_* and ETH_*
- Use BPF_STDERR instead of BPF_STREAM_STDERR

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 0a0f371a2dec..fa73b17cb999 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -1,12 +1,12 @@
-#include <stdbool.h>
-#include <linux/bpf.h>
-#include <linux/errno.h>
-#include <linux/if_ether.h>
-#include <linux/pkt_cls.h>
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
 
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <errno.h>
+
 #include "bpf_kfuncs.h"
+#include "bpf_tracing_net.h"
 
 #define META_SIZE 32
 
@@ -42,7 +42,7 @@ static bool check_metadata(const char *file, int line, __u8 *meta_have)
 	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
 		return true;
 
-	bpf_stream_printk(BPF_STREAM_STDERR,
+	bpf_stream_printk(BPF_STDERR,
 			  "FAIL:%s:%d: metadata mismatch\n"
 			  "  have:\n    %pI6\n    %pI6\n"
 			  "  want:\n    %pI6\n    %pI6\n",
-- 
2.53.0


