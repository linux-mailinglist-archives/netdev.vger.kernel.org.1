Return-Path: <netdev+bounces-245926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E211DCDAEDA
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE68C3005F37
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CCE288C86;
	Wed, 24 Dec 2025 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRjgMS3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FD2797B5
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536152; cv=none; b=DGs8yFCv6Ds2BoYEmwJnBol4oTherJf4ZSokQfs2H0VqRhI2XdYSoHy9e5GbmEN/NiSeK4mcl8WHuZ4ZTc+U/FHvIxXwrlPpTaRoYIHNgMT5G7n7xnHrMd4Fq6E8bBfI+DQ9A7BAAPyNhM2lBte3wHme3i4MhvLBlhzFdyNWm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536152; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pi6Q6vhXUDvVbfe4sh+EmnyF5/mGpu410BPC8p/YqujiSDtS/wwA94y6HCegmzUIsnSjqEpV6LK6sl814eRRvxNoC8n1epaMp5+0Mz4PQbAK8j/D7cbuYjn0V7O441yGq2SGc7TZ2ual8tHyoW37K6Pv9Rbx20rIEAr6u9HMkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRjgMS3Q; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso3250563a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536147; x=1767140947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=cRjgMS3QklLczNYAVT/yC7Xc/Rz6zW0xW3bWfelspElw8cwciSJcROhtVXQh9b04n+
         CJ5CdqOmkzham/q3S3DpYcJjZlGBdfPGpYvWZq4ZEffFUYZrzC9ouGlxs53YGZ8WXasD
         wp6HMnV/3jq9OAaAXx9uVZ2IqLDwwYiCwo3ctvhHI+x9Na1I29hMWu52mGYlMdGh8z6h
         /ZbPbwC/NuppKfENS4m0z3t6bvp3WEj3HscuhWFroWSkGy0iRo/37+CA2tHzpkzxEIjn
         RlzZEjwv8T1DMSoPeDKmnFE5Ugoe9AK82Q40sA/gbanHoob2EUEVETeYKOi0+rK8aDog
         5Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536148; x=1767140948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=D6zjqWWqrejuvJDvb4jxhqX3kqeuIIE+1MQc6xUclwSizUuYxvQaMIw14srHleWaKW
         fcya3w7hdRLSsxbnybJh9EjTIDFgQt+pdrr7XLgN59ZRyZphYeaF+YOJe4nlj4pJGu8e
         AMYjPi2K5NwAFNtfqeOgTHmWi/NW8fC2O1IU6R09KzXrSOcNZI5kTMMSpU19pIfRNMtg
         NaXAAkmELwVPpGiTceXOxCMx7BDlcldtEO8f8dcvjYlNQYmD7WnJf10ByZQTj9bf7mez
         /wZVx2xIBGvhOYYKT1GEp5QE9BePCYDuQrDY9ISokXA3pm8P7NQT+KxH3IhCyuIxNh9r
         1MXw==
X-Forwarded-Encrypted: i=1; AJvYcCX0CWbjiF9SHtEs1dETGIdVzcTogG+Jods01gWoclrnLiKKC5kcUd0329GsEHGGG6hVrvgqPVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZuguVwhoUGCHVzxAgMwjaW2bdG7KUGj8zsGbmFtQC2RUw4kX
	HsbZGYxhUvYl2vs5erpLRmE4PooeuSpcR7XEAzGZT06zTIFAoBEDeWPW
X-Gm-Gg: AY/fxX7GzvVkcHm5Lj980xZpb1YSP6ozt4l8/dw0LngHlUl4TppMXyuZoS0zk1ytUpg
	1ULHiNLnmdGI61CUwgxqnYUbAKfZ9SMc2IGivbUT0KbjgE5idkOT3Lzk4yZ2vwGJeIc02Q9IUBJ
	3eJyy5mKNieqfGhhijSBCycr6SWbepDb2t+BnBdZA2HAXhcNV/u5sylnaou3c7SFbmxKshzCm74
	YKiKei4UfLbd49mr9w3UlDvzQ0oTyI7UnABYIg5nMQajC29+qmIrB0ZLoGBa9EAN/WJc8TkRx/h
	v6ws/gZa7Goj/0Fdkfhcs5GlllU0d+8a63skC91g9xtSo6cJ6ZOh43oul1IW8DgvpKkoh1wdj0e
	y7vl93AfRNVh15tpfo52AfBJeptVPE+izONWrMHESEVho+Z0VC2KbTqSPvzKLBwLPPaNxckCsXI
	M56UFNG6D2q9Aqtz4C
X-Google-Smtp-Source: AGHT+IEnt5MFD2z92xcaaC0B2FD3jHvTV/CdQSmrEfTkHhvBEkCeNRbln24shg4R5xbEeUrAsqetcw==
X-Received: by 2002:a17:90b:1d0d:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-34e90d6980bmr13148402a91.5.1766536147584;
        Tue, 23 Dec 2025 16:29:07 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm13429268a12.19.2025.12.23.16.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:07 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:45 -0800
Subject: [PATCH RFC net-next v13 11/13] selftests/vsock: add namespace
 tests for CID collisions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-11-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to verify CID collision rules across different vsock namespace
modes.

1. Two VMs with the same CID cannot start in different global namespaces
   (ns_global_same_cid_fails)
2. Two VMs with the same CID can start in different local namespaces
   (ns_local_same_cid_ok)
3. VMs with the same CID can coexist when one is in a global namespace
   and another is in a local namespace (ns_global_local_same_cid_ok and
   ns_local_global_same_cid_ok)

The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
make sure that ordering does not matter.

The tests use a shared helper function namespaces_can_boot_same_cid()
that attempts to start two VMs with identical CIDs in the specified
namespaces and verifies whether VM initialization failed or succeeded.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
  local0 twice. This check should pass, ensuring local namespaces do not
  collide (Stefano)
---
 tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 38785a102236..1bf537410ea6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_child_ns_mode_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_child_ns_mode_ok
 	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
+
+	# ns_global_same_cid_fails
+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
+
+	# ns_local_same_cid_ok
+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
+
+	# ns_global_local_same_cid_ok
+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
+
+	# ns_local_global_same_cid_ok
+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
 )
 
 readonly USE_SHARED_VM=(
@@ -577,6 +593,68 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+
+	# The first VM should be able to start. If it can't then we have
+	# problems and need to return non-zero.
+	if ! vm_start "${pidfile1}" "${ns0}"; then
+		return 1
+	fi
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return "${rc}"
+}
+
+test_ns_global_same_cid_fails() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "global1"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_local_global_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_global_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
 test_ns_host_vsock_child_ns_mode_ok() {
 	local orig_mode
 	local rc

-- 
2.47.3


