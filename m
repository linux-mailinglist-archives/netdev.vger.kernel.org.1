Return-Path: <netdev+bounces-72617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CBE858D49
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 06:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F65B21DF6
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D761C2B2;
	Sat, 17 Feb 2024 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="QLN0Eihb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CF1C6BD
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708146265; cv=none; b=WkmZixGBOiNcZGfV5KNvc2gWem9ygLAaRVUTj3X76Z1TUKdX/f6gkEmmblh/q0fUs1p2YaHMuJdb0S6xNnfDr/SkAkMyVmkllP13tFvT5NTtUQ3c2LJkoZd/RZv0gnFASPdNdfD8afmx12JwCaX8TvYGrbW7/InJLpDv0uh5TrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708146265; c=relaxed/simple;
	bh=0cUVoJTJr3QlY4VeIpHF08NETkkBRKcCVRXoF8XuXsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZIt9LBqLQ0d/Zhwpj++NlkWME6P05pzTJDvy9vuvxbqGunZvNgh5QlmHGCgekxbn5UmwjWDhrWhBcA7SzIFE82eR4OUkhsmC1NFQ9JjRRbyTp3+xRt1E2oWEKCvCWlpmCwNY2MGr+4PuDh5RnShf4JAySR2lDudcZZGa7doCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=QLN0Eihb; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ddf26eba3cso1837365a34.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708146263; x=1708751063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofa1RGnWd2lIotrEIt0lDKejuMRo/GrQuejfvweLENM=;
        b=QLN0EihbNNVvOvRfjAX2dIXdHB2W9hM2Y2xw+tpeiJiETpzaMSAn2aKLgWs7xBc0V1
         wzkVhiQks8/pduaJeeSV8UxBW1kVLf8cd9rqqDpCGBaSytIVgD0P1E1Pd/Xt+Z7ew1uc
         bHScLvTmjQnfThTxYdxC6WVFVkc5WWeLMsG+S1GfyfudN63HWvCGEusVzeJfWnF+iEDj
         LvNLR8gtMrJSBUcUGw7XHdv86FD3i2YbzvxAoOdXOaaMT80qXSOwh0MoTxCRIQbtIEMu
         lVtPzii8H2FecFIKOIkEMAVbBvBglktiXUJHmYL8n8HeuSGK7BEp1vikHyESnEJnLsLX
         JU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708146263; x=1708751063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofa1RGnWd2lIotrEIt0lDKejuMRo/GrQuejfvweLENM=;
        b=FQ7+Yoz+xsbttbd8q1BBqSOVLyvFQW1qMZeFCxeiQIpfi1hJZGOkW3lqJyHvJP9MyV
         Ya/0FREGOGPrUgWdwsbwFoHqbzd2u1jJ8Nzrm8QDtYkkJA79Wx8cxCqp6KGehoYg1VKj
         wJryAdn7qFmH9msI27Wpzd+tBn5p5bbiaiaTl0Lp+yUIt8G59q9TntSllwDeyfKrpKRV
         RCf5DWSDlAzfVpvDXYLRSpQaIrJ/dDFak8AMOMKSVOmmC/p1s49op0zKPt5Q60TSmNK7
         kBoHHmPOI95k/n2SUboZHpL2+Fif28jXqCAQi9nPcQeAfYn/32D/3UWsihW6kCMDuNgc
         kVEw==
X-Forwarded-Encrypted: i=1; AJvYcCV2SADO6NRmrJR+mPCXlVoeW8U92lVZGa9XlDAcdcNMWBQt8sA9Seprsx2oRo1cOVQVFrowq2fdeerKKvYsxp5uyhu3eJUI
X-Gm-Message-State: AOJu0YzuLwRaJ2u1HDAONfptUQWJtG/QFPALpAPinsNNvxNFntboBsi1
	xqL4GQ1qeJgr7WpdpdDrZHhOtFSiSvdCgl4DLfM6Kack8NCVYPGttKw4aNr9AV8=
X-Google-Smtp-Source: AGHT+IGYFCGOJJhpaJ9diYN7G1TogjhXQqmW9muo3nKFfifu1OEqsCfo1GWPeXnYA24Qs1ZjQb4vWA==
X-Received: by 2002:a05:6358:5925:b0:176:d522:76b4 with SMTP id g37-20020a056358592500b00176d52276b4mr7138428rwf.14.1708146263121;
        Fri, 16 Feb 2024 21:04:23 -0800 (PST)
Received: from localhost (fwdproxy-prn-006.fbsv.net. [2a03:2880:ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78259000000b006e0d44e1bd0sm783967pfn.55.2024.02.16.21.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:04:22 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v12 3/4] netdevsim: add selftest for forwarding skb between connected ports
Date: Fri, 16 Feb 2024 21:04:17 -0800
Message-Id: <20240217050418.3125504-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240217050418.3125504-1-dw@davidwei.uk>
References: <20240217050418.3125504-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 139 ++++++++++++++++++
 2 files changed, 140 insertions(+)
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
index 000000000000..c3051399c509
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,139 @@
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


