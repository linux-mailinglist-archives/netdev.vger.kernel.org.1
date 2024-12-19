Return-Path: <netdev+bounces-153226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365469F73B4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 05:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726B0162C16
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FA6216395;
	Thu, 19 Dec 2024 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ+vvfDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922978F4A;
	Thu, 19 Dec 2024 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734582872; cv=none; b=PHiBgTw8/j0csC8PKLCWAv/PyCDOmwbqrJoLqQqahFpQgBy1Ofdo63aqfcFQU82tAAQmBk1mv1fm5vFQ1erFLXSMQeixy8RPjc9khk4hELcG9inHZgOcotj0m0wDHXy3pWXkGsXBfzCclU+R5D75W+QdZd9ip50Fvnoqk9adx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734582872; c=relaxed/simple;
	bh=Mew50UFjlFRO0yAQrD66BR+CTHzPRYQ7QV4FDOWkrVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkGM+D+kn6XMp3iC3DMkay2x962D1AZoG79IiaVZ6m2mIeUsWd0rdNiy62hGEUBKngKAGzIm4N2Jo4Qn2EWOUzmcTib0S3OQKXgjt/sTQNF/Xk7VABi7Oc2ZPA84e3n7Zs/d7/JaIHZjRG7DEy1au5X4shKKcF/xmr9OBHsQC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ+vvfDc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215464b0432so537605ad.0;
        Wed, 18 Dec 2024 20:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734582870; x=1735187670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhdqMXbXmBxx1W827hZPVn0JqgZrKEkmNFd3Ir0QtWA=;
        b=fZ+vvfDcAifcBBedTM9Mf2BkPzZeDc2TmIL0lltND1Lubxl74U8JGFPNf0rKP1mCva
         4tDzfxQYyz9M2mXkeOa92PbyNwTQhx4CRE3TFaCoKQxeZPs8mKI0vCNLk5aPexfTQuiE
         Qwn+zE+bDjmVEchDXhk6VvQuEs9DesOTyfecva+u3XTsRESGjiutmSLZk0tC1NR/0zmM
         5nueUtiNRk1A/y9fCIgyeENFKdGcfU46HMCXWx67Mtu38ya8ITROn61gCpz/diDlZUgg
         D92g0S5GUJ2O0Icaum2XWIABfv+/dzf/Svydt22N93eexWjcLpGZimxQB3xvNKn4LGWT
         F9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734582870; x=1735187670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhdqMXbXmBxx1W827hZPVn0JqgZrKEkmNFd3Ir0QtWA=;
        b=cPWelsfhvhq/e+8bWc0wsUtnJdpFmD/5Ygpr5t3SNeA01yMp5hHYAlTLAuK6UMkSXg
         mzjzwvelTdUVmhgNsSxdoBdOh6iQyjd/S+xyE/6iBSMZ0kH4LbSI9RS+GVyR7RSIKeSB
         xAIcJHr5o7U/C+jRe1GjJd/nW3PbhxC/CVBW1A4c3/LSOqzE7QOLWim5+WIc8uXxDfme
         EyGpWdAxJcMDCiPLHfRA0R/Zztg8ITCD4/7ZSRJSQkbPW5Up5TS6W5EgRnbSnY2Pez9S
         56k7u5vP83Hy/lUG4OXtv0q3EpROKNtEQ3vQ4352Sp22YYc8voxtNYjk8a7oIqj42ftF
         59Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUOIIocGYKp7BLJJmNuH6fcpF5+3vp71BkiivqmCRoKnBzl5hMDiV+sO2W+DQlj9OaYoMgB9z7R@vger.kernel.org, AJvYcCUs6htpRcqa6kA7rucInZkxATT7fqmA9HRQJ/UtYnKpXISZT6fMeMgw1NEjejoOrNzKpb+mboye+LxtgQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz67B08Yy+zQ/ONrq0XK9cphTpUvWSr8FqitxkX2Z51vOD+7jj
	0OIMGLfPdYXO5BhScRjXAy8Vm2LahLO/r5LAzmRuIaCGL868ZZ6v
X-Gm-Gg: ASbGncs3fdn55udMauUH3UlmLjFwVwQfBgaxhDSjvQCRRB0MdE/jCRcRbayUx6uwK0T
	DJFNVKZ0xHlOogNqjiVY1F9Mg2/bfzHOsmT2p5pRF/pgFdVVrBHoTQXFOfH/xepUrcX4yr1zs7U
	I5ZnctgHbG18WP+blxw9WCFG2vzT/LuCbWw30Jju7s6ntt5ID5MCGFsy3dV4qAkpqCk1xAb0uhN
	iXH06xtkTeH9r7gpCW3JpwacFyw3zMxnd39uYhbde7iHV1i/ZBB4yyjRcq52S9IODtl7Hf/m2F0
	XDk=
X-Google-Smtp-Source: AGHT+IFJ9NOFEUAkcch6EsxnNxZvqWeFxIrsRw9lzLG6XjA04kowmFa+bl43953Pc3yx97GIj4cltw==
X-Received: by 2002:a17:902:d2c9:b0:216:4339:70f with SMTP id d9443c01a7336-218d722714dmr26813115ad.8.1734582868701;
        Wed, 18 Dec 2024 20:34:28 -0800 (PST)
Received: from ubuntu.logpoint.local ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f71sm275283a12.9.2024.12.18.20.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 20:34:28 -0800 (PST)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: b44: uninitialized variable in multiple places in b44.c
Date: Thu, 19 Dec 2024 04:34:10 +0000
Message-Id: <20241219043410.1912288-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smatch reported uninitialized variable in multiples places in b44.c.
This patch fixes the uniinitialized variable errors in multiple places
reported by smatch.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/net/ethernet/broadcom/b44.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index e5809ad5eb82..9a466c5c4b6c 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -314,7 +314,7 @@ static int b44_mdio_write_phylib(struct mii_bus *bus, int phy_id, int location,
 
 static int b44_phy_reset(struct b44 *bp)
 {
-	u32 val;
+	u32 val = 0;
 	int err;
 
 	if (bp->flags & B44_FLAG_EXTERNAL_PHY)
@@ -414,7 +414,7 @@ static inline void b44_wap54g10_workaround(struct b44 *bp)
 
 static int b44_setup_phy(struct b44 *bp)
 {
-	u32 val;
+	u32 val = 0;
 	int err;
 
 	b44_wap54g10_workaround(bp);
@@ -512,7 +512,7 @@ static void b44_link_report(struct b44 *bp)
 
 static void b44_check_phy(struct b44 *bp)
 {
-	u32 bmsr, aux;
+	u32 bmsr = 0, aux = 0;
 
 	if (bp->flags & B44_FLAG_EXTERNAL_PHY) {
 		bp->flags |= B44_FLAG_100_BASE_T;
@@ -544,7 +544,7 @@ static void b44_check_phy(struct b44 *bp)
 		if (!netif_carrier_ok(bp->dev) &&
 		    (bmsr & BMSR_LSTATUS)) {
 			u32 val = br32(bp, B44_TX_CTRL);
-			u32 local_adv, remote_adv;
+			u32 local_adv = 0, remote_adv = 0;
 
 			if (bp->flags & B44_FLAG_FULL_DUPLEX)
 				val |= TX_CTRL_DUPLEX;
@@ -1786,7 +1786,7 @@ static void b44_get_drvinfo (struct net_device *dev, struct ethtool_drvinfo *inf
 static int b44_nway_reset(struct net_device *dev)
 {
 	struct b44 *bp = netdev_priv(dev);
-	u32 bmcr;
+	u32 bmcr = 0;
 	int r;
 
 	spin_lock_irq(&bp->lock);
-- 
2.34.1


