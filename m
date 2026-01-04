Return-Path: <netdev+bounces-246802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A301DCF135C
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFF2030056DC
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C330FF27;
	Sun,  4 Jan 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl/OU6jS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4B2D738F
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552138; cv=none; b=qr0P0D59gqgPC606U5xBzMLMmhSNUukYP/yI3BM/ixYttrPF53EXk7l7UumJjTYvpqy4m94WNtbsOZzixTMG3G6c/JUdWVHGejh99bLPgrfSrxoJQg541S+iBiGB89FYdfT1KvejUlLI9b4ZmO6sFH8tTR001NWkZipOm8uX8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552138; c=relaxed/simple;
	bh=KSC8Nj3DiK31fDmZ4/PzcbAzUlQgw1PwPAvmb/6l8Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATF0a4aKc0Y7cJqtTg2vARs7FnVGmDL5sMidg/gc/zkItEIhKirzGgoOpQAxgKha03sQm1KMTljDHjiEUspdNoBsNw0eHVlMsRFyVSv4ZWJiwIPHx06MxFqqMJwc3TkN8E6dl9N6pZ1qniyvT7ehl4tEyTWXS4Lm1sdq76VY9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl/OU6jS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0bb2f093aso134712175ad.3
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552134; x=1768156934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RFEABt6Iiak9nuJmj7Wxw5Z8I9sCXd9qm2gCXqcVTA=;
        b=Pl/OU6jSJ/bs4oHkZTu9BHcp1V02qksP1a+IAAjFwv25UZ/xlTvhV/kPRobqW64z0y
         h+nVNck7HBsRNHhPPf1Mp8IN+oXlswndWauKRgipWAYRi/BCWvMpTiEv8YpAcnWu0qMr
         opJDVHwDcBVO0lhMz3HRwF+vIwIoLvaZabZgJxDZ0k7Z8TOOXBb7UfwR8js6ueCddRfw
         +dHrpoZwFDF2qi0qtT0JPrq5qwPOEKX9BKYb3SeZFBaTnrWwxlZzfy2kmrnPs1IiAvN4
         LfsXtRXst7i9FrPRJPdZaLLbrKbFv9GF02KrUJUoCfgjcAIfBgGvCQct5Ro6z67ym44h
         UpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552134; x=1768156934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2RFEABt6Iiak9nuJmj7Wxw5Z8I9sCXd9qm2gCXqcVTA=;
        b=H1TUyspEOMo1/U7oWxM5q7uDd7qoPSiTGBUGbvfT34Y2aK9IZrhUfpb5avzPtJlUTA
         wcPA3BGIi7XygrXJDY7y1QyEgWuJzCtd+eXTKlWcdBGZU0r0PQCQXoz9/8aJpV07mqUV
         z4RnCvkLJ7VeZc44yTH8gTUcdVfDPc7jqDkki6r1IWpo6DEMNOE7UD+4CgismPBKtpGF
         2z7O0IHSZIIHtCVhKHZPLcWle3wKqvnqB7Id4lHqIIfgqxfEoXXZGTuV8LRm9/pBNFY1
         YA2PKfml+rSkUMmp2BoQtXvX4q9nyPsEm8I7TONE7meDOLIGDOa/iAofksW9N6pcRMds
         KiPw==
X-Gm-Message-State: AOJu0Yx68rVR9Y7JigBf+xMepiW/EmzCz2ONObqAnR818g1Kx6Zb6Mq6
	m0v01fSO8TXjZUkp/ZE8kWy8bW6ROIVuphhELogEecJ0lXU2PoIM1pzb
X-Gm-Gg: AY/fxX4yG+1ZjOFiJSm40aHIcEyB/gYKVn41e1RWzqm6hf848Q7zcnS/fYIbThSeXc+
	236BDpN0L162PUALMvloyDiq2ZRrAjcI1BZk5oG4aJjy0cDN60FM7PPrUlkcPb5vsP6LV5Dzrl/
	cHiMbSX4c6NjQ3BpJEzYcVWf+te2k3Q8j9/rfYxriQcSA3E3/FmP8RPUsZKtJgNdUjG9DONJDxQ
	rNEVjQDnnwJmoNzJZrv6aCogdpGiGsTwpuZFH24TXt5YgJwQdNWSYBcO93QG8MwAoNRBXjeofDr
	WsDri8YK17LzyNEf90xl0P5/5lovlud20cXXSAn0/zAkSeuv797RsgbjKt0hLEeCGzCZYxisFib
	CNtbA8CxXWfSsC2dVsaGB+jBlrL9fBRrJHFe2dIxmffi/GwjqsZfgS8pkFL/HBpuxSLL6oL97Gv
	g+wfpvaXmxktZ+P915
X-Google-Smtp-Source: AGHT+IFnwIpqXZbzNWeV+xcKxHrl4l/R98bpocjGoxRMFG3stXib8Diu/GTPyxwiD4FcLrZEpn6o6g==
X-Received: by 2002:a05:7022:670b:b0:11a:fec5:d005 with SMTP id a92af1059eb24-121721aab84mr42485113c88.10.1767552134246;
        Sun, 04 Jan 2026 10:42:14 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:42:13 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:16 +0000
Subject: [PATCH net-next v9 6/6] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-6-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=6537;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=KSC8Nj3DiK31fDmZ4/PzcbAzUlQgw1PwPAvmb/6l8Os=;
 b=PgSfxa9US0mdGHwEc+hU6mfJVmj91v5553z6D5A4D99LsDPMgmzV88AP3TyeZcM60Jy5nRZFu
 21PaxEXyvnjDX5xPuPeBGwpUak25DWSp/ZimN9zTFXjz+q26KEZQhdn
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Targets are created via cmdline parameters to the module to ensure that
we are able to resume targets that were bound by mac and interface name.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 35 ++++++--
 .../selftests/drivers/net/netcons_resume.sh        | 97 ++++++++++++++++++++++
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index f5c71d993750..3eba569b3366 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS := \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_resume.sh \
 	netcons_sysdata.sh \
 	netcons_torture.sh \
 	netpoll_basic.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index ae8abff4be40..b6093bcf2b06 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -203,19 +203,21 @@ function do_cleanup() {
 function cleanup_netcons() {
 	# delete netconsole dynamic reconfiguration
 	# do not fail if the target is already disabled
-	if [[ ! -d "${NETCONS_PATH}" ]]
+	local TARGET_PATH=${1:-${NETCONS_PATH}}
+
+	if [[ ! -d "${TARGET_PATH}" ]]
 	then
 		# in some cases this is called before netcons path is created
 		return
 	fi
-	if [[ $(cat "${NETCONS_PATH}"/enabled) != 0 ]]
+	if [[ $(cat "${TARGET_PATH}"/enabled) != 0 ]]
 	then
-		echo 0 > "${NETCONS_PATH}"/enabled || true
+		echo 0 > "${TARGET_PATH}"/enabled || true
 	fi
 	# Remove all the keys that got created during the selftest
-	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
+	find "${TARGET_PATH}/userdata/" -mindepth 1 -type d -delete
 	# Remove the configfs entry
-	rmdir "${NETCONS_PATH}"
+	rmdir "${TARGET_PATH}"
 }
 
 function cleanup() {
@@ -377,6 +379,29 @@ function check_netconsole_module() {
 	fi
 }
 
+function wait_target_state() {
+	local TARGET=${1}
+	local STATE=${2}
+	local TARGET_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
+	local ENABLED=0
+
+	if [ "${STATE}" == "enabled" ]
+	then
+		ENABLED=1
+	fi
+
+	if [ ! -d "$TARGET_PATH" ]; then
+		echo "FAIL: Target does not exist." >&2
+		exit "${ksft_fail}"
+	fi
+
+	local CHECK_CMD="grep \"$ENABLED\" \"$TARGET_PATH/enabled\""
+	slowwait 2 sh -c "test -n \"\$($CHECK_CMD)\"" || {
+		echo "FAIL: ${TARGET} is not ${STATE}." >&2
+		exit "${ksft_fail}"
+	}
+}
+
 # A wrapper to translate protocol version to udp version
 function wait_for_port() {
 	local NAMESPACE=${1}
diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
new file mode 100755
index 000000000000..383ad1149271
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,97 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test validates that netconsole is able to resume a target that was
+# deactivated when its interface was removed when the interface is brought
+# back up.
+#
+# The test configures a netconsole target and then removes netdevsim module to
+# cause the interface to disappear. Targets are configured via cmdline to ensure
+# targets bound by interface name and mac address can be resumed.
+# The test verifies that the target moved to disabled state before adding
+# netdevsim and the interface back.
+#
+# Finally, the test verifies that the target is re-enabled automatically and
+# the message is received on the destination interface.
+#
+# Author: Andre Carvalho <asantostc@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+modprobe netdevsim 2> /dev/null || true
+rmmod netconsole 2> /dev/null || true
+
+check_netconsole_module
+
+function cleanup() {
+	cleanup_netcons "${NETCONS_CONFIGFS}/cmdline0"
+	do_cleanup
+	rmmod netconsole
+}
+
+trap cleanup EXIT
+
+# Run the test twice, with different cmdline parameters
+for BINDMODE in "ifname" "mac"
+do
+	echo "Running with bind mode: ${BINDMODE}" >&2
+	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+	echo "6 5" > /proc/sys/kernel/printk
+
+	# Create one namespace and two interfaces
+	set_network
+
+	# Create the command line for netconsole, with the configuration from
+	# the function above
+	CMDLINE=$(create_cmdline_str "${BINDMODE}")
+
+	# The content of kmsg will be save to the following file
+	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
+
+	# Load the module, with the cmdline set
+	modprobe netconsole "${CMDLINE}"
+	# Expose cmdline target in configfs
+	mkdir "${NETCONS_CONFIGFS}/cmdline0"
+
+	# Target should be enabled
+	wait_target_state "cmdline0" "enabled"
+
+	# Remove low level module
+	rmmod netdevsim
+	# Target should be disabled
+	wait_target_state "cmdline0" "disabled"
+
+	# Add back low level module
+	modprobe netdevsim
+	# Recreate namespace and two interfaces
+	set_network
+	# Target should be enabled again
+	wait_target_state "cmdline0" "enabled"
+
+	# Listen for netconsole port inside the namespace and destination
+	# interface
+	listen_port_and_save_to "${OUTPUT_FILE}" &
+	# Wait for socat to start and listen to the port.
+	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
+	# Send the message
+	echo "${MSG}: ${TARGET}" > /dev/kmsg
+	# Wait until socat saves the file to disk
+	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
+	# Make sure the message was received in the dst part
+	# and exit
+	validate_msg "${OUTPUT_FILE}"
+
+	# kill socat in case it is still running
+	pkill_socat
+	# Cleanup & unload the module
+	cleanup
+
+	echo "${BINDMODE} : Test passed" >&2
+done
+
+trap - EXIT
+exit "${EXIT_STATUS}"

-- 
2.52.0


