Return-Path: <netdev+bounces-261407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LPwKxdroGk3jgQAu9opvQ
	(envelope-from <netdev+bounces-261407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:47:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 717091A90F6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E818307D711
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BA8372B4B;
	Thu, 26 Feb 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="RpENm/vz";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VJTVyWuv"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B521E098
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120767; cv=none; b=TmcE+NM8Ja9YQI5MYXegHsxsqGNsAdrvatZuEenCbDjQbWCM6x2Rh4cvBU7t6zIY+rfAMer2hEiZJQASQZLE8nAy5Z2ynwBGh1wNcyPlgu1e8pkonrOMFdLt8SwrxvcicKmGQTQTFWA8yjiD5euLcSuC+AyyvJULhh3kHL8oIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120767; c=relaxed/simple;
	bh=FzvnsVQisrqzRJRhYWtZDrdx0tPWxlCwx6vEyyUhE2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bYVZ0y+yWfurIrS3bQ9d8VC5dxWh/maO2C3eYqqBeC8uZmbmx7sHnKPqp/fJx0jV2QDvG5rPRV2inUSO6vC2jc45NMP7GqiXI1TcctR4LB+e5s6G0SwxnyGv6qNENUoCsBP1v+TmOblL7CQZGchXSX7xSbCJpkK6tyVwmf5CMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=RpENm/vz; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VJTVyWuv; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RpENm/vzZOxkufbDUQbYrpLqINwJ05D4LnIRmL4AsuYlHVAxJpx7v7gC8gOpcqhs7WvSVlj9F6X7YUrGZEF8eko0CzYwp4192L+ZZ9xFrq26D8+6DX3090WHKPWls1svqnG0rwe9Cw1rq23DKzxRAKoNySOWEKmubp+BBdROAPda+S6/vVVd0cAcFetn/pZr67dtqZsUFQ8UWdj+SUYLcMSDlfvcyW/CFom5/HUaGDUBakHn+Zu2ZH+l+Crok9iA21iEBrvH3EpEJAIuDS67OUg2crMT3/JdZdfvZe+LPKXimpniUCN3JQSXQ+AX17UkaAR/ABih+w803RcWBDonrQ==; s=purelymail3; d=tinyisr.com; v=1; bh=FzvnsVQisrqzRJRhYWtZDrdx0tPWxlCwx6vEyyUhE2s=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=VJTVyWuvdydgJm1WFCjcnbjcK18nIVmmMqU2oUSiGeDMO3FgxbeN6oiUtNthEbnp0Z2vHZJoWg9sieaaEo7YmXFYM1ESQU3bXePlZ120iKSCMzbmKInfn6X0Rivp2BowvwZYSojx8UgLqpr5fh/xNJOdiZnKQj7KVZMu1US6DYIc3LFAVcnZFZAmIZHSgno5jHE6ho2nvs4mPOEbFJeScPSDtSpbbnKNbs/r94ddeecLranROFIdAmG3cdocngt84I3Yxb9iTu2p6MQytHGrsxOiCH9oTYaAgGaRwtIv3j80kCixnWaaMNFfnUdqoPonH9KABOyW9l8bU4hEr8MVnA==; s=purelymail3; d=purelymail.com; v=1; bh=FzvnsVQisrqzRJRhYWtZDrdx0tPWxlCwx6vEyyUhE2s=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1166072005;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 26 Feb 2026 15:45:57 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH v4] net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628
Date: Thu, 26 Feb 2026 15:45:18 +0000
Message-ID: <20260226154547.68553-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 717091A90F6
X-Rspamd-Action: no action

The MT7628 has a fixed-link PHY and does not expose MAC control
registers. Writes to these registers only corrupt the ESW VLAN
configuration.

This patch explicitly registers no-op phylink_mac_ops for MT7628, as
after removing the invalid register accesses, the existing
phylink_mac_ops effectively become no-ops.

This code was introduced by commit 296c9120752b
("net: ethernet: mediatek: Add MT7628/88 SoC support")

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
v4:
 - Remove unnecessary Fixes tag
 - Clarify commit message
 - Fix v3 nitpicks
v3: https://lore.kernel.org/netdev/20260122191822.1476732-1-joey@tinyisr.co=
m/
 - Register separate mac_ops for MT7628 instead of using early return
   based on SoC for all phylink mac operations
 - Update commit message
v2: https://lore.kernel.org/netdev/20260106052845.1945352-1-joey@tinyisr.co=
m/
 - Add missing fixes tag
v1: https://lore.kernel.org/netdev/20251230091151.129176-1-joey@tinyisr.com=
/

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 34 ++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index 35fef28ee2f9..1c3c6d94dbe8 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -562,9 +562,7 @@ static void mtk_mac_config(struct phylink_config *confi=
g, unsigned int mode,
 =09int val, ge_mode, err =3D 0;
 =09u32 i;
=20
-=09/* MT76x8 has no hardware settings between for the MAC */
-=09if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
-=09    mac->interface !=3D state->interface) {
+=09if (mac->interface !=3D state->interface) {
 =09=09/* Setup soc pin functions */
 =09=09switch (state->interface) {
 =09=09case PHY_INTERFACE_MODE_TRGMII:
@@ -956,6 +954,30 @@ static const struct phylink_mac_ops mtk_phylink_ops =
=3D {
 =09.mac_enable_tx_lpi =3D mtk_mac_enable_tx_lpi,
 };
=20
+static void rt5350_mac_config(struct phylink_config *config, unsigned int =
mode,
+=09=09=09=09const struct phylink_link_state *state)
+{
+}
+
+static void rt5350_mac_link_down(struct phylink_config *config, unsigned i=
nt mode,
+=09=09=09=09phy_interface_t interface)
+{
+}
+
+static void rt5350_mac_link_up(struct phylink_config *config,
+=09=09=09    struct phy_device *phy,
+=09=09=09    unsigned int mode, phy_interface_t interface,
+=09=09=09    int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+}
+
+/* MT76x8 (rt5350-eth) does not expose any MAC control registers */
+static const struct phylink_mac_ops rt5350_phylink_ops =3D {
+=09.mac_config =3D rt5350_mac_config,
+=09.mac_link_down =3D rt5350_mac_link_down,
+=09.mac_link_up =3D rt5350_mac_link_up,
+};
+
 static void mtk_mdio_config(struct mtk_eth *eth)
 {
 =09u32 val;
@@ -4772,6 +4794,7 @@ static const struct net_device_ops mtk_netdev_ops =3D=
 {
=20
 static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 {
+=09const struct phylink_mac_ops *mac_ops =3D &mtk_phylink_ops;
 =09const __be32 *_id =3D of_get_property(np, "reg", NULL);
 =09phy_interface_t phy_mode;
 =09struct phylink *phylink;
@@ -4906,9 +4929,12 @@ static int mtk_add_mac(struct mtk_eth *eth, struct d=
evice_node *np)
 =09=09=09  mac->phylink_config.supported_interfaces);
 =09}
=20
+=09if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+=09=09mac_ops =3D &rt5350_phylink_ops;
+
 =09phylink =3D phylink_create(&mac->phylink_config,
 =09=09=09=09 of_fwnode_handle(mac->of_node),
-=09=09=09=09 phy_mode, &mtk_phylink_ops);
+=09=09=09=09 phy_mode, mac_ops);
 =09if (IS_ERR(phylink)) {
 =09=09err =3D PTR_ERR(phylink);
 =09=09goto free_netdev;
--=20
2.53.0


