Return-Path: <netdev+bounces-239332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 198AAC66EDD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C2C09295FE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167332E752;
	Tue, 18 Nov 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEuuUKxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8A329C60
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431243; cv=none; b=HJ2xlL2TRlCT5fYvSv1hdZ8OU17bPdRy/6XDtf+ByB8Ax6OlmBoOAhjaBjro4Vcv7/QfcJ7eZCkZREpHYg1P8vtH0TA6K7/bAPcPRlrqWzbNUjNfHGLShso9LTzmXuKnaEdQH1+0kG0KF9kBrWPP36g7m/P4Hi7+rn9+vd98sNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431243; c=relaxed/simple;
	bh=3zstnYgrjjZTcL85zX/bwEXTpc6YD365WK9ireof2ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lP9y/R0qO5z8mN+Z6xMQkIyBabOHXhTKjdir7wf3SXKHsPMmrZGg6Exjubz0lOuxp3/2XxvJ7mEPlIklB0jE90mH+RZmEb7rMLRf5EwvAATSz0xtGXLWs+DUKqL4BcuZd7TuuwD8EQVuXRZaVQb9Ye8zHFB5P20YNnEYoqBoC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEuuUKxL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34372216275so5389484a91.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431239; x=1764036039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qhvm+dnH460Tt7FFn5Fd2rcGuVIIsnu9XpGRtebTbS8=;
        b=eEuuUKxL88H+xzP55NnbfD0ZfoPSM7SRsjmUxTXzBKeZWGRe3YuCFT7Ow3SHCJu9c/
         3LvT8dHQDa1umpIX81H9AGnkuHo3qo2ndLFYnupHNUBpP6PI/f0TSeegqQ/JBGxSmy36
         +SOflAfMc4ddC+8qcaxNkkhfvDtaVP6xL+93AXfhgcR+7Ioy6VmHT18vjUK7hoAu5Ffj
         qX3tfHBKicu8PP5UWSuUOt70kcswnMlYtdmqZgL5aGAhymOT7dhRjHpzCqJzYYL1EnHA
         uFksu+WpZdSv4l5isS8OicvDeF3HSwB1ejJ+CF8NY/A6CQWqJAxhPhp15eqZYa1IG4QQ
         7mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431239; x=1764036039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qhvm+dnH460Tt7FFn5Fd2rcGuVIIsnu9XpGRtebTbS8=;
        b=piru4QXwniIShkC67YLZvS8oW9zWSIoBcfTenqdTiJnuFEj8CFBjfiql0zK29eSXTW
         NZ2aT1sByJUURrSUV7IGsVmJaGRlyIr97HbwnOpfXbTa0FauhUwbBO/H+jjFIKTO7SN/
         rQuNBnBPrZ4DOTiVm+5pLMUjnbucZYJT+2OxSWAtPmUa0nVlsiOXPJHUz3o4uueA2QKI
         8PD0HrE3V9CKzXTuj0pSRiuzXCFJ5VryEPo+GSVDEIjIySxqDpi5h/hPPsx6k+U/LTL7
         cLd/e3L0YuIeCQfeSTN7d6D+LkTbTU9Ygw3XOZKD5sqtBZ9FEFdbWupi+FUVeRmornq/
         o+jw==
X-Forwarded-Encrypted: i=1; AJvYcCWet1YHGiR8QosnvMdjMjw10rmT+UGyt5mt5VneCkJiPDpKXV5xYD/S6LUoIwht2J1hJpK4ldY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVKRZEZEBkJFuos9rnBstu07kRTCCmNV8AY0hs3BEkQ+QXzL2
	5gf2COTsYSmog6PNabRkyQZdIt+5caHhWqRuGYh8vyccifh69piHAmjT
X-Gm-Gg: ASbGncswooiXlM5EzqYWxbMU4we8W7IyuUQP7wVG56Rmy3CoEKDjjLypGQlZhTdvU3R
	g8XNX6ZGpO4X2hSS4r32igJaoYAx9/PsjEb9nr6PkloriF0ejYQUzXJBfkvj4l1Ip2akBH0S4Zs
	pq9n6kk+dA33OG0lo6fVT7ksauxKoXdTQmTYqo6a87FwCEpmD02J1QM55XJgdilIDL/DJlTwIgn
	Rs3Q+I/HhrHc3HFeN5anRRXcz8KVbDz74TanAcoDORvSZGrM0Wqj7TQ1SnT4AkruZkMKUEwvUFP
	v2hOeJ6U+5f5BSLheH99mkEyVxbsp/XgjPvGJ4Un59yYq+1Rfhhh4867G941cUkP7VAfycDuNHF
	Kb67ZPLgWdkfqWvzRH6cdyFfz0gwsrQrQoxWIIt1JR9C/iF/jt6+nc87B8QFDUk5lvLlhtdV5uD
	2NDobVGT4ZWdEu+3h5c/8RQh+el94JVg==
X-Google-Smtp-Source: AGHT+IFqV1GrHr3XrPIYmCcvEa4oEIM7omi6fW12jvd7AtWF00Di4zCzOTV0RIbzxFbKb2Lo+nb8Qw==
X-Received: by 2002:a17:90b:2f08:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-343fa7493admr15317741a91.25.1763431239229;
        Mon, 17 Nov 2025 18:00:39 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b0202b16sm369741a91.2.2025.11.17.18.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:38 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:32 -0800
Subject: [PATCH net-next v10 09/11] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-9-df08f165bf3e@meta.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
In-Reply-To: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
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

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 86483249f490..a8bf78a5075d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
 	ns_vm_local_mode_rejected
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
 
 	# ns_vm_local_mode_rejected
 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
@@ -553,6 +568,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+
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
+	if namespaces_can_boot_same_cid "local0" "local0"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"

-- 
2.47.3


