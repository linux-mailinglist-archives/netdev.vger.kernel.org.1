Return-Path: <netdev+bounces-61882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9689825263
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588EF2861FA
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC02510D;
	Fri,  5 Jan 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=helmholz.de header.i=@helmholz.de header.b="mHGxdojK"
X-Original-To: netdev@vger.kernel.org
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327D28E34
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helmholz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helmholz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
	; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=omMNf4jkyATzdvlargerrqRENP7s64+Vtj8rKloZtgE=; b=mHGxdojK2Oo+mYdn59UarCN1Uo
	rtZx4tWVHVHsWdFUtqBCkEAt/53wbYLWwzSRJlHq+Fs3Z3zwkRNVfI1TGJ4Gyi+uPv2LkH//wE/69
	vKZqZGDZ0dO37eMEJaZ8gvhDQUAe2T29pRc8nheIscGuTipXls8mL62WCqJ40D3QT+Q4b3SaUBdG8
	ETjeFep2XiTi24qqd3yZPCnVtD+t1kc0n0RIaEQSwgY/narevhYuOX6UKdb2AEegNVLC3jBYcI9Bu
	8WQhJ4TwuF/0PpwclJf3g2zbYVIisFaQaMee3c98Zsxkl7DaizdexbAnniNDjXtg14Lcv22C2u/aD
	kQD746eA==;
Received: from [192.168.1.4] (port=44815 helo=SH-EX2013.helmholz.local)
	by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Ante.Knezic@helmholz.de>)
	id 1rLhib-0000fQ-1z;
	Fri, 05 Jan 2024 11:46:25 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 5 Jan 2024 11:46:25 +0100
From: Ante Knezic <ante.knezic@helmholz.de>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ante.knezic@helmholz.de>
Subject: [RFC PATCH net-next 5/6] net: dsa: mv88e6xxx: properly disable mirror destination
Date: Fri, 5 Jan 2024 11:46:18 +0100
Message-ID: <5efd2caf4fab5e08b47495360911a8767f182538.1704449760.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1704449760.git.ante.knezic@helmholz.de>
References: <cover.1704449760.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933

According to Switch Functional Specification in order to
disable policy mirroring we need to set mirror destination
to 0x1F.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 drivers/net/dsa/mv88e6xxx/chip.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 1938f0b1644f..ce3a5d61edb4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6542,7 +6542,7 @@ static void mv88e6xxx_port_mirror_del(struct dsa_switch *ds, int from_port,
 	/* Reset egress port when no other mirror is active */
 	if (!other_mirrors) {
 		if (mv88e6xxx_set_egress_port(chip, direction,
-					      dsa_upstream_port(ds, from_port)))
+					      MV88E6XXX_EGRESS_DEST_DISABLE))
 			dev_err(ds->dev, "failed to set egress port\n");
 	}
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 85eb293381a7..a73da4e965ec 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -589,6 +589,9 @@ struct mv88e6xxx_ops {
 				 const struct mv88e6xxx_hw_stat *stat,
 				 uint64_t *data);
 	int (*set_cpu_port)(struct mv88e6xxx_chip *chip, int port);
+
+#define MV88E6XXX_EGRESS_DEST_DISABLE           0x1f
+
 	int (*set_egress_port)(struct mv88e6xxx_chip *chip,
 			       enum mv88e6xxx_egress_direction direction,
 			       int port);
-- 
2.11.0


