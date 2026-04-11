Return-Path: <netdev+bounces-277708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pNddOLVt2mnV2QgAu9opvQ
	(envelope-from <netdev+bounces-277708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 17:50:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93C63E0B34
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 733F43008445
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00003A6F0E;
	Sat, 11 Apr 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty/XSEba"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE33A6B99
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775922606; cv=none; b=hrUdLe2hwme06Ek1gdxzr/2DWS2jwhBu3clexnoId2df6hOS7AgZamwVqMY3m1kaRGcRRnP50dEVBirMHQUQ2TTdq5PxP/FQHi8bYL9897aEtQY5ETeWvQhrfhvYScmToUIGdTHGQII7BRu62GwPDZ0tWb2Hkqd4j/QuufP/8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775922606; c=relaxed/simple;
	bh=jLJHxn45YIu0ODRVIGUSiV0+fkK3PfmgztscGeaXR/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UCwRd9j2SuG0FVhjdxK8amYZ6oU8QsTz7NCEow4m7jj0+jfGDtEOSkrDjvYhTxDqa+atQTGuVoHNBVtYKLeLDyuFDxG5T8nhQSK9gmfnoKgBC6pQuE3reowF9PXwTHGvdr9jrIrZ3PsGVLIfTrbYOHphKvMEKUGVudiLE56bZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty/XSEba; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso45665345e9.3
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775922604; x=1776527404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RivRwNQOkJLh4rdW5APMQeQflMY8Havh14Tia1kZuAk=;
        b=Ty/XSEbaBNeWpnLP5b4vdZoWinVhBbzBcGj2pGY/Kg9pptG+Abuqyi2H/5d3PDVUDJ
         9yvqjOLB6jIWdd+t3MhiHFSow4t6Z+HvQOVm66Jdj0xoaTP6ZrUoefZytRcTJy2jM/2P
         ZEF9YthxSgiF95VqoS9MBVrEEtqiFD1mhsQojiF0bTFzHlhd6kPMo0XKPaQ6KvOo132o
         PXiXXKwKi2DM+vJedzjzvX9qdJ9q5oUFMrXcH19cyj874C41wnSYnTmPBEO87+SBpSyt
         T/+47O1fuD0om7ugTAlH4PdwZPGrSV8aWwwtYcjk4W0XLU0sXGcnIo3xTwsTOYEfIYwk
         /E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775922604; x=1776527404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RivRwNQOkJLh4rdW5APMQeQflMY8Havh14Tia1kZuAk=;
        b=URzYhu42EPNHP2c1KIQIpHTjN51Mp+KhsLN1jmM3xNN9u+/OcgKXxKOMfgnPy+wf4/
         JzEkV/R0trIvur34nsE+8M9WzEqgHgIV7kefws5V+7pOWbR3i5Iu7Ig6iTcQUXJk4uNe
         G3Yd4o629QI7uf/RQ+S08Bq2BZTeC3c0zYR/L4tE+MK2YCBn4lDKP0C6Z626AotlZwvD
         Ffwcku/5X3Xyq8QfsI2mRs7QSWwvQ69r0wTV/Hyh6RkcYn55r/9cEqd1hPNpI0R19aNm
         0x04gYr5E9PF4eWeEnVJiAR9RTalB4lObQq+EzadsxIP/c46MmxxC4YrFBwAUQYcHcD2
         jtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnQP1sOjb+S6T5IrkODYuFyU/AxLiQk/8iF4FXxXN33HatnmjwQudF0SaYuNq+tkypFNx9YDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6CSoSUuwb3vt0F9J+60AdrcRA/2bZrW/iDL1QdqoQxVbhvOE
	AeRtZG9rMPKM2BQZ1QhD4RMCmMe9xdy9K6G2FV2L7wIOEaNtNOJupKC4
X-Gm-Gg: AeBDies/2iOaD0ZZ6MzRf5OXLsUuDOd1Oq2otNVMnVye/wc41i5AGRp3zIxatb1+773
	NK4J+oG8UxvJ8rxVL2yoLmc1VUKpVIIc25VqELYJIMQZ7whXDp372T03G7mieh1yrMkEqZ4b3TK
	IgsU33FJNYeYU1I9MtlG2xGxLeZJJHBt+SJNZxMqv4sj/JK9q70oNh7Nz2ddzkPNwL2Ewe+MjUQ
	XwWncY2Zsjfa40zy37UZtRPecUq1kiu1EuxQb2eOAJI7cRnoOms0Ywtwui/cSQIMWkr/TAMdh60
	iRWbyXacPKlKLV62UgCW0/KanEer9/Eu9fjKkIxfK+oc/omOzlGDKW0t9LwxVkXQaTIR3UV51yb
	FDjJpkqHOQmbC2hXFnvQKJh8O1NmJMGeAPKSEy+FnW4X9+q9LC14lCujHmXwnYiuSl0S7+CznCh
	n+nAMnMhu/G+e96AgKZXZZ/+Nnn1YijCc=
X-Received: by 2002:a05:600c:5298:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488d68820abmr105375755e9.27.1775922603531;
        Sat, 11 Apr 2026 08:50:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:1ef3:1f1e:3a7e:32e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d53808b2sm181718715e9.11.2026.04.11.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:50:03 -0700 (PDT)
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
Subject: [PATCH next-next] net: phy: mscc: Drop redundant phydev->lock
Date: Sat, 11 Apr 2026 16:49:56 +0100
Message-ID: <20260411154959.200091-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277708-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: C93C63E0B34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove manual mutex_lock/unlock(&phydev->lock) calls from several
functions in the MSCC PHY driver, as the PHY core already holds this lock
when invoking these callbacks.

The affected functions are:

vsc85xx_edge_rate_cntl_set() — lock/unlock around phy_modify_paged()
vsc85xx_mac_if_set() — lock/unlock with a goto out_unlock error path
vsc8531_pre_init_seq_set() — lock/unlock around phy_select/restore_page()
vsc85xx_eee_init_seq_set() — lock/unlock around phy_select/restore_page()

Along with dropping the locks, error-path labels are renamed from
out_unlock to err or restore_oldpage to better reflect their purpose now
that no unlocking is performed. In vsc8531_pre_init_seq_set() and
vsc85xx_eee_init_seq_set(), the redundant intermediate assignment of
oldpage before returning is also eliminated.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note: Only boot tested on Renesas RZ/{T2H,N2H} platform.
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


