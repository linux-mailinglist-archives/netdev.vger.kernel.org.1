Return-Path: <netdev+bounces-167814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C7BA3C71B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C591887DBB
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E6214A64;
	Wed, 19 Feb 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="RFZU5qVH"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1041A7264;
	Wed, 19 Feb 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988836; cv=pass; b=FwOTDlBfRaliUSr1rrVMq3bjm1bDCajAZQ+77dyigKaXOOy+sQbe6ESQoHK7O3B+a2QilrbVCKEGpdbY1kMTWnHHrhz3qTBc18UjuPVkfnsBJeNZvcAAFVqrTDU+FP+fwwEWiuog/t6mdzOoa9OH+wdukA24Ti7nyHsiZd2JzXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988836; c=relaxed/simple;
	bh=H3WFiZ6Lg19AdQqBFHLqhRqZsA/ZRyzUZwtPyPfU6BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EU/uTO+wkX3QCKxRahvIBtY37bWg1/0vGHWMHZnTFypvvW2YsCc5A4oKQkI0CNFr6EFB9EPIuHviq60DDfVTaH9LUyuJN8cul3NE/mDQemYOveR+SVgzgksyy474TlhgofjJD34wO0UjZSitaXxDQznUulOQHM3ncHn9paeeDp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=RFZU5qVH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4YykzW3cCvzyQQ;
	Wed, 19 Feb 2025 20:13:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1739988826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hOkm928FH1MXpDJcxJZjAaAV4tVx2mcqhCypx8RXFKo=;
	b=RFZU5qVHVP7l6n//421bwYECDfZx7wSxoigACfkpE7YUWchicIImxE82CGnpke1AciWj10
	+qPggQi/TbLADK/2zhfkmT22whWflD57ESu0tZnteOJypH/+ZuKBMbAe8zcpjUz6E1CMSN
	A463+0Anepsi6TqpJyaFXD7RdSyM/Co=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1739988826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hOkm928FH1MXpDJcxJZjAaAV4tVx2mcqhCypx8RXFKo=;
	b=oPUNjtQsW1AFibX6fSlgcigzFZFdXlBGarcDDE7dI2bS0vRRERki0C8wbkOZ5/ERnZ7kKb
	EDOzSapB84e283tnCD1FvyMNPEYJ2lfEBZFrmaHh9Qra2YdOgjUQtcy8pDnBHVEJENN/Rg
	Fnr2GlBN3APsq4segiFDR1dSsQL4d6M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1739988826; a=rsa-sha256; cv=none;
	b=QOvH79VUMMuz8bj+8ZIAE09MBNXRBOmkc90nxaWIoVUwebqVV178TIidCWXRfA6+c47gDk
	Shv7u5U+s6TDrxMGmZIUwFD++0IARIH2X4ykm7YE9m6uzL1wSAJVzvPzhcaScKj/WAIGP9
	sGDnJUPx1FqZF6CJGj1XLX7h9yMKbI8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
Date: Wed, 19 Feb 2025 20:13:32 +0200
Message-ID: <cover.1739988644.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.

Add new COMPLETION timestamp type, to report a software timestamp when
the hardware reports a packet completed. (Cc netdev for this)

Previous discussions:
https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.fi/
https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch/
https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/

Changes
=======
v4:
- Change meaning of SOF_TIMESTAMPING_TX_COMPLETION, to save a bit in
  skb_shared_info.tx_flags:

  It now enables COMPLETION only for packets that also have software SND
  enabled.  The flag can now be enabled only via a socket option, but
  coupling with SND allows user to still choose for which packets
  SND+COMPLETION should be generated.  This choice maybe is OK for
  applications which can skip SND if they're not interested.

  However, this would make the timestamping API not uniform, as the
  other TX flags can be enabled via CMSG.

  IIUC, sizeof skb_shared_info cannot be easily changed and I'm not sure
  there is somewhere else in general skb info, where one could safely
  put the extra separate flag bit for COMPLETION. So here's alternative
  suggestion.

- Better name in sof_timestamping_names

- I decided to keep using sockcm_init(), to avoid open coding READ_ONCE
  and since it's passed to sock_cmsg_send() which anyway also may init
  such fields.

v3:
- Add new COMPLETION timestamp type, and emit it in HCI completion.
- Emit SND instead of SCHED, when sending to driver.
- Do not emit SCHED timestamps.
- Don't safeguard tx_q length explicitly. Now that hci_sched_acl_blk()
  is no more, the scheduler flow control is guaranteed to keep it
  bounded.
- Fix L2CAP stream sockets to use the bytestream timestamp conventions.

Overview
========

The packet flow in Bluetooth is the following. Timestamps added here
indicated:

user sendmsg() generates skbs
|
* skb waits in net/bluetooth queue for a free HW packet slot
|
* orphan skb, send to driver -> TSTAMP_SND
|
* driver: send packet data to transport (eg. USB)
|
* wait for transport completion
|
* driver: transport tx completion, free skb (some do this immediately)
|
* packet waits in HW side queue
|
* HCI report for packet completion -> TSTAMP_COMPLETION (for non-SCO)

In addition, we may want to do the following in future (but not
implemented in this series as we don't have ISO sequence number
synchronization yet which is needed first, moreover e.g. Intel
controllers return only zeros in timestamps):

* if packet is ISO, send HCI LE Read ISO TX Sync
|
* HCI response -> hardware TSTAMP_SND for the packet the response
  corresponds to if it was waiting for one, might not be possible
  to get a tstamp for every packet

Bluetooth does not have tx timestamps in the completion reports from
hardware, and only for ISO packets there are HCI commands in
specification for querying timestamps afterward.

The drivers do not provide ways to get timestamps either, I'm also not
aware if some devices would have vendor-specific commands to get them.

Driver-side timestamps
======================

Generating SND on driver side may be slightly more accurate, but that
requires changing the BT driver API to not orphan skbs first.  In theory
this probably won't cause problems, but it is not done in this patchset.

For some of the drivers it won't gain much. E.g. btusb immediately
submits the URB, so if one would emit SND just before submit (as
drivers/net/usb/usbnet.c does), it is essentially identical to emitting
before sending to driver.  btintel_pcie looks like it does synchronous
send, so looks the same.  hci_serdev has internal queue, iiuc flushing
as fast as data can be transferred, but it shouldn't be waiting for
hardware slots due to HCI flow control.

Unless HW buffers are full, packets mostly wait on the HW side.  E.g.
with btusb (non-SCO) median time from sendmsg() to URB generation is
~0.1 ms, to USB completion ~0.5 ms, and HCI completion report at ~5 ms.

The exception is SCO, for which HCI flow control is disabled, so they do
not get completion events so it's possible to build up queues inside the
driver. For SCO, COMPLETION needs to be generated from driver side, eg.
for btusb maybe at URB completion.  This could be useful for SCO PCM
modes (but which are more or less obsolete nowadays), where USB isoc
data rate matches audio data rate, so queues on USB side may build up.

Use cases
=========

In audio use cases we want to track and avoid queues building up, to
control latency, especially in cases like ISO where the controller has a
fixed schedule that the sending application must match.  E.g.
application can aim to keep 1 packet in HW queue, so it has 2*7.5ms of
slack for being woken up too late.

Applications can use SND & COMPLETION timestamps to track in-kernel and
in-HW packet queues separately.  This can matter for ISO, where the
specification allows HW to use the timings when it gets packets to
determine what packets are synchronized together. Applications can use
SND to track that.

Tests
=====

See
https://lore.kernel.org/linux-bluetooth/cover.1739026302.git.pav@iki.fi/

Pauli Virtanen (5):
  net-timestamp: COMPLETION timestamp on packet tx completion
  Bluetooth: add support for skb TX SND/COMPLETION timestamping
  Bluetooth: ISO: add TX timestamping
  Bluetooth: L2CAP: add TX timestamping
  Bluetooth: SCO: add TX timestamping socket-level mechanism

 Documentation/networking/timestamping.rst |   9 ++
 include/net/bluetooth/bluetooth.h         |   1 +
 include/net/bluetooth/hci_core.h          |  13 +++
 include/net/bluetooth/l2cap.h             |   3 +-
 include/uapi/linux/errqueue.h             |   1 +
 include/uapi/linux/net_tstamp.h           |   6 +-
 net/bluetooth/6lowpan.c                   |   2 +-
 net/bluetooth/hci_conn.c                  | 118 ++++++++++++++++++++++
 net/bluetooth/hci_core.c                  |  17 +++-
 net/bluetooth/hci_event.c                 |   4 +
 net/bluetooth/iso.c                       |  24 ++++-
 net/bluetooth/l2cap_core.c                |  41 +++++++-
 net/bluetooth/l2cap_sock.c                |  15 ++-
 net/bluetooth/sco.c                       |  19 +++-
 net/bluetooth/smp.c                       |   2 +-
 net/core/sock.c                           |   2 +
 net/ethtool/common.c                      |   1 +
 17 files changed, 258 insertions(+), 20 deletions(-)

-- 
2.48.1


