Return-Path: <netdev+bounces-70702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6D850139
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB25A1F27801
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A503FD4;
	Sat, 10 Feb 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="QavA3BsO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5F20F1
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525183; cv=none; b=cASUiFHLht+JPOaCRWAZhsXoOwwf/DbbTL3AVpF3F9/QbsFZMrtBaUAo756K/8WouvJoDfVls6jVco6+cofnXOLKGqX/nXcjS7QC116vbqyIsiPiD4eCrPf51+e0kuRS0MVc0id9CDxQy9BvO2xCM6V7xaMvu2kdlQ63t/jMLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525183; c=relaxed/simple;
	bh=22FbttwhJsXxkbiGLGQiGiw9/68ZxM9lKImRyOV9gLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUt9jYyL4xoa7JzCAWXy/Vr0MiA9kbbk8cFCZWt6wrWU99BJtBCXMDp6iaAdyIC02e9O+Grtl9Q5G/HGR0Y8i8vWS0ZT0r+0kO9empbzDlGrbpQpwK9GKgHLMWei1vFypi2rV+NZeL4i1Em4zvR4ZLdtt7pEnKRIAKB+duIsvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=QavA3BsO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso707819b3a.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 16:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707525181; x=1708129981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoS7Yv4Dm9pKnywF75Lod+pluPkWkES1eynTinaQnGs=;
        b=QavA3BsOrlFP7gPbT5DnS2S2SPQ6m57bdvO/IdoqOIiOeEmfizYFQlqLvDo1Llu4kP
         Ivwy2MFxN4J5jb7laRacF8RAFaRAvG3LS+zm5ak7xhBHfWlkksy5D5bvkZu/iA2bbstf
         miVTAMRgGCeYMlsjp5FgZ9OKPh20uVi1N3Z4xHxoW9ILNf1J507n0VE8v7+5yOkkCkNK
         yyn6a684BphoCc/frrlSTyrp562WDD21K5e4lkK1nQ7GXn+UByTO6GSiBSLeQVjvC0tl
         5It7jVzEzJ7kRyNXZOwIDudiBm+iFkG84MEosUxt5t+8Q/hRtylihhN9MjykXgng10j+
         ZkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525181; x=1708129981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoS7Yv4Dm9pKnywF75Lod+pluPkWkES1eynTinaQnGs=;
        b=JXbSswQthnVhzPLX22rHyPvIFVLow7CA2PzhOgbd3pOC9k1YuQ3awsoJoGGdxqneKw
         MqQvi+EpyW9T5ecDBubEFKBkKYwr5uRyQ71+J4CUoSLMiy7Zkz8E+jKabkw+PAQOWJHC
         U8MlDu8kcx6u0f3T1aT9lAzqxVCqEqyHFySpjdPEAJj6lPD6gFdHp2TnVB2RQpREc28d
         Zj03yWr+F2+Io/64tKJJ+mzhwRAzg3rArm9DXsUf64+Re7zHnmev823wR6sIln11WK8L
         9UIKLMN/JSJHAUKjksRXiCWSwimXsZabXRz3Te0ykWefZDfDqAG52rg+bgQIi4zzcgC8
         dP9w==
X-Gm-Message-State: AOJu0Yxlqm3qRZk+IO5c8aAIn6LiaQ/fMbm3mdGFFKOB+SOa9Oy/uPHo
	4AlQroy0tV9Gik0y7Hpmy1LWn/xq8fCsfoWvSy5Tc9azpCjsX85wXnQVHkiZy9w=
X-Google-Smtp-Source: AGHT+IECpK29xtVqkBXVFIWn424IpgwjbB4zlaw23sy/W3qJ7AQVO+oddO1wX2F8QMG1Zh5MJkO2Zw==
X-Received: by 2002:a05:6a21:e85:b0:19e:abe0:f0e with SMTP id ma5-20020a056a210e8500b0019eabe00f0emr3616897pzb.5.1707525181025;
        Fri, 09 Feb 2024 16:33:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWHXSdM60tzH+oPD7cRLhYsqTg1wb5M5Mlf6cmPbeJBZh/4snANf/pjiX+bGb1n0Rr7jHLdkvogdbu4HEJyWhRTYgDa16aNMcOm0Nd8uRqFvmb5AYgK7B4wmr8ePYOicQ6oALmDJcWfWFu4mJBZGzfTm0KATBAlKLZVENfyMAmJjlwgpdNH+LZTqachh3Kr3O01XVK
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id s21-20020a63af55000000b005cf5cbac29asm2431660pgo.53.2024.02.09.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:33:00 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v9 3/3] netdevsim: add selftest for forwarding skb between connected ports
Date: Fri,  9 Feb 2024 16:32:40 -0800
Message-Id: <20240210003240.847392-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240210003240.847392-1-dw@davidwei.uk>
References: <20240210003240.847392-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 133 ++++++++++++++++++
 2 files changed, 134 insertions(+)
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
index 000000000000..07f46d195954
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,133 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+NSIM_DEV_1_ID=$((RANDOM % 1024))
+NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_2_ID=$((RANDOM % 1024))
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
+modprobe netdevsim
+
+# linking
+
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
+
+setup_ns
+
+NSIM_DEV_1_FD=$((RANDOM % 1024))
+exec {NSIM_DEV_1_FD}</var/run/netns/nssv
+NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
+
+NSIM_DEV_2_FD=$((RANDOM % 1024))
+exec {NSIM_DEV_2_FD}</var/run/netns/nscl
+NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netnsid should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with self should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 with netdevsim2 should succeed"
+	exit 1
+fi
+
+# argument error checking
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
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


