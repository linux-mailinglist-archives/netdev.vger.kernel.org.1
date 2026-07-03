Return-Path: <netdev+bounces-304436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7tzuFg1sR2o1YAAAu9opvQ
	(envelope-from <netdev+bounces-304436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F26FFD2C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=UmiWZeSO;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304436-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304436-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E7F313A854
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA0370AEB;
	Fri,  3 Jul 2026 07:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1A370ACD;
	Fri,  3 Jul 2026 07:47:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064873; cv=none; b=csL5A3iLwwLjPlzzcLtvccRCRqrrzG6DHdXgPzcf4PsigMIQU1YLlZIg8uWcc1n2LRWvCEWStZWr44YIaB9oYA0GSmz7J8rQEfBF5sNyfXnsPja78v1YB+DoyKSKKOL/a3mt/sjDgsjXuK4FvJ251liB/Ti7DTWfO9h4piYWbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064873; c=relaxed/simple;
	bh=JYnxmNvnYqhGSdwMLK8oOIlK/aGv1u6novLaSFIFapw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tq0jQkIm4+XEvivcGWf6AtfaTMy43Abk9GETB9lFXjImwBzuWZfF5vvtVlEYLmqxP+8zZfdJ8J/XZe0OOhjg0AiqFGcFurkdta92OV6zKOjjesDFn3gNk4c505EzE6JYZ2hsrvAAwMvtuRQjIVhOk36fqSIS6UjJIHp+CUkyJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=UmiWZeSO; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 373D660C04;
	Fri,  3 Jul 2026 03:47:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783064871; bh=ar982RBJ2nzWFY1F+G96iIk7kopMb43rBsnBWxaJCKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UmiWZeSORGLIWe6iHG0ISDL0wEh7ufhaR7MPzJDtKBocby6PzycnRXZIypMVSUQOX
	 U1y12L273szBuUVWwLU8viZ+OWgz1imY+B/wGneURhjh/n8DZAoFy/K7E47nnhOKX/
	 mDt/fQi2rlyPU6cQ5Lv6w5gcAy4syfkNlUk73vHiMkoBezoqiQtQb7EAZkRwuzVOrZ
	 AGd+UZZ4gKBTiU9xS3fjCe1Ez/z1jmSwNm6QGheUD6Jag42qijJdVqJ9FnFy3G9CNf
	 FNS7n/TmBgm0MVmO/Rb9IEJMPsH/3YO+JrjxRbh8CZbz+XZ6O8XYGyVOjYyuWJOjaR
	 jcSBV3PRRg5dg==
From: Luke Howard <lukeh@padl.com>
Date: Fri, 03 Jul 2026 17:46:49 +1000
Subject: [PATCH net-next 15/17] net: dsa: mv88e6xxx: cancel PTP polling
 work on .shutdown
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-next-mv88e6xxx-rmu-v1-15-991a27d78bca@padl.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783064798; l=3643;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=JYnxmNvnYqhGSdwMLK8oOIlK/aGv1u6novLaSFIFapw=;
 b=5QJNh0eNpw4KPaTMa44uud0VQrupsL0OZeSEm5y7eyY3GhjbcxBn1ggOi0IBDXOHQxAE4gcL6
 mhRsYhPZTbiD+5hyKnVIqiHhbhWaJHzVKufWuxENmQP+KjgaUzzVJx6
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
	TAGGED_FROM(0.00)[bounces-304436-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A25F26FFD2C

DSA core's dsa_switch_shutdown() only closes CPU port conduits and
unlinks DSA uppers; it does not invoke ds->ops->teardown(). On
.shutdown (reboot), the chip's mv88e6xxx_teardown() therefore never
runs, and the PTP overflow / TAI event delayed works are not
cancelled. They continue to fire as the conduit netdev is torn down
by its own driver, racing the teardown and crashing in the RMU
request path when conduit->dev_addr is released.

Factor the work cancellation out of mv88e6xxx_ptp_free() into a new
mv88e6xxx_ptp_shutdown() helper that leaves the PTP clock registered,
and call it from mv88e6xxx_shutdown_common() before
dsa_switch_shutdown(). mv88e6xxx_ptp_free() now calls the helper
itself, so the regular .remove path is unchanged.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  6 ++++++
 drivers/net/dsa/mv88e6xxx/ptp.c  | 14 ++++++++++++--
 drivers/net/dsa/mv88e6xxx/ptp.h  |  5 +++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 531a59093ef97..3d92c59de7b5f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7543,6 +7543,12 @@ static void mv88e6xxx_shutdown(struct mdio_device *mdiodev)
 	if (!ds)
 		return;
 
+	/* DSA core does not call ->teardown on .shutdown, so stop PTP
+	 * polling here before the conduit goes away. Otherwise the work
+	 * can race teardown and dereference a stale conduit->dev_addr.
+	 */
+	mv88e6xxx_ptp_shutdown(ds->priv);
+
 	dsa_switch_shutdown(ds);
 
 	dev_set_drvdata(&mdiodev->dev, NULL);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index f7603573d3a98..f6ce3232d10ff 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -551,14 +551,24 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
-/* This must never be called holding the register lock */
-void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
+/* Cancel any pending PTP polling work. Safe to call from .shutdown
+ * paths where the PTP clock itself stays registered.
+ * This must never be called holding the register lock.
+ */
+void mv88e6xxx_ptp_shutdown(struct mv88e6xxx_chip *chip)
 {
 	if (chip->ptp_clock) {
 		cancel_delayed_work_sync(&chip->overflow_work);
 		if (chip->info->ops->ptp_ops->event_work)
 			cancel_delayed_work_sync(&chip->tai_event_work);
+	}
+}
 
+/* This must never be called holding the register lock */
+void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
+{
+	if (chip->ptp_clock) {
+		mv88e6xxx_ptp_shutdown(chip);
 		ptp_clock_unregister(chip->ptp_clock);
 		chip->ptp_clock = NULL;
 	}
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 95bdddb0bf39f..90031b05d2514 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -68,6 +68,7 @@
 
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip);
+void mv88e6xxx_ptp_shutdown(struct mv88e6xxx_chip *chip);
 
 #define ptp_to_chip(ptp) container_of(ptp, struct mv88e6xxx_chip,	\
 				      ptp_clock_info)
@@ -87,6 +88,10 @@ static inline void mv88e6xxx_ptp_free(struct mv88e6xxx_chip *chip)
 {
 }
 
+static inline void mv88e6xxx_ptp_shutdown(struct mv88e6xxx_chip *chip)
+{
+}
+
 static const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {};

-- 
2.43.0


