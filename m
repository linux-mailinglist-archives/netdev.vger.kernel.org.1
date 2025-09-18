Return-Path: <netdev+bounces-224440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00161B84E68
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFB72A6406
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43221925BC;
	Thu, 18 Sep 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8h8OcPT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD91CA52
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203201; cv=none; b=cCYykEMskS6Rn99BDnau8BsDsh4jLpkH+e/+YMLxIFDnKl7ixRZeZJ8jPbE4hdBetq97K76MLCIVyepD949CfEdxk9LwyZTVI/AlU/JG2n3Lz00aIFX4OgiziHONRxbS1OimOURan0BnnCpFKPtA7Rm0KIcjwZF6nq6rdxPA5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203201; c=relaxed/simple;
	bh=XLIidpsqO51OHrc1VlSMDqjpYMADSazxBvF/B/6gB70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKCEDBl+72KHeNYloopQOtlV08ph96fSq57bhlFyzfZ8CfrjPqs0VwEohDwK8fMD6jYvtz1JbVt2WYh90om9DknWz2H6JPy7kxHUS7clHW2prn2W4jk+46UFpVBP99Q1rjc4AcNokT/hfpFh+Tj7MuDpdgG2BK0OptnlGrmc6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8h8OcPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0081C4CEE7;
	Thu, 18 Sep 2025 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758203201;
	bh=XLIidpsqO51OHrc1VlSMDqjpYMADSazxBvF/B/6gB70=;
	h=From:To:Cc:Subject:Date:From;
	b=b8h8OcPTpEveN+gpxwQ/M62HPwCj/Q28BaTWz/OsqdC3l+zbzoXYPaQU0Lnmox+Df
	 ZuTxfCrl9Ihph+tiPZvBZUEr8zWi5ZXyEXIqVBwNRgjjNPYzUMPaL6wHA3lhlHoXPF
	 eVRvcGz0OA3xGbtMLOF9O1BQFA2IGh+K7ubuD9/X3yaBqexKhcjsL8wgR537Yr5yzR
	 9BSChKJxlxeU7AsMYtV1O5kQVLHvqJm2y2KMhqm47WoFqiT7fTLF3mIiORxxzsPcGm
	 nGeWDMdPEniE83v7qL04VO0uy3LXdw6ubsHwKx+KLc3zSLg0OoPi+06I7C3LtZPa2l
	 q2rI3jGWx5UDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	herve.codina@bootlin.com
Subject: [PATCH net-next] wan: framer: pef2256: use %pe in print format
Date: Thu, 18 Sep 2025 06:46:37 -0700
Message-ID: <20250918134637.2226614-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New cocci check complains:

  drivers/net/wan/framer/pef2256/pef2256.c:733:3-10: WARNING: Consider using %pe to print PTR_ERR()

Link: https://lore.kernel.org/1758192227-701925-1-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: herve.codina@bootlin.com
---
 drivers/net/wan/framer/pef2256/pef2256.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 1e4c8e85d598..2a25cbd3f13b 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -719,8 +719,8 @@ static int pef2256_probe(struct platform_device *pdev)
 	pef2256->regmap = devm_regmap_init_mmio(&pdev->dev, iomem,
 						&pef2256_regmap_config);
 	if (IS_ERR(pef2256->regmap)) {
-		dev_err(&pdev->dev, "Failed to initialise Regmap (%ld)\n",
-			PTR_ERR(pef2256->regmap));
+		dev_err(&pdev->dev, "Failed to initialise Regmap (%pe)\n",
+			pef2256->regmap);
 		return PTR_ERR(pef2256->regmap);
 	}
 
-- 
2.51.0


