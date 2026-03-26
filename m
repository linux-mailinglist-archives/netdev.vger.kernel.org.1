Return-Path: <netdev+bounces-271957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ORVBJ0GxWnZ5gQAu9opvQ
	(envelope-from <netdev+bounces-271957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:12:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E033310E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A57B0319B32D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEDD3CF677;
	Thu, 26 Mar 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsUprecA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1B3C660D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519059; cv=none; b=E97rjLztEyf/Vm10GIdPfu5LKBtM/MUkRyNMhWX/8xArC3r/ZJRw/uy6JdQoarvtjX+QGFlBph3bMTzCNpYgrzVjC8GJfNZ2nALXw9XXqU2PgPGYsgXaoQhV7dFyI+zBFngUsmOQqRLk32esvUh+Z/rQzZcLccPqjwZCtMT4aWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519059; c=relaxed/simple;
	bh=Qds9B5ILFmS8Vp3JnU8z1SyfzpPtjdN9afy1Htr5iI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7VmcpURcPu5Oj8K/8MlbhEPpOmdDn7kWrdX+yaijaXiFfYvKkwFld+qwfZ4xI3k5ew21yYS5bS0bOT3ZSL5gLXyrUaREAhvbzv/OLvM/R2ZB2oje6qMkuvuO9+BjqreWtbbyFRmsXt5HhzdpNyEOToW8vRQ0k1Z6t0TpJynwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsUprecA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D84C19423;
	Thu, 26 Mar 2026 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774519059;
	bh=Qds9B5ILFmS8Vp3JnU8z1SyfzpPtjdN9afy1Htr5iI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qsUprecA4pPJAJo4/LuiJ7rZyt7ml2VX+RmWAIKKi98ppChWRG90f1tLKNSEW57IS
	 Lp5JwqAIcgg8omPRgb29RzkYaORUTvVgEiiJwVdcNyt/IRz5oaMYiQKojblHfvgtlv
	 EmhZcmF61Ik4GyvHpMvBYAEtoYxz0NET8Aa5HQFDEC/bYcUM3WAifwTT3LWTcZBo7J
	 rXU/owqrW7hVfnGKJfRx96mkIaODzIUEc9mUKlNE6hEtZmb0rh4RHZe2iG2pyE4VXV
	 /sj/cpxOMbglz17XOnwFq4YonHoBNMODAwRX28Hr3nEdpGvsmmIzrv/GtG7QE1EEMn
	 /fOPNvZ4tgxlA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Mar 2026 10:57:32 +0100
Subject: [PATCH net v4 1/4] net: dsa: ks8995: Add shutdown callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ks8995-fixups-v4-1-989abba8f077@kernel.org>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
In-Reply-To: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 827E033310E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


