Return-Path: <netdev+bounces-250660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4923D38893
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 22:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C881630B53C1
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11F336EE0;
	Fri, 16 Jan 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTngvH+a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE21F131A
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598953; cv=none; b=dhwZqcNIIkKZp1U1P4/U3tSQshGrt3WvU633iuAG6Ewo6atIFJ1u4kzJz1XEX4yhOA11xYzr/JK3Y4FMjbSRW6KKkoRHVD3AiGgQqg0V+5MJoETBwspM53DshKL2nwYvNevaT9ZBPrBs0P6xDgQiUc8Kkr68UC1++NVVLmrUmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598953; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q08kUSyMgNQ3TrRujkEGc2AiUs6UUvoFTk901UcB9e3AA7FjVNXqFOoF+cZTGqCt9fNMtuVWXC2gMJpb+T35f/0UaKa7mvMu4q9jHLTXMymzJsfr48OyBMPPZ3m5Zrse/g9FNazgqdDAOzuLW3u9ayRtfwVf+U4x3wONtGCWMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTngvH+a; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6455a60c12bso2218338d50.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598949; x=1769203749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=QTngvH+aHSlgpc6sbkMxQQXQgVjpHfvo8/ybabtKjpTSprv3GfeKKJBTALE6RgtdDg
         RswwtkZl+IAqTCdFrDCPHorrsMHWw0aGSIuwfImh/UGEDyme9oneRL6kbIwX9Efx4xYB
         mSieuSGsc5RLrst1Mabf/Ewlk7C2Dqx2NlbGcdszebK3DDxj6a+r+epSXdjJn0nDPKzT
         LlHE6x72Cg7y9/xaxwXYp/AuW6SFdnS4tBfDYGej85+UwalYdyDNm/lmAXapIFWbnshx
         Zf+/2YilCh3DnjHITvjH31s0Dihvq+0QcEtewyuuNiLeDx3Zqzetfk728lYJ+zB4Ell/
         0pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598949; x=1769203749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=YbmIuhInjWJUHrEINL0Arp6mtZTTtCoM7moEERs7NowIxOJZnTNvS8LHa270OFa2PZ
         /qTRQSeVxW7KwXFXsMAFTCrjBy4HxSrmAnGA57clOBOpwiwdTW3i/52+HPeg0wsljIn9
         5T9R/czulAGqFCJaDSGPbo8rKSiq8G6PEgWZNkcOaEp9gjcqfPvOpGhCx4NexDAGBIH7
         H3Y/xzW6nEGQ1T7+y1VM119bhaWsUNf22qwS8F+S7dMp5MU/saJsdsIys5D7lgLSFxQA
         ky1DqTn+zfVhF4cqdLBiZrXIJNGYUSqWOadZ1HYtiT2Kr6QQFwp4QWGQJ/EDpaoJ9NXy
         iOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqltPQS8qbdhvLSG04OLO5DBUEsgMInV48OBEkkTMI1K/ASJ7I6bVVcLz73RZkbqlo0uFYmxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ip3JrvYRdLZYd6YCXOsNOUebZlbsOnOy3S6QnZfQXiIohvtR
	RtZWXieKwaPLKUl2WEFAB0U1UzT6geCIouZFjx/ikaGJiTz57+uHV6Nm
X-Gm-Gg: AY/fxX6TO5OMvWZAmgqeSQJ2lVgwe+0ZmQWiFwH+Zvuk1b7bZdjPtxxpdgz6H6wZ0xN
	HftH/+Wfjtql8q/UhZuhwRW8PLAADFpd/nKx/QLY+qOcVr7JMZX+C51YpADl/acF+4kzIiuKOzt
	HoSejPfKlKfA8m42zHZrdLOdXKnFEik0BgtMk15F/5JpY/fKMspro6wavk+7ICd/MmuR5u0a2Pa
	qizffl8MhK6Wdy1BJkgVkdxzZm+jG71Tw2RAYXmOUSKRjxwUkpQjtwfDzeaeKU53XkcGOmiCJgU
	p1HcWTwtQlW35GSH4+6yejv0dvpUaODU/ily6DZXZ+kLVfiA+EiWQJrOL+1tLTQBmZpin4rqy0O
	9UpLlOOei948ZVnDWbRmix11EmkUSWM49Zb8IDG260hQuACJI/bcQ67dabdwTRa7fj6C6prKWmS
	RDHEakg2of
X-Received: by 2002:a05:690e:d8d:b0:644:60d9:8667 with SMTP id 956f58d0204a3-64917773d86mr2650287d50.88.1768598948802;
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170d2f04sm1663457d50.22.2026.01.16.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:47 -0800
Subject: [PATCH net-next v15 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-7-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1d03acb62347..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


