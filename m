Return-Path: <netdev+bounces-226463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F056BA0B8C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 19:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C2E32302B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E7309DB0;
	Thu, 25 Sep 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG4/9Smv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61130AAC2
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819619; cv=none; b=h7u6q2ryn2sMw9Grv3wIEPzWsdmARQprDs4Vlxi/xj0KeWlnYUW89+nEEpzNAvC+nxMvkEpcSOi4gl5IaAmF7W0MRAV41bWJOnk8SJPne91O9E3NoiHinXxRwVmdq2PA9tiEdk6A+/Ubg8ohfNIhDnajMZQdoudsjLxuTRyjofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819619; c=relaxed/simple;
	bh=WNxAnmCw4P1TtKlBwI2Ow+v7MaCfjNgBJ6uifpDB/70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgwsnxAfCr7d+rAKYwb07/VgDozFfwlfWW4Vr8p66/yk0aA3ixGA1Ay3lqvSRsc+VNJYI6s3XjvipkxueHmMX7P73ly/lpCpTsC3HiX0RcPv1hkqucD2Y7olXLFk6x7Tj7k04WwN19oonZ1KxdTasQ5kOdk/Y/aqCMusmeBkYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG4/9Smv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1230560b3a.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758819616; x=1759424416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ5kMbOBwIZudleYReSesMHzWocvI5qVkxY80vlrovE=;
        b=JG4/9Smv0i9lA64Q928iGiX6nn/o3A2O6sCpvHqXfGj+D1rh/UpNE8Mbx9j+MiJVtp
         WFWbTPz2fui6R8OOD/luCjoO8SaeAsk5iH/x4PKuHDOVpoDcQXCRkZKt8oAo1PCrtjcJ
         csyNLxiT/mFSm5k48YmW1r/+I0TEtkoXlw7UCngpxz9Y+Xt3r4CSy8LX1xG8s0z88xST
         Dv8xy7izmRZ2pk79dpKGPVfatkv4pGm/hMcwD58U54mRHedaQ9H2W6IIlOVWISBS9t+j
         V75hIUyhhhlWFMmBuqEIa0MhO5yxv6KLqQGgleBKdsn7ehpJbPDZRJ8awB+fbOQcNLNY
         Jwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819616; x=1759424416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ5kMbOBwIZudleYReSesMHzWocvI5qVkxY80vlrovE=;
        b=lpkYJEClx5iLPePrwDLqMaGeMIgFC/GyAglc1gBVjJ55vGjfWrzy58CDNjqzOKLVCg
         9tbyENlLk5nWvpGEUE6GApGP1Z4ktuqMMsqhVa78x4vUp/QSYoRUXATxk94fCvW54Fkn
         reQwWESTdi9KN5T2uKFkPMXTW1jp9Akr7h1vjW7vodwre/RouN18rJ1cglJle2d/sGv6
         BMJFVmiCPunSAKhZW48Eavmr122RCawXH7dw1rZ3OJA3jt5W3sHPNjaRaksyey2qfDWs
         fKMZ8I61Sx704QB/ci1XQYXHcHO1QEUrr1eh7UmqMFlBMjIUGUDrcxqjwCJmgI4SIW5z
         LlGg==
X-Gm-Message-State: AOJu0Yy2e6nnXnv7gCkNhPip44aAvXFDoCDbj6n8+h/Q8HVBshKDbQvm
	bbWOxsmk1uDFO8Me7cBWiwxE8y1JgDRAsfRtNQqis9xndTWvD7YqG4Zj
X-Gm-Gg: ASbGncubMlXHdddEmKuYvgG3H2HC81FxnWLUpCy72thSF/m09rDUVGHOAdyuQW83Ary
	6s0vHub1Jyqwoz+HVQUmKyu0C2MaxUqqT1MI68IAl8/2UOBGcf7uZ/6rRzSyNrfez/r81m3nmMz
	epiGcYgx/FiJm2gLpoTU4Fh6UTR2YX8hABlKz/MMHHeUDyv4Ka8eMyRQdWZW4r45ySMBpBWY1/v
	svw5GY/lKZhJVjr6VHLmNobetVD6ZzNoU7G7EjMV/YyhG6qz/tVVhQIKMTitn7UC87Wv2NQscX2
	cRDmD6SiafT6PbbPX5livHxAwCZgkDnyOhrfHYt1qT7FG1O7kcIzTmKREPtJ1ox70Sr92ThZcJr
	y/FzU7Eoyf/Qz
X-Google-Smtp-Source: AGHT+IF64W5FA8cGGFwXqDnRK2BW/s5biCaOMMt7UPRhhyPKNl8ixpKfpsD7Kltnj/s+mxRuFg050g==
X-Received: by 2002:a05:6a20:d305:b0:2f1:302d:1275 with SMTP id adf61e73a8af0-2f1302d14d4mr1255040637.17.1758819615743;
        Thu, 25 Sep 2025 10:00:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023cb593sm2434880b3a.39.2025.09.25.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:00:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test changing packet data from global functions with a kfunc
Date: Thu, 25 Sep 2025 10:00:13 -0700
Message-ID: <20250925170013.1752561-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925170013.1752561-1-ameryhung@gmail.com>
References: <20250925170013.1752561-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier should invalidate all packet pointers after a packet data
changing kfunc is called. So, similar to commit 3f23ee5590d9
("selftests/bpf: test for changing packet data from global functions"),
test changing packet data from global functions to make sure packet
pointers are indeed invalidated.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index bf88c644eb30..0bed5715c9e1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Converted from tools/testing/selftests/bpf/verifier/sock.c */
 
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -1068,6 +1068,34 @@ int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+__noinline
+long xdp_pull_data2(struct xdp_md *x, __u32 len)
+{
+	return bpf_xdp_pull_data(x, len);
+}
+
+__noinline
+long xdp_pull_data1(struct xdp_md *x, __u32 len)
+{
+	return xdp_pull_data2(x, len);
+}
+
+/* global function calls bpf_xdp_pull_data(), which invalidates packet
+ * pointers established before global function call.
+ */
+SEC("xdp")
+__failure __msg("invalid mem access")
+int invalidate_xdp_pkt_pointers_from_global_func(struct xdp_md *x)
+{
+	int *p = (void *)(long)x->data;
+
+	if ((void *)(p + 1) > (void *)(long)x->data_end)
+		return TCX_DROP;
+	xdp_pull_data1(x, 0);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 __noinline
 int tail_call(struct __sk_buff *sk)
 {
-- 
2.47.3


