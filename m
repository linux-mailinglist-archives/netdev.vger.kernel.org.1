Return-Path: <netdev+bounces-259477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK61KyYdl2ktuwIAu9opvQ
	(envelope-from <netdev+bounces-259477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:24:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB015F73D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44C5330293D1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249B33DED9;
	Thu, 19 Feb 2026 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZJbc/+e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5617ADE0
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511065; cv=none; b=jI6yoF7pYVtQezJwVBfdKlLCQEuRPiPJ9hceHgzdqNu3BkEU28+6baqMBY454mg59BwU5btNQMQHJFujeUTAJVlf8/1GqmlmpDZ6dk5qROeI/BIb88bCkQ++fxd+8cbbVJwDbpKy9C/V6/cjV2lov+2nRAk/DxOb5WVb86bbgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511065; c=relaxed/simple;
	bh=Qds9B5ILFmS8Vp3JnU8z1SyfzpPtjdN9afy1Htr5iI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DepjpozG4+OjYPa6KoncsuyYeVYjgP+UHxZKImqZrPbVH/x1372D1GwyxxczTs1TrSAHTfoFTNRQpdS3UGyasryxaOVuMAJe5AJ3FpDWaguNek+bbKV0/wia+JDW9d/mKltoEFe2Lqh0tCGDElhNqhun5K48h0ZIOlmWIc0TnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZJbc/+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2456C116C6;
	Thu, 19 Feb 2026 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511064;
	bh=Qds9B5ILFmS8Vp3JnU8z1SyfzpPtjdN9afy1Htr5iI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rZJbc/+eUfpFmZ19tuE/UZ8QpPXnNGOzfwQDL8o1x1MgqPML39Kg7jXYXlyFRyxlM
	 CeWNDZze3NskBHEo6hdJuiZW/7AQbklCIyODkx7alQ3ilfLdHgQdjGbcgGXTp6wm5c
	 lmyL1HTQlQwo4KXNmAEwXrJ7Evb1O67MwRg2e6SxX4MILLX54viYzeJumlZaZ+UkRQ
	 nt+p96zRlG4ECTXbcgCRFbWiZ4XeG3Kl3vFyNTWmyQumgDSvsTM98XJovCHajv0Hcg
	 sUHFMUc4OdzhULdjc7iSgyXUjj4y4vg/j34xqBeYNVtgJAwkfPmTPJbzG5n1vLD+5P
	 ajWVvhItLLLVg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 15:24:17 +0100
Subject: [PATCH net v3 1/5] net: dsa: ks8995: Add shutdown callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-ks8995-fixups-v3-1-a7fc63fe1916@kernel.org>
References: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
In-Reply-To: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05BB015F73D
X-Rspamd-Action: no action

The DSA framework requires that dsa_switch_shutdown() be
called when the driver is shut down.

Make sure to also implement the mutual exclusion required
by checking the platform data pointer to be NULL in
.remove() and .shutdown().

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 77d8b842693c..2522c9057382 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -833,11 +833,26 @@ static void ks8995_remove(struct spi_device *spi)
 {
 	struct ks8995_switch *ks = spi_get_drvdata(spi);
 
+	if (!ks)
+		return;
+
 	dsa_unregister_switch(ks->ds);
 	/* assert reset */
 	gpiod_set_value_cansleep(ks->reset_gpio, 1);
 }
 
+static void ks8995_shutdown(struct spi_device *spi)
+{
+	struct ks8995_switch *ks = spi_get_drvdata(spi);
+
+	if (!ks)
+		return;
+
+	dsa_switch_shutdown(ks->ds);
+
+	spi_set_drvdata(spi, NULL);
+}
+
 /* ------------------------------------------------------------------------ */
 static struct spi_driver ks8995_driver = {
 	.driver = {
@@ -846,6 +861,7 @@ static struct spi_driver ks8995_driver = {
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
+	.shutdown = ks8995_shutdown,
 	.id_table = ks8995_id,
 };
 

-- 
2.53.0


