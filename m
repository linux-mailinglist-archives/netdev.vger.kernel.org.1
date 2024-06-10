Return-Path: <netdev+bounces-102287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E81902382
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B028A292
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8BF1494A6;
	Mon, 10 Jun 2024 14:03:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040D149007;
	Mon, 10 Jun 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028191; cv=none; b=nrNwoIpNc6tki/VfXCf6VDrMNJxeQJlBg9Jwn4AiBQyu6Ct1jOTZ8tbsQzhhjY4z8MV2IAcmzyqRfF1Wch5l+kzynXXxoObENrLk+u4Ikih62eH5XvhCupS5e7SPXEkb5j5ak7w3NMJNuMGWMuHT77OGd6c2sIZJLyVh82k938I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028191; c=relaxed/simple;
	bh=TkIw1Jo5rub0mbt5s8aLdlARv8Kvqrp77BYNZT1ySXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3tT2uvgndJojIURV+PmNjZIEqwESK7LOncTbkrH2AEZip7wCFkM0QksacUiNLlHU5VmSPBwQkOOxejW8MS28pNo7WcJIdwIdySjtl/i/XJPUeNWz8MzQ/J7LBpxJdDJC7Hht8Nd7hS3x1tszf7235980cYyzD2mz7LIg8psPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfc3-00CbGb-K8; Mon, 10 Jun 2024 16:03:07 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfc3-00BDr8-1o; Mon, 10 Jun 2024 16:03:07 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id B8EE2240053;
	Mon, 10 Jun 2024 16:03:06 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4E663240050;
	Mon, 10 Jun 2024 16:03:06 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 0FD5D36F2E;
	Mon, 10 Jun 2024 16:03:06 +0200 (CEST)
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
Subject: [PATCH net-next v3 07/12] net: dsa: lantiq_gswip: Use dsa_is_cpu_port() in gswip_port_change_mtu()
Date: Mon, 10 Jun 2024 16:02:14 +0200
Message-ID: <20240610140219.2795167-8-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610140219.2795167-1-ms@dev.tdt.de>
References: <20240610140219.2795167-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1718028187-14A01D11-46F0D273/0/0
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Make the check for the CPU port in gswip_port_change_mtu() consistent
with other areas of the driver by using dsa_is_cpu_port().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
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


