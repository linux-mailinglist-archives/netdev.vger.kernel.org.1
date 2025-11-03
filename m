Return-Path: <netdev+bounces-234924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0449C29D6C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 03:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807813AA8F5
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 02:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5F271447;
	Mon,  3 Nov 2025 02:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC829A2;
	Mon,  3 Nov 2025 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762135407; cv=none; b=oHBuW9Di7aBK/J90T4w0E70zThQbw1WiOk3J1kLJFhHKQXPiAHIJoF4dU3nRLMyFTpUBfZBRm3Oiyr+5wg2C7skZNFXFSKc+Zwxy00meAVuFXUWYG6jUoRhbTVbzzyQBOrwBdSEtEn/ZW0pt4r4AaPhfRO3hL4bP160jElaZLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762135407; c=relaxed/simple;
	bh=WcHlvIwTwKQ+93ogLCGc3oVtV09Vvg+lFU9c0YzSRAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CsAHGANGPOVI6D/cyD/lyck3UL8OYPSoO4QXNRAGQZCFQC8a7m3XKI3NWU+yHq2fWurvPA4fFyMnmu6sccSgpxudFYtHopYn1zEAEzRTakj70/cDNdBXpbs+4X+4oR8CpkcYzuKYLypuFzjJAlstR29OwkBDDJhYaHm9aESjH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [114.241.85.109])
	by APP-05 (Coremail) with SMTP id zQCowAD3oO9JDQhpJTImAQ--.23894S2;
	Mon, 03 Nov 2025 10:02:50 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Mon, 03 Nov 2025 10:02:49 +0800
Subject: [PATCH net v3] net: spacemit: Check netif_running() in
 emac_set_pauseparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-k1-ethernet-remove-fc-v3-1-2083770cd282@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAEgNCGkC/4WOwWrDMBBEf8Xo3DVaOVbVnPIfIQV5ta5FsZ1Ii
 mgw/vcKtVB6KGVPszvzdjYROXiO4thsInD20a9LEd1TI2iyyxuDd0ULJVWPskN4R+A0cVg4QeB
 5zQwjgVGj08/OmBerRcleA4/+o3LPoljF5WsZ+HYvP9L3ZbCRgdZ59unYZN2igUD4uu3VP/mY1
 vCo3TLWwD81MkIZy92ITvfS0MlHsrG11NJSmVn9cFD+yVGFI/FgqRtIGcm/Ofu+fwIVhXGVOQE
 AAA==
X-Change-ID: 20251031-k1-ethernet-remove-fc-82fd67d889a6
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowAD3oO9JDQhpJTImAQ--.23894S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur13Zr1rKw1DJFy5Ar15CFg_yoW8uw1fpF
	WUZa93Ww17Jr4rKFs7tw4xZFy5Jayftr1Uua1akw4rZa4aya4UCFyFkFW3Cr18ZFW5CrWa
	gw4jv3WfCF1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Currently, emac_set_pauseparam() will oops if userspace calls it while
the interface is not up, because phydev is NULL, but it is still
accessed in emac_set_fc() and emac_set_fc_autoneg().

Check for netif_running(dev) in emac_set_pauseparam() before proceeding.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
This more urgent problem was discovered while trying to fix
emac_set_pauseparam() (v1 of that has already been sent to the mailing
lists [1], but it was still bad), so I decided to send this patch for
the net tree now so that this oops will not happen on 6.18. A future
version of the proper flow control implementation will be sent to
net-next.

[1]: https://lore.kernel.org/spacemit/20251030-k1-ethernet-fix-autoneg-v1-1-baa572607ccc@iscas.ac.cn
---
Changes in v3:
- Check netif_running() instead (Andrew)
- Add back blurb about the attempt to fix flow control for context
- Link to v2: https://lore.kernel.org/r/20251101-k1-ethernet-remove-fc-v2-1-014ac3bc280e@iscas.ac.cn

Changes in v2:
- Reduced patch to only contain checking IFF_UP to avoid the oops. More
  invasive changes will be sent to net-next in the future. (Andrew)
- Link to v1: https://lore.kernel.org/r/20251031-k1-ethernet-remove-fc-v1-1-1ae3f1d6508c@iscas.ac.cn
---
 drivers/net/ethernet/spacemit/k1_emac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index e1c5faff3b71..220eb5ce7583 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1441,6 +1441,9 @@ static int emac_set_pauseparam(struct net_device *dev,
 	struct emac_priv *priv = netdev_priv(dev);
 	u8 fc = 0;
 
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
 	priv->flow_control_autoneg = pause->autoneg;
 
 	if (pause->autoneg) {

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251031-k1-ethernet-remove-fc-82fd67d889a6

Best regards,
-- 
Vivian "dramforever" Wang


