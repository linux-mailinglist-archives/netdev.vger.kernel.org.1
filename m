Return-Path: <netdev+bounces-171345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4FA4C953
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31405188A63A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D9242914;
	Mon,  3 Mar 2025 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="jlJumFtQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C874820D4E9;
	Mon,  3 Mar 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021560; cv=none; b=WKgjHv5vW3eDhQvMTCuV9FEj5A2tYaep+54aAWncvqUF6EIgxAhSCLPPnILeHT0lcDbN7jtk7/fawE6i67Y2McIZQmFqJbRw3G93MMmrmGzYcpa26WPzThxuu5uvsQdmhghCBBBepVGDDT9JYDcQufuoxHfnt2CqK+uCRh5yP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021560; c=relaxed/simple;
	bh=l+3eEvBugJSbwQ9w3y+t3p5DR/uMCce4LWP85pyH/TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atahaKS/uKnmqUsNzlquwxO6xrR8rEKf7nBj0vags/kaH6VhNv1ybVbOcQF2hbsWfk5hVscc5TVqROTbxna3M4TZh7HwWhhv2m3NpWPHxO5GgE4V4Ac0/HnGdFdtGkmF3xcSmIaeAPl2QUnPUIle+Aul+XkaW3kH0csLrjcFra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=jlJumFtQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 045C3443B5;
	Mon,  3 Mar 2025 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1741021557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQoyq5i1vitMuLXuK9kol56BipaNeFGVfF4z+AVYxfE=;
	b=jlJumFtQcTlxIDGeR9OckJt/Nqs+hHbSJvbkMTeRKqfCFB71Cj62XbWxlaYVtAGVEcKeac
	8U2n4rVvU8lqAUHrldhqA0wSMbZt5CZ8bIjDpgzxcvNkFamRIq/vBIvveXjAOulbPUR19g
	A7SdD7mfQWNCe2Gbilp7VNBEgs4Ru//77QlTXESrq1QOO0WOstGappsiQpEaqTAtbHShFM
	/OfT+i4l/Puxh1KMjado7pG7M3oBeHF+FJZcg++rPWnVsYu0mwW2eqKnpw5Q7Ajb//Ph/J
	JiJ+eYKB8VtDGh1JiuVkxDN2vzj2O7q5NNq0nFmkCEaUgmxl52dPNV9rx2hZCg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Mon, 03 Mar 2025 18:05:51 +0100
Subject: [PATCH 1/2] net: phy: dp83826: Fix TX data voltage support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-dp83826-fixes-v1-1-6901a04f262d@yoseli.org>
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
In-Reply-To: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741021554; l=1128;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=l+3eEvBugJSbwQ9w3y+t3p5DR/uMCce4LWP85pyH/TY=;
 b=q2mDvosd4jiDHixLxJmysW1y0ht545NcXQIS2YI61uFQWIq7tgvmsbU/GZsoCWEpAQ0E4xlT9
 PNT+Htdn+KLBdgpdXivVNoWhXDyyjkM39ybLrySCvV8jST8Kw24q5nI
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflvggrnhdqofhitghhvghlucfjrghuthgsohhishcuoehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrgheqnecuggftrfgrthhtvghrnhepffejhfdtlefhhfehveehueetgffhfeetleeuvdduhfeggeetiedttdeuhffhleetnecukfhppedvrgdtudemvgdtrgemudeileemjedugedtmegttgelmedvieelvdemrgehfhejmeejlegvtgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudeileemjedugedtmegttgelmedvieelvdemrgehfhejmeejlegvtgdphhgvlhhopeihohhsvghlihdqhihotghtohdrhihoshgvlhhirdhorhhgpdhmrghilhhfrhhomhepjhgvrghnmhhitghhvghlrdhhrghuthgsohhisheshihoshgvlhhirdhorhhgpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesv
 hhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvggrnhhmihgthhgvlhdrhhgruhhtsghoihhsseihohhsvghlihdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheptggrthgrlhhinhdrphhophgvshgtuheslhgvihgtrgdqghgvohhshihsthgvmhhsrdgtohhm
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

When CONFIG_OF_MDIO is not set, the cfg_dac_minus and cfg_dac_plus are
not set in dp83826_of_init(). This leads to a bad behavior in
dp83826_config_init: the phy initialization fails, after
MII_DP83826_VOD_CFG1 and MII_DP83826_VOD_CFG2 are set.

Fix it by setting the default value for both variables.

Fixes: d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/net/phy/dp83822.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 6599feca1967d705331d6e354205a2485ea962f2..88c49e8fe13e20e97191cddcd0885a6e075ae326 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -854,6 +854,10 @@ static int dp83822_of_init(struct phy_device *phydev)
 
 static void dp83826_of_init(struct phy_device *phydev)
 {
+	struct dp83822_private *dp83822 = phydev->priv;
+
+	dp83822->cfg_dac_minus = DP83826_CFG_DAC_MINUS_DEFAULT;
+	dp83822->cfg_dac_plus = DP83826_CFG_DAC_PLUS_DEFAULT;
 }
 #endif /* CONFIG_OF_MDIO */
 

-- 
2.39.5


