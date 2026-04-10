Return-Path: <netdev+bounces-277542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B+WAiJW2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215D3DC351
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06EB6302FB5A
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670323A0EBB;
	Fri, 10 Apr 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ig/U9x7C"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1739DBC9
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850761; cv=none; b=XIkHRsVzaSvuhmX7JNFt4FoRgNpJpIRWTczNBMTv7yi+Cft+w55v9g4s7EH33zS/87MkB+YQtbPqqavMoQKrI/dwXt1bQQX9QmdLDIk0xz5sb6CXx05oRAgCNWC76OX7C5iMe0/t0ZODFcjUVX+5eXS4JV4Edwxu6ngBLllFaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850761; c=relaxed/simple;
	bh=do4o9qY0uLFmroGHU0FAD9AGkWE+vKquSkRX/0oiZTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQTu8zzA2HEh3kFx/CZUQlgGnuknndGYZ8skLuoxEQeTl44ozk5dBEjl0X82BFg0dLZ9wJmeI8OmAmpvCyCDMzU18dgTtH+JJDErp9zrfNo1zZ/cTjshB+XavRRyBbhLF43ljd7l3rk+c7bKu+fBcUYfOoT6CFzovalY85prm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ig/U9x7C; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8B1761A3269;
	Fri, 10 Apr 2026 19:52:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A044603F0;
	Fri, 10 Apr 2026 19:52:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7E4B10450082;
	Fri, 10 Apr 2026 21:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850757; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=prrOPMIw7nMYQCmGEiMpPgqNtOOmZZOsMRZWzN/Gv3k=;
	b=Ig/U9x7CZBij4EB7QD3FbrOsXIok3CtJ74K5fJ2CXbcUdVyTxIbavsx8ZBpLdFLmSAgfM8
	dcr1Qspae9YUIDSwzs2BbIUgMnT0nXQxBeZNoO2odSSlM4GXUmRtY6ONU2OhOTjnMbTntV
	TSH4IIGNLAmGPDiOLPFnUnND2Q4JjgQIzAo61QiSbCna6+lXpq8bbJo1qfLI6ZBasv37HD
	ahDDCLRqm8q1lcmpH9TRNdsiRBAuSWwm3DCkFcoYc1sxVDj7NwwnsgymvgppLPnZ1ZgHIS
	03FCWnRY2GeDF4EHP/M5+/1c4pC/KSxOCGlGeLtin/P10kkAvSfRm8flqgioXg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:52:00 +0200
Subject: [PATCH net-next v2 12/14] net: macb: re-read ISR inside IRQ
 handler locked section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-12-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277542-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0215D3DC351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IRQ handler reads ISR register into the `status` stack variable.
If empty, it early returns. Else, it grabs bp->lock and iterates on
the status bits.

If we tried grabbing bp->lock while already acquired, we might have
slept and the status might have been updated. Our most likely
competitor in this race (condition) is a swap operation, used in
change_mtu and set_ringparam. It is the only MACB codepath that resets
interrupts and HW inside a bp->lock critical section. Other codepaths
that clear HW IRQ status do so outside the bp->lock critical section.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ba7463a857dd..81beb67b206a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2190,6 +2190,13 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 	spin_lock(&bp->lock);
 
+	/* `status` stack variable might be stalled => re-read it */
+	status = queue_readl(queue, ISR);
+	if (unlikely(!status)) {
+		spin_unlock(&bp->lock);
+		return IRQ_NONE;
+	}
+
 	while (status) {
 		/* close possible race with dev_close */
 		if (unlikely(!netif_running(netdev))) {

-- 
2.53.0


