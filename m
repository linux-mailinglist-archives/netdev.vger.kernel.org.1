Return-Path: <netdev+bounces-57668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550BF813C8E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB75B20D68
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693776D1CF;
	Thu, 14 Dec 2023 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="y0KFBQhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467268B9A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d35569b8c6so14325585ad.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702589095; x=1703193895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhP0/KeAkEXkYbNZIC9cYiWhoMF1Ptz+Mj0ZXLXOzVQ=;
        b=y0KFBQhlxNF3FnerE1gi9SHKzQgLLwxFtUd2JuKE53IXwR8srIRj88GdlKaPQ29+Ls
         37D0w3u6T3YsZxPqp3Lt99wH20xnnTLUAZStioIsBSX7Tg9q/tzssZDVUDfgowJLejEu
         rjCX1p3OJ/ow5+bQtdPymUv5ZuT95q3WJKbVzuLnHMYmsOu7M+/wrXJY+ZhETJa05uLx
         038U/kwEJWiELQTDCc3diK40+jbCOP/Gh8kQni9gzfEe8NQGIOPk5N9ZHF2/mV0KovET
         fdHkE1knGVqQTHfrqNJzYKhOQWlA6ATW0mQkMGbWbWgApezil724GNZWxV7r2kRgkWMc
         79Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589095; x=1703193895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhP0/KeAkEXkYbNZIC9cYiWhoMF1Ptz+Mj0ZXLXOzVQ=;
        b=DkZsZ3rm5YQp9uiD1aMQGVUjapPWMybmmeB860Ij/WF/iXMwgGR0g696PRO/Vi5XFF
         ryYblViEP8vRHFjgpPHrIMEdPZ+ToTHSLNLsEDeAx/dQOt9h3xefKwD6W8zMVWT8CQuy
         EkUEC181ZpADF5S82SlZ9qbF11XF/uoRUBKR7xH5LkUpUni1NkoJv2Izce4vftntTb0+
         5lUdMh3E7RVcCL6ZHalN+ppwJ466GHz7Ej3gfIykAyf3bisUSXLzy1bGF/mpVu2+bE8v
         GPlfwQ3mvujUDYe6ez0AY4h6EwHm1uk/9KXnrW4gK+O3xDraaxfB2sHGsibsMuH89Y9a
         nQug==
X-Gm-Message-State: AOJu0YxKb5Na6CcabfawKfPNK2k+3bFYuTV349Kb3n6QGkiqW57dSwux
	DwXpMWcRKi0MsZnyZqtMXYHiWw==
X-Google-Smtp-Source: AGHT+IFB+lAYzXehEFCIH0SbCX1pzt8YnQ86sRciI2rf0ZS5uc5FLCoQnBPqpzRA008ks9hO77CZrQ==
X-Received: by 2002:a17:902:784a:b0:1d0:4778:fb3f with SMTP id e10-20020a170902784a00b001d04778fb3fmr4902602pln.32.1702589095684;
        Thu, 14 Dec 2023 13:24:55 -0800 (PST)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001d35e9471absm2603219plj.195.2023.12.14.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:24:55 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 3/4] netdevsim: add selftest for forwarding skb between connected ports
Date: Thu, 14 Dec 2023 13:24:42 -0800
Message-Id: <20231214212443.3638210-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214212443.3638210-1-dw@davidwei.uk>
References: <20231214212443.3638210-1-dw@davidwei.uk>
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
 .../selftests/drivers/net/netdevsim/peer.sh   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..942526640d59
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,123 @@
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
+
+echo "$NSIM_DEV_2_ID 0" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	exit 1
+fi
+
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
+
+echo "$NSIM_DEV_2_ID 0" > ${NSIM_DEV_1_DFS}/ports/0/peer
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 port0 with netdevsim2 port0 should succeed"
+	exit 1
+fi
+
+# argument error checking
+
+echo "$NSIM_DEV_2_ID 1" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent port in a netdevsim should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_ID 0" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with self should fail"
+	exit 1
+fi
+
+echo "$NSIM_DEV_2_ID a" > ${NSIM_DEV_1_DFS}/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	exit 1
+fi
+
+# send/recv packets
+
+socat_check || exit 4
+
+setup_ns
+
+tmp_file=$(mktemp)
+ip netns exec nssv socat TCP-LISTEN:1234,fork $tmp_file &
+pid=$!
+
+echo "HI" | ip netns exec nscl socat STDIN TCP:192.168.1.1:1234
+
+count=$(cat $tmp_file | wc -c)
+if [[ $count -ne 3 ]]; then
+	echo "expected 3 bytes, got $count"
+	exit 1
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
+exit 0
-- 
2.39.3


