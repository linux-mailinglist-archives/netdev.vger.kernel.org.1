Return-Path: <netdev+bounces-227696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA509BB5934
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 00:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F300819C7A3A
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186E2C1786;
	Thu,  2 Oct 2025 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4kJ0Q28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF032C0323
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445650; cv=none; b=LN7WT//P8tc9fYgluUYZfQYkrsOueswM+JYyuAx9cPTSyUtS+igvHY0ecjUTWt7dsEtsrsEDFlOTPvm0g21bXCNaw98YzEVe8a6VzHEr/9+Mpjss6utd7xdToUNeAPuUXZ+15h0u06KFr9uU/I+7bnHSC1AxQOFFh9MGLmhaZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445650; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7OJKdn9Lvu20yKThPpqekP9HIYJ4EW0rogVtIBq7dJU0wz9zqgwQD2PrxcQsWd2few5EiK/wHL7kPakG9jfZT3OZ6jFYkEG7McCvr4QDLlmtqE2+DJMwN1PWMlFNqKaqRA+0s8cYeVXxEGM3AEg92JaVzaDGqxuDQ9FhhOZCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4kJ0Q28; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2681660d604so15025095ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445648; x=1760050448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=g4kJ0Q28UKOE+u8NTSGJYLncLcOQ8E2/630/PhDirRnPmksxKInPb1JsOkaBVuxBM8
         +6AsFLkqee/GAC9gjipZ0QvOKiaVqT9J2geHwMYKktdMC5DYeQAOtPV2GUalDOeUpEIq
         Ry9HdpeoufB0Uv3MTFPkC0aAgCq8Kwq0xwqUAo1df2jTr5siILQXuu8fH3sVXq5xEunv
         NoVGCapbxJPP595+KmE1t7+cTZ98sXl1oj5HuEToBWH60SS4UsFhKlb9KIdQ+um8+Rw6
         vcoVGMs1G/et5xAG7sV+YxrpPSI+rSyVFLHthHc8I0Yg2ZDLOqsolj+HgdYvVWtJF1Mt
         D5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445648; x=1760050448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=Z5al7iyUXg52BVIwPeL2/GigplAt1HjfSke6MmDrRPU6M2gDMRfcMh27qbNC/DVVSq
         fzl/vi526cRdMvyGSdmMyMyJkPRwZNzfHi0uS6UEKaOpFE/GOmB6oRvPktIbXaKskeVH
         +e0uB6V8b+UUGU1Dzjbcvbj0RunH0+8M5rvVMaQDXgSH4tp3xlloeGE6ckyou00w4iWg
         jY5AVsG/Yjh6cKdc/bDXrBDOBuypuOgbKM3pK811mGFZitOJrtBVOJFkXKA80J97N3i4
         5L8QSjRnFEVvAsxkzH1Bbfu5SzylTXI08pSnRWjs7jeVpQFh+rlxLo43qo3pJwrzF2pt
         tzCw==
X-Gm-Message-State: AOJu0YwwRLhCVPZ5gqMFk+IQm6DZ+/N+1K2ErypZGFtH3Xeq8pVXqXh4
	m9hYZcmLmRHpKbDIdBWbBh4PIS3/4f/Fpu7xQyslQEaISjmB09RkvK9cFaFJPQ==
X-Gm-Gg: ASbGncu4eAq5Z/iceBB41qbjRcuJ79uCuy2GDT7fbyw/4IwJC6AkYx6LuwYXPOqaMbg
	NGpqfcxbcppbznCNFS0mbRJoVCZzuMiNw75vGcz4nyMPJQpLt5jkSbElTn2as79AMIVtq15NLpR
	OmrAsuMxzxpCpn+7xI/7L87hbCILx2bBh4LUX9KeAzRey21QhBVaGdzbHULxc3IV+uziVgf3Zxx
	Lm5VxPjE5U9jbZNVdqF4NQbPBp1wadtDiBof7B77Q7JYSNycx9LH/OQIJ+OTD5+a+wGkHOYWPCJ
	oC6b/Pp3PEDR6CEEUpsuqiycSfeSjeY49zMZl1U0ywFlFHnzJCriJkgMl8KflVu1H1UzJU/husn
	CzQIPHRo85P0fn1HiUkh5e9WALdCfPvl7fj9O/Q==
X-Google-Smtp-Source: AGHT+IF6X05WN5IpwEmN95+3RykBUaI/cu06lJOa928MKQCsJfqX3kDVxlPrOL7+Fwsx/f40n9Bx2w==
X-Received: by 2002:a17:902:c94c:b0:269:7c21:f3f8 with SMTP id d9443c01a7336-28e9a5f7246mr11314725ad.39.1759445648430;
        Thu, 02 Oct 2025 15:54:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5635sm30716655ad.102.2025.10.02.15.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:08 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 12/12] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Thu,  2 Oct 2025 15:53:51 -0700
Message-ID: <20251002225356.1505480-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


