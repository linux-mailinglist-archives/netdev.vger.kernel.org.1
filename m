Return-Path: <netdev+bounces-255660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CwIAdGSf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:52:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7160C6CF1
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2A413005EB4
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73926B955;
	Sun,  1 Feb 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9KD9gN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41254283C9E
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968273; cv=none; b=GNwhAjQMftlER9Xc+A/0nYtNGWd/HKhWzNkxhRl/2vW1nAaJsMNihL9TvkwfvcWdMappdVumnf0n5+/W+o2F/nANuq+8m+iQfCl46gLoi2SU+zON0fwgjSmhp2lY50Hvvd0rP/Vu2XOttOUDhvD+9LsFrZY7LQ5Idna5Lq1YMrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968273; c=relaxed/simple;
	bh=6kMSHY69ShPBtgu/4LR3AsnJqQKZdPzU1YywkA98ha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw02CfIImKteHfjJYQZcdnl+CBJ1ZNFOVw9ZMtckl4lZ4M46GrQ4G3+Vdnsk/pMDV+gTOot0l2hGCs8Pc9dnHLalBWD0Btk8OB7iI70xpjdevcE8AFqiNg0hp6OkrJvR5e91qiTsSVi1xPKA5qrfTf7HvRviPu1LsQdcy63UTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9KD9gN9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c626bd75628so1325339a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968269; x=1770573069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=I9KD9gN93bvkQRrdSdophVPtrmuCwUCcfA+VlWJD2AuCN6zBjeRXZEG/m7VI2PGSzk
         AzUmHQ2uYZOb5yb9fH5FNfPTa54ZM28GTXy9zytUHwsX4mAFDIiFBCa9nbvebe4efywQ
         CUX+uYOuSNLTcbzaNrYgJe0pOKlyNuPwXQiy2wLnmjFmImft+MpJIRbum/riNH1lTPev
         wEb9KUpj71W+0LSjah/NmyRHGDgenfMj9sBTwznq96V1w0C+CSyIgzKYAYuHq36On17C
         9o4cdRdsuJ63lF1OPud/l9KSM0PWJOUlYgb3KPWqwmxRoQq8Z//pkp+KzP55nC0q8sMh
         UxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968269; x=1770573069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxqS/tO+I6m5D9ZrvXJXIDaZLXu0H/c/z+YPwf7tqnU=;
        b=wqmYfuTqon3SQJw3sWOcy47HyOzct7ghfFE7IEyCiDcXu2qTB+TLtjOqWTsTQ590+S
         0+l3aC0PN79aVZ1sLEBOvBZFLx6SVAWuLvv4cVVp1Ltd5pt2PKyySDRvrTEu9EwLxEza
         m4SEIWZrak++U8WNAyfwQ6hOQphIvBVk3JDfGIqod8Gn84LF76RCL8m8dI1aaZ17CT/t
         DLnBg4p9aN7IpHzObv9hyFr8wpux6GMHxORq7/NWGzhlXTUANJawAsa+TiMQAQtGdlff
         eGgvLxp7wIOI6GGnS3ZWljdeAKDM8/62oowu2nsWk+vueYHajJixGIs8MYoW5dB1BzB8
         nicA==
X-Gm-Message-State: AOJu0Yw+4/b6lS05QrdSLKg0t+Se9mgvw92ck+dWJnAnRFBqB18HToaf
	na3wfKgXe73YKXPxKeFZ8HWzLOIzmFmJp1a9ZjiKqqQswcs8wmgxU8oX
X-Gm-Gg: AZuq6aLGIHppPZwQDGtBWgijoFpqL+1BnYg1AzNYlvvv8Aat6eUf5syWnhqVMjtD1f4
	sQeRLxpVJM/6nuimG1/zi+uk0XY62Q7V/tMews0VuBfu6VhpLG0bAkCoIgO+tCBboToEJ3tm1eS
	zP3gKA1I+qQmXfUM602Nh54LP7Td/CukeVvyfm6b7p3V/WHo5mRFwQx2fHn8Sidz/kk0bLp10EN
	MuHrGnRxIbkCT/YxG34GSfeVsdt3o35aFjgfsJfwhw76lIXZSG3uhuk0zhu2X0QEcCS2wnrI58O
	bfTXF8uWsxzgT6/0YhRiQV+nqBzj8pu4zkA+pqVkQNKCBI0wkxFh79HRSz9Gcg7u68PSgXjge2H
	3+YGOBOSRA/Z9bHa6/rsQj/MnmsAVsGach9c+WG/l0QJGVsrV2DVqN96G/Ml8wUBcIgLT5E89QI
	X4Hw==
X-Received: by 2002:a17:902:ef07:b0:295:99f0:6c66 with SMTP id d9443c01a7336-2a8d990b344mr106313665ad.36.1769968268671;
        Sun, 01 Feb 2026 09:51:08 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b417394sm122466005ad.42.2026.02.01.09.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:08 -0800 (PST)
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
Subject: [PATCH bpf-next v5 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Sun,  1 Feb 2026 09:50:47 -0800
Message-ID: <20260201175050.468601-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255660-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B7160C6CF1
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


