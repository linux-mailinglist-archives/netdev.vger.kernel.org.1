Return-Path: <netdev+bounces-67352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E2842EC6
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77564288B24
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9433179950;
	Tue, 30 Jan 2024 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ThJ3YwR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563C78B4C
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651187; cv=none; b=p4MWPqWIqzcEgTucKpMHmSdsvj9RQ8/zPkQxz5YC918HbOLCK5zwVpuP8B4Z1y10AQTlvZR5FZ4qCcYRZqhiIHbP2e78cEEz5OdCGGDEZGxG4fMyTHj9ty7AUl1HmXtgexJaQXjF/gNxaC5vISe71G5WheR+YVNI7kn9bChbrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651187; c=relaxed/simple;
	bh=tkY3NSVt4mMMttzbuNQJ18NgnNQXjdNURV2Wno4GCTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OzA5j5OELkfAhdrSY7175T5MvanyQMpRJ+eFjoofVS4o6twDpDyG5JLxpNg7HgrQFx5YrcURa9M246LuZS+Dl+yuqJGrsSfwfbRbl2TMWP1uJr2Lr414v2KOrM7AYsP9s2aD6IyEAO1lDOQTtZ9UvUfGvcNxL/XtEjgrz3kQfLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ThJ3YwR5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddce722576so2286280b3a.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706651185; x=1707255985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28btIFDDW89Qzho7Aw2XRXuoWIopwwnt9ux9YmhuDBM=;
        b=ThJ3YwR5HFEGLhiTknwbT2Y3KYiP2qOFn9sXB5y4tCQ4FehGpW9aUjFYYy3q3P7Mey
         nBD7UkJNzCuIjqPYHdoeslLr4rkMkJZR1mQ+2sNm0pWBrkrYXn2xhPPIa+tA+BVySY2A
         VwQhozsyNWb1VMcseQuYTbjplUZ5YSJC2I+IDGDhw2Xlbnz5Ttagep5Hz4IH7hiLZYyE
         Ra93s/Uelvvf6ABUkc8fmPWkTDlwgW+t7eAFz4TZyDS//EHTwMSvhFHLLHCf4ohquj71
         BJHTMCl3mHli+f49k+jpQmeDmcL7K+zhs/dAy227O2x3801a8nEuQietj6xZRpMxa9DF
         y2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651185; x=1707255985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28btIFDDW89Qzho7Aw2XRXuoWIopwwnt9ux9YmhuDBM=;
        b=tJ+GBsXVX4gsmUZUa4A/RS6IAdEUG/QthYREkEpqzpfvgHdBU9E+ckxW295DHa1xNy
         VKoFxyca5cBLK3eF3OP6Vt39OwhUszDXzyrVnZqg2E8nl6Ec2KpyLH8paZenGocazaos
         VHeRr6dcrp37FUl336TGlgi1Jh0UJu+4O4mHVoJL+KS1SP0xacxvk+zFTFDu2vWHJA1n
         ytM5HPbhub+9TQ05DfAFiAedGQ6j1doxV5W1wqbejXJlQg4u5e2Wk2rdiZaz8mTesu0U
         Exjx2qX4uTg184YBJANYGIFlNRJrWT9vzeXxYRGho+AdW8kiQVAgwl8o3fnamuXddfIE
         9SlQ==
X-Gm-Message-State: AOJu0Yy4T99aF7Sn/mmhUfbe+pvBAANAm9vfUVnzRuG4QLdmOG+UUQPo
	KxMSwozlfjQm31Og8oMJZSBOhDn+P0KCw7JiwxlwoZjVVc1GTdsn2jh/JTGiWmM=
X-Google-Smtp-Source: AGHT+IHv9bp/PyvD5OfCuogtR9+V0aYjGAO2wMZo+fqFStjj4/Hi3md9gAHWHkLxAXY9+Sw1Q1Fqqg==
X-Received: by 2002:aa7:8886:0:b0:6db:de89:d0f1 with SMTP id z6-20020aa78886000000b006dbde89d0f1mr6150636pfe.28.1706651185323;
        Tue, 30 Jan 2024 13:46:25 -0800 (PST)
Received: from localhost (fwdproxy-prn-027.fbsv.net. [2a03:2880:ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id d10-20020a63fd0a000000b005cf450e91d2sm8980727pgh.52.2024.01.30.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:46:25 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v8 3/4] netdevsim: add selftest for forwarding skb between connected ports
Date: Tue, 30 Jan 2024 13:46:19 -0800
Message-Id: <20240130214620.3722189-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130214620.3722189-1-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..9d232fc50d69
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,125 @@
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


