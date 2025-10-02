Return-Path: <netdev+bounces-227636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E834BB451C
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71C119E2C57
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464B31DF99C;
	Thu,  2 Oct 2025 15:26:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FC81D54E3
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418806; cv=none; b=uhQ/YJHquOG+3gX4YWXJVnxumxnzKtND2UJcnW3mVdYzoYQ7N1ZHbV/bYWH590Ljw1a3Ry68+9no30yp4qPveAazQ+NMtYdCYGKJQGLN9JdN1+4iobYb3Mb8flm1sPsLudSH6IYSi+wy3P5/iXpvtARwkD9NmPn6O4Sh7YhXlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418806; c=relaxed/simple;
	bh=wCTCXuF1yxmEp/u/Sr4POeQXqdQsOxIg5TvZ/SJ3ls0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6MBfQwGlBhYIBKyw/q2OkrBhHH1arJIFdqNdwGRPlayCf+W0gjI1YcsFju3rF5vYp/4LDiIvVAk5Q0TvOeXheb0dTD7aam4FHHE6Ako1AwPbpUdFxByWAVpG7X1BsIW87ED2p/Jy18Qeco9FnUo5wnO9mwXBapZwVzF6OSiwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-637a2543127so1988170a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 08:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418802; x=1760023602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXgombtdf1pG/9E0pDd7PwlfJe24y1WoCU+6S182X6w=;
        b=CE13rpX7o5kQM48vKilpBYsFErisgqRXGjNCVaRk5EvXdeg8B+L+WfxvR26U/GpkMq
         A05buz4c0HnPg3+TAf3SepfH5+FD+DNEM6s92qfMxkV8OBrHuUegDKki4h9DNIpbv2ZE
         dOqWm6WyXMWcLrOOJVe7Vyq9zcPuiuo6HlB6YT3arGjlulEv88qHD4fuL+T/qeysUKg1
         J7Humj4A1i2fdEnCzMpKGJv38EyBTwHK/+raGguV0/V+M7qqRs2s0Ijrdtw9Y8krrFo5
         pYb/bmGkBd9v1osiB6oj7wy0CNvL4qBv4bwxFWdQIbpzLkfwj4XGFhjzkmC1bIfl8u+G
         w3UA==
X-Forwarded-Encrypted: i=1; AJvYcCWaKWPaHQuZfveUGYRt55YEiKlgtpPUu1laISp58vvOEyyjz2zct8NBRcGn7i6JtDffbD4scdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uKfGuKS34o7n531dYP2XC402kBLLki1QLFcQ7rwn6+yyUJQO
	cWz42LBkSoPqXXK/K5V/pzXGcgoviYTf08t4ugWQqqpCdQHPubOrF6Uc
X-Gm-Gg: ASbGncuUcCMauLVK+8ZBTnCKCnJBW2PSyyy0HG63tsqYuCzCRsWBChpi0zptbACjCGB
	g+OwfmPGfWjNjrNF0SdoFLURLPTXGdPzDiDOhvNSvuHUWvY14ZiNH1iZSsx3kkXszihW+3AhpQI
	wXVuMPXh+QZqjyeZYlysXP6Je7OA9r0yoXZGTe0+blkCZJqRTZAQQL2AQ8S/BszGx8yQznGDlpS
	To6exyCcTp15ztCNB4q2B3BrghpcsiELi2YT5d68+YPwDCarJwonAVUm4ZQUgXob9sgi9CipEkD
	eNg033yV78eiSsgK0pJzdiPCg6yASfgDR3StK2aebAMEl1qZuEzWY99nZHsFWFQr/RnbEJaZFun
	zH2tZCj+5uCa+9dat//rPCwfI7l16CH/5azCZZ4iJxlvdPic=
X-Google-Smtp-Source: AGHT+IGwJ7GX2udijpZY8tC506RtKUpv5oAxJ0Wta3SK+EKAIFSchsaTuH5oq1K3c4XJNvkVHHckCQ==
X-Received: by 2002:a17:906:6a1e:b0:b46:1db9:cb76 with SMTP id a640c23a62f3a-b46e6031e32mr947212166b.39.1759418802114;
        Thu, 02 Oct 2025 08:26:42 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606dc84sm222645366b.45.2025.10.02.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:27 -0700
Subject: [PATCH net v6 3/4] selftest: netcons: create a torture test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-3-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5371; i=leitao@debian.org;
 h=from:subject:message-id; bh=wCTCXuF1yxmEp/u/Sr4POeQXqdQsOxIg5TvZ/SJ3ls0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pmsmmMGNKcgEnavHC2jMEtdvF8yeZdoGp4aZ
 3JHNKKmj6SJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bd4lD/9+O4IHa2bZy6+3RktskQcbeHj09CYSlsackDR0zeECGyMpFB9wUmmDQMJW0foPBqCXB5F
 PrsVB83q1YgEsLu4mfivqXDYoBuYHVAImibFrRzwkWuLaAPNJnE/cN7niP885NMl6Ydrjrn5ySM
 FEx3yPsG1f6td68+Qzy9nKvNQmL/ImM6/ndzpvXuknJqYb3XWGa+8QpuZzOxemQYj0XFUoOO7rI
 h+tILR8p55nF+3AAilLeMBJfipr+WqGklE6+WbbvPzP4WlHlJypCZeuJBusi/gEbwwXmv4THtlx
 0/CjRNY3ufwtPFg0k+JfR+agGr7Pnfqlimayzxh92fMKp3DgU034derwx4K0edlAXc2vb+uh5Kq
 AKVQI352huzOxTrMHMaczB9zQkV4czj+BUYLOn8NUyj75HC/UL8FgPLqRGXCQGW0z4AZKp205/M
 ptqPctj1EEYeHoo7njjgUC5liEhdCvZ+FfWXiWdkjPjbq60Eu6PKS6Kho5jaYC7SPo7T9TV2+QX
 TarXwGH5FIfbck8Vca1C9DYEitV1IKf70mBxFXSzwQn1MBnahxE5WJTXWBT4I5axFynAZpapC3U
 SlXCzgalhj+34nNzXjy7wahhcOlSTGioynvN2TMsd7YY710BXiJEahoL6MejHXyq8K6/CmrN1k0
 n5ldAGaPgN8Bq0Q==
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
 tools/testing/selftests/drivers/net/Makefile           |   1 +
 tools/testing/selftests/drivers/net/netcons_torture.sh | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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


