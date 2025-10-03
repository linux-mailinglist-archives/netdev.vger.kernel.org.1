Return-Path: <netdev+bounces-227751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B46BB693E
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 13:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7CE486BA0
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA22EC099;
	Fri,  3 Oct 2025 11:57:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231302BE62B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492647; cv=none; b=Sis8zOWVlymKxNg5MPfTgjv/AR8DJuLrxk01HDdm8+BLjZAEaw2Dz3uYfLu/oD97jOIAfd7k8rd0iTFgJXYPlIF8TZnOtQJAiVd+8eSdXtEVha6MyRTT1xKVq8HxR8aixEXOv/6p0KntXRWdmVthJxD+tUTIQQGyxTaoI3g2ECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492647; c=relaxed/simple;
	bh=Tjpm4RbfWtGDoFiEsISXBux5s1C88ndSM58FldqBqTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBhi/wJiEWi91QbDWYtD3sjWc6t5ccgmf03kXL3fg5uh3sMUhLw0xri0epIlB761dDnQ/BHGYa4sopp3ytO61gJoLuybmOIFMU+lBbQhtcojoWc6Ynq+ueZxH2zf9zeHmLjSkG+zABz3EOsAqq57TgrPBr6wuL7deOWBPEDrJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso3838720a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 04:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492643; x=1760097443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri3Yk+R6v8p6/dp1Jjzw7TUVEJw3doRpqntYPTJquY8=;
        b=KeX9QFFX7M9Zw8GA+P5SRNBXsAFbBgCtCBL614j/2HSGGWPLZxYe6qL1gkG5sKyvSr
         56zFQ/hqeQrBbeCmG5d0uTkbVbzJX9+yEykD2kPPTdngkYtClU7c+Au2pRdefbMhDkWj
         dlLFdiYjXCOpEPFrvEar713FcN8y0VnIx3fHBagidK4M8bUjZJWzLA76HcjmiNUHKV4+
         cpInOj+s9WVtFY6pZXPuu9DCLC52BnqRpUgQnBed48/YCNuyKU9lvsn+kvhqKKgHikJ7
         +Z5lY6j8q1YmWBYGMtLK8EjPrdN565i2bQRP4Q8ZajBsus6FsU82Qn9Yh2mgQdXp6FW0
         yBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1XjlnsbNQlGBQ8/BCXAJ9qvt43rxkzezwwDqzJnJfGgaHJRGOzmGlHA4vZjMJBvNHAO1vnUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cU9tkbgcaq55vRpyqzjtd0+j//wzw3KSRwistysKionWxYMm
	PscReKw9LXg94keb5gyg9oulOx3ivM/9CRwH0tmaIUVmTG625xDNXcMLkZ1yxw==
X-Gm-Gg: ASbGnctSozwIIhd93kSITQPSP2hnTkLZB0s6fhu1U3nxQZAbGWQLdjUGlWNx2eIy8is
	aP/9Yi2LHFabwgew3fL5PGb0rmwnlfvn9sU1d+CpHBPoaweeonr/6Yii/rVgGVoUTAIduVJyWTV
	G10YvlH5DnTFl0jjgbpviEN4wCiwIiPjk04yZASvqO+VfyLEX7ong+VDPF3DQoa52Aq3tUjRmck
	GDmkRqbgNPDgoJjcyvJHLw9KgVdhUznvY9du3EwAOwmH1lZ+QVY6bJG/1ZSddVsj2z1WFhTDVUK
	tTg/Udkf8diQAM3+UcQiPDiW9XzfUjhAE4cv5GmPbdqgH70OcoXeaIGKd2NZ41DuWD30ZXbJ1Ek
	EuswClIPy9NphOpflYO2DwbQ/dvbbixOcZeAgB+WEJwj3Bng=
X-Google-Smtp-Source: AGHT+IFPwQoR8OAqkG5wJPF+4KyBxmm8XJ44xrE4QX6QJmlVGotYuu3HNJEc1Bf0kTZdBb8NjCQaQA==
X-Received: by 2002:a05:6402:42d6:b0:62f:5992:a64a with SMTP id 4fb4d7f45d1cf-639348f1287mr2981993a12.13.1759492643181;
        Fri, 03 Oct 2025 04:57:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3ab692sm3874370a12.6.2025.10.03.04.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:57:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Oct 2025 04:57:14 -0700
Subject: [PATCH net v7 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-netconsole_torture-v7-3-aa92fcce62a9@debian.org>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
In-Reply-To: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5257; i=leitao@debian.org;
 h=from:subject:message-id; bh=Tjpm4RbfWtGDoFiEsISXBux5s1C88ndSM58FldqBqTI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo37odUXbco8T+ETf3vOsgWdqUwlUx2LqDw1q0n
 NrsS5yuAA6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN+6HQAKCRA1o5Of/Hh3
 bRphD/98YZPmVSRfmgy0ZGV09XSGNtfSnzYZLVFTO4FtDRxioNNVxuA1Re7xRcySx6yX7p64MeP
 LNTdL+8B7yyooTi5f9gMhHL/28XfpEKSnzyaItMtwiYK/YaniYRUwgYrkhvj1zcNO62AejPD+FK
 UM7ucDQza5anv/0xDkl2hrU84MnAnUKiOSJh6Gdz+jJh64bPCmR0FDoIQF8/s5YmukpLMjgfdmB
 mx681HApdqg6oTWctnQtjsgc6m/fhnDc2ExmbkX2PNhClgc+uOHLpcYJ0jmlkNDB/AqHuAOTPQK
 wCfNPFc/TDLvS/muFwDCZfuTsVhTnBDkg3ixfevOzi1XZZYULIlSTwW8PRWq/yYvsiRKcotbYcC
 Fiz0pqFYmsmG/oxarBD6ypkpgHM4VRlZvsjxj7BYZQsH4eJiE+DOWwc9ABJsSHNv0ZBt2WnqMZc
 FO037C2yZHp43YMZbMFMsybbeKOj3wZ9spHbHKRjrxgTkl2HXovt6jVzfH0qyuTvaKP8KMbSjNY
 /f/Hz+cTfxb8lJLqybu0goRaMzTm2/A3dvMAsJR0N1Iw71kIq1Nogu//dzqWPs8agQAumlvaec/
 zJNACZiEQzX7YEIBqsXHzhGuENsS4Ro4fE1MiUnQVv1T+tX9zzoPtbMe5w2GJMaeF7QQ7lFcx9G
 xpIMUWKKueL5jcA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Create a netconsole test that puts a lot of pressure on the netconsole
list manipulation. Do it by creating dynamic targets and deleting
targets while messages are being sent. Also put interface down while the
messages are being sent, as creating parallel targets.

The code launches three background jobs on distinct schedules:

 * Toggle netcons target every 30 iterations
 * create and delete random_target every 50 iterations
 * toggle iface every 70 iterations

This creates multiple concurrency sources that interact with netconsole
states. This is good practice to simulate stress, and exercise netpoll
and netconsole locks.

This test already found an issue as reported in [1]

Link: https://lore.kernel.org/all/20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Andre Carvalho <asantostc@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index bd3af9a34e2f2..42b3fb049f868 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
 	netcons_sysdata.sh \
+	netcons_torture.sh \
 	netpoll_basic.py \
 	ping.py \
 	psp.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_torture.sh b/tools/testing/selftests/drivers/net/netcons_torture.sh
new file mode 100755
index 0000000000000..723aa2488c19a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_torture.sh
@@ -0,0 +1,127 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Repeatedly send kernel messages, toggles netconsole targets on and off,
+# creates and deletes targets in parallel, and toggles the source interface to
+# simulate stress conditions.
+#
+# This test aims to verify the robustness of netconsole under dynamic
+# configurations and concurrent operations.
+#
+# The major goal is to run this test with LOCKDEP, Kmemleak and KASAN to make
+# sure no issues is reported.
+#
+# Author: Breno Leitao <leitao@debian.org>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+# Number of times the main loop run
+ITERATIONS=${1:-1000}
+
+# Only test extended format
+FORMAT="extended"
+# And ipv6 only
+IP_VERSION="ipv6"
+
+# Create, enable and delete some targets.
+create_and_delete_random_target() {
+	COUNT=2
+	RND_PREFIX=$(mktemp -u netcons_rnd_XXXX_)
+
+	if [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}${COUNT}"  ] || \
+	   [ -d "${NETCONS_CONFIGFS}/${RND_PREFIX}0" ]; then
+		echo "Function didn't finish yet, skipping it." >&2
+		return
+	fi
+
+	# enable COUNT targets
+	for i in $(seq ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+
+		# Basic population so the target can come up
+		_create_dynamic_target "${FORMAT}" "${RND_TARGET_PATH}"
+	done
+
+	echo "netconsole selftest: ${COUNT} additional targets were created" > /dev/kmsg
+	# disable them all
+	for i in $(seq ${COUNT})
+	do
+		RND_TARGET="${RND_PREFIX}"${i}
+		RND_TARGET_PATH="${NETCONS_CONFIGFS}"/"${RND_TARGET}"
+		echo 0 > "${RND_TARGET_PATH}"/enabled
+		rmdir "${RND_TARGET_PATH}"
+	done
+}
+
+# Disable and enable the target mid-air, while messages
+# are being transmitted.
+toggle_netcons_target() {
+	for i in $(seq 2)
+	do
+		if [ ! -d "${NETCONS_PATH}" ]
+		then
+			break
+		fi
+		echo 0 > "${NETCONS_PATH}"/enabled 2> /dev/null || true
+		# Try to enable a bit harder, given it might fail to enable
+		# Write to `enabled` might fail depending on the lock, which is
+		# highly contentious here
+		for _ in $(seq 5)
+		do
+			echo 1 > "${NETCONS_PATH}"/enabled 2> /dev/null || true
+		done
+	done
+}
+
+toggle_iface(){
+	ip link set "${SRCIF}" down
+	ip link set "${SRCIF}" up
+}
+
+# Start here
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# Remove the namespace, interfaces and netconsole target on exit
+trap cleanup EXIT
+# Create one namespace and two interfaces
+set_network "${IP_VERSION}"
+# Create a dynamic target for netconsole
+create_dynamic_target "${FORMAT}"
+
+for i in $(seq "$ITERATIONS")
+do
+	for _ in $(seq 10)
+	do
+		echo "${MSG}: ${TARGET} ${i}" > /dev/kmsg
+	done
+	wait
+
+	if (( i % 30 == 0 )); then
+		toggle_netcons_target &
+	fi
+
+	if (( i % 50 == 0 )); then
+		# create some targets, enable them, send msg and disable
+		# all in a parallel thread
+		create_and_delete_random_target &
+	fi
+
+	if (( i % 70 == 0 )); then
+		toggle_iface &
+	fi
+done
+wait
+
+exit "${EXIT_STATUS}"

-- 
2.47.3


