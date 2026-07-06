Return-Path: <netdev+bounces-305101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I7A2NRvHS2ppaAEAu9opvQ
	(envelope-from <netdev+bounces-305101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:17:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D07712780
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=robTeF0H;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305101-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305101-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A4AB31AEBC2
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E915388360;
	Mon,  6 Jul 2026 14:52:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F943A7820
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 14:52:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349564; cv=none; b=AnbIhu6/BiXqajpKBjL3Xepqn8e0951/omzqKIl7EIE+mTMsPzUm5BzcnBPwEOOZ7Xi61Mn9T6COqzRtgeiUIEaEOxwc1ZVa57UBBYZ2wOV4297Ou+qlOjGzyx6AwmKjBmA6zN0x7xVjjdBrb5MoqVPnLfsHr8a6g5mcs6ALzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349564; c=relaxed/simple;
	bh=sLOXjd+NfAwNXadZFH7WDVyUde0hvaq0L0Srnaupd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxW1Z0xLIbjPnrOkg6t3xnJ3+pNC2NtNTdoCr4JLjc/MR0LTdtuRlpQM8MaiWskg5+j8xrPmhXA8ZV0psRrBD1I1myiwlZoejmYWKauhMBVvvLE5iv+WG/POAkQFDh+VV9AX7CPQ/SBLOBljOQTV2+AW0gkD8E4AOOhUAVa4bwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=robTeF0H; arc=none smtp.client-ip=209.85.221.180
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bd95de6865so1205051e0c.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783349561; x=1783954361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pei7zU5fit2kiS0qO76Myjn3DP91N9i6Q/nmtwzzNx4=;
        b=robTeF0HhSPr00Y4NKI/uDxQ8v/mIGnRlEql16Vc/PXudRhuBvDIJvtWndqaI8fdWo
         s6d5+q22rOrwBmHaHw2T14lJuVJjPZffGAjMs7od+elOF2iRjt0ei8SBB8ay3bs1ZeqM
         DO4z65+csUWhU6Ep5WG8ZTs393W9ZI4k94fNr1elzBKxkFS/o8NUi+tftJJoKodrWi3D
         VDz3THlpZ9uxlkl1pm9JzQS8Ws8viXizQnwXcO2TLfhh++LD4/EKTMaZCBahpa8gMfN/
         xjfonWKcSVgqy1Ql3Y+WENwFzt9W3xJfJSabXFw3lk8tYrCq2oMt5NGZ27dyYe7xQ5Xr
         W4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349561; x=1783954361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pei7zU5fit2kiS0qO76Myjn3DP91N9i6Q/nmtwzzNx4=;
        b=FwjP8uACPtMJ9uMPoFZTnck9Z22ycbIFZIaFAucheYTZUqFrIgVGSIGVpSsh9pvrCY
         NN0b6wDTo91PX2meLSM3wAOxPDFxLI/v4g7f5Ncf6DMkKM1Ca0nzvz8wOJVw9YxjQ0SH
         +wFZ4YUo3XrLQ2z5IfJ49VuqjNg5H+j8LhFR42Bg0Ccl2br0tCcIoFr1qXU6wMdPJdi4
         5+T6Ei7TlLaR4nEdPZVcjiBqob47bJJ24jBIKzyaXbn5L2oe/TPaKLwNCiw1+BZwaZlm
         tkBl7FhmKEKT3P617XLfyncXPDyrQb5YC85CMZ1oAsVdYzB/Ph03h8M0xLqy9+U9mvAR
         Q23Q==
X-Forwarded-Encrypted: i=1; AHgh+RrwsiDdgnV9n5y5XPaDDsR6bm7SXyexi+wJz43qXbS5YOa8s+p24JmnOw/XZuKm5MW4nUmaQaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpAimC1flqavZfe9nctRmN9RsNz6TPkk7Eif4Tdbw4G7WwnWe
	1Vc0rT8JUbC8UDVrP0oOUW6To5Lpn1UA+57hTPvJ9xlq7RjAzDDPNNKYj9SI2Rw1tgw=
X-Gm-Gg: AfdE7clbYwnHBfZoxA041X9w10Lrxz1ATWTC9Hnol+lKjWQbXcZCWgqUEMCilKO+LdH
	gKAcTDNhor5DNR3CnrxKk6dUx3rpdDvPR0Etb+WLpu3+y6NuOos44p9P7RLJr1yoMERImbn1PrL
	CqNTl0nE3KFuZxwYwbmHCQVSRAXR4vf30iQTQ+2IbBU2gdiFA3/0D4lwMuzIkAmf0dDk2KgqTw1
	L2oBuliaV29PUxcXvWNU8TEwuEBZVOpsUKsVGkYwXoWZazJtKSW1pwpKIcXIT6QyItpt3yuBIM+
	LlrNa6PJMx28DBPE6gmIjYJs4dxiWgVEDr3dtMmZUdUMSL2PelMhG7rAi2hDebxTfwjXDmaGbQn
	gXz8dKxKOUqLZh9DCo6c3eEfMx2i8g9PVt9gsCSI3s3N761X5Y1cU7BOB+tqPW4t0qzFrP7DkW3
	z0zQh6bsEDkBYz26a5AbIWcD3hI70CD8W9Qtds0s4GiDN/wE6y4gVV6OP2PNT9JCdok/Qotr5e8
	UES4qx6lk6lGyh8vA==
X-Received: by 2002:a05:6122:46aa:b0:5bd:b0de:a736 with SMTP id 71dfb90a1353d-5be907a7dd5mr473218e0c.8.1783349560419;
        Mon, 06 Jul 2026 07:52:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5be0299616fsm5074880e0c.6.2026.07.06.07.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:52:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-06
Date: Mon,  6 Jul 2026 10:52:29 -0400
Message-ID: <20260706145229.728127-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305101-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48D07712780

The following changes since commit 9e05e91a9a847ed57926414bd7c2c5e54d6c56c6:

  amt: fix size calculation in amt_get_size() (2026-07-06 13:01:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-06

for you to fetch changes up to 6e1930ece855a4c256f1c7e6632d634cfb9888b5:

  Bluetooth: L2CAP: fix tx ident leak for commands without a response (2026-07-06 10:46:58 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: Fix null ptr deref in hci_abort_conn()
 - af_bluetooth: fix UAF in bt_accept_dequeue()
 - L2CAP: validate option length before reading conf opt value
 - L2CAP: cancel pending_rx_work before taking conn->lock
 - L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
 - L2CAP: fix tx ident leak for commands without a response
 - SCO: Fix a race condition in sco_sock_timeout()
 - ISO: avoid NULL deref of conn in iso_conn_big_sync()
 - ISO: fix malformed ISO_END/CONT handling
 - ISO: exclude RFU bits from ISO_SDU_Length
 - MGMT: Fix adv monitor add failure cleanup
 - MGMT: Fix UAF of hci_conn_params in add_device_complete
 - bnep: pin L2CAP connection during netdev registration
 - 6lowpan: avoid untracked enable work
 - 6lowpan: hold L2CAP conn across debugfs control
 - 6lowpan: Fix using chan->conn as indication to no remote netdev
 - btintel_pcie: Refactor FLR to use device_reprobe()
 - btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()
 - hci_uart: clear HCI_UART_SENDING when write_work is canceled
 - bpa10x: avoid OOB read of revision string in bpa10x_setup()

----------------------------------------------------------------
Cen Zhang (3):
      Bluetooth: 6lowpan: avoid untracked enable work
      Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
      Bluetooth: MGMT: Fix adv monitor add failure cleanup

Kiran K (1):
      Bluetooth: btintel_pcie: Refactor FLR to use device_reprobe()

Luiz Augusto von Dentz (1):
      Bluetooth: 6lowpan: Fix using chan->conn as indication to no remote netdev

Maoyi Xie (1):
      Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v3()

Muhammad Bilal (2):
      Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
      Bluetooth: L2CAP: validate option length before reading conf opt value

Pauli Virtanen (3):
      Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
      Bluetooth: ISO: fix malformed ISO_END/CONT handling
      Bluetooth: ISO: exclude RFU bits from ISO_SDU_Length

Runyu Xiao (1):
      Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock

Samuel Page (1):
      Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete

Siwei Zhang (2):
      Bluetooth: hci_conn: Fix null ptr deref in hci_abort_conn()
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

Stig Hornang (1):
      Bluetooth: L2CAP: fix tx ident leak for commands without a response

Sungwoo Kim (1):
      Bluetooth: sco: Fix a race condition in sco_sock_timeout()

Weiming Shi (1):
      Bluetooth: bpa10x: avoid OOB read of revision string in bpa10x_setup()

Yousef Alhouseen (2):
      Bluetooth: bnep: pin L2CAP connection during netdev registration
      Bluetooth: fix UAF in bt_accept_dequeue()

 drivers/bluetooth/bpa10x.c       |   8 ++-
 drivers/bluetooth/btintel_pcie.c | 102 ++++++++++++++--------------
 drivers/bluetooth/btnxpuart.c    |   6 ++
 drivers/bluetooth/hci_ldisc.c    |  14 ++--
 include/net/bluetooth/hci.h      |   5 +-
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |  10 +--
 net/bluetooth/6lowpan.c          |  84 +++++++----------------
 net/bluetooth/af_bluetooth.c     |  17 +----
 net/bluetooth/bnep/core.c        |  27 ++++++--
 net/bluetooth/hci_conn.c         |  21 +-----
 net/bluetooth/hci_sync.c         | 133 +++++++++++++++++++++++++++++++++----
 net/bluetooth/iso.c              |  44 +++++++-----
 net/bluetooth/l2cap_core.c       | 140 ++++++++++++++++++++++++++++++---------
 net/bluetooth/l2cap_sock.c       | 107 ++++++++++++++----------------
 net/bluetooth/mgmt.c             |   5 ++
 net/bluetooth/msft.c             |   2 +-
 net/bluetooth/sco.c              |  15 ++++-
 net/bluetooth/smp.c              |  27 ++------
 19 files changed, 467 insertions(+), 301 deletions(-)

