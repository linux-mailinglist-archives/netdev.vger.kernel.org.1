Return-Path: <netdev+bounces-277800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LOufKwGm22nbEgkAu9opvQ
	(envelope-from <netdev+bounces-277800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 344653E4208
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07997301176A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2940837C91E;
	Sun, 12 Apr 2026 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ4zZV9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A66317164
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002442; cv=none; b=la5+u6vNsm0hJipZo2BR7wVLpE+cGzMkc49WbnBiy0OjJiMrU3L6rH+ujd3MUYLHLwn6aBWBts1el6vnBR7E4qaZLXfaDHKb1zxIYIsNRqu4J1091Tkaqk1rIq88NJIeNhoRiGfO3XbKXG0g02S86G/xiOkM+o33OWpHnMhKvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002442; c=relaxed/simple;
	bh=3+I/QmdaT5K5uAqSVBg3ntKJt2qnVe2AOfqKzgGLZfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tI6/gYaiYQ7I7OaYZkDsfyGvTtCgxucW7aQOlJuVH6BVcBb+C4NBp74nCLP7llACYP3tnsrfexft8BYZdXubKFR0g52ErqjNLbzoSL0CCk86zAQnXuLhEjbgcoHA0sO3P3NrQxutqvncOk1reM64CHxXvu4FCiAcmNR5p5T/RZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ4zZV9I; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d77f6092eso73547f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002439; x=1776607239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+LliZVhUSquTF1adZHkj/J/X8yfecCPswdZw6vA+og=;
        b=cZ4zZV9IuEGP2L2S6dG/j8a9QbLDzSkZPNzdAK5pbdxxOCS78eS3iXPYnG0Xngnhh6
         PCKSpfUoTVq1KZ8vpGf5L4ZaLce5/OVJaW3b1AOLqYfy7NgMAKsy3DBq0rmyU5ZRbrwJ
         +rOQ87bgaEqBtc8neWAzKnc2VG9Yzt1UBAx1sT424UGTIyC+/sbI+peSxX5I0SKazj4L
         bJpfrNinpT1D1fcWy7CZzB3mnNooHH9kFbtDFJ+IArTfrRUV0thJs6nLx1NmxRBD03wZ
         sKFSvf2/Lk0XhNs+B1aqYPUZJEMsOCkJxBnjjF/8JSNGRiJa5MBLheBmZZfSdjlahYeO
         gqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002439; x=1776607239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8+LliZVhUSquTF1adZHkj/J/X8yfecCPswdZw6vA+og=;
        b=nY9CIeY9qD7MjMVM4BbcLv070hVueDopGqvpeCqWWVObCLxF4Zg0lgGrqEaMkfv5OM
         BUtg5QzdG9iWFEUk17ndHmJ3/SQ5EPL34x9Zh+5OrOxsyvw6nRRkvWHk86PVaiZAv2yX
         kJtiH53kdhSytKHY6DmbzXXBuU0XvemBKLpw8yYj3jCXuh90F9S7zXyFbymhyo5wo41c
         B0rLFVhkQe+NwC6Nap3znhHxBbQVhQbRyAEi4l4mdhvfZgv/Y1diGSNHzGOq8Lngsdrn
         V/658v/56U3jKLoe1JUnNskdbpD5XIY7cbLFUiAV0IpvErKPBv93A8FjyTtOmVD94CjW
         1S/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+d8PRwTjjMbjG20XWfVqmUw58b0dEAYFoo/9StdshTEMkdXxng8ipHf9HPsIuIcVKgNev/kY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIU3CXBnyAv9pj52VHbhOIHuJeKjPM/yTp/ruiIMyNREMcmO3p
	H31NNJQSO6Aq/yneZknLT+5LEaXXF0csjk0bKVUgRW1YLVOlo0fcAEZk
X-Gm-Gg: AeBDievzQSGA36YeGGTJ4q6p24WfFbHrikRyPe/ROadeUdOE/fYFtjK9P/DHOSTFUgd
	bnyDcudjurOXix5CGHjgfHpszuGo2TGUw7q1XD251mZm1D08cffnCthQTTRxrD//I0DVuqmtQW5
	MDDKoK2YdOOuM6lJeREk3SyZ56fWIC2AYz/onPiUqELN8gXOBC+OwgAFQqtnuhd9B+ceY/Gqf2a
	aD7dtx2TAUvgaNy5Lu6QrLBuucHEEHEgFrA9sgnOS+JOYxGLj+nNA/equrEdG2Dk70i4eg3kygo
	ES8Q0IaHUmzwZotm/Vn/7GvY1Sr/DOgpjmArbcuVJXVJw71lh+uGw9dlqa4C6d6EdOYRbFa9K4w
	QHBwMweE+e6I60a2bFK/4FtiiLt908I2IMl+c9457aEugnRRXd6f42qrlK5REv2xNl6Ib4TgscS
	mKDWoewTWBfYio3un8QBHGbcntiwZsTsYXIbKLEYGErGCJHR0h
X-Received: by 2002:a05:6000:4201:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-43d78282302mr700830f8f.41.1776002438686;
        Sun, 12 Apr 2026 07:00:38 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:6956:2074:5220:4650])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50015sm26127538f8f.27.2026.04.12.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 07:00:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Russell King <linux@armlinux.org.uk>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 3/5] net: phy: mscc: Drop unnecessary phydev->lock
Date: Sun, 12 Apr 2026 15:00:25 +0100
Message-ID: <20260412140032.122841-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
References: <20260412140032.122841-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277800-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[bp.renesas.com,armlinux.org.uk,microchip.com,nxp.com,vger.kernel.org,glider.be,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 344653E4208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove manual mutex_lock/unlock(&phydev->lock) calls from several
functions in the MSCC PHY driver.

In vsc85xx_edge_rate_cntl_set(), phydev->lock is taken around a single
phy_modify_paged() call. phy_modify_paged() is already a fully locked
atomic operation that acquires the MDIO bus lock internally, so the
additional phydev->lock is unnecessary.

The remaining three functions — vsc85xx_mac_if_set(),
vsc8531_pre_init_seq_set(), and vsc85xx_eee_init_seq_set() — use
phy_read(), phy_write(), phy_select_page(), and phy_restore_page(),
all of which operate under the MDIO bus lock. Taking phydev->lock
around them provides no additional serialisation.

Along with dropping the locks, error-path labels are renamed from
out_unlock to err or restore_oldpage to better reflect their purpose.
In vsc8531_pre_init_seq_set() and vsc85xx_eee_init_seq_set(), the
redundant intermediate assignment of oldpage before returning is also
eliminated.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added the patch into series
 * Updated commit description.
v2:
 * New patch
---
 drivers/net/phy/mscc/mscc_main.c | 41 ++++++++++----------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 2b9fb8a675a6..75430f55acfd 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -486,15 +486,9 @@ static int vsc85xx_dt_led_modes_get(struct phy_device *phydev,
 
 static int vsc85xx_edge_rate_cntl_set(struct phy_device *phydev, u8 edge_rate)
 {
-	int rc;
-
-	mutex_lock(&phydev->lock);
-	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
-			      MSCC_PHY_WOL_MAC_CONTROL, EDGE_RATE_CNTL_MASK,
-			      edge_rate << EDGE_RATE_CNTL_POS);
-	mutex_unlock(&phydev->lock);
-
-	return rc;
+	return phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
+				MSCC_PHY_WOL_MAC_CONTROL, EDGE_RATE_CNTL_MASK,
+				edge_rate << EDGE_RATE_CNTL_POS);
 }
 
 static int vsc85xx_mac_if_set(struct phy_device *phydev,
@@ -503,7 +497,6 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
 	int rc;
 	u16 reg_val;
 
-	mutex_lock(&phydev->lock);
 	reg_val = phy_read(phydev, MSCC_PHY_EXT_PHY_CNTL_1);
 	reg_val &= ~(MAC_IF_SELECTION_MASK);
 	switch (interface) {
@@ -522,17 +515,15 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
 		break;
 	default:
 		rc = -EINVAL;
-		goto out_unlock;
+		goto err;
 	}
 	rc = phy_write(phydev, MSCC_PHY_EXT_PHY_CNTL_1, reg_val);
 	if (rc)
-		goto out_unlock;
+		goto err;
 
 	rc = genphy_soft_reset(phydev);
 
-out_unlock:
-	mutex_unlock(&phydev->lock);
-
+err:
 	return rc;
 }
 
@@ -668,19 +659,15 @@ static int vsc8531_pre_init_seq_set(struct phy_device *phydev)
 	if (rc < 0)
 		return rc;
 
-	mutex_lock(&phydev->lock);
 	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_TR);
 	if (oldpage < 0)
-		goto out_unlock;
+		goto restore_oldpage;
 
 	for (i = 0; i < ARRAY_SIZE(init_seq); i++)
 		vsc85xx_tr_write(phydev, init_seq[i].reg, init_seq[i].val);
 
-out_unlock:
-	oldpage = phy_restore_page(phydev, oldpage, oldpage);
-	mutex_unlock(&phydev->lock);
-
-	return oldpage;
+restore_oldpage:
+	return phy_restore_page(phydev, oldpage, oldpage);
 }
 
 static int vsc85xx_eee_init_seq_set(struct phy_device *phydev)
@@ -708,19 +695,15 @@ static int vsc85xx_eee_init_seq_set(struct phy_device *phydev)
 	unsigned int i;
 	int oldpage;
 
-	mutex_lock(&phydev->lock);
 	oldpage = phy_select_page(phydev, MSCC_PHY_PAGE_TR);
 	if (oldpage < 0)
-		goto out_unlock;
+		goto restore_oldpage;
 
 	for (i = 0; i < ARRAY_SIZE(init_eee); i++)
 		vsc85xx_tr_write(phydev, init_eee[i].reg, init_eee[i].val);
 
-out_unlock:
-	oldpage = phy_restore_page(phydev, oldpage, oldpage);
-	mutex_unlock(&phydev->lock);
-
-	return oldpage;
+restore_oldpage:
+	return phy_restore_page(phydev, oldpage, oldpage);
 }
 
 /* phydev->bus->mdio_lock should be locked when using this function */
-- 
2.43.0


