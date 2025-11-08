Return-Path: <netdev+bounces-237001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA876C42F5C
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA98E4E8636
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74C25B2E7;
	Sat,  8 Nov 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzlaOoEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E51244669
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617722; cv=none; b=dEjQssNksCyUjINyoGuXw5/7Jm4ydW4ozGooB69CII00wBa9m0/+V3ELM7/8Y09a1dAR2MHAIpzymlPiirGSWarSB7bswcgE2mHEOjLdGNO80XFb4fk2tw8SAmTOdymKtXLY41ljrNF9lUevdDaA4RYBD8WP8VpPJqHAlX9zKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617722; c=relaxed/simple;
	bh=F9FsVtLt7rSsC+SslDdvx9EYIxO2ErB70trA08f7qAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GakH90YyhInUUDx7EdpXaBsuPvarOJkSKVtdkOxPnrxKe/KV0C4CE/8aEkMFs5TgvdPi/QZQ9304+6yyO2WnTk5eI21RZBk44PMsdlV6VRRsngkW75svFzItWv8Pr9YgA6xJ/QdhBYBCrTJZkpKQuyn82EgX9tXWAFUR7rDkcYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzlaOoEF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b9a5b5b47bfso940147a12.1
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=EzlaOoEFGnQtWtAUK6QRETa5cr68VJ9uGYfHind4UB0drUaox0wHjkivoFsFuJenFp
         9AICGVsBtIUsaRZn9cOd9l8Anaa89KxldxiYzWAaeSgnzFTwSJiM7zY5TpLGnxwSSWdn
         m5dwQgysbz2CiywgJ9frT99wavGveNEp/y3ZqqXj9gWrS944EZrDz5FaendwuDI6xtii
         tQHk7NP9wIoBchac261RXLICQjcRAmJfSxO25HIpUxR9ZUT+e6SQSqDXKC83HdMljk21
         6gqIBElBgphRHF1xug/9LOMPNIcvqJ1cVZM9NShpvs9y4zhmP1Ni5H6uX2Ixx4MlhxlG
         0tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/1yyOZn8r1C2HMNNmP8ItI3UkC7xFO+t2DlRUjrTgM=;
        b=AEHXZOjBsNmEWMxpNIZS4jUA2vghzjgNTI3i6590sS/pfyZySMTh65LVCJKoXFGe27
         mslBsi6X0/YAcmkevSHa5oTkvKX1tMN/zZ4LLMcPUfKihxP85j5uzeceeprynaHdfGuM
         +HzXOWhcZDYGFAZlbY89UGOGyf0OFAOd9+c92hrSZ29puyzj+fmMd87qHZ7riHMkO61o
         XjJ0S1Tzsi7p5OCmWt1CrB+DQcsC/7FYDuAw7eoqkmuQ+4+oyqnMfgELQGOfK9r1/VuV
         IN4soVnzFX+tE2P++pjgTk8uuqCkZCeD+cRhl04Ax6uCEh0IrXM+Ildxfd5LCwOOY3W+
         udKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPSgkMisrEYZHoLLNGBXkfjsPpxjGPDb6boZLAIH0QxQbxAvATXzgwflEmJGDZ8/ysHmdfgh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRhi0u4aHCSzW1Sww0UgU6vM+zQCb0Rhbrh0QsShiFyykSEMi
	gsmt9WGl6kcZs929lyW0xgflIngosV2tPtmYGJmJZsBzqYbsdyP4Y1im
X-Gm-Gg: ASbGncuaC0Jv+LnmXw+4ahyUbyXyq6xepvYXKe9FxWI66ySqng23ne8KCz4PVrudwRf
	jLg9cuDOiYygk2EOnTM/nNxgKtI8lKESqFIfw6ScGX4Gp5TfsHkcbjHqfSJAjqlKH3oJ4l8zfmU
	0vG+c02GBWtLEubv7a1qfBLXLOJCOglPT00EczgkNIJkiEW/0FJtd1Eex6x1WLHc17yohNFXlko
	pe/jNdrbRsmMsjt7zEhF8/LEv2VaO9wqEnEb6GhBJbX/sGzpOuEEOtEm/dWzqRptdOzaI0ZjKs3
	oFPEbOiIRtgX8O0HpP4SUiYfY4iiLXzi7zPP0eOGevRiaXJw+tHo+2MMDOra3jY84JFb9vV7ANX
	vZJvbdmp4FZ/wriWczQT7sIDQQZPVAPEhBme4WXKrWatuj8lUjgepmUANkyv2dC0fx/Tc/uMCAE
	mGOQ4pTGA=
X-Google-Smtp-Source: AGHT+IHomY4YyVD8KS6qtG7MNKX+4x/II1DuyBNIdKkYHuI5hzRRInd+7+JdQ5vyk3YIsOnkaHnafw==
X-Received: by 2002:a17:902:ebc1:b0:294:cc8d:c0c2 with SMTP id d9443c01a7336-297e5663a67mr35112645ad.27.1762617718558;
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm93090585ad.92.2025.11.08.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:59 -0800
Subject: [PATCH net-next v4 08/12] selftests/vsock: identify and execute
 tests that can re-use VM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-8-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

In preparation for future patches that introduce tests that cannot
re-use the same VM, add functions to identify those that *can* re-use a
VM.

By continuing to re-use the same VM for these tests we can save time by
avoiding the delay of booting a VM for every test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
---
 tools/testing/selftests/vsock/vmtest.sh | 63 ++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 2dd9bbb8c4a9..a1c2969c44b6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -461,7 +463,44 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
-run_test() {
+shared_vm_test() {
+	local tname
+
+	tname="${1}"
+
+	for testname in "${USE_SHARED_VM[@]}"; do
+		if [[ "${tname}" == "${testname}" ]]; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+shared_vm_tests_requested() {
+	for arg in "$@"; do
+		if shared_vm_test "${arg}"; then
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+run_shared_vm_tests() {
+	local arg
+
+	for arg in "$@"; do
+		if ! shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		run_shared_vm_test "${arg}"
+		check_result "$?" "${arg}"
+	done
+}
+
+run_shared_vm_test() {
 	local host_oops_cnt_before
 	local host_warn_cnt_before
 	local vm_oops_cnt_before
@@ -537,23 +576,21 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_host "Booting up VM"
-pidfile="$(create_pidfile)"
-vm_start "${pidfile}"
-vm_wait_for_ssh
-log_host "VM booted up"
-
 cnt_pass=0
 cnt_fail=0
 cnt_skip=0
 cnt_total=0
-for arg in "${ARGS[@]}"; do
-	run_test "${arg}"
-	rc=$?
-	check_result "${rc}" "${arg}"
-done
 
-terminate_pidfiles "${pidfile}"
+if shared_vm_tests_requested "${ARGS[@]}"; then
+	log_host "Booting up VM"
+	pidfile="$(create_pidfile)"
+	vm_start "${pidfile}"
+	vm_wait_for_ssh
+	log_host "VM booted up"
+
+	run_shared_vm_tests "${ARGS[@]}"
+	terminate_pidfiles "${pidfile}"
+fi
 
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"

-- 
2.47.3


