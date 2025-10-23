Return-Path: <netdev+bounces-231934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77055BFEC64
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E45C74E6BDE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B621257A;
	Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flCqHk1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A011E1C1A
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181230; cv=none; b=PwK/oZ4LZ5/SLoxcn2oum/Fes4pcVa/mEaRc8z2ckHMiGwia3w2PlVqgbJqkSqSTkKjeglxtyfGBzlwzmfJjMQ/8Z/4TMxW17j8cRDrmWfEaU5mJo2iyaLdoP+Qn44KTx3ugdJ+2E2ZAcQbcpK68gWPECc62DR3xd+MgO4GCx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181230; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldQbm2trp/oon/7BDsRV3BkQ5Bf9CgblOpv639wI5R0v/JbnioqTBa++ZpHbCd7LMsZp+BZPcQh49W9h3S8E2fxC332wN2PC41hyDDpKRYaqgIUBtNzPDMRYgRM5PBCj7UlW9dzMpD2ExuUAVfaE+OMmEJHE5DZopMd6/7UM+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flCqHk1m; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a27053843bso350747b3a.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181227; x=1761786027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=flCqHk1mDLdG9p/ErVgof8Zm1i7YjDT5YgjAFh3ysADTpr8bR5SXu4xYq1AHEBi3Vc
         3p/19KGyH1ABCaoQHxQMeZjEWLgylM5wNjVJv0/dJEyYQpayiz+fLd275/kq99Gan46n
         8KkQ41Ny9HrlivebrJuY5a0BARWuYbmm0MvoO7Hn529x8SCHYvmaK5RFV5qkOq/satQx
         OxdRSOduuVDIat+TDTJA1Ne0byneZCYPyGaGuOLpphlOoKu3152D/SJjDcPiQh5dC5Ap
         eDmx9Hz4Honp21eveZbxYi4XU0vuo7jRaJAVRYSpZ/BqlI/mHKFqwzs7XmQfs7qTB5/S
         bkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181227; x=1761786027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=dg5MHa8zzsyoUlCMXE+5dCWo2ioRyWS7ScTjfhQCBsGjZ/fhzQAAKjuIx7UkQZUAKR
         Ti+YzcNXIuE3nedkLy2u1X/hJoZvHXRQ8JT7skGtlrNDQ/C6JQtIHkGGGIIzS6p3Qf8Y
         OEg0lftPksRflLrwfCs2HmX9ufhRdHbKXIMWAaeIERi1LSG0AElFRrMsR4MknXE7xupw
         jhtrUdahORhnBem6uIXBZ4iZtdror4H7JswC8ulGEGGGo78wzVv2J8l6HAcTpIZya955
         iMmEhLGuEtjjWhsTdPoBTxUuThhRiqmTfCGYQZyXwactcEWdRlFwSlLxc8O5Vv8HSog4
         mWmw==
X-Forwarded-Encrypted: i=1; AJvYcCUf48rdTQQX5q9YrFoM9X58XtXNPY9yEdT63UhvgLITGdLr6xaQcL9M7zZpT7nC/o1nUj+Udac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3WmDgaddBKwUI8IX9X+h6+DV//hicnB+02P8I+sOCoN+k+aS
	SHagQ8RulhzjOvg13f3pCSN/lReB4mgjcxdItU1utH02Z7L+7hpT7l/b
X-Gm-Gg: ASbGncuE01D4qo8ODiVk2usLapwPcFazsTzzSQNOm+PkNkYCvr9yZfEC8diggd7PBhV
	u31es7ltdmXy/pnqAVHRthWB5INZGIbzSu2HbLl2HUII6IL0mwp2wIp5OAWAzXY//QQZjS7KR3g
	hEXqhQRA8Ap6PZixdjp5t8TqNQBK0yIdT3mK2J+hxoP0gcAM7YFviiqI0WOeGbTxAokWNURslLS
	T/Ivsmu1yK97nFt4cXO3jAgvXKpheMXz6IiLW7nb4/CeWgnBIYkyMAfwSoWTL81Ob4tsGYHA9g6
	TvxOibub9fAi5AOJaLs8xuHXVwhTdriQel/CcTg1ngTq+bu01yew6RdZzdB9JIhly0RhN9lxylQ
	XPYZaiM8eZUULAHNquDT4kkjuhmlPn0EZh/GoxkuiWBwJ++jeOtcG12V62UtO6P7YI8w6frdJiA
	sHDnbb2tU5
X-Google-Smtp-Source: AGHT+IHOazPmZapnzVoec11my1SEQGOMvfwZs/K9HZJGzOPAxbA0ZzCZ6eN45sS9QYFtvW0q4Wovgw==
X-Received: by 2002:a05:6a00:4652:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-7a220d2330amr21377015b3a.20.1761181227244;
        Wed, 22 Oct 2025 18:00:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274abf6d5sm563573b3a.33.2025.10.22.18.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:07 -0700
Subject: [PATCH net-next 03/12] selftests/vsock: reuse logic for vsock_test
 through wrapper functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add wrapper functions vm_vsock_test() and host_vsock_test() to invoke
the vsock_test binary. This encapsulates several items of repeat logic,
such as waiting for the server to reach listening state and
enabling/disabling the bash option pipefail to avoid pipe-style logging
from hiding failures.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 131 ++++++++++++++++++++++----------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ec3ff443f49a..29b36b4d301d 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -283,7 +283,78 @@ EOF
 
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
+	set -o pipefail
+	if [[ "${host}" != server ]]; then
+		# log output and use pipefail to respect vsock_test errors
+		vm_ssh -- "${VSOCK_TEST}" \
+			--mode=client \
+			--control-host="${host}" \
+			--peer-cid="${cid}" \
+			--control-port="${port}" \
+			2>&1 | log_guest
+		rc=$?
+	else
+		# log output and use pipefail to respect vsock_test errors
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
@@ -322,59 +393,41 @@ log_guest() {
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


