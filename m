Return-Path: <netdev+bounces-304408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /v5qJ49nR2omXwAAu9opvQ
	(envelope-from <netdev+bounces-304408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:41:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E759C6FFA63
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:41:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=lOxA9eru;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304408-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304408-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 271A5303CA4A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD136EAB1;
	Fri,  3 Jul 2026 07:31:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C4368D71;
	Fri,  3 Jul 2026 07:31:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063892; cv=none; b=o2ZUZavVKYHgHgTen+lg1/hT8yq/jmoAW02BAy9m94ZsC2p7zhZmSRgNAxChY/HdO91X0NNswQp20brmwKkOXTpgd72b8WhwwKXMXmzlLEk1uuEX9Q9R6Bn1pOtd5KRUXddIKlFohmVfV96w8ro+GIkH2qjBlAhfWGvaU2flPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063892; c=relaxed/simple;
	bh=jmvTvDGf70jvYI8OTcAgyQMxRq681e+230ZOTDo+ERQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2otYHsVbpZPrZwUgi5/9cJsCLPFgqFVxJL2JXuZD0QvClwPbGXPSIU4kpW2IzIlvByme1MlrsXI3SCPtklidiL0vwndCeZnlfnFBPV7dYc07htyFl5lKEcaKuQb/QRmd4AJizW7U15zpqsvLoYiQx7y/64sNDVC2RKZom0PK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=lOxA9eru; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id C225E60C0B;
	Fri,  3 Jul 2026 03:31:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063890; bh=dvUyPVPbnfey8hIjeXW1Um5jRBhhtUqxmcNX9voDPLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lOxA9eru+OlBluLIrRY8q3/dhTCf3EeGBfV6cEt8nJbia4WlNZIGBsRg849PYbFmS
	 kwlmm2OXwgaN1/70I94Ib7wtKzZ55/KKwXP7M2STWRtVgqb/ayrp1qeK0xjlbpgTGg
	 +TKkDCSBpuPB3b6rqSLqdc+ektcQN9qGx8cuiDKqPmf8ss8pbTyIvrKEwoaLWQP1la
	 IMrnqq4oO432Aj06mC4ywewCA6S0/9BZmi0l0h+Q4h0nYArbDGTrK5MOmLjiMTBn8M
	 xhWZemMmYpbdj1+Fk6wSznDyf++xdAT3glakU39pLop8oTIJVWZGh857VRxxQV4Kdp
	 9hhhcMPJNRF6g==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:30 +1000
Subject: [PATCH net-next 11/12] net: dsa: Add helper to find ds_switch by
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-11-a03febf20bb4@padl.com>
References: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
In-Reply-To: <20260703-net-next-dsa-rmu-v1-0-a03febf20bb4@padl.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=1191;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=aGyYoCS/DPWqkPNAAeZJqgqV1VzF8Qi95ySkugXQvAg=;
 b=Mki32ezu9L7e5spIU9eO+DzIWvZ5cRRW5t55cP33Fm+ZuVoBw8Ck5qpTUUvqxGB4qXM/B+vbT
 isWzzi4hE6FAUbImON9rCyXDUv42Zyj8b+UmORCkxnUy/3SYxJlDkSF
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304408-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch,waldekranz.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:horms@kernel.org,m:f.fainelli@gmail.com,m:tobias@waldekranz.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:dkim,padl.com:mid,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E759C6FFA63

From: Andrew Lunn <andrew@lunn.ch>

The DSA header for an RMU frame includes the switch index to indicate
which switch sent the RMU frame. Add a helper which walks the list of
ports and finds the corresponding switch. Since this is not the hot
path for data frames, the overhead of multiple ports per switch is not
considered a problem.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 net/dsa/tag.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index cf52283fe9df4..c21d746652601 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -44,6 +44,20 @@ static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
 	return NULL;
 }
 
+static inline struct dsa_switch *dsa_conduit_find_switch(struct net_device *dev,
+							 int device)
+{
+	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_switch_tree *dst = cpu_dp->dst;
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list)
+		if (dp->ds->index == device)
+			return dp->ds;
+
+	return NULL;
+}
+
 /**
  * dsa_software_untag_vlan_aware_bridge: Software untagging for VLAN-aware bridge
  * @skb: Pointer to received socket buffer (packet)

-- 
2.43.0


