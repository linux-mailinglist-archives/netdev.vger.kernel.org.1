Return-Path: <netdev+bounces-257005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAqHFx1ChGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:09:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB35AEF4B3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50EF63022F69
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7435E53A;
	Thu,  5 Feb 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Ut8yYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607335E534
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274948; cv=none; b=KHKEdO0WCRZOp9KdeO4T4PAtCDJxNTRLc6fXuejPqH06SFxUsTFCZXN8Mozz+bOMGAr2Pxkr6kWjm/vCrmYuTaUQhd8qiJ5OkHvhFT7nglhiTOwtFqoyD+A7q9CcyqfqNLbcPSw4u0IEXjma0hspiUcHvu+Uje78q4P3b5xISpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274948; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQu8J3DxwuzaC4/TzBw+iBKVrzmvxXDdjT95hcI1H0Zrg9ifoc8936Iw5eJZ1llIEsWEzJFaaqGsDN3WJDgEAomkYEgOjxPusGbp/HbMQKK2LG/afqxjJGPdwe9YMTsS//O1Lj/EA0XcJMMSI4tkKbqGUbhexdmrCSKpMy2bCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1Ut8yYc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a76f90872cso3718665ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274948; x=1770879748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=G1Ut8yYclMd5WzKdknYqLSv8BWylu+GScCux98c2vF5aIUvcrMR3e5an0M2DPXz4OP
         MF5/kO3D0nx/N+iuNJGQyZ6GGVwu1/XlmI0W0DfXzNvo5pmofkHXS7FqcxD4f+9s2MDE
         iE1tjVq/hjsrd0kocqX+MW3T7ZS56XZagHMfm9Zk7fyxPqHA3TNC7+mJgk4Tj8fPvQIA
         7ccMxfTSjPed2RCqISn2/qIfwBGq7o+p2LKzzbMR3E/jfYve+GkgtI4/YjkWggIybLz8
         qd9oB437SdKyNEuOyosdUNXmBxn0HUZjC0FtvrLOIBDS/HAFlS8PtXXBXZbdppZh8cW3
         1AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274948; x=1770879748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=duoy15DngU16seJYRPLQZmV0korAWS0fSUQnMrHjPMOholE9zL6np+1oPMmd+KLZnX
         dq9rJhwELFwrk/6rKuNS6sJY2ePtwH97vIB8HbsCwiGkIaA0uear3BOjg/XI0jsAfAlN
         6A3IFgi26iEek0ANczbOInWnNdBLjxTgvRVd3DMv/M8lc2bYRnc6ut3kWS8kJ8C27L3u
         uVgK+WQYN7r9f3WJVK0vF+nrNEr1L6P0nkXcxh8drUkwHhxu7yIsS7tZzy1DNQ4kdmwZ
         G1mDl/QGpOZBs3FcBiRC9QU0AhgL8vbkfJs5VN3KQQEwP0YHS/d2+qGy9mUVK1lmcgqN
         n1SQ==
X-Gm-Message-State: AOJu0YxULyocs2rM17cYfvJH2UV03yuFw2DPe89u/2cJHKGQj5BaaUzl
	qbHIDflj/kKVy6QjN2JZLgpYSw0caE12I9gXqT82fR+DwQ1gv7d3y8Z8
X-Gm-Gg: AZuq6aKgKS4CZGRba5YTfTioMW7mf3iMEl18agG76KM5elMzVULqoql2ldWeq5bbS62
	fH9tNY7yG07yFKYPU3PHsJ2wyK5W71bG6m5g4T/KEcyX/Sv6s5TSWKbKOu6oVpZcK5MJE+dXqPQ
	JaLVtbXYUgdpMydUbf7gnk38qO6g7lba8w7QyOnJGNkP55O4PCg749jcMn7cnCWiN0iJA4m7LZf
	06WpgsNKAHKkItND58vGWq8P/cEqyk/x8KkA/0+lpwxu+mMsd6GJ7WCB07c0YDPUarcfmYVN9W2
	/rmXWhbU/dNYuP5sfTOfWBh2vm+s1CQ7R/e+K/YKlH5NKwpKp8TAMZYp4R5XBmwU6dbURXnADTg
	IpK3xq4ocTq+B/0VquldBHHjBzHHRL8W+3WDBUl4mIYQu/kQECA/15hpmN+8sVdRWT4ZP/5UPOs
	Kztgq9cYZai8g=
X-Received: by 2002:a17:902:9888:b0:2a7:73d1:b2a1 with SMTP id d9443c01a7336-2a933fb25bdmr34435875ad.33.1770274947997;
        Wed, 04 Feb 2026 23:02:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338b71acsm48072095ad.45.2026.02.04.23.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:27 -0800 (PST)
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
Subject: [PATCH bpf-next v6 16/17] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Wed,  4 Feb 2026 23:02:05 -0800
Message-ID: <20260205070208.186382-17-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-257005-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CB35AEF4B3
X-Rspamd-Action: no action

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3


