Return-Path: <netdev+bounces-255358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHo1JpuPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:14:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1500AC0B80
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C284306B7B4
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9332B9B1;
	Sat, 31 Jan 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwyV9RkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4033C190
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836179; cv=none; b=WAHbQgVZz8jOjxJjGxUk5iLR6G3S1xrGJ616IR4OTqkP2QhybjGgPrd/7jJeV/MpETxX3jXvPKgSeuPar2ZSiIUiJRO0NsTIALeZf3BnCGIPIujRJmBxVAN8MH7XH2G0CIjfNi3JWGUs4pUHwlBjJsrzEf65YdphDIBJNxEHAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836179; c=relaxed/simple;
	bh=An8BnmX9Br7RS5E/JK5+AuLgGH68OZSuI8tJGKtCb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlgtIq/anZVAdhCJJF5BjqS/Fm4MQ54EURFdmMZuQp/7D0OwXr+9xgOEBBQttKD7napQw5sYTX2GICDIOYIxGLd6SYojXQK2o96ejKhxk+RyihyDT9tXYlgwQlXTo/RQfxvFUfhQQ7OSZR4tKRAh1QN21jCGQhVpVU3pb8XUDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwyV9RkG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so1554991b3a.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836177; x=1770440977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=AwyV9RkGB0dbIB+mYd2veXeggBvyLT0flWLb8gOIgnPy39rqnpJDErOSVxfoW6HusS
         Yn9LSAG1ufYzjGX7Sy3V8lUVDD1v8eS+k8tZilSft8lNNLQWhk46FjEPpw3u254SNzdP
         fctW+mdqB1BFGlkESn6uLJwwCKINPc3lnoTKZyswta43NpgoEuRZqqsRW2yPKO/Yy/zO
         tQvjpfKywcyuQzfagRxxfMyd4OXHJPYzdHs9V1KEPFZ6qsOqlWFnQBZmTOsDKFSNapn2
         +Hj8pZJJys4FBv5Obrlztv53PJJ4r4BkGgIa+dGpYWj0dJU4nl9caRUevfU9Cdjm+gh9
         EJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836177; x=1770440977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=iu/lXgkQ8tXHlaq5g+En775IsxM8uuoMsJZKfprD258I4/bmJpwPLzwh1yO6rvZa1z
         zoITzijvQePjEt0SLTyWlsCwwqyzOWxlArsDKiLF/D2vcqVhdTZABDCltS668w6/c5dQ
         lJgW1/Dl3B0KUv3GKS5m8+D/6Kyx0Loz+Vgb/pcQFVKWJjnKM7sfRBTVGKUsOSNFAV32
         bSwFJnaKo3fBz+SCTP4pzLtMva4xSrAHl1PPhL4jfKOaOAqmNLs0mXrWGjM7unTbx3aI
         TWkfeR+NW4nMcPfv5VRLRA5z0j3OOX34xO+6Un0YAIPr8iSKJvxpQZ1Ndh7MHy3apm5W
         NIGQ==
X-Gm-Message-State: AOJu0YyrMdfcI/YgYylEHQauCKIbeblqkbliCzx9PpxuP9mOlYw2N+/P
	QcwMheKfmgorHsVdX3NWYlopKyg7yukMAtfDAaIkogqB6NO5zFN3bul9
X-Gm-Gg: AZuq6aLBgm+Z0udrVq6ZwIDAm/MSevj30B+OsBf3nSZ5P020avEkCXAc83caD+TyxQq
	AB2zyFPmaXkL3i5GZU+tK31zQeLCmFZvs8U400gAdBofYXW71z4Hh9m+IRZv3utIefq5JS4JVNf
	8RmzXEUX9OWWj4YPnuYMo8HyJSdKCr0YlQNtHutPXePg54z5dVnuJkxgl8Yi+rf7i8lYnEE2KvL
	k/yfpDkExi950jNGxEWbI4OecaEdcjARDN8sR4OP1H6E94IQqZ2a0SlcBC2+oqDyi9NeKf8secz
	5mcbwzXSiMQwl+iJZygLp9RRDdDx4XQHyppiaMvLRIYSeW4ihb6hFSEf4J05PUwUxeDKarRrM+k
	QkiL9ZVO/JAhjZsw843bbFAZx2EbYFVq23WjXI0AcFCPP5Hql+Q868w0fR0mPMhXIyxmPLTFxLe
	MDZgIckqqAX7ha
X-Received: by 2002:a05:6a20:486:b0:38e:8878:91bb with SMTP id adf61e73a8af0-392dffd9db4mr4756810637.4.1769836177232;
        Fri, 30 Jan 2026 21:09:37 -0800 (PST)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3356b4sm8859134a12.17.2026.01.30.21.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:36 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Fri, 30 Jan 2026 21:09:17 -0800
Message-ID: <20260131050920.2574084-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255358-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1500AC0B80
X-Rspamd-Action: no action

Adjsut the error code we are checking against as bpf_task_storage_get()
now returns -EDEADLK or -ETIMEDOUT when deadlock happens.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/task_storage_nodeadlock.c  | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
index 986829aaf73a..6ce98fe9f387 100644
--- a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef EBUSY
-#define EBUSY 16
-#endif
-
 extern bool CONFIG_PREEMPTION __kconfig __weak;
 int nr_get_errs = 0;
 int nr_del_errs = 0;
@@ -40,7 +37,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 
 	ret = bpf_task_storage_delete(&task_storage,
 				      bpf_get_current_task_btf());
-	if (ret == -EBUSY)
+	if (ret == -EDEADLK || ret == -ETIMEDOUT)
 		__sync_fetch_and_add(&nr_del_errs, 1);
 
 	return 0;
-- 
2.47.3


