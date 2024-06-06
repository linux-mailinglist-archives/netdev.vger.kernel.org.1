Return-Path: <netdev+bounces-101315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3FF8FE1C5
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6975DB24F9E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284B14F11A;
	Thu,  6 Jun 2024 08:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411C14BFA8;
	Thu,  6 Jun 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664080; cv=none; b=gTojHCkOVs+dreYWfQXET3Rh2oDPJ1vVJk+HESHkh73HwC/9QRph8y125Dg+OJM94nfsfYZWd2ImlEb/dXeZ4xv/0tXrml5f9e4dJKffTmMWqiig6RZGcPrFQJLw1kUdqtIxCs51rKV5b/G3LgrbmVJlRML3hzmD8bugKNIG8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664080; c=relaxed/simple;
	bh=U5XAGK39m7qKAwqpT4r8gKe5EEI5JdrNkymm/Ox3yoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooYqH83SWC0PTBn5/H5tsNJdWXki8VrxliEiQ/S0AyYQY+VZyBnJsezbfrVR9mZ4vzcLTYFlVlkpA5fQdt+c4CO6X+00I5pMi4da3Nx5eLX4WiLgKXMyniLa1i3cqZ3CniHz6dv0gOivrEgedJiwd06JkHCHHnvkK1uWG5k7vfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8tJ-002l13-9J; Thu, 06 Jun 2024 10:54:37 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8tI-00EFAW-OG; Thu, 06 Jun 2024 10:54:36 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 78D62240053;
	Thu,  6 Jun 2024 10:54:36 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0D843240050;
	Thu,  6 Jun 2024 10:54:36 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id ACA6C379F6;
	Thu,  6 Jun 2024 10:54:35 +0200 (CEST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 06/13] net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in gswip_port_change_mtu()
Date: Thu,  6 Jun 2024 10:52:27 +0200
Message-ID: <20240606085234.565551-7-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606085234.565551-1-ms@dev.tdt.de>
References: <20240606085234.565551-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1717664077-A5EFD356-F033A507/0/0
X-purgate-type: clean
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Make the check for the CPU port in gswip_port_change_mtu() consistent
with other areas of the driver by using dsa_is_cpu_port().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 38b5f743e5ee..789b8a1076f1 100644
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


