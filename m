Return-Path: <netdev+bounces-115490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D55946988
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 13:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB01F21606
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E428248D;
	Sat,  3 Aug 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8tR9/qV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272DF60B8A
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722685523; cv=none; b=jDTNJMgubDHmUi7rKPc8BllPNUs3327B81VKoRYzNNZ+rCc/DKOy587Bceju8onKNgACKDzyA1nlF5ucZBGmm4wbO+2yKtWHfSpjM+k/Mp+KAmwtRxSPZgYJYD0q1MR6MO6DHCyjWX7jVf2cbJNTTj94IDh0eEX8dIB4fWtqias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722685523; c=relaxed/simple;
	bh=dd6YAia4jNTdcf/yYWcuaEiKRPwYKrPqI2UXVgMGMu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXc4zR4TYU9f503/c/scG8ykNXzLURqq+Wne9OZvU1vOt7xhQBny7SN4enN35UNShTuyw4KiiaSTIKbYDKpC5ug7Ysjse+jgHbPBGKXDUC1YBUpksMoukryPbOtkNu3O1rdGebf8yNU0TMz+HMcw8U3axkueY3RvNrA9GWf3qkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8tR9/qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F85FC116B1;
	Sat,  3 Aug 2024 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722685522;
	bh=dd6YAia4jNTdcf/yYWcuaEiKRPwYKrPqI2UXVgMGMu4=;
	h=From:To:Cc:Subject:Date:From;
	b=h8tR9/qVantRPE401WVyNPu5nFdTKr/ufxyr88Ns6pXZCMpOKryS07icjZdOxVOGp
	 75h41YUXC0XmoiXHLgIMXQaley441vRm62zfXbw3Y5WeP9VtH4nUgeMOn8zWegCjDr
	 Zl2vaQv3DQV7rH7s+imH1i4xLDIVMaY6yCkP45HJ3I7KwOuxGd5SQd9XgcjFlZIZWo
	 rsBKJk34EoqVOBPJ5mIFTN0orMnw9RVuYpvLNC+GYMZxHUAkBBPdnz3pnenDCRAt9f
	 iglQAuVv5kn+NBY38fZL9qz947mDdO+Q6uX0R4R82EgaC2hrZDupLfvD4mw9D7FLSm
	 jQ0I1wv14Fj/Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH stable 5.15.y] net: stmmac: Enable mac_managed_pm phylink config
Date: Sat,  3 Aug 2024 19:30:44 +0800
Message-ID: <20240803113044.2285-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shenwei Wang <shenwei.wang@nxp.com>

commit f151c147b3afcf92dedff53f5f0e965414e4fd2c upstream

Enable the mac_managed_pm configuration in the phylink_config
structure to avoid the kernel warning during system resume.

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b0ab8f6986f8..ed552852bb7b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1286,6 +1286,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
 
+	priv->phylink_config.mac_managed_pm = true;
+
 	phylink = phylink_create(&priv->phylink_config, fwnode,
 				 mode, &stmmac_phylink_mac_ops);
 	if (IS_ERR(phylink))
-- 
2.45.2


