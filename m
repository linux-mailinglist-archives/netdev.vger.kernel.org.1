Return-Path: <netdev+bounces-242190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C00C8D3A9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84AFF34A94C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58C328616;
	Thu, 27 Nov 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kju2PZAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA088322A28
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229680; cv=none; b=nfH5/eena53QkqRWoKOG8SGYHYKusVi3xHItM2NSE6hOzzdaSuFzgMPbMjtc3MfZOMi/g25Gle6QuiEPN6oUMh3YTsc8tRVtb1ZHSsiX+jz4QJCJbUdd24U/i8NNnGdKfuAIMgMq7mWMbP8etdgqvYlQDemszYu207QDlWG+8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229680; c=relaxed/simple;
	bh=+2R3w3S681rnHvviIO0MgWHpMBdTB9OzqHRpjlN2cZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=libJyNpGMQwl5nqslMUOl41wbHp9nHAcjQ3CHcveEIYY9oFg+EYAjJZtr8aAq4yzULbAbOpHTWFvI5CvPAX5CqnyP4KLiMmFsDeBFO+KJ3leEgYTjiPqNR9fAYfu4TI1NRir5FWpdo8zFJjsGf3y6CAZOqnk8ctl+GeYM+Xxbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kju2PZAu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ba55660769so459125b3a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229672; x=1764834472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njNVZdo2YcwUcrU7+c1XfJBjEkwYcrP/2uy6YKalASA=;
        b=kju2PZAuBZ7TglrcObJGqKgNmPOLsUAuiERbEPlkouTrZSOA65gONVkVaPzHTPV0P7
         X+ydosXFwx/SyxuFlE6N1uPzPuYmCANqVMp3CZlhZLDeT2/i0CHYuW0JjdcFeUCbQXry
         iyTyRxEQjj4tMq6Aq4+FOZhBesXyrpcxDpHaJLZZvF/E1VlUjVx1aMnzTsC8w8M7K5fg
         wl3M3kbSN1ItVix3PgPNZ6MtzHlVubTV0PYodx+9h0rrzgkfdvk0VGUpP96QwxrsSGWV
         imsqo3ZgifhpksjuRVnNU7HFdiNrRDd8HVY5BTWV2EazOK2SHCMY5wDj90sRVYie1DAL
         Cu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229672; x=1764834472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njNVZdo2YcwUcrU7+c1XfJBjEkwYcrP/2uy6YKalASA=;
        b=tiUacYki/6j3qcBXTvR+CluHw4+vJKpImKhXTCZE1cLFaSjDWUObzIuw8cYKOXinUG
         oyNeAnKFSYI5Te3cWb5gGGdyPwMkBuEvXx3JQxSY2HWsHWZM82r70ghXibRqbHzJz6Fo
         feXfOl2eGm045kybtseorg6I3LJjY5Yw6EAG9kb6ucWL7PJcWUF0fxGNWOAr2p0ihA1p
         FDRvNLsG+zwFMhREnIrA4aabGRL1ZDT2FrGdCPwhAa/y8uKPVS9JPF7dExVfhcYsCHa9
         HdceaEc66J9jwx7MA82b8n+3iSPWX2vD6xFZxnp1cm2xhoQawxpUJ6e2wDySA+XNKfC7
         dJWA==
X-Forwarded-Encrypted: i=1; AJvYcCXHiD4oWzjbNHNJYbBNmC1NvF046bf4Pt7eUFr4ExoAurLRLlXE9uNxlFAMxzEvqbmo811PhBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCI7wKvukMK6P4DUf51ty/3hPRsxt+YqFpz+gXsT4N3DrXtVn
	wHIzTbrDNIbq9kkkTQhavK7LMWOyb1acZbWK16XFjzgk/oYdWZ1fvDM6
X-Gm-Gg: ASbGnctw+9bne2CfAjriLDqogvS59hf4sJsCZiiktulKAOVHE7yw5D0SxQXJHmewrHh
	hxVByjRFMT9ipQ6eCgs/qFAIju10BE3fFEjISVzc2v+PlA6UGYAEgH+d155qzLBg0VPGqNFT1O1
	BxErcCbWh1vhvHAIaO1bjmOOdx6NXyQAkuMhqBI/Nt5+U0ytZm3PQ1goyPeRVhxyFJx22s9XcLX
	UrTotGZLUGN7vAaRKpkHS7fwBbDbM6R1pHZ5UHDaDPHUMDPdxgSt1YhateYLMKCDBposUZkPYhk
	ak+0Y+AxQw5+5++i/TF1E6wMA7jRZlFRMm0/4MBPL9k0fN6xsCDzscga85A1M08PfPSZjmeGvwh
	UYq8hdzJdj2PXAKt70Xq84hE52Bx5Jvp7TpAJOwkkq9yH7uauFGjuAoQNC33F66SX0giC0YNTFk
	qLADb0iHYFYs/MBjTmotY=
X-Google-Smtp-Source: AGHT+IEQLozRTu5+aaYZLmpX43UDWknuXMdbfEtxDJQmwd+GQgMyCjfBlGTu04L/oX1PAGiOiTHt+g==
X-Received: by 2002:a05:6a00:1383:b0:7b9:7349:4f0f with SMTP id d2e1a72fcca58-7c58988f7camr22478072b3a.0.1764229672558;
        Wed, 26 Nov 2025 23:47:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfd0cfsm913324b3a.65.2025.11.26.23.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:52 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:39 -0800
Subject: [PATCH net-next v12 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-10-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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
index 28b91b906cdc..ec18eb5b4ccd 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_ns_mode_write_once_ok
 	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
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
@@ -576,6 +592,68 @@ test_ns_host_vsock_ns_mode_ok() {
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
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"

-- 
2.47.3


