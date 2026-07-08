Return-Path: <netdev+bounces-305726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hG8mOv4fTmrDDgIAu9opvQ
	(envelope-from <netdev+bounces-305726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:01:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68903723FA5
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=ah9iWdcU;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305726-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305726-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD0E301BF76
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360D73749FB;
	Wed,  8 Jul 2026 09:58:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAB367F31;
	Wed,  8 Jul 2026 09:58:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504734; cv=none; b=QxV65LIINM5TdofTCsIvQL2+GDzWhkOUT9XNl78rT2YMAmpVFln4Waj5DgpIiq6cVTAFkrB5ViPFiIBlUOALuilNpWL/ksQ6222zgEmpj5FHIAovaywdgTwVZZ/VUWRbZo7nHLDLqIhb8ne6KUcb3TmKuL747B94jpI6dUydIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504734; c=relaxed/simple;
	bh=51W4xMdGTfZYWKyMifoJl4D3DqRiZkIHs+NR3TyhtOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GMjSrpt372hQSHY+IHycFDL3ywENoBNCqINAsWUEoXjB4LLuFihMQ64qhfMuhC5j2pTiTmr9RmAub6YXu+IZpedpSNl2Nhemx3+DnE/WvM1529Iwk4r/ICNNzSF9BdU9jPI+0eXmeHU/6aX5L49NGQbYQmzL/vraBbmMOEL4duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ah9iWdcU; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783504724;
	bh=BT/RZYYVoc0gCsHBOMp+tg5rBdH6JU85lu53knTMkyA=;
	h=From:Subject:Date:To:Cc;
	b=ah9iWdcU3o3UPWSOVby5Jp3y/pDo1jmSmMgy9x6ezXMdYXfVANYTStNEJs/+ivFQ/
	 gqijkUSQ0pbCYKryvi7j2ZqhohwRuV/Z8Gt4qc3Xj9/Cie5TwrZemwkcOBDS1zhNe+
	 qJthO5MQykWScyFkr6Ve7AAiBTEOR2hmEygd+gywkT0TwK2EheO9BNF0mcODtr290q
	 aH45cYVTAOBFvZRZv921j4QrLwWzQAXpaz6iuslCq8rdRh/Xl9RJf4Smo0JGT0DUlU
	 QIN1Ex7ksjBeajvRRb0jrooc9qStapZe3d6mGvXbYp9qL/Il4PLiT1yD/K0u0+ffBA
	 HZheIwpHhkQzw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 71CE266526; Wed,  8 Jul 2026 17:58:44 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v3 00/12] net: mctp: usb: Add support for
 MCTP-over-USB v1.1
Date: Wed, 08 Jul 2026 17:58:31 +0800
Message-Id: <20260708-dev-mctp-usb-1-1-v3-0-9e710155cdbf@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEcfTmoC/3WOyw6CMBBFf4V0bUlLsRBX/odxAe0gNaHFvoIh/
 LsFTFyomdXNzD1nZuTAKnDolM3IQlROGZ0CO2RI9I2+AVYyZVSQghNOSiwh4kH4EQfXYpqGd7I
 +lo2kDGqUaqOFTk0b8oI0eKxh8ui6b1xo7yD8SnzfWniEZPV7YT3rlfPGPreXIt0wu52Rb3ukm
 OCaN4zSTvCqrc7CSBBGO2+D8LkwQ96ETR+LD6si7AerSCxOWMLUnLaM/WEty/ICmhiO2zgBAAA
 =
X-Change-ID: 20260604-dev-mctp-usb-1-1-6fd854ad13e8
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68903723FA5

Version 1.1.0 of DSP0283 (MCTP over USB transport binding) has been
released, this patch series updates our current v1.0.1 support for the
changes in v1.1.x.

The major change in v1.1 is the introduction of "packet spanning" mode,
where a single MCTP packet may be split over multiple USB packets
(themselves forming a single USB bulk transfer). This relaxes the
requirement for USB high-speed mode, as we can now send MCTP packets
contained over multiple 64-byte full-speed USB bulk transfers, and gives
us an increase in the maximum MCTP packet size - we now have 13 bits of
packet length (previously 8) in the transport header.

Handling packet spanning introduces some complexity in the transmit and
receive paths, as we lose some constraints on where packet boundaries
may correspond to USB transfer boundaries, and may need to retain state
across separate transfers. To contain this complexity, we introduce a
new library for the transfer packing- and unpacking implementations,
"mctp-usblib". The host driver is a consumer of this library, and a
future gadget driver can use the same implementations. We can now also
implement tests on the API boundary of the library.

The series implements an incremental shift to mctp-usblib, then
implements packet spanning mode in the new library. We have a few
changes to prepare for this, in altering a few constants and
behaviours as v1.0-specific. Once packet spanning is implemented in
mctp-usblib, we enable it in the host-side driver.

To: Matt Johnston <matt@codeconstruct.com.au>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Changes in v3:
- split rx urb status handling to a separate change, handle stalls
- merge tx anchor usage into initial usblib implementation
- add skb drop reasons
- prevent unnecessary skb reallocation
- Link to v2: https://patch.msgid.link/20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au

Changes in v2:
- address sashiko reviews:
  - rx mac_header correction
  - rx/tx stats fixes
  - limit non-spanned packets (where we have no ZLP) to max size
  - handle transient rx urb error status
  - set skb_drop_reasons
  - kunit early-exit cleanups, take rntl lock where needed
- rework tx_qmem locking and anchor handling (we don't need to unanchor
  on completion)
- Link to v1: https://patch.msgid.link/20260630-dev-mctp-usb-1-1-v1-0-86a311fc67b7@codeconstruct.com.au

---
Jeremy Kerr (12):
      net: mctp: usb: Include version indicator in max packet size defines
      net: mctp: usb: Use packet-length max for maximum packet-size check
      net: mctp: usblib: Move RX transfer processing to a new mctp-usblib
      net: mctp: usb: Improve IN endpoint status handling
      net: mctp: usblib: Move TX transfer processing to mctp-usblib
      net: mctp: usblib: Add support for multi-packet transmit
      net: mctp: usb: Accommodate DSP0283 v1.1 header format
      net: mctp: usblib: Implement receive-side packet spanning
      net: mctp: usblib: Implement transmit-side packet spanning
      net: mctp: usblib: Add initial kunit tests
      net: mctp: usb: enable v1.1 packet spanning
      net: mctp: usb: Allow multiple urbs in flight

 drivers/net/mctp/Kconfig            |  16 +
 drivers/net/mctp/Makefile           |   1 +
 drivers/net/mctp/mctp-usb.c         | 315 +++++++++---------
 drivers/net/mctp/mctp-usblib-test.c | 410 ++++++++++++++++++++++++
 drivers/net/mctp/mctp-usblib.c      | 616 ++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h        |  88 +++++-
 6 files changed, 1297 insertions(+), 149 deletions(-)
---
base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4
change-id: 20260604-dev-mctp-usb-1-1-6fd854ad13e8

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>


