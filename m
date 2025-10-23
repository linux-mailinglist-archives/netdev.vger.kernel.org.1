Return-Path: <netdev+bounces-231940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC3BFECAB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E441A354314
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D026F292;
	Thu, 23 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0kpUtE+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF9255F2C
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181236; cv=none; b=tNmvXmVnry0zKti4e0qGDWaBf5eQW2yECitRK5gLDc0EEaohaluMVmpaGwv7m39YU0OhQWuW6KdAzIxtO/JAkrGyuVnrZu4xGCe29OGFFtZisoXQfGze7/CUyMhrxW8+2r3gwah+GqqFh0T3/IMS/SGsMfFxnMhF4pW+Sv5vntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181236; c=relaxed/simple;
	bh=A7Pia+kzD9m0J27kf4ph64d7fzH2Tfv7wW9zOoywfI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HH5ZDkFgSMBlHA3A8WKs5ATKQ9tjQ0YP/4AOH/LDusaBv3sfXJ7PDcG2nvk7rZEcQhHHHMGg4FpnrHvsK/bsxBCf80bovl58aeg+1l909z/am3p41BhIWSnBGtsvy7jewIY//QeuMC6o+gaibX3WEgUt3D35dknJcqgbnOYdwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0kpUtE+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso232799b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181234; x=1761786034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=R0kpUtE+4xPX+wPqgen1bjgNVxcgtTj69D7Rjudq5oeMR3J07j7dqjIZJ3Q4E6w9X3
         vxgiT9sLvpbMjE9kt0MbO6dhkeaUBZ0cwmExCUMa1Zaeumg6ErwTP/2DwyFNatfWoWNi
         //SOtiIKYI/zFdcxuYzd8f3UTQmpvKeZ8UMPNofw2VxlOxqEOYg91/sxbs4lZJG/H7KT
         0raKiLZmfMmG3ON/ONu8zV9G76Hc7nnVVt2svrQA8tUeTig72vN4OYeu1hk+OBIc/4IV
         SduR9PA0tLVmF0Sq2zLAVJUecLj/UAwTeojbMNKEEMbQQBfEAnwN8Y9kyop0kFHjmUup
         Pc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181234; x=1761786034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHVaMWRrmEBE/SxfIGFnLx0j8jRM6x/KUMvxwGUNtCA=;
        b=dxjpaKntaHzB9JbseUBrbsosRo52AaiFDbHiAZ5V0rTkiaFnjfLP1RLirkF6hcwANR
         VneBp4/wp8GC+IBWE9lhv+Mtfoj3OvQ+GJuDuUXnPh+Bi/+aqY/X4aw1DJAFJl1K1PJI
         X1x235KXLfH6w8i+m8qSU2YakYclOrFi5BCfagNB3oqS80umJmwdgG+unh655Sddn3R8
         ZfzwK+hNXUoIyrpFldCK9hS1xq7v02EKkR++jvqD+athQiAZprYQHc1/LO2UgfJhKjK3
         +IfHbIPIyv0mX6SmQgRSmullrbuPN/KGQqYKKR8zZYwg+9ZY7l1vYdLVYJ8FvggctwF9
         iaRA==
X-Forwarded-Encrypted: i=1; AJvYcCXYCski6VAQ0iRrk6LmiHDT8wSBWIKsAfje09ZzQw999Iolb1zDuTKJkCXor9eWwXyapOf5KO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgjuabdsKPHg+3m3N/CXYKQYHUFPqe0TRx71vBWty+Er8kKE/
	s1rKDG7ETl5Z5H59Zktq1Tfd7ABzvKGa2kP9qMn/0My7ci7qRTEk0eam
X-Gm-Gg: ASbGncte2KlgolcytXBSKycMPTiUI8y7fc7ik+vxUXH2QzlOSaxrRq3oS4mWQE0SZIj
	ApeUBXSDgIFanO7NAF1mXfZz57nVY3WFfw8wLMeFgrSEsCO0WAzEjWC4TSHCOo3FQ789mIPqpOR
	Jfew/LmM2bmpIdVVk4q13wkrO5gRNlhtWT9PEVpJbjYFV6/FZd61dwkjuVWRaB56gIWmGD9DNe7
	VXZMrc9vP1XeDL9clj++fDHqHmRNwmGQLfR9JRKoBbfZVZmEDcpeT3IZKZZEa6zCVlE81WRENaP
	Ut+Ovd4THlyaMO8pqddH0FoxPdUa/Zye+EuBdd/7E5HlmwOcynRbpLTsd2HQ1yh7EDaIxIdscAB
	S0sSdbNQ+wTKJm2ZmSP7RhQ0EHunI1qmWm3CHUikwXRdvy8kALkIi7Uth18uaNovvMMlEP7pLsg
	FUAQRt0Oc=
X-Google-Smtp-Source: AGHT+IF9GCZ5yEahtQVlZaXsqCeQjg9YU+w5E/EIvNEWA8qffUUmtOI33IKw7GAAlLb31mw7tG5+pQ==
X-Received: by 2002:a05:6a20:cd92:b0:334:a916:8b4 with SMTP id adf61e73a8af0-33c5fbaab59mr766832637.8.1761181233861;
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c0e4e6sm362737a12.11.2025.10.22.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:13 -0700
Subject: [PATCH net-next 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-9-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a728958c58ee..a312930cb8b7 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -541,6 +541,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


