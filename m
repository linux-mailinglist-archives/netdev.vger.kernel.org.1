Return-Path: <netdev+bounces-251141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE725D3AC33
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA142301CBA7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0B1FF1C7;
	Mon, 19 Jan 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1OFHvsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92091ACEDF
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833012; cv=none; b=G4oU8I67SwB/HAmJB61Xm4l7iS3VojTNDewaeEMHgFeTSWBnySMV0uSDA1STFh+K/ExmSrtArtLNvuQiYZm60seC9QTCsNibycXNfVQJR8q7AOL8yxaF5O6MCpzp4+W7y3J1vWy3hIbASKBce9YGmb5mTnlkTyvfhU20cjHxpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833012; c=relaxed/simple;
	bh=/FZC0o/x0AcLWXigkij64zA5BjdpDay/64NTClKGZac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pL6mLuzakUvXC6IbF7IJccEDx/7Ao1d/23DyKNqc2NjMNQrRc45fhF1hkZO7y5dMLTXDUXygPSbIxDmbRj4jfm6lwYoxE2DR0LU2CKamWtTal7v4Z5CLKPN1qPpS7hL7wWRm1LKL8t9669REUX+0T2G6VYM6N7g3uLNVfRAt4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1OFHvsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE10C19423;
	Mon, 19 Jan 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833012;
	bh=/FZC0o/x0AcLWXigkij64zA5BjdpDay/64NTClKGZac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G1OFHvsXA6CwarwmJtMk8fhGSlBd4Wsq5d6RO+r4iEPrxjSH2vmau3GRR47N+oCTr
	 frPV//ht+EIXcNdTrq1Xh2pSYCR3X9owAxe2t4Mh7Vr3UcU8EY/tKUZTMGxcgIzHEo
	 VDufEv53wcT72tP6o3c0JmKXJpZ3itlMRw+iHE22qjLWha7X/x9zUSeghn4cuEdfWN
	 WWf2PRd5GLxMaax++nKoolbvDjSa37tUzgIDZY50Br5ORZ3G+Ad1tmyxIp+FQZlR23
	 tkjcCXMpZzLU0nvHl5BLNlf/4atppNbS7rH26am/OOrpIVicb0gfRqtBRcALfh7fER
	 ZsEWcUbROue9g==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 19 Jan 2026 15:30:05 +0100
Subject: [PATCH net-next v2 1/4] net: dsa: ks8995: Add shutdown callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-ks8995-fixups-v2-1-98bd034a0d12@kernel.org>
References: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
In-Reply-To: <20260119-ks8995-fixups-v2-0-98bd034a0d12@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The DSA framework requires that dsa_switch_shutdown() be
called when the driver is shut down.

Fixes: a7fe8b266f65 ("net: dsa: ks8995: Add basic switch set-up")
Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/ks8995.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 77d8b842693c..ff01097601ec 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -838,6 +838,13 @@ static void ks8995_remove(struct spi_device *spi)
 	gpiod_set_value_cansleep(ks->reset_gpio, 1);
 }
 
+static void ks8995_shutdown(struct spi_device *spi)
+{
+	struct ks8995_switch *ks = spi_get_drvdata(spi);
+
+	dsa_switch_shutdown(ks->ds);
+}
+
 /* ------------------------------------------------------------------------ */
 static struct spi_driver ks8995_driver = {
 	.driver = {
@@ -846,6 +853,7 @@ static struct spi_driver ks8995_driver = {
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
+	.shutdown = ks8995_shutdown,
 	.id_table = ks8995_id,
 };
 

-- 
2.52.0


