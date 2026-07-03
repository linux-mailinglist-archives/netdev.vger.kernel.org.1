Return-Path: <netdev+bounces-304400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzloElplR2qoXgAAu9opvQ
	(envelope-from <netdev+bounces-304400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B888F6FF905
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=r9awMjs8;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304400-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304400-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 445E0302BFFB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF436492D;
	Fri,  3 Jul 2026 07:30:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534E367291;
	Fri,  3 Jul 2026 07:30:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063856; cv=none; b=bzmZBQWA4dURcDYiFAq8soClmNO3z5WZXY6L3p/yn19ziPj1UTEGPOXbpyWAClp3FWCSmo+WljzW/UIBZV+VKgtgTM2CvTLeTulTot6WtTCqzrlqm90jaDOxAuEqS7SNOnpcnn8TByDSHRmkgWF0DtzuEw/PLGo9aaWB5B40Fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063856; c=relaxed/simple;
	bh=lIqB9V6hKFdURaVCuXx+7cQWv+ygnXsOb7cDYfq8CiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+RO6YR6Ola9tjaQzCZeN2klJZVGBdbpWu/22P6XpByUDO5FxexlWetLfojK06Y87Qecj2WLP/N0A/LqF8IEl1l2Qe8PEIHKs52Z3R6Z8oWlLZeAm1ILwlHPhsFIf2ANbNWZybBO0HsDTyrh/IluP3nWcldYXXvAK301hbuiYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=r9awMjs8; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 5AF9960C0B;
	Fri,  3 Jul 2026 03:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063854; bh=PRC4fNxaFNfBdxOnE9hXO6hP9ohPMZMg74FbLz8I9Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r9awMjs8My9Hq0ceCn4Of2lV2aBdObVl/pqHHVHJNyyl+Igy0rBEEtqmNhz9zRGu3
	 2CLJ10aC4US+PygvR+BiNd6YbF7qaZuZTHNNAQUeUEQLn2Sfm0M37pi0WjLXpqmjMt
	 QC6bw62lJEShdsoSSbOoVigVIJfanEUm7Vh7rJtv0nrIxJU/HgJib70ZQOT96HbIDC
	 kAv9SAdjgJanOvd7uKEEAXLSrG/AQk1AxHQyM+DANWLlh52U0yjcTiBCz/IqFZWKs6
	 VA1upGa08g0y5yw9nUXmbEfoIYsksl5bENVRVd2yDQxraco5NYK1easac+V09T5+Eg
	 682Bw/rFoHqaw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:23 +1000
Subject: [PATCH net-next 04/12] net: dsa: qca8k: Drop replies with wrong
 sequence numbers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-4-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=1250;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=9bKE5vAjC6sIfuicdfaEQLHT5Fbj/RGbV3lJaE7kIyM=;
 b=hE9btnfBLw1edRY3VNOMe9Z88TZlTz97H2nEqsOSi0GMqISMq6yzwpPJgT/IuAHUSGxuJUuiy
 Y+7yX3jDhnAAOdSLMai0HVaaOSTj3U5DZzXeiOOBhWetqq7UFCIjKkf
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304400-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:horms@kernel.org,m:f.fainelli@gmail.com,m:tobias@waldekranz.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch,waldekranz.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,padl.com:from_mime,padl.com:dkim,padl.com:mid,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B888F6FF905

From: Andrew Lunn <andrew@lunn.ch>

A response with the wrong sequence number is likely to be a late
arriving responses, which the driver has already given up waiting for.
Drop it rather than signalling the complete. If the complete was
signalled, this late response could take the place of the genuine
reply which is soon to follow.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index b0cbe72c15b4c..3b3fe96016176 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -185,9 +185,9 @@ static void qca8k_rw_reg_ack_handler(struct dsa_switch *ds, struct sk_buff *skb)
 	/* We can ignore odd value, we always round up them in the alloc function. */
 	len *= sizeof(u16);
 
-	/* Make sure the seq match the requested packet */
-	if (get_unaligned_le32(&mgmt_ethhdr->seq) == mgmt_eth_data->seq)
-		mgmt_eth_data->ack = true;
+	/* Make sure the seq match the requested packet. If not, drop. */
+	if (get_unaligned_le32(&mgmt_ethhdr->seq) != mgmt_eth_data->seq)
+		return;
 
 	if (cmd == MDIO_READ) {
 		u32 *val = mgmt_eth_data->data;

-- 
2.43.0


