Return-Path: <netdev+bounces-210604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60553B14095
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D1F3AF850
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF862750ED;
	Mon, 28 Jul 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b="TTZteMtE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ionic.de (ionic.de [145.239.234.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0452AE97;
	Mon, 28 Jul 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.234.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721148; cv=none; b=mx8wUvCLyvPq0263kFfDE2UrtiYp/pp4Wrv6MJ8cXAj+WR3a2hhEz3MBX85t+X9xTWjGj+SssYDoVaiQP+wV8z98kS++MJNB/nOhYb7PsWOBUcdDjjC82ccbRVpKogbdObGVfmRgCbU7Vemd8I4iPNISQSYucB+WRmgIFq8ek8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721148; c=relaxed/simple;
	bh=FyHwd+MV76b8WmKZ0YSS5V0JlgFRToL1PV/16FUsh8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dz1Av4eQieduG1/xDnW664GzppRSmE2OLXK9VM+z/4UwRTSZ242gf0Y//owiejxeiuwcIAlU4mgH98ngBMFra1RHoccInbGkbiYGrjuvg+YJ0+ZTvwzRW15ZvI5+qN5ITOywIUwtXtdCWKVUV8sD/Y629OHZdJo1UVBhV7T1nSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de; spf=pass smtp.mailfrom=ionic.de; dkim=pass (1024-bit key) header.d=ionic.de header.i=@ionic.de header.b=TTZteMtE; arc=none smtp.client-ip=145.239.234.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ionic.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionic.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
	t=1753721137; bh=FyHwd+MV76b8WmKZ0YSS5V0JlgFRToL1PV/16FUsh8g=;
	h=From:To:Cc:Subject:Date:From;
	b=TTZteMtEYL3sy0IJj3YEmGQwuaQyUtKUiTtoIxgxdLxoI8aBgLbfjBbCJ2rJnRM7z
	 QRxt7a99VKrxAgLgPWr5UpHdY5M3OH8pvywYkB0B0uxRugETC2TCgef+QRN8Y4XCaF
	 dW8RSFneJNkbeqjKFOJygDCzNOMRK9foRAbKJYQs=
Received: from grml.local.home.ionic.de (unknown [IPv6:2a00:11:fb41:7a00:21b:21ff:fe5e:dddc])
	by mail.ionic.de (Postfix) with ESMTPSA id 190C71480967;
	Mon, 28 Jul 2025 18:45:37 +0200 (CEST)
From: Mihai Moldovan <ionic@ionic.de>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 00/11] QRTR Multi-endpoint support
Date: Mon, 28 Jul 2025 18:45:17 +0200
Message-ID: <cover.1753720934.git.ionic@ionic.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am incredibly thankful for Denis's work on this. To get this back on
track and to eventually get it merged, with his permission, I'm
resubmitting his patch set with issues in the previous review rounds
resolved. This feature is a prerequisite for my work on ath1{1,2}k to
allow using multiple devices in one computer.

The original description follows:

The current implementation of QRTR assumes that each entity on the QRTR
IPC bus is uniquely identifiable by its node/port combination, with
node/port combinations being used to route messages between entities.

However, this assumption of uniqueness is problematic in scenarios
where multiple devices with the same node/port combinations are
connected to the system.  A practical example is a typical consumer PC
with multiple PCIe-based devices, such as WiFi cards or 5G modems, where
each device could potentially have the same node identifier set.  In
such cases, the current QRTR protocol implementation does not provide a
mechanism to differentiate between these devices, making it impossible
to support communication with multiple identical devices.

This patch series addresses this limitation by introducing support for
a concept of an 'endpoint.' Multiple devices with conflicting node/port
combinations can be supported by assigning a unique endpoint identifier
to each one.  Such endpoint identifiers can then be used to distinguish
between devices while sending and receiving messages over QRTR sockets.

The patch series maintains backward compatibility with existing clients:
the endpoint concept is added using auxiliary data that can be added to
recvmsg and sendmsg system calls.  The QRTR socket interface is extended
as follows:

- Adds QRTR_ENDPOINT auxiliary data element that reports which endpoint
  generated a particular message.  This auxiliary data is only reported
  if the socket was explicitly opted in using setsockopt, enabling the
  QRTR_REPORT_ENDPOINT socket option.  SOL_QRTR socket level was added
  to facilitate this.  This requires QRTR clients to be updated to use
  recvmsg instead of the more typical recvfrom() or recv() use.

- Similarly, QRTR_ENDPOINT auxiliary data element can be included in
  sendmsg() requests.  This will allow clients to route QRTR messages
  to the desired endpoint, even in cases of node/port conflict between
  multiple endpoints.

- Finally, QRTR_BIND_ENDPOINT socket option is introduced.  This allows
  clients to bind to a particular endpoint (such as a 5G PCIe modem) if
  they're only interested in receiving or sending messages to this
  device.

v4:
  - fixed issues found in previous review round:
    o lock without unlock
    o wrong return value
  - Link to v3: https://msgid.link/cover.1753312999.git.ionic@ionic.de

v3:
  - rebased against current master
  - fix checkpatch.pl warnings
  - fix overflow issues with unsigned long radix tree keys by using the
    upper half of the storage space for one element and the lower half
    of storage for the other element, making sure that the elements fit
    into their respective storage space
  - Link to v2: https://msgid.link/cover.1752947108.git.ionic@ionic.de

v2:
  - rebased against current master
  - fixed most issues found in first review round (see individual
    commits), minus the 32-bit long
    unsafe use
  - Link to v1: https://msgid.link/20241018181842.1368394-1-denkenz@gmail.com

Denis Kenzior (10):
  net: qrtr: ns: validate msglen before ctrl_pkt use
  net: qrtr: allocate and track endpoint ids
  net: qrtr: support identical node ids
  net: qrtr: Report sender endpoint in aux data
  net: qrtr: Report endpoint for locally generated messages
  net: qrtr: Allow sendmsg to target an endpoint
  net: qrtr: allow socket endpoint binding
  net: qrtr: Drop remote {NEW|DEL}_LOOKUP messages
  net: qrtr: ns: support multiple endpoints
  net: qrtr: mhi: Report endpoint id in sysfs

Mihai Moldovan (1):
  net: qrtr: fit node ID + port number combination into unsigned long

 include/linux/socket.h    |   1 +
 include/uapi/linux/qrtr.h |   7 +
 net/qrtr/af_qrtr.c        | 405 ++++++++++++++++++++++++++++++++------
 net/qrtr/mhi.c            |  14 ++
 net/qrtr/ns.c             | 299 +++++++++++++++++-----------
 net/qrtr/qrtr.h           |   4 +
 6 files changed, 548 insertions(+), 182 deletions(-)

-- 
2.50.0


