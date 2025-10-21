Return-Path: <netdev+bounces-231460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E521BBF95A4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 057FB4F38C5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A12D5941;
	Tue, 21 Oct 2025 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvLpxZ/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115562F1FE4
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090443; cv=none; b=OqFiJnTPEb2mwHy5SUqkcXWLhjyjihziVbDCEGr4YjnNw7JlJK2G21XHnOMiog/JKaiB0LBHrgl51dwPeMHtYmZ2/nXuawndIby4BPyMMrWGfhyhbE6+hB5WVRrJdXVOJJys//lVGNFdgRy5zHUfN3XZF6UcFcLnVt/LW36C65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090443; c=relaxed/simple;
	bh=8bOFcVzDZsUwxKg5ikgK5NJUIukOBjSEIefCk8ZnB5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f10hI0VwwvQt7e7jXFifGH1IdUptJd/U2dcZVjQnosh4PiId38mEHU7gAQXcCD3JHMDMgUjomJRJthxlji4QBXCyL2XGMO0VqvNfOUIKb2/UW/QNuNx0eTQ1K6HSyDiTuHPvlUG2OolHQl+iwA1vBiHQmorSPjM+TDU2l+h3rV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvLpxZ/o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-791c287c10dso4809729b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090438; x=1761695238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4OFfgfpg2zuYVB97qQ4nYxxE2fA0slLU1vqJ2CVR4E=;
        b=HvLpxZ/oyS6/bJuVCK52e2NPKHQGvQmmYqh8/9b4AxDZ2YYK7TrE1CWlHE2reLMhun
         cX/LAKQcBHti7pwdZlU2FD0gdKfHtaXB2/dH+bWAJ4MFzeB102phEzkQ6vFJs+IXukjt
         uMwjUwdEzoFySh0OWznGnIfPjO/pqtP9StiZeoeJ0Uf0iCnRhDj9DqPV1+T/UUvvEuyO
         Pmr8qsSx87aT0QJixLbYmLlOxCMOosVPRb/C1R4u2p9wuqb0VgI9GgAsvUgodrgqHhvu
         MXACr2Hzlwox7//EKMFlLTUtAca7vOtHRPKdiKoG7me4IQnv5UN75f0ErpeJLP7Xzfkq
         jXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090438; x=1761695238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4OFfgfpg2zuYVB97qQ4nYxxE2fA0slLU1vqJ2CVR4E=;
        b=lrtVOWVl86CvyD91N+J5Z/xDEywCQMxIXdJITjK1aqs5YLwljRvOhzS3pjCplBsbsl
         FeovfGKvA+3AucevgSV4HLhT1CFfLfDULs3e8PotAzPoZXnwmRlDjuYWXSNRXDB09e7N
         A9vC8xksDjr+nuBvCyJuHlmX3KhSPowRlV8hio4JKoNoa7w+36bFJ0CqQolt9uVAw319
         W1mYV1LPQKCQCcohJZlLASj4D9nrLnAxeWiaB5P/7KC8ZuD0rSYVN11h2JXed42lXTaa
         7FU9RjBBM9DUtWMhUgVeAnox2lUWVzUunqNkc+yLSvjPCnuIcw03I7018J9EB1dzQKbC
         1wsw==
X-Forwarded-Encrypted: i=1; AJvYcCUb2Gq6s26Ahm/IB5PS2Cy80DH8pTvhaxuBcyp5VKNNTXnBJshOUsjaK/JRwMY7x3guTm2P27E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WG9D6vsleFo3cX5ukCgtIta/ebYrdiVsvSxCBVQuJspqQ6Ow
	8W0CNduyGCnYNpU480kVOs2T8DKdqWd+ZSn6Vixt8YH4iEBsId5hZQwo
X-Gm-Gg: ASbGncvm5J0OlGcHUa9JRkShNm/hNKKpsfzfqtVqzGCK2hAxYxw9pyR7h9qN+sNnNvR
	kv3bSBr0GZyfgpEl3vuHKSzOPuwJXDH34m4ELhGsqd0ggWR2iK2efYsNAy4EGOv4GvmZa1HypwH
	83MqS//n5AZZFFtgyhB23+/cI1hxARTMOwQucIvEZrDB5+wyEbvreA0T4QYtieXorGFJPLGu8A6
	n6gPbMoLbZPodeDy6sM9aSzUUETCGBJJuNwai28lYpbs1yV0QwHP6qQya6V858tSbkcZuMUCrZq
	MkLjdb3/M0YoH9ykzKqOdEIdliTg5Os/qt4RrHwGI27mjvVEZBOkeFEb5BmIWHHGnmOmX4p3Mgr
	c7qL24drUywcJWlSCFtFFX7NMLA1qLLq/OOnaCYmGkfP8ZuY6Pan3IzxSI7EyuOqxbcgdVWg323
	/FIrnZAxdJ
X-Google-Smtp-Source: AGHT+IFkhGJRP2dLAASLtzToAAHgpD36H89TPJABTWvg0NGgrSHeo1CXKroyw7GJKTzS0N8BFk4Bbg==
X-Received: by 2002:a05:6a20:42a3:b0:334:a832:91a5 with SMTP id adf61e73a8af0-334a862939dmr20305416637.44.1761090437936;
        Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b33bf3sm11369376a12.19.2025.10.21.16.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:03 -0700
Subject: [PATCH net-next v7 20/26] selftests/vsock: avoid false-positives
 when checking dmesg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-20-0661b7b6f081@meta.com>
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

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9afe8177167e..b129976e27fc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -591,9 +591,9 @@ run_shared_vm_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -605,7 +605,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
@@ -617,7 +617,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


