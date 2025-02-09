Return-Path: <netdev+bounces-164419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D7A2DC8B
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30841885FAC
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19449156230;
	Sun,  9 Feb 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dzpBSrD6"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD80243370;
	Sun,  9 Feb 2025 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097579; cv=pass; b=KIiMX8Bl1RC4zawrfuoOWEI4DXk8EtfYXJGoT2I2vQgvk+UgRh/GfP0BA8Ud14yFiBTEWNz/olxPpK/MNfO+xZoN4boQFKZzSdbKRdncf7SNfiZMZhhWdjjxIHPYZ1N6rusc0rgyBwIuqma3X5IkMIAJWr+jj3icLbTsOkfvMmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097579; c=relaxed/simple;
	bh=H6wKNnTjIhUEF7jSWj/4hL8GFDsRO6mTY4TldXGHnJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNXGYZGGXqiUs+7Qxr04HS+JogBxhMBrLtVbvEpoga4tMZqJd0M4cdZCdKn1hpVTwoBpV8p6vZL4N0ER2zHF6sYpPVrpojmhesp0X3Hy/spzsfypDhNfbmdKwxFSwS4mdTDVwZ7GQvIoj9Q4UdoW4PRvCAfKUlZ6Pky+W31mnTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dzpBSrD6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPMz1kZyz49Q1R;
	Sun,  9 Feb 2025 12:39:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CxCBQczEebSRa4HuQ77EBkx39dklZvIxW1x2Y3WcJn8=;
	b=dzpBSrD6WpCd2TyNLn9ByBtyliBLP+Yy4Zwx2nXgj2B09E+rkxnsdwV0/BtKFt66mPIoAW
	8Pn0jvFyyvtNmZlFY/6cOdE6nxudi6TJdmDriikpb3VHvtkQfXc50zxpma6kKSIyjizV9d
	sFPR2UByL0Rnsw6fzuh3sVwg7K1EixbxA248m1rCO1TmlWeFY7nDFsYwvmsMPW1Irgu3fi
	wVxcI3EPJiCZ5xduzgSR1ZnAH5W5FFZW7yOdRJqPjeq1Wrj/19Jmr6S05XiHVR13hQXFGR
	P/XE++IrTkUC/QGKZymMykK3i5NZyUmcu8YM5ZK9w95GiwrnTWYNHQV4+QC1yw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097569; a=rsa-sha256;
	cv=none;
	b=VpxypeCUltmZcJWKX90D0Ya4acJx9oB/pSrSc5jHofxW/tBwrgTWO+vwvScU9A8fVWFqJ3
	0LFgFvKlBz9w6l7zWFzWnEVXtrKrydTwLqhPh/Su8jGhrMww73uBxJfAsrxTF7JiUKhWv1
	pNJdsPWgmDKptB0KFbPDOL9WxxtNtMy+Ac5UlUfIB9OFcrUKKyioTxGsO5CAi5WIPtouR6
	kfFXbl9QUdRTH5vP8CQcb8JtPuIH3RQqI57n0xzh/c7KCyRYGHYqiMf9mAVKtVeJwshn+M
	4oo/B6zJ8fqrvZPPdVMf04NBgECRtgYOsRZQSnQvqOMpmKbK3cJ+CpI3NrAIrw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CxCBQczEebSRa4HuQ77EBkx39dklZvIxW1x2Y3WcJn8=;
	b=cyFDRs/vD6vCiOvCjIhcCuW1KCNbiZ5c06JgwyZT2KKCrCuj7Jv5M8S/UMrADigp71UrTa
	gM3xjvEsrQCJRwhFOvRkj0XojS2qoVnWvh1UpmqQoKWSbrEtalnieb05yUUrbGdmNsYK5C
	SkuyXbfWyKafLTzK+/syf4q9sEHpn53jIVKwV6RJY9LeuLV+b9NUC1MrRvxoOCH8BIKKOp
	ewtXnhkqRps8DJZUPnLUMCRsmo2GuBPj246BSeqxEBUBJueA4ORjpTYgY+94Ty/wicsvHR
	n/7gyc4rByziXnKX5+MlZkbf4y7/syQLygiUnhl5EhOLOMHyrbBAQQL4XmRf2Q==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v3 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
Date: Sun,  9 Feb 2025 12:39:12 +0200
Message-ID: <cover.1739097311.git.pav@iki.fi>
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

Changes in v3
=============

- Add new COMPLETION timestamp type, and emit it in HCI completion.

- Emit SND instead of SCHED, when sending to driver.

- Do not emit SCHED timestamps.

- Don't safeguard tx_q length explicitly. Now that hci_sched_acl_blk()
  is no more, the scheduler flow control is guaranteed to keep it
  bounded.

- Fix L2CAP stream sockets to use the bytestream timestamp conventions.

Pauli Virtanen (5):
  net-timestamp: COMPLETION timestamp on packet tx completion
  Bluetooth: add support for skb TX SND/COMPLETION timestamping
  Bluetooth: ISO: add TX timestamping
  Bluetooth: L2CAP: add TX timestamping
  Bluetooth: SCO: add TX timestamping socket-level mechanism

 Documentation/networking/timestamping.rst |   9 ++
 include/linux/skbuff.h                    |   6 +-
 include/net/bluetooth/bluetooth.h         |   1 +
 include/net/bluetooth/hci_core.h          |  13 +++
 include/net/bluetooth/l2cap.h             |   3 +-
 include/uapi/linux/errqueue.h             |   1 +
 include/uapi/linux/net_tstamp.h           |   6 +-
 net/bluetooth/6lowpan.c                   |   2 +-
 net/bluetooth/hci_conn.c                  | 117 ++++++++++++++++++++++
 net/bluetooth/hci_core.c                  |  17 +++-
 net/bluetooth/hci_event.c                 |   4 +
 net/bluetooth/iso.c                       |  24 ++++-
 net/bluetooth/l2cap_core.c                |  41 +++++++-
 net/bluetooth/l2cap_sock.c                |  15 ++-
 net/bluetooth/sco.c                       |  19 +++-
 net/bluetooth/smp.c                       |   2 +-
 net/ethtool/common.c                      |   1 +
 net/socket.c                              |   3 +
 18 files changed, 263 insertions(+), 21 deletions(-)

-- 
2.48.1


