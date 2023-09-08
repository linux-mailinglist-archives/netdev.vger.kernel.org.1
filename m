Return-Path: <netdev+bounces-32615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ADB798C59
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B847A281CB9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138414A9E;
	Fri,  8 Sep 2023 18:14:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8314A94;
	Fri,  8 Sep 2023 18:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CE5C4166B;
	Fri,  8 Sep 2023 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196847;
	bh=E9CG2erST0QIlKGicll2mOJwDlhvm/t9GkLEog/8NbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUhZuC6vvHFHzBf1B5LXecxwIptWjZnMop8Q3UJTOxe/p/er5skNyFO3XEx+skn9m
	 QC886BpdwJGwa93Xt3YygiCgI4IHbX7F38LAUVweT+RFQF8+vRXXHQjEzs4vGLuJ6X
	 9RPuvyTrOObaeX8xDiuKpIzsOl90omkESi5AqHXRbIFnh4TTrJ/qxV5W0diVED0dKf
	 qR+JCQPgsBhF1OLuB8Q8RJ+wqcIunY0mX8vz6dJBAeutaNqpxbu5G/CsPVHdLsyE7x
	 6+Y7u4CzD4sMrzQeI+/MuXDhLPhwBCaB12KtPJqqNllSwzbxWfQ7xhEgqgRdqTuFFl
	 vIckVgVhuFpUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	wg@grandegger.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 13/45] can: sun4i_can: Add acceptance register quirk
Date: Fri,  8 Sep 2023 14:12:54 -0400
Message-Id: <20230908181327.3459042-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit

From: John Watts <contact@jookia.org>

[ Upstream commit 8cda0c6dfd42ee6f2586e7dffb553aaf1fcb62ca ]

The Allwinner D1's CAN controllers have the ACPC and ACPM registers
moved down. Compensate for this by adding an offset quirk for the
acceptance registers.

Signed-off-by: John Watts <contact@jookia.org>
Link: https://lore.kernel.org/all/20230721221552.1973203-5-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/sun4i_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28c..1f90fe6dbb8bb 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -205,9 +205,11 @@
  * struct sun4ican_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @acp_offset: Offset of ACPC and ACPM registers
  */
 struct sun4ican_quirks {
 	bool has_reset;
+	int acp_offset;
 };
 
 struct sun4ican_priv {
@@ -216,6 +218,7 @@ struct sun4ican_priv {
 	struct clk *clk;
 	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
+	int acp_offset;
 };
 
 static const struct can_bittiming_const sun4ican_bittiming_const = {
@@ -338,8 +341,8 @@ static int sun4i_can_start(struct net_device *dev)
 	}
 
 	/* set filters - we accept all */
-	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
-	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
+	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv->acp_offset);
+	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv->acp_offset);
 
 	/* clear error counters and error code capture */
 	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
@@ -768,10 +771,12 @@ static const struct ethtool_ops sun4ican_ethtool_ops = {
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
+	.acp_offset = 0,
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
@@ -870,6 +875,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	priv->base = addr;
 	priv->clk = clk;
 	priv->reset = reset;
+	priv->acp_offset = quirks->acp_offset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.40.1


