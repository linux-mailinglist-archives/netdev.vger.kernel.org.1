Return-Path: <netdev+bounces-304409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jL5/Jt1mR2oAXwAAu9opvQ
	(envelope-from <netdev+bounces-304409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC9C6FF9E8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:38:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=jKmkK+sv;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304409-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304409-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A63A3023DE6
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68EC36AB4B;
	Fri,  3 Jul 2026 07:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F146353A95;
	Fri,  3 Jul 2026 07:31:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063897; cv=none; b=trLMG3Jf5JD0ygkS2L5+RsKsB/G8+8VgfcbFvvwHVyYSILq5d9IH/KxmpxydZ9PF1ZaA7JBtirpnmOitQrvCdM4DyktummBKuz54YKKDbEPGiM3nZ7gLmAc/gZMEU2aX1EBO1OKfxwqrh0jYs4mLIVEq/FCl597m6eM80k6s6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063897; c=relaxed/simple;
	bh=NYl8h0eIOF18Xsbeiu5QkpCRbTJqepTHI1f3sdTwlG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aj1coyCyjEcLGCYzGBOF+L4QMJmh9PZgkK3xrm9r1zo8L92qSqY6MhMNl3XXEeyXH+sU1uVy+fS12M8AtEQL/CbCTJGn4ptrPZCHzyhBgzjOLxsAWWtjPQkQWsy7sognhZ/Q468JYodBStZXU6jQBNasMkl+M40fhZuCt+BQppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=jKmkK+sv; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id EB8EE60C04;
	Fri,  3 Jul 2026 03:31:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783063895; bh=u8wWtMeZ320+Zv3+97ABw7lenLORkz5+7BI+eoX/piI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jKmkK+svOliKFf/TIA623s+9iMBvKYYcjUniiMBv4qb2NcubnegH5EiFqOyvwZImg
	 7l2Wyg/3ZMcYIu3BryoMYfECm/J/rZPNXxx0f0mbG1RF8ZB6wjFBGUxKMSMximHtaR
	 6S7zaOCg02/++l2f4iCMvT5r5oA3lb5Rh7erVxcg0DIA7wBA9eLz1QKD92JsZAJNmM
	 d/v0J+giGz+heDihwgzumQrTczHABSY+aQnFX5D/jRvI+NDixFNwAi0ytm1ms1FmmW
	 EbVupYKldPpaCiQlVWFfCRBqZHcSjcmk3jZdYhpJV3vgtMYwk+f7GoH7bclp1v19He
	 bcJKoeBYXFejw==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:30:31 +1000
Subject: [PATCH net-next 12/12] net: dsa: validate source trunk against
 lags_len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-dsa-rmu-v1-12-a03febf20bb4@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783063828; l=1024;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=NYl8h0eIOF18Xsbeiu5QkpCRbTJqepTHI1f3sdTwlG4=;
 b=GdCs7/5TITWGHQUgBv1h6lw+qc9K/uuiQGNBSXZ4ASR7LHQoO88b9IqjxR14pFMCUlA3XO1tP
 qQZYC5IDLngCVpiMlVfPK52cl5rfpYNYbttfxGQ+ejXV9OSk7nuF0M3
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304409-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFC9C6FF9E8

A DSA frame with an invalid source trunk ID could cause an out-of-bounds
read access of dst->lags.

Add a check to dsa_lag_by_id() to validate the LAG ID is not zero, and is
less than or equal to dst->lags_len. (The LAG ID is derived by adding one
to the source trunk ID.)

Note: this is in the fast path for any frames within a trunk.

Fixes: 5b60dadb71db ("net: dsa: tag_dsa: Support reception of packets from LAG devices")
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 include/net/dsa.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index af16347a3d331..9f01ea5bbd877 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -190,6 +190,9 @@ struct dsa_switch_tree {
 static inline struct dsa_lag *dsa_lag_by_id(struct dsa_switch_tree *dst,
 					    unsigned int id)
 {
+	if (unlikely(id == 0 || id > dst->lags_len))
+		return NULL;
+
 	/* DSA LAG IDs are one-based, dst->lags is zero-based */
 	return dst->lags[id - 1];
 }

-- 
2.43.0


