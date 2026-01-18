Return-Path: <netdev+bounces-250924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035CD39A3A
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 23:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D27FC30080F2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A12F25E4;
	Sun, 18 Jan 2026 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFlcauFf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71A23B63C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774065; cv=none; b=T3TyT0WgSP0nk4QxAN3OUUScf86XfCULy8FrODl0EMwlPRUk3OgIX50gxdSE6EpYMf2oNZRNWv4BkAtukkNgKMboE2GOHYMpJWvauunZviQM7PYG0PCHq+Kicpc3GmAE/lxdKfQUrEV+oZcadCkNXWskh/wuaP7Chl3r9432xoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774065; c=relaxed/simple;
	bh=/FZC0o/x0AcLWXigkij64zA5BjdpDay/64NTClKGZac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D383WBfzQrcm21fs82rIbgBsaFNdCU+EIo8lzWMaUz/J5ZAa4Mxvoup8u4wkBF6KbkqXbV44mFI7GxTGdkgEGWPpDCYAOm1H5HPDGRhlKHq8c+YRmmQp2RZy30dR+35EaN7o4BbdMVAQ2+rrkRmEPzwYXjuV2XH1mhCYHBnd+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFlcauFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C214C19424;
	Sun, 18 Jan 2026 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768774065;
	bh=/FZC0o/x0AcLWXigkij64zA5BjdpDay/64NTClKGZac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tFlcauFfBkJ6W28z9yLezGMP6Ktje5MAs/QlcGnM+DbCuXFmleJcFX09X5o7gxSvg
	 5IUhF75QItNodljYNKb//kDuFVFiljn00lEIglDZ5rE/Kvt6txoQ2DXVE8CyYeCKk3
	 qFGDPPXpyQCTcGqWecbZ+T2cUj2+u0+Gp1ZWtkH5S2e+9rDF8WC/Ynnmd7kmIDQbjl
	 OF9MHgC++xLd7CUiQACahBHLfsBk4eCHJyof/7j+8W5+TEfn8IS6NwvFpEmMvqgSuH
	 GB1kWYpKK1W2WydORdhLq01p815ftBFv+TYKAsq4Cig6OHFT86VdswUlnMSEAbdP51
	 9/ntDs5IBgFsg==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 18 Jan 2026 23:07:31 +0100
Subject: [PATCH net-next 1/4] net: dsa: ks8995: Add shutdown callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-ks8995-fixups-v1-1-10a493f0339d@kernel.org>
References: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
In-Reply-To: <20260118-ks8995-fixups-v1-0-10a493f0339d@kernel.org>
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


