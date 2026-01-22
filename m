Return-Path: <netdev+bounces-252505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL47Gth4cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B955A6CF66
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78FD43011582
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C738B7D6;
	Thu, 22 Jan 2026 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="vJWrHlbR";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gi4d/5sP"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BD35FF49
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109715; cv=none; b=ZQ50sEub8lttR6xsXAKKaBj5JgRu0Qn1mQaRgHLtw7VtSaAwFNDn3i/mCnEzZLZpMBEf21QmuBLyUnAsLdvxuovMDuEPkzvLLERuate+QAWnjFUKRPLtGGpmqSqSnApYbdTIiO/5vL8Ul2ze7tEd6At2ZguWbIidkRAiaZixu0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109715; c=relaxed/simple;
	bh=bOjobQmiNLZlE/hbj0co2hcs4Vk4lb7rt3zjX5DHO6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oogTQjzkymVjhlKbgEWQkF+2rqYFdjfU/hWHCTuUaxXNVqunUB68xZRk8pzbNbXVsJuhYTi1SEwcx2aGQsjdpbtoxSaV4fnQnStgePs5YeTSYCKVa2pGv5q5L8eVYm5Dyb3ZVKu1tD9W96XTTOdzHGJWzQm3e0aEMUFl9Ux7Ts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=vJWrHlbR; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gi4d/5sP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=vJWrHlbRWCN5hscU4+KdVHCljCUwAIFaDmFb6l4UnHH5xzL3r5DQnJNAH7LzPyjhFoTc+CLOhBWC8LF8+R0yO4mdEOihuu8qszcinESHvAOwF+Xi0+LnFYwaelx//9qwKhsYpiIj+g7CI0G8IMBTY3r15aWGI9Ibji5qOyD2uvccc3FwmEH2r/JK6URE6+s134nH5NRivSbvtjl8a0gWipRMib1MLPjNli2Tmkn/5ZWrc59TZyCEBoAzq0XWyNrelmIl/gUsblGbmASaBh+5XrhJ7UzFlKhVPBdMpJIp0EI6tia36oLe4k17hOhCgX2CLuI7BXIGFM0+91AWw9Y3BA==; s=purelymail1; d=tinyisr.com; v=1; bh=bOjobQmiNLZlE/hbj0co2hcs4Vk4lb7rt3zjX5DHO6o=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gi4d/5sPOSnccw5v2yPEV3nKv3SeHrpzEVfNZXXZciqC9iKEHk2tcvaJHp7jtEA5FaG2lJbaEVdQUi7lEmrmlIuJRKeVsGfpGXUc7LCsivgvSNDZIVMwrCpx75ykpFHqRHL4XI7jvFFG4LBoE1qMyQID7lbJUF+Q+BgOYmNNkakEVA4NCGyte/ZcFHtmm01ns1jegwYquEWUe0JPgyCdmRsmf7TI/p2/ORhauhHtACHT7tbCbZ8h38UQOhXBVmnkJRoXKOsGKx6trkOGtwa0AFF/MfD+e7DlmGdrO7HqqnOMPAUfjmEKedUlEq7bXasM1PdogtfbeBQEfMxhp8qMJA==; s=purelymail1; d=purelymail.com; v=1; bh=bOjobQmiNLZlE/hbj0co2hcs4Vk4lb7rt3zjX5DHO6o=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 626594755;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 22 Jan 2026 19:21:41 +0000 (UTC)
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
Subject: [PATCH net-next v3] net: ethernet: mtk_eth_soc: avoid writing to ESW registers on MT7628
Date: Thu, 22 Jan 2026 20:58:08 +0200
Message-ID: <20260122191822.1476732-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail1,purelymail.com:s=purelymail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252505-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purelymail.com:dkim,tinyisr.com:email,tinyisr.com:dkim,tinyisr.com:mid]
X-Rspamd-Queue-Id: B955A6CF66
X-Rspamd-Action: no action

The MT7628 has a fixed-link PHY and does not expose MAC control
registers. Writes to these registers only corrupt the ESW VLAN
configuration.

This patch registers empty phylink_mac_ops for MT7628, as removing the
invalid register accesses leaves nothing to do on this SoC.

Fixes: 296c9120752b ("net: ethernet: mediatek: Add MT7628/88 SoC support")
Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
v3:=20
 - Register separate mac_ops for MT7628 instead of using early return
   based on SoC for all phylink mac operations
 - Update commit message
v2: https://lore.kernel.org/netdev/20260106052845.1945352-1-joey@tinyisr.co=
m/
 - Add missing fixes tag
v1: https://lore.kernel.org/netdev/20251230091151.129176-1-joey@tinyisr.com=
/

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 37 ++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethe=
rnet/mediatek/mtk_eth_soc.c
index 35fef28ee2f9..ede8efdc3413 100644
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
@@ -4779,6 +4801,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct de=
vice_node *np)
 =09int id, err;
 =09int txqs =3D 1;
 =09u32 val;
+=09const struct phylink_mac_ops *mac_ops =3D &mtk_phylink_ops;
=20
 =09if (!_id) {
 =09=09dev_err(eth->dev, "missing mac id\n");
@@ -4906,9 +4929,15 @@ static int mtk_add_mac(struct mtk_eth *eth, struct d=
evice_node *np)
 =09=09=09  mac->phylink_config.supported_interfaces);
 =09}
=20
+
+=09if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+=09=09mac_ops =3D &rt5350_phylink_ops;
+
 =09phylink =3D phylink_create(&mac->phylink_config,
 =09=09=09=09 of_fwnode_handle(mac->of_node),
-=09=09=09=09 phy_mode, &mtk_phylink_ops);
+=09=09=09=09 phy_mode,
+=09=09=09=09 mac_ops);
+
 =09if (IS_ERR(phylink)) {
 =09=09err =3D PTR_ERR(phylink);
 =09=09goto free_netdev;
--=20
2.52.0


