Return-Path: <netdev+bounces-236567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18771C3E071
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5613AD45F
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D942EC097;
	Fri,  7 Nov 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbtqZVar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604B2EC08D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476597; cv=none; b=RHvxvYEg4CwmLtaMrlJvecBoGBjrTjuBgAJZ5oQh2fQ6TCVgawVhKtvT/1/YIn0BjK9tS3r5M/JSJTvGyLW7KsHSCc0ebKlC7lnBCQl0nh/1cFIcdnd7lLyRZi82D3EbwXVs/Y7NWpZtiFwjErw2m83ME9VmPQZVgeMsProaJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476597; c=relaxed/simple;
	bh=dwrVGPkUKFfHciYh/BOwW5ybz1vWWecMLURQ6DmfPcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGikyO30WqXCTAuOV0qIXnxoL05yN777SGk18nsNgIbhnqVMUZiJC3dcfjzq+HTnKH+GWoOTfPHQ/L/j9qLWU8NIc1COo93sQWn+GugUC4YeTNMgriG8S5YT3Wa2ZL934Obb0x3aKgV2MwaAKuj8DEH4uSoRmioXRJy6iynicwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbtqZVar; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so200873b3a.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476594; x=1763081394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRbKKbPo7sghLlyHK7HWRfe/WOnldFy+fNHUccLNkyY=;
        b=KbtqZVarxQBjv85tfHvy57gnoXxUnRrGS5ejboMg5fynrPykKESzZY6QKQ7I4PJ1UI
         UcNONRJgigi0f0f7sz/ME65VinYgO4oDciXtQGVwN4l1WMxYmozFhDtTjX7iIDjDF1Tw
         bAjOP+XhkrnKZNemVa/3WYcAePNO4sVnyRzNYzycaj7fsTczIpDuu+KlxkTia31EnzES
         Baou8FEp4ndJsocuzoQs+7zLKGzCDf76MKiKl0SlBkTdAetTt+oiCNCrPWWHINCNmWXK
         Pj3qZXpEmODrRGgwb4p4lRxv09WGDBerGWAAgaX7jSvMwl9DCuDvQNhBmDgnzn3uj3i9
         AJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476594; x=1763081394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YRbKKbPo7sghLlyHK7HWRfe/WOnldFy+fNHUccLNkyY=;
        b=mRXzzFsdrMMPZCLmpRsO+3T6YYxXh8svgrIdd8IYwCzML6Fp2TjA8aCJ4gWk2Vt/1I
         48aE/Ym2lECSwtEBXIMGen9Q59Xhd4LT3iO/t1o4+CFqscJt7zF1umrVAFDcTJoZvRxM
         kXCRHK5TD8aXozLllu/d+2cw2ElshJljbnID9LquIsF/eZUM68Sz4kHfShYElNdDKOrJ
         G1U18AdZ6EJoE2GvjkPxeGFpJ5iEy4s4yvJC8vvN44UqSbJ07rE21/KFPGmT/UQxWBEB
         n4gWQobYBH/jFGZ0iRW5Cy26gEgFOQBr4eBGOyb6SZq9dx1ivMzuBYyqz7wfz/MbQIxz
         6wRg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgLgPecuOazKXIGhnhGwk5QDK9VKQQXaR4Ak9ws6Q++jk5OZeqrlQvhZrCYK26LyZMXbzVKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctV5RBAn57j/gMQAo31/Q/wFlHidTvMsmgkchNU2k0DbQseOE
	1U451jvIztCuvffE5/7RzH1GEPqSLjnGpbqHl11Jg4Y2TWpmKTKfJ402uoGBXw==
X-Gm-Gg: ASbGncuc3yzq+f8EjkAStDGwgBaI8fea4sx/uFBZEWxsYx46ipOZgmnynTQTVpd2k3z
	WgGYknUNeLo/DLDahdVikowpvw9TbSo4lKzUHzj4sABSzKlE7WsFoXdsRkhDALC8ALMmdFIxdBG
	RUmPVj0/IcdkQVZ4CxPGoL4n760lY0A8dTSpSgJZi98a7y/dVKH8zWGwLubB7wnV8JvdHrFl+9s
	TNj0CfyI0qZOwpjMx/2GC9KIhzc4+mXs9bopIu+PUp1t7pvDbsejMxLJWT1SsVhyiNyj7ceGAQC
	1Tarr7G/VN02fGVnAoBn1zq/PjU1oGZWYxyhQZHGKCcgXP8wMLi4IDYSmtHgN+cGwkHBFfvuNVa
	Y4oe/Sv1OGrLmjY/XYvd5lGlWvq3H/LSvaXh8OfY82+HfBS6wEtUrTGGxR5hO1Bnfg4gMB5z/
X-Google-Smtp-Source: AGHT+IEbuIc5GRka/5Y9I021s/vgHn1nIjge60jkwm47qZF7uc1qjEbVWXKKl/0cBwa3wQt/WmA2Cg==
X-Received: by 2002:a05:6a00:8014:b0:7a9:acdf:e8f8 with SMTP id d2e1a72fcca58-7af6fbd5c22mr6105213b3a.4.1762476594202;
        Thu, 06 Nov 2025 16:49:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17a252sm869506b3a.41.2025.11.06.16.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:53 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:47 -0800
Subject: [PATCH net-next v3 03/11] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-3-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- Add port input parameter to host_wait_for_listener() to accept port
  from host_vsock_test() (Stefano)
- Change host_wait_for_listener() call-site to pass in parameter
---
 tools/testing/selftests/vsock/vmtest.sh | 134 ++++++++++++++++++++++----------
 1 file changed, 94 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index d936209d3eaa..01ac2b7ee8db 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -272,8 +272,80 @@ EOF
 }
 
 host_wait_for_listener() {
-	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	local port=$1
 
+	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+}
+
+vm_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			set +o pipefail
+			return $rc
+		fi
+
+		vm_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
+}
+
+host_vsock_test() {
+	local host=$1
+	local cid=$2
+	local port=$3
+	local rc
+
+	# log output and use pipefail to respect vsock_test errors
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		${VSOCK_TEST} \
+			--mode=client \
+			--peer-cid="${cid}" \
+			--control-host="${host}" \
+			--control-port="${port}" 2>&1 | log_host
+		rc=$?
+	else
+		${VSOCK_TEST} \
+			--mode=server \
+			--peer-cid="${cid}" \
+			--control-port="${port}" 2>&1 | log_host &
+		rc=$?
+
+		if [[ $rc -ne 0 ]]; then
+			return $rc
+		fi
+
+		host_wait_for_listener "${port}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -312,59 +384,41 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
+	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${TEST_GUEST_PORT}" \
-		--peer-cid=2 \
-		2>&1 | log_guest &
-
-	vm_wait_for_listener "${TEST_GUEST_PORT}"
-
-	${VSOCK_TEST} \
-		--mode=client \
-		--control-host=127.0.0.1 \
-		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
+	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_client_host_server() {
+	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	${VSOCK_TEST} \
-		--mode "server" \
-		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
-
-	host_wait_for_listener
-
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host=10.0.2.2 \
-		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
+	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=server \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest &
-
-	vm_wait_for_listener "${port}"
+	if ! vm_vsock_test "server" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	vm_ssh -- "${VSOCK_TEST}" \
-		--mode=client \
-		--control-host="127.0.0.1" \
-		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest
+	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+		return "${KSFT_FAIL}"
+	fi
 
-	return $?
+	return "${KSFT_PASS}"
 }
 
 run_test() {

-- 
2.47.3


