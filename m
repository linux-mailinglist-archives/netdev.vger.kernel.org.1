Return-Path: <netdev+bounces-306447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JN1INrWUUGrM1wIAu9opvQ
	(envelope-from <netdev+bounces-306447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:44:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD74737CB0
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=LM0Ysxnv;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306447-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306447-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5823C300BC79
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E42377579;
	Fri, 10 Jul 2026 06:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F53B388E;
	Fri, 10 Jul 2026 06:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665838; cv=none; b=Nh4t89K70hlDiGDIne3NKtfPqCqrdGcpLrvj/rMO+eNz+uGy1BzauioYOYVDjyxjBbwoBXpgorPWIjsloPTB26b+ywmsoEEi/iGO1E7u1/7qB7mOdceXdzE8k6SGGVPN6cVwbOqDJ+VeJZW5jE/qR++aer/W3cYg+KqmlbmP3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665838; c=relaxed/simple;
	bh=S/m7wEGVPPuy/T0jA6cuudg3kG0H7utcE7QLoebxOpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rS/q9iGxsU2ZzdePxUPa3i0gvZ+9uIEU7QvoPjhX2RgWGK3UyP/rJhpCoefU6iikNifjCmO5oqi3GxfUhr7KAmcb2Hzej8aYIuKdkF80OGMe8ehz6a0QL+5KVdfZ70lDFaDGbuhzjqn9gA7HNpGf7OgVXI4aoRGW3eLtYUxwEjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=LM0Ysxnv; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 1C94B621EB;
	Fri, 10 Jul 2026 02:43:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783665836; bh=FapvGTAxBY2u9Vb3QN5cttB3cakXLqKSc2AEx2t5wDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LM0Ysxnvh8k8qzMllIcbj76BNQbzbgcgPeElUT6vce3/TEx+3aaZPEFnqKa9E46Jk
	 Ol/PUx071Osm3EAV/JZYzFOpDOkTSBV9h+lnolQZtyoYlrwGup4whOdMhY5qRp54NH
	 JyF4BB6E5lAGe4WhDH28lLQbdWW3CIfQeQZdi8E3RiGFy+MGXXsUoAmEqvlycUBN5e
	 dVlv2SWdKqY3tFr8qe/57dk9YgTa49j+frl1YYiBXDg9xe7K6gpHK+ok20epnl6Cr0
	 EriPPK29qrmYo/yVwxD3V5entWJenPQ82cXlw2U9Sw9LruPXAcCEjbfarFtXkm+3VZ
	 eHAPa/KZ/VaoQ==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 10 Jul 2026 16:43:41 +1000
Subject: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: use ARRIVAL1 counter
 for all peer delay messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mv88e6xxx-ptp-fixes-v2-1-af97c38df247@padl.com>
References: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
In-Reply-To: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783665827; l=2031;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=S/m7wEGVPPuy/T0jA6cuudg3kG0H7utcE7QLoebxOpk=;
 b=OE+lIkY6Qx5gcYI1IwQp6yiGI6yeEkd1As4mfK3gkEYLzU79PjzDsjWuory9cMzak0tnBl8ed
 fle3nANfR/tDGc9uSTHedr1+VAKpXCeOezr4E5ZwD0SpUmyTFNfi0On
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306447-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DD74737CB0

mv88e6xxx switches have two arrival timestamp counters for timestamping
PTP event messages. This permits more than one arriving event message's
timestamp to be captured. This is useful for the case where event
messages from a grandmaster arrive at the same time as PDelayReq/PDelayResp
messages from a peer.

Previously only PDelayResp messages were assigned to the second arrival
counter; this patch does so for PDelayReq messages as well.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 6e6472a3b75ad..57ff77496864f 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -319,9 +319,16 @@ static void mv88e6xxx_rxtstamp_work(struct mv88e6xxx_chip *chip,
 				   &ps->rx_queue2);
 }
 
-static int is_pdelay_resp(const struct ptp_header *hdr)
+static bool is_pdelay_msg(const struct ptp_header *hdr)
 {
-	return (hdr->tsmt & 0xf) == 3;
+	switch (ptp_get_msgtype(hdr, PTP_CLASS_V2)) {
+	case PTP_MSGTYPE_PDELAY_REQ:
+		fallthrough;
+	case PTP_MSGTYPE_PDELAY_RESP:
+		return true;
+	default:
+		return false;
+	}
 }
 
 bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
@@ -343,7 +350,7 @@ bool mv88e6xxx_port_rxtstamp(struct dsa_switch *ds, int port,
 
 	SKB_PTP_TYPE(skb) = type;
 
-	if (is_pdelay_resp(hdr))
+	if (is_pdelay_msg(hdr))
 		skb_queue_tail(&ps->rx_queue2, skb);
 	else
 		skb_queue_tail(&ps->rx_queue, skb);
@@ -584,8 +591,9 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Use ARRIVAL1 for peer delay response messages. */
+	/* Use ARRIVAL1 for peer delay messages. */
 	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_TS_ARRIVAL_PTR,
+				  MV88E6XXX_PTP_MSGTYPE_PDLAY_REQ |
 				  MV88E6XXX_PTP_MSGTYPE_PDLAY_RES);
 	if (err)
 		return err;

-- 
2.43.0


