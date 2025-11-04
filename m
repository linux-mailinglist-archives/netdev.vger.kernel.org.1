Return-Path: <netdev+bounces-235605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A381C33416
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C218C481E
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541C346FA2;
	Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpGdT9ZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DD33B6F1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=OvXeWtC2O2jxpFSJ3g66FqYrjcx1ZMDfufi3vTUZqsocKPvA2IDdTZ/4oDB4CCETmJx/6CZkirxTQxBlTr8SlVO2kvgLiElXo3gCC70j5glvPs4ksiQT+Zx3WPjjqylSqM8W1s2eywjJHTGmWjeWY/O3/Muf5S1DZC1Q/CDiSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=/8284WgqZBkmvYo7p6HbzA4BQ9SwpvVlj048Ne45Jpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYkxlen30aN6UU3U8JS/uUsdsUBR04YL+HqqScqYsrWSvk7rhSl2A8Wt1Dg1anb22mMXQQr6gVtpmINMssAgEGvLMt90RgMFUQ0zWtDYfXwAxj344qiyFPB+wWdY5AqbqTZiDNvOnNY4JZwKzdTpSX0ehy/261EDj2NESHNYtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpGdT9ZZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-341988c720aso515205a91.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295952; x=1762900752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZp+C4CcVFJXBROG1xENTNsT1iMwKGcBzeNVL/tTmVw=;
        b=HpGdT9ZZSUGCLKyD1inkdmnlnbkltkD0Q4GGENk3x2FP/lJKQ3wUVv1HHiLHHKJOs6
         R68ku1OWN2PdHS/5S7qX+Cmpbt+MSaGjNm7qmkeL2wxKxELCH6lCubqQ5f3u0hFDePLy
         lr8VvhQiZdupBi5wZYTeLrUGrmEp5sb/cQSOdFKlkjVRasYgET2h4Q5uY2uxQrpyp+Rx
         fxL6tcDMCdULiTtFCTU2kLsL8KI7nfiPBavXk5eallKdpJKqI2yIw7naRvkOoRyqn1+M
         pwiAwsPKkzZPUX7mA82sV2S6D/HvkQufp9p3caNcTeg1nEa20xS1XWLOV6HxYLMsxBDB
         Ox3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295952; x=1762900752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZp+C4CcVFJXBROG1xENTNsT1iMwKGcBzeNVL/tTmVw=;
        b=tHAo8DgAIKRDdEr9ikqwwlgYLGdchMtVM+LOUdQsxXzMp3qVOw9Uh8bOlD57q/MUfC
         BkHmdJ+JJHPTDe1pQlSbR6C75yJWiJ0zT6IMHvCVbBKPxT61mjnklBzJ9FiHbT5PXDQj
         BByED2qGiIFtGy8syono3MG7YeQA+QppYeHug8G3jlkDo0VgAZckdGhJHbDK9smKCNy/
         P2NzVyvRH1DnFGfMUW31Arm8KvOG8PfYLLKe/rcZnqRrnFXSRdP9288ZvqS7ee23wdmo
         KeDOuBFFYSHlrFZUVNTZY/5h4tU/1V40oRAmU7iyuyueydy7CqDLsS4J+FDafxceyLJ7
         jw7w==
X-Forwarded-Encrypted: i=1; AJvYcCVcm1DBC9vpaj8RcPE40/6ql3nYhXSKJMmpfksBxMXSq7L5DKw33gH3r3vGbdJptdsIUh1ibpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfd+wvf+TCnJDKlJentivoJgd/nneMFKzn5GUer5hzasZ8sJH
	jDX/lB1rx8dgHFZrRf2xvojiscOm9i7tFR7Nm9e/pg+08PLnMlzexKPA
X-Gm-Gg: ASbGncvDpDcIqyACEDNGSGh6aQDAMVGtYrJp7/zRPiF0c9Ab5avhL5wTeltKOYXv2as
	AVv24USyuxa/ybXKdh5O6xyZGW7nhtNM7uanJFx9PtJRhnrM3ShXzSJ6x/l9Y8NSwgjhIlxgTgs
	qkgHdX2WPPHK5Ua3o+sTxYqYkf/Fr5ZVZ2g+WnVxHHgffCqqCuiGOJFsO6hPRl8PHV/ydq+E/ns
	HkPcd98hkMEtZRQXcvWA9uCkqjRBCMQrYtxwoCh3mIR3FPuZ8n78W2RT79a+Ujkbiv29kA0HtoF
	ReWwk+cez8qUZ3OYqeMA5pk5pTfOLVtigCwKKxGMgC92JpGNaOrD6YXLrQy/7c6hRSXVYzUHz3Q
	aVEpQxThVaNJvH5hD8iByNf7dBQI9X0ZT7L79iLuzZLH5C27Muz928DNLgK/MDAATRniwmJB9bA
	==
X-Google-Smtp-Source: AGHT+IHtBPG9OeMS+uLaPZ7VQjgXPmnJkhyPQNwSqGa6hD901ItTF9A+GhcbDo+Uvew9U846BuIvcg==
X-Received: by 2002:a17:90b:3751:b0:341:194:5e7c with SMTP id 98e67ed59e1d1-341a6dd6953mr825767a91.24.1762295952118;
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f18315bfsm3432766a12.5.2025.11.04.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:53 -0800
Subject: [PATCH net-next v2 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-3-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 130 ++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index da0408ca6895..03dc4717ac3b 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -273,7 +273,77 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
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
+		host_wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		rc=$?
+	fi
+	set +o pipefail
+
+	return $rc
 }
 
 log() {
@@ -312,59 +382,41 @@ log_guest() {
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


