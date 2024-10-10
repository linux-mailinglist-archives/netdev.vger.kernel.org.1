Return-Path: <netdev+bounces-133992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D5997A4B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0BF1C211CA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847A2AE91;
	Thu, 10 Oct 2024 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qFJcoNgQ"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C329406
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525227; cv=none; b=dFLCRTcvVTDgrEve2SctrPo30C5QzRhb09s5yee5iwhj5IL5gtSlDFVwlXVDJcERqk+h5WKyvD1iyDioQJg5frSImGwArlSDFRaajp94gwoOXfcpNrcb1yeDmoKYmHVb8I7B6RxG02H9Xbs1267QNh4xlKwgNK8JiGURaXmQGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525227; c=relaxed/simple;
	bh=QSInXO+U0seyV0C6xm7vE0MTCG7cJRNiR2Djzcn3jKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+Yolvt7AEBY9R9IZ18CeTyLteQ0SeJivRTmSqgnlowZ2fuuOmLPX8efEdfpx/K7zWDdYQFToPvNl8szlCLAe0xl+s5ZgzOas0+ixFLS0Rt3UgNy15Q4uP8fMqAV9hyawrmNScI9TLezAFr+uGTEexdnfiFxYKRJQibkOvl7Z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qFJcoNgQ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 297C82C02A5;
	Thu, 10 Oct 2024 14:53:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728525223;
	bh=cLjR3dzs+5jR/Vs6gfSc3iv275Ynq5LY3yeQ+MH/VIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qFJcoNgQhb7ysx3HJSLKV119Zzq11TWOr81Sby1R0/nT3GbBfIJOGYG0+tryqk2So
	 a1ImAjda7sreFh9vTDnqkLrtrkW0TxWtOwNwD7Gr79hAN+/BObFRzzZzJxeV0S3lAX
	 Gyuur6jgaXt3iElAZoTM3V+VwUKKSJebrOUKn+dI9sqapKxQRrvoXqF1FU5ANkaU5s
	 Pp/d5Jhh9jhTUAtPVSZ1h6c0A2Hh2OBIvLPzAxJ3k1nw6ui07Q6UEM8FOiEbjRNEIX
	 kJmgQ8k/0jRIOeH6ydNogvgI0olq/7vnq8kvze1SH887/bTSU6AXYLrkVsbECaxnNN
	 s/jdpppG/JtUA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670733a60000>; Thu, 10 Oct 2024 14:53:42 +1300
Received: from aryans-dl.ws.atlnz.lc (aryans-dl.ws.atlnz.lc [10.33.22.38])
	by pat.atlnz.lc (Postfix) with ESMTP id EA78513ED7B;
	Thu, 10 Oct 2024 14:53:42 +1300 (NZDT)
Received: by aryans-dl.ws.atlnz.lc (Postfix, from userid 1844)
	id E765B2A0BF8; Thu, 10 Oct 2024 14:53:42 +1300 (NZDT)
From: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v0] net: mvpp2: Add parser configuration for DSA tags
Date: Thu, 10 Oct 2024 14:51:04 +1300
Message-ID: <20241010015104.1888628-1-aryan.srivastava@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670733a6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=bwvKFnaZSXCItuFZI_oA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Allow the header parser to consider DSA and EDSA tagging. Currently the
parser is always configured to use the MH tag, but this results in poor
traffic distribution across queues and sub-optimal performance (in the
case where DSA or EDSA tags are in the header).

Add mechanism to check for tag type in use and then configure the
parser correctly for this tag. This results in proper traffic
distribution and hash calculation.

Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 37 ++++++++++++++++++-
 .../net/ethernet/marvell/mvpp2/mvpp2_prs.c    |  4 ++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/eth=
ernet/marvell/mvpp2/mvpp2.h
index 9e02e4367bec..6ebed21a7af3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -59,6 +59,8 @@
=20
 /* Top Registers */
 #define MVPP2_MH_REG(port)			(0x5040 + 4 * (port))
+#define MVPP2_MH_EN				BIT(0)
+#define MVPP2_DSA_NON_EXTENDED			BIT(4)
 #define MVPP2_DSA_EXTENDED			BIT(5)
 #define MVPP2_VER_ID_REG			0x50b0
 #define MVPP2_VER_PP22				0x10
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
index 103632ba78a2..8f865fddc8c1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -38,6 +38,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/tso.h>
 #include <linux/bpf_trace.h>
+#include <net/dsa.h>
=20
 #include "mvpp2.h"
 #include "mvpp2_prs.h"
@@ -4782,6 +4783,36 @@ static bool mvpp22_rss_is_supported(struct mvpp2_p=
ort *port)
 		!(port->flags & MVPP2_F_LOOPBACK);
 }
=20
+static int mvpp2_get_tag(struct net_device *dev)
+{
+	int tag;
+	int dsa_proto =3D DSA_TAG_PROTO_NONE;
+
+#if IS_ENABLED(CONFIG_NET_DSA)
+	if (netdev_uses_dsa(dev))
+		dsa_proto =3D dev->dsa_ptr->tag_ops->proto;
+#endif
+
+	switch (dsa_proto) {
+	case DSA_TAG_PROTO_DSA:
+		tag =3D MVPP2_TAG_TYPE_DSA;
+		break;
+	case DSA_TAG_PROTO_EDSA:
+	/**
+	 * DSA_TAG_PROTO_EDSA and MVPP2_TAG_TYPE_EDSA are
+	 * referring to separate things. MVPP2_TAG_TYPE_EDSA
+	 * refers to extended DSA, while DSA_TAG_PROTO_EDSA
+	 * refers to Ethertype DSA. Ethertype DSA requires no
+	 * setting in the parser.
+	 */
+	default:
+		tag =3D MVPP2_TAG_TYPE_MH;
+		break;
+	}
+
+	return tag;
+}
+
 static int mvpp2_open(struct net_device *dev)
 {
 	struct mvpp2_port *port =3D netdev_priv(dev);
@@ -4801,7 +4832,11 @@ static int mvpp2_open(struct net_device *dev)
 		netdev_err(dev, "mvpp2_prs_mac_da_accept own addr failed\n");
 		return err;
 	}
-	err =3D mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH)=
;
+
+	if (netdev_uses_dsa(dev))
+		err =3D mvpp2_prs_tag_mode_set(port->priv, port->id, mvpp2_get_tag(dev=
));
+	else
+		err =3D mvpp2_prs_tag_mode_set(port->priv, port->id, MVPP2_TAG_TYPE_MH=
);
 	if (err) {
 		netdev_err(dev, "mvpp2_prs_tag_mode_set failed\n");
 		return err;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net=
/ethernet/marvell/mvpp2/mvpp2_prs.c
index 9af22f497a40..7cc42e22ed92 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -2393,6 +2393,8 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int =
port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_DSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_DSA);
+		/* Set Marvell Header register for Ext. DSA tag */
+		mvpp2_write(priv, MVPP2_MH_REG(port), MVPP2_DSA_EXTENDED);
 		break;
=20
 	case MVPP2_TAG_TYPE_DSA:
@@ -2406,6 +2408,8 @@ int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int =
port, int type)
 				      MVPP2_PRS_TAGGED, MVPP2_PRS_EDSA);
 		mvpp2_prs_dsa_tag_set(priv, port, false,
 				      MVPP2_PRS_UNTAGGED, MVPP2_PRS_EDSA);
+		/* Set Marvell Header register for DSA tag */
+		mvpp2_write(priv, MVPP2_MH_REG(port), MVPP2_DSA_NON_EXTENDED);
 		break;
=20
 	case MVPP2_TAG_TYPE_MH:
--=20
2.46.0


