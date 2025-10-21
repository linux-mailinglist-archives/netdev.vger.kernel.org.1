Return-Path: <netdev+bounces-231467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0DBF95F5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CE05E0B5B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A76B2FBE05;
	Tue, 21 Oct 2025 23:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBdMP7dN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDB27A107
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090450; cv=none; b=SXXiJBt0td18X4kFTORpMagGKw2bRJ5qTUB2Hh/PTKJeSIJB/WD88BlXP1/SfTKMPHoEIqnZI7fxZ9yuvPNmie7mI/3HilNcUK9fdmfOLs5ckwpaolQPxGvqkEg7kZ8kQURiKA1tNlUba0IINVyiTqSS3+/7r3KhTCOVeSRtj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090450; c=relaxed/simple;
	bh=BMoDKOrhS66bBpIGFuMcrxO7gUW03URrQ8nNkpSPZhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7I4k51wOLouCf4PQFaJRDauDzeOK27/Q6nQkWnD4b/UBoUSJMVrhiyeMsBbV9E2apQIFyEtWVHheC/2OKW0eUJ0YVAmyY80I1vkVLGGU6dNbIrAU4c/vuAuPfBHOP31lnNnNHgU4eDFWMMTUDPb8ytym3Pj/BjWSABwT/HquIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBdMP7dN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b556284db11so5178448a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090443; x=1761695243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCa9hiumthv+bRPHMdag7ntkQWTFgKpIIbTw+AdtIpU=;
        b=NBdMP7dNyeOytmB2rvy/Yxg5bJ+F7cyedwstBr5tbIxXbfnQAnrRwwyYzF+xECSSyN
         9RfXd4KOI/CJWLn2lW3wYqAvCS1Mz5u6AX2JgigUZRTQOzdWxZWjkYc/eRd0PZNtdtSN
         dwsz4jMxNfDGPN+XQZSLjWxwXqsflbyVG+DmDKMNfTWFZ5AIhLVwMuIJeF7gTJ3ClkWK
         q/vi7/iRl6+sfSx/nSpcF3YbQCkT1N5LShAjn+aKIL5bjUl2H2zgCOQ/n8d80JoKlFEk
         nwzYeyo95tosg82ihqt7uyhz3cqdmntdVD4xHvcENRoF/FRYVeWC8K2G0hKe4fErfWAN
         DT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090443; x=1761695243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCa9hiumthv+bRPHMdag7ntkQWTFgKpIIbTw+AdtIpU=;
        b=q/5lQeIdtPGSNI9pMeXiGocud9OlCFRlmYRrYl5DO90pLzn9A9mUbyZ2On+YGl1cZI
         ho6oXu3Cjrz2cvgki47rR9vPYawiaB+KBppiZj67V5uy79Idj2Tj5Jt4wwLbQGav5y9e
         aiWGN6ZzltUucs91sV0dVsrJQBPwxr0kcWY3xqOl0pVcsezV72Pj7yo7ufaLWTYF7HuO
         29OGTddHGwW8FPwMe8Ch+1fPrSTU7pAyKAENJ9RkWWc99u8Wj7TjXHJ07KXyWrH8J1yq
         YnMNU7aR6WMsDvpAiESUWjI2KdXdsU7fCpny+gUflrkWL3oEFZYRpyVftKVceIRoksZZ
         3hBg==
X-Forwarded-Encrypted: i=1; AJvYcCWyuR+pLLWtjL7O7E432WIu5RYFz0Der2zipyN/kgK8B7PfeORWREz1nZU5/AFlTmPR+TiySWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PtOJcHIx4rk3cMj7ftg4gXtsTsfqviMLrLFPd0NO73pD7bLz
	SB5ty5JhhUJVo9adVaqhS0EqUtLhdGPEOxTU1CSoKn5sEGzWXeYwiRoj
X-Gm-Gg: ASbGncvuIFCalh4g8c/cp2rcYiHWHZojPA+tusu/z7s0EReJiQegMX3noMTpUWf9oUW
	urtnUnmOj0roWOiRwg8F3FXXOL30BLWKoyYIYjGKtC3/ZlkrwnoxSW+TctiHIcg4GRd45RjFpnG
	KUjEIbkKzT8fmYAFT6LVEyVldLoQ8S1rZ8eXntTp7hxzf+Ov/1WQrO1yvzDFobc1OMfGDCqiAHK
	kQ7iwt53KfHvzx3HrYRomSQn7/4a36UiQJyQ+hFjLPMW4hWgBrjScXaIHfHPncGwUWS0DEsuIcC
	8PW2L0QXfhh+yySqk6e0zRgxAgUPxwVYI+dQgPLMEvq+OX1l6lCAxuw9jz2QvnMNvCJIbzBOBB4
	aHrSIEYrGYzUbJUsXbI0F/xoYquuCfq15UheaDTwq3P9d5oLMttdB+hTsL2GGgB9hq1sMacfetw
	dqCPz9az2A
X-Google-Smtp-Source: AGHT+IGaqRNpMxUjoe2TEEOGYZ81AJdjcRS3PZQjYosVwq9rn7Rp/cmS0OGVE01pd5g/Wml0FTdNXQ==
X-Received: by 2002:a17:903:22c3:b0:293:57e:c8a7 with SMTP id d9443c01a7336-293057eca74mr3060095ad.23.1761090443407;
        Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm120489125ad.63.2025.10.21.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:09 -0700
Subject: [PATCH net-next v7 26/26] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-26-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36
1..30
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_ns_mode_write_once_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_mode_change_connection_continue_vm_ok
ok 24 ns_mode_change_connection_continue_host_ok
ok 25 ns_mode_change_connection_continue_both_ok
ok 26 ns_delete_vm_ok
ok 27 ns_delete_host_ok
ok 28 ns_delete_both_ok
ok 29 ns_loopback_global_global_late_module_load_ok
ok 30 ns_loopback_local_local_late_module_load_fails

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 648ae71bf45a..d73fdea886fb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -338,7 +338,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


