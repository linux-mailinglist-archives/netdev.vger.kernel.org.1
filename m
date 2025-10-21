Return-Path: <netdev+bounces-231451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1DCBF9514
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D61523480C1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D292ECD05;
	Tue, 21 Oct 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWc1v91H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF742BEC22
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090433; cv=none; b=TnKnvzzFChI21dBeSvtBppSHACZsnyvKTiCP+c6xjySotbe9C1A4dEtQfhU6cBqJFpt5znKy2ZCKBZmsd9yqumTle5Xlk49J6GVrIlFAePQ9AOCN/2ZMUka50gYORe17asKdP+VIYZ8b0lcAlfbyH/AaEvcQDodRn4NNAgnhTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090433; c=relaxed/simple;
	bh=bLgJRj0B3l4I9LRxTwg4ipTz6i5xRpftUXJZZBIn7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdWnKlmy0qxu0y3ylsTHCqM41Ct4SfpFEodTPHn7DS4yH8O6uuEtZk85ckxI7HUKUhxNU+9lYTamKfvnnhwjYk/0sx6SJPGDKgm6JZ9yeQhEHaZoN/UihbqkW9D5yzXhA2q/VZUc/ZwvQ0513RXksUBUX9PFOuHEdax9haq615I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWc1v91H; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7930132f59aso8281981b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090429; x=1761695229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=WWc1v91HrI0aX0IVlRuS9CMwS78uNFi5IhWxvqoBKtmul+3fGRFloPkHbfh/QwQnqE
         Q7JFpeMIHePBAcMlQMy0lN88yIXcm2r7p4J6Xtv8PVqfgsB7o5ZsgCxjU+HwiTYsAdry
         S/WT2cxKpMj57Ta/9D7Z5+jt/0Wa/3MbWkKDDFGoSy1z/rlcH0D3dTOgFeN8ER67qf2S
         Pb26dukHqsR/6lZ/tDbLmJ6f6TlbCA2vnRIGJa4Cvc4iuKZOnAOU3F2IyKxLy4rYaV/C
         JOv6BDAFJbZnyWoPrKoOzqkaAFluha74bd3zhwCTbcicdLM232cKgi3PjhORkIbIvn3J
         844g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090429; x=1761695229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysnAf5Q6/F37oVxnktahtq8MWGwMsYn3elO8YpXbx58=;
        b=BnNUA3AMTkJLx255EF3zeVjuBNaJrO1DDX13YI5O/S1lv2BsfM5V17EL+UHhGa7ACY
         y+PAj5sCQ7hLeFA03l9wHjH+L24tROhdL791sbpjGqAywnCoFEwcjcX+GJaAnbhBTnSu
         JcDJ1BhifXT7fr8bQCLcWAE03JwAGxSIhxMnCBTHjfjD3NDiKOyvMOQDXewGIZS/C5eY
         FDvfoq/U8o5y5UOn1zGNAxTlmbyL59Dr7ogLquHKSGlbHdnieJCY5ms+q3zDIXJwuHB8
         9eG3qdWI6EpFGHM/ZwKHExaU2k11nXfh55VMwQPH1PidsgsYonm35whbdjPvCJ9MzR4z
         Pa2A==
X-Forwarded-Encrypted: i=1; AJvYcCWNWuIXU6q0Ay29cYBlS/i/TCgX2TLnNBRTJd8sVX3TRdGgphx8Y7oFbAIYVsNnhWXZzEQU+Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJXLvX3flBkLlqg1XCvOeW2mK6Jp4KWQiN6maJRefIiZATOqu
	Y8ketYMfRGD4S1nGjWo7mmnOxw2F5bVNpy9FTOFsXiMOa3VVgWGGf8jo
X-Gm-Gg: ASbGncsABF7HvI7TrsrS49GWArboyrDRPW3rYqIpmx9AjJ5bbbxs+tQK3b9FoBblWyu
	q48Co6/G/ry4EJmIeyd1WbVKFnSf7AQIP8ABWyGDu9Rjbk6LMgZ/8fjJLsqiB6Gr0orb6sHmkUl
	csqzjBqX8thafz3F/jFblwDyfK9UQCB0S+OUwR89dBflhCNX7HSbPdiCsMfTs6IaPReJWxP9H3N
	zjUP1GHHgdilKi6BpK2GQCuTnZ1A9bGy7qA4FEI37y4e7SGHxR3USQRQGahOWzNrLSsGR1lTosH
	S9gOLDeAt1XKcZi4VolxGe0Mu6Etn9s+DImwptrmKtBp1rd8/4fIWCk/iIEfkDHcDZqibaUUnrV
	GS3L646BYDkeNQ7+kzo4FkH8kGACMy33uRt8sGe4Vk1QVtFeE+Kr6Lr9PtGXIvDMMnmM9xe4t
X-Google-Smtp-Source: AGHT+IESeY2Sh9LyXvlNWSBcoIwZ1r/2aMHLIXNnNKYEULemMRlMzJHh0W4ok0D91ZgsuVhYMMaokA==
X-Received: by 2002:a05:6a20:1611:b0:2ae:dee:4ba with SMTP id adf61e73a8af0-334a85bb208mr23055148637.50.1761090428628;
        Tue, 21 Oct 2025 16:47:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff5d76bsm12490315b3a.33.2025.10.21.16.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:08 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:53 -0700
Subject: [PATCH net-next v7 10/26] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-10-0661b7b6f081@meta.com>
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


