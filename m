Return-Path: <netdev+bounces-236574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA2C3E0B3
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC7E188E48B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47483016EE;
	Fri,  7 Nov 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtLhWvLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B92FB0BE
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476604; cv=none; b=EtJRCU5lxYN1zmUl5td9WiMef1XV9b6FMEYiUtA1HOq7Gjw0lQBXnRFb7DPdST0drNPB66ZJ9ceZveX/lVhu3Vnjpt3rURI921o6SfSpxes86fNSJUXp1Qx5Le73KcrNu4FoLvdCoex0YqcVh+CSPgkFF+EzmWIv/ViNHFV4A24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476604; c=relaxed/simple;
	bh=GxjWMLryYjjKJpr6TT3LeDbeqAWdzd/wbLS6W72CbIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMJFVDjAy2WwWiPIbgv/eaeakspFVQun1pzFBZeVltAIX2izqvXTu2aqnd21qmS/3QSmCVdvkQTEYHG4L6vn6rvlImBGGsqJNevqfvbivvZ7nh9UwO8bJOz3yM10sdlmb/cji2iQC5tJjk271dyyGVnzKKY/WWv4XOUy6W5dBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtLhWvLj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so306416b3a.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476602; x=1763081402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=BtLhWvLjh5egr8867jTIYFHKmFh8IGhbzvAGpiDirzMN0iBfyyhq68ULn/qBkfl4ys
         q+Tnq+nEo4jBLfXJQ/2CgThpT8vsularfbuN+Ig4iN2tGbEYl3myOBvlfFA0Mxh5qPoG
         7eZ3EHc8JCQLGim33EqOhpB/8NPFZTXVyxWqrkGDcCfTDciFHDxrZaVMrfLTy2GbQ722
         Sd3VbK5Npl7PfAvWgDV9GZ1UWNPLkfHZ0d1yJVEuE74+IywQN34iD9j1fFLMWM0Cijgn
         mjd+pE7jqZ9FLXp7ttpR68uXzaqp7eRYtbJZvHfQpQdPM0Og/ZYwFToa+6odyxfw67Sd
         fTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476602; x=1763081402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9DCFKi0aY+3dE4R9e8oh4CcU6zhkT3ckh+srhUdXmfc=;
        b=uNG60xF15w3j8M9VhXWgtYA7sr70lAvRheTd90DrJQDHmKImqMN4gcGW9GoROUXIby
         ZCLbdu+ulQ68ynhK8QUvnlyQ3LsCeZx6GfB8X6GYmaG9OWwwy7LGyOouD+9wrDF9/lrR
         mrs5zlfczcspGgj2B4MCag928aoMQc6g8/lvI8lKWA4v+gnDUG7SnFxysJ63v3VDOsjV
         RIk6dWfWQjf/LGCybjJUoPGZ/c+U4TpMZ4vNoht3K26+VdqBrJDJVdkX2Dl8Rvl8SEFg
         D11GJAeVDeOB9xNnbN0mOabwFp3FAuH10A5YFlNrPRMaZ60JwGbVPQ64VrFgjfo/nS1v
         GtWw==
X-Forwarded-Encrypted: i=1; AJvYcCWEwQKGhEcutEHhm0Ds6ahQlf/CgUlsW++dBqI/sI1HzxZvqcb6Rl4Rg21G7kLooxI4eBi9DhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcsm2QTpOihf7DqXbhnNoLYSC85ak5NAYIukhbmvYBZlHlwoC8
	RfIxb0Goc+DFRXEfqR0Kj6yC3W6381wLnRQ3t9OZsJtcnLpHwmrgDRpda6DsyA==
X-Gm-Gg: ASbGncu2iJ1JjiBhfTiM/iHJph4L4m3hnWIsTsf0UaPsoyGhnYpURvQ+uZbiaPCWZCj
	igf82RduUY2kFWlOZlsEoT4+/dPyOA7eSQ3wat7LF32uC+ZJcQMI+10HAMfRNHkomgsvjTDnA6r
	7NfCq3TaUwJP7dbxJ7kMfIFYrAsK6+hOvCWVIq/fG7vTtKFd1CT/mmKq8zMGqMS705byHlbL/WU
	dJfyob+H+WENnOCU8CIN3OWZ9VSruegLn72B4LjSCAy11Xg0jVWICKl1je7DL4ZLHAmB3WXEwDy
	P0OAgNpOXIuR+lKBaZAzZqzYzoij7bnDGSxJo8I9J2uSzYeDWkfwWCxHHIWgHiXAsjVgUGasbSk
	7/aCq5Ow9ls3mkncoylSx6n0poou+Y6WRnnY3j1f3e/NWTYYEt13BYEX05oWRat3Sp9z0a9iG
X-Google-Smtp-Source: AGHT+IGEV5/i8frm9hdbKMaepp45D3BIIaGPeZxpCw61DZpaDradXH7/QyynY840Xwr3dtOtnTjxPg==
X-Received: by 2002:a17:903:943:b0:295:82d0:9ba2 with SMTP id d9443c01a7336-297c0389dd7mr18651925ad.1.1762476601515;
        Thu, 06 Nov 2025 16:50:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm40921705ad.102.2025.11.06.16.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:50:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:54 -0800
Subject: [PATCH net-next v3 10/11] selftests/vsock: add vsock_loopback
 module loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-10-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test so that vmtest.sh
can be used for kernels built with loopback as a module.

This is not technically a fix as kselftest expects loopback to be
built-in already (defined in selftests/vsock/config). This is useful
only for using vmtest.sh outside of kselftest.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a5c33b475a39..cde048bd7fe6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -463,6 +463,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3


