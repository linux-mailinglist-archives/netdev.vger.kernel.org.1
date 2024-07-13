Return-Path: <netdev+bounces-111269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D693075C
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9C21C20C11
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944214F9CA;
	Sat, 13 Jul 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrBn61pY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD801487CC;
	Sat, 13 Jul 2024 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905395; cv=none; b=d3CW+/q7PYcobOjShwUYT/bVtUqP5fMEP4ARcduCHroUenXrDO1pZwk11eYLKg9AmtfmGSjh+k9xH091zIS2N8Okqa2p7IppMOpfnF380S4bbwUtp54u8XsLzhuqZGE1j7eu1+eiO3LZpIJkLQfOr3KLQXyCkjjiPapSscsmpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905395; c=relaxed/simple;
	bh=uWtFnFc6EcdWJ1WaheqNs4Zpfq9xp9F3Z5MM07kdFak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxBvBQTH2U/UqZGeJFl6fk7tA9tQ3d5vHERZUQp8QcMh0ku+kYFhdI0KDztO7d8uzJ6nxeFbwV2FzIA1K3JYIr9I7frxqh569/VuObVvVTxM/bh+a3jZhCdQDLmzII7jbVuYNEJZ04sQBccHnJIbU5njMIW7KeznOH43GcoXlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrBn61pY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso3793408a12.0;
        Sat, 13 Jul 2024 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905391; x=1721510191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlzlcpUrZaecTJnrW4oTkslDFRnaIxgJzpmItmI/lNU=;
        b=UrBn61pYUukbRvMAg1z+J7YMCpFAz8FKk2NlfBja1wSdrNBqbHckZS2+fzU/NrBZOM
         eclsccp3F9pcKNoDyvCTcb5IG30hshdbRbQMAnpEmghihYm3fi86UdFBQj67yjGxjaZy
         zc9/Nye3h8GYcAqM7ZAEM2wiXvwHItTF4MSBRK3UiwVHuP4AbKmeS3FuBkb8i3WyE5JU
         UtKQlakno4SigT9TQUkN2FvpTka7UGqWpTewX1PH0uoFj9CJZN+1Vl2eNLJaKiJf+sQ7
         990B5nG8aM47tJ/poMgQCUc3uuicEJijhQvDyECzZF2MqpJ5+V7z2NVcd5yXJ9JopQ1x
         oWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905391; x=1721510191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlzlcpUrZaecTJnrW4oTkslDFRnaIxgJzpmItmI/lNU=;
        b=MUB3GHqBIGFc1XQc/5hLpo2q1nGU789za5wI2pYrTEsOp5FxHgrLH0QFNOheR8WeFo
         xtQfeFrZCgsfhjp4NjWnZYrBtqooP6Dfk3uMM/hxXNSr3oc7grJ9H4wKrKNS8f3FTQa8
         FIVFLhzN85C+siVJ1yRdfwobfS5r9oO4/aSnaI+HO3m4n57wrDsHofbMzdFJPOzdK8VH
         hzpawW5l5J3qlRKeXO9FWK1jP0zeuZ7yWX3jJcGfDI6uPxcDBIqQUyfAMM9viLXjBEkx
         hN6qZXWF7+UkfZpCGIotnvd5iKBLJpLH/ATaKWIShiY55GxZTws23AAaem/YnkKnm70A
         15PA==
X-Forwarded-Encrypted: i=1; AJvYcCVLFiuVWDazcnllBrQqzl8NIjHiSePGd/oDmNKfhwBwN2LRcR8JpDkVBSRv9EEvOIpo8pYZmOkcyt4OUdrVMwFBODVcuwVSVyuAGCkr
X-Gm-Message-State: AOJu0YyhtlST+4oTtmlNpBHse/NDNpt3nAGzlxyTdOt+ULGCMZxfbXJN
	xI1qkjrrITNzOPGPaHH4g3OihWrpHcSIkwXMPiT9z/fCTFcMCcNlkn/fpe1F
X-Google-Smtp-Source: AGHT+IEJ4qdTMRS+WhiitFRDzZ1hVGDe8yCdKMwXz0IyxllXbHMIl+4lo9wPcGuB1g9fwuuxGT2EuA==
X-Received: by 2002:a05:6402:5187:b0:57d:6326:c658 with SMTP id 4fb4d7f45d1cf-594b7d840admr12718186a12.0.1720905391249;
        Sat, 13 Jul 2024 14:16:31 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:30 -0700 (PDT)
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
Subject: [PATCH net-next v4 01/12] net: dsa: vsc73xx: add port_stp_state_set function
Date: Sat, 13 Jul 2024 23:16:07 +0200
Message-Id: <20240713211620.1125910-2-paweldembicki@gmail.com>
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

This isn't a fully functional implementation of 802.1D, but
port_stp_state_set is required for a future tag8021q operations.

This implementation handles properly all states, but vsc73xx doesn't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v4-v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v7:
  - implement 'vsc73xx_refresh_fwd_map' simplification
v6:
  - fix inconsistent indenting
v5:
  - remove unneeded 'RECVMASK' operations
  - reorganise vsc73xx_refresh_fwd_map function
v4:
  - fully reworked port_stp_state_set
v3:
  - use 'VSC73XX_MAX_NUM_PORTS' define
  - add 'state == BR_STATE_DISABLED' condition
  - fix style issues
v2:
  - fix kdoc
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 96 +++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4b031fefcec6..ebeea259f019 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -164,6 +164,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -623,9 +627,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
@@ -788,10 +789,6 @@ static void vsc73xx_mac_link_down(struct phylink_config *config,
 	/* Allow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
-
-	/* Receive mask (disable forwarding) */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), 0);
 }
 
 static void vsc73xx_mac_link_up(struct phylink_config *config,
@@ -844,10 +841,6 @@ static void vsc73xx_mac_link_up(struct phylink_config *config,
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_ARBDISC, BIT(port), 0);
 
-	/* Enable port (forwarding) in the receive mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
-
 	/* Disallow backward dropping of frames from this port */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			    VSC73XX_SBACKWDROP, BIT(port), 0);
@@ -1039,6 +1032,86 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
 	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
 }
 
+static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
+{
+	struct dsa_port *other_dp, *dp = dsa_to_port(ds, port);
+	struct vsc73xx *vsc = ds->priv;
+	u16 mask;
+
+	if (state != BR_STATE_FORWARDING) {
+		/* Ports that aren't in the forwarding state must not
+		 * forward packets anywhere.
+		 */
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+
+		dsa_switch_for_each_available_port(other_dp, ds) {
+			if (other_dp == dp)
+				continue;
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + other_dp->index,
+					    BIT(port), 0);
+		}
+
+		return;
+	}
+
+	/* Forwarding ports must forward to the CPU and to other ports
+	 * in the same bridge
+	 */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + CPU_PORT, BIT(port), BIT(port));
+
+	mask = BIT(CPU_PORT);
+
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		int other_port = other_dp->index;
+
+		if (port == other_port || !dsa_port_bridge_same(dp, other_dp) ||
+		    other_dp->stp_state != BR_STATE_FORWARDING)
+			continue;
+
+		mask |= BIT(other_port);
+
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + other_port,
+				    BIT(port), BIT(port));
+	}
+
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_SRCMASKS + port,
+			    VSC73XX_SRCMASKS_PORTS_MASK, mask);
+}
+
+/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
+ * forwarded only from and to PI/SI interface. For more info see chapter
+ * 2.7.1 (CPU Forwarding) in datasheet.
+ * This function is required for tag_8021q operations.
+ */
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
+				       u8 state)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
+
+	val = (state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED) ?
+	      0 : BIT(port);
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), val);
+
+	val = (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) ?
+	      BIT(port) : 0;
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_LEARNMASK, BIT(port), val);
+
+	/* CPU Port should always forward packets when user ports are forwarding
+	 * so let's configure it from other ports only.
+	 */
+	if (port != CPU_PORT)
+		vsc73xx_refresh_fwd_map(ds, port, state);
+}
+
 static const struct phylink_mac_ops vsc73xx_phylink_mac_ops = {
 	.mac_config = vsc73xx_mac_config,
 	.mac_link_down = vsc73xx_mac_link_down,
@@ -1057,6 +1130,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 	.phylink_get_caps = vsc73xx_phylink_get_caps,
 };
 
-- 
2.34.1


