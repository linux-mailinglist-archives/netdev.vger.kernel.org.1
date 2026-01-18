Return-Path: <netdev+bounces-250832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E304D3946E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E20E30704E2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCA293C42;
	Sun, 18 Jan 2026 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbzHdWjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BE32AAAA
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734061; cv=none; b=D/SXLFwW/SHS3RvWrfTn8RNGsYQZ/2HdkoH4NGXWI27lrVoeFZQ4822ePdmpytJWLF6/nb2tGl0VC64NRea3rq6htPzP/EEg2HEcPTwRgDlywL9/jYw1XVKpfmpUqKZKKaocA40OXt8ffHjPDOahDVPVW4J+XJjpIKJg75ogJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734061; c=relaxed/simple;
	bh=e+w0DAW9oXvqNZy9JiObhL7asMTKcY24W84QkRdGT9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4PAIvVO4c6Z8uDvnL1fORWTcHsDQpiJmXGgWDwMlyqo4FJk/z4AzHq4TNoxIXFiVlOLaztpLA8sDwiAr9g7VnLOOLGur3UIYi536g2i3zxpGeREi5OoxgZbEpjm9XeMcTN8cEidIUtwTZJtvbP13CVfCoyuLfuo3CPb7dmPXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbzHdWjc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2287961f8f.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734036; x=1769338836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0hfwQRUIahRpuglzDE/ef/thxNWT6Y5iS8nFpch8gc=;
        b=TbzHdWjc9ICyxcUzFeNcITNE8FqMOlXkUzbzMSKnntIs4sKF5FEqZ5uSnQ39cnJZZ2
         kSnJm0Og7A3Vbc+U0Xq3hGqYWDrbYZa/75QMCgsairb2wrbO0WbIuPGlXbLoQYjgFPRQ
         wrwQ7T95kP+ehtcjk4eqEW+kTletjdLL2ElEQNPHwb/M6nO3j8wXrYZkxqdt+ooyn3PI
         dDpdASxXw81xc9Mh7CO353BSyWcvcP7Q+3wq0kCtmoxhV9AFHGKdQ/IGszjLjUGjB/CL
         r0hB1x8OJHmOAWY2mYwkNr2DhfWYtQh36Ckx3jvvwCn+zgdQ+KAv827WMg8dVvG94mjL
         Jd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734036; x=1769338836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0hfwQRUIahRpuglzDE/ef/thxNWT6Y5iS8nFpch8gc=;
        b=Qs+1MHaJY+Z0Ke0nuW69p5d6tePWDbXVP7WLLEw5PKRZYVGCKkxn2FrVwQk1FOq4aq
         T5ZZyVFYTcmkq1zvZIuYvQwzNrU8oBq7rThXi4N73s4AI3Vp65EdlENXNeJM07m8tI/c
         B/DnE3lc2+Xm2wkSjR+qwp5239zed8vFsHZZTsCaRikX3YqrZuc9YAbxbQRE21dnVfTR
         ethNMKO3bulPVf2QhzxrQNOTZRoLY7Cm8WRkbaL3JCbw9yNYwqGchN4ZXS3Fg+26OBXw
         4EG8IT0TSi9oRDAdW8FluR4QDjZnUzML6VNBG4hFERCuOkmfer+ZEaiI6PvmZlnvcFKX
         3qYQ==
X-Gm-Message-State: AOJu0Ywg2ODUP6QfOn2Af7kYL/CNvQb92V0+Tc6nIuFGOzrXovkp8uoO
	ELy4jh81jvQ2hKWp8/OgXp2OhuyVQJ7kNnniDB1AiNa5UZ7g6nIT75Kb
X-Gm-Gg: AY/fxX7OzoJByrVwGYE+TPl3TdSln9BzIUP7kSnSx3YHnWDAP/h9m/NYNzuLZ1qxuzr
	0FGG4AZwmnaJQ723kFaMruT8UZfaL/H0/CuKFIzTy6MAFwlG7rHMTAh9YFbElBlKOA9+ySDbFDL
	L2O2XfPp6RDnnPPP4SrpkOCtxMfjNozfiTC3be3tE7oVizUuP3b9mFovyWiXe9wycdx3BAPi4Dx
	y7c6V20uHeP7CVaj6SAx5f+ry9s5QzpDVCUjsUqi12zb2ZcdK/H4hKu33D9OmTKsSXR0YyxNMLj
	HvkiDeNz2/rCz36avkcGMJ71qJsJKsGTkb835RGgYho7n70uNqXWfjdiG7QS/yl7U0HkAMK6prc
	NMVzpXEtgUpPTxn6Fr3xPy+j10ZoFcg6H57nWrM0ktdyaf4alnR8+I6EBdgmVIUooiJyc7KTm/m
	RCzePqZZibwT1zkg==
X-Received: by 2002:a05:6000:1847:b0:42b:5592:ebe6 with SMTP id ffacd0b85a97d-43569df48d2mr7889842f8f.0.1768734035801;
        Sun, 18 Jan 2026 03:00:35 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:34 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:27 +0000
Subject: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=7540;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=e+w0DAW9oXvqNZy9JiObhL7asMTKcY24W84QkRdGT9w=;
 b=0mH19GhErzAi1HimK1aBDCmL/tFdWqtd24AQ//SxdqMJYyv7XsN/yIF3OeKiKm5yvv4m6WAfw
 sNIKnCD9eK6As+DnEEGjNces9E3u968aPRhvsbJ6V58cbkHTlj4zvRg
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
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  35 +++++-
 .../selftests/drivers/net/netcons_resume.sh        | 124 +++++++++++++++++++++
 3 files changed, 155 insertions(+), 5 deletions(-)

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
index 000000000000..fc5e5e3ad3d4
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
@@ -0,0 +1,124 @@
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
+SAVED_SRCMAC="" # to be populated later
+SAVED_DSTMAC="" # to be populated later
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
+function trigger_reactivation() {
+	# Add back low level module
+	modprobe netdevsim
+	# Recreate namespace and two interfaces
+	set_network
+	# Restore MACs
+	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
+		address "${SAVED_DSTMAC}"
+	if [ "${BINDMODE}" == "mac" ]; then
+		ip link set dev "${SRCIF}" down
+		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
+		# Rename device in order to trigger target resume, as initial
+		# when device was recreated it didn't have correct mac address.
+		ip link set dev "${SRCIF}" name "${TARGET}"
+	fi
+}
+
+function trigger_deactivation() {
+	# Start by storing mac addresses so we can be restored in reactivate
+	SAVED_DSTMAC=$(ip netns exec "${NAMESPACE}" \
+		cat /sys/class/net/"$DSTIF"/address)
+	SAVED_SRCMAC=$(mac_get "${SRCIF}")
+	# Remove low level module
+	rmmod netdevsim
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
+	# Trigger deactivation by unloading netdevsim module. Target should be
+	# disabled.
+	trigger_deactivation
+	wait_target_state "cmdline0" "disabled"
+
+	# Trigger reactivation by loading netdevsim, recreating the network and
+	# restoring mac addresses. Target should be re-enabled.
+	trigger_reactivation
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


