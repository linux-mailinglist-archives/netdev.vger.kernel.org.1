Return-Path: <netdev+bounces-54905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D5808E81
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524641C20AEE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2C49F8D;
	Thu,  7 Dec 2023 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="rBlULXfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F577A3
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 09:21:34 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so826237a12.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1701969694; x=1702574494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ1yns42BwbRaoCcXYx5fKSmGMhxoE4SxiHQAoi05zE=;
        b=rBlULXfAZDA4cP+ZsuWcqcCA/TTlZYZK6F35NT7H9hpViB7u54MU1S6KEaztTUvrOQ
         35+jvCyuaKeLakM8l7WZ/MDfpYBV0ms+Sa+VLgQB0lXguxAD1iZoBifZUlz8BvKV+nAf
         6pDtBQeueqEG1gcQhrF+JMXWO+yR0VOwqsm4oOnMh0PFY7ZjhCMaCwKtlbvERHH6rq/d
         fmnl7ln0j/nKmLfkbZcWw0raBu9cPLVo+LK6yd+x53kZYGq8vlq7s+/mHsZxChJ0Cizw
         21HW9RMpXzBjcNv7Xd9dymJnv1Mr+LVzMQIlsHblXTEm81yjH5ZN5wCmNu8/9374uXg4
         82ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969694; x=1702574494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ1yns42BwbRaoCcXYx5fKSmGMhxoE4SxiHQAoi05zE=;
        b=juCxHBs02W074T9Ut9ZVvQsZ79XOEGoss9tFVdGWzLV7WnfbTAoIVSezH7+709QMa+
         bTXBtW63emZxJEXobR/PxsgwrjccOgUp6VsaliMmRzrCKfLcj7Y2mXiAIT119kt39Nt/
         rNeB//kNWgr1erx47e/qF02ScvEYaNKRiLqzNNg/Q7D8NrtXgQWlSKl7oTOrCLN0u0fx
         w2boXSZowJcTHBL3EJAhZR1WGlkY9TnW9fn36RDJ2wsY3FC1PiE6VSmluXO5dPJLk51a
         Gxlk2fhrV3AviHS3PEIArUY3aUSFFuuxdkc+aJ1LExeC71qT/Meb/nq9a56zB5Z1yaTR
         CUqA==
X-Gm-Message-State: AOJu0YzGn7YG/76WEEEXvFffRF0dXNsSpVLCmcK4/w8yRd/hRi2QnP7w
	Zs7Wpvbh1DGaa8vNtsUlM5lGuQ==
X-Google-Smtp-Source: AGHT+IEWQ1iRLRGdHXFVSXApyc+/TK2vXKPt1GJTRJSZtY3s5R4Eu+eRjPWYfAB5l1o9tCzQ5Ft5fQ==
X-Received: by 2002:a05:6a20:441c:b0:187:9521:92b9 with SMTP id ce28-20020a056a20441c00b00187952192b9mr3095685pzb.53.1701969693735;
        Thu, 07 Dec 2023 09:21:33 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id c7-20020a6566c7000000b005c215baacc1sm7228pgw.70.2023.12.07.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:21:33 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] selftest: netdevsim: add selftest for
Date: Thu,  7 Dec 2023 09:21:17 -0800
Message-Id: <20231207172117.3671183-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231207172117.3671183-1-dw@davidwei.uk>
References: <20231207172117.3671183-1-dw@davidwei.uk>
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
 .../drivers/net/netdevsim/forward.sh          | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/forward.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/forward.sh b/tools/testing/selftests/drivers/net/netdevsim/forward.sh
new file mode 100755
index 000000000000..7464fb42576d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/forward.sh
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
+echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/link 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent netdevsim should fail"
+	return 1
+fi
+
+echo 2 > /sys/bus/netdevsim/new_device
+
+echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/link
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 port0 with netdevsim2 port0 should succeed"
+	return 1
+fi
+
+# argument error checking
+
+echo "2 1" > ${NSIM_DEV_DFS}1/ports/0/link 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "linking with non-existent port in a netdevsim should fail"
+	return 1
+fi
+
+echo "2 a" > ${NSIM_DEV_DFS}1/ports/0/link 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	return 1
+fi
+
+echo "2 0 1" > ${NSIM_DEV_DFS}1/ports/0/link 2>/dev/null
+if [ $? -eq 0 ]; then
+	echo "invalid arg should fail"
+	return 1
+fi
+
+# send/recv packets
+
+socat_check || return 1
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
+	return 1
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


