Return-Path: <netdev+bounces-60435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A742981F3EF
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAFD283FEA
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92466110B;
	Thu, 28 Dec 2023 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="REh6A+Ca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9A1FAA
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28beb1d946fso4608634a91.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703728000; x=1704332800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0RSkXs7li8lnvkzU5r8iNz4kfcZb38Ob07KAbBW2h4=;
        b=REh6A+CaZfHGEqlP/6u9Q+M+U4F7q0SgX+78jo+L0DWmRR/iQP7XfXAKRkcwYuVr9s
         0Lg6DIP+W2KYiZe33kxi1Qjt2D8p8IDfCqidN2p0nYeu1OuYEahxkFUIkAwNg5i1zxpL
         Yu7mXw77lzMMxECw43vT4hwt5oucUYcgvJa7xeiD6V574g4lnQRneLsc12zM98SZuylZ
         7LRMr9CDLul25vzE4qRz4EdEGindt/MGIVdJM/xh//kh5WtRnbkupWfSf42+yF6fYRQO
         f/PciuPw2pvYRHHhk8R5r4tjI7H4NpknhkNxGL+IgdKYrgtvAc5GmYRwzU2ADcJzynfX
         dinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703728000; x=1704332800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0RSkXs7li8lnvkzU5r8iNz4kfcZb38Ob07KAbBW2h4=;
        b=Hb9OrVVq9W5HbnWw1/LrdapPggXuLsKry6b9aqNsNcOI1KQrj+DWRDYB5pVuvnT+cu
         1AejSD2K/j7SLlQDUHnD4NNikOSFXwGnf+TAc6eNRzAJQMkBV+HNsUhjMUwh7KG7nEBI
         r7M6nZKT5mk6jzIo0eGanqwpEyvMKckNQpwmEo74jYOpZJ8x8zvg5F6vYOF4wgwfdhE4
         zUpeXwFD7lBgEbW1+He9end/F8+UNmMizmNyh3ykmXIyKbSAUbpQOthHMVZ0XfXuJnre
         zgmAiWYonX3fbWC60Hnpzu4bHEOh8xvTdoEdvM5qxF4atyBAdM77FgO+Z7U9Pa8O/EUp
         6XpQ==
X-Gm-Message-State: AOJu0YxVtfdQSUAyUT0iREDRBCKDOLKebf8n1ln2+CteSD8l/j4hL4NF
	QNi8LCHtC4ejFQeRbGynvLi2/n/0ZO3JQg==
X-Google-Smtp-Source: AGHT+IGNmlb/hRtCzZrqmDGNddn0b2sG830VPHvMqXJQisK30qOMU8uIGq9dyFqFU0+rw17E6qKNJg==
X-Received: by 2002:a17:90a:d243:b0:28b:ecdf:3267 with SMTP id o3-20020a17090ad24300b0028becdf3267mr4470803pjw.85.1703728000559;
        Wed, 27 Dec 2023 17:46:40 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id o23-20020a17090aac1700b0028c361b5c7csm8788341pjq.23.2023.12.27.17.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:46:40 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 4/5] netdevsim: add selftest for forwarding skb between connected ports
Date: Wed, 27 Dec 2023 17:46:32 -0800
Message-Id: <20231228014633.3256862-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231228014633.3256862-1-dw@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
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
index 000000000000..f123e6b7cd2f
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


