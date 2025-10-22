Return-Path: <netdev+bounces-231809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A89BFDA53
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCED3B0E69
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE0D2D6E6D;
	Wed, 22 Oct 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkFVZJav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CE2D978A
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154845; cv=none; b=DrzMWZKO0SKu7n5+QHugi+rBvy3FTtgLPvK1GNjcNWvAP1QjgxCFptsELeGzxiHhth2M9PieJH7sI7Ja8k2A8bqpKHFNMd1XDA9C8qXt/z5vPZp6IdQaUeazl53zyls45tLzr8Fa4vb3//B7zScrEBAwJyBqpgEkMslIPp4hyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154845; c=relaxed/simple;
	bh=zVFKrMjT7Yg8KzgZuFRm2mf+JLW0KJOFTZQ6lqdZFRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9l76syA5yX7u/fw8IL3H/ioQ5ze3vvEAUErUbbyWFadix9sOLEqayhZ7SVDrX0fStcmRzoXPBNqwr2dRpOVa7tp8zttmMXTu4fJroPdqMpogiQUwZNkN6Nl5+K9c0adpBfHNfLqSDH+EEAWuAt3aHuookeYn6Gc65+CJ6VFXQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkFVZJav; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47107a9928cso3825105e9.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761154842; x=1761759642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AP35Lhe113Y360Zl88AVM66sXWalstyx7sHvh40y3sA=;
        b=BkFVZJave9AG9e/yHekQUqBgYiZkapx/5cZMoJ4MaVxlAgnXnefSAYSg48H7pqZRxY
         nq08ZRYqKJVN4CZClPv++4xuuLUSawfKrJlimIirOtS6jqg/ESKb5cHjB2OyKWrn4nB5
         MbMS2BE3eKM2JyV8zl2cqKzKEbC2PuvK62r93Wb3f8HNW7Ixh1MEjkXdEosJBq5WVgXZ
         450gUUTvosUgiizoO0+mAf7ukBXoJd98GRgadqwr0kTeulczf2Y4ma/ZW0mY4UEhvQGj
         dCOFo+MXaCMXAYsIqm95ETQpRu1Lrb1Xr9EEE7hEuQNhsvJFt/BccNSXMcUR4xzaizrq
         Oweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154842; x=1761759642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP35Lhe113Y360Zl88AVM66sXWalstyx7sHvh40y3sA=;
        b=CE54zDGH9q5JWPSbXtq8ERRdDfRZqtxHc6v7Etwrk/lYL9BI2EKIYCMS3Pt1zfOmzh
         lxO5XUqsnzL3DINJILlSeTvm1/pzGnjfXud2ECf2340GQYxeVQA/TJpsln53D6jG62Z5
         VKhbH/Kq9p0ay52qX67miAkt7dPOPtubF/59aeSwvk/z3MwZWpRPYYXaMQZkJ4oAropS
         40+gYy8svxizwML0nrybu0O07WSmDd/kMFC6btissYETEPBsP2Aono3WYZS1AFHdqe7A
         JyXRerqjxgwFlj7euAvqcqUkQPRFhfkk2gzlixOx6660fNL8NB+TpuA3iCEvJiP54Zvh
         mtKA==
X-Gm-Message-State: AOJu0Yyry9RCCiH5wE1g5A/qIrbnDoA0exbqK5UHH57aQwgnZumfEFwv
	tWzLWaXdFa+doCTWiyqSHpIQGbWeRqPf/yjb8KOIDJWGM8v8QnRq7tU6
X-Gm-Gg: ASbGncuTnw+bL103i0k5mUuU1MFkrHUFAIss/jtexB85IHWWlWGpvP3ptpoBenVlYPg
	riBF/bU7PbwT7SHyPYbhyUIpMKeaOdSz0JcpbsS1Ki/5Ph/289PBeehKVX4LqWDPlhes52qfnFE
	biJF2u5zZP+NYDc3MTcU9A8N7CJIjPcPAr0l4Vdux3BcUhhKkDpE5U9f+WJg4DxkB8Pp+yZe+SW
	KGWfwIwfMGTW5SQfYj4wmBbNk2JgXfz6ynVdGN1g/zOSIp1OzvO+6d2RS18Nw5HbGGDW2CfKReZ
	KFmECZYfDJl+tr1NDSP0ekRxdpbno8JCMp8F2e3mKUKOf02hAuVArw48j0VEieW1cWzEeG+R2jY
	chr5nv/XIeghHyrtT/O9nJ9Atp9WT+7f8mUkLhAoN/JO29zZHyBNZFMbpnLsmZBzJYIHhmgWAPv
	mk1Sib
X-Google-Smtp-Source: AGHT+IEecb4eLK37gAPhC+kUHjZRQLAVXxIkgkcbFBCIuxAll0AonuANG7ebbYJGBJSoVbFYl4u3hQ==
X-Received: by 2002:a05:600c:1c25:b0:45f:2d70:2af6 with SMTP id 5b1f17b1804b1-474942c4fabmr36464545e9.1.1761154841890;
        Wed, 22 Oct 2025 10:40:41 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c41ca845sm55430385e9.0.2025.10.22.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:40:41 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 22 Oct 2025 10:39:58 -0700
Subject: [PATCH net v2 2/2] selftests: netconsole: Add race condition test
 for userdata corruption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-netconsole-fix-race-v2-2-337241338079@meta.com>
References: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
In-Reply-To: <20251022-netconsole-fix-race-v2-0-337241338079@meta.com>
To: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Add a test to verify that netconsole userdata handling is properly
synchronized under concurrent read/write operations. The test creates
two competing loops: one continuously sending netconsole messages
(which read userdata), and another rapidly alternating userdata values
between two distinct 198-byte patterns filled with 'A' and 'B'
characters.

Without proper synchronization, concurrent reads and writes could result
in torn reads where a message contains mixed userdata (e.g., starting
with 'A' but containing 'B', or vice versa). The test monitors 10,000
messages and fails if it detects any such corruption, ensuring that the
netconsole implementation maintains data consistency through proper
locking mechanisms.

This test validates the fix for potential race conditions in the
netconsole userdata path and serves as a regression test to prevent
similar issues in the future.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile       |  1 +
 .../selftests/drivers/net/netcons_race_userdata.sh | 87 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 6e41635bd55a..ba7dedc54711 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS := \
 	netcons_cmdline.sh \
 	netcons_fragmented_msg.sh \
 	netcons_overflow.sh \
+	netcons_race_userdata.sh \
 	netcons_sysdata.sh \
 	netpoll_basic.py \
 	ping.py \
diff --git a/tools/testing/selftests/drivers/net/netcons_race_userdata.sh b/tools/testing/selftests/drivers/net/netcons_race_userdata.sh
new file mode 100755
index 000000000000..017ee042eb75
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netcons_race_userdata.sh
@@ -0,0 +1,87 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This test verifies that netconsole userdata remains consistent under concurrent
+# read/write operations. It creates two loops: one continuously writing netconsole
+# messages (which read userdata) and another rapidly alternating userdata values
+# between two distinct patterns. The test checks that no message contains corrupted
+# or mixed userdata, ensuring proper synchronization in the netconsole implementation.
+#
+# Author: Gustavo Luiz Duarte <gustavold@gmail.com>
+
+set -euo pipefail
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
+
+function loop_set_userdata() {
+	MSGA=$(printf 'A%.0s' {1..198})
+	MSGB=$(printf 'B%.0s' {1..198})
+
+	while true; do
+		echo "$MSGA" > "${NETCONS_PATH}/userdata/${USERDATA_KEY}/value"
+		echo "$MSGB" > "${NETCONS_PATH}/userdata/${USERDATA_KEY}/value"
+	done
+}
+
+function loop_print_msg() {
+	while true; do
+		echo "test msg" > /dev/kmsg
+	done
+}
+
+cleanup_children() {
+	pkill_socat
+	kill "$child1" "$child2" 2> /dev/null || true
+	wait "$child1" "$child2" 2> /dev/null || true
+	# Remove the namespace, interfaces and netconsole target
+	cleanup
+}
+
+modprobe netdevsim 2> /dev/null || true
+modprobe netconsole 2> /dev/null || true
+
+OUTPUT_FILE="stdout"
+# Check for basic system dependency and exit if not found
+check_for_dependencies
+# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
+echo "6 5" > /proc/sys/kernel/printk
+# kill child processes and remove interfaces on exit
+trap cleanup_children EXIT
+
+# Create one namespace and two interfaces
+set_network
+# Create a dynamic target for netconsole
+create_dynamic_target
+# Set userdata "key" with the "value" value
+set_user_data
+
+# Start userdata read loop (printk)
+loop_print_msg &
+child1=$!
+
+# Start userdata write loop
+loop_set_userdata &
+child2=$!
+
+# Start socat to listen for netconsole messages and check for corrupted userdata.
+MAX_COUNT=10000
+i=0
+while read -r line; do
+	if [ $i -ge $MAX_COUNT ]; then
+		echo "Test passed."
+		exit "${ksft_pass}"
+	fi
+
+	if [[ "$line" == "key=A"* && "$line" == *"B"* ||
+	      "$line" == "key=B"* && "$line" == *"A"* ]]; then
+		echo "Test failed. Found corrupted userdata: $line"
+		exit "${ksft_fail}"
+	fi
+
+	i=$((i + 1))
+done < <(listen_port_and_save_to ${OUTPUT_FILE} 2> /dev/null)
+
+echo "socat died before we could check $MAX_COUNT messages. Skipping test."
+exit "${ksft_skip}"

-- 
2.47.3


