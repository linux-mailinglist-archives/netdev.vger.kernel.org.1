Return-Path: <netdev+bounces-102602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4331D903E24
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DAA1C24A7B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD817F4EF;
	Tue, 11 Jun 2024 13:55:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4A17D883;
	Tue, 11 Jun 2024 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114149; cv=none; b=pvvtGMCDHYN4CyFVzQGL08WDBYsSIHLf+QBi+5RR8fMOGummfoTqXxe2AiN/dQP6UI8l/VUxh3aFT73fvCEGQO+QpHayIjzGPG83uFuKqopMgcPTf7zWvj/NtkBN7A2F+SFPen173UCft4kw08HCgHxlXCA8OEF1qFGkcbsxxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114149; c=relaxed/simple;
	bh=rf7bKxreywWaz36ihg44Ce5tNfgkoAMZ4b/VuvGSpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaqO54IfZ8vq9/zKB8mWdovyvsMFK8E9KwRF4ghMt5jggfQmcGgy2r30bE5y1iWFrZt4YHJ0/N3NpISopOhv9YKQKB4FG5C7MXDNc/5yIPKg0aIyvifAdX1osNW+OB8AX0UxmuFKQRE4fEmHLh/80YnLioX3R8ePQA4KgYIiVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1yT-009Q76-HX; Tue, 11 Jun 2024 15:55:45 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1yS-002Mxq-W1; Tue, 11 Jun 2024 15:55:45 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id AE957240053;
	Tue, 11 Jun 2024 15:55:44 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 43DC3240050;
	Tue, 11 Jun 2024 15:55:44 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id F31D2376FA;
	Tue, 11 Jun 2024 15:55:43 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v5 07/12] net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in gswip_port_change_mtu()
Date: Tue, 11 Jun 2024 15:54:29 +0200
Message-ID: <20240611135434.3180973-8-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611135434.3180973-1-ms@dev.tdt.de>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1718114145-03EF3E81-735757FA/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Make the check for the CPU port in gswip_port_change_mtu() consistent
with other areas of the driver by using dsa_is_cpu_port().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/dsa/lantiq_gswip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 8ec329d0c136..58c069f964dd 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1464,12 +1464,11 @@ static int gswip_port_max_mtu(struct dsa_switch *=
ds, int port)
 static int gswip_port_change_mtu(struct dsa_switch *ds, int port, int ne=
w_mtu)
 {
 	struct gswip_priv *priv =3D ds->priv;
-	int cpu_port =3D priv->hw_info->cpu_port;
=20
 	/* CPU port always has maximum mtu of user ports, so use it to set
 	 * switch frame size, including 8 byte special header.
 	 */
-	if (port =3D=3D cpu_port) {
+	if (dsa_is_cpu_port(ds, port)) {
 		new_mtu +=3D 8;
 		gswip_switch_w(priv, VLAN_ETH_HLEN + new_mtu + ETH_FCS_LEN,
 			       GSWIP_MAC_FLEN);
--=20
2.39.2


