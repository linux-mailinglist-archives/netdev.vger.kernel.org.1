Return-Path: <netdev+bounces-236571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B444C3E095
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92D1C4EA443
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19062F8BC0;
	Fri,  7 Nov 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hciGptYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA572F5A3B
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476601; cv=none; b=alyB6UuF9YgimQCxXtzT98Wactn3VjUrlG8UOSzvPGgx+g12uew5xVnCJHqFJYPaJFimldFw1d68ck2pbAO+0NEr4jKb/rClsISNL/gLaNA8V2cuMhpCZdy8wyG/7jCK+51gn7u+HQ2ohQLP8QAzmPHudWpstVLOffoJp20h/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476601; c=relaxed/simple;
	bh=gWRJPR7nlbp70//O2u5KWOT+hLm0yZoG3tHFlE9gXpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQB5s1u+5FhzUdJYqnUwvDZxoVOZKXhfatbEtipNRHuRADEf32/E81+DbGNDm1sLR7ThNSkKg+CNheKDDP1Qke530+Xcx9Er6T7d+iNQk6WOznCJidkuOeCl4BkFTKfgK9MieMQhWY1HzFfNdrsP4/cvm9Yc8DbD//MFBGHO58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hciGptYz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7af603c06easo250458b3a.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476599; x=1763081399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCEmvng1yWc0PKZqREcwFmN4dvc5QvU4pfz1PlM1Jyo=;
        b=hciGptYz88KwAYjw8CpExmWVSm+7TcRbsHwBsZcdqbDf6puxJtDfxXclGpsec+mjLP
         vSFCb8zu8T+wy2kprVHSqe4aMj0sueiArNhzSguBrHebnxsVyOrjkK1suYeLnyhyy6C5
         cx8Ty/LiBqWxe1xuvlW1QCgw0r1VC7tgbskNKOFhm6mS59eSffO502iCf4YvSle6ns9/
         jk+XbcLNWR7JTtDhusjku7BFgPTkcLCTTBTxfXq6aWLvo71gGshUD2KXnPyqTKweBdsn
         5G9vsmHoAcEvcHgJKYDayMjs46o+E+oN4ZTtX6veRcwVP3VeL5H8jX3u/q0NdvQDZm01
         wvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476599; x=1763081399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCEmvng1yWc0PKZqREcwFmN4dvc5QvU4pfz1PlM1Jyo=;
        b=U9dUypg7GFOJf9EmXbIveY317JgvT6yi2Zzupoe1ZEmq+SPw1hlSUiI4j0bvZO4fBT
         F6PjmuqD6S55F/QC8sxX2STnviwwrNyRZq0JVWX9AqdN64F9i184RPqF95BSWdlb1GeW
         d3ccH7LD7C8mTUais2bPkmxMVyYQncCPB7BMovKEUPSaMfH8caY12W3kpybSrie5dyXv
         2kPC8EpD3AGkpMWSCAgrXprvYFE1A950//V2jmzub+wBy58BxhGGdQlDFXGkIpgb43qI
         UYsLtPZo8LFgjT1hqTFPYsRvAu7HlR4DpbtKg2cFBvrChYJR/roKpjcw8kdKuYGWJQxI
         RkVA==
X-Forwarded-Encrypted: i=1; AJvYcCW5DuiNWAsmEKwq5P3i5QjOXOkxw6NwRB2PPCCTtbgckkjzdKTK1qdOs2GSWqP4znxvR/seGOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXs/repKfbVBAZ0OTraddrfyl82f/ZlOf16T7p/UBSq9NYzdw
	OC5idDP74hTz6xpg4ECI3L1Z5K8eo6iK9tgPv+3RsgvG2KuIOEui3HZF3MhsYQ==
X-Gm-Gg: ASbGnctlwKDwr1JbZVNNLiDvWjkA6XiOabqAlPW16d8xx9x6fK4WO0N84iNyrPyOPOd
	Me1mBI16Xsffld1tQdd/RBKHl5Rzv5vcrgumSJu8LG9e4MiYSznHJ/17JrQDa4VvZoCnGlrxMIF
	bRFUn/devP/6IVSJ+riJ67mSV5kd3mp9WN/w1cxmk2WOVNQMjKrw5/8P748QPpBb/1yuYgrJsfv
	520Ce0GkfTG54BRNVbCMd4ocTvNCLQpOcp9pj8T50tly6OswjC/uLtgAgKD3OcvOpUWvwZoiDqw
	VxbDuRu/UnXCFwGRWNPeiXRzH0JBIafMwdl5kkfhdPDRCjL4831hRx+Rm/4VmEmefC69Km99ELR
	voEzN/1OEkzdoRy5PbXPAhx1D8/xrObUyXdhkLSy0DFOY9jbvs8MjBRtEww2swinqAegtgTg15l
	QS3C80/nU=
X-Google-Smtp-Source: AGHT+IFI0mcKzM1/Q8A1uRGQq4SFewTSb0w9plBTnCGZlfhkXZ/d0eC96TItpJKFxk7QSLfYEMblUQ==
X-Received: by 2002:aa7:93c1:0:b0:7a2:6adc:cbe8 with SMTP id d2e1a72fcca58-7af72464564mr5156477b3a.16.1762476598594;
        Thu, 06 Nov 2025 16:49:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e15sm868507b3a.14.2025.11.06.16.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 06 Nov 2025 16:49:51 -0800
Subject: [PATCH net-next v3 07/11] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-7-519372e8a07b@meta.com>
References: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
In-Reply-To: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- increment cnt_total directly (no intermediary var) (Stefano)
- pass arg to check_result() from caller, dont incidentally rely on
  global (Stefano)
- use new create_pidfile() introduce in v3 of earlier patch
- continue with more disciplined variable quoting style
---
 tools/testing/selftests/vsock/vmtest.sh | 95 +++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 557f9a99a306..05cf370a3db4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -46,6 +46,8 @@ readonly TEST_DESCS=(
 	"Run vsock_test using the loopback transport in the VM."
 )
 
+readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+
 VERBOSE=0
 
 usage() {
@@ -79,6 +81,28 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc arg
+
+	rc=$1
+	arg=$2
+
+	cnt_total=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -450,7 +474,44 @@ test_vm_loopback() {
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
@@ -526,33 +587,21 @@ handle_build
 
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
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
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


