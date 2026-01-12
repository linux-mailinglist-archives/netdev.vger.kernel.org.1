Return-Path: <netdev+bounces-248940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489FDD1194C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C87AF309539D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3468349B1E;
	Mon, 12 Jan 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4Rg5gtr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CC34A79D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210879; cv=none; b=fIfsndv1wSTxjoU0jWHoqRQ8DayaPjsTCwbnzGN6Z2m8afJ1rNnsZK2hf+DjwROjaVd2uRLzIUaP6Wa0q0jxFk6M5Zh9bbL9gYrjSmM7VIuP2liJV6di10Mqz5CQg+AOSqHhrNO44D1CFvJB1rQSdePtaBjke0EsNWMvGhN7BQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210879; c=relaxed/simple;
	bh=KSC8Nj3DiK31fDmZ4/PzcbAzUlQgw1PwPAvmb/6l8Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aw6YMG7fIVvauTxzUWWnG2vg50bbv5SU/RNIs2GUcoWJ5T0g764W3cgI7JJ+bJpgpm42rs9IpCG//uo6TMPp61ixLNDYQJcZFdWdMyWHEBjai3wSgH9h7VQ2cbLCcXreYfu+WdwilJDAiJsqtRGxwH8gNpD5Sp9brkEQrKPD/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4Rg5gtr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b87281dbdbcso52711066b.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210874; x=1768815674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RFEABt6Iiak9nuJmj7Wxw5Z8I9sCXd9qm2gCXqcVTA=;
        b=k4Rg5gtrQzZNDFwPEua/3PteELL8IOfQ76OrcxIPrd7hmF3EMtSTW93tIpL+OaBmXl
         8HL3DUkpewKwM0YM4jx6YxsVegRMX+MxxhNxM3FTlw71JjFCGxMj3lhd2mhsyOg8EfdL
         Xk2kFp3j4LX47D/v33R/bpeYOwKp7BJDgWgKWGTo5cLd6VqGk1JtdbGCZs39nzjiBBrc
         RW3speVSWuV45YO0jW+2suJT3b9O7TCsirkbsCuzUney+jq6YXtuRZIlyWESpEBm2I1l
         JCVXfkdS+d6dQPDh9upvynPl4VfKZLSjTJtCbfKLWiP9+Ox7m4KsvvulkmXGTp4ASwIH
         SdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210874; x=1768815674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2RFEABt6Iiak9nuJmj7Wxw5Z8I9sCXd9qm2gCXqcVTA=;
        b=hmlAmuL1grDZ4hIdC8Bdn0m4NNoOLTH9r2Om1dxRkGen69uuTZfQo3Lawqk2apDguC
         5X4SDb1aqAOE18e9Iz24w0j1dZzmQPFiXAd7z7T8D0lLgNa7Ix4TSH4QvpFC0qKJvKZk
         dgk4d23zlBd1Ty3vnJudRjam9tOuPSfGIo6qFh4MQyXs1xrURKJ6ut4v2FPOpdjKnjz7
         Lz9aRUi6R60vJDujoy8X3hVnrBsr3573AOkndyXrSkzb972W4zPfl4M6pLXwReD3aBR7
         gwJ1yha5D8FlgUzVF5e5yL2G3yAltw68Y/WtF/KX5dlPua28nZe1dkDtRzRSnY7i3isd
         hfOQ==
X-Gm-Message-State: AOJu0Ywok8BoA1d3mMBNinmJrISAd6Q2aLUUbz6Pta1IVXiPP91bQPM3
	Rb2/Yr5BJjJOKPf6VvRmiP7auEZb72zbp4P8GRsgXBDqJ0J0edValVYA
X-Gm-Gg: AY/fxX67nsgeKJm1EOjH4sfe/4Pb1lqITjzTC0kqh7HFpFQdokGnUFEcwbu3sYe/qJi
	6qF/L3WgBjMKNElrxKEB2oeTgHUe3skObchqRoaer+lscRDIe91VYrgmy2tQ5qPm/zqLaMcGPpK
	Fen5ZNmFgUgBe0C85ZrjJK2zhQAQlQFhGxyLeUWoYVFPZdMhyVkqQQBy1byDDuwL37U//zM6rjK
	LICZuv15MY8vAbdEuf/zZH7HMT/SQ4lE/SdSbBHEHoO/lgFuBaJBXXaTqV7Xoj4UeZDld7+B5pV
	0OfA9JwixrZSznW1BUQZ48KXW4iyjvHdDISLriNYIYTidAgBr1ZPXvdWlyvRbG8+Sl14QCmpshZ
	BSYpp0yFqVOJs+xG1ZShiL4xmreHUOnKk7jYJSRratsaiF6mUKZJw2qGRaYFXDRp7m0fCFkpYDQ
	kCIADdNJLbDf+H0oz0PFgGpdI1
X-Google-Smtp-Source: AGHT+IE3wiOXJvIMJw8ueQ9HmSpunkUpmolMVZVGfJsiMnps0ap0V1WAk3+kWd4HECoGsMIKWUcuqw==
X-Received: by 2002:a17:907:86a5:b0:b87:6d0:df2a with SMTP id a640c23a62f3a-b8706d0e1e9mr437193266b.40.1768210873498;
        Mon, 12 Jan 2026 01:41:13 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:12 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:58 +0000
Subject: [PATCH net-next v10 7/7] selftests: netconsole: validate target
 resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-7-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=6537;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=KSC8Nj3DiK31fDmZ4/PzcbAzUlQgw1PwPAvmb/6l8Os=;
 b=yT390LC8bW9NHpfY3TcipbMrxZ1ISAJCIIideT52vdpL2kwc0ZJtpmUDb7SyZ6EhSZKrh9A56
 kiD5h+lpd5OCA7yQCr9if1+60dgN/t+nBN+mVJu0b4/kjEelQ209O4m
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


