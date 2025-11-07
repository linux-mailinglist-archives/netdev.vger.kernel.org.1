Return-Path: <netdev+bounces-236572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03503C3E0B6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E893A9C7D
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D262FB094;
	Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQE3Bjnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BBE2F6913
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476602; cv=none; b=Ng+TNidDh22SIgD7jvYfM/LL+3cPfgDgMYCV5kYgIFzAhhQZ+wD7zWNYL9P6v5E6OIMid1H6upwtQqGPU6F0LGvRseMDXlgRezGlp3qOuftgRPR4NTxm1SBf7V7u2LgukvR4FitmpeP+Zqx/iJw8yJilE+JtwwtHoLLCoXZju/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476602; c=relaxed/simple;
	bh=XXNlL9HT6OWyfD6YaISgyik17zuUQszMD6nW7MMjNu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJ+vEEVggOMF7iLO38u/3pYtrXaZQNSVsTPKOt1a/9ot3ghWJdk/oWBhdywRHU/2iHBBBP0Up5p/HDCmx+1P3Ds6vCdTZI+M5adm7uBBH6PbUSavmzT0Fmq+RVFjH2nu/uxx+tlppeOwgfRie2U8jcAVYcrHY0lfQbpmqoezksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQE3Bjnd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295ceaf8dacso2176565ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476599; x=1763081399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=VQE3BjndPzgv6lyChA///bM9XjaIyZ38XwkiNVXX+9r4y8PcM4Jhkk+/aSJplHRzFV
         HmdBlsGLfNoQyEXCEjgrbpqXwculFw1s6unKp47wvgq6zpv0Y2UUVzbLg4AEkFXXoOdn
         lWiassIfPbK2PX7WZaKwJvN3UYVBCUu1GbSllvBRHESgEyzk5IslMqnawW1MBDw0KXSj
         Qypb1jrZW+1TyPScZaBiBjXyS3F257KS2ffSWISLsjfltS5CEYEBC/G4XhH5LDvn9Ohi
         8PYZKtB5j715yHpX8flNbkchzPFocYy03Do487rfkyaIinquJCSsp/T176YOuSx/xS8h
         oEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476599; x=1763081399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qm+iFGtqs2TRCo1fgFDGUjgedOio+kGkQCN5xya41c8=;
        b=I6kxT+582Mcz8CNGscsMJI9LlUTF6Dg36r8uB8YDWyQzp0qxk/Odf0NXoJWEd9CLg1
         m94xXI97KQyFr8I1vSGbk/R4yT0/ofPi22k3pJD9bzagE2NhBSzTv1/He4glO8YgibPU
         YJPBB9No8Hi0fYDExVHL3SnSOW3RqE2ZBW/DA4Hce3ddP2b4XgeMt/pCYSBZ3u6J6ym3
         XIL6AjpgihAYzjv6PRQRXnjAYaMeDbDPcXT4eDzJODHZPEeo4zzyP/ZMojzhp1Q209sP
         +mS65NdaEt0ly5EOEEMuOPdS+62tHt+wjfDHdrr9jWWKBqfzGselE731zMsmvK1cWX9M
         HaTg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6Gl9/gWKjtlP0JdK+Dv0Li89GMjHp3xHI5TVHxk28huMZzGCndGtYXJB4H0yzToBQupqwJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+OF4wO2eVzcps0btwOxbBZ4fnP5324kwnWja/LkdQc1+iTwC
	5LQyq6wM6BhHTcJ4rNwhOxL7lv+T/KKOh7A75raIVfYSvmero1IKEl8RxtdwXw==
X-Gm-Gg: ASbGncvKr/NezU0xzpL7rUggWSxbcIWV8S9Bv9AWYXptMSehSXgBplleH7OfJZqQlr+
	haKtCDjO1PvSXi8MyNqrQ38/wX6i15hcox2wHQdUoVWZoLFtP77H1dt/tdMFMwQV2TAw9llfSLg
	UNP7rr9dVpUh+Frzx75J9EB6UVt6dQaHmgytoJtLNGyzxP9a1Em2ihyCllN/mr8hZ72MdKKQCIX
	+IX7KS2vDOzpHIIHHZs0Y2GNSi68WVVK/PsLKBJkbTaPTc/G2Cmep5tw8YWcLru+M7zOVLg9Ex0
	E9+krJG7CvwGP999ajYV6bhRrgqln88dM0cmlxN2lpPry1Ir6xif3Rih8+1F+rzAIonxdNz/y9w
	GAFQKbFDwsqLUEToXtUyoJwEk/fueDYJqLitqzy8GUBIYi8UOPyiNMe1wu3+HKqrA51wDbCybTg
	==
X-Google-Smtp-Source: AGHT+IFOFDetHqDrq/PAxGg+NrZQJpCNEyHjtP9cSvBQ0lXmrGvIWZ7Q8EW8bgf8ugBUgQz3F280Xg==
X-Received: by 2002:a17:903:2ec7:b0:26a:ac66:ef3f with SMTP id d9443c01a7336-297c03a608cmr14724535ad.8.1762476599508;
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm41535535ad.72.2025.11.06.16.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:52 -0800
Subject: [PATCH net-next v3 08/11] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-8-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 05cf370a3db4..7962bc40d055 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -559,6 +559,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


