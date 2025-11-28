Return-Path: <netdev+bounces-242635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2CC933B3
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 23:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2B1034DC97
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 22:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3E2F616B;
	Fri, 28 Nov 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+qFHD+U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95AC2EF67F
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367721; cv=none; b=hpVkgdmxxrj+5Q5meofjFkcVVvjGATNQZ0dVqHqzDD6+T7N30+rqU4MR3O/6oScBg4H1+Y64UpbazeFTNh5hlqI4Hnfc/XGRvPGq0M9QcpJWcvpfIxxmyNDa3MWb0iCN34Sj71LGIbjmAkuSKTRj7m0e3X3tK55JBdWqfouLqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367721; c=relaxed/simple;
	bh=hn/kxg8v9iI6fPhbZcD8Tj+G//s0QmgoWLVA/hu8hV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSCuLxWG2hNLr18BkIyZDiiD6mUGJihzHm0yFNCIbtYzq9ZyvnXK8FOUGVF+rU6tKjdqcujFbMAJv+vRHrbu3tFNJsfIgXAckr1ywYe2XLC63GuJos2vA7BOzxE4BdTU1O6hhNUYBfewD4A/JjHviKVuhHV8Ju1WGrF2XG1hyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+qFHD+U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so2010252b3a.1
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367719; x=1764972519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/fAPe5zn1MJUzjr0NdBaLTd5ohKsQq+JKoQHPiFo9E=;
        b=E+qFHD+U3Qx0NvVgJkjGAto3C4uPyVjVbHCApsEOUSyV/H2yKoelUWvpnua3NnA2uS
         R6QWxiSj9Hep8AieHC4c+WF4ZzLU2YjMGk8+aTkCWTvhc+em6Qx4spq73sqtFrJvcLY5
         afV9jsvgyTYK2V1C8hyeVOPlbXdmO/FdLpgcQMKWR2LvxktBW2LX+FzCWqu2SyOGHH+W
         2SH5kC4TV0G9Jgb9T3m3JG+DdQzjLSMHYfq2ImIQHYBM5cq/tPWcM0Qv949FCc8M3YtS
         JIdcCvroOHLsj3f6krgjSb5Jej0lrJT3seXVUXoLIN5JfazcvMjH5ZFkp1FATlJzWZ3a
         3C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367719; x=1764972519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/fAPe5zn1MJUzjr0NdBaLTd5ohKsQq+JKoQHPiFo9E=;
        b=SwXfXH1/5eOxYdV9622HHxP/XxMZvCKYJwP9SjJB4Tbl+E2N8gkQqj4DhTqskSZ9DV
         VQQfTKw8Y8s/0ia4J5tv+o8LvFnlJK47kjSeX/weeK8aBKTV2sHzz32xL5je1BRlbW45
         +TYnFYNZ+VtRgHLK2hXExsl1X+94IPkDhSCZzt9jMASrefkvCov4PhvnY2hRm1XBKOim
         2bpPW4Zlg5c3diqdQW/NDUY6lLNrzM1931pS6vLpzSAd9/Xl0h8GwgCalUKgtCCq6lfu
         70UWKATvIfIWVKhBtnEb041jjK+tzVeufqKJuLXS4Xx1xHivrMLVnnNrZnGBj5Q8gK+z
         vFeg==
X-Gm-Message-State: AOJu0YweQE7mh0U9wsrMIJ+QEGBXUZE5HYcJoNGMUn8/bV/QDuDP9OIw
	/3wHXk2aZxmZHi0wa/sTNgghbQL/K51q0o4WHAB+Vibr5TPZRi5ADU3Spyd78MwxliW6WA==
X-Gm-Gg: ASbGncvK0+iQifNAFoLIa9cwFkxgYF6X71X96+ly3oSxJ9vLXImNDdhdb2a7moPwmS4
	+vJQY1hNCtKrNZ7bQXzPaE7hUNS215+enIoWBghjbjSxOVg3uLSdG9EtsRKZroFzAVR+NAmiKCq
	zwA5aXvXPHyWcGpkn2crKnUZKPxVjsanbYRcnDCdC4U3HPzxSUB/ESMWHjQ9sz5ny0FEBLm1UoM
	QP54diroUHcvgAY+8hf6OJMwnATfRdJVSjFyTxPQPTswgt33WmNlYV+WrK8zvs2QxJ/Rc4bj8Fg
	vlZlsxSykXjl8e4QhoOXZ2jrz+TPlKeR5KrC0DgdfFZ6LeH90oeO1/8LKeiALKbRCbfCJi0QMK8
	ixEtuZyu3yaYVfHbPHWjgCilV1F9+ORwKPrM+DWGfpZ8QydLqOyyx6uTDFmgIvlFeNHguf4rGR8
	K37PlNKOyaZCSkc2tRcA==
X-Google-Smtp-Source: AGHT+IGHZEWFQ0KjoUVeTZE930c9/q5lskB5MxuqjPefp4lXxRMi5yyhmjD7WBYkTxgYnWwGS6AQuA==
X-Received: by 2002:a05:7022:f691:b0:119:e569:fba1 with SMTP id a92af1059eb24-11c9d717970mr22737261c88.16.1764367718821;
        Fri, 28 Nov 2025 14:08:38 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:38 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 28 Nov 2025 22:08:04 +0000
Subject: [PATCH net-next v8 5/5] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netcons-retrigger-v8-5-0bccbf4c6385@gmail.com>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
In-Reply-To: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=6537;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=hn/kxg8v9iI6fPhbZcD8Tj+G//s0QmgoWLVA/hu8hV4=;
 b=VBxaoFHaw3juwU/yfhuN3hXGZCPa6kWgBe5dOdchPvA9SX5oc+t8abLbQaC4QQ/ZJ/0ZDfq3+
 wGabWcqagPaChRFU4W0zBmvb/ijfQ9oxfLm1jS4CsFar1iUVhOsE6yz
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
index 87f89fd92f8c..239f44d4a45d 100644
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


