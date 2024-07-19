Return-Path: <netdev+bounces-112269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E4937D4F
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589C21C21012
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5230147C76;
	Fri, 19 Jul 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb5C67sY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235E59168
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421535; cv=none; b=ZA4uf7aWrnr+LM7j3Rs9Zk9q+aUgwecB+iZxRSLRlzCMIY362D3txwBQ8w8ON90r4LeVt4vGD9XHwUjRNydNoW+9MZzHBLViRNNSStJidG0O8zPjwxGVr6MgZslpp5yN0fkhwcQ6O687trpGDuI0+7nbEcB9reRqGhDRshmDsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421535; c=relaxed/simple;
	bh=AON9XBl1TCaXqJyKVVpDsSKb6Hr7n3DQkS8P2XAGnBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI8FZLf3QPfykXVq0Ek4CKmbwgue9zu7va13rcrrG/r9C9bnadvlfEB7N9PPsFtDk8l6TXuFZH3lZUluJfBTQpnoQXNDTG58au2ZeSdEfUEfo0OcfgHl3+9XoaxT/rfh4WEsINxriYsarebhFHBeDv5YcpxC+59Z1dpynwIAFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xb5C67sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEC1C32782;
	Fri, 19 Jul 2024 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721421535;
	bh=AON9XBl1TCaXqJyKVVpDsSKb6Hr7n3DQkS8P2XAGnBE=;
	h=From:To:Cc:Subject:Date:From;
	b=Xb5C67sY+1eQl6g3SCRQP0vLUQVmg+0oBlSZJVQESOUhAH+jZ6DOJtFojmAaN3IZZ
	 6bLJSyJaB34gUMxZvORFH3ZWuiF2XxjEK9pMCPlzXqRcZCiPvfOEe4tZiJK7JRED/+
	 LmXm30W+LN1eqDmsIMShbJ5sVsNamDLH6EZg9iVkSpkNSYFO5RVrur7/FIuD9opHzN
	 XiaPsM0Qj/NZNmMcXxJYV/f+Wo5BhNfeo3uB91Zt/W7ng5zWyZLGmDgt9/DcVy0A0H
	 LzGKqSQYwlrxkIcGi3OhcqRaGFH3O+eH2oLNArXB8kx2M0DbxudzGbREK6xrfVyibD
	 nu5alfn+hOHbw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	lorenzo.bianconi83@gmail.com,
	dan.carpenter@linaro.org
Subject: [PATCH net] net: airoha: Fix MBI_RX_AGE_SEL_MASK definition
Date: Fri, 19 Jul 2024 22:38:31 +0200
Message-ID: <d27d0465be1bff3369e886e5f10c4d37fefc4934.1721419930.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix copy-paste error in MBI_RX_AGE_SEL_MASK macro definition

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 16761fde6c6c..1c5b85a86df1 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -249,7 +249,7 @@
 #define REG_FE_GDM_RX_ETH_L1023_CNT_H(_n)	(GDM_BASE(_n) + 0x2fc)
 
 #define REG_GDM2_CHN_RLS		(GDM2_BASE + 0x20)
-#define MBI_RX_AGE_SEL_MASK		GENMASK(18, 17)
+#define MBI_RX_AGE_SEL_MASK		GENMASK(26, 25)
 #define MBI_TX_AGE_SEL_MASK		GENMASK(18, 17)
 
 #define REG_GDM3_FWD_CFG		GDM3_BASE
-- 
2.45.2


