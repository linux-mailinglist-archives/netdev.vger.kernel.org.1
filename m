Return-Path: <netdev+bounces-235603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9AC33402
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C40A18C47D4
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C44D329C68;
	Tue,  4 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq+IaYBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435FD313559
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295952; cv=none; b=ucrzyDO27GN5eh0nfhelXGyZW2mokbbMrXVgoviwGCbMvmV5M4c8WcpItzejrQtpjPuScLvswoq56YABMMYsA4CTAULT4cmQ/8+OZc+RsugyGMRBYLd8VhZcMjCHZ+oyATMzY6fKD0/9pZF9kJ+wc32ykz7K6DXQZDKDw7oyUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295952; c=relaxed/simple;
	bh=d0lXSaAPV1hSCbv4riJfsbPBoHPeUelaGN5Zg0VyKzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ls/fcbbdXraLaInT+yNtNkWdy2+mr+taH5D5aetl6eRCTj9SEkYOSfOpIP9z4dxijieMdTEwCJ41yPCWs3Xpsy3+PPQZt3RXk+SX9850vG+8H2QMcF7uIInl1d+tp4lJSZqkBZa5fskEOLaEIq0FmmaeKmqRZyOrk1GO2+ZONE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq+IaYBH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294fb21b160so42881045ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295950; x=1762900750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SCnFxkAKvo4bMRASv7XIHpGepGtL4M3i1ZyZegDajE=;
        b=Tq+IaYBH1ZvjquGGM6pV2Uxv+rsFwYW4p2GqoKwwitOgI+xMa1/O2vLTYJ6XT8/s1V
         HFOkXieNN7z7q9GWlRxw07kPuDTYblPzlQdpE5w7G7yB8cCaQBQxLnRVOAx3x6GWOf5R
         HbeeeQ4IJNAD+X28gpbMphlI/EJCEoxuClVhp4EA11oEaVghVV+dQNgQwt8WKbTljgoi
         jMyNqZtwqgPpRmj2qXF3jhh4+Vbo/N5K8Qmx+EpEtrdX2kxbKI+KnPjCuw5PnlSsxXd5
         MXdAitSt4wC4u4mJYsmiSb4ytUEeujIRXAjUrZqUZhV58Vb/q6AAe4YzwuBdTXpDrSeT
         z/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295950; x=1762900750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SCnFxkAKvo4bMRASv7XIHpGepGtL4M3i1ZyZegDajE=;
        b=Zs4aRUD5nuUwM6a3ygrPjMHVaNdc03mrfxmvuW0PXL6p/xx4+40zB6ZOxyu7MGxuyM
         L/f7cQU0ec7leHQu4qJQtOI+qkcCzTDSBSbQEbsIxW7XD75/b+or2fLfnbScFz6JFLhk
         MJhAe0zDCAjHCj8mCtoFRNN9/hMAGlxAu4kdWuxrqbnYVwWIAK5BhQcFeDwG7KIBQNa2
         m1MmULBq3RoqpfPGVpvkvQKWlRalKkA9MPjimrEkzxM2c4VxDXf7NP6rav61Ib2Z0YpP
         7nbnn9PtTGwkmuug+C0ceTp8vsIYAndaf26ayjfxXZIsj68fMlVzUoHzkeC9vO33STPC
         jaVw==
X-Forwarded-Encrypted: i=1; AJvYcCVaXRqP/lWBFTvFqKQTSFWPTAVfHMh/BpcQcfD6ie9g23ulFfGYfffIMYhAyhDl7Pyvymuu/OA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1hRSgwZorBX2xZPP2Dh2jItBLmGvcrt6mSOOjyLz7nO5Xaw2
	FXYQX9eM6MYiMRkOeth0B3XJxEvol6Edy7LSRosHH2uhaRrCegpb32Jd
X-Gm-Gg: ASbGncvgDjg41AZ6fo3clw3/VvPps6CECxIc4baiGmUYvQD3pofTlLSWJjvJWSpODg1
	6FMlpKF0uR59jnfV2UJryHSbqQplSxXV3Bl8Op3ciDidOW/8zlF/OCskSRZx02DgsnriK0ae4SN
	S6VfnEBUZUlPwTTSmK66sXO0A1TOVl6nsB7AXtxKMvaxBPwEJ0dq5QmLfXYL4NNqM8du2y6CLxL
	W/Y2GPzrjFotfya1m7nwQG26mGkkbF7p3BysKLZhMU5s4UCYNqBd5PNH/6e8twJxn06MJCeslVB
	H11cVn15EVbRG+xkSrpI5a4xJi1gsJbXj+GIy0EVlaBzmqsgjMABHKfq83NYVhTnbF6E7hTlOZU
	C8lLatba65BzOiU4+sRkPHdxrARekSPnthINcC/LP/qpSOPAnMiri6uL//XfJZpmuUAQ8tzQ9
X-Google-Smtp-Source: AGHT+IFj0ralhxCw9gtXMNxyl9Kpp7b0xZeMtfhdxLBXWpHqRS7iX83xZgLhRxoK9y2BWDEiCj0m4A==
X-Received: by 2002:a17:902:d2c6:b0:295:7453:b58b with SMTP id d9443c01a7336-2962adb29cdmr12165085ad.4.1762295950273;
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a609c8sm38264015ad.92.2025.11.04.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:51 -0800
Subject: [PATCH net-next v2 01/12] selftests/vsock: improve logging in
 vmtest.sh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-1-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Improve usability of logging functions. Remove the test name prefix from
logging functions so that logging calls can be made deeper into the call
stack without passing down the test name or setting some global. Teach
log function to accept a LOG_PREFIX variable to avoid unnecessary
argument shifting.

Remove log_setup() and instead use log_host(). The host/guest prefixes
are useful to show whether a failure happened on the guest or host side,
but "setup" doesn't really give additional useful information. Since all
log_setup() calls happen on the host, lets just use log_host() instead.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- add quotes around $@ in log_{host,guest} (Simon)
- remove unnecessary cat for piping into awk (Simon)

Changes from previous series:
- do not use log levels, keep as on/off switch, after revising the other
  patch series the levels became unnecessary.
---
 tools/testing/selftests/vsock/vmtest.sh | 69 ++++++++++++++-------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..1715594cc783 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -271,60 +271,51 @@ EOF
 
 host_wait_for_listener() {
 	wait_for_listener "${TEST_HOST_PORT_LISTENER}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
-}
-
-__log_stdin() {
-	cat | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
-}
 
-__log_args() {
-	echo "$*" | awk '{ printf "%s:\t%s\n","'"${prefix}"'", $0 }'
 }
 
 log() {
-	local prefix="$1"
+	local redirect
+	local prefix
 
-	shift
-	local redirect=
 	if [[ ${VERBOSE} -eq 0 ]]; then
 		redirect=/dev/null
 	else
 		redirect=/dev/stdout
 	fi
 
+	prefix="${LOG_PREFIX:-}"
+
 	if [[ "$#" -eq 0 ]]; then
-		__log_stdin | tee -a "${LOG}" > ${redirect}
+		if [[ -n "${prefix}" ]]; then
+			awk -v prefix="${prefix}" '{printf "%s: %s\n", prefix, $0}'
+		else
+			cat
+		fi
 	else
-		__log_args "$@" | tee -a "${LOG}" > ${redirect}
-	fi
-}
-
-log_setup() {
-	log "setup" "$@"
+		if [[ -n "${prefix}" ]]; then
+			echo "${prefix}: " "$@"
+		else
+			echo "$@"
+		fi
+	fi | tee -a "${LOG}" > ${redirect}
 }
 
 log_host() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:host" "$@"
+	LOG_PREFIX=host log "$@"
 }
 
 log_guest() {
-	local testname=$1
-
-	shift
-	log "test:${testname}:guest" "$@"
+	LOG_PREFIX=guest log "$@"
 }
 
 test_vm_server_host_client() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${TEST_GUEST_PORT}" \
 		--peer-cid=2 \
-		2>&1 | log_guest "${testname}" &
+		2>&1 | log_guest &
 
 	vm_wait_for_listener "${TEST_GUEST_PORT}"
 
@@ -332,18 +323,17 @@ test_vm_server_host_client() {
 		--mode=client \
 		--control-host=127.0.0.1 \
 		--peer-cid="${VSOCK_CID}" \
-		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host "${testname}"
+		--control-port="${TEST_HOST_PORT}" 2>&1 | log_host
 
 	return $?
 }
 
 test_vm_client_host_server() {
-	local testname="${FUNCNAME[0]#test_}"
 
 	${VSOCK_TEST} \
 		--mode "server" \
 		--control-port "${TEST_HOST_PORT_LISTENER}" \
-		--peer-cid "${VSOCK_CID}" 2>&1 | log_host "${testname}" &
+		--peer-cid "${VSOCK_CID}" 2>&1 | log_host &
 
 	host_wait_for_listener
 
@@ -351,19 +341,18 @@ test_vm_client_host_server() {
 		--mode=client \
 		--control-host=10.0.2.2 \
 		--peer-cid=2 \
-		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest "${testname}"
+		--control-port="${TEST_HOST_PORT_LISTENER}" 2>&1 | log_guest
 
 	return $?
 }
 
 test_vm_loopback() {
-	local testname="${FUNCNAME[0]#test_}"
 	local port=60000 # non-forwarded local port
 
 	vm_ssh -- "${VSOCK_TEST}" \
 		--mode=server \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}" &
+		--peer-cid=1 2>&1 | log_guest &
 
 	vm_wait_for_listener "${port}"
 
@@ -371,7 +360,7 @@ test_vm_loopback() {
 		--mode=client \
 		--control-host="127.0.0.1" \
 		--control-port="${port}" \
-		--peer-cid=1 2>&1 | log_guest "${testname}"
+		--peer-cid=1 2>&1 | log_guest
 
 	return $?
 }
@@ -399,25 +388,25 @@ run_test() {
 
 	host_oops_cnt_after=$(dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${host_oops_cnt_after} -gt ${host_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on host" | log_host "${name}"
+		echo "FAIL: kernel oops detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on host" | log_host "${name}"
+		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
-		echo "FAIL: kernel oops detected on vm" | log_host "${name}"
+		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
 	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
-		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
+		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
@@ -452,10 +441,10 @@ handle_build
 
 echo "1..${#ARGS[@]}"
 
-log_setup "Booting up VM"
+log_host "Booting up VM"
 vm_start
 vm_wait_for_ssh
-log_setup "VM booted up"
+log_host "VM booted up"
 
 cnt_pass=0
 cnt_fail=0

-- 
2.47.3


