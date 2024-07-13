Return-Path: <netdev+bounces-111280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933D7930773
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E7B21E26
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A6178386;
	Sat, 13 Jul 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5pbhxa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EF31791FC;
	Sat, 13 Jul 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905435; cv=none; b=othdlsFoJXpdr9zCBVhXwlv2Z3oCeMV7z0jveFRUuLRZ2av906D6HqdQ/le0UguEB1B+9iCLJkWQEz4Wg2dE/IVpOTpM2Eo6MEuYWxIgPtmZvwHBBLBMccqSVg7mR55ftQxOUms27GQsBaSBUbxcSRtVSNAdHnnUOGyUfdfcjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905435; c=relaxed/simple;
	bh=NPqMgo9gtnZXY/h7WtRJxcro3cjnKeyxlLC18xc+HV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qh0HXnb86DMNxOXJrdqu6Iz0lfvar8rXixGg4k6o9sYNKpdj56TfO6DE2m5P9xqeHTvTt/b8rEZOUgWjjnTc+Rt3Skf5zku21Mx2Si3F7jw0ZFPNvmKdKuZ3L8YyT5uFhKVdrHQUnoWf9X9w1hYFcqEN9hVYtX1DoU4RuYfx5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5pbhxa4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so42825121fa.3;
        Sat, 13 Jul 2024 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905432; x=1721510232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQgibu500P3YDt2hMOG73vwrN+QAzL47wTR1RfSLcBU=;
        b=L5pbhxa4KNbNsgjlxnnXhqeiFLgrb9Hd3bjodKGCJly8BbyzqgaUhcX6S8b+1BsQMF
         LzM39hg+IWHjXY0gHHsO4FrAlB1z/vyQCK+AQGwaJPyD99bTLnxqBmpBmlDVP4rrSc8p
         f3F1OEtFgzzXLhpYkeMXTJnYwIz5OmRS6nbJQyC89I0QEYCA0cAsiahL3yYDqZAQJYmN
         d2tgj/64W9kRbf3HDVadyZR8qLkjcBPGCecncUg1r6R43Bgnz5ee9H2xXkphOoMX/a3H
         Sxs0C6RQk/Mb5t2X1dZgv491P1rhLZbKC+5m2mDlmTA7MYjl/zIYHDiISXJ4yKk9lewc
         J7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905432; x=1721510232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQgibu500P3YDt2hMOG73vwrN+QAzL47wTR1RfSLcBU=;
        b=Uf/7jW58pp+v3X3m1U+vifFA8veXs5N2dJQzJ3+35rTw4IEhZZyam805YghsAOY7e1
         62I6FdIcwRWwNKOML/wgmq+ov5b7Qro4pYnKROuHDEHLIADYp6Ga483GG8/XBWku2h/X
         oVouWZc5jcUp4ZE4FES2Cqlv//JAGSfWCwJK+04oHK0n+w8KLKR6w3Dxi8273bDUOVQP
         JaaemdIc0mRsHIvs4iG4y9r3ILi1HV+bLgx8FPMHAyDaCyPQLQVQESWOlE1mSuuojZbK
         cjk94zybIH1mdjQvK/xFLGMHpY9uXHiActatgCmrNIWk43QAqMLQsiCrbdbOku3E0G1z
         HBpg==
X-Forwarded-Encrypted: i=1; AJvYcCU12EfdZ3HOSWCqY5SgtLko17wBWTZBE6rOZcSEWfyj+5lNWp3HlWLnLd6B3Zb7rs+F3KBRRkPXEov7aBqABOKAfAd/ZxXrl4i/bTfT
X-Gm-Message-State: AOJu0YxTt+RAnFzEGt0xoX2UF8Kmq0RDbyDd1xGZoqXF6Tu1f1oSIu+C
	EBj0YqTOGgO9FhPhd0ZsaHlkbIhm6/cfgXs0OeorE8Lf8OptLe+zQukG+nDv
X-Google-Smtp-Source: AGHT+IHVOu8pSTKu1CC99P+PavQ2l22Ds/buADGjZ9G+zCFTKGmcVwNA6fvNLuMM5ecJhdKlcv9LRQ==
X-Received: by 2002:a05:6512:b22:b0:52d:8356:f6b9 with SMTP id 2adb3069b0e04-52eb99a270cmr10862605e87.38.1720905431594;
        Sat, 13 Jul 2024 14:17:11 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:17:11 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 12/12] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Sat, 13 Jul 2024 23:16:18 +0200
Message-Id: <20240713211620.1125910-13-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
which are required for properly treating the BR_LEARNING flag. Also,
.port_stp_state_set() is tweaked and now disables learning for standalone
ports.

Disabling learning for standalone ports is required to avoid situations
where one port sees traffic originating from another, which could cause
packet drops.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v4-v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8:
  - resend only
v7:
  - added 'Acked-by' and 'Reviewed-by' and improve  commit message
v6:
  - fix arranging local variables in reverse xmas tree order
v5:
  - introduce patch
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index d0e501bbd57d..d9d3e30fd47a 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1622,6 +1622,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
 	return vsc73xx_update_vlan_table(vsc, port, vid, false);
 }
 
+static int vsc73xx_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					 struct switchdev_brport_flags flags,
+					 struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int vsc73xx_port_bridge_flags(struct dsa_switch *ds, int port,
+				     struct switchdev_brport_flags flags,
+				     struct netlink_ext_ack *extack)
+{
+	if (flags.mask & BR_LEARNING) {
+		u32 val = flags.val & BR_LEARNING ? BIT(port) : 0;
+		struct vsc73xx *vsc = ds->priv;
+
+		return vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					   VSC73XX_LEARNMASK, BIT(port), val);
+	}
+
+	return 0;
+}
+
 static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 {
 	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
@@ -1682,19 +1707,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				       u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	u32 val = 0;
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		val = dp->learning ? BIT(port) : 0;
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
 
 	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
 	      0 : BIT(port);
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), val);
 
-	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
-	      BIT(port) : 0;
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_LEARNMASK, BIT(port), val);
-
 	/* CPU Port should always forward packets when user ports are forwarding
 	 * so let's configure it from other ports only.
 	 */
@@ -1719,6 +1746,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_sset_count = vsc73xx_get_sset_count,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_pre_bridge_flags = vsc73xx_port_pre_bridge_flags,
+	.port_bridge_flags = vsc73xx_port_bridge_flags,
 	.port_bridge_join = dsa_tag_8021q_bridge_join,
 	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
-- 
2.34.1


