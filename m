Return-Path: <netdev+bounces-256676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PIbMKUsg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:25:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61BE50D3
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1A47300E3ED
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3DC3E9F78;
	Wed,  4 Feb 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4jZqaN9Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NbyrnLjL"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37D3E9F70
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204295; cv=none; b=meIMHs2K08NxJj7uiMjTzWrJGFqLTz6xtb+8WMS0L0DP4Vy0PGWdmbsIxaddBeFKbOLTZB0zbSZs1IA3QjNnIkdNOa/YJlE2LTOjCdpnbU7odUUqvZgBg7hWI9+OK5dPJmcFaKtK/ZOZ3O2G/KhKPcs0ZCe4XLV44fQS8Xbux+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204295; c=relaxed/simple;
	bh=Ng3MTrMtfEc9+RJTan1hOr86PjA0SWgXi/++1KH3TvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ot1ajACwv3WAbMxfj1APIyYJsMXCIlB/+/Hm+LnxKHNZDHG3P6/kZb6q7ch9ecjD9tWM/ngbMcNzAdOp52ObDYBRJe+1/AtnLLd5SFPDqbsqBoWTe8l1Pu7VpD3P0P2DalEYu0oZ2/DYOIWPNn1oXQDI4Yv9o1dYHifUYo8rHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4jZqaN9Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NbyrnLjL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770204293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i/gSYPcmL+O3A8MX4SmXmYxtnR5pB+0fha1HhHgjDPg=;
	b=4jZqaN9Qs6hDwGTGsbUKfDEfw4KieZJsnhI/fMi48qOm42SO+wQRPAKA7kkHWvWul1eAQ3
	rBS6+Me4RBfwNjoM1K292yCq0vTcMdDYiUTteBpDlI/bdtoH17goE+WMm+u7Yvnnxc37nk
	7b/PH4zawiUtwDeq4MT87EC1mquVEYvvsIOZCcuXkWY1w2tX5xcEjsrbSYBFcNqEYNiEfx
	gtUJv7JTFRUx47czbmcZohKZ0u7xk3bcUtlobKkd5xY8C0AFXdTxuT1EbsGxvNh1PIkXCl
	ab3sYddJI7BoUdZjtYf6AU9ucuVI1TrE1uPyHKuGUKHzrG4elRnDCb9DM7yBOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770204293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i/gSYPcmL+O3A8MX4SmXmYxtnR5pB+0fha1HhHgjDPg=;
	b=NbyrnLjL0PMuOVkzKMa7r9sbS4fmYkJplPI/GGHs2+ijn4jq2GylNhawndvh/OvRvJHVCI
	hXbWgUjpVKnk7bDw==
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC net-next 0/2] hsr: Add additional info to send/ receive skbs
Date: Wed,  4 Feb 2026 12:24:02 +0100
Message-ID: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260204-hsr_ptp-1f6380f1d35f
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-256676-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 3E61BE50D3
X-Rspamd-Action: no action

I am trying to extend linuxptp to support PTP over a HSR network. The
user space for linuxptp are still under discussion, the thread starts at
	https://lists.nwtime.org/sympa/arc/linuxptp-devel/2025-11/msg00013.html

the posted patches are also available at git repository for convenience
	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/linuxptp-hsr.git h=
sr_v2

This is the kernel side of the changes. In short PTP over HSR sends its
packets to multicast address and every node needs to forward the PTP
packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
In order to achieve this, the HSR stack must not duplicate and forward
the PTP packets as it would with other packets. The delay caused by the
duplication and forwarding adds overhead which in turn makes the timing
information within the PTP packet inaccurate.

My current approach is to open the hsr0 device from userland and send
and receive the PTP packets individually on both slave interfaces. I
added additional hints to the af_packet interface, which is used by
linuxptp, to be able send a packet on a specific interface (A or B) and
also to have the information recorded for received packets.
Additionally, the PTP-timestamps which arrive on the slave interface are
forwarded to the hsr interface.

This solves the following:
- Forwarding a SYNC and a FOLLOW_UP packet.
  Userland receives a SYNC, FOLLOW_UP and timestamp packet from port A.
  The received port is known and recorded. The SYNC sync packet and the
  updated FOLLOW_UP packet can then be forwarded on port B. The update
  is based on the time spent during the forward so the forwarding delay
  is accounted for.
  In this scenario the HSR header is used from the original sender of
  the SYNC and FOLLOW_UP header and the stack must not prepand the
  system's HSR header nor replace the provided header.

- Sending PDELAY_REQ and PDELAY_RESP*
  These packets are only exchanged between the two nodes directly
  connected and they must not be forwarded within the HSR ring.
  These packets are sent as PTP packets and the HSR stack must prepand
  system's HSR header including a sequence number.
  This logic is also used for SYNC packet if the node acts as a GM.

This has been tested in a pure software environment and in an HW-assited
environment where the HW is able to duplicate and deduplicate packets
but does not do it for PTP packets.
It has not been tested within an enviroment where the HW is able to
forward the PTP packet and correctly update the timming information.

This series will clash with Felix's sequence number/ deduplication
rework.

---
Sebastian Andrzej Siewior (2):
      hsr: Allow to send a specific port and with HSR header
      af_packet: Add port specific handling for HSR

 include/linux/if_hsr.h         |   2 +
 include/linux/skbuff.h         |   1 +
 include/uapi/linux/if_packet.h |   9 ++++
 net/hsr/hsr_device.c           |   7 +++
 net/hsr/hsr_forward.c          | 114 +++++++++++++++++++++++++++++++++++++=
+---
 net/hsr/hsr_slave.c            |  16 ++++++
 net/packet/af_packet.c         | 103 +++++++++++++++++++++++++++++++++++++
 net/packet/internal.h          |   1 +
 8 files changed, 246 insertions(+), 7 deletions(-)
---
base-commit: 4ff7d63728ef2315d402a608cef1376248aa5c56
change-id: 20260204-hsr_ptp-1f6380f1d35f

Best regards,
--=20
Sebastian Andrzej Siewior <bigeasy@linutronix.de>

