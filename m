Return-Path: <netdev+bounces-297508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5csGlYZKWp+QgMAu9opvQ
	(envelope-from <netdev+bounces-297508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:59:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEEF666DF1
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=c127.dev header.s=mail header.b=cRCEfBUy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297508-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297508-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742A231609F8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EC83939C8;
	Wed, 10 Jun 2026 07:54:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ie.d.sender-sib.com (ie.d.sender-sib.com [77.32.148.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA663939B1
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:54:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078055; cv=none; b=k21VxJBadHSiCYu7g07PPGid7g10lAe98uLhm6h4pR2MTm4nehuTUEuZ0+qkGNKfL4tZW/WY43Xkwopjyywg/Ns/xdPGfJJD9x1fMRM8fFKCpWOhTdSsiIyAOgMs0O1akuw32p5wzNHDFvIB26aPDZj5CuCuP63qOqFZ92LWmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078055; c=relaxed/simple;
	bh=5I53mNF9nzwXieU+o5PlacM2NY9F72faQbDq4+lNRJE=;
	h=To:Date:Subject:Message-Id:From:Cc:Mime-Version; b=AIGI4h+Y8AyuYEj27MP80kfh53QdrZppWY2IoKehSR2A85OpYBFxZc57NrxFz9I96Jiz8yzPOeHb1M95n1Tyqbp0aijNKascQlSUsfrWRFuA/1psEzqg6P2OHrnk1+YEjoE0NdIJRYh30pWlwG1HnRhwv9OzWvWHjzXhpUuim5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=ie.d.sender-sib.com; dkim=pass (1024-bit key) header.d=c127.dev header.i=@c127.dev header.b=cRCEfBUy; arc=none smtp.client-ip=77.32.148.57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c127.dev;
 q=dns/txt; s=mail; bh=ZMlke4zIy3SDTUd0vYpvrY9kR6n+0uS3IfBGC8mmI1Q=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=cRCEfBUyqWLjaBOuUbMljOzqWz4RGPyVGYLQ9mAFdWzcdXzHCDTPxkaSodB6OpywSl/8yj1edQZX
        HLp5lMAu/eRPd6eD482boyNQnbYx7OSTv5bEy13nR+0GD+febw6ch1f9ktALk+D6h9fYarLcfNcE
        ejv//0PJNDplIDyH2SI=
To: <netdev@vger.kernel.org>
Date: Wed, 10 Jun 2026 02:52:39 -0500
Subject: [PATCH net-next v1 0/2] net: dsa: realtek: rtl8365mb: add SGMII/HSGMII support for RTL8367S
Message-Id: <aebccaad-eca3-4ea4-99dd-ae7edbc8981b@smtp-relay.sendinblue.com>
Origin-messageId: <20260610075241.1069370-1-contact@c127.dev>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: "Johan Alvarado" <contact@c127.dev>
X-CSA-Complaints: csa-complaints@eco.de
X-sib-id: OLhFG0WHinseFFRYmSSqi45eFrLTKT1U4l7BBv3VJ1ICq-3m5r9Lk_nbLk-yv4gg0Pg6ockIm64iZs6X0ZAK2vj88DVUkGOhTf5eEGDP7gN9PRVk47uJAq4v4BBtcfyof5bIu8FyZ-lQEP2JI2H4kpi1pg14sVReHrvYtljOZuQ-F9kL
Cc: "Linus Walleij" <linusw@kernel.org>,  Alvin Šipraga <alsi@bang-olufsen.dk>,  "Andrew Lunn" <andrew@lunn.ch>,  "Vladimir Oltean" <olteanv@gmail.com>,  "David S . Miller" <davem@davemloft.net>,  "Eric Dumazet" <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni" <pabeni@redhat.com>,  "Russell King" <linux@armlinux.org.uk>,  <linux-kernel@vger.kernel.org>,  "Johan Alvarado" <contact@c127.dev>
Feedback-ID: 77.32.148.57:6940426_-1:6940426:Sendinblue
X-Mailin-EID: MjQyODY3MzE0fm5ldGRldkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNjEwMDc1MjQxLjEwNjkzNzAtMS1jb250YWN0QGMxMjcuZGV2Pn5pZS5kLnNlbmRlci1zaWIuY29t
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	R_DKIM_REJECT(1.00)[c127.dev:s=mail];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[c127.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:contact@c127.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-297508-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[c127.dev:-];
	FROM_NEQ_ENVFROM(0.00)[contact@c127.dev,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,vger.kernel.org,c127.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp-relay.sendinblue.com:mid,c127.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEEEF666DF1


The RTL8367S is a 5+2 port switch from the same family as the
RTL8365MB-VC already supported by this driver. Its chip info table
entry declares SGMII and HSGMII on external interface 1, but the
driver so far only implements RGMII, leaving boards that wire the
switch to the CPU over the SerDes without a working CPU port.

This series implements both modes. The configuration sequence and the
SerDes tuning parameters are derived from the GPL-licensed Realtek
rtl8367c vendor driver, as distributed in the Mercusys MR80X GPL code
drop. The SerDes bring-up requires firmware running on the switch's
embedded DW8051 microcontroller; the firmware blob from the vendor
driver will be submitted to linux-firmware separately as
realtek/rtl8367s-sgmii.bin, and is loaded via the firmware API.

Patch 1 adds the SerDes indirect access helpers, the DW8051 firmware
loading and SGMII (1 Gbps) support. Patch 2 extends this to HSGMII
(2.5 Gbps), which phylink represents as 2500base-x.

Tested on a Mercusys MR80X v2.20 (RTL8367S connected to the SoC via
the SerDes), in both SGMII and HSGMII modes, with a fixed-link device
tree description.

Johan Alvarado (2):
  net: dsa: realtek: rtl8365mb: add SGMII support for RTL8367S
  net: dsa: realtek: rtl8365mb: add HSGMII support for RTL8367S

 drivers/net/dsa/realtek/rtl8365mb.c | 394 +++++++++++++++++++++++++++-
 1 file changed, 390 insertions(+), 4 deletions(-)

--=20
2.54.0




