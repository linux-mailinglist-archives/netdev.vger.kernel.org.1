Return-Path: <netdev+bounces-233401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C1C12BC4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CFB560770
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC3277C86;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqO2RohP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110D17C21E;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621546; cv=none; b=E6439leS8ZwsVuRze6sjzcrDNV84fuPe6LSgzoK1m6FM4htFFIGJiqwpgl44GXebwEkNphFTSCF851q5xBIub62vMvhsqn8yXycX8PT/iplE4b5dgFK6lTH/aPH6KujO4x2WL6Siw382OpV079wjPWygenZsX9ivqcnbG9VIS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621546; c=relaxed/simple;
	bh=rhuTQBILO/3ko7T4YN6viqf7VD8LLS2B2vglmaJ12pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcxyWS4aNW5HGf2tI+okdOJbbhjjUQ9fRTiO5ofsZ3k8VGJe/2jd8igGeEoxzElCIFH4aeyqopiv+RD4j1j5HrDa9TwNr7Qup/AjYXwYnlIM9/ZpfVDB3RJT4xthSNd/7GKT4RypPxO/xdh6BwORiutLh0VMfKR0QdAsSpG24YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqO2RohP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50248C116C6;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761621546;
	bh=rhuTQBILO/3ko7T4YN6viqf7VD8LLS2B2vglmaJ12pc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LqO2RohPzR/SipeTjO6n7Be7rqBTm+38Wx5xx0V9m30hcBqoUzUhgo53X8Y1Fg7oj
	 XMGhKXB9AeXM7wvEkRAmimYLMVEUGy+XcpzBIyHrS4o07sEDmsOVCQmAvA7tOxW6fF
	 FE5nQ2CVMnqZ3fIu7X9uXZxoWL4PAOnmRmwMfuYxkbq5JT8E/jn2NKB+RgK48PRzYn
	 YZ0vKoUUy05e40bQwECgHbgEIyxYTnSoLEddOprddEG1x65Z0NaOfuoxvgzAGS4u1j
	 OfYuqmtY/tJRuA3DIjAHKbwl7dIrmg+vZEnDdpVkx29AqmsGHlp71te1jvveNXci2Q
	 VFfXHkfoXrUQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D7CCF9EA;
	Tue, 28 Oct 2025 03:19:06 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Tue, 28 Oct 2025 11:18:45 +0800
Subject: [PATCH net v4 3/3] net: stmmac: est: Fix GCL bounds checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-qbv-fixes-v4-3-26481c7634e3@altera.com>
References: <20251028-qbv-fixes-v4-0-26481c7634e3@altera.com>
In-Reply-To: <20251028-qbv-fixes-v4-0-26481c7634e3@altera.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761621544; l=1340;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=k4E9iK4RiPK/MUr6aNRMEoxEsNmOvrcMsNQIhLkPefA=;
 b=HfSDPmgRlDitrbNjivy6sUn+fYyJqUgImrklCz+82NoRqDphaIwBDiBGGyY0CrBJWNiQZSNVn
 MX41EgUgcl5BCokGi0lBGPv+Zq16SiugloP3OYI08P9v3VN9Ixl2ObO
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
index ef65cf511f3e25eb512187d52775bb363bb83902..d786527185999db6bb6a18a29eee5ff5282b8ef4 100644
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



