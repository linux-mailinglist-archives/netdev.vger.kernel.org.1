Return-Path: <netdev+bounces-236569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78744C3E083
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2723AC47A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666912F5A11;
	Fri,  7 Nov 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfKs7eKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED482EBB84
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476599; cv=none; b=TrdLjBFDLH2QW5qbuczdfSjbiccDmcxsJClJTzsvguZCmelZxVLvUi4PGcZfIohmQcJLAgPzAtn7SnmDCVQVTLHlE9agZehHMCuBrnCdQ2w4nFPGROzrSGLZ+EWxzUjX/ywq8zKSfy54dyn76DitEK6RERYNzEOg8idS5Msd0vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476599; c=relaxed/simple;
	bh=4uCVZgM6UeuQx0XSrGdd9WXjIqluMM3jZUftpCJANAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lr6hLRezOUKMoE8Bp5i5n+25nP8xfpdmBx6pSd0NgCZTX2uXPwu36xRtimcxO+Vq46pNPi/qJmfdI9t7KMuPOzP3cT2snFap0uRAK4alwLnJ5xOmvCHlZ0KZs4AxKgSP6KlnieLLrLBg4IYhvT+AjXkfPwqwAw1sBBa2/3vS8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfKs7eKs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29524c38f4fso2417815ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476596; x=1763081396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=jfKs7eKsSRQ+QZYNuOQ3Ewg2uyfpFtWMekNrVmc0lq3cCBiBYHuN8FLOxErNTJQUFK
         Lux8ahAkQVcgK1ZWE6lmgd14rtmEK9WYJIb3UFqjuUV1w+r74RDFtXylyxtR6VgLfKPS
         mTpVXoc41XQwL5RSXmLcSXubHwyylHakv/aHC1hDQ/764NNF1318Jc0nl3YlP9sZuUyE
         tcCdoqd1dJq8ORpBxZnBX82Kxj78WQavRgk6Zbj82tOXfZOMMczMAMLBOyEg04Aq4ooh
         mDFFVwqrzse2OkRqQIyvmR5Vap7rONja74UgKCoVUAfAs4QAvlvsw0mv3IhKjEYXZSgD
         Jacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476596; x=1763081396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ijXE7xEmBTHmMpA+2gEwbQm6yVHcpL7r2RPNx0k5rU=;
        b=SQebo/boLtmWCZ+Y1sLC43Qut/0SX1YD1ZFW0+/faKOXKVLHOyg7n3qc+qb7ewwzyE
         xfn3bQ/kBwQyTFpeE2VqLNoWMOFf/54rrKLSvxhZGqI2BRq9Kl8ztJR167Y7+HOGGjS1
         rolYhh52Pg1JEfPg2zwCCv+i2CK7YdCj4F0sRXgHY1zPs2OOPb0p2W6QjZfTAmjtagfW
         f1LbnldMQlTb3Go2LdHRRGiBhlSABwNSvOI91y4Q3AlrDppEzat4c7RRg5pRK+ujt6Nn
         FOMhu55YPCovLYlzAo3X4RphatOHbpw6mAHrbcGl15pcyXGJNdUVZMF2I9fvI0bOnfWZ
         Gzeg==
X-Forwarded-Encrypted: i=1; AJvYcCVfPaO9kILC6COMnT8e+6TI74LibASDZRiQb34WyoWLrxoSJu+o3E3z4F56i3lge92KmysUkmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYh3E17tZh5WXzWj5c/8FwOB8oBAqCKKcaMeMm5MYVLXc/rp6
	oBE3JK93a6e/JpbNZ0rMQTO9cFZhgkQuAUwUT4ogfCu6yZZKuOv+ZpBCVKA1/w==
X-Gm-Gg: ASbGnct7wUVGP4+7xxTKQc+skBvhGzr6pldPA3XjnevOntAcaa5/F5PSo8Be0EweHth
	Y9bdEdkCtPGmwFV2duegp+m5SBW/KobNzM2ZLLrI2VlCllbrafIJ3gxZuDcMhnhGd1pm4kza4oI
	sUkxUS3eAFIVfxdQ04wg2ao74afBM1wEvL4he80jQJYHEAsWNuUC6IzNsvGkvsV238UShfmz0Ic
	ypCAwsJbtluOT6rs3+0F+8nI/nyOC14y+miWDGKNAHah5qT6oyx7fNfM/E2eDX+2/qXPFGigvOp
	5dsVUdu/po1dmKNDmAJyfxwRoSgyLdrPE0g1iNZZ7w4NBiGGH0jPmH2fMs9fPsWh1MbonVIQez+
	Corc45TbM+WEYJ1hIjT3VXFhgI5HRo+KvGbPp+RGAY3JQ/EqSCNHrlIsKnjBoYojhg5DVW7wTXw
	==
X-Google-Smtp-Source: AGHT+IGDT33BspNwLZAZGr8rW1mWSoTCi6gvaV3hnBfSUxt42Bs8QnGChK2Hk2M/l58MMqK2S4GupA==
X-Received: by 2002:a17:903:1a86:b0:277:3488:787e with SMTP id d9443c01a7336-297c0389ec8mr16267605ad.12.1762476596231;
        Thu, 06 Nov 2025 16:49:56 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm40974195ad.11.2025.11.06.16.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:49 -0800
Subject: [PATCH net-next v3 05/11] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-5-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a461ef1fcc61..ede74add070a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -246,10 +246,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


