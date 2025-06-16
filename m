Return-Path: <netdev+bounces-198201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D75ADB927
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AAF3B5B7D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0440128A1CF;
	Mon, 16 Jun 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="LwCWNAPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7D289823
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100103; cv=none; b=kc8LgmMG/74hQ6z+uleLovsbDBi6sbnn9hLneotCRpw0I5Sf7oJGAzRkLElKGgMyZYi0QLvmxAA3SyeThQcYp61Erboc02tHTu49pXQe5VqMUN4IDNnnTEq+lQOPEq3EtBiEN/lgo7nRlQujT8PMzZPl/F30jrT2QKtKOdMxWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100103; c=relaxed/simple;
	bh=TPbFmYm2pYmwrTTR53izgCCDv1AzxT3tOzkqSDT8nSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etKJHmkRsHIJ76jZciBDBxLH3g9es7v2Rv1/Yo0aJ6sxAhTq4kHOa7hZlzt1ooDpQrldyEWC0FsrA0xK2BqntLi/uXF+w0QFOaK3NkMVg/wcuosLyAsnsrZXsKmAssAPMI9UTDzMakUKzAdtaIOETBLrxFVt0StGFqqREBfShpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=LwCWNAPF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af6a315b491so4454716a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750100102; x=1750704902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydJG3khVO+X4U9n8qkDODxWlQGQgPbDZl94QEFZZIRY=;
        b=LwCWNAPFRZ5tNF2+dKf2Kty0Pv9lkm81mZVM9OrChkuJbvA2P4aIBy2YeAE0qv9/zc
         +JKPyJX+KkqDykewDyLCcCbQdrilY2gYvHf+1Br/6LNT+HcSR83+EObAgApRAYDEicQe
         tNZNhOMqhoDK+XEasP7/lv1CVyqpZ/mU9n/nZV1gTyZkn4VFisMSBonE+gQlD0Nvmoj8
         k2VURiWLieVnlBmzqSXNcqBNp7I9fpIcR3OFh20jlm9kJ4w50SI8BG4R4ALlKuQha586
         aZTpjP+tE6QiTPN+96tzgzyoyWeV0Vv1tb6P8WmK5/GUJvvTbYIqLDtL+C/J6loxGT5Z
         hgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100102; x=1750704902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydJG3khVO+X4U9n8qkDODxWlQGQgPbDZl94QEFZZIRY=;
        b=e4KlTFRkyV9dSjtMdHcPVQzLBrlGplfirMymdqy+D6HJvJxTFLicAup8m9lbe7XL7Z
         U8sTCbbUofMIRzoDO0whOFbPmYZj3buHpenlw6P/s6mwwAopSXL2dkHvCKGb22Upq5K/
         4VhMK0ZHAqHV5LbXhqqBRMsEPQL7tLP4KL+QZE7fV2M/SaWYX96NNBsLVQK3fP603ZpB
         rxzlV5R8SeyEAh1ctLb8Ol/ZYcVKJ8VFV+FBbeMS3P9Xh+uGBpnfwgCfuLX7BxxHBnvV
         lLOBEjNNZpIt1rtu6IlSAqDIqokUvt/Yw3lCG/lm5M/nKFi6e8/NadC9QT2+HOGIRfJt
         P/2A==
X-Gm-Message-State: AOJu0YyIdJOwSUVQcf9wcrGdXT76euPGH5yhel6lA7GtW1ft9iBxU5se
	BsKyHnoiEW81vqOhkSp2XlimwfdDvFG7ku6D2MbPnBkXgOfDFlgBUznNjyW2P1VkneTFb5aXNJx
	ihw5M
X-Gm-Gg: ASbGncupOv8BIb0fE7em287PjkITfP0uV1Ez4nfW2jHc+flraUCxdvyopJgUfHoURf4
	/N2L6dGtKa8cFUtFLAq3UHqvvit0kAxqvy63FRfw/czM6OT4qDBuxx5mxg3XnvMf1BtIlZgKH9e
	KViUrbgkcEoWT/q/HTpmJmQ3/w4XXqt2b68uRgEhMZSUMSku5LQhSqqccPUBOO7LzfKlNIxcyGH
	W818v0/Hujc64/L0QBkIq+5i6uKU4GXYlkpGefM2JgUZDj4bZHYKTLxTI0gsx8alvroUzREkvLU
	VrW3HKcEzHbNAsY7K6mElihOWu/YDXmcS3MVQOIeEZZxBNp8Bx5xvefX0w==
X-Google-Smtp-Source: AGHT+IEKJuN/+VzsR2dWKg0IrkvrtpTVi/FG0NsNGJWcpIieEqBRi69xER1ZM/tZx1dg/w7EiNO57A==
X-Received: by 2002:a05:6a21:4d8c:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-21fbd55112fmr15222853637.20.1750100101544;
        Mon, 16 Jun 2025 11:55:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890084013sm7476957b3a.96.2025.06.16.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:55:01 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v1 3/4] selftests: net: add test for passive TFO socket NAPI ID
Date: Mon, 16 Jun 2025 11:54:55 -0700
Message-ID: <20250616185456.2644238-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616185456.2644238-1-dw@davidwei.uk>
References: <20250616185456.2644238-1-dw@davidwei.uk>
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


