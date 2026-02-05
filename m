Return-Path: <netdev+bounces-257003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLiYFOFBhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:08:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1C8EF496
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A97A3059A77
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CF35DCF6;
	Thu,  5 Feb 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrPQlRze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71935B62F
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274946; cv=none; b=HEF6lFAoBu3opfObrf+WCbx9qHJFKUkAdALpcbIR06vaZIuriRhDn0uRODPVae4cS1sQWSeFTI+4IOffimR7hc+mJGtIY4crYAZixqvsNpJ0odMlM6kkJq3//sFwMOzFRP6Ey6h0z5tavrNsB9RW883727BwJ/93+hT+gqvQLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274946; c=relaxed/simple;
	bh=6kMSHY69ShPBtgu/4LR3AsnJqQKZdPzU1YywkA98ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBp+gaeFMvGvzscyAsj9Vm2jbtyx4g3vp6lKCm68Xm8FgwyIaimc7lJrMJzz6twNvQqyWzCDgpFYQYLiaOR/V+7fuItD4ja3P5wIF9NDfHfa9/Jlzi5J8vD/OQGt5mL9KIi5WR9LqaJwv2iLO3sAjQ/wD56tE6EmUuZqOcIEFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrPQlRze; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a94450ae14so2855355ad.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274946; x=1770879746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=KrPQlRze8knUEmh1JBmE+etq1SghyAfxV9E2cCiWicA6YcyQxA1pjMPqvRn5u5S9Zj
         lV1RbEM3AW5med+z1AI8+DwIBWWmwb5L/Xzh+UCHEyAgtdQ+WshEDZWAgH7DMgopRoUr
         YqVtSLuHNDNrDD39GrCSS5Gfesg6Pp+tvyikdBe83xGTdJfK6jUMMuSQO23ST2HJ04cS
         tokZ1v0UjRPvW8ywdA3k3UWwibaouYBOcfuNXycCz4/Ef4oXOsduvCnqA7M15R4USZbd
         i+qofszbcZusOpujUeBpyuShUjWLEFeAJRuWlgUppPLa3PrzAh8sE3G3etksx2WH+rX9
         ByIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274946; x=1770879746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=Bt93JHALxOomvewYs71M8KI/PLjjSUf2Ast0loRBTvqQPkdAG7YCtwqjFmZbiUDNq5
         dziXVWxzWzIAE+jRv2BhmDf9NkJC3jf5M/3wQfJEyljodVmCIUbe3Mv5e44rjfRo2rNd
         uLygeX/Nfy8GEb5LsM0KFPVXduX11TayNSbJ6kTVgFL5oMztLVmRdYZxTWmCETUKKBTd
         mNgJTvpJ1qnLUeaHOsySTPbaUO0a78rf0I/803MnAALlIP8K2O2EEObjAznpfQo1GomF
         AulMVL5hr/6Xs1z7tbyAW1HRF50iok2Ejqr63m5vA2fNwPk489KWO/Nq1lN7GoEaftuz
         MZmA==
X-Gm-Message-State: AOJu0YwTY0ISw0VR6et6XQvJ7cPeVpfNm2HKIjiWS98qEwwGe4poBsGM
	ToVKhYkSWQZkcOjE/n0hGbYYHN7Jh6piZ89wT7Opeztvnwh/Afb5lWWjcWtJ9w==
X-Gm-Gg: AZuq6aL0W+9KFK+Ib0B4OOPqxtyP5aDT4/9+Etff95x/ixSadvMDP3C1Vbcb2hUyWdi
	ACrrQU1JmjYY+4b/RJX442NUC5N4QOpp0VIOYhdU8+1rTsggXm+EAHu7J18jYBbSpB35vtkWG3z
	XwaMweuBKmpp1q/xvxQ2wkIFWxB6FxOWQz0JWVfMWm7Fc+Rc3ToAT7atQGfgD09D3n8yxJC3Sj9
	g4hvO8+V3XsLxY+dLDpMBxD7R4ss7puQ62Y7Oo6+xUqfnltSosl3cC8kNJT3hKU8HOGdMpngoLj
	EsGyskMjRTwWWcQqcGB2NKDygsIz761huoaanSF8wzhDblp5ifvUYZie0h9FaWPJJnUPu0Vwp8I
	ehXgfJ7KjVm20ol1QG7tGU2Hod+ljKyrF2LN7kAztAVEJRXo9nKTDo6PV24AhZNKl+kA9VoMTm6
	U5
X-Received: by 2002:a17:902:c411:b0:2a7:9b6e:33df with SMTP id d9443c01a7336-2a933fb25a4mr63450675ad.35.1770274945658;
        Wed, 04 Feb 2026 23:02:25 -0800 (PST)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338b71b7sm39950475ad.44.2026.02.04.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:25 -0800 (PST)
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
Subject: [PATCH bpf-next v6 14/17] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Wed,  4 Feb 2026 23:02:03 -0800
Message-ID: <20260205070208.186382-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257003-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF1C8EF496
X-Rspamd-Action: no action

Adjust the error code we are checking against as
bpf_task_storage_delete() now returns -EDEADLK or -ETIMEDOUT when
deadlock happens.

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


