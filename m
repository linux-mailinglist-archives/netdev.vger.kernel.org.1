Return-Path: <netdev+bounces-292015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WVVMKjM+FmomjwcAu9opvQ
	(envelope-from <netdev+bounces-292015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:43:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 281325DE02D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABB663012C7D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38461DD0EF;
	Wed, 27 May 2026 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="yFsirazU"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DEB208D0
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842604; cv=none; b=FgLejFeP2QIEhrsWjC2S0diOwrtdjjUjANVEWqr7IQuv5HI1N3caOp+i+mCr24mRV9iCaZOX4o/lIBJMlVWugLfwj4iBAJsX2EnL6rC7JlHwEJLvYC/9r2+FQib1S0un2leAPUXVtxTVcu7nki67K6H8xDwlM+Yc7/Ar2wwUJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842604; c=relaxed/simple;
	bh=4QX7fwNvhVwrNK+2ClVN676sfp2oUo8C5UpFDXrZxTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRLfK7FCapvcbh1VsSLWtAa3hQouEV8YMW3lMq6/fDVYu9q9qzkhOdnWtCHS+tI72zn7PXvhxokPrPo0CFikl3IpghGslBhitIDLZvPmNpY+aHgo0MLR8nJnxsaiZeliZ5VRfm5xoElWxbcx1gSAg7PsKlikeF3DDiFvX/VwO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=yFsirazU; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tD030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:04 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tD030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842587; bh=F1FGxKpBHnLusNCRfgELyfxgIL+mOBlMNdXUAsZaqQw=;
	h=From:To:Cc:Subject:Date:From;
	b=yFsirazUjQsxLzCWk+XnEncgD47IEUKieqEuHYtikScxep/KXChSTG1Emdb3S3PUc
	 SgMA4uL+9vPaTV5o0cXg3yL0yjps9/CY/NzmU52c7KbEpq4ErbAP4beRIWP78+XY8k
	 g67ciKCoaEHO6T8zJSKWg7eGJe4UpYe4yput3BhUVSnYmfe8rtDIwwmqS8D3Io+27d
	 J4lvLT1/PbfnMQsYRuC9edsjRw4MBvfOg0mk18u9gdaZuMNx2MSvRboAQOG0yQk/mX
	 Bx2XEws0J7GwVtJIYjLUuvlDaYxZyALUoMs140qzSPwTw/G3VJaut5M+VWLWWRUKo+
	 XvJ6H2sszCOqQ==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>
Subject: [PATCH net-next 0/6] net: dsa: mv88e6xxx: add MQPRIO/CBS offload
Date: Wed, 27 May 2026 10:42:46 +1000
Message-ID: <cover.1779841530.git.lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292015-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 281325DE02D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds hardware offload of 802.1Qav (Credit Based Shaper) for
conforming Marvell switches. It also introduces a new bridge MDB flag,
MDB_FLAGS_STREAM_RESERVED, that userspace can set on RTM_NEWMDB to mark a
multicast destination as belonging to a reserved stream; the flag is
propagated through switchdev to hardware drivers that can enforce
admission of AVB / SR priority traffic only to flagged destinations.

The patches were originally proposed as an RFC in September 2025 [1], but have
been updated to absorb most of Cedric Jehasse's recent CBS changes [2] (with
the exception of support for more than two shaped queues). The principal
application is hardware-offloaded switching of AVB/TSN traffic rather than
host-initiated traffic.

In addition to programming the per-queue shaper, the following related
registers are configured:

* global isochronous queue pointer threshold
* strict-priority queue scheduling while CBS is active on a port
* in Enhanced/Secure AVB mode, hardware drops frames with AVB priorities
  whose destination MAC has not been added to the MDB with the new
  MDB_FLAGS_STREAM_RESERVED flag

A more detailed overview is given in drivers/net/dsa/mv88e6xxx/avb.h.

Support for MDB_FLAGS_STREAM_RESERVED in the software bridge will be submitted
as a separate patch series.

[1] https://lore.kernel.org/netdev/20250927070724.734933-1-lukeh@padl.com/
[2] https://lore.kernel.org/netdev/20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be/

Luke Howard (6):
  net: bridge: mdb: add MDB_FLAGS_STREAM_RESERVED flag
  net: dsa: mv88e6xxx: add num_tx_queues to chip info structure
  net: dsa: mv88e6xxx: add MV88E6XXX_G1_ATU_CTL_MAC_AVB setter
  net: dsa: mv88e6xxx: MQPRIO support
  net: dsa: mv88e6xxx: CBS support
  dt-bindings: net: dsa: mv88e6xxx: add mv88e6xxx-avb-mode property

 .../bindings/net/dsa/marvell,mv88e6xxx.yaml   |  26 +
 drivers/net/dsa/mv88e6xxx/Makefile            |   3 +-
 drivers/net/dsa/mv88e6xxx/avb.c               | 633 ++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/avb.h               | 228 +++++++
 drivers/net/dsa/mv88e6xxx/chip.c              | 372 +++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h              | 101 +++
 drivers/net/dsa/mv88e6xxx/global1.c           |   9 +-
 drivers/net/dsa/mv88e6xxx/global1.h           |  47 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c       |  17 +
 drivers/net/dsa/mv88e6xxx/global2.h           |  14 +-
 drivers/net/dsa/mv88e6xxx/global2_avb.c       | 205 +++++-
 drivers/net/dsa/mv88e6xxx/port.c              |  54 ++
 drivers/net/dsa/mv88e6xxx/port.h              |  22 +
 include/linux/platform_data/mv88e6xxx.h       |   1 +
 include/net/switchdev.h                       |   4 +
 include/uapi/linux/if_bridge.h                |   2 +
 net/bridge/br_mdb.c                           |  12 +
 net/bridge/br_private.h                       |   2 +
 net/bridge/br_switchdev.c                     |  17 +-
 19 files changed, 1744 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/avb.h

-- 
2.43.0


