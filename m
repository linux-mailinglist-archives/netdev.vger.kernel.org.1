Return-Path: <netdev+bounces-175861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C283AA67CC3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D50164EBC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5A2144BA;
	Tue, 18 Mar 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="u2Gkqddy"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48091214233;
	Tue, 18 Mar 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324821; cv=pass; b=qzRWO479A0TdqWhIVvicS1H+q/ZDY+KPBQTBQ7N5PT/4A6+nyhlYSHumqESqoZgxkVwfMEPWX14MrOMMfqw/rXSbW3p+yOlnfsvoIIbyBcwRjsj14+skJvSRTH58ElCrVh/jjMJ7umy0yCXhYUBfl8yQHvPtVNgp3cwUWgmjNAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324821; c=relaxed/simple;
	bh=n1QSrIBWMfQwnITPFOpkIogERBaaJLsqB+NW3mjqhss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIJ83K+lvfziHZWyv6bDbCpZZJ+RNmyZaZHFJiGnSIRhwv1/r/r3k12aItP7i44fQzjjyCtrfH210kUW5fXOg4Acntgjf4BYVGKJKF4OVLa8nR+maT3lb7GliJlIvRvPyB+/c9ruAwQ+k8SyAD6SFwL50Vdp1tbMnLmEREutKK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=u2Gkqddy; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHLtM0K4Kz49PyD;
	Tue, 18 Mar 2025 21:06:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742324812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HFebrYrMFr7ev38Y7ujtdui6zWTbqO0IUVOh+45Kyys=;
	b=u2GkqddykrTt+/X1IGQXEogaDBg2GqZohdIL4wJz3S0TvTipTBpDBjeqLJB3fVl6IHBE7M
	ZnsPN2QCy4LkmJC33CpoNskrCTvYgwzYtkosS7cmNchDiKbW0wMgHw900saBn+lUYlMXJ3
	6hjnJA+GBhaLEOLo2XLxbdboLP3RcXJneLNqSvnPfY+PZ6U/NRd41ZwV3KFOsl5EqlCbPj
	RWR5R4aLXHpfz8qgpw8m6su6HV/sHW15Bx1hIsO+Ax3OjZIjToZHiyT/zi0FKlw9fFzV9u
	N3omw9uIt+t+bnBNtBBOu/eHwCZe2VIRCnksRHGcX6q6wlVBC+DtShX4kFbCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742324812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HFebrYrMFr7ev38Y7ujtdui6zWTbqO0IUVOh+45Kyys=;
	b=RoZDhmfYlIMoB/IHlamLTB3fSLzUIIpF6283RPRoe7VzdYvYBqS7oZZfaTPI5DqozbT23n
	FcQAe5GBwfiRcme/LJJjuseOpYblUB48gOO3X0Jec2rvdilwTbKvYmVrb6iYfsqZADvpf+
	QKFS19EZWlXhy7VJtIPYCa3PbUtPbtxov0SHy/kM+d+cHEzSWgRojn1Bykgw198Ww5RfHz
	/EQBM3ydcQvBbaRnGpB6bKEEFKJmWrLsXbfPkKFYyzCVlTMUEtkIGPB/7UWJbxNMM9izfD
	Kw0molREoyJAt34YmXT7cxOF7Ghjcox8sHykJ2vv45nSqjt32IMT6Xr5yo7y5g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742324812; a=rsa-sha256;
	cv=none;
	b=DexcBlxSUgAqmp8blJ+4KI+AFA90A4bHzvmGgtwCpgq2y4MTJZbJyIyRjMu0udmtk5Ks8S
	Tm5C8AUvDTlyq71gIv2nJUiP5Q+0bvwnx4gfcVumTPAqyTD3ZGoXjZLmJM1e/h5bnr01fM
	X782IBVU++lvi8xazR+aipu3YEE1z4v0FOi/u++NZvI3u1g10wW7zcttZMN/Lbi6aSth9l
	RY4FqPp9vxv0PTsd0MiIwxn37G9Kxv5elXY+zSuDUUk2dQJiC5D28t78Vy4A2G5/+Jd4vA
	e4Bzh7A1vbuIIAKjPUZqP+t1I8oLImo9pu4o2mC5dX5X9OaygdesyOu8CU1fRw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH v5 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
Date: Tue, 18 Mar 2025 21:06:41 +0200
Message-ID: <cover.1742324341.git.pav@iki.fi>
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
https://lore.kernel.org/linux-bluetooth/cover.1739988644.git.pav@iki.fi/
https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@iki.fi/
https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch/
https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/

Changes
=======
v5:
- Revert to v3 vs decoupled SND & COMPLETION, just use the bit in tx_flags.
- Add hci_sockcm_init() and use it.
- Emit COMPLETION also for SCO if flowctl enabled, now that we enable it
  for some HW (most HW doesn't seem to support it)

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
  Bluetooth: SCO: add TX timestamping

 Documentation/networking/timestamping.rst |   8 ++
 include/linux/skbuff.h                    |   7 +-
 include/net/bluetooth/bluetooth.h         |   1 +
 include/net/bluetooth/hci_core.h          |  20 ++++
 include/net/bluetooth/l2cap.h             |   3 +-
 include/uapi/linux/errqueue.h             |   1 +
 include/uapi/linux/net_tstamp.h           |   6 +-
 net/bluetooth/6lowpan.c                   |   2 +-
 net/bluetooth/hci_conn.c                  | 122 ++++++++++++++++++++++
 net/bluetooth/hci_core.c                  |  15 ++-
 net/bluetooth/hci_event.c                 |   4 +
 net/bluetooth/iso.c                       |  24 ++++-
 net/bluetooth/l2cap_core.c                |  41 +++++++-
 net/bluetooth/l2cap_sock.c                |  15 ++-
 net/bluetooth/sco.c                       |  19 +++-
 net/bluetooth/smp.c                       |   2 +-
 net/core/skbuff.c                         |   2 +
 net/ethtool/common.c                      |   1 +
 net/socket.c                              |   3 +
 19 files changed, 274 insertions(+), 22 deletions(-)

-- 
2.48.1


