Return-Path: <netdev+bounces-252630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZmnFFLbwcmlgrQAAu9opvQ
	(envelope-from <netdev+bounces-252630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:53:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292F70324
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92FC43007BA9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F3389DEE;
	Fri, 23 Jan 2026 03:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (unknown [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBA37F8BC;
	Fri, 23 Jan 2026 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769140399; cv=none; b=g+AO3sLAFLo0BERsCV5t48i25PL00WM/w3vQnPOrq8t+FcfFlPI9CknXtuKhHw5xH5vZ0eiFrap/P5Nazp3UwWVv6xVUPXQDhnUJ+niFwwiuYkzB+PAFphP+ulS5IrZpiO7Rh5PhqUY7jcblqkwdEjSPWDrQECGIE2Xebk2cAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769140399; c=relaxed/simple;
	bh=4Sq1m95nMhBZ4sWzKktBqG3xAfHUblz60WZRYNYPBq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K7jG5t6LoYHieOGv6eRhmwNLWTkTjS46ZnKmY8UbGZkJ9yidQnV/LfnbnDOFFtfJtWE6am/HhgnbDxO5WbEfZgAV80L6PtLERqG1oh6OyDJBbGd10/FbOP/JqATuRVBGf+lZKo8vAV1yXKFOkfsfsAh7QBukyx0dYGaKXfoa0EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAB3HGh_8HJpaGXcBQ--.18963S2;
	Fri, 23 Jan 2026 11:52:33 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 23 Jan 2026 11:52:23 +0800
Subject: [PATCH net v3] net: spacemit: Check for netif_carrier_ok() in
 emac_stats_update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-k1-ethernet-clarify-stat-timeout-v3-1-93b9df627e87@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAHbwcmkC/43PwW7DMAgA0F+JfJ4rQyKX9LT/mHYgNl6sLUlnu
 1GrKv9eK9thu1WcAPGAu8qSomR1au4qyRpzXOaatC+NciPPH6Kjr7lCg9YAGv0JWsooaZai3Re
 nGG46Fy66xEmWS9EeEYLzLTOTqsw5SYjXfcWbqlPq/aeY5PtS15XfzsBZtFumKZZT03HrB+4Ii
 NCQdMFaQiRjxHRoyR6p89h72K0x5rKk2/7CCjv2/LUr6BqGXOiRPAzta8yO84Hdwc07v+JfEp4
 gsZJHGwIwgCXf/ye3bXsAGSVarXYBAAA=
X-Change-ID: 20260120-k1-ethernet-clarify-stat-timeout-d221fcd3aaa8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Yixun Lan <dlan@gentoo.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID:qwCowAB3HGh_8HJpaGXcBQ--.18963S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17Xw4rAF1rJw1fZw15CFg_yoWrWFW8p3
	yYvasaqr40kry0vFsIyr4UZrZ8Xa1fJFyUCFyay395WFn0y3WfAry8KayUKF1qvrWkuryY
	qr1UAa1DCF4DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU892-5UU
	UUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252630-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 2292F70324
X-Rspamd-Action: no action

Some PHYs stop the refclk for power saving, usually while link down.
This causes reading stats to time out.

Therefore, in emac_stats_update(), also don't update and reschedule if
!netif_carrier_ok(). But that means we could be missing later updates if
the link comes back up, so also reschedule when link up is detected in
emac_adjust_link().

While we're at it, improve the comments and error message prints around
this to reflect the better understanding of how this could happen.
Hopefully if this happens again on new hardware, these comments will
direct towards a solution.

Closes: https://lore.kernel.org/r/20260119141620.1318102-1-amadeus@jmu.edu.cn/
Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Co-developed-by: Chukun Pan <amadeus@jmu.edu.cn>
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Changes in v3:
- Incorporated changes from Chukun to check for netif_carrier_ok().
  Reworded patch message to match. (Jakub)
- Link to v2: https://lore.kernel.org/r/20260121-k1-ethernet-clarify-stat-timeout-v2-1-76ff1a1168d9@iscas.ac.cn

Changes in v2:
- Add "Fixes" and retarget to net (Andrew)
- Link to v1: https://lore.kernel.org/r/20260120-k1-ethernet-clarify-stat-timeout-v1-1-108cf928d1b3@iscas.ac.cn
---
This has a conflict in context lines in emac_adjust_link() with current
net-next, which will show up when pulling that for next rc1. Just remove
"emac_set_fc_autoneg(priv);".
---
 drivers/net/ethernet/spacemit/k1_emac.c | 34 ++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 220eb5ce7583..88e9424d2d51 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1099,7 +1099,13 @@ static int emac_read_stat_cnt(struct emac_priv *priv, u8 cnt, u32 *res,
 					100, 10000);
 
 	if (ret) {
-		netdev_err(priv->ndev, "Read stat timeout\n");
+		/*
+		 * This could be caused by the PHY stopping its refclk even when
+		 * the link is up, for power saving. See also comments in
+		 * emac_stats_update().
+		 */
+		dev_err_ratelimited(&priv->ndev->dev,
+				    "Read stat timeout. PHY clock stopped?\n");
 		return ret;
 	}
 
@@ -1147,17 +1153,25 @@ static void emac_stats_update(struct emac_priv *priv)
 
 	assert_spin_locked(&priv->stats_lock);
 
-	if (!netif_running(priv->ndev) || !netif_device_present(priv->ndev)) {
-		/* Not up, don't try to update */
+	/*
+	 * We can't read statistics if the interface is not up. Also, some PHYs
+	 * stop their reference clocks for link down power saving, which also
+	 * causes reading statistics to time out. Don't update and don't
+	 * reschedule in these cases.
+	 */
+	if (!netif_running(priv->ndev) ||
+	    !netif_carrier_ok(priv->ndev) ||
+	    !netif_device_present(priv->ndev)) {
 		return;
 	}
 
 	for (i = 0; i < sizeof(priv->tx_stats) / sizeof(*tx_stats); i++) {
 		/*
-		 * If reading stats times out, everything is broken and there's
-		 * nothing we can do. Reading statistics also can't return an
-		 * error, so just return without updating and without
-		 * rescheduling.
+		 * If reading stats times out anyway, the stat registers will be
+		 * stuck, and we can't really recover from that.
+		 *
+		 * Reading statistics also can't return an error, so just return
+		 * without updating and without rescheduling.
 		 */
 		if (emac_tx_read_stat_cnt(priv, i, &res))
 			return;
@@ -1636,6 +1650,12 @@ static void emac_adjust_link(struct net_device *dev)
 		emac_wr(priv, MAC_GLOBAL_CONTROL, ctrl);
 
 		emac_set_fc_autoneg(priv);
+
+		/*
+		 * Reschedule stats updates now that link is up. See comments in
+		 * emac_stats_update().
+		 */
+		mod_timer(&priv->stats_timer, jiffies);
 	}
 
 	phy_print_status(phydev);

---
base-commit: 4a3dba48188208e4f66822800e042686784d29d1
change-id: 20260120-k1-ethernet-clarify-stat-timeout-d221fcd3aaa8

Best regards,
-- 
Vivian "dramforever" Wang


