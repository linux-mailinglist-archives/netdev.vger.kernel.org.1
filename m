Return-Path: <netdev+bounces-117280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131EB94D726
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7FF1F2523B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259615EFA4;
	Fri,  9 Aug 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZa6LtrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E49156228;
	Fri,  9 Aug 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231319; cv=none; b=mNOAOsS2JOcvwf5l1lpb+AZICOt1/brWB8dz+0fGVZh1fuS45qCJ056QIU22G9Ans3YET1QC3Z98ZdwN4LkSMGmUFQywQanGiuS1uzgtNghWZklhgRr5RJQzcwcb2Bv7csl2tvsfAJiCHKJELhzX8rX7aZefRoNHAI1csD9Xsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231319; c=relaxed/simple;
	bh=t0e0a6LXI6LeDS1IfT6HENQbOl9eDddwRUJQCJMyh3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lf9w0Z8X1uK3CgFnM5KUlY1usJ+LNzlyHctmZmxqRVaX+76Nj+dezCew6t7yIsCjpmsxWGw6gqa0JmGeF+g/QQS6CPYuFaUX92jcMIYKVgU7wTc+yRDZmeXEhSR7fdaKhbLauojK4e3nqg77JNCk4U5TtqGGVlE/Hsjmg+Tjg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZa6LtrD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso32733561fa.1;
        Fri, 09 Aug 2024 12:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723231315; x=1723836115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zQR5I5Z9YI9eBNAvBlhP8v0AMty41l/RawM3riRFrM=;
        b=mZa6LtrDxr5bhxobUTTM12pz+GFx5SWu4n+QVatZXAEODrisKoC/WZlhC5q3tgmOIT
         cKHMXR9zbE55cG/i2VCUvNc1sMrq4pCvy0kkBfETwul2cpLrxiFKhUAUdtTbdYhpUPao
         knu+SVqFaA/yJR5VcnAlXxOLMeg12h7wG8jSOa4RW6iVyt38GhVmedQAhsIOEawJMEzl
         yYYwHMMwuJWYaCfnMagEhHG6BVZLPItHa237I9obzKVOI23Of+G/DnVwPRI+HDqXmF0g
         8DfE9Y817w92DUgqYVa8uQZHpVZRDc/so8rkkGbPlzrDFfaOGxZLIgk2sVhQAF/YJc28
         mS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723231315; x=1723836115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zQR5I5Z9YI9eBNAvBlhP8v0AMty41l/RawM3riRFrM=;
        b=Gvl6OD3xICf8o/ndZBQzfppJPMdbNpyllYO19KLVk/Dcw35+NFC2EtueqedE/msmHl
         vIu2O8M8+WXNZL7/+3aw+Or+mPyzu0SJA4J716/eIq3g4TvkcwchU+1Gb1Sbv7eZLGBy
         IxtmOYL/VenntcI+OGMEK7iUI3x3XrEuJeOeEBRK/w5X4sl1nqG5bcaU91zEwduRDXDu
         b4TDJYSG8yHKgkV2kcQEl3DnTfGl7hVJcZT6YWxIn930cx+qs/qZfnxNUJ1XHdrGgLul
         PiSSVWHu7G1JiZYGfytawf3XVL7ollRds2pNLdG8TrV+1iKo1EIJgSDPQk+CWf38bEG/
         OS9w==
X-Forwarded-Encrypted: i=1; AJvYcCVRbHpRkbuTHQhiseLfLeiSJ8Kfpxf/022ttxlfZveHzTggkw+HvPYyns2aIRoSzLx0ee+iIRSeM+v7ZRFQNKPcP+ZGqooHv6tCTAB8YQLnVeQyVFsRgd3d/4I6BV6OMWa1Jk0U
X-Gm-Message-State: AOJu0YzHqipAE3fv2TluMV+augnjD1e4SiefQvjA5vSd4CTVWs6/bJC1
	cJmYnQqf+y8hH8op4Vjc+JzLfNVawt/QNCYMU2cJ5U+9XeF6PWpt
X-Google-Smtp-Source: AGHT+IFZsdAmeqUUT6dg+xSHUP03KteOOKTe2JhiKfH0J1W1ciDN8u2ABk4LKTPDoact9/vXoMGhSg==
X-Received: by 2002:a2e:9dc5:0:b0:2ef:21e5:1f01 with SMTP id 38308e7fff4ca-2f1a6d1da0dmr19326411fa.20.1723231314255;
        Fri, 09 Aug 2024 12:21:54 -0700 (PDT)
Received: from localhost ([109.197.207.99])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291ddbbb0sm435501fa.8.2024.08.09.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:21:53 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: stmmac: Fix false "invalid port speed" warning
Date: Fri,  9 Aug 2024 22:21:39 +0300
Message-ID: <20240809192150.32756-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the internal SGMII/TBI/RTBI PCS is available in a DW GMAC or DW QoS Eth
instance and there is no "snps,ps-speed" property specified (or the
plat_stmmacenet_data::mac_port_sel_speed field is left zero), then the
next warning will be printed to the system log:

> [  294.611899] stmmaceth 1f060000.ethernet: invalid port speed

By the original intention the "snps,ps-speed" property was supposed to be
utilized on the platforms with the MAC2MAC link setup to fix the link
speed with the specified value. But since it's possible to have a device
with the DW *MAC with the SGMII/TBI/RTBI interface attached to a PHY, then
the property is actually optional (which is also confirmed by the DW MAC
DT-bindings). Thus it's absolutely normal to have the
plat_stmmacenet_data::mac_port_sel_speed field zero initialized indicating
that there is no need in the MAC-speed fixing and the denoted warning is
false.

Fix the warning by permitting the plat_stmmacenet_data::mac_port_sel_speed
field to have the zero value in case if the internal PCS is available.

Fixes: 02e57b9d7c8c ("drivers: net: stmmac: add port selection programming")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note this fix will get to be mainly actual after the next patch is merged
in:
https://lore.kernel.org/netdev/E1sauuS-000tvz-6E@rmk-PC.armlinux.org.uk/

Cc: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaea..fb63df1b99c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3422,7 +3422,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		if ((speed == SPEED_10) || (speed == SPEED_100) ||
 		    (speed == SPEED_1000)) {
 			priv->hw->ps = speed;
-		} else {
+		} else if (speed) {
 			dev_warn(priv->device, "invalid port speed\n");
 			priv->hw->ps = 0;
 		}
-- 
2.43.0


