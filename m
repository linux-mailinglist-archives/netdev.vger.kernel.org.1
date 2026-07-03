Return-Path: <netdev+bounces-304422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VaszFlZpR2qdXwAAu9opvQ
	(envelope-from <netdev+bounces-304422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:48:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C489D6FFB9B
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b="APIAQ8/O";
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304422-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304422-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C87B30559EB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC63A36E48D;
	Fri,  3 Jul 2026 07:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF836D9E9;
	Fri,  3 Jul 2026 07:46:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064809; cv=none; b=tlIE5C+vh+v9Kji3M42F0BzZWHNgQkcElXjb4dcNIvgoIYXwY8p96EIp9ptzouKTdUZpQslQ6RlQEeV3jMMBirI3JG0OG7IX/Jt/63Q4/Fno213ulb2ByV7STzh7sq4D1lp831iWFDL+LRGg2bNZEKuv3EUmwQG8hA3s9x3ryJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064809; c=relaxed/simple;
	bh=N/u28YFvqlyff6csSQGnOMirUz49m5lxx04nVIZ5RFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=helP+ON0DGuq1Jhfw4SPe+VPMsWGR/XEXNUuSVQy4t/vXZ0j94yU5VfrxaWZNGVGk76FGzKacR2BnLxKVAJiWYwFuLly3VqkN/tMOxEpYSQ+AVUqHnDziKe82bpKL6EdPvIRA98dcmx4tZX4duW0X7/4UBDsdpp8nUbFjCLtKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=APIAQ8/O; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 6769760C0B;
	Fri,  3 Jul 2026 03:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064807; bh=s0nqKp+6lTW8fkYEJLeW1hGhdrrWHAgoFBoUgfS73vw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=APIAQ8/Oc4RYsYICCsqrr+K+owv/NgeiTyWETVsBLYcXWSTMLbkgFkbTOTwygXVpE
	 CjrySWvJAbbJlr2GBFtgwykhjZmbWaShz4RO2DABYGJ1qNUF+YfzWoJjTkwJrSfz/Q
	 zeqGCFJKTC+HqOumDsv6IydrQbLu7NFfODnc+36Nrxwl4dVXUfnLLUt4jmL8hTQris
	 AMz6RlnWEVkxPMyvn/m17vMpcJkrfoCtJafAkjJQXqmZ+stRJ3wgobmj5m13xlY+7u
	 Wy5xNj+Xvxdr3TVGTHiDFhPmUzeDFWR26d71M45YqbSXubAN5XfRlvuh3yL3YsjEZ/
	 OeDZ8fya55n+g==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:35 +1000
Subject: [PATCH net-next 01/17] net: dsa: mv88e6xxx: use
 lockdep_assert_held() if CONFIG_LOCKDEP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-1-991a27d78bca@padl.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
 Kieran Tyrrell <kieran@sienda.com>, 
 Ryan Wilkins <Ryan.Wilkins@telosalliance.com>, 
 Mattias Forsblad <mattias.forsblad@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=864;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=N/u28YFvqlyff6csSQGnOMirUz49m5lxx04nVIZ5RFs=;
 b=sCh3W0w2Mv/FPYbT+fqYjo08uCcnpP3bxSPCYK7b6bzD6Ivore7Kb3yeRpSSN36m0UlgQOI+7
 G7kW+SjF4jMCbiXtonOCxTiNCwWE/EOcqvqszlDLr7wgqTM+T8Hc/he
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
	TAGGED_FROM(0.00)[bounces-304422-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:f.fainelli@gmail.com,m:cedric.jehasse@gmail.com,m:mh@rme-audio.de,m:max@huntershome.org,m:kieran@sienda.com,m:Ryan.Wilkins@telosalliance.com,m:mattias.forsblad@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:ffainelli@gmail.com,m:cedricjehasse@gmail.com,m:mattiasforsblad@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	FREEMAIL_CC(0.00)[gmail.com,rme-audio.de,huntershome.org,sienda.com,telosalliance.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C489D6FFB9B

If CONFIG_LOCKDEP is enabled, use lockdep_assert_held() rather than an
explicit check for the chip's register mutex.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 80b877c74513d..eada2f71cb7b3 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -48,10 +48,14 @@
 
 static void assert_reg_lock(struct mv88e6xxx_chip *chip)
 {
+#ifdef CONFIG_LOCKDEP
+	lockdep_assert_held(&chip->reg_lock);
+#else
 	if (unlikely(!mutex_is_locked(&chip->reg_lock))) {
 		dev_err(chip->dev, "Switch registers lock not held!\n");
 		dump_stack();
 	}
+#endif
 }
 
 int mv88e6xxx_read(struct mv88e6xxx_chip *chip, int addr, int reg, u16 *val)

-- 
2.43.0


