Return-Path: <netdev+bounces-127165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD6974716
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF5828941E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16A8B665;
	Wed, 11 Sep 2024 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxd6cXPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214C161
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012923; cv=none; b=tRHq7ABMVeCTToR3LzMQRIjHdTcv5uCdhXl8bkCKgVXZ5sQgon0rErZVlto1pFFA5DyfWV5lChsVQCWh/YvYQT3LOMIrZIF654+tEp7NnB5nZpCf72vIxt8wG7Wkcr9hwxWzejPq2mrsXbN9pMzfmKTc9IVy8V388oIpcDFVcxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012923; c=relaxed/simple;
	bh=Xm00tEhUNWo8CSp1uYRU4HUkC1BUabSNKDiIRe/4KjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju9fKlwUb78veCE6uiPzVib+dvuq5X3veEm1vkeMztSzSNFLYbj7g/9bqEXi23gRn7t/hbOBTJWEECvcUO/QGLqjzxHyKh1Ts0qi3MSxilhB5e60rpyEXyVbsEbiSAjYxR7Zt4bMlcz64Phj56nT4e+J/gtPie6L/42uCiZ7IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxd6cXPE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99fdf2e1aso371287185a.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726012920; x=1726617720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IftJtVcdKRxWHeKjG7UTaFvvgLJrjlZsNRH8PMZgGT0=;
        b=Dxd6cXPERgHfZL0Hq911gW+ijvihcYDIjyqX5C4IhDeYCmhupJXdRnxsEOY2hoO2oy
         pN6KOs7AqQLR82KFJWWqdJOQCBkR4zjfuPTUlErLVbhu39ZGQaLo1QpubLsa9tqMiJym
         bS+07tmt6cvHAlK+7NugaRUdaSTJkmrNpJv13xyZftmWUf8IK11LWb3twa4oeeyheure
         8n4P2IxXtOfajL/WNmERCiz36UBH2m6/zgtY6OHGaVdL3tK4JewHf1R3mfahC9ZmipXU
         i9CH1xWPF7nEHe+jXLP6tvcoYFcfEGYcJ9vbes5FmrzMMRKN5VLpIMUd8Tb68cRMEuHd
         ghIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726012920; x=1726617720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IftJtVcdKRxWHeKjG7UTaFvvgLJrjlZsNRH8PMZgGT0=;
        b=ufrUPeCKnSr55xhr0pcDoa2Bfk4dYTa/Ae788aMJwXEoCz+HU5DlIf82xoO2I/kLf5
         KdKmfIOK9cSqK4vHhlTIcQTYd/sHyazdGEk6+JiGb5mTOn41PywUB6W/WQnGHQ1DKtIk
         TsScVUg/j84feQTyvyymwBj32YDMSOsY6llzLoMMynHZc7b4pFfFio1WAa1o2ZVwe5X4
         lYCEC2ZNqqguBos1hDj1JXpoE4B0JfzL8S0B2SdfH28QEnUyNyx1veulydHyTMT2+Kre
         KdXR1Sz+HG/5DbaybRaYAyc0Y6Ndpd5cOHuoFjyfsksAPrP/xPlLfZUKcGojgJMHKBmf
         3lYw==
X-Gm-Message-State: AOJu0YwcMHHHJl+LGLM3G9gfiMZ0YCGjIvXzi8OGHflm+j+WIaDM6Q6d
	zY3nqVBAUTf+0Td6hEnH4eC+duw83I/u57tZhmeoCIa9fZi9SCdSaMEkHg==
X-Google-Smtp-Source: AGHT+IHCjWKglhaReRgv6l/MPo1ZIbm5pQI6zSG9LRR0SWQQ828IYb4KJeuShmtO+yWL9z+bO4Hr/w==
X-Received: by 2002:a05:620a:1a86:b0:7a9:babd:effe with SMTP id af79cd13be357-7a9babe61f2mr1348182785a.7.1726012919703;
        Tue, 10 Sep 2024 17:01:59 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1d652sm354705785a.123.2024.09.10.17.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:01:59 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/3] selftests/net: packetdrill: import tcp/zerocopy
Date: Tue, 10 Sep 2024 19:59:58 -0400
Message-ID: <20240911000154.929317-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
References: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Same as initial tests, import verbatim from
github.com/google/packetdrill, aside from:

- update `source ./defaults.sh` path to adjust for flat dir
- add SPDX headers
- remove author statements if any

Also import set_sysctls.py, which many scripts depend on to set
sysctls and then restore them later. This is no longer strictly needed
for namespacified sysctl. But not all sysctls are namespacified, and
doesn't hurt if they are.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../selftests/net/packetdrill/set_sysctls.py  |  38 ++++++
 .../net/packetdrill/tcp_zerocopy_basic.pkt    |  55 ++++++++
 .../net/packetdrill/tcp_zerocopy_batch.pkt    |  41 ++++++
 .../net/packetdrill/tcp_zerocopy_client.pkt   |  31 +++++
 .../net/packetdrill/tcp_zerocopy_closed.pkt   |  45 +++++++
 .../packetdrill/tcp_zerocopy_epoll_edge.pkt   |  61 +++++++++
 .../tcp_zerocopy_epoll_exclusive.pkt          |  63 ++++++++++
 .../tcp_zerocopy_epoll_oneshot.pkt            |  66 ++++++++++
 .../tcp_zerocopy_fastopen-client.pkt          |  56 +++++++++
 .../tcp_zerocopy_fastopen-server.pkt          |  44 +++++++
 .../net/packetdrill/tcp_zerocopy_maxfrags.pkt | 119 ++++++++++++++++++
 .../net/packetdrill/tcp_zerocopy_small.pkt    |  58 +++++++++
 12 files changed, 677 insertions(+)
 create mode 100755 tools/testing/selftests/net/packetdrill/set_sysctls.py
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt

diff --git a/tools/testing/selftests/net/packetdrill/set_sysctls.py b/tools/testing/selftests/net/packetdrill/set_sysctls.py
new file mode 100755
index 0000000000000..5ddf456ae973a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/set_sysctls.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Sets sysctl values and writes a file that restores them.
+
+The arguments are of the form "<proc-file>=<val>" separated by spaces.
+The program first reads the current value of the proc-file and creates
+a shell script named "/tmp/sysctl_restore_${PACKETDRILL_PID}.sh" which
+restores the values when executed. It then sets the new values.
+
+PACKETDRILL_PID is set by packetdrill to the pid of itself, so a .pkt
+file could restore sysctls by running `/tmp/sysctl_restore_${PPID}.sh`
+at the end.
+"""
+
+import os
+import subprocess
+import sys
+
+filename = '/tmp/sysctl_restore_%s.sh' % os.environ['PACKETDRILL_PID']
+
+# Open file for restoring sysctl values
+restore_file = open(filename, 'w')
+print('#!/bin/bash', file=restore_file)
+
+for a in sys.argv[1:]:
+  sysctl = a.split('=')
+  # sysctl[0] contains the proc-file name, sysctl[1] the new value
+
+  # read current value and add restore command to file
+  cur_val = subprocess.check_output(['cat', sysctl[0]], universal_newlines=True)
+  print('echo "%s" > %s' % (cur_val.strip(), sysctl[0]), file=restore_file)
+
+  # set new value
+  cmd = 'echo "%s" > %s' % (sysctl[1], sysctl[0])
+  os.system(cmd)
+
+os.system('chmod u+x %s' % filename)
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
new file mode 100644
index 0000000000000..a82c8899d36bf
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+// basic zerocopy test:
+//
+// send a packet with MSG_ZEROCOPY and receive the notification ID
+// repeat and verify IDs are consecutive
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=1,
+                                    ee_data=1}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
new file mode 100644
index 0000000000000..c01915e7f4a15
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+// batch zerocopy test:
+//
+// send multiple packets, then read one range of all notifications.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_MARK, [666], 4) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=1}}
+                  ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
new file mode 100644
index 0000000000000..a300dbd368a4e
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+// Minimal client-side zerocopy test
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0...0 connect(4, ..., ...) = 0
+
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
+   +0 < S. 0:0(0) ack 1 win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
new file mode 100644
index 0000000000000..572eb2d0d4267
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+// send with MSG_ZEROCOPY on a non-established socket
+//
+// verify that a send in state TCP_CLOSE correctly aborts the zerocopy
+// operation, specifically it does not increment the zerocopy counter.
+//
+// First send on a closed socket and wait for (absent) notification.
+// Then connect and send and verify that notification nr. is zero.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 setsockopt(4, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = -1 EPIPE (Broken pipe)
+
+   +0.1 recvmsg(4, {msg_name(...)=...,
+                    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE,
+                    msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)
+
+   +0...0 connect(4, ..., ...) = 0
+
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 8>
+   +0 < S. 0:0(0) ack 1 win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
new file mode 100644
index 0000000000000..7671c20e01cf6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// epoll zerocopy test:
+//
+// EPOLLERR is known to be not edge-triggered unlike EPOLLIN and EPOLLOUT but
+// it is not level-triggered either.
+//
+// fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
+// is correctly fired only once, when EPOLLET is set. send another packet with
+// MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 epoll_create(1) = 5
+   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4, {events=EPOLLOUT|EPOLLET, fd=4}) = 0
+   +0 epoll_wait(5, {events=EPOLLOUT, fd=4}, 1, 0) = 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+// receive only one EPOLLERR for the two sends above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 8001:12001(4000) ack 1
+   +0 < . 1:1(0) ack 12001 win 257
+
+// receive only one EPOLLERR for the third send above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=2}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
new file mode 100644
index 0000000000000..fadc480fdb7fe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+// epoll zerocopy test:
+//
+// EPOLLERR is known to be not edge-triggered unlike EPOLLIN and EPOLLOUT but
+// it is not level-triggered either. this tests verify that the same behavior is
+// maintained when we have EPOLLEXCLUSIVE.
+//
+// fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
+// is correctly fired only once, when EPOLLET is set. send another packet with
+// MSG_ZEROCOPY. confirm that EPOLLERR is correctly fired again only once.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 epoll_create(1) = 5
+   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4,
+		{events=EPOLLOUT|EPOLLET|EPOLLEXCLUSIVE, fd=4}) = 0
+   +0 epoll_wait(5, {events=EPOLLOUT, fd=4}, 1, 0) = 1
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+// receive only one EPOLLERR for the two sends above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 8001:12001(4000) ack 1
+   +0 < . 1:1(0) ack 12001 win 257
+
+// receive only one EPOLLERR for the third send above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=2}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
new file mode 100644
index 0000000000000..5bfa0d1d2f4a3
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// epoll zerocopy test:
+//
+// This is a test to confirm that EPOLLERR is only fired once for an FD when
+// EPOLLONESHOT is set.
+//
+// fire two sends with MSG_ZEROCOPY and receive the acks. confirm that EPOLLERR
+// is correctly fired only once, when EPOLLONESHOT is set. send another packet
+// with MSG_ZEROCOPY. confirm that EPOLLERR is not fired. Rearm the FD and
+// confirm that EPOLLERR is correctly set.
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 epoll_create(1) = 5
+   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4,
+		{events=EPOLLOUT|EPOLLET|EPOLLONESHOT, fd=4}) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 1:4001(4000) ack 1
+   +0 < . 1:1(0) ack 4001 win 257
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 4001:8001(4000) ack 1
+   +0 < . 1:1(0) ack 8001 win 257
+
+// receive only one EPOLLERR for the two sends above.
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 send(4, ..., 4000, MSG_ZEROCOPY) = 4000
+   +0 > P. 8001:12001(4000) ack 1
+   +0 < . 1:1(0) ack 12001 win 257
+
+// receive no EPOLLERR for the third send above.
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+// rearm the FD and verify the EPOLLERR is fired again.
+   +0 epoll_ctl(5, EPOLL_CTL_MOD, 4, {events=EPOLLOUT|EPOLLONESHOT, fd=4}) = 0
+   +0 epoll_wait(5, {events=EPOLLERR|EPOLLOUT, fd=4}, 1, 0) = 1
+   +0 epoll_wait(5, {events=0, ptr=0}, 1, 0) = 0
+
+   +0 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=2}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
new file mode 100644
index 0000000000000..4a73bbf469610
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// Fastopen client zerocopy test:
+//
+// send data with MSG_FASTOPEN | MSG_ZEROCOPY and verify that the
+// kernel returns the notification ID.
+//
+// Fastopen requires a stored cookie. Create two sockets. The first
+// one will have no data in the initial send. On return 0 the
+// zerocopy notification counter is not incremented. Verify this too.
+
+`./defaults.sh`
+
+// Send a FastOpen request, no cookie yet so no data in SYN
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 sendto(3, ..., 500, MSG_FASTOPEN|MSG_ZEROCOPY, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8,FO,nop,nop>
+ +.01 < S. 123:123(0) ack 1 win 14600 <mss 940,TS val 2000 ecr 1000,sackOK,nop,wscale 6, FO abcd1234,nop,nop>
+   +0 > . 1:1(0) ack 1 <nop,nop,TS val 1001 ecr 2000>
+
+// Read from error queue: no zerocopy notification
+   +1 recvmsg(3, {msg_name(...)=...,
+                    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE,
+                    msg_control=[]}, MSG_ERRQUEUE) = -1 EAGAIN (Resource temporarily unavailable)
+
+ +.01 close(3) = 0
+   +0 > F. 1:1(0) ack 1 <nop,nop,TS val 1002 ecr 2000>
+ +.01 < F. 1:1(0) ack 2 win 92 <nop,nop,TS val 2001 ecr 1002>
+   +0 > .  2:2(0) ack 2 <nop,nop,TS val 1003 ecr 2001>
+
+// Send another Fastopen request, now SYN will have data
+ +.07 `sysctl -q net.ipv4.tcp_timestamps=0`
+  +.1 socket(..., SOCK_STREAM, IPPROTO_TCP) = 5
+   +0 fcntl(5, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 setsockopt(5, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 sendto(5, ..., 500, MSG_FASTOPEN|MSG_ZEROCOPY, ..., ...) = 500
+   +0 > S 0:500(500) <mss 1460,nop,nop,sackOK,nop,wscale 8,FO abcd1234,nop,nop>
+ +.05 < S. 5678:5678(0) ack 501 win 14600 <mss 1460,nop,nop,sackOK,nop,wscale 6>
+   +0 > . 501:501(0) ack 1
+
+// Read from error queue: now has first zerocopy notification
+   +0.5 recvmsg(5, {msg_name(...)=...,
+                    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE,
+                    msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
new file mode 100644
index 0000000000000..36086c5877ce7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+// Fastopen server zerocopy test:
+//
+// send data with MSG_FASTOPEN | MSG_ZEROCOPY and verify that the
+// kernel returns the notification ID.
+
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x207`
+
+// Set up a TFO server listening socket.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+  +.1 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+   +0 setsockopt(3, SOL_TCP, TCP_FASTOPEN, [2], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+
+// Client sends a SYN with data.
+  +.1 < S 0:1000(1000) win 32792 <mss 1460,sackOK,nop,nop>
+   +0 > S. 0:0(0) ack 1001 <mss 1460,nop,nop,sackOK>
+
+// Server accepts and replies with data.
++.005 accept(3, ..., ...) = 4
+   +0 read(4, ..., 1024) = 1000
+   +0 sendto(4, ..., 1000, MSG_ZEROCOPY, ..., ...) = 1000
+   +0 > P. 1:1001(1000) ack 1001
+ +.05 < . 1001:1001(0) ack 1001 win 32792
+
+// Read from error queue: now has first zerocopy notification
+  +0.1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                      {cmsg_level=CMSG_LEVEL_IP,
+                       cmsg_type=CMSG_TYPE_RECVERR,
+                       cmsg_data={ee_errno=0,
+                                  ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                  ee_type=0,
+                                  ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                  ee_info=0,
+                                  ee_data=0}}
+                  ]}, MSG_ERRQUEUE) = 0
+
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
new file mode 100644
index 0000000000000..8b00ae2cd1154
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+// tcp_MAX_SKB_FRAGS test
+//
+// Verify that sending an iovec of tcp_MAX_SKB_FRAGS + 1 elements will
+// 1) fit in a single packet without zerocopy
+// 2) spill over into a second packet with zerocopy,
+//    because each iovec element becomes a frag
+// 3) the PSH bit is set on an skb when it runs out of fragments
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+
+   // Each pinned zerocopy page is fully accounted to skb->truesize.
+   // This test generates a worst case packet with each frag storing
+   // one byte, but increasing truesize with a page (64KB on PPC).
+   +0 setsockopt(3, SOL_SOCKET, SO_SNDBUF, [2000000], 4) = 0
+
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   // send an iov of 18 elements: just becomes a linear skb
+   +0 sendmsg(4, {msg_name(...)=...,
+		  msg_iov(18)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}],
+		  msg_flags=0}, 0) = 18
+
+   +0 > P. 1:19(18) ack 1
+   +0 < . 1:1(0) ack 19 win 257
+
+   // send a zerocopy iov of 18 elements:
+   +1 sendmsg(4, {msg_name(...)=...,
+		  msg_iov(18)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}],
+		  msg_flags=0}, MSG_ZEROCOPY) = 18
+
+   // verify that it is split in one skb of 17 frags + 1 of 1 frag
+   // verify that both have the PSH bit set
+   +0 > P. 19:36(17) ack 1
+   +0 < . 1:1(0) ack 36 win 257
+
+   +0 > P. 36:37(1) ack 1
+   +0 < . 1:1(0) ack 37 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
+   // send a zerocopy iov of 64 elements:
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(64)=[{..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1},
+			       {..., 1}, {..., 1}, {..., 1}, {..., 1}],
+                  msg_flags=0}, MSG_ZEROCOPY) = 64
+
+   // verify that it is split in skbs with 17 frags
+   +0 > P. 37:54(17) ack 1
+   +0 < . 1:1(0) ack 54 win 257
+
+   +0 > P. 54:71(17) ack 1
+   +0 < . 1:1(0) ack 71 win 257
+
+   +0 > P. 71:88(17) ack 1
+   +0 < . 1:1(0) ack 88 win 257
+
+   +0 > P. 88:101(13) ack 1
+   +0 < . 1:1(0) ack 101 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=1,
+                                    ee_data=1}}
+                   ]}, MSG_ERRQUEUE) = 0
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
new file mode 100644
index 0000000000000..a9215982822a9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+// small packet zerocopy test:
+//
+// verify that SO_EE_CODE_ZEROCOPY_COPIED is set on zerocopy
+// packets of all sizes, including the smallest payload, 1B.
+
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_ZEROCOPY, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+   // send 1B
+   +0 send(4, ..., 1, MSG_ZEROCOPY) = 1
+   +0 > P. 1:2(1) ack 1
+   +0 < . 1:1(0) ack 2 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=0,
+                                    ee_data=0}}
+                   ]}, MSG_ERRQUEUE) = 0
+
+   // send 1B again
+   +0 send(4, ..., 1, MSG_ZEROCOPY) = 1
+   +0 > P. 2:3(1) ack 1
+   +0 < . 1:1(0) ack 3 win 257
+
+   +1 recvmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{...,0}],
+                  msg_flags=MSG_ERRQUEUE,
+                  msg_control=[
+                        {cmsg_level=CMSG_LEVEL_IP,
+                         cmsg_type=CMSG_TYPE_RECVERR,
+                         cmsg_data={ee_errno=0,
+                                    ee_origin=SO_EE_ORIGIN_ZEROCOPY,
+                                    ee_type=0,
+                                    ee_code=SO_EE_CODE_ZEROCOPY_COPIED,
+                                    ee_info=1,
+                                    ee_data=1}}
+                   ]}, MSG_ERRQUEUE) = 0
+
-- 
2.46.0.598.g6f2099f65c-goog


