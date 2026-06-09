Return-Path: <netdev+bounces-297114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KjE3J5ozKGo+AAMAu9opvQ
	(envelope-from <netdev+bounces-297114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:39:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FE661DD4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:39:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=izfXoU30;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297114-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297114-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 739533359979
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FA4ADDA7;
	Tue,  9 Jun 2026 15:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405B4A139A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:13:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018034; cv=none; b=b6grmPUtdAPElijEMaTC+lMZHBWK7Y3vZvRnZNDEsO4QAU/xU9f8Qy8QTOMr4whij3aCJ6uttoEGXM2S7e0ZFspJeGjEolet7bcUXByE7tn1GCcfHmXrYMH4DGWrHVXfvbMh7Yc0FofV2h3Ppxs/VJ74AITQuBmkyqoW8kPUUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018034; c=relaxed/simple;
	bh=8O2w84sf3k9UsdHFrkiTPC0ZIKeE7XAkdAh1ZSc348c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzQFWghWTeaKMRfWIipqQAWCr9N6CsqH4ZB5/kTjOecoKs0n3rNadhDDByhyaBSQltjPPybfdc5WFGMeIF8ookVJutA7LlQY0JpHYp9BavjUJXTBAN8gBzkB3d7KK/Irx1VS7jitPgJON/o1Fq833MIRHH70zR6xNM6SJgm1omM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izfXoU30; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bebbc325000so727210066b.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781018019; x=1781622819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKAHZBj8Q4+vRNpcM7hRX5sDNhQM8RLIVJoZZt90zy8=;
        b=izfXoU30DNugtjq4M9qUnyFD9GtmWlPvt5Jt8YHZQhr41CAPbHUrWI9IfIQCSe5Awn
         kxnvHG93imUohZoo2ExJHod2gmLhq19A2n3W4qrTlqrNxjfrCCxAaCRzlO9s+9GiII7u
         GZZCZilICYr46YlJC40DqdhxATAJx3T8SApwAkvAkvjTG5OQ9OhgAjeGXOoD5LlNiQx0
         CNj2Amn0Teb5Yl2etVgMabc5PdRvR6nZl1FjIL+QMjNVOt0/qaf+vAW/unKc3KgAxij7
         YYmAi5DIiap1DPhbj3TqE8KUnmo7fyjPv0GrfRNoXhYkgeiLkWFKME8FF+6aMPzu6n90
         2W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781018019; x=1781622819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKAHZBj8Q4+vRNpcM7hRX5sDNhQM8RLIVJoZZt90zy8=;
        b=acdYbUG6GEebGPLtP/b2XpsFbG9NjOynK1KHgGFmfzK6d/Ux7Riyf9CU8S/ImrP2fD
         yLj+uxEhWx820b0otMSXXZJxPD5QOqROwCGKykIhpurmLKKnrTNz056VPIfmaIC079bG
         469YtW5SY7c1uvjCXnjDaKPATElmGn8Ll7HG8Q69/EhgYk4MSJvgE2h85TGOZyMU2pz/
         pxI4dD1xFbKQNkCcz2bNXb3R4x3bmzd4VRql0ueuSBtz5/gH20fiHqlpynT3s5kPfaT2
         RJ8xI5Xh5J+Im9/MCoqv6sWAiHs29UMtuSP1UAH9EcaRDOFP93qcCAMiHNlB+9zEwpmw
         8n0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7Eb7GrufXWmBmCVSkoIp2XaD4HN60+/w8c17Xa9loptAmuWRIsQ8vBry/mcgABAqx8BOpFvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/uVUYEaE73jjv2D/HBSWG38JBhYY+1FsEdaFwtdVRItpiDKH
	Oe9BPODYM7n7fvOkQoSAUB+K9x+qnZExoF2EOjuwhT2deCzcV9C7vuDR
X-Gm-Gg: Acq92OGtm0Nk/24mpDZSWwwslmNaTLFYw2DCuKBiny1GmQoqhMY6r1/+S3c5AhvKl5O
	NqiMAS/fimaT7gmD2uLrD6PNtGo4DrG6SoSy6i9ITVh23WKcoX6u3YVGOQHyjshcLC/vk18QnKj
	MOE8uqD6msRGI5Q5uzsW3/xPNbguz3DnnPsBXdxN55GkUq/OWT/wO6q6dNSBaLsqEdeYmlKtG/w
	ljdJbjarZ69p1KQlmpzSgxZtfIse6uf2SKZ0x+bzeNSYr/et0w1RXs+x+rZM5pl8wasw7zb9Ugd
	1VSR+99BOw36RDcEnele9Lewdk/dW/0HPPHzzuy00j/OhX5BokLEbIhBCs1fVxUItHUCwQMq2ox
	HY2Jk9jIXvGW/c7P7j+2ZQoAI0mf/t0x6hNw74ZQqFVLpW+xeIEs/VwEh9fZfpaekM7hWvBpMaD
	PHoKsxNzEH2df7AKhyLmeAhV0UIDk0Vgmm
X-Received: by 2002:a17:907:7289:b0:bf3:230c:4c64 with SMTP id a640c23a62f3a-bf371f52a44mr1059828766b.16.1781018018452;
        Tue, 09 Jun 2026 08:13:38 -0700 (PDT)
Received: from Ansuel-XPS24 ([2.195.136.12])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-bf0517721e5sm1073637866b.9.2026.06.09.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:13:37 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v6 12/12] net: airoha: add phylink support
Date: Tue,  9 Jun 2026 17:12:08 +0200
Message-ID: <20260609151212.29469-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609151212.29469-1-ansuelsmth@gmail.com>
References: <20260609151212.29469-1-ansuelsmth@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297114-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ansuelsmth@gmail.com,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 352FE661DD4

Add phylink support for each GDM port. For GDM1 add the internal interface
mode as the only supported mode. For GDM2/3/4 add the required
configuration of the PCS to make the external PHY or attached SFP cage
work.

These needs to be defined in the GDM port node using the pcs-handle
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/Kconfig       |   1 +
 drivers/net/ethernet/airoha/airoha_eth.c  | 167 +++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h  |   3 +
 drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
 4 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index ad3ce501e7a5..38dcc76e5998 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -20,6 +20,7 @@ config NET_AIROHA
 	depends on NET_DSA || !NET_DSA
 	select NET_AIROHA_NPU
 	select PAGE_POOL
+	select PHYLINK
 	help
 	  This driver supports the gigabit ethernet MACs in the
 	  Airoha SoC family.
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..eabd7b058f82 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -8,6 +8,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
+#include <linux/pcs/pcs.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
@@ -1779,6 +1780,15 @@ static int airoha_dev_open(struct net_device *netdev)
 	u32 cur_len, pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma = dev->qdma;
 
+	err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
+	if (err) {
+		netdev_err(netdev, "%s: could not attach PHY: %d\n", __func__,
+			   err);
+		return err;
+	}
+
+	phylink_start(dev->phylink);
+
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
 	if (err)
@@ -1876,6 +1886,9 @@ static int airoha_dev_stop(struct net_device *netdev)
 		}
 	}
 
+	phylink_stop(dev->phylink);
+	phylink_disconnect_phy(dev->phylink);
+
 	return 0;
 }
 
@@ -3148,6 +3161,153 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 	return false;
 }
 
+/* Nothing to do in MAC, everything is handled in PCS */
+static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
+			      const struct phylink_link_state *state)
+{
+}
+
+static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+			       unsigned int mode, phy_interface_t interface,
+			       int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct airoha_gdm_dev *dev = container_of(config, struct airoha_gdm_dev,
+						  phylink_config);
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+	u32 frag_size_tx, frag_size_rx;
+	u32 mask, val;
+
+	/* TX/RX frag is configured only for GDM4 */
+	if (port->id != 4)
+		return;
+
+	switch (speed) {
+	case SPEED_10000:
+	case SPEED_5000:
+		frag_size_tx = 8;
+		frag_size_rx = 8;
+		break;
+	case SPEED_2500:
+		frag_size_tx = 2;
+		frag_size_rx = 1;
+		break;
+	default:
+		frag_size_tx = 1;
+		frag_size_rx = 0;
+	}
+
+	/* Configure TX/RX frag based on speed */
+	if (dev->nbq == 1) {
+		mask = GDMA4_SGMII1_TX_FRAG_SIZE_MASK;
+		val = FIELD_PREP(GDMA4_SGMII1_TX_FRAG_SIZE_MASK,
+				 frag_size_tx);
+	}  else {
+		mask = GDMA4_SGMII0_TX_FRAG_SIZE_MASK;
+		val = FIELD_PREP(GDMA4_SGMII0_TX_FRAG_SIZE_MASK,
+				 frag_size_tx);
+	}
+	airoha_fe_rmw(eth, REG_GDMA4_TMBI_FRAG, mask, val);
+
+	if (dev->nbq == 1) {
+		mask = GDMA4_SGMII1_RX_FRAG_SIZE_MASK;
+		val = FIELD_PREP(GDMA4_SGMII1_RX_FRAG_SIZE_MASK,
+				 frag_size_tx);
+	} else {
+		mask = GDMA4_SGMII0_RX_FRAG_SIZE_MASK;
+		val = FIELD_PREP(GDMA4_SGMII0_RX_FRAG_SIZE_MASK,
+				 frag_size_tx);
+	}
+	airoha_fe_rmw(eth, REG_GDMA4_RMBI_FRAG, mask, val);
+}
+
+/* Nothing to do in MAC, everything is handled in PCS */
+static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
+				 phy_interface_t interface)
+{
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_config = airoha_mac_config,
+	.mac_link_up = airoha_mac_link_up,
+	.mac_link_down = airoha_mac_link_down,
+};
+
+static int airoha_fill_available_pcs(struct phylink_config *config,
+				     struct phylink_pcs **available_pcs,
+				     unsigned int num_available_pcs)
+{
+	struct device *dev = config->dev;
+
+	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
+					&num_available_pcs);
+}
+
+static int airoha_setup_phylink(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct device_node *np = netdev->dev.of_node;
+	struct airoha_gdm_port *port = dev->port;
+	struct phylink_config *config;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	int err;
+
+	err = of_get_phy_mode(np, &phy_mode);
+	if (err) {
+		dev_err(&netdev->dev, "incorrect phy-mode\n");
+		return err;
+	}
+
+	config = &dev->phylink_config;
+
+	config->dev = &netdev->dev;
+	config->type = PHYLINK_NETDEV;
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |  MAC_10000FD;
+	if (port->id > AIROHA_GDM1_IDX)
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000 |
+					    MAC_2500FD | MAC_5000FD;
+
+	err = fwnode_phylink_pcs_parse(dev_fwnode(&netdev->dev), NULL,
+				       &config->num_available_pcs);
+	if (err)
+		return err;
+
+	config->fill_available_pcs = airoha_fill_available_pcs;
+
+	/*
+	 * GDM1 only supports internal for Embedded Switch
+	 * and doesn't require a PCS.
+	 */
+	if (port->id == AIROHA_GDM1_IDX) {
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+	} else {
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  config->supported_interfaces);
+
+		phy_interface_copy(config->pcs_interfaces,
+				   config->supported_interfaces);
+	}
+
+	phylink = phylink_create(config, of_fwnode_handle(np),
+				 phy_mode, &airoha_phylink_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	dev->phylink = phylink;
+
+	return 0;
+}
+
 static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 				   struct airoha_gdm_port *port,
 				   int nbq, struct device_node *np)
@@ -3210,7 +3370,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	dev->nbq = nbq;
 	port->devs[index] = dev;
 
-	return 0;
+	return airoha_setup_phylink(netdev);
 }
 
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
@@ -3435,8 +3595,10 @@ static int airoha_probe(struct platform_device *pdev)
 				continue;
 
 			netdev = netdev_from_priv(dev);
-			if (netdev->reg_state == NETREG_REGISTERED)
+			if (netdev->reg_state == NETREG_REGISTERED) {
+				phylink_destroy(dev->phylink);
 				unregister_netdev(netdev);
+			}
 			of_node_put(netdev->dev.of_node);
 		}
 		airoha_metadata_dst_free(port);
@@ -3472,6 +3634,7 @@ static void airoha_remove(struct platform_device *pdev)
 				continue;
 
 			netdev = netdev_from_priv(dev);
+			phylink_destroy(dev->phylink);
 			unregister_netdev(netdev);
 			of_node_put(netdev->dev.of_node);
 		}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..1b25603dc64d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -554,6 +554,9 @@ struct airoha_gdm_dev {
 
 	u32 flags;
 	int nbq;
+
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 struct airoha_gdm_port {
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..27f2583e143a 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -358,6 +358,18 @@
 #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
 #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
 
+#define REG_GDMA4_TMBI_FRAG		0x2028
+#define GDMA4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
+#define GDMA4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
+#define GDMA4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
+#define GDMA4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
+
+#define REG_GDMA4_RMBI_FRAG		0x202c
+#define GDMA4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
+#define GDMA4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
+#define GDMA4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
+#define GDMA4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
+
 #define REG_MC_VLAN_EN			0x2100
 #define MC_VLAN_EN_MASK			BIT(0)
 
-- 
2.53.0


