Return-Path: <netdev+bounces-307132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nuFBFVPMVGrnewAAu9opvQ
	(envelope-from <netdev+bounces-307132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:30:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4374A614
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307132-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307132-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fritz.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81A3930258B4
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4433E8C65;
	Mon, 13 Jul 2026 11:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672F387359;
	Mon, 13 Jul 2026 11:30:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942214; cv=none; b=OyqyuFCvIS3FaX3LkYzh6HsCIZPb5v+/knvO3i96TWWXB7iq2p8qtDaov6uRuArq4WTnQB62RSQwJtrek+ZJBbL7z1j8XeXJVDWM/NOBJEJMpa+N+56Qb1zAcnYRlLwaUgSQLhwkWb0skz6FtmGs0j6dGl0euBp4BWdPRBZOSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942214; c=relaxed/simple;
	bh=YKVLIQtatBhn5yK/xtLhS4dBm2eOpXamOjk5hO60+Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH23RUS8tS2K/OYVgDGYrOrHKaGkYdZvfRgsfrvrk+JBhxSyix2d42o/geV7vK+vp7khwIXKxTPNr/i1b6GGSg/EVp2UpohjHCu8HhaLwdZOg+8U3A1qoXfOqtQQvRu4wX/wHWsQRnIxk5My/0jsn873jQn0LZDRvku6PLrQbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.94
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a54caed-1649-7f0000032729-7f000001c90c-1
	for <multiple-recipients>; Mon, 13 Jul 2026 13:24:29 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 13 Jul 2026 13:24:29 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/1] macvlan: allow source mode devices along with passthru
Date: Mon, 13 Jul 2026 13:24:12 +0200
Message-ID: <20260713112414.2842803-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1783941869-B34B5B3F-5DC6AEEB/0/0
X-purgate-type: clean
X-purgate-size: 2437
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: queueID: D7249A0261
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[fritz.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:t.martitz@fritz.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307132-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[t.martitz@fritz.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.martitz@fritz.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fritz.com:from_mime,fritz.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8C4374A614

Hello,

we're trying to solve a use case on our devices where two SoC are
connected on the same board, using the only available high-speed interface.

One SoC runs the main Linux system including the full routing stack
(FRITZ!OS) and the other SoC implements most of the GPON ONT side.

The high-speed interface is of course also used for the user traffic.
Therefore we must tell the inter-SoC traffic apart from the user traffic.

We achieve this by matching the well-known MAC address of the ONT SoC.
The user traffic passes through the ONT SoC without modifying MAC headers.
Now we would like to use macvlan (with source mode devices) on the main
SoC side for this but our routing stack requires the rx_handler to be
available. Therefore macvlan is currently not an option.

With this patch macvlan becomes an option because the current limitation
of either "one passthru device" or "any other configuration" is relaxed
for the combination of passthru and any number of source mode devices.

This allows us to configure a source mode device for the other SoC and
register an rx_handler for further processing on the passthru device.

Thanks in advance!

---
Changes in v4
- Prevent macvlan_restore_mac() from changing the MAC address
  of remaining source mode interfaces.
- Set MACVLAN_F_PASSTHRU on the macvlan_port only after adding
  the passthru interface truly succeeds.
- Changing existing interfaces to passthru mode shouldn't become
  allowed.

Changes in v3
- fix passthru port removal caused by passing the wrong 
  device to macvlan_port_release_mac(). This was also
  detected by syzbot.
- macvlan_port_release_mac() is now named macvlan_restore_mac()
  and gets passed a "struct macvlan_port" directly.
- Link to v2: https://lore.kernel.org/netdev/20260709100512.1383421-1-t.martitz@fritz.com/

Changes in v2:
- changed several port-wide checks (macvlan_passthru()) to 
  per-interface checks (vlan->mode == vlan->mode == MACVLAN_MODE_PASSTHRU)
- correctly handle removing the passthru interface when there are still
  source interfaces
- Link to initial posting: https://lore.kernel.org/netdev/20260612092345.2352255-1-t.martitz@fritz.com/
---

Thomas Martitz (1):
  macvlan: allow source mode devices along with passthru

 drivers/net/macvlan.c | 107 ++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 34 deletions(-)

-- 
2.54.0


