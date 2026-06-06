Return-Path: <netdev+bounces-296065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tcYmGCS/I2qtxgEAu9opvQ
	(envelope-from <netdev+bounces-296065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 08:33:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0D64CB5B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 08:33:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z+lXylQT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296065-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296065-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A85F3021649
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 06:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704AE262FFC;
	Sat,  6 Jun 2026 06:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8B1D5CFB
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 06:31:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780727465; cv=none; b=DmsOFmFxIWx0oU7FGmek1RImE6D+LzpxUu9L5+hDMJq2GmJNrDtoFDpCmmKuVwXu2mKmEhYnM/ia3cZg+SUDCGwnPcwrz0Y/No/oysGOGrLiIfzpneFsZ+DgVKcQw1pVXGOLngNKpM6tRwy6OGHbuaI3GV/GylV4PR+uE15zmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780727465; c=relaxed/simple;
	bh=fLJc5oC3YaKmrvJcbkoDaP/sfGGeF3b46S1rl/G6I8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uW8qWuZc0go7IDb6ccNedsvCYFvIC87t5YW5axTX3bwSfpBqp2pxSIbxgVvtBFqKawdpTUToSNPODNxe95+a/YDWR462KLLvlaiDJd2+R+jgEu32KwCPsfPNE5EQTb0W7eJo5K/QhGacmg9U+mo/IXJVokysBT2ZYKbfA6+ALZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+lXylQT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA3C1F00893;
	Sat,  6 Jun 2026 06:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780727463;
	bh=rzt8BYs7Mzw4Tpacz5I+FsGVINJwYYFtlK1dNESkZV8=;
	h=From:Date:Subject:To:Cc;
	b=Z+lXylQT4fdRJesqlmUhnBnaSdHQACBqhDLtOOOfEc9iN9wmZaIxPhgFMn/kByR8R
	 hBxTCvPPRKGL/1bYt+J4y7xP4rRJlbAsao2PLkX8lvteRehF0dpY5Qrfs2JEw8U0Sr
	 FUpIaxYYw4bGdZCpAanqT513cd6qwdYDjqljdvKuefBua0CGZ5wSvWmepNzpNe5ROA
	 Ow3t9eqYdL3H/B2yqPb/Mrh5nJ+qzGcoEktIr6lK5FMSA/5alvjLOLLbJbImURWWnS
	 ATWipIkkF5vCmKAUsxCgsUvirZ8TgcgZuUG4qJTPRhbAJwe7R5/8OA8/32ezZM3KCc
	 K6OSsZFk6gp4w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 06 Jun 2026 08:30:12 +0200
Subject: [PATCH net-next] net: airoha: add ethtool priv_flags support for
 LAN/WAN and GDM2 loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-airoha-ethtool-priv_flags-v1-1-401b2c9fe9f1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAwEvyI5G6geVPyKiESNNiCtpEUE8e8GG
 ViYw84DiVU4QV88oHxJkhhMqrKAxVPYGWU1h9rVjTOQRKMn5OxzjAeeKte0HbQnnBui1i02nQP
 7n8qb3H97gMAZA98Zxvf9ALVh2/B1AAAA
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296065-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7B0D64CB5B

Introduce ethtool private flags infrastructure for the airoha ethernet
driver, allowing userspace to configure per-device behavior via ethtool.
Implement the "wan" private flag to let the user select whether a GDM
port is used as a hardware LAN or WAN interface. GDM2 is fixed as WAN
only, GDM1 is fixed as LAN only, while GDM3 and GDM4 can be switched
between LAN and WAN at runtime (when the interface is not running).
When a GDM3/GDM4 port is set to WAN mode, enable GDM2 loopback to
support hardware QoS. Conversely, when switching back to LAN mode,
disable the GDM2 loopback and restore the default forwarding
configuration.
Add airoha_disable_gdm2_loopback() as the counterpart of the existing
airoha_enable_gdm2_loopback(), and define FC_MAP6_DEF_VALUE for use
during loopback teardown.

Example usage to configure eth1 (GDM3/GDM4) as WAN:

$ ethtool --show-priv-flags eth1
Private flags for eth1:
wan: off

$ ethtool --set-priv-flags eth1 wan on

$ ethtool --show-priv-flags eth1
Private flags for eth1:
wan: on

To revert back to LAN mode:

$ ethtool --set-priv-flags eth1 wan off

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 175 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 2 files changed, 176 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..487c5470fb01 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1960,6 +1960,45 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	return 0;
 }
 
+static int airoha_disable_gdm2_loopback(struct airoha_gdm_dev *dev)
+{
+	struct airoha_eth *eth = dev->eth;
+	int i, src_port;
+	u32 pse_port;
+
+	src_port = eth->soc->ops.get_sport(dev->port, dev->nbq);
+	if (src_port < 0)
+		return src_port;
+
+	airoha_fe_clear(eth,
+			REG_SP_DFT_CPORT(src_port >> fls(SP_CPORT_DFT_MASK)),
+			SP_CPORT_MASK(src_port & SP_CPORT_DFT_MASK));
+
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    FE_PSE_PORT_DROP);
+	airoha_fe_clear(eth, REG_GDM_LPBK_CFG(AIROHA_GDM2_IDX),
+			LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK);
+	pse_port = airoha_ppe_is_enabled(eth, 1) ? FE_PSE_PORT_PPE2
+						 : FE_PSE_PORT_PPE1;
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    pse_port);
+
+	airoha_fe_rmw(eth, REG_FE_WAN_PORT, WAN0_MASK,
+		      FIELD_PREP(WAN0_MASK, AIROHA_GDM2_IDX));
+
+	for (i = 0; i < eth->soc->num_ppe; i++)
+		airoha_fe_clear(eth, REG_PPE_DFT_CPORT(i, AIROHA_GDM2_IDX),
+				DFT_CPORT_MASK(AIROHA_GDM2_IDX));
+
+	/* Enable VIP and IFC for GDM2 */
+	airoha_fe_set(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));
+	airoha_fe_set(eth, REG_FE_IFC_PORT_EN, BIT(AIROHA_GDM2_IDX));
+
+	airoha_fe_wr(eth, REG_SRC_PORT_FC_MAP6, FC_MAP6_DEF_VALUE);
+
+	return 0;
+}
+
 static struct airoha_gdm_dev *
 airoha_get_wan_gdm_dev(struct airoha_eth *eth)
 {
@@ -2296,6 +2335,87 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+struct airoha_ethool_priv_flags {
+	char name[ETH_GSTRING_LEN];
+	int (*handler)(struct net_device *netdev, u32 flags);
+};
+
+static int airoha_dev_set_wan_flag(struct net_device *netdev, u32 flags)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+
+	if (!((dev->flags ^ flags) & AIROHA_PRIV_F_WAN))
+		return 0;
+
+	if (netif_running(netdev))
+		return -EBUSY;
+
+	if (flags & AIROHA_PRIV_F_WAN) {
+		struct airoha_gdm_dev *wan_dev;
+
+		/* Verify the WAN device is not already configured */
+		wan_dev = airoha_get_wan_gdm_dev(eth);
+		if (wan_dev && wan_dev != dev)
+			return -EBUSY;
+
+		switch (port->id) {
+		case AIROHA_GDM2_IDX:
+			/* GDM2 can be used just as WAN */
+			return 0;
+		case AIROHA_GDM3_IDX:
+		case AIROHA_GDM4_IDX: {
+			int err;
+
+			dev->flags |= AIROHA_PRIV_F_WAN;
+			airoha_dev_set_qdma(dev);
+
+			err = airoha_enable_gdm2_loopback(dev);
+			if (err) {
+				dev->flags &= ~AIROHA_PRIV_F_WAN;
+				airoha_dev_set_qdma(dev);
+
+				return err;
+			}
+			break;
+		}
+		default:
+			/* GDM1 can be used just as LAN */
+			return -EOPNOTSUPP;
+		}
+	} else {
+		switch (port->id) {
+		case AIROHA_GDM2_IDX:
+			/* GDM2 can be used just as WAN */
+			return -EOPNOTSUPP;
+		case AIROHA_GDM3_IDX:
+		case AIROHA_GDM4_IDX: {
+			int err;
+
+			err = airoha_disable_gdm2_loopback(dev);
+			if (err)
+				return err;
+
+			dev->flags &= ~AIROHA_PRIV_F_WAN;
+			airoha_dev_set_qdma(dev);
+			break;
+		}
+		default:
+			/* GDM1 can be used just as LAN */
+			return 0;
+		}
+	}
+
+	return airoha_set_macaddr(dev, netdev->dev_addr);
+}
+
+static const struct airoha_ethool_priv_flags airoha_eth_priv_flags[] = {
+	{ "wan", airoha_dev_set_wan_flag },
+};
+
+#define AIROHA_PRIV_FLAGS_STR_LEN	ARRAY_SIZE(airoha_eth_priv_flags)
+
 static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
 				       struct ethtool_drvinfo *info)
 {
@@ -2304,6 +2424,7 @@ static void airoha_ethtool_get_drvinfo(struct net_device *netdev,
 
 	strscpy(info->driver, eth->dev->driver->name, sizeof(info->driver));
 	strscpy(info->bus_info, dev_name(eth->dev), sizeof(info->bus_info));
+	info->n_priv_flags = AIROHA_PRIV_FLAGS_STR_LEN;
 }
 
 static void airoha_ethtool_get_mac_stats(struct net_device *netdev,
@@ -2368,6 +2489,56 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
+static int airoha_ethtool_set_priv_flags(struct net_device *netdev, u32 flags)
+{
+	int i;
+
+	for (i = 0; i < AIROHA_PRIV_FLAGS_STR_LEN; i++) {
+		int err;
+
+		if (!airoha_eth_priv_flags[i].handler)
+			continue;
+
+		err = airoha_eth_priv_flags[i].handler(netdev, flags);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static u32 airoha_ethtool_get_priv_flags(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	return dev->flags;
+}
+
+static int airoha_ethtool_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_PRIV_FLAGS:
+		return AIROHA_PRIV_FLAGS_STR_LEN;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void airoha_ethtool_get_strings(struct net_device *netdev,
+				       u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_PRIV_FLAGS:
+		for (i = 0; i < AIROHA_PRIV_FLAGS_STR_LEN; i++)
+			ethtool_puts(&data, airoha_eth_priv_flags[i].name);
+		break;
+	default:
+		break;
+	}
+}
+
 static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 int channel, enum tx_sched_mode mode,
 					 const u16 *weights, u8 n_weights)
@@ -3094,6 +3265,10 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.get_link		= ethtool_op_get_link,
+	.set_priv_flags		= airoha_ethtool_set_priv_flags,
+	.get_priv_flags		= airoha_ethtool_get_priv_flags,
+	.get_sset_count		= airoha_ethtool_get_sset_count,
+	.get_strings		= airoha_ethtool_get_strings,
 };
 
 static int airoha_metadata_dst_alloc(struct airoha_gdm_port *port)
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 436f3c8779c1..4e17dfbcf2b8 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -376,6 +376,7 @@
 
 #define REG_SRC_PORT_FC_MAP6		0x2298
 #define FC_ID_OF_SRC_PORT_MASK(_n)	GENMASK(4 + ((_n) << 3), ((_n) << 3))
+#define FC_MAP6_DEF_VALUE		0x1b1a1918
 
 #define REG_CDM5_RX_OQ1_DROP_CNT	0x29d4
 

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


