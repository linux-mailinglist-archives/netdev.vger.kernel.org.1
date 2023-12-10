Return-Path: <netdev+bounces-55584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FB80B843
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 02:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47C7280F55
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413E417E1;
	Sun, 10 Dec 2023 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="qgZWE3IU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1F114
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 17:04:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d0538d9bbcso30474795ad.3
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 17:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702170295; x=1702775095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rluyofcHo6kIZ2AnpUIUhpo/4gKMCAzt00LUTIVlWKI=;
        b=qgZWE3IU4Y2+uMlKxc4Nd0bXbLKOpPXo1067eZb/ygOF/P36sNfxChEI7/CVzYVx2M
         eql6BVD2QptVEq6uGzKg+Rwj9OGyAwYzGNR7ABc4Li5SQafmqSgUVvzU468xKAjBGTIM
         1P09wQCZ/chfpxjfb5owyBWnqp0zSnCMVRlubxYlm0KvCYIlXwLUEQK3u2/3vqakgXRf
         /H1PykOFtEalrxJy/7avyXCB48Bhbo/FAJ4Ko5GAebiVnxUnDRcbATbtVeEXmkulevu8
         rH1NF2vOzXzB2l6INSlUGvNvj/FiJsgPj9TM0tNJu5ClEeYRHi+6GQGbpK2RzTawgLUE
         L8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702170295; x=1702775095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rluyofcHo6kIZ2AnpUIUhpo/4gKMCAzt00LUTIVlWKI=;
        b=ULjYpY7ryxsSTR0vD9U/3L4oQwpy7kuImiGGYnhU6yVNEL5bFMxJZrR63MEa7Rhlvm
         N4sNJ2Cg5Efm31fIzTQyhIJm6JdA6r8F5run7OPmYe8AZfMEUf/Ylmi9vy1DyifU7cIx
         E4PZLzJimgMxFxNWbf2dxXbxgjq2f7UNannYdcvI/q/7PATGN84Ic6HD8OKHXT0pIvXg
         U0UhtWumAHcevJvv/W47vPxrO9XWJ2HN3MCJ8vsTDdnP0icIVnkF3RiPKp7/2YdVWzvw
         8tXYetLYZ19XTQe92MQqfX7b5JfupLss81quZa7Y8FGpvtw4sSsaQ5IYUgQI36cqWzG8
         ZTwA==
X-Gm-Message-State: AOJu0YwmrHms4MJhxk/zYEGPI8GNuQ8DL+djE0CXgifoKvvZmGS3MCfb
	co6N4l1YtC1QmxOAIss7eOXLKg==
X-Google-Smtp-Source: AGHT+IHRcWlNOY09ivtcSeKfsCMrJd0DVreRBiguZd34Kq6tvPvdnx+lkQMgynO+YBGnjDFX3wgkqg==
X-Received: by 2002:a17:902:7c03:b0:1d0:8554:5dd5 with SMTP id x3-20020a1709027c0300b001d085545dd5mr2202176pll.37.1702170295707;
        Sat, 09 Dec 2023 17:04:55 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902b18f00b001cf6783fd41sm3954886plr.17.2023.12.09.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 17:04:55 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 3/3] netdevsim: add selftest for forwarding skb between connected ports
Date: Sat,  9 Dec 2023 17:04:48 -0800
Message-Id: <20231210010448.816126-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231210010448.816126-1-dw@davidwei.uk>
References: <20231210010448.816126-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

Connect two netdevsim ports in different namespaces together, then send
packets between them using socat.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/netdevsim/peer.sh   | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
new file mode 100755
index 000000000000..d1d59a932174
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+NSIM_DEV_SYS=/sys/bus/netdevsim
+NSIM_DEV_DFS=/sys/kernel/debug/netdevsim/netdevsim
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
+	ip link set eni1np1 netns nssv
+	ip link set eni2np1 netns nscl
+
+	ip netns exec nssv ip addr add '192.168.1.1/24' dev eni1np1
+	ip netns exec nscl ip addr add '192.168.1.2/24' dev eni2np1
+
+	ip netns exec nssv ip link set dev eni1np1 up
+	ip netns exec nscl ip link set dev eni2np1 up
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
+echo 1 > ${NSIM_DEV_SYS}/new_device
+
+echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	exit 1
+fi
+
+echo 2 > /sys/bus/netdevsim/new_device
+
+echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/peer
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 port0 with netdevsim2 port0 should succeed"
+	exit 1
+fi
+
+# argument error checking
+
+echo "2 1" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent port in a netdevsim should fail"
+	exit 1
+fi
+
+echo "1 0" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with self should fail"
+	exit 1
+fi
+
+echo "2 a" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	exit 1
+fi
+
+# send/recv packets
+
+socat_check || exit 1
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
+echo 2 > ${NSIM_DEV_SYS}/del_device
+
+kill $pid
+echo 1 > ${NSIM_DEV_SYS}/del_device
+
+cleanup_ns
+
+modprobe -r netdevsim
+
+exit 0
-- 
2.39.3


