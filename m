Return-Path: <netdev+bounces-66362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8083EAD7
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641C51F25110
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71113ADC;
	Sat, 27 Jan 2024 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="W+GcPc1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FF125B1
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 04:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328250; cv=none; b=pi78q0yZOd0K5N/ebBw15RG8kZsskjhYDrt5gbq72nGgvlCwdiVJcIgksQvH5/vrcOfm07Ps2TqMxXHbaR00F6FmJ5zkI7YN+JNeSp9LuayyULfvhwA2Vs8c3b/ctJ3HrgjOE8XDLgxw2eUo6PVHsYeIDRUs+u6Kux15lBf1TNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328250; c=relaxed/simple;
	bh=nj2mDop2t0QrkpEErvwE8HwVED0A/wp9/wADFcl5IMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cg0kiijzAkBIF/sf+RT95mUqYzdHzdo5wZyBqTZsA+W7Nhkk9I8oTDjywklGQrRU2tfS9vwraccBONkvLO8r+Eswt8bkm+/d55s7cm8W7+1RoJRKfIuQC/gbHqmRGBF6lV2P9jvRP3ZBUKhmqCDAWVgKjLEX/bBkforcdEBCdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=W+GcPc1n; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e10f791f09so748358a34.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 20:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706328248; x=1706933048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2xN6P4fwXQsEOQPwU6oqJcN9ayeZZ+FE5D8UNFg1aI=;
        b=W+GcPc1nDO+5fyuw1fDuLOxG0wZfUIRwbRvg2lG8IB0IdbQ0Al7TyGfY1cY8fZwAXH
         Zd8cpuJ83ZeTVluJWjyOjOxSrNypKP4NE1WlDUzQUyCUOrtIRcMhWMAu7z2pD/CugsAo
         ewHV7t2HD7yZFsPPZ6ZdzTdbNK2KU5D57l+VjXdIO4DgY1N3aeqbg2X8GK18pdD9mvPb
         gD7bRcGgp59mqOdFaSVZ8X3dw5sLDeNjtkfKTj9UFTc2glVwbKAYA5aFvD7s7znKNJBb
         rHairYwKddolsvS2DRhLmlNltYgHyKtQblinGG6DTWZ0mOUUy78FXN6ejQpdNKHx5Akq
         vnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328248; x=1706933048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2xN6P4fwXQsEOQPwU6oqJcN9ayeZZ+FE5D8UNFg1aI=;
        b=GoTsAHgRCstFHyS4cXsx7Sr+qusfMrDi+agc4kUapCUjDcsqR50eS1fmwHGrWQgqi4
         ImTVEC6FTDgc//BqVkhSdcADC3UJhopQ+vDvbELA6yOtISYfvhepFwlZRJyPSbiiv/ka
         MvydZ415FOifWBSFkztr3C1nbm1BrYpOEjtT3z/oFeqZwFDgOdD/EYU6d0/XjZxcnvPj
         tsUXq2PCpEKOXkd4OSEfubikqBiEaiCAPDxronp2hVsSjoAbGX0uguiHF+bnqlarUV5d
         +KhGppbeJpOr5aTgg040amr0XG+h2tO9waewVvUKSZ9tWwHDGeuwOPuptujpHDGTlrzz
         fvbg==
X-Gm-Message-State: AOJu0Yy5a3+SpYb+ptvWOpe5Zu0Z8gChrLKjROxG7zXpKKrufNkXmpRk
	1jCEg5IrLtGLYx0Ms2ZfdAibkdsKQk7azMZe8/+z/uQMXwYacH4zJ2Mcib0s5fs=
X-Google-Smtp-Source: AGHT+IGraCaYT0J2u1lMs56bDL9yClDf3ZQ05keZjxjlTLBlgsZirDBSiI2/QdEakci29XSShpHrCQ==
X-Received: by 2002:a05:6830:2055:b0:6d8:567d:ed18 with SMTP id f21-20020a056830205500b006d8567ded18mr1072625otp.7.1706328248259;
        Fri, 26 Jan 2024 20:04:08 -0800 (PST)
Received: from localhost (fwdproxy-prn-021.fbsv.net. [2a03:2880:ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id r25-20020aa78b99000000b006dbda9a4e6bsm1855477pfd.44.2024.01.26.20.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 20:04:08 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v7 3/4] netdevsim: add selftest for forwarding skb between connected ports
Date: Fri, 26 Jan 2024 20:03:53 -0800
Message-Id: <20240127040354.944744-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240127040354.944744-1-dw@davidwei.uk>
References: <20240127040354.944744-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..05f3cefa53f3
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,127 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+NSIM_DEV_1_ID=$((RANDOM % 1024))
+NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_1_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_2_ID=$((RANDOM % 1024))
+NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
+NSIM_DEV_2_DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_DEV_2_ID
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
+modprobe netdevsim
+
+# linking
+
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
+
+setup_ns
+
+NSIM_DEV_1_NETNSID=$(ip netns list-id | grep nssv | awk '{print $2}')
+NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
+
+NSIM_DEV_2_NETNSID=$(ip netns list-id | grep nscl | awk '{print $2}')
+NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
+
+echo "$NSIM_DEV_1_NETNSID:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_NETNSID:20" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_NETNSID:$NSIM_DEV_1_IFIDX 20:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netnsid should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_NETNSID:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_NETNSID:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 with netdevsim2 should succeed"
+	exit 1
+fi
+
+# argument error checking
+
+echo "$NSIM_DEV_1_NETNSID:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_NETNSID:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	exit 1
+fi
+
+# send/recv packets
+
+socat_check || exit 4
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
+echo "$NSIM_DEV_1_NETNSID:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
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


