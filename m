Return-Path: <netdev+bounces-71093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265368520E8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9139BB24B74
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350E4D9F8;
	Mon, 12 Feb 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="a6jc+8Cp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD164D584
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775555; cv=none; b=Sb0deK2SYC8mnRJdMKi2CrniX383cZBFqAmhrNPG6IZK+pgnLcuXExeMaXhrURLGVV+IaLWcbtPFoJIkcDRLesKhv40K0AxZAdaCptfxgPE16Wi66dBTjRWjq/NhD5xJsfqbbKD2JRmv4tIoTCwRYyhmJNYzjcOqJqtASVMVYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775555; c=relaxed/simple;
	bh=fiA5KOUUpJT4R0pr92kiAeU8kaGWFhr4wAe6YC+qCwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Op1NcsOiVG++x+fQnjpKt06ERjgB7Pknhk3OAosj8tl+jilnjTssV3/Lsgk9HZJo7fG1ERPnyaOBEl85pems8gpJCtRPJvNGdc86sEZYW7sQm0R8OeHV2NuPmuGlo5gXawbo18/eh3IaUAnAfM6R9NFnwgQiDusLkr9laZY1vy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=a6jc+8Cp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d73066880eso34524045ad.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707775553; x=1708380353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zMatM8mJqDlYq7rZI8vigNbL9xkDJ4MAdk7FJc0Hmc=;
        b=a6jc+8CpQAgErtrKURkcikaI5ptL68ZpgNlwmq7TgzFiowZ7RLsqH3Iy/d0wA/V6JS
         N9WlbaTNUJRH24+5q7pdIMmdC5NZKRJ63fWvDzHuqDrkYRsuzqzlWtFTljKtjSIDhKNj
         rm6JQRo90CmOFitazo56vsYmTk25A2j+YbSdBtPt2AxingKu9g5FUNmOThIDDHph7SQ7
         /ry4IjGV/1+U4EtoQoK5yPeu14SqM7XMdHEx1ohN02F5qvG/lzvasgvhqGDjEo0j1RZY
         z7516Ql6Fb8aIcWE4pLjguf1xVPMN52nl1H1h6hL3gcVR5ZNHNeiT4ZcQ25AX0cqghqV
         By6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775553; x=1708380353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zMatM8mJqDlYq7rZI8vigNbL9xkDJ4MAdk7FJc0Hmc=;
        b=SrNsCj6xTuEPaIbCzJ/TlEiVY0HS11+y+v4j+7MrmwJlDWdt5MDnOYiRVvMHBgYPGd
         Et1qkPiOdjXNO5dBBYUUZxrMCBDVcHX+G1m3p27X89LzQdm7XnBpk7Lb+xRV4oZBr25Q
         PNS1YxOAA047lctyIVlsEDJCsli+BLOX5QMDpbpjezr4pzGyRvFtXY6s+lv8JJHKKBJ7
         dFGp0NqCVEsxiBUj63rUYKl8wP4ltNgs/ln0CD2OjpB/6Tv1Ho6Ls9KohAWnd5hngwLH
         hCMSyFR1iG5QiKbhBSPUGMoTPgpcC/RCtgcs4Fv937qfOTD295pIQ6SvJGmMS8SqT5cT
         zMlw==
X-Forwarded-Encrypted: i=1; AJvYcCXgXfFN5lCI4GsmcvWT7Dl0sL+cbjA/KByRAz7A18qd81ySPr1rQV5yURwwCEcvbap6gUskKJbiJKhDcqP4tbnn/6yB4N7x
X-Gm-Message-State: AOJu0YwTT4FbiWXnQOvk68rYbQ+AGK1xeEKA5w1oxRSJczIhbfmYakuZ
	d/89jwi9waGdvIwfUO3Y8gS75eBwmvfT+KTKyRc2q1o1EfFuGe3bzs5nwPB5I00=
X-Google-Smtp-Source: AGHT+IHtj76uoZJCkNWXEpiXARzZxDV0OCxAMOzV0ox24R4oUCBLCbW2rJRwubslv5Vo4su4NWAarA==
X-Received: by 2002:a17:902:7c93:b0:1db:2ad9:9393 with SMTP id y19-20020a1709027c9300b001db2ad99393mr881406pll.48.1707775553211;
        Mon, 12 Feb 2024 14:05:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkwUOvAbrK7wEGwRFzx/vnZMgqJxNs3h+6F4Led4yFb8kwgqjEqRcJRRNW1UxR75tFMmJdsjy9gnq2NRPtpi4XAr1f5SsCmiEdv9b0trPRHOIz4MyKoUrMzl9N7sCB/WBFDy0IKrWM0a/ppgDOsiDGO334LEzfmywMfuU72udkt/ml3uqiDMQyqjzCwxK6TNCfPUs0
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id r22-20020a170902be1600b001d9773a1993sm790221pls.213.2024.02.12.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:05:52 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v10 3/3] netdevsim: add selftest for forwarding skb between connected ports
Date: Mon, 12 Feb 2024 14:05:44 -0800
Message-Id: <20240212220544.70546-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212220544.70546-1-dw@davidwei.uk>
References: <20240212220544.70546-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 138 ++++++++++++++++++
 2 files changed, 139 insertions(+)
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
index 000000000000..274e0d977975
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,138 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
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
2.39.3


