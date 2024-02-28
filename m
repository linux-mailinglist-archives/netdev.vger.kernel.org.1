Return-Path: <netdev+bounces-75947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201886BC23
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B718B260C1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4322876EE6;
	Wed, 28 Feb 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Eb3dvQzS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8CF72901
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162583; cv=none; b=ffKoc2f8zlJIBOC6nwMlgBnSFO1CTqFjbipKD0w1EyHmUUnKibdt3R5nGy1vruEJZBdXgkzvdI5seA8qjcaTsF24N9wPmN5zGmq5RYPuQ056PXhdxkBN55Cfw9XW2z/8jJs+I+3nShQsb4qlHfjZ/Xt0yiLSH6izumlo35CNzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162583; c=relaxed/simple;
	bh=Y1jPRwRoyMNF0suvjMjHZLxamIH5AlPcRacyY9MnFBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUU3T+ioIvTrS6RPM+WKsUJa9L6kDBnBO4YlF0UPjuzHfUhFhlfOoWMtN/fXUbuiOmDoNWLg4AzzzVdnr2kJm8ikHSHr75kduX+ZzCNPxr39ctjFOi2u1+Q6PTC5Tl8qVxRfrUPki0QI/OEWzByQeAme/mmM3q7G0qihDPAHop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Eb3dvQzS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608959cfcbfso3792527b3.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709162580; x=1709767380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q5XYN7tzbVmTzEuBgAB1tZATSLFQ1CSVWIFAsyXioE=;
        b=Eb3dvQzShbBxNl6bh4zcT7xaJQHLDqoa0uSPaBqNYt8KkhoJ0hLro83IXU87jLKN/p
         A1Mdyk5/NrGhJ6eiDb8xd7QQnOclf63MpC14gQLJx5WpBuzIhQb+wiNON+tpsQCVPOiN
         Iw+rXShCk4IvzEbVooVGdpESiHZzlxK/ZhQNY3cd2rf2yBwdiefGDCdz2fO/80NO8j+j
         moXHESsvKWTPtncsccrhLfKiEXV6nuJk5JZ5EghVmcgtCLaBE/yNS+B7R8IBvrwQggNU
         ryfRqYbE8sCj2h5iW09dAI0IiMwVbYE/3TWumBNihjkZeiyxy6JFSumyfEt6qz0tID5g
         VLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162580; x=1709767380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q5XYN7tzbVmTzEuBgAB1tZATSLFQ1CSVWIFAsyXioE=;
        b=HATte9Ffbysc2wF5Z+ZXbflG2O/QPJheroj1iC5Bgb8gglD8JxKcQlg9NaXQiaRhQB
         FPGoUh8u4g5E5V53lm0A3AqowGj7hRE8mweX0k1ZfKNx75YdJzsvPcapqdyb5AAQB6Ss
         7duQFkn32MHbY+ZOmXT7mzqf4dHbc7r1dqNZfYbOJ49RMClhBadOmZWvu5dDauiclI38
         d2j+32mhLuoMl6QMOkWe74hRUflV2AIcT5M1Cq5vSef6/TYzoeFkGpUDFebCNyIhDF7w
         rXrPRgsyZvTG+4kOCL6XlrBkK0/g4Jni2dCvj2C1bTKMTIVabfu1NaTnn8A+YgtN4CkI
         G8iw==
X-Forwarded-Encrypted: i=1; AJvYcCWaNB3N2jb2IErLrlx0yYF90W/ZaJY1lNEwdM5fBsVyMcTcxP44YRCG7XJmdFAkakcaX7JqrqckYRDm0zp7KbFZqjoeFyvm
X-Gm-Message-State: AOJu0YxDpR6rCjkHqHJZkirMmst1ezRkjZRGh6Ayzj0Z9a5HtKe/Q4v2
	LTH7R2nNz4S4t30/17xt2bn0LDuroYmv/uIMvbnOnvPVTJ7/LRfpeS1s8lInHs0=
X-Google-Smtp-Source: AGHT+IFdGc5iS069dwBDm1PLYqqaF5i6QrAzF03v+YWYq0DDd/glzzKKdhBarMVa+A54wABREGgOyA==
X-Received: by 2002:a0d:ed04:0:b0:608:20fe:dc28 with SMTP id w4-20020a0ded04000000b0060820fedc28mr588799ywe.37.1709162580632;
        Wed, 28 Feb 2024 15:23:00 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id t125-20020a818383000000b005ff846d1f1dsm25808ywf.134.2024.02.28.15.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:23:00 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	maciek@machnikowski.net,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v14 4/5] netdevsim: add selftest for forwarding skb between connected ports
Date: Wed, 28 Feb 2024 15:22:52 -0800
Message-ID: <20240228232253.2875900-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228232253.2875900-1-dw@davidwei.uk>
References: <20240228232253.2875900-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect two netdevsim ports in different namespaces together, then send
packets between them using socat.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../selftests/drivers/net/netdevsim/peer.sh   | 143 ++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index 7a29a05bea8b..5bace0b7fb57 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS = devlink.sh \
 	fib.sh \
 	hw_stats_l3.sh \
 	nexthop.sh \
+	peer.sh \
 	psample.sh \
 	tc-mq-visibility.sh \
 	udp_tunnel_nic.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..aed62d9e6c0a
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,143 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source ../../../net/net_helper.sh
+
+NSIM_DEV_1_ID=$((256 + RANDOM % 256))
+NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
+
+NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
+NSIM_DEV_SYS_LINK=/sys/bus/netdevsim/link_device
+NSIM_DEV_SYS_UNLINK=/sys/bus/netdevsim/unlink_device
+
+socat_check()
+{
+	if [ ! -x "$(command -v socat)" ]; then
+		echo "socat command not found. Skipping test"
+		return 1
+	fi
+
+	return 0
+}
+
+setup_ns()
+{
+	set -e
+	ip netns add nssv
+	ip netns add nscl
+
+	NSIM_DEV_1_NAME=$(find $NSIM_DEV_1_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_DEV_1_SYS/net -exec basename {} \;)
+	NSIM_DEV_2_NAME=$(find $NSIM_DEV_2_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_DEV_2_SYS/net -exec basename {} \;)
+
+	ip link set $NSIM_DEV_1_NAME netns nssv
+	ip link set $NSIM_DEV_2_NAME netns nscl
+
+	ip netns exec nssv ip addr add '192.168.1.1/24' dev $NSIM_DEV_1_NAME
+	ip netns exec nscl ip addr add '192.168.1.2/24' dev $NSIM_DEV_2_NAME
+
+	ip netns exec nssv ip link set dev $NSIM_DEV_1_NAME up
+	ip netns exec nscl ip link set dev $NSIM_DEV_2_NAME up
+	set +e
+}
+
+cleanup_ns()
+{
+	ip netns del nscl
+	ip netns del nssv
+}
+
+###
+### Code start
+###
+
+socat_check || exit 4
+
+modprobe netdevsim
+
+# linking
+
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
+udevadm settle
+
+setup_ns
+
+NSIM_DEV_1_FD=$((256 + RANDOM % 256))
+exec {NSIM_DEV_1_FD}</var/run/netns/nssv
+NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
+
+NSIM_DEV_2_FD=$((256 + RANDOM % 256))
+exec {NSIM_DEV_2_FD}</var/run/netns/nscl
+NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	cleanup_ns
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netnsid should fail"
+	cleanup_ns
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with self should fail"
+	cleanup_ns
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 with netdevsim2 should succeed"
+	cleanup_ns
+	exit 1
+fi
+
+# argument error checking
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	cleanup_ns
+	exit 1
+fi
+
+# send/recv packets
+
+tmp_file=$(mktemp)
+ip netns exec nssv socat TCP-LISTEN:1234,fork $tmp_file &
+pid=$!
+res=0
+
+wait_local_port_listen nssv 1234 tcp
+
+echo "HI" | ip netns exec nscl socat STDIN TCP:192.168.1.1:1234
+
+count=$(cat $tmp_file | wc -c)
+if [[ $count -ne 3 ]]; then
+	echo "expected 3 bytes, got $count"
+	res=1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
+
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
+
+kill $pid
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_DEL
+
+cleanup_ns
+
+modprobe -r netdevsim
+
+exit $res
-- 
2.43.0


