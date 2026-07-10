Return-Path: <netdev+bounces-306518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kv7KIK/PUGqF5QIAu9opvQ
	(envelope-from <netdev+bounces-306518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF63739E20
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:55:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A2SHe7cY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306518-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306518-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10F1D300BC4F
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D1410D24;
	Fri, 10 Jul 2026 10:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9205372B41
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:55:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680905; cv=none; b=vFEDr76ZvAHRvDF+84ggdu81d1XIPvDN/HiULvLDerR6kRHZkc8YjwVP0Qqm5fl3BeRjd4TEzsgSuXgZU8TGgNMImBvlwNxTc6yYtDGebWJ1X2tbm/5ctAFPpOFrRkfBf1kkj+SHGnne7hBSWh9wDb5v26j3F+E6JtHYcEsB8Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680905; c=relaxed/simple;
	bh=Jc+cyW0SAXe60JSqWOsvka8eUS3RRaYLEvEnsVaDZaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8chxSBcnGBeN5jx8IVWKqwtP8K/wgmOWCn+iMhQCS1x7bNIBD7LB93cS3ZYxgwiQ9AlHS6/W8Eclmv41p4EpJYfH5nUnjpisc085RCmroPtkrtohmGQm5Nku8KxYj10I1ZFrHFen2cjpasMGnJ+D5mtK/joEDGnCBCjY+uHqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2SHe7cY; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc891373e0so6848885ad.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783680902; x=1784285702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=534LbVPyjYMVPj0BO46vzk6oyGda1cLHKL7+ZYYErcI=;
        b=A2SHe7cYRsiwO1lIeI/WbX1PADypli+s3N78ZJU1WKIey34CeB3g+xIbE7J/nXieis
         y6tN7rGqtzwFGpjmttLcuSmvefIongiM/oQdV8dNCuFaORUCcD/oLM+7X0S7Wk7XrxST
         kBUkLD73dyeerZ/P+z29GdUqBCaWUVTyNnkbsRkW7GGK1Cbni3HS5TvmKzfs2nPn+NZw
         5QmqHGr5ldusnDgeHIgKWH7tbKGIVthvviffzlQRyYimlq8kSRrpmFdyFmoK49wB5V/G
         Fl4Q4qrj7T6EAot06midMMUJ7Yhb8leqJV81/tjzXNUlmDAZdLnz7Zy4jUskXZX1FB3P
         29xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680902; x=1784285702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=534LbVPyjYMVPj0BO46vzk6oyGda1cLHKL7+ZYYErcI=;
        b=TB4awD3YCOQiLdFipI++CYTfDMfj5i/g5FEmnoEWPnhf2Y3KE1TlxIebrJVL9XR7fM
         pwzsTsD+xvrj98bCJqNLv5bG76CNt7tIFnqIKMQ+khBy3VCnp84MsawfBf9LatwWMCcp
         A4isDH5NqM8h27SKARXvENW+4dt6FyNkUUfy+YnFbYYKqZOrKqmSMnY73egNMVOySQHj
         A+KCSpgR65nFK445CI4FJLM/DaczxQayUOrRmQUfvYQhFm1BSRZZXE6cL5G46pETfXl7
         Z0amc1bknkgTwLWjwppqtN0XSJnto3C2aEp/Nf4Ry2AHGEFfdAdN2RNs6fI7BDgRd2VO
         IiRg==
X-Gm-Message-State: AOJu0YxvMGL0/aA80zE23qYN5YH+szjlBZffi83stfvdcUAVc5uZ1vgX
	UviHlmEFYkUFnP+0LBPyzZUsnSRrJJ8qCJ0YCFUvGRca8focTqsh/DnwswqGvoeK
X-Gm-Gg: AfdE7ckiTicOCC6zFb+RSuX7QqLUi9G9F7VnTHLO4lxrBasTakO0d97/a2SGxOst/KO
	szxMiS556Z32rpznIx/pwnvXMKj/si6MaEQrvc4D8RLJk9LjDc6Qd2rsh73WXewShNtkEK85T4B
	utBalN9eOKYJ11xFj6ovC2N3b//oV0JhS6SYorqEh3gTtXiezibOwbth+C+haUg1Zs9vII/7oFh
	40pvmZP3zF8iHWIF1prrTzZeRlQbhxSNijOBEJY0eQvK5BdjmIO8+tFKvmCCFcpMDrQOmltPRof
	MU4Tetff3WYaRl2Iz+uRQqdIwU8zXu2YdzH5y2fURGFQjcrXv0NbvbqTrgbWt1hKzSh+tEtJ0Tp
	sKBotu67y0yo2z5JOoDsyhBGAwXRusDzR7cqIERDx0JrtERmcpeG4wIH8sX4q+BY+A1XWt9xrlI
	lYykOsRV0L0Cw3lzxQlK3CbOdm+mIwCSA=
X-Received: by 2002:a05:6a21:6b01:b0:3bf:baed:c797 with SMTP id adf61e73a8af0-3c0bd0fa3d7mr13220654637.49.1783680901822;
        Fri, 10 Jul 2026 03:55:01 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8572sm40752937c88.9.2026.07.10.03.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:55:01 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net-next 2/2] net: dsa: mt7530: add EN7528 support
Date: Fri, 10 Jul 2026 14:54:24 +0400
Message-Id: <1865eaedef97e593ba608764c7390209cae85b30.1783680864.git.naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783680864.git.naseefkm@gmail.com>
References: <cover.1783680864.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[naseefkm@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:arinc.unal@arinc9.com,m:chester.a.unal@arinc9.com,m:davem@davemloft.net,m:andrew@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:conor+dt@kernel.org,m:dqfext@gmail.com,m:daniel@makrotopia.org,m:edumazet@google.com,m:kuba@kernel.org,m:krzk+dt@kernel.org,m:Landen.Chao@mediatek.com,m:matthias.bgg@gmail.com,m:pabeni@redhat.com,m:robh@kernel.org,m:linux@armlinux.org.uk,m:sean.wang@mediatek.com,m:olteanv@gmail.com,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:naseefkm@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arinc9.com,davemloft.net,lunn.ch,collabora.com,kernel.org,gmail.com,makrotopia.org,google.com,mediatek.com,redhat.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naseefkm@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BF63739E20

The EcoNet EN7528 SoC integrates an MT7530 switch (the chip revision
register reads 0x7530), memory-mapped in the SoC register space and
reached through the same MMIO glue used for the built-in switches of the
MediaTek MT7988 and Airoha EN7581/AN7583 SoCs. Its reset sequence and its
PHY indirect access registers are the same as on those switches, so add
an ID_EN7528 variant bound with the "econet,en7528-switch" compatible,
reusing mt7988_setup() and the indirect PHY accessors.

The switch core, however, is an MT7530 and not an MT7531 derivative: it
has no MT7531 CFC register, and the CPU port to trap frames to is set
through the MT7530-style CPU_EN / CPU_PORT fields of the MFC register, so
add it to the MT7530 handling in mt753x_conduit_state_change(). For the
same reason the MT7530 mirror and force-mode register layouts already
apply to it as the default of the MT753X_*() macros.

The four user ports (1-4) are connected to integrated Gigabit PHYs at
MDIO addresses 9-12 of the switch internal MDIO bus. The CPU port (port
6) is connected to the SoC Ethernet MAC at a fixed 1000 Mbps full duplex
link, so the port capabilities cannot be shared with the MT7988 and
EN7581 switches, whose CPU ports run at 10 Gbps.

The LAN GPHYs advertise EEE by default, but negotiating EEE with some
link partners results in an unstable link with dropped frames. Disable
EEE advertisement on them at setup time, like mt7531_setup() does for the
MT7531 switch PHYs.

Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---
 drivers/net/dsa/mt7530-mmio.c |  1 +
 drivers/net/dsa/mt7530.c      | 56 ++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/mt7530.h      |  1 +
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 1dc8b93fb51a..1065671bcdd1 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -13,6 +13,7 @@
 static const struct of_device_id mt7988_of_match[] = {
 	{ .compatible = "airoha,an7583-switch", .data = &mt753x_table[ID_AN7583], },
 	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
+	{ .compatible = "econet,en7528-switch", .data = &mt753x_table[ID_EN7528], },
 	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
 	{ /* sentinel */ },
 };
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3c2a3029b10c..2aecad77af9a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2912,6 +2912,30 @@ static void en7581_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
+static void en7528_mac_port_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
+{
+	switch (port) {
+	/* Ports which are connected to switch PHYs. There is no MII pinout. */
+	case 1 ... 4:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+		break;
+
+	/* Port 6 is connected to SoC's GMAC at 1000 Mbps full duplex. There
+	 * is no MII pinout.
+	 */
+	case 6:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_1000FD;
+		break;
+	}
+}
+
 static void
 mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
@@ -3254,7 +3278,8 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	 * forwarded to the numerically smallest CPU port whose conduit
 	 * interface is up.
 	 */
-	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
+	    priv->id != ID_EN7528)
 		return;
 
 	mask = BIT(cpu_dp->index);
@@ -3319,9 +3344,17 @@ static int mt753x_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+/* The EN7528 LAN ports are integrated GPHYs at MDIO addresses 9..12 (switch
+ * ports 1..4) on the switch internal MDIO bus, reachable only through the PHY
+ * indirect access registers. There is no mdiodev to derive the addresses from.
+ */
+#define EN7528_GPHY_BASE		9
+#define EN7528_NUM_GPHYS		4
+
 static int mt7988_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
+	int i;
 
 	/* Reset the switch */
 	reset_control_assert(priv->rstc);
@@ -3342,6 +3375,17 @@ static int mt7988_setup(struct dsa_switch *ds)
 	/* Reset the switch PHYs */
 	mt7530_write(priv, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
 
+	/* The EN7528 LAN GPHYs advertise EEE by default, but negotiating EEE
+	 * with common link partners (e.g. Realtek GbE NICs) results in an
+	 * unstable link with dropped frames. Disable EEE advertisement on
+	 * them.
+	 */
+	if (priv->id == ID_EN7528)
+		for (i = EN7528_GPHY_BASE;
+		     i < EN7528_GPHY_BASE + EN7528_NUM_GPHYS; i++)
+			mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN,
+						 MDIO_AN_EEE_ADV, 0);
+
 	return mt7531_setup_common(ds);
 }
 
@@ -3459,6 +3503,16 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
 		.mac_port_get_caps = en7581_mac_port_get_caps,
 	},
+	[ID_EN7528] = {
+		.id = ID_EN7528,
+		.pcs_ops = &mt7530_pcs_ops,
+		.sw_setup = mt7988_setup,
+		.phy_read_c22 = mt7531_ind_c22_phy_read,
+		.phy_write_c22 = mt7531_ind_c22_phy_write,
+		.phy_read_c45 = mt7531_ind_c45_phy_read,
+		.phy_write_c45 = mt7531_ind_c45_phy_write,
+		.mac_port_get_caps = en7528_mac_port_get_caps,
+	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index dd33b0df3419..5f1e841f42c0 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -21,6 +21,7 @@ enum mt753x_id {
 	ID_MT7988 = 3,
 	ID_EN7581 = 4,
 	ID_AN7583 = 5,
+	ID_EN7528 = 6,
 };
 
 #define	NUM_TRGMII_CTRL			5
-- 
2.34.1


