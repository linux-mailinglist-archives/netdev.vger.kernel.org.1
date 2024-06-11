Return-Path: <netdev+bounces-102701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F8D904557
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886BE280F7A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16B0157A46;
	Tue, 11 Jun 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2EPFSHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C59157492;
	Tue, 11 Jun 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135499; cv=none; b=KhvN5W1pqVqfwgCETta3U4O2RUPdRTnxYGZ8iflx0TjsUMPoYnb3PGQAWnpQ6IzgeQlXKXHOZ6POmPxgCzxu2Ru/uhcIT2byhZlDgWlHB3LNNA95PW3s6cZh12mAYQAj9ZeAtgQGJvYuK1F115VAnZLuzyQxSTqpSzJRty9zMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135499; c=relaxed/simple;
	bh=+RDHrnohSAyhoajZ4SCPPdctIWJd9H2BoT3P/Fcr22U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLGQKcHHLkeY4mMY2zgiHKn+B+qxuc+IOyuD6jGccl3Iouzo4ubt5YpJ/FbtmqfMuCNjMiJ3BIlqICKGU+NJfvDel8EyRINDTAmt7eXJjKbQhjwKKyEODjXDoEAD9JdVc1y8cjGvcouPDV+baqrcUBCH1GEj+Un6oqXkfIiRYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2EPFSHe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebed33cbaeso16562421fa.1;
        Tue, 11 Jun 2024 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135496; x=1718740296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A340mtEjf+HpqQSbD/fX+pjSP4Osr75EcDU1L1W8Y+8=;
        b=P2EPFSHeLhTcxe5c3lOpRJoCko5gnXySYtS18ZCx9fWbN5+CLYswxAU0sp8uLHfl45
         6NaTnRaQA1aYHupDP9IgKp8tQTkWZZKTY/oCjT2j3YpJbzJLQAo6m6IWISebjBooqgZ4
         fWOzSNPXtAQ27utBjOCP2nqU9n9cS/tE3yg3/ze1oFnCFW1B+zVqRLi3lQW0UOuBqb9S
         X95lTtIFSD6mzcQeG2JNGH8Ih3+kaCcjbkE+cYBvtBYHDjemXR0aabK3kF4XaOLDlh65
         fJsNk4GPGjZs3CioXdZRFnqVdxBDTTwBB9Wezy8twnAWd0v856eMJJgQJr39KM5nBvPH
         IIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135496; x=1718740296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A340mtEjf+HpqQSbD/fX+pjSP4Osr75EcDU1L1W8Y+8=;
        b=vSvwd27XQ2T6SGlfLBP1E/VKihIOD0pTdN9/wkYzGFy/FjB7niRUnCqIazM/rCFMIl
         nf+uVw1rQhkSNJbWKLQh6oUOLjH48it2mMpVr6QDI5PNHMxOTbD1/019+bRI/8yXYU/L
         kdDXzaL/XjWTy+r3xywKW/XAyTur2MU3V6nko/lvBSad7SQIS9EEhnIS38DJn76HCBNj
         0aEpim54bukJ6hinTi38nKPUT3+6pxcsTAKz9dJLrKcX2b+QaXhUiop2Xmq1GesAejB2
         3DctbSgkb5+mxTKgEU0Yk96GNrK45vkEduoym/416Y6bdpjPfuB4GAXScfLwg2vNVhSu
         gN2w==
X-Forwarded-Encrypted: i=1; AJvYcCUC8RmeH4rgrIvK1yLoG4JAIrv+XFMwRrQJuOSqK6CTWaggCMdm0tpfGNmjK0IvDTqXT0ggkQJa6Z+hcfCPN6fSm/f9Y7UNp9kMXnJe
X-Gm-Message-State: AOJu0YwccgSMpvLLlch7co5WRwQ/Bh9orNPTnPAoalgFntkELx3h09cU
	hr2k1VIBg03uqBx1LX7Qtd76bK365SCOyF2O1yM9f+PJhy3wYnUwBtn0vvJxc4Q=
X-Google-Smtp-Source: AGHT+IG31zr6oc0gMnKxXF2RWOSy95HFOTS65nReVC6vqQZxdn0Jh4YZBarVwvc6/oJ7elyjcmOCqg==
X-Received: by 2002:a2e:a99f:0:b0:2eb:e4b3:2782 with SMTP id 38308e7fff4ca-2ebe4b327bbmr50365901fa.52.1718135495890;
        Tue, 11 Jun 2024 12:51:35 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:35 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 12/12] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Tue, 11 Jun 2024 21:50:04 +0200
Message-Id: <20240611195007.486919-13-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
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
v1:
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

 drivers/net/dsa/vitesse-vsc73xx-core.c | 41 ++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 7d5522e146f5..e15098a7b75b 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1538,6 +1538,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
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
 static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
 {
 	struct vsc73xx_portinfo *portinfo;
@@ -1616,19 +1641,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
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
@@ -1654,6 +1681,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_setup = vsc73xx_port_setup,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_pre_bridge_flags = vsc73xx_port_pre_bridge_flags,
+	.port_bridge_flags = vsc73xx_port_bridge_flags,
 	.port_bridge_join = dsa_tag_8021q_bridge_join,
 	.port_bridge_leave = dsa_tag_8021q_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
-- 
2.34.1


