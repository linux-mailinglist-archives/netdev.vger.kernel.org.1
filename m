Return-Path: <netdev+bounces-240054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A907C6FF6A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB6123584AF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF037375D;
	Wed, 19 Nov 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX+K4FSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E47371DF6;
	Wed, 19 Nov 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567599; cv=none; b=GhlZpSsPznUnfTwfXjOtvb5fbHtJ1Krh8cQQsSuRpwsYhyet/CCLl+6+xgUbVS9VE9BtfEaVq6CI/ydHbGt9xcI8TN/8jbAQ5scaNlZiVYCcyAzMlAWIUD4nh8pgF/v+YqllJ4HvGYy/pwRcpfUeJOgjkWKmpUju9YBxooPxDko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567599; c=relaxed/simple;
	bh=ghn1DQMvwDFb2t8E3blcc0GQRRX7k47nsQNotsdpd5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hg980xYWPUlgychblnQAtSsiiOjMPFDwBZDIXkm3Qv2BeLUo6/sDwKtjRMbCvCvMFQobP/B8WhU7XhiRBKILwcCRdmBh+WEinpbcpQdSE3Xk2I8ABXb/3poywTx7xXP+rNUr9vAEl/iW6OwUVBvRsmSsF4kt6TE9XPpz6+itQ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX+K4FSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6339C4AF14;
	Wed, 19 Nov 2025 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567597;
	bh=ghn1DQMvwDFb2t8E3blcc0GQRRX7k47nsQNotsdpd5k=;
	h=From:To:Cc:Subject:Date:From;
	b=LX+K4FSDDP4e9yAEryXqFyjA/EQPdkOCtujeK1HOh4xZoELGg5FYGLKkmK42o0XBO
	 88LV5Z4Xcp0LVexLHCGjyrmQK4hIPPsEFJi8mwwBRGn0zL3dWUxTVAJxaIWAcLbzrX
	 wkc5Cv+tRibnjmRcjZiO3WsiORlul+yjjCDbVDxHQqk6OXT/hlHSjcNbEkq4D3cV4E
	 FS3c2VIXH4jtiu1fpJLE4svc5x+tS6oF7fo+xBJcjIyehIOX8auitNcy4GKdUMlhkF
	 2EIgcAw7Ped67nJvYNUZSAze5OjzWKlVyrXW2T21L9sFwQ2wnoPLq0V/bNvwm8j7HZ
	 doxPGSbZI9KIA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 resend] net: stmmac: add support for dwmac 5.20
Date: Wed, 19 Nov 2025 23:35:26 +0800
Message-ID: <20251119153526.13780-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dwmac 5.20 IP can be found on some synaptics SoCs. 

The binding doc has been already upstreamed by
commit 13f9351180aa ("dt-bindings: net: snps,dwmac: Add dwmac-5.20
version")

So we just need to add a compatibility flag in dwmac generic driver.

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
2.51.0


