Return-Path: <netdev+bounces-198800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BC2ADDDD8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A993B2230
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6A2F0C58;
	Tue, 17 Jun 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AQ5Pag6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21422F0055
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195274; cv=none; b=ma9lyDYx9VN9TOHf8gPG8epLWGGcumNpoIhXcVBG/SaPQxyxbgjjgJJ5lEjhfF91f/CGwcHBd6t7nPzJGt6I+MrH50A2txJs2cEJAkfRpwS1mSgRa8FOL/c/s65YtOru9r+pbYl05efBCzUREbZ3Ne1nAheOMZMF31P8IkPSbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195274; c=relaxed/simple;
	bh=TPbFmYm2pYmwrTTR53izgCCDv1AzxT3tOzkqSDT8nSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx5yH44RrCuAt9GIZqNBDc28Q/9Y1RL7mOsEluLQRBwGV6YYfpFiLK5vF5O05t97msXLUV8WDu2mLtbGRoBC61Ho71ZvRbwLU6vcWmGMnP9ZE2v/jGjLYBkm5k9NeLP3YmFQlliHUreRWaaaieJTP4uPTXSYlDrt7y3LD9HbSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AQ5Pag6B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2360ff7ac1bso43874705ad.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750195272; x=1750800072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydJG3khVO+X4U9n8qkDODxWlQGQgPbDZl94QEFZZIRY=;
        b=AQ5Pag6BJEwe0TJXaYDBAdcjPMRDXGw56gzrPXZGanBEaZjd8otFBrZ92E+uptkDu6
         2jvxYwMujf6sAR7ddkMkqlDP04naxNcz8vM1LL93Ous1WaZ8kEdxvHN/FbSmm77V3BMd
         PF85gFDXA/LWAFu94w7miIrEgkWvbVkfuUwgfsbptpRx/2U6pGexLZVgUaktvY3iTGrq
         Bh+n5gcW/VCuQh4SMEzkRVJr6zMr/C9rD+QGZFRZ24V9Wmv/sRTWKKtUZtRC6GL6wP41
         i1X9g1lK8tquIwOxf/00uawwamv/wc5MpeGjBKD5BR8tdpzuQrRTQnj6k1EyW4Y2Gf08
         6Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195272; x=1750800072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydJG3khVO+X4U9n8qkDODxWlQGQgPbDZl94QEFZZIRY=;
        b=HGW/joSGtDMSCL4deWDqQ3hf/LYAaYSguhEWwF4XuaVGSF9favPUqNaNMXOP9amidN
         Dsa0p8YXi18hgDJx+145XVacQ5xeVFL60mAORfPyj+FwKgn5MUU9Zf+mqBTlF9rbsx46
         zovNQ/jhJbMbzEA47Obl33GapV4rvderkk9eOHSwxaCWoLlMP4ZS1gItjLZ/1ASD9GPd
         l5rVcDbkM2RIsCs2/f/2TJDZ9E7DOwk7cHaU0hohxpWNwSTTZbBSzA1IDYCVktLWwbk+
         BKKNk21iejbVxyxIYBN4jfgLBjk4o70ZcUkDgAV0y5AbnnS7PwzjlZEUH+iDu1AE7WF3
         XxOA==
X-Gm-Message-State: AOJu0YzWAWNprCRGRSpGy3LpZEq928kndiyjRnc2CDTTWtE7xwqwcv1j
	lhvatINKPLj9YOdmGyYMU28ALTDPW/iRFD+7fQyABextx9Aim2wlSR+yY84fMigamu9eDx6nIft
	qqBCx
X-Gm-Gg: ASbGncsiVs6xtOXRmmJkGE3XNtwdHVEFAEtKLym0bc7QliYDzD5m7/iQ/cgezaK2NJh
	YkiFXjRBvJqgmf8wjgJNC5miylT0grZ1qKyN133NR0XY5qH6uhqe79HfcP+iVVu+kVWiP94aQw4
	BaXex61E1EtNyOjac10AdZqSJHBVw8a8KPY4/X5xPPvBch/XiC1BuS+pIrT5phLHwkSMia8TW+2
	xiUfr4qSmB/51OmnqIGvznh1iRfeNCV/SdMmcPp29n0Vd6lj9q/Db7nWnRUzapAEg3rCPy+Wdus
	uAF8gN9auzseL46k+lFWbAT+2AMTIxq0hHv3JmFDCGfmD/3X
X-Google-Smtp-Source: AGHT+IGrY993gpFtv3vY8bfMVBaecsBCqshkG9v+o5R1X06EWr7PjJ+Ca4VZW9ljvLefeFIQTKN78A==
X-Received: by 2002:a17:903:1aae:b0:234:914b:3841 with SMTP id d9443c01a7336-2366b144b94mr206219085ad.39.1750195272274;
        Tue, 17 Jun 2025 14:21:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c018sm85678635ad.36.2025.06.17.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:21:12 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v2 3/4] selftests: net: add test for passive TFO socket NAPI ID
Date: Tue, 17 Jun 2025 14:21:01 -0700
Message-ID: <20250617212102.175711-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617212102.175711-1-dw@davidwei.uk>
References: <20250617212102.175711-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that checks that the NAPI ID of a passive TFO socket is valid
i.e. not zero.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/tfo_passive.sh | 112 +++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100755 tools/testing/selftests/net/tfo_passive.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ab8da438fd78..332f387615d7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -111,6 +111,7 @@ TEST_PROGS += lwt_dst_cache_ref_loop.sh
 TEST_PROGS += skf_net_off.sh
 TEST_GEN_FILES += skf_net_off
 TEST_GEN_FILES += tfo
+TEST_PROGS += tfo_passive.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
new file mode 100755
index 000000000000..80bf11fdc046
--- /dev/null
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+source lib.sh
+
+NSIM_SV_ID=$((256 + RANDOM % 256))
+NSIM_SV_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_SV_ID
+NSIM_CL_ID=$((512 + RANDOM % 256))
+NSIM_CL_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_CL_ID
+
+NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
+NSIM_DEV_SYS_LINK=/sys/bus/netdevsim/link_device
+NSIM_DEV_SYS_UNLINK=/sys/bus/netdevsim/unlink_device
+
+SERVER_IP=192.168.1.1
+CLIENT_IP=192.168.1.2
+SERVER_PORT=48675
+
+setup_ns()
+{
+	set -e
+	ip netns add nssv
+	ip netns add nscl
+
+	NSIM_SV_NAME=$(find $NSIM_SV_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_SV_SYS/net -exec basename {} \;)
+	NSIM_CL_NAME=$(find $NSIM_CL_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_CL_SYS/net -exec basename {} \;)
+
+	ip link set $NSIM_SV_NAME netns nssv
+	ip link set $NSIM_CL_NAME netns nscl
+
+	ip netns exec nssv ip addr add "${SERVER_IP}/24" dev $NSIM_SV_NAME
+	ip netns exec nscl ip addr add "${CLIENT_IP}/24" dev $NSIM_CL_NAME
+
+	ip netns exec nssv ip link set dev $NSIM_SV_NAME up
+	ip netns exec nscl ip link set dev $NSIM_CL_NAME up
+
+	# Enable passive TFO
+	ip netns exec nssv sysctl -w net.ipv4.tcp_fastopen=519 > /dev/null
+
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
+echo $NSIM_SV_ID > $NSIM_DEV_SYS_NEW
+echo $NSIM_CL_ID > $NSIM_DEV_SYS_NEW
+udevadm settle
+
+setup_ns
+
+NSIM_SV_FD=$((256 + RANDOM % 256))
+exec {NSIM_SV_FD}</var/run/netns/nssv
+NSIM_SV_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_SV_NAME/ifindex)
+
+NSIM_CL_FD=$((256 + RANDOM % 256))
+exec {NSIM_CL_FD}</var/run/netns/nscl
+NSIM_CL_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_CL_NAME/ifindex)
+
+echo "$NSIM_SV_FD:$NSIM_SV_IFIDX $NSIM_CL_FD:$NSIM_CL_IFIDX" > \
+     $NSIM_DEV_SYS_LINK
+
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 with netdevsim2 should succeed"
+	cleanup_ns
+	exit 1
+fi
+
+out_file=$(mktemp)
+
+timeout -k 1s 30s ip netns exec nssv ./tfo        \
+				-s                \
+				-p ${SERVER_PORT} \
+				-o ${out_file}&
+
+wait_local_port_listen nssv ${SERVER_PORT} tcp
+
+ip netns exec nscl ./tfo -c -h ${SERVER_IP} -p ${SERVER_PORT}
+
+wait
+
+res=$(cat $out_file)
+rm $out_file
+
+if [ $res -eq 0 ]; then
+	echo "got invalid NAPI ID from passive TFO socket"
+	cleanup_ns
+	exit 1
+fi
+
+echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
+
+echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
+
+cleanup_ns
+
+modprobe -r netdevsim
+
+exit 0
-- 
2.47.1


