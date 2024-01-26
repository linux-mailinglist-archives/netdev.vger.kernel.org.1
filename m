Return-Path: <netdev+bounces-66068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF483D205
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C301F2635B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79869567D;
	Fri, 26 Jan 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CeuH0Yc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306215BF
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232245; cv=none; b=mCTOXT1z4I7L+8L/vkJYBR9/r5paxeg+fhDV3fW+RsVDAF2B1nEXaUvg+gqLPxXP9LIx+0ZymEdVqv55/t6+hzkQTiOfxyg1W/6ud5iAne7X08eXRiSUqZXQsBHHY/QOiY7N2mq8oOepAsx0QA8fLTo5gt8N1PWiLc8oZjinnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232245; c=relaxed/simple;
	bh=74xb1S+58KTAkR+KlZoZt6XeFGiV0DmBRji/NtusKYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piageADjaewJmRLLNay0dp1lkHzrf+qaFSkA+s+efC0U6UA9G4gBsZlG4ywMeTyD9U6dQKG3ob0IGWFHLeRiNUUtilYNMMtc+3RRtPPArMLMU8fAVA9xh41BlqgG8yVS0N6IDdC3cAUk8T1c9haErGMYoatVU+FGgtmF9hGBp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CeuH0Yc+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce942efda5so5555214a12.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706232243; x=1706837043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXL8wH7GmvH1gdgfeRX5m+iM2fXhAn+u6nfVnG2vWa8=;
        b=CeuH0Yc+M03SpXNvkwZqN/A0t0WSjJYZs1wpDavYjcUYbajTd8Hac5pFTZkbS1cJ7O
         Mhbaxeuvm+WdzG+/FHVMIoGqG1p89SYPMdGmqcMS1958eKrdV62iWDcDCi2/6jdNyXkD
         XNpMvVe3QJA+iUD4PXFuEmVHGM66uL5Ead0uSvuL3HTHJwj+6fVSa77zieNd0vIwzWFw
         cyVpvNJLA1t2jtP7yXD4zYMzuaQqHK9OI2p+dRzE1HoM1wf6M14/lELHz6+Ljt49kRaF
         7BRWpfql1jTU3f90YIb/UaagPbRAPi/kEiowXCp/X3LVP5u9fRz6+nXO7U8zRU1ROJE5
         /p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232243; x=1706837043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXL8wH7GmvH1gdgfeRX5m+iM2fXhAn+u6nfVnG2vWa8=;
        b=oR9rVOw0Bt/AK9lDxbX3QNFIBNBlem9IlhufS+Jlj1Wuwlqpu9t68f4tTBefPldgmD
         gvv0uSamj1vDKDAwnEWwFf5vPnkV1PIrDX8mkl8W4PJd3JmpAdPB2gcmOxlVVYRljkA5
         kSMl0EUgTcufl4QMDWzqkD+21UTs1aWaYCbIolK8KFxiqR5JkURsADShsMKzl+7xFNzL
         OjzK1RC3J4pNpFvEwinrSGoCkLmZX0ZmhY1RUwzRy18vTbTInF70a/U/LRFc04AI3B6x
         xmwMX2DalQI6E99POzm6e6SdtCVeVZLkC4v1exKjrRM6Fx0B8+4mPtjE64FcSmya6xrh
         ZoEg==
X-Gm-Message-State: AOJu0YxG0FMnThTrY/eKCHhM2cz2ONazB/PzFPipxUM39Li7vqM+a+4Z
	NQ+pZ6pbFMQTgf8+443Su6Pzh3dM5Uq2oaC6xntQFTG71yOgkfEpVLE5UBgbBO4=
X-Google-Smtp-Source: AGHT+IE9k1IE4NvEgmyARUYqW6sSWPhq9qE0pwTvps/Wd17av1qfnT2YG5yGFlQJgp3wvc3ng0HGjg==
X-Received: by 2002:a05:6a21:3403:b0:19c:86f3:e3f2 with SMTP id yn3-20020a056a21340300b0019c86f3e3f2mr247121pzb.21.1706232243119;
        Thu, 25 Jan 2024 17:24:03 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id j12-20020a056a00234c00b006d9b35b2602sm155187pfj.3.2024.01.25.17.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:24:02 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v6 3/4] netdevsim: add selftest for forwarding skb between connected ports
Date: Thu, 25 Jan 2024 17:23:56 -0800
Message-Id: <20240126012357.535494-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240126012357.535494-1-dw@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..4fdb43fec044
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,124 @@
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
+echo "$NSIM_DEV_1_NETNSID $NSIM_DEV_1_IFIDX $NSIM_DEV_2_NETNSID 20" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_NETNSID $NSIM_DEV_1_IFIDX 20 $NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netnsid should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_NETNSID $NSIM_DEV_1_IFIDX $NSIM_DEV_2_NETNSID $NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 with netdevsim2 should succeed"
+	exit 1
+fi
+
+# argument error checking
+
+echo "$NSIM_DEV_1_NETNSID $NSIM_DEV_1_IFIDX $NSIM_DEV_2_NETNSID a" > $NSIM_DEV_SYS_LINK 2>/dev/null
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


