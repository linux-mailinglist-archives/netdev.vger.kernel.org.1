Return-Path: <netdev+bounces-230332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 399BEBE69A9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89EC64FB7CA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0A323414;
	Fri, 17 Oct 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDT2h+jN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9C310635;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681493; cv=none; b=lTuXOj0+qEH/oVPWcg+/oDvCu2a7sOedLjGUT4hAJnOgvDsPtD4zZla31uLyY97AtjOSOg7vaZl1buIhS5i0kPZXWxnUR1LfpJD/LilDYUgiX2CyodyBmO3BwNCtQ6xyRF+FZm1bGnC5i/fd7l9svP30xGTg2BKAajgFlxa8sKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681493; c=relaxed/simple;
	bh=NTA7XXehFna8Lnz9z9hQDJQmt5EcD5cxGnspoWjl5V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBdJZAUvAXRPDQvTXKdO8GemFoJqEqMa6+1wa571bDoCkdb4CG/Mb2Mn2wKedcFCz84xggkYoXx8J3H+JaF4f+lyR86A+CoH8iYJjx2O7ljSH0Tp9iQZenYAFR3xzb3XKfqShX7YAfMh0WzlTqAE9CSwH6TZQrpprouHAluD9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDT2h+jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A785AC116B1;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760681492;
	bh=NTA7XXehFna8Lnz9z9hQDJQmt5EcD5cxGnspoWjl5V8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NDT2h+jN4Fo/V782pJVCyAoFMDQnca+b11ea9IbVH3hZjx0JvKZtsDb6BBFbxJjEW
	 KgBXOBYWrEY29jdKBiR3vbIBwAvxiCfFNcudI8kD5AngbnR6YCXGd7Gm/Un9geOOhy
	 D77x5NWxRh1HnfG5BNY2cWp5KPcDogJIY8suYnFlWyVt8y6Y1DXGOic69Oiyeaku6O
	 jiFtYZC1AUghnKzEeE8N/MiZXcEBeLnF3tKQAUsTXa2lO5xM7Z9LrWnpYHdCdguVeL
	 bcGn/MEskl7O9AeiTXgrczZsx8a2QjKycNOYotd5N4YdFzfYbTDfRO3+PgA6xYZSvE
	 hyX8lEwLBY9nA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C4CCD1A2;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Fri, 17 Oct 2025 14:11:21 +0800
Subject: [PATCH net v3 3/3] net: stmmac: est: Fix GCL bounds checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-qbv-fixes-v3-3-d3a42e32646a@altera.com>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
In-Reply-To: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760681491; l=1340;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=mX5G4ROq0gDY4G0a4Qm/T3N17XaJr2mEhgFfcjCdoJk=;
 b=z8V58A1VlIr5ekLOqI6PBxwoKAM5sCuB+v2xtlazP8QRxqeoIu3e4AOJzUJiniz/MDLjGmNFn
 YWFLDF9+3quBrbhbs5cVU0EvUePkFdXCjLg7rESERbIkmMEmkC4wGuz
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

Fix the bounds checks for the hw supported maximum GCL entry
count and gate interval time.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 97e89a604abd7a01bb8e904c38f10716e0a911c1..3b4d4696afe96afe58e0c936429f51c22ae145be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -981,7 +981,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
 
-	if (qopt->num_entries >= dep)
+	if (qopt->num_entries > dep)
 		return -EINVAL;
 	if (!qopt->cycle_time)
 		return -ERANGE;
@@ -1012,7 +1012,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid, 0))
+		if (delta_ns > GENMASK(wid - 1, 0))
 			return -ERANGE;
 		if (gates > GENMASK(31 - wid, 0))
 			return -ERANGE;

-- 
2.43.7



