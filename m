Return-Path: <netdev+bounces-102547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099F3903AB3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E5C1F23241
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E97D17BB25;
	Tue, 11 Jun 2024 11:41:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D617BB20;
	Tue, 11 Jun 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106095; cv=none; b=oAT5uhlpqdwTwDibDrReor67BVAUMaDkeOaevc8Ysf9KKkG7hMV8OAEQrTDS8eQkd2f8nYMr0V6TSriiW7BWChWXLKbYSJ5W5EsD+Uwm5tgZKMBhBcz7IYw8IEF/FgA+MByi682aEyQNItDdbWoh2ashYMSI7xS+Uv5/XTeb5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106095; c=relaxed/simple;
	bh=rf7bKxreywWaz36ihg44Ce5tNfgkoAMZ4b/VuvGSpv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USWK1n1gH0AoXXl26VJPxgBpaY5m4yBZy1wOEMO0yxbtYsGHCnA71cDSU/ocjGOnPRmF7Cy6nt3uVQt44VoIdlZvbEkVott8GQoHRPvUEerlAIkKrUEG3iDkJitZVbOHf7g/NZnJUOYv0mqgBh2qQ2B8med00kv6d6eB91+5KkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzsa-001KyY-3q; Tue, 11 Jun 2024 13:41:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzsZ-0027hL-He; Tue, 11 Jun 2024 13:41:31 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 45C54240053;
	Tue, 11 Jun 2024 13:41:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id CE64B240050;
	Tue, 11 Jun 2024 13:41:30 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 8C2D629768;
	Tue, 11 Jun 2024 13:41:30 +0200 (CEST)
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
Subject: [PATCH net-next v4 08/13] net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in gswip_port_change_mtu()
Date: Tue, 11 Jun 2024 13:40:22 +0200
Message-ID: <20240611114027.3136405-9-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240611114027.3136405-1-ms@dev.tdt.de>
References: <20240611114027.3136405-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1718106092-1B4A162D-2A226304/0/0

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


