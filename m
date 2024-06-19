Return-Path: <netdev+bounces-105049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8090F7DD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197AE1C22A45
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97A1662ED;
	Wed, 19 Jun 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAzCVFfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70015B124;
	Wed, 19 Jun 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830399; cv=none; b=PLpxcsE0ZUl8beTiGSNaPA1fvwX5l+x9IAThLkNfWOiF9kQKNQyythPX1U2rXWaxPxUYG0gUuvD20DW/TYHsCjESjKBPiPlW77SGKlP6GqpF1zywyJhiUAtuG3kEljITHrhaj21SNyEyuD3bdid2GcXd5M9LDxNghtm6xRHZBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830399; c=relaxed/simple;
	bh=RaADqzyGVgATxjkyrCGLr59ecKKEBBDwXHF88bT0AM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7f7D3rAPHoXclbXPCZjsNUmsOHZvW3zL20fEsE7yt2K4m8raOCZJULPUe43dM8di18jA2fTHMGM32Nz6reyItMojZv6TNJnOITzThIbkZj8V7fqIXOmFUz+3RrQc107bJsA6TiFz2xf9U00MRxYg+S6mjVVt5hEwlmI3Go+ZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAzCVFfz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f85f82ffeso17376466b.0;
        Wed, 19 Jun 2024 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830395; x=1719435195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoMonN5KTGsTAI06z21/CRk7gcVlzV6jDkZYPNRbNuM=;
        b=BAzCVFfzFtXhGVT0K+aUA3nOBZVflixIGbH1VzjbaSExEkLJAck8QvRlFaIPuOu/aB
         xshy3t8D6w3QS18aJ258F/QCJzy8P6lwk33Ho4gHB6OjOLFr6/nbzqLb+MypN6y8SCaR
         aHhYuqgwNAvcHVQFnnk3EC05fanilzn+YkQEbVcr4nQETtxBr8cPT5LBGMq7PfCyWo1r
         dpHMHcXZy9u189VzM+efznpQYKNKtuOHZ/yKHm2HFGwwXmxqPEzYqkGCzIf9V33+mpTQ
         r/6jAvnBV/z71qTmW6MIqcXRqqtKxAlni4zIQCl0TPC5tGri4KVXHNFzfBzIYC4DLDnn
         HScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830395; x=1719435195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoMonN5KTGsTAI06z21/CRk7gcVlzV6jDkZYPNRbNuM=;
        b=ofEiv1YRPECBHphjUc31NQGjU+Lzn0a/pmLGgpKV5JRKlF+ABI+mJiGYjofIvg/2LF
         wsHARslWjuxvWOdRSXuNIoGnOD51Za0OK0bUEp4A+ZzN8UCKAqAtxRxKA/NevOXUKDhI
         vMY6DU64H4n7RHHjg0ZyS3L53CyufD3/WgRWgHVVxdRO6JNtwaAcrXhDQnAiqAlDiilJ
         V7N+hKXhfD2YYu2SV2HcYqegHxFUY/XGYd0W6uM6AtOAspsV3FW5DTM+Rwpjde4wy0Cv
         OMajHB3W+h9K9iWH2Fz/A7gZ2YDCCx8ExbjAs1V9LE4kNe/EAixa3scsZdyUK/BfxzO2
         Ul2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDtj9jj3td9ImPhR9ESAYBjIWzuSVa0jlsDSO4UhF1tywWpjOo6YMOskrHarJa0avxbuoFoUll4ke/ZAau+EjXBccxbWvXAtRIOaKg
X-Gm-Message-State: AOJu0Yw9yNYBXYzwbDt+gq15oEhqZcYGdOaXYcpsbg3gLYExnQO6G+2f
	kElAHq77zUfVo8XvQc+RmQu2iMSf9frULsjSU9hEeylYmNN+NRM9OQPoNRO/Vuk=
X-Google-Smtp-Source: AGHT+IEXILH/Tq7bqav/jGPzVjS1HnrVKhCXc5prH+gFx0OUY5ZvV9Y41L0pcmcVKUPdVUo7XV42/w==
X-Received: by 2002:a17:906:3c48:b0:a69:13a2:4f6e with SMTP id a640c23a62f3a-a6fab7d6d0emr203187266b.74.1718830395383;
        Wed, 19 Jun 2024 13:53:15 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:53:15 -0700 (PDT)
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
Subject: [PATCH net-next v2 12/12] net: dsa: vsc73xx: start treating the BR_LEARNING flag
Date: Wed, 19 Jun 2024 22:52:18 +0200
Message-Id: <20240619205220.965844-13-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205220.965844-1-paweldembicki@gmail.com>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
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
v2,v1:
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
index 6606bfdf58b0..11660f1d7cbe 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1581,6 +1581,31 @@ static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
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
@@ -1655,19 +1680,21 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
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
@@ -1693,6 +1720,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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


