Return-Path: <netdev+bounces-298792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NucME1xzLGrbQwQAu9opvQ
	(envelope-from <netdev+bounces-298792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE767C684
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:00:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=GgVpFRkK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298792-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298792-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B743148699
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7916362149;
	Fri, 12 Jun 2026 21:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD4375F8E;
	Fri, 12 Jun 2026 21:00:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781298008; cv=none; b=OyVV+z2QWDgChqzwWDtnXwG0tYv20G0/8nMw3r/d8tvdsxcXMJGtw/m0MYiTH9Q4176x0M5gaGQd0lvFGacTek7XZKZFP5YfkDp70u8UIHs8bM8iOJIBQ3K63zTE1cueg61XnQaMs0eqlzrHWA6dW4SIDg1KiokXs1Lyqbu8/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781298008; c=relaxed/simple;
	bh=iE7R31d6Vw3xhwPeEcUffSLCObrWgpbGuK7GyGc13hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Omlv7e+V0P+W1EZO6VS2MxBiuVgzp5xtLhXsMnZN3l/E1TPbIxHPF2f6YlnwBuO8FYDypMgIUx2ASlGOC0H2D3UBZT2i0QdN8MoXN8+UA12G1sGBkR+oq5D7iqhGN1LGss1yazqRRvdN3dicmzUFJhiUmnqRWpC7BuX6gMpa5CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=GgVpFRkK; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4614A4D39;
	Fri, 12 Jun 2026 22:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781298001; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8WwPMoEet8iC2sxpAvMEv7cqNr3RbumxxBq5EouUnGo=;
	b=GgVpFRkKrgOKdlWzp80bSWm0tqYdKUC6aH0++FDPDEbX367fwyHcONDgFbsBmDCFu0wF/4
	tij3ABjmOFCMZFLdRKCm9np6d37SboScjv5XFufRvXUqvrUZiwoxHLZ3DXV5Y9HrGq+cJ6
	vZaQ1CFK7yDgVusM3bk1VAu6UhEnlv1sWpm9P5ihr2BwYZ0K10hcmSh+CqtabYm9+Noo6A
	N1fbaoPdIlx6K3QHICyWLcqdcdXMiHePeSt5R+icYZ8ws+khMlEAuLXPw0lZ6XaJ5vMqa+
	9dtnhdHXs03iS8AkxoANEExA9qMn3gIk2NdReOwjZGPkG86a3ABXWYhqcSGenQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/3] net: bcmgenet: collapse TX priority queues
Date: Fri, 12 Jun 2026 22:59:12 +0200
Message-ID: <20260612205915.3156127-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298792-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AFE767C684

The strict-priority TX queues can starve under multi-queue load and
trip NETDEV_WATCHDOG. Justin's earlier series [1] tried to mitigate
the timeouts but kept the multi-queue design. Ovidiu Panait recently
proposed a WRR stop-gap [2]. This series drops the priority queues
entirely. Justin confirmed they are no longer required.

Patch 1 collapses v2-v4 hw_params to the same single-queue path v1
already uses. Patch 2 removes the now-dead priority register writes,
helper macros, and the dead "flow period for ring != 0" branch in
bcmgenet_init_tx_ring(); the DMA_ARBITER_{RR,WRR,SP} and
DMA_RING_BUF_PRIORITY_* HW defines are kept as register
documentation. Patch 3 switches the netdev allocation from
alloc_etherdev_mqs(., 5, 5) to alloc_etherdev(), since only one
TX/RX queue is ever used.

Tested on Raspberry Pi CM4 (BCM2711):
  - Ovidiu's reproducer (iperf3 -u -b0 -P16 -t60) no longer trips
    NETDEV_WATCHDOG.
  - UDP sustains 956 Mbit/s line rate over 60 s with 0 datagrams
    lost (0/4952890).
  - Single-stream TCP throughput unchanged at 943 Mbit/s.

[1] https://lore.kernel.org/netdev/20260406175756.134567-1-justin.chen@broadcom.com/
[2] https://lore.kernel.org/netdev/20260610085238.56300-1-ovidiu.panait.rb@renesas.com/

Nicolai Buchwitz (3):
  net: bcmgenet: collapse TX priority queues to a single queue
  net: bcmgenet: remove dead priority queue plumbing
  net: bcmgenet: allocate a single-queue netdev

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 100 +++---------------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   2 -
 2 files changed, 16 insertions(+), 86 deletions(-)

-- 
2.53.0


