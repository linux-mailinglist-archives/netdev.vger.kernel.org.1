Return-Path: <netdev+bounces-236573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA07C3E0A7
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC4C54EB821
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64782FE065;
	Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i51rLpjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809F2E9EC6
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476603; cv=none; b=d9Zhs2bP+jBwpdpyWBFWgKloePsBOI8ur5D8Wp9r17qJFPsMWeGJO1iA+FALMKHKBpy4qCtsDaWI3bbW41+kchplgOrVMgzz5s/9CMhvhQMAQANXwNIaQiuwSybFLPofIURBEvWQdKqqX+9DVioJr3SHw9mSWqSfeJ64Ydbl/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476603; c=relaxed/simple;
	bh=3X7FcSuFEkDk3JDUhogHRIfC2C0s4TSTiHdkuzapQSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRLufmgKzngkumtdf/1CJ+Je1XqeC+6QTV/4+EBW5VDIhaKjkBl41qJIYcjpFwbfuyoc1ZfmW6WHFBHAplSk8rpCd8MGO6cZI7KHxP956KrHFN09fbhVpzGmHiZLVS2K9wlJZsk+SrdywtDUdsc6TsD8Ldea3Utc7VwPOl1GPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i51rLpjR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29568d93e87so1773615ad.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476601; x=1763081401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=i51rLpjRl+DgspFfmCBoDYbYLiR68qY1vwHrcSPjsf8dYDREDmmBaHfN9hAUik6foc
         Gt1efzeGb1H9sjKH6Z3NoUff+iaG+/rKoo97q2/dZVphMKL0CIwImBkzDfdK6QbDIuIj
         7xa8dgx9H8zxnUPrYGTw4E3pbFKDbB081c5I1XYF7Y0+NJYk9jCWjN3vSCWnSv2x9YCx
         Bp/h79fRZRjpMrfrGsHytvUQIocM+XeAouur1gJZ2cdr/k1DWAkPtgFm61Vcpfb6/IfJ
         PkgLEPUq/LH2AeFLDb7V0mOYZAHUVTJmI9NM73XRDZdurqlBwHjGXtRDle8T8HkRzIlY
         lo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476601; x=1763081401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08hYWGEnuRuvo8cclYTSCBGU9hHXXt88CsOLxaqCDS4=;
        b=XSIE+ZdiPiiWj992zzf5R15BXZp9r/LlUz918651TYu/LFEAA299KdcjQ4mERb9Ob3
         GTt3gnGR3Rc+GgF/Khwf83mBqprofLDIOT8TLEoAEY4EkJj09aZ1YAuuBPor9ZKyvQUl
         3di4pWNp6jv6zKKHLRmi0CD8Ehm8Byp8ERlOI9JNuoKf0niE/EpcKmFwxGbLDA+gk0tk
         RteyjeZ12vUr7X0if1TFiwe/akRrh4lUM4wf3PrlR9sy6rOF1xbXJvahTqA8J0XwGkKy
         Xkd/PVQtYiE0swekKgGYJDCwoKxq4K207gPUAvX9CXSAvRUPt0xylfJyXMYtu8xwH5mY
         zo0g==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ur7jS4qf1Tu6TyJZCEZ6HBGTtqCPeQ7nhhHpdyC62IMgjcGoxNczOCcMs9QbvMfqOOy0jSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqRB7ZLuY/QiFALC83ZC3eRBuUQyfUwCGV+O/Q5SnYKtfRBmD
	UpFTpfY6kH78WyJndY6KlRih0RSPxHwjj49CeqcGuBPaUTlHN8qHmz3bflfV6A==
X-Gm-Gg: ASbGncu1CPXZlcw7A8qO1hVF6Zy//YhSUAEC10jNYiQhVYtTlloawBRyvMuh3rkut6a
	QIV3jnp9/o+F+ll3lkXqj1tpc9ZY5u2w0deq6maYqYmk407afp64ldbD+798U+70/4jjie2m38o
	jxN7f6MrLMTnqsRB4SHECa9YlOpqQbgKi9afcfcLVaFPfEwjYPMHDWTOGDit5ILP71MAS0X604V
	oe20VVqvvYNrxmUIpxPJrMkJaJ+W2NKPLgwL3M4vjUAy6CktN2Mu4fsaoks+AAkgoLY/UVlwxUk
	BtJxa+8OinEpqEDmnmwiJgqdgA8JrNb6t3LvzuEqkDYF/MKSGBlhF+phkrQxizWS84F/jnKuy5w
	krSS0oXPSGwb0LL+o7AL2oBM2hTm9f3MErTv1GtnJn+Z/kAm1MaDiO/4ipEjkUbqDnr/KpD+U5g
	==
X-Google-Smtp-Source: AGHT+IGJA+8g6wRjaGXZk+uvhQ1e9D6dzx/VUNrIZDpEGW28OcBzHMx9m6/c+9slJaL7jTXyZDCNaQ==
X-Received: by 2002:a17:903:384f:b0:270:e595:a440 with SMTP id d9443c01a7336-297c040a72bmr17286965ad.25.1762476600328;
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm40775685ad.64.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:53 -0800
Subject: [PATCH net-next v3 09/11] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-9-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 7962bc40d055..a5c33b475a39 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -170,7 +170,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


