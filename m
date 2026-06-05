Return-Path: <netdev+bounces-295947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zH7/G+8ZI2rXiQEAu9opvQ
	(envelope-from <netdev+bounces-295947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:48:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1627664ABC7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:48:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oncUyvsl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295947-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295947-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902E83052B5D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E167C401A14;
	Fri,  5 Jun 2026 18:35:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF463FF1C5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:35:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684559; cv=none; b=HwWzhdfXJewB+obvtmc1wga+pBYtprCq60ZkCAtuT7TLf6U87ud7kn2oXpMoVpDK+MZM+BpZMEiZ+ahL1RQ8NZPunPLEhpOctBdrzosscvA8mgSJx58EN6gVfUkHxnRifHp+E/1QswRbegRWL1QnUn61kRVvVxJ1a0e3FF2gV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684559; c=relaxed/simple;
	bh=mEvyukhAhdQcXVildxDzfDWhPWDo3cluDvmrIumRn2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlTAIhbmZo24kmoMa3wYUS7Lq1ZiWQr1S7O6OeF0BjT3Ni+bs8PK1M8ZU2+j1IkwmHZLwoCuKD6ebCUUr2Cro+DsgRa5ThTa808mZOWUhOcDuJSAV9SyuApcTj6noIenEJheo1bNDe6U0Pf3bbnapzjFi0vR7NYDUzbV+mLF6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oncUyvsl; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422f148dfcso1246987b3a.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684558; x=1781289358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=oncUyvslSx96Q1sGSO7xhrtL3Y4JZC4x8CqaXNadr7ERZ5lB8tPp+Rs65No2FbPtWI
         CfUPzYnYEZvqGMmo/NqZ5XsVat3PhYEVRSP7k2GOoXYT0AnicdGTgloWlWHLRHguFPPv
         fZBXqX3KNIyCjOaYX6w/3fChPXZeaNSD5AiCElcr/NR5T/ZZrsnhBrciyLtO4ROz/7WV
         VlFSUtZZ8nn/MuP2+hV7+rwk07kZ0NcribPOHl9UU1reNx42MKZ8ojLThVJ+X5cpaeNE
         2UH198Wkll16uT9grjv1p/f6LoNNyVm+A6ng/w/2ELPo3XRe1zoBvcQ4Qu4KsiLQfAmn
         ODRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684558; x=1781289358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WskOQGo0lDwUWYHDxbKfENWvvFNug6jys3p8dhOE0vs=;
        b=e59kPcjwW3uMYl5LSe/0PyRHCruM1aPYzPyj7bMf4q65Xm0oNkqdOAGNNH4yBILqJD
         xADlQ1VJuCsmdZgnhbs1Gi4weLEWFG1DdCJ37La3LAdEEep1n4HF+wctpksQj0FcWz4a
         n6A7Fk1h4n41XJfyy0LXlAwvHyQeWmD4nYJidhyIyHJybmJQs/6DGHMht5Gr9UcFRzD1
         WvvCGBs6XRWM43RuZ/M42VMfNluAJJ1g3+wRxvKr4ThAKqizvWHjexD0MI7MPXhJGXZ1
         IQ5cF6BhDc3cQ1xk8ZKSyXsoT97E38ZPzxANTj+Sym8RsOSScRyNS0MNZs4CfO5VTl2F
         Iqug==
X-Gm-Message-State: AOJu0Yxr90m/1beooFde7V37BKct8xzYDt0SZ1ee4haJKlWRXjGSvAOy
	FgpyUzTTNmShQtVMNbdgpkAQ8J8YyjLA724xgbXNuGO1Srvu0D1nABqj
X-Gm-Gg: Acq92OHbiaQVCidYsGz7nw/4XBfZpPsnQP6Y2VIrrgbPLMjB5CeZUl6BC4BmFcEMOHy
	US08HiQAU52Urp9atk97R/u/wT45Oqe/y0nEegSGg0v6dkPdi+NINTrhkcvufhR5wjJNkF0tDKs
	szwcT9QiRW200Cb6v0ayOlT5m3E/5HcE15DiCNBnAi8db4TpRtWNNZIvDxGgbCSqyy7on7M/yuC
	hs3QbwfivJ5sSUt4Ecr7JjWS0HDbcKP/2lRLEtrRRZpBkxpTi4aKUHiYvV8Ybcj8TceqUxhzuMu
	RTFdnDYX6mg6GeJgB/C1bz/hXgzzLzehYASfCi4saxyNmBxYXVxcRDR6nev2DsdHsWTc1eczQkq
	bp8n/In0gLXU8RIZNPa6ArNdJ2v3vyf6tadX7IGHFccFS8VvC/UGJq2rswbHpmdx5xpahudp7+c
	O7Kk53Mr2ZzRdlLjIKRct41itw
X-Received: by 2002:a05:6a00:4216:b0:835:41f3:f440 with SMTP id d2e1a72fcca58-842b0e5d0ecmr4949646b3a.14.1780684557646;
        Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm10586252b3a.15.2026.06.05.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
Date: Fri,  5 Jun 2026 11:35:51 -0700
Message-ID: <20260605183551.969144-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295947-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1627664ABC7

use_file_dynptr_slice_after_put_file() reads the dynptr via
bpf_dynptr_data(), which always returns NULL for a read-only file
dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
correct read API for file dynptrs, and read (rather than write) the slice
since it is read-only. The test still fails as expected.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index d5fae5e4cf9a..3bb9e2612f8f 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	struct task_struct *task = bpf_get_current_task_btf();
 	struct file *file = bpf_get_task_exe_file(task);
 	struct bpf_dynptr dynptr;
-	char *data;
+	char buf[1];
+	const char *data;
 
 	if (!file)
 		return 0;
@@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	if (bpf_dynptr_from_file(file, 0, &dynptr))
 		goto out;
 
-	data = bpf_dynptr_data(&dynptr, 0, 1);
+	data = bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));
 	if (!data)
 		goto out;
 
 	/* this should fail - file dynptr should be discarded first to prevent resource leak */
 	bpf_put_file(file);
 
-	*data = 'x';
-	return 0;
+	return data[0];
 
 out:
 	bpf_dynptr_file_discard(&dynptr);
-- 
2.53.0-Meta


