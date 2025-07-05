Return-Path: <netdev+bounces-204298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E05AF9F5D
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 11:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF340565B1F
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04AC242930;
	Sat,  5 Jul 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB9qBJAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BC1A3142;
	Sat,  5 Jul 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751707585; cv=none; b=l+GGNBuHCGiqSeDGr/e/VzIzCCtI70bW5DrEFfQybUa8woB1PPxxh0CMXP7MfqUMDag+PhXBrpl6zq9wvVULk5mxxih/oNDYdF51v+vc3jhrBpYY5+IUsRusr3eXe7VaFMyg3t32Qvr84+mvdSSS/8hna8DvfPDlux1evjeTbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751707585; c=relaxed/simple;
	bh=1jcC9TceXdzZtJGhy6YZenRnqlihRmJcKT3PDwgXNQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZ/WakC3gYKOYHc2nGu9O5coAnvkQjNLadf/xEEy4/M8q3A5pEq6MgzfQbpBvR1XfyvEzpjx/jU0tSINEwoXQkeUNHyQnCpspEuYryNFh8ZNT+OsAjGfaHUJeYOOYb5+tg2oci1bndseTNY9EZ0Ee1PfRnBaveAtiMrIaHXsYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB9qBJAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71487C4CEE7;
	Sat,  5 Jul 2025 09:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751707585;
	bh=1jcC9TceXdzZtJGhy6YZenRnqlihRmJcKT3PDwgXNQE=;
	h=From:To:Cc:Subject:Date:From;
	b=VB9qBJAL5wEas7rR1Fgu7qGWHgA33k1e1SYrK+QclWk3lsv76VjcMwC0l6Y4ef2mW
	 Cfmljwn0iIZWkFSxCwtCl12Z6IwLWg6VGDBVMXyHfbEAmsHj+ZgiDKhV+3NsaeMOpO
	 mLexJCm2so/PYFBtfOcnsV79Lay4OZlrkobZcBUILRE+IrwkmSmeYJD0ZlbHxQOD90
	 mEWc4IYNTHELDdjO6LA6R+UG7k8upuNJ/gpdPfTn1Bx3xszgE9eU2KIY0ofjTsQTxP
	 M/7ZYozN+vRnmcXNqP3tlS5xM19QNM8vWuurA4UfHtxMJIQf/jmfDHxkcNydbUvFKG
	 8LqeGmPawkYfw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: add support for dwmac 5.20
Date: Sat,  5 Jul 2025 17:09:30 +0800
Message-ID: <20250705090931.14358-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
compatibility flag for it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
Since v1:
 - fix the commit msg

 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index b9218c07eb6b..cecce6ed9aa6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -59,6 +59,7 @@ static const struct of_device_id dwmac_generic_match[] = {
 	{ .compatible = "snps,dwmac-3.72a"},
 	{ .compatible = "snps,dwmac-4.00"},
 	{ .compatible = "snps,dwmac-4.10a"},
+	{ .compatible = "snps,dwmac-5.20"},
 	{ .compatible = "snps,dwmac"},
 	{ .compatible = "snps,dwxgmac-2.10"},
 	{ .compatible = "snps,dwxgmac"},
-- 
2.49.0


