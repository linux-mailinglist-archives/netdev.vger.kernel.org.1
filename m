Return-Path: <netdev+bounces-212408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A8B20068
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E1E3B08B6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A872DA743;
	Mon, 11 Aug 2025 07:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA920B812;
	Mon, 11 Aug 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897733; cv=none; b=aa1SAyDGpwBRvEwBotD0KHwEPRsM6NdTT+TXOp9Q6W12Avhss6GRxomKroQFM4Xfv+v/e++t8xuppGMtWYFcrgABGEhTE15NDQrYhOlTpKUIV3ghhMKM6ufsoSGZYRH61Mt5GrZvAz4Jaw/Qd+mkFCdSAg+rRRAV9Y8ufRlFGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897733; c=relaxed/simple;
	bh=Ge4FRghdRnHIXHEBbI+ihsb97tZrdg8eh1P/Q4/FG8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrPqIZsMuZ8PzWP5smKVn3E0Lex9HipNl1E1O1UZ8XXzuHwOM8MG7PlUZQ9akKc+qR7eQTRC2oKJ1RExdVWdkUADMtpOMo0CGN04ReUD/cO0VgaHeIcRXUASQFW6MZYOfAAP+J8xo75kJrEcFcWmBCRUDWE/t/1IfiaAHc+3wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxnOJBnZloL1Q+AQ--.17294S3;
	Mon, 11 Aug 2025 15:35:29 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQqnZloCJ9CAA--.53284S5;
	Mon, 11 Aug 2025 15:35:24 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: stmmac: Return early if invalid in loongson_dwmac_fix_reset()
Date: Mon, 11 Aug 2025 15:35:06 +0800
Message-ID: <20250811073506.27513-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250811073506.27513-1-yangtiezhu@loongson.cn>
References: <20250811073506.27513-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQqnZloCJ9CAA--.53284S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur15WF47Zr1fCF1Duw4xKrX_yoW8GF1xpr
	W3Za429r9Fqr1fJa1qy34DXFy5u34rKrZ7WFZ7Awn3uan5Ja4qqr1agay0grW7Ar4rtFy3
	XrW8uw1rua4DKwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAKsUUUUUU=

If the MAC controller does not connect to any PHY interface, there is a
missing clock, then the DMA reset fails.

For this case, the DMA_BUS_MODE_SFT_RESET bit is 1 before software reset,
just print an error message which gives a hint the PHY clock is missing,
and then return -EINVAL immediately to avoid waiting for the timeout when
the DMA reset fails in loongson_dwmac_fix_reset().

With this patch, for the normal end user, the computer start faster with
reducing boot time for 2 seconds on the specified mainboard.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bb376c69016d..05f195a18548 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -513,6 +513,11 @@ static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioad
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 
+	if (value & DMA_BUS_MODE_SFT_RESET) {
+		netdev_err(priv->dev, "the PHY clock is missing\n");
+		return -EINVAL;
+	}
+
 	value |= DMA_BUS_MODE_SFT_RESET;
 	writel(value, ioaddr + DMA_BUS_MODE);
 
-- 
2.42.0


