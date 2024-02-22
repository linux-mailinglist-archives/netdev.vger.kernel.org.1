Return-Path: <netdev+bounces-73883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896DC85F0B9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A01C21613
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 05:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0943F9CC;
	Thu, 22 Feb 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qAj9ky5+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515577490
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578527; cv=none; b=EGXEOKvauGHjlmESaDhblFwphz6nQWf3E/MUnAx1c87ueMQeCu9vKAN9j6ADIGh2AAkMtvbvtKG9xjg7MPKa/hSomC7T17J+JmFEisPucOL+HD8zDGmXFD4Kl4IZ7FwLxFD3gOfEKDTrDGdsN4EqP/sRw6poC04HB2XukOdspwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578527; c=relaxed/simple;
	bh=YOPWX+M5ZqiUEJjsvcl0SVqwqZv37soDMbhqOvMVvaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahByYJ6UEyovbSc15pQtXRlZjsbkVjAix8rkcYMEbbZkXKFOqi+LHSLKuhg8cvHVQBSv5lJVxHRnUePbAzdLOrst52UXOYtR6P1XbE3HLDz7ykMuU7U99eqzLoKgppaw68TLmORdqvRClcmCyiE3OP1e63e06069PHIi3RGkAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=qAj9ky5+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso5749391a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 21:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708578525; x=1709183325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg6mAe8Th7HkYfWnh5XTzJrsh0pJe46nLGrfe+y89ZE=;
        b=qAj9ky5+jo0jiq89y3/qm3uIbgKRcaQqz4h20vbw5nMP2NLtOSPdjUK+Fu+KRusHTi
         9MdLYP+BbMNbNZ/+/RuwWwWY3OwVZnqK8iovdf6N9CZkZWu0Yf021bUVFoA3mZ432+Wv
         GG3ohG0Z2fSyFkxovmj1kPLXjZXF9ef+FHxf922BJ5/1tJSf9GAVpy5tYjadNSwxqbeg
         x8iy/fthe5gaZGjKEAKvpWnDm5/chHfsB8B6p0cNJa4Hvtc5aefcuQ6Ox4744JIb4aAU
         KUhUX3dOze3bZMd0B+jiesM6HQt7MVrZZTpXqmLabyr6shyYWiaYtBh4KMPC4cvHquFw
         cD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578525; x=1709183325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg6mAe8Th7HkYfWnh5XTzJrsh0pJe46nLGrfe+y89ZE=;
        b=H0fkceDeE0QBiEwh6l1YsgoBTV7GMwuvGJDFkY4pN55DHI3Iz6XzFmAMMFIEk2xWtr
         SXo/Yu91wYgrf6AscnbYh2iH9m+8/q7cOkHIU4uEFo0ySrGm2KajQ4T5xaO5VtTKHIoi
         6prpPZENn96ERamuPKMur68IdJnB4GDYpdU5LxJCLfc7OPoMCpuPUquY6M0fW1BzRnYI
         jLlMZ7JGoOc+iCmhzMdh02/2F/NMARoyquaE9O/daIlYuRtQX2H23ovpOx6g0cdjUZrH
         Ad03UJrkiqERz1A/Iv4SkkPiACZkCzGYvK8WiGekfPDezlyxLoa+FHpVP7YpIwnX+QtQ
         VfvA==
X-Forwarded-Encrypted: i=1; AJvYcCVrAB0P1L4VAoQ99zDbcwmGx/o1+FDYwb8+tUh8MsZH0QlZQicUskmZAZWjhz8VFgUu1+vdbSRCxvlQuUneZyujrjAA5Uvd
X-Gm-Message-State: AOJu0YxjkLQPwRob2d6BiGaki1jXm8fWv5LBVMi5DJB5myCC0T9c2U/a
	b2/7k5LQCe8hcRnqpuH8a7N5Klm4TgZEZSAUwuUybgu5/lfiOROIIMVMWjQUs2k=
X-Google-Smtp-Source: AGHT+IG4sEOeJd1OGBe5p19rylQG18tMPXSYhI9LNEtG5ef21mGuott/NpnEllvIYPfGMrmNnVfhhg==
X-Received: by 2002:a05:6a21:1014:b0:1a0:c950:9eb6 with SMTP id nk20-20020a056a21101400b001a0c9509eb6mr3051270pzb.27.1708578525323;
        Wed, 21 Feb 2024 21:08:45 -0800 (PST)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001d9aa663282sm8946416plg.266.2024.02.21.21.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:08:45 -0800 (PST)
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
Subject: [PATCH net-next v13 3/4] netdevsim: add selftest for forwarding skb between connected ports
Date: Wed, 21 Feb 2024 21:08:39 -0800
Message-Id: <20240222050840.362799-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240222050840.362799-1-dw@davidwei.uk>
References: <20240222050840.362799-1-dw@davidwei.uk>
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
2.39.3


