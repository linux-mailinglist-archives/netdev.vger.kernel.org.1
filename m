Return-Path: <netdev+bounces-235607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23865C33441
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F4DF4EEA99
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385F4346E5B;
	Tue,  4 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYMDxhOF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F5336EC8
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295957; cv=none; b=ZRay0PYhtrenAoLiY23BoNPYzhhy+PLQcGqOkE+RUXlkXX6JG3SH5BUZs390vOa0x+tgADnxHp1katzNAnfMztGuWtyY2LW3KPXEesLtXYBMTJ5e5KQpp2HiJdpsQRJ6z60YMbeJHj9H7xjsAMa1sNXSmP61kFR51bhGOpo/n5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295957; c=relaxed/simple;
	bh=qaM/YycVu4RVy+bT1TrwTWoAn6/Kw7T+6Ey2I1qpe/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSdbinxjRYdUF2cbp+VAOUK+hGBBwv97xk3Emc/vWZyhOkaxrNDsatW1uYKi4huCvzHx6GSqjMFlqyIcm3yBd5+kLrTzbINcI8PTzBVe/+L54torsi2CxSRAz37BSEIHgQMpYmI3kBBhOHzxYbppS9UvRAFQbrtRgeBXISqIco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYMDxhOF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29524c38f4fso57772055ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295953; x=1762900753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPomieP6y6cKKzxkcHQHYffWFCMJSj6awEpxYtimWiU=;
        b=RYMDxhOFseWUuK4ZoO6Q4IpPqgVPdE2SlsRFQpakBaVDpcGimutcZHApQ0z4phW8ea
         C4H6iQkYEwCdgGeED0o7m8tEL5AI9FoS6ReiQ/rjAcsmcdD61RsZppNP4HqNxQxP+cYS
         TUQzcdwqSiEpSMbIcICfT3tSdzwcTYIhIJB9N6LNbWXCnj2krvY5nNyw+6XgctPc8umM
         kNr6oR5THiOQanRxh7rcPfDFbGNmPdKP3N1dVmH05G4w6bZUJ5YJAj+VJK2q3OdMnWJC
         B8dozfD9+/qOZKy9ZrRF880mJuJ3rXOLi+QE110AxPo6RrbUEFc9tTzUM+Uk8cpYIQ9w
         un9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295953; x=1762900753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPomieP6y6cKKzxkcHQHYffWFCMJSj6awEpxYtimWiU=;
        b=am8+1Wf129ts0UyiHSAyWuYC9SI5DeKDvrYkEZnvM+4iWN0Pt9fUlmiGat2OQhvDt2
         Ll6RcIya5UvGsaTi2HFbYmhuow1DUPcT/ACX43raRwbUxKiTJHJm8+usWdqeUHlyRh8N
         Vm/c2xTYRJVSvVjZE6rWxiwoldRgpQXrU3TMV3O0p0lKkZxbRf8mCorUT9cGXpeso5yM
         QXxl9Zny5TT5jJOareIAmMc4Iqpa/NBs9MofaMGbWw+WBca4DuladAFBH4cmhE4/cPAn
         vHQrUhstDW/jLubPkiDJo7cyGvIvzULYbjquWPWVcPQbwUgzYDbMqthK0cV22ynPm4Z3
         To5g==
X-Forwarded-Encrypted: i=1; AJvYcCWJkSH1qZuqRwiXCCWNk7bMVS5S7Xa+rgqA4xf8pXcViZZAMP3W2dw5WuWGnUY7pX9T/5voA0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJ0WD4ocYzbem0tpIJBUzV2nwoh/oCrixvCt5sYhggas9jzXI
	hQkMK0I4MscrYGDT+8c45x1hecYL4fRqxZHsX6XlnlDHBKNhk6wAxxGZ
X-Gm-Gg: ASbGncsnkE3v2sVUOsCcEs4mu5waCGY+Sb/2VtsCjzOnD/pL/pzt9kN2hrw72gT3LIO
	vec9taAggVehOshleYLcQExjJd5xfdjPB3GtLynG8WuOBmcY/870hwaxLhEWTCYFdtoGtuCY8Tq
	AVVyTg4Q8qT/c0rcoSpNfzeJ4JjV9qY9y/DMbsewaMKRGOMRkg15r0y267Kb+Vhcio0OeK/Frdk
	kKMA6r60TZIdDJ2qVPyAtahBTiAgWsZidFc9HN3PE6rX1roE/4I+j378ouE9yig8byjiZgWnF0j
	t/U9psJQS8v7H0IvrqXR73ZVfgTi/jJOdn3idFEfK6wfsDJwYWAwrcUxn8PbHxY16TiiLFjAcbM
	uNYhXm6175K/Cr/eelydnVWrQwfbDNGQ48Jl4DTIiGNDN1a+pcw708GllblFG2mKJBRoxBFZlXQ
	==
X-Google-Smtp-Source: AGHT+IHD3n38ktdMLAtQTdG9dlRMpp5+qaB/a5F/5Hc82s9u1whde0uAmROI8lO0PC79msxpg9QR4Q==
X-Received: by 2002:a17:903:19e4:b0:290:cd9c:1229 with SMTP id d9443c01a7336-2962ad1f5d4mr15355965ad.19.1762295952976;
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm38421705ad.31.2025.11.04.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:12 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:54 -0800
Subject: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

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

Change QEMU_OPTS to be initialized inside the vm_start(). This allows the
generated pidfile to passed to the string assignment, and prepares for
future vm-specific options as well (e.g., cid).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- mention QEMU_OPTS changes in commit message (Simon)
---
 tools/testing/selftests/vsock/vmtest.sh | 53 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 03dc4717ac3b..5637c98d5fe8 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -23,7 +23,7 @@ readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
 readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
-readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
+readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
 # control port forwarded for vsock_test.  Because virtme-ng doesn't support
@@ -33,12 +33,6 @@ readonly QEMU_PIDFILE=$(mktemp /tmp/qemu_vsock_vmtest_XXXX.pid)
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
@@ -89,17 +83,6 @@ vm_ssh() {
 	return $?
 }
 
-cleanup() {
-	if [[ -s "${QEMU_PIDFILE}" ]]; then
-		pkill -SIGTERM -F "${QEMU_PIDFILE}" > /dev/null 2>&1
-	fi
-
-	# If failure occurred during or before qemu start up, then we need
-	# to clean this up ourselves.
-	if [[ -e "${QEMU_PIDFILE}" ]]; then
-		rm "${QEMU_PIDFILE}"
-	fi
-}
 
 check_args() {
 	local found
@@ -188,10 +171,26 @@ handle_build() {
 	popd &>/dev/null
 }
 
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
@@ -201,6 +200,13 @@ vm_start() {
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
@@ -209,14 +215,14 @@ vm_start() {
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
@@ -480,8 +486,6 @@ do
 done
 shift $((OPTIND-1))
 
-trap cleanup EXIT
-
 if [[ ${#} -eq 0 ]]; then
 	ARGS=("${TEST_NAMES[@]}")
 else
@@ -496,7 +500,8 @@ handle_build
 echo "1..${#ARGS[@]}"
 
 log_host "Booting up VM"
-vm_start
+pidfile="$(mktemp -u $PIDFILE_TEMPLATE)"
+vm_start "${pidfile}"
 vm_wait_for_ssh
 log_host "VM booted up"
 
@@ -520,6 +525,8 @@ for arg in "${ARGS[@]}"; do
 	cnt_total=$(( cnt_total + 1 ))
 done
 
+terminate_pidfiles "${pidfile}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


