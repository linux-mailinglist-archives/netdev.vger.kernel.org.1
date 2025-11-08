Return-Path: <netdev+bounces-236997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48920C42F50
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A023B149D
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7C241673;
	Sat,  8 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKCOaJAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01826229B2E
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617718; cv=none; b=BnbqGS5hjwYRlf4bTFFFcaw6LuA/X4nROisaMJdf0umP/x3Rwvd0yUm1iMEPpaHvIvY7oXPiy1JwyPyhIZ4IkHbMDrikmODHaVwjsCcdNJ0FDHMPAIem0PNhA2H6kCElmWR1F3tuWs87Blad6rza7DOJDU1Y/Fw0UbOurOQiB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617718; c=relaxed/simple;
	bh=/dJQ/7I3OQhP+yWr0bsAI2cwjILzUHF+RHQ7fT+3XdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxFgPIECD+tHUyyS5m26vpTFwuKNuV+hzEp7lK9ZRQBKkuRpbR+NuIz15s59yE4g8kto5f//muwTLUN9gsocJMTOGAM1sfUv/OxF9G+H6rnKpu9UDqIKrZEbry8ltjsBTu5/LS7mwrsLrejH0oq9e/HhCfwuotSAfFTMO/Us/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKCOaJAb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-794e300e20dso1136518b3a.1
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617715; x=1763222515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4Urawj2//n5SfHIkQ4jAkZb6mHY043f4lqvaETaRcY=;
        b=iKCOaJAbaWz3jjJ+vz/274KDozpscf4nxIsqSI14wQ8prQ9cbrvrx+WGq39caurwmq
         vML4wcdp8EPkEG50k2zqdWEg85mMfCk0MTG0ZEwa6fu7g4ElSSFS1LMB89AfM+nZQmIt
         kJSmn8jl7rCzjaRBTBB9zlW6H5Oz0kGdArc3mk7OyeY3dBBMowxPMZ6vfjMwAq7n3L3t
         Yalzv8KMiiNZlDz3+maQStZR3YQhrvC6FHIUBd7yVqy5USFFaoAT1sMk1XsCoPAlICXj
         V08JlT5mmk9lyoEC9F42fnXipWW/KpUwY6mnV8N3SWPxjxd2CBzf9D6m5+9m7KPab/b4
         XhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617715; x=1763222515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4Urawj2//n5SfHIkQ4jAkZb6mHY043f4lqvaETaRcY=;
        b=XKaCN/vwWS78cec9Qx9D1lShl3x83NfpetypHx1hEBN01WDv3/CxbF78mCVuzsMtEU
         JBYpi4I6YWwZg5MKu+wMwcTqdvTHeCq+X3X5LmLVKDnQA6bEOoh5FAwUgI2+MzrmM9B6
         LWQIefnNgQef8zPIR2LfgTKpmZkcC8a/8zqaQKt9bkqw3nZzBg3nQQGQnl61+s/iFC1V
         Smir4gc2e3+GMDpr8XCvLk+K1q9ODFj8DAo38FvxFWLagG6B1XSZXhZZC/dnUdLFChjj
         Mo9p6YPR3mjGzgk/j2RqrN9DsmwCBM/66XTSTZ7xc3QZKzz1TOMTAPTNo60wktO220O9
         W7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeBppTrWbA+BJRqHarE87bQ1W8DSlBpdZyKmFMbwSgXbGylU4M0DZQlOi9IwhkARuiPZn1Wb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+MRXNEZeVPrhcJ9DodcfVSuK/qG6k+/qpfbk/x8w1Q83XSsL
	uI7RhB5xgUTHg8fC/JIRl1l2QRZXguqEAUceQ1zNuZdJvfvL8ZiPlH/g
X-Gm-Gg: ASbGncuGyk1raJ0oS1qRcPUdTSbunvKgScun4DEl54DfN+MnplaKPNMYL0vrOajXSXg
	7gv4tFZcElc9MBKuUdJdQoSbMz2qCelPOG7XbTYOwpGQpPJ6ZQfEMU6dB9UA5hZJh2HS8o2c3n8
	FtL88rI33t3hJb3ULPI93ypVIYzx59BkHb7XKqK/JVtR8El31ATJ0IEifxXtAHqD5m0IB3yRTDb
	29PHNyU2k5+R9sEEUHa1A1AWCqNd1WgOGhQd0VF+V/1PqYRu3/zbAKmxFeHVgJGdu+cBeJM/ME7
	caWRXnv9Zk34iivCwS9YWmJpT36AgOxWyI36X/Joivo0toImdgHTfGHvfszTre3FfP7CEQMTvqz
	qCQ+aMohqhzr5raJcIvBrwwMvWmqUDGnfGvjn9qt/lhSbbumv6d/6Vjv5a6WT8vEgKbJrdZD9s3
	G9MezZ1Gx+
X-Google-Smtp-Source: AGHT+IHjnaq10HvTrkjlIQLeEstGDQ+eD2zoexE9N95h5RNKlq4D/zv3drStG+s5wuj4edCRNY4UGg==
X-Received: by 2002:a17:903:2cc:b0:295:82d0:9baa with SMTP id d9443c01a7336-297e1e34090mr44306595ad.17.1762617714935;
        Sat, 08 Nov 2025 08:01:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2964f2a9716sm95897525ad.0.2025.11.08.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:54 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:55 -0800
Subject: [PATCH net-next v4 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-4-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Change QEMU to use generated pidfile names instead of just a single
globally-defined pidfile. This allows multiple QEMU instances to
co-exist with different pidfiles. This is required for future tests that
use multiple VMs to check for CID collissions.

Additionally, this also places the burden of killing the QEMU process
and cleaning up the pidfile on the caller of vm_start(). To help with
this, a function terminate_pidfiles() is introduced that callers use to
perform the cleanup. The terminate_pidfiles() function supports multiple
pidfile removals because future patches will need to process two
pidfiles at a time.

Change QEMU_OPTS to be initialized inside the vm_start(). This allows
the generated pidfile to be passed to the string assignment, and
prepares for future vm-specific options as well (e.g., cid).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- use terminate_pidfiles() in cleanup (Simon)
- use associative array for PIDFILES and remove pidfiles as they are
  terminated (Simon)

Changes in v3:
- do not add unneeded -u to mktemp (Stefano)
- quote $PIDFILE_TEMPLATE (Stefano)
- do not remove cleanup(). Though it is expected that vm_start() does
  not exit(2) and its caller is responsible for pidfile cleanup,
  retaining cleanup() on EXIT is worth keeping as ill-timed kill signals
  (i.e., during manual runs) may leak those files.
- add create_pidfile() function to generate pidfile and automatically
  add it to array for cleanup() to terminate and remove later.

Changes in v2:
- mention QEMU_OPTS changes in commit message (Simon)
---
 tools/testing/selftests/vsock/vmtest.sh | 62 +++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 3bccd9b84e4a..13b685280a67 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,8 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
+declare -A PIDFILES
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +34,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
 # add the kernel cmdline options that virtme-init uses to setup the interface.
 readonly QEMU_TEST_PORT_FWD="hostfwd=tcp::${TEST_HOST_PORT}-:${TEST_GUEST_PORT}"
 readonly QEMU_SSH_PORT_FWD="hostfwd=tcp::${SSH_HOST_PORT}-:${SSH_GUEST_PORT}"
-readonly QEMU_OPTS="\
-	 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
-	 -device virtio-net-pci,netdev=n0 \
-	 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
-	 --pidfile ${QEMU_PIDFILE} \
-"
 readonly KERNEL_CMDLINE="\
 	virtme.dhcp net.ifnames=0 biosdevname=0 \
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
@@ -90,15 +85,7 @@ vm_ssh() {
 }
 
 cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
-
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
+	terminate_pidfiles "${!PIDFILES[@]}"
 }
 
 check_args() {
@@ -188,10 +175,37 @@ handle_build() {
 	popd &>/dev/null
 }
 
+create_pidfile() {
+	local pidfile
+
+	pidfile=$(mktemp "${PIDFILE_TEMPLATE}")
+	PIDFILES["${pidfile}"]=1
+
+	echo "${pidfile}"
+}
+
+terminate_pidfiles() {
+	local pidfile
+
+	for pidfile in "$@"; do
+		if [[ -s "${pidfile}" ]]; then
+			pkill -SIGTERM -F "${pidfile}" > /dev/null 2>&1
+		fi
+
+		if [[ -e "${pidfile}" ]]; then
+			rm -f "${pidfile}"
+		fi
+
+		unset "PIDFILES[${pidfile}]"
+	done
+}
+
 vm_start() {
+	local pidfile=$1
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
+	local qemu_opts=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -201,6 +215,13 @@ vm_start() {
 		logfile=/dev/stdout
 	fi
 
+	qemu_opts="\
+		 -netdev user,id=n0,${QEMU_TEST_PORT_FWD},${QEMU_SSH_PORT_FWD} \
+		 -device virtio-net-pci,netdev=n0 \
+		 -device vhost-vsock-pci,guest-cid=${VSOCK_CID} \
+		--pidfile ${pidfile}
+	"
+
 	if [[ "${BUILD}" -eq 1 ]]; then
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
@@ -209,14 +230,14 @@ vm_start() {
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
-		--qemu-opts="${QEMU_OPTS}" \
+		--qemu-opts="${qemu_opts}" \
 		--qemu="${qemu}" \
 		--user root \
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
 	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${QEMU_PIDFILE}"' ]]; do sleep 1; done; exit 0'; then
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
 		die "failed to boot VM"
 	fi
 }
@@ -499,7 +520,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(create_pidfile)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -523,6 +545,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


