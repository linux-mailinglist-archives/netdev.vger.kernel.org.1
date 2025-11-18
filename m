Return-Path: <netdev+bounces-239333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C9C66F16
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2412D35D66D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47132ED27;
	Tue, 18 Nov 2025 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOjrw6JY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AD329E40
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431246; cv=none; b=LQmhtVpDVwpiuXJnLwtcQCwuVlb2SxwNyUoQECwqSx+O2hsBT9ZE/40PLSuU6jLUkuDRZKRNDSQpHfO6kR6WlptdquLF5gTzyXmx7xPh8cA4+9DfjBtmKpw7qvSxVZN/kb27RI/vvn0EqhSw4AVKI5/kq8bepO8K30LH8LuX+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431246; c=relaxed/simple;
	bh=T4Q0xSf6R3podxO4R+Ma9r50o0a0RBOgmhxddA+GpUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RqJPTSi0bdMWv5PUE3pQHnH/nFn6j4BqbeX0Go6/orOKPl7yc1uNFDc5a+d+wkVPlfpQ2ShdLKtrB8jgs0K4RiVF+1WwIkv16W2u7aXb7kUfTfF4hrLJDPmtJsxzRfOvrKdnSD8QMPGrB66ACgYPeSqmNCFqbUyyPyRR8vrqP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOjrw6JY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29853ec5b8cso57904955ad.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431240; x=1764036040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSPkUpgEn2Y0MP2KCB5fV1UyMT32r8AXV208PKunv0k=;
        b=IOjrw6JYlxLkTnU96UvEHuKcrKFCkVgzkMyeGsnsJB07vk7sib8swFqaVhCU93Nrdk
         JVtxVRpPOtoaphn2CTjvhIPsPw/f1K92wJualg2Jcz4MOLm4Q1cR9kWHGIuQPhwjb3HF
         EdoWHMdNRXII2lcV4JmUWcmnUxn9EzRDwEogqCuOloGhOT1PBkRwIM2mq1Gp+QqGlUBH
         ZyQ+SH72DqeHSqN5hReEwrKIF4pkrk5muNuVScxUjmKf6uEVSSwYbhMDauJu4mA+rZIl
         ODbfCz6BYk24S/t16HfUsiXSFtGdc9ZGUsM20f7/u28TXa1xVcfH5aKmyRBRGF4OjGla
         0huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431240; x=1764036040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSPkUpgEn2Y0MP2KCB5fV1UyMT32r8AXV208PKunv0k=;
        b=smyl0aq9LEtqQiTHTzpavfKfMqne1ge/udTEPl5QVJeJQlWmL5OIpTlGOzAyq7C6N4
         OisaQC58A1gNp+dTcykt8Yd5GNHZSmOC5oeOm2+pOZ0pMjLIgASCWNP8mVLcwgpbDx14
         2W4Uv0aGcnhkUB4xKDWGFDXTMddHmJ0K0U6/yshyaTYEHcL7t+1cMRiHMaFS+2NpyMFK
         ljuu8vXYmH5tiNShcjtQFqOyAAOZpbNDAwuo+eynPGm7UTxyZUZTlrhHHlJkdKJJD8YR
         OClohXf1x3cX9WiiXb7fJk+L32SXHTQBKiR7lC0BM2uwOink61pZ9bu5jwYAkdggkBi8
         jZdA==
X-Forwarded-Encrypted: i=1; AJvYcCUzYVgzhScT/M27LwmXUD8l6hzQIzCepXRUfqCXJwlqrWgfywU+tkR2m6pEd6pL+6TvF0tzyMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjpOA/BC9B8cr5j7bXfFDkDOJWIx/R59inMq7a0wSYdmQ5jGA
	gDdKr+HoWlEPtGgP+guNVJx75Ml/Op//Anin2mLumV3s99bwob1b3fMN
X-Gm-Gg: ASbGncu/m28HDyRaWzaKfDfL+f/wEQ5TJxy6vQKQhurMocVHjfGCp5ApC7DmKjYTX9M
	LgrnAi5wzgWvooaqEAj64yTftNXfE7qap+5BhmPD1iPYtEqX4KAmUyDe4fEp/YAzyAm36D0J2cx
	0uuHC/6DWJB7Qos7L63N0zK7X89O+6/n6YCi3HAt8t86qFR8XiyDbhl/uCtkurDeINFTDXsBRNC
	9Nq5Xb/sIItBoLzT2UasWHlKq38GN8iY+85fbzzzjuLNSyMCOFVBl+fCuAAPQavUq6b4wsPL+tY
	gArHg3QRAxg3V/qIjfv5SXH0bzZXjGsFT5G16xB7QBtarU5Cb+ZXtlQJk+hiYJIeZOER0D7DGFb
	AR35QYSa1+8GrA982Gi/Sf+W41nWxoafCf92evcQ6IB8S1t7583gctlZNHEanzmV1LP8XrahSLA
	qgW/mFvfVbANBPFcxt3lPG850Mo7qQnA==
X-Google-Smtp-Source: AGHT+IHAx36So0bPcvUrc+TUQe4tuwQofa8paulwJrfKRSnfE2RklDk+Wb1IvphsE5+ZCVqfKKehuQ==
X-Received: by 2002:a17:902:f687:b0:295:82c6:dac3 with SMTP id d9443c01a7336-2986a7416e4mr174165575ad.32.1763431240168;
        Mon, 17 Nov 2025 18:00:40 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b1088sm154893845ad.57.2025.11.17.18.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:00:39 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 17 Nov 2025 18:00:33 -0800
Subject: [PATCH net-next v10 10/11] selftests/vsock: add tests for host <->
 vm connectivity with namespaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-vsock-vmtest-v10-10-df08f165bf3e@meta.com>
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

Add tests to validate namespace correctness using vsock_test and socat.
The vsock_test tool is used to validate expected success tests, but
socat is used for expected failure tests. socat is used to ensure that
connections are rejected outright instead of failing due to some other
socket behavior (as tested in vsock_test). Additionally, socat is
already required for tunneling TCP traffic from vsock_test. Using only
one of the vsock_test tests like 'test_stream_client_close_client' would
have yielded a similar result, but doing so wouldn't remove the socat
dependency.

Additionally, check for the dependency socat. socat needs special
handling beyond just checking if it is on the path because it must be
compiled with support for both vsock and unix. The function
check_socat() checks that this support exists.

Add more padding to test name printf strings because the tests added in
this patch would otherwise overflow.

Add vm_dmesg_start() and vm_dmesg_check() to encapsulate checking dmesg
for oops and warnings.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v10:
- add vm_dmesg_start() and vm_dmesg_check()

Changes in v9:
- consistent variable quoting
---
 tools/testing/selftests/vsock/vmtest.sh | 558 +++++++++++++++++++++++++++++++-
 1 file changed, 556 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a8bf78a5075d..9c12c1bd1edc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,7 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#		* socat
 #
 # shellcheck disable=SC2317,SC2119
 
@@ -52,6 +53,19 @@ readonly TEST_NAMES=(
 	ns_local_same_cid_ok
 	ns_global_local_same_cid_ok
 	ns_local_global_same_cid_ok
+	ns_diff_global_host_connect_to_global_vm_ok
+	ns_diff_global_host_connect_to_local_vm_fails
+	ns_diff_global_vm_connect_to_global_host_ok
+	ns_diff_global_vm_connect_to_local_host_fails
+	ns_diff_local_host_connect_to_local_vm_fails
+	ns_diff_local_vm_connect_to_local_host_fails
+	ns_diff_global_to_local_loopback_local_fails
+	ns_diff_local_to_global_loopback_fails
+	ns_diff_local_to_local_loopback_fails
+	ns_diff_global_to_global_loopback_ok
+	ns_same_local_loopback_ok
+	ns_same_local_host_connect_to_local_vm_ok
+	ns_same_local_vm_connect_to_local_host_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -82,6 +96,45 @@ readonly TEST_DESCS=(
 
 	# ns_local_global_same_cid_ok
 	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
+
+	# ns_diff_global_host_connect_to_global_vm_ok
+	"Run vsock_test client in global ns with server in VM in another global ns."
+
+	# ns_diff_global_host_connect_to_local_vm_fails
+	"Run socat to test a process in a global ns fails to connect to a VM in a local ns."
+
+	# ns_diff_global_vm_connect_to_global_host_ok
+	"Run vsock_test client in VM in a global ns with server in another global ns."
+
+	# ns_diff_global_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a global ns fails to connect to a host process in a local ns."
+
+	# ns_diff_local_host_connect_to_local_vm_fails
+	"Run socat to test a host process in a local ns fails to connect to a VM in another local ns."
+
+	# ns_diff_local_vm_connect_to_local_host_fails
+	"Run socat to test a VM in a local ns fails to connect to a host process in another local ns."
+
+	# ns_diff_global_to_local_loopback_local_fails
+	"Run socat to test a loopback vsock in a global ns fails to connect to a vsock in a local ns."
+
+	# ns_diff_local_to_global_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in a global ns."
+
+	# ns_diff_local_to_local_loopback_fails
+	"Run socat to test a loopback vsock in a local ns fails to connect to a vsock in another local ns."
+
+	# ns_diff_global_to_global_loopback_ok
+	"Run socat to test a loopback vsock in a global ns successfully connects to a vsock in another global ns."
+
+	# ns_same_local_loopback_ok
+	"Run socat to test a loopback vsock in a local ns successfully connects to a vsock in the same ns."
+
+	# ns_same_local_host_connect_to_local_vm_ok
+	"Run vsock_test client in a local ns with server in VM in same ns."
+
+	# ns_same_local_vm_connect_to_local_host_ok
+	"Run vsock_test client in VM in a local ns with server in same ns."
 )
 
 readonly USE_SHARED_VM=(
@@ -113,7 +166,7 @@ usage() {
 	for ((i = 0; i < ${#TEST_NAMES[@]}; i++)); do
 		name=${TEST_NAMES[${i}]}
 		desc=${TEST_DESCS[${i}]}
-		printf "\t%-35s%-35s\n" "${name}" "${desc}"
+		printf "\t%-55s%-35s\n" "${name}" "${desc}"
 	done
 	echo
 
@@ -232,7 +285,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh socat; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -283,6 +336,20 @@ check_vng() {
 	fi
 }
 
+check_socat() {
+	local support_string
+
+	support_string="$(socat -V)"
+
+	if [[ "${support_string}" != *"WITH_VSOCK 1"* ]]; then
+		die "err: socat is missing vsock support"
+	fi
+
+	if [[ "${support_string}" != *"WITH_UNIX 1"* ]]; then
+		die "err: socat is missing unix support"
+	fi
+}
+
 handle_build() {
 	if [[ ! "${BUILD}" -eq 1 ]]; then
 		return
@@ -331,6 +398,14 @@ terminate_pidfiles() {
 	done
 }
 
+terminate_pids() {
+	local pid
+
+	for pid in "$@"; do
+		kill -SIGTERM "${pid}" &>/dev/null || :
+	done
+}
+
 vm_start() {
 	local pidfile=$1
 	local ns=$2
@@ -444,6 +519,40 @@ host_wait_for_listener() {
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
+
+vm_dmesg_check() {
+	local pidfile=$1
+	local ns=$2
+	local oops_before=$3
+	local warn_before=$4
+	local oops_after warn_after
+
+	oops_after=$(vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops')
+	if [[ "${oops_after}" -gt "${oops_before}" ]]; then
+		echo "FAIL: kernel oops detected on vm in ns ${ns}" | log_host
+		return 1
+	fi
+
+	warn_after=$(vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+	if [[ "${warn_after}" -gt "${warn_before}" ]]; then
+		echo "FAIL: kernel warning detected on vm in ns ${ns}" | log_host
+		return 1
+	fi
+
+	return 0
+}
+
 vm_vsock_test() {
 	local ns=$1
 	local host=$2
@@ -568,6 +677,450 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+test_ns_diff_global_host_connect_to_global_vm_ok() {
+	local oops_before warn_before
+	local pids pid pidfile
+	local ns0 ns1 port
+	declare -a pids
+	local unixfile
+	ns0="global0"
+	ns1="global1"
+	port=1234
+	local rc
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+	ip netns exec "${ns1}" \
+		socat TCP-LISTEN:"${TEST_HOST_PORT}",fork \
+			UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+	host_wait_for_listener "${ns1}" "${TEST_HOST_PORT}"
+
+	ip netns exec "${ns0}" socat UNIX-LISTEN:"${unixfile}",fork \
+		TCP-CONNECT:localhost:"${TEST_HOST_PORT}" &
+	pids+=($!)
+
+	vm_vsock_test "${ns0}" "server" 2 "${TEST_GUEST_PORT}"
+	vm_wait_for_listener "${ns0}" "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns1}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pids "${pids[@]}"
+	terminate_pidfiles "${pidfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_diff_global_host_connect_to_local_vm_fails() {
+	local oops_before warn_before
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${VSOCK_CID}, ns=${ns0})"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	oops_before=$(vm_dmesg_oops_count "${ns1}")
+	warn_before=$(vm_dmesg_warn_count "${ns1}")
+
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == "TEST" ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_diff_global_vm_connect_to_global_host_ok() {
+	local oops_before warn_before
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local unixfile
+	local dmesg_rc
+	local pidfile
+	local pids
+	local rc
+
+	init_namespaces
+
+	declare -a pids
+
+	log_host "Setup socat bridge from ns ${ns0} to ns ${ns1} over port ${port}"
+
+	unixfile=$(mktemp -u /tmp/XXXX.sock)
+
+	ip netns exec "${ns0}" \
+		socat TCP-LISTEN:"${port}" UNIX-CONNECT:"${unixfile}" &
+	pids+=($!)
+
+	ip netns exec "${ns1}" \
+		socat UNIX-LISTEN:"${unixfile}" TCP-CONNECT:127.0.0.1:"${port}" &
+	pids+=($!)
+
+	log_host "Launching ${VSOCK_TEST} in ns ${ns1}"
+	host_vsock_test "${ns1}" "server" "${VSOCK_CID}" "${port}"
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pids[@]}"
+		rm -f "${unixfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	vm_vsock_test "${ns0}" "10.0.2.2" 2 "${port}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${unixfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+
+}
+
+test_ns_diff_global_vm_connect_to_local_host_fails() {
+	local ns0="global0"
+	local ns1="local0"
+	local port=12345
+	local oops_before warn_before
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		terminate_pids "${pid}"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_host_connect_to_local_vm_fails() {
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local oops_before warn_before
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	outfile=$(mktemp)
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns1}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns1}"
+	oops_before=$(vm_dmesg_oops_count "${ns1}")
+	warn_before=$(vm_dmesg_warn_count "${ns1}")
+
+	vm_ssh "${ns1}" -- socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" &
+	echo TEST | ip netns exec "${ns0}" \
+		socat STDIN VSOCK-CONNECT:"${VSOCK_CID}":"${port}" 2>/dev/null
+
+	vm_dmesg_check "${pidfile}" "${ns1}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_vm_connect_to_local_host_fails() {
+	local oops_before warn_before
+	local ns0="local0"
+	local ns1="local1"
+	local port=12345
+	local dmesg_rc
+	local pidfile
+	local result
+	local pid
+
+	init_namespaces
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT &> "${outfile}" &
+	pid=$!
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		log_host "failed to start vm (cid=${cid}, ns=${ns0})"
+		rm -f "${outfile}"
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns0}"
+	oops_before=$(vm_dmesg_oops_count "${ns0}")
+	warn_before=$(vm_dmesg_warn_count "${ns0}")
+
+	vm_ssh "${ns0}" -- \
+		bash -c "echo TEST | socat STDIN VSOCK-CONNECT:2:${port}" 2>&1 | log_guest
+
+	vm_dmesg_check "${pidfile}" "${ns0}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" != TEST ]] && [[ "${dmesg_rc}" -eq 0 ]]; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+__test_loopback_two_netns() {
+	local ns0=$1
+	local ns1=$2
+	local port=12345
+	local result
+	local pid
+
+	modprobe vsock_loopback &> /dev/null || :
+
+	log_host "Launching socat in ns ${ns1}"
+	outfile=$(mktemp)
+	ip netns exec "${ns1}" socat VSOCK-LISTEN:"${port}" STDOUT > "${outfile}" 2>/dev/null &
+	pid=$!
+
+	log_host "Launching socat in ns ${ns0}"
+	echo TEST | ip netns exec "${ns0}" socat STDIN VSOCK-CONNECT:1:"${port}" 2>/dev/null
+	terminate_pids "${pid}"
+
+	result=$(cat "${outfile}")
+	rm -f "${outfile}"
+
+	if [[ "${result}" == TEST ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
+test_ns_diff_global_to_local_loopback_local_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_to_global_loopback_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_local_to_local_loopback_fails() {
+	init_namespaces
+
+	if ! __test_loopback_two_netns "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_diff_global_to_global_loopback_ok() {
+	init_namespaces
+
+	if __test_loopback_two_netns "global0" "global1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_same_local_loopback_ok() {
+	init_namespaces
+
+	if __test_loopback_two_netns "local0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_same_local_host_connect_to_local_vm_ok() {
+	local oops_before warn_before
+	local ns="local0"
+	local port=1234
+	local dmesg_rc
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns}"
+	oops_before=$(vm_dmesg_oops_count "${ns}")
+	warn_before=$(vm_dmesg_warn_count "${ns}")
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_same_local_vm_connect_to_local_host_ok() {
+	local oops_before warn_before
+	local ns="local0"
+	local port=1234
+	local dmesg_rc
+	local pidfile
+	local rc
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+
+	if ! vm_start "${pidfile}" "${ns}"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	vm_wait_for_ssh "${ns}"
+	oops_before=$(vm_dmesg_oops_count "${ns}")
+	warn_before=$(vm_dmesg_warn_count "${ns}")
+
+	vm_vsock_test "${ns}" "server" 2 "${TEST_GUEST_PORT}"
+	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"
+	rc=$?
+
+	vm_dmesg_check "${pidfile}" "${ns}" "${oops_before}" "${warn_before}"
+	dmesg_rc=$?
+
+	terminate_pidfiles "${pidfile}"
+
+	if [[ "${rc}" -ne 0 ]] || [[ "${dmesg_rc}" -ne 0 ]]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 namespaces_can_boot_same_cid() {
 	local ns0=$1
 	local ns1=$2
@@ -861,6 +1414,7 @@ fi
 check_args "${ARGS[@]}"
 check_deps
 check_vng
+check_socat
 handle_build
 
 echo "1..${#ARGS[@]}"

-- 
2.47.3


