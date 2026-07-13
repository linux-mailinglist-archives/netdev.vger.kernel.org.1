Return-Path: <netdev+bounces-307042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 557yBEKQVGqFnQMAu9opvQ
	(envelope-from <netdev+bounces-307042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:14:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA08747E77
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:14:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="STJovxC/";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307042-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307042-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 544B43014240
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9BF38C2D1;
	Mon, 13 Jul 2026 07:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBA383305
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:11:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926710; cv=none; b=E17BwY2W0II16ZZAa2Kuoa/AHUX4IX3j9jbNrhhVrbQSP13lq6JwcAGBU6Rdtk6cbATgGbTZuNMlMGbwk8KNLHBxyuy4LFNKP2Nl4IfH8H2OqlcOGfRxMMn0EdWBVgIHf3sBDn+vWtRNhOqMOPh2o/aLLjNROPJqIcGwLM/Ncdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926710; c=relaxed/simple;
	bh=0tx5h/gOw7mSpA6bQ0Ivylr29fJutlF0yRBcE/DtAMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bi8Z7vWGY3jawoo2khw3/bsPp9iKTs93vxqmMEgFUNA9xAd7eYmix/nd1V6/rVraDnFCC9dnw49ek9W+BEUslKmEc0HDoJBbGdBTRnNeuK5gTqyxUgNykmtEmHSB4MQ5shNl+bkx4/ERP2BpohlN7+k3B/MxNr9xN29gl37tDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=STJovxC/; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 786FE4E40D82;
	Mon, 13 Jul 2026 07:11:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C7A860341;
	Mon, 13 Jul 2026 07:11:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F36911BD3A3D;
	Mon, 13 Jul 2026 09:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783926705; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lNaj+7pmUwVXwV8Z90r3nasLl/i2CdZABVfDqyXQdbo=;
	b=STJovxC/VfEKBizaWvwjz4PuaSUSXqXT0t0n0+hSHVLNMa25RFtQEZlmqNhz+WJo8lDBZ8
	4NLNN+na/vHxA8TAPYGPxAAQmPmKpIL7KPGYyucuQMnHTYOSPZ9qHlkheSXNEcBds6BU8Y
	XQPhWomUU1WoxvDEdBsXqS2+8WA8dVJvDvXh6gIuRl115HuK56pByX06aaCi3bcKeRehv4
	HH/QSWqjeddYarySxrWc6BaaWTzJWXBYtfz35OQXJAajIoTL/iE0g6K5zFjcbXL9WOsi4V
	NjW8UJJQJZU1KJ6WtKtjZPMtbjo+woC4OCSq3lyaT+BcNVtfy3vYQs5M+90ptg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 13 Jul 2026 09:11:28 +0200
Subject: [PATCH net-next v2 09/10] net: dsa: microchip: explicitly enable
 detection of L2 PTP frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-ksz-new-ptp-v2-9-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
In-Reply-To: <20260713-ksz-new-ptp-v2-0-7209c05058ef@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307042-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DA08747E77

Detection of L2 PTP frames needs to be enabled for PTP to work at the L2
layer. The bit enabling this detection is set by default on the switches
currently supported by the driver, but it is unset by default on the
KSZ8463 for which support will be added in upcoming patches.

Explicitly enable the detection of L2 PTP frames for all switches when
PTP is enabled.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 89fbc1253f25..be6b8240ac03 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -953,8 +953,9 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
 	/* Currently only P2P mode is supported. When 802_1AS bit is set, it
 	 * forwards all PTP packets to host port and none to other ports.
 	 */
-	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_TC_P2P | PTP_802_1AS,
-			PTP_TC_P2P | PTP_802_1AS);
+	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1],
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE,
+			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE);
 	if (ret)
 		return ret;
 

-- 
2.54.0


