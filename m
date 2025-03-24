Return-Path: <netdev+bounces-177038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27403A6D768
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4403B345F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB425DB1E;
	Mon, 24 Mar 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQsnjwgT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDF25DB1A;
	Mon, 24 Mar 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808615; cv=none; b=tBFPm2/A+4G8GdZmbIxdF0vbjl+BfermY4968OThpTo22FvWYmLvkZxA10wl118DTAHX96u6J1S7qxdtVatrE9RM+/+/PQluDut14aBp/J7/vIcRrcSt65gcl6krlul+ZU/eKrlcglnNJlUpHKLe0MskplOxJ8VXKlv4HXLy8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808615; c=relaxed/simple;
	bh=qvEF2fJCzu5X8V0NTQGWFGFuFTWwf3k9To8iBhwcuKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQnAgI3Jd3Cftbfuj/J4MNf6e5DddhFABa6xDuCQarR5Te5KIZTRUIrcB9BAULCXlcn6KG+vaHbZAcVVx4alcuuqzAytJ6ABJbO6Pmk3H8V46SuUkKmM0QLLoWQRlzG0FTzgsoaIimipBslLxYlLPiNbqP3d9JLr7DzlE7G//BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQsnjwgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F0DC4CEDD;
	Mon, 24 Mar 2025 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742808614;
	bh=qvEF2fJCzu5X8V0NTQGWFGFuFTWwf3k9To8iBhwcuKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQsnjwgT19IobHoC77xagOBHjM7+X2zTsG1p1KVZ3LoGlVjSTJPz53YbBM8usS1qy
	 QHTbZJ0GfhHscbbCY+xKD+rYoIAWtWt7v9WSaTRWhXuw730nJMZjSQGnFgBVb1mhRW
	 UB150Qv5i5rEO3kmLxtqk+r5/A3d6hdxUjE2sHM4aanOodw4SOTJ8P++ZtNsEHKQF/
	 HKNR+Fke3jd2L7d2Jw9jadWwZyPlGcZtyUN4x1naENebpKav3/V6W1xSp3OZ7evUTz
	 k23hATeNsw3OK5W4O01F2DZH27fN5JY9otAVSwBxtrkKqhOUCvzX8/cQEmYoyTyIWZ
	 6onfFyj67rbgQ==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yinggang Gu <guyinggang@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Henry Chen <chenx97@aosc.io>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v4 1/3] stmmac: loongson: Remove surplus loop
Date: Mon, 24 Mar 2025 10:29:28 +0100
Message-ID: <20250324092928.9482-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324092928.9482-2-phasta@kernel.org>
References: <20250324092928.9482-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loongson_dwmac_probe() contains a loop which doesn't have an effect,
because it tries to call pcim_iomap_regions() with the same parameters
several times. The break statement at the loop's end furthermore ensures
that the loop only runs once anyways.

Remove the surplus loop.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Tested-by: Henry Chen <chenx97@aosc.io>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c    | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f1c62f237e58..7e8495547934 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -536,7 +536,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	struct stmmac_pci_info *info;
 	struct stmmac_resources res;
 	struct loongson_data *ld;
-	int ret, i;
+	int ret;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
@@ -566,14 +566,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	pci_set_master(pdev);
 
 	/* Get the base address of device */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
-		if (ret)
-			goto err_disable_device;
-		break;
-	}
+	ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
+	if (ret)
+		goto err_disable_device;
 
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
-- 
2.48.1


