Return-Path: <netdev+bounces-240664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 784EDC776EE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFA4E748C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244F2FF144;
	Fri, 21 Nov 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWFEJt4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C02FCC01
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703902; cv=none; b=Z2fb5t4nPmGyTgARl4MvGw4ymWAFduPR0uTN4x83drNytZxSVUb4WDnovnpEeimBCVaupnsGLAWM9Gzhr6shcCNe7TJYrZHecfODKkv8TrIjDiXRSWwCE5OzzrYEXmL2Q5JTW4jUEXbVn+fLklpJt12OKNTpBVz+enXGJUl8qNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703902; c=relaxed/simple;
	bh=dLqHAItx9mFQf4mJ0TDWA0vu/MRgEQeXnYFPU6Q9mTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qketmStAOiVPpYKed8OoYNKqAUNgSbblZuKOWHX69DTKpjfGdhGdRWCFLAUmLdpE7wWbrzHXeqXz8MZnOrfYa36rYQERfThPMl6oueGa0Gngq4g/So/DIUyq5EdcWEuA91gomfJc8mQFDupv8ZX4GmgBHQOiNAIp1nj8rl0lP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWFEJt4B; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so701283a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703898; x=1764308698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDBkxvqePG9pbCy3nBUwmVuR9KjnUrVCuFljawa5iCE=;
        b=AWFEJt4Bqwej0yJTjVHvcVa+uZjYQWMZ7cjollxBvyClmEncy2JF7ku0fck1R5nNC3
         zdcVH0Z5DBypPThmq51MkMhe6U1pMfkSw0BzItBzGFiKkycgAaezoi7ovR5nMploGv0F
         laFthun+4/o8zDWZ4ESqXW/mm/Bdk3p8wXrVRnnG8p7S6IGOZA6StsmDAalV70UOgUjt
         Gctk2So5pl3zyoNQOJ+Yy4i031bfEY2E79ZuO+pmDj+gFCKXmxRGjk6RariMPItMgLW0
         9EOqzuUN1Asdq6N2HD80bhAOGUnL3eHfgNZEjQIvuBFUjKFTNKlYx+2gaDM1/R0NZ4tO
         RfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703898; x=1764308698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VDBkxvqePG9pbCy3nBUwmVuR9KjnUrVCuFljawa5iCE=;
        b=bX5Grql7Sqz3Iaj86n405Z0uvRlSQUcopwhI/bfeTYZ/H+/LSpek//LqipqV+7+fwT
         2phcacMyZUj/FqL0a1fBXziKLs/cnJ60BEOofn7XBDrGds3QsakO4ffTqEIQq3JMF+9U
         +MMBYoPC/31qW0dfhQhKmDZHUSTL3e8bRNR3evLkhE3zeOqy1LTWh3TOyIDk5vkaW1Kk
         4Eeinbz5eo2uIkTJTGXcXkHLqtFxV/U6286Fb29rVd2CdmxqZcFCovVSE4hElJivIkji
         Z6su630F24iTJE4CwyTyH1aybaRNE5Tprff2hOg6JeApRsnaDYpLlwWeVDzd22QnzaXq
         3yrA==
X-Forwarded-Encrypted: i=1; AJvYcCUmUHmNhyBCcCXTQDPOrrYtH0BiQosdxUBrw4CVb69JvO8+EV9snAeWcnszjcRcxEbMx9R80Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNPf6rCJZ6J4rDHrSIYVNIas4XdjexJlKRwqNClv6ivqZqsSp
	tdvtWiYDHqePfLMbW2MIIuQgFPXXcJnKvaerPVkzu5Eg1F6P/IQ8iF6s
X-Gm-Gg: ASbGncvDYESgiIjEd/oGe0C5i7Ax8dttx7xWI1QSOgnY/KZd8IHAn/n05fYzA7y0Ve0
	1CACV5JlbvoCX73acDEf0o0u0F6yocqbpJZFCZhjySZ0qEKp6w46RAcmWtMtfQ1XVXye+yuubb3
	l25MtX45gKKCyWizhMoJejTe8f1lfTTOA3YJCSfnzzmsdmtEGwbC2Ijwyo1x7qXSHiJarD7e8OO
	v3wDcxkyJh4ulIAkMZAG+g+uMmF7JC4niajgqGhEkV5C0fk4PoumgI8QR7bzTCelF91z15SqiQq
	kK+IPzZ+4N23aVp01f2UkiU1ikAawLAnExefdvf1aBibHHt7LQRZOgU6xh0G7FLEogsL3lA9BT+
	IzGohedJjeT6iEWRrMl8+Hzc9orefJ1FUS0kpJFubux0qiESUfClINaYmpopcVvOdEwAz+8xYaq
	y5fJ7/EQL9+EIYvMraxfHc5ubTH9gXPg==
X-Google-Smtp-Source: AGHT+IEBMn6TQYN1j4KFxziEA98W0yBi294QmAjGh6KNbAmhH8gwotxis/ko5/31tPJswq8x6D/dpQ==
X-Received: by 2002:a17:90b:534e:b0:343:89cc:6f23 with SMTP id 98e67ed59e1d1-347298c0cb6mr5941596a91.14.1763703897724;
        Thu, 20 Nov 2025 21:44:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727bcc59dsm4086780a91.2.2025.11.20.21.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:39 -0800
Subject: [PATCH net-next v11 07/13] selftests/vsock: prepare vm management
 helpers for namespaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-7-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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

Add namespace support to vm management, ssh helpers, and vsock_test
wrapper functions. This enables running VMs and test helpers in specific
namespaces, which is required for upcoming namespace isolation tests.

The functions still work correctly within the init ns, though the caller
must now pass "init_ns" explicitly.

No functional changes for existing tests. All have been updated to pass
"init_ns" explicitly.

Affected functions (such as vm_start() and vm_ssh()) now wrap their
commands with 'ip netns exec' when executing commands in non-init
namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 93 +++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index f78cc574c274..4da91828a6a0 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -144,7 +144,18 @@ ns_set_mode() {
 }
 
 vm_ssh() {
-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
+	local ns_exec
+
+	if [[ "${1}" == init_ns ]]; then
+		ns_exec=""
+	else
+		ns_exec="ip netns exec ${1}"
+	fi
+
+	shift
+
+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
+
 	return $?
 }
 
@@ -267,10 +278,12 @@ terminate_pidfiles() {
 
 vm_start() {
 	local pidfile=$1
+	local ns=$2
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
 	local qemu_opts=""
+	local ns_exec=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -291,7 +304,11 @@ vm_start() {
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
 
-	vng \
+	if [[ "${ns}" != "init_ns" ]]; then
+		ns_exec="ip netns exec ${ns}"
+	fi
+
+	${ns_exec} vng \
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
@@ -306,6 +323,7 @@ vm_start() {
 }
 
 vm_wait_for_ssh() {
+	local ns=$1
 	local i
 
 	i=0
@@ -313,7 +331,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -347,30 +366,41 @@ wait_for_listener()
 }
 
 vm_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	vm_ssh <<EOF
+	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
 }
 
 host_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	if [[ "${ns}" == "init_ns" ]]; then
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	else
+		ip netns exec "${ns}" bash <<-EOF
+			$(declare -f wait_for_listener)
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+		EOF
+	fi
 }
 
+
 vm_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -378,7 +408,7 @@ vm_vsock_test() {
 			2>&1 | log_guest
 		rc=$?
 	else
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \
@@ -390,7 +420,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${port}"
+		vm_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -399,22 +429,28 @@ vm_vsock_test() {
 }
 
 host_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
+	local cmd="${VSOCK_TEST}"
+	if [[ "${ns}" != "init_ns" ]]; then
+		cmd="ip netns exec ${ns} ${cmd}"
+	fi
+
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=client \
 			--peer-cid="${cid}" \
 			--control-host="${host}" \
 			--control-port="${port}" 2>&1 | log_host
 		rc=$?
 	else
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" 2>&1 | log_host &
@@ -425,7 +461,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${port}"
+		host_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -469,11 +505,11 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
-	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+	if ! host_vsock_test "init_ns" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -481,11 +517,11 @@ test_vm_server_host_client() {
 }
 
 test_vm_client_host_server() {
-	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+	if ! host_vsock_test "init_ns" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+	if ! vm_vsock_test "init_ns" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -495,13 +531,14 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+	vm_ssh "init_ns" -- modprobe vsock_loopback &> /dev/null || :
 
-	if ! vm_vsock_test "server" 1 "${port}"; then
+	if ! vm_vsock_test "init_ns" "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+
+	if ! vm_vsock_test "init_ns" "127.0.0.1" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -630,8 +667,8 @@ cnt_total=0
 if shared_vm_tests_requested "${ARGS[@]}"; then
 	log_host "Booting up VM"
 	pidfile="$(create_pidfile)"
-	vm_start "${pidfile}"
-	vm_wait_for_ssh
+	vm_start "${pidfile}" "init_ns"
+	vm_wait_for_ssh "init_ns"
 	log_host "VM booted up"
 
 	run_shared_vm_tests "${ARGS[@]}"

-- 
2.47.3


