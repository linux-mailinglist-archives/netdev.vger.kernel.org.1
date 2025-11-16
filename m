Return-Path: <netdev+bounces-238953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA3C61926
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 63446291E0
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20A3101AD;
	Sun, 16 Nov 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqznU/vH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F830F959
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313261; cv=none; b=B9Ee4mfhDPaaNu9nOZRnQS5OulSwf0v+XiIylXs7oH3YeO7cGBlx3+9ovUtltE71NlSwLetXZT8V/Owpvtk5b8OzaX7uM7q1mjav81Z7QL5Fun43rJGO7moIAJZcba7B5jA7sfcBqLLcLnnO0FFjb7nP7D6AGigXrQnkSNW1TFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313261; c=relaxed/simple;
	bh=cSkbpzOScZDOIzNwW1Ore/elvihVGtq9EEd1znjD/vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtEKC89FHvQGHL4so0JGe0LhuzXuteT5AB02A+f/qlnZpIcnlCeeMPvrvA4d/xeLWiUkp8i3RFqhyV5rm0NrDG+V3TXl09b2R2+ZFiAuXBQJf3sf5R+EvQkisqXVJhhCcSA7zwpb88+Cziu0eBS0vAfID0bIRy3mGKq5THj4XUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqznU/vH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4774f41628bso23730935e9.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313257; x=1763918057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JYJQBu9iv6dVjvkSHn+sjpe3Hje65AyykqNzlW6M0I=;
        b=FqznU/vHNNCzDCRMSjJd4kMvdv2+sV74Hx/l0x5CjAy/XixrbYcGakKendQyIvcSn/
         CHaKZ9oQebLueb2wnD/KOXeL+W84yoKwM2GEUWSmffAjsSf3YE14gucZ1yENCuWGYLbf
         5t4gseuIzXMvnO/JFtTzmJHu6nU7DEvHrnJ5wtOgHNY7pSNXnFpw68U7V0IbfA0JqtG2
         nCcSswOr9/tWmQ8M3lWZHhZ0DXReERTY+7vtySbdQP7BWjYJrCzdjE1MRjTuSQyP2REa
         EB0DBFqKoLlNJxGF3nPWZ1yjUN3UhSf/y11m81rh20KkK5vta/7l45BsA22SpxsPuKjX
         boPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313257; x=1763918057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JYJQBu9iv6dVjvkSHn+sjpe3Hje65AyykqNzlW6M0I=;
        b=cjFE+obscuWSev7cmxtCqJY0dG4bxluzrADCHmym4tc4YY4jdD+AVgcv9ai7/znDP2
         U8biupojtXvO6j3sVE+XgxpVm7/uBGx3WT4qRfn17L/Ze8cOXbmrC9b2AAjtZKRBzP7l
         Hw7sMAnoITU4tMavo3XBzl8XvpkGekSJrgUljnoQzFRvoyDHIJLRydqqvGE7paZaKDKo
         1XvQewGC8ybI0xed6qUVRMU10maV88HCs9w1+8cMHCJcYOcWcyrPlMhADvF9n+fZ99EF
         RjA3n5Xfh49GAtitf5ymz12LKwX1imzL67bJWNWFIVv+V4xYCluvKUYQA9A/IDP50pAy
         eGGA==
X-Gm-Message-State: AOJu0YzaK9aqUKQjkhT+HORGjaqQZwmek/3XnqVZVo8u9bWA3OP/Cwyn
	x37zidNfTtP6D3XI9B4535ftWG9ABpc0XRrpBVMGk3NBS3S/mR3X510n
X-Gm-Gg: ASbGncstS4W2VhFMkO378nVsUDSw3T2IxalAXtDzpc2ZMFKuPADpf9GbAw4K+kzZXcb
	2i3gsEbVYNJHlngt+jlHIg09npf4UMD/4E0a/djdovrZs9ErPhFdRWHhYPCLtNaNbEKbllRwm7W
	7VjbMnQxD9eC01IVwyvLNZYoj/YqE95Eli493VTqJoEU4QcoFnYE5UBsoaR2Rdd8sQXP2+QGpdM
	Q0rzARpRDAlbDaoWFJ7crg07Foe6HkghvNePvRUaYmvQKBiTkDpTRWj+Q4JUbWCd5mrG6jngSO3
	LBvP9jBaFWhyR22mul58b9/Zl4fyMxcNRmA3J+tutUQ2NilWyYkJ8zGy11yOv9PvEWR4uI7gHx6
	3QT5lBL4zHr4d5EjQ7xI+EDxSj0TQUL9vc2/Rc+BhJ6bUMzSXzVJLabkac66MpphtNDBZou7E/n
	cST4ezjT4GvYOaxw5Ykhjc5sbekw==
X-Google-Smtp-Source: AGHT+IHCYuk5mG7mCpI3ofpnHFX152jLfPh0VKK8Yl+QsCayK9hrd3d7t05L3SHcQkISCGCM1B4z6w==
X-Received: by 2002:a05:600c:a406:b0:477:75b4:d2d1 with SMTP id 5b1f17b1804b1-4778bd13e4amr98405915e9.15.1763313257465;
        Sun, 16 Nov 2025 09:14:17 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:16 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 16 Nov 2025 17:14:05 +0000
Subject: [PATCH net-next v4 5/5] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-netcons-retrigger-v4-5-5290b5f140c2@gmail.com>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
In-Reply-To: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=6495;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=cSkbpzOScZDOIzNwW1Ore/elvihVGtq9EEd1znjD/vg=;
 b=MlEjVU6NAqK/Eg10qo/ju+anbefWk7ZE96KoLgXDvkn8bCFTefxY4eVTNz3MymmW6l0qa86X5
 yNBUcMiIHpuAfZAdjpOXhBdWAEHBKoe7yMyrh2X3c/I3lQXFgwmLE/z
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Introduce a new netconsole selftest to validate that netconsole is able
to resume a deactivated target when the low level interface comes back.

The test setups the network using netdevsim, creates a netconsole target
and then remove/add netdevsim in order to bring the same interfaces
back. Afterwards, the test validates that the target works as expected.

Targets are created via cmdline parameters to the module to ensure that
we are able to resume targets that were bound by mac and interface name.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 35 ++++++--
 .../selftests/drivers/net/netcons_resume.sh        | 97 ++++++++++++++++++++++
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 33f4816216ec..7dc9e5b23d5b 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_resume.sh \
 	netcons_sysdata.sh \
 	netcons_torture.sh \
 	netpoll_basic.py \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 87f89fd92f8c..6157db660067 100644
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
+		local ENABLED=1
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
index 000000000000..8f7f07779c41
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
+	trap - EXIT
+
+	echo "${BINDMODE} : Test passed" >&2
+done
+
+exit "${ksft_pass}"

-- 
2.51.2


