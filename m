Return-Path: <netdev+bounces-102550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B2B903ABF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55D7EB2676E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C217E8E0;
	Tue, 11 Jun 2024 11:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E517C218;
	Tue, 11 Jun 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106111; cv=none; b=syhPfDlWFP0cD7aa/L1M4lZK9C2pfOenR0xttUBIt84fJNsC0u35SOpRpWt3BG8enJAHL5mBkqv5riRaDBsoq5tWOsy5jao6YKNXKuMM2aV9GM7BaTUZdwaKvWKFTImuYK4mnFCcpGq5uP+NYeCK5t0SiGghN7hPJWpUwdIWnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106111; c=relaxed/simple;
	bh=9onUpucCUdaQ47RVEas5qURWppBYcOplNxRVA5xCvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZYEih8DYy+RNv7ZJDHZy8S57YK0KdavCWgPij9npajL2wvEnkJ9l1TmQgLDVmvI4VNSECEIMGgLltlucNsYDR9ufx9uB+EJckfUB3rFRJYyxLkd0tXwssZlNreG9wAl8VvWC/hQvXETIb7eDjSN4GG2++kylFdg7EfVyujCbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sGzsp-008R41-R4; Tue, 11 Jun 2024 13:41:47 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGzsp-00EFhC-9S; Tue, 11 Jun 2024 13:41:47 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 04E4A240053;
	Tue, 11 Jun 2024 13:41:47 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 8F123240050;
	Tue, 11 Jun 2024 13:41:46 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 63A4B29768;
	Tue, 11 Jun 2024 13:41:46 +0200 (CEST)
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
Subject: [PATCH net-next v4 11/13] net: dsa: lantiq_gswip: Remove dead code from gswip_add_single_port_br()
Date: Tue, 11 Jun 2024 13:40:25 +0200
Message-ID: <20240611114027.3136405-12-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1718106107-036F2E81-2BF1C4C2/0/0
X-purgate-type: clean
X-purgate: clean

The port validation in gswip_add_single_port_br() is superfluous and
can be omitted.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/net/dsa/lantiq_gswip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index cd88b00cfdc1..2bbc7dd45418 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -655,14 +655,8 @@ static int gswip_add_single_port_br(struct gswip_pri=
v *priv, int port, bool add)
 	struct gswip_pce_table_entry vlan_active =3D {0,};
 	struct gswip_pce_table_entry vlan_mapping =3D {0,};
 	unsigned int cpu_port =3D priv->hw_info->cpu_port;
-	unsigned int max_ports =3D priv->hw_info->max_ports;
 	int err;
=20
-	if (port >=3D max_ports) {
-		dev_err(priv->dev, "single port for %i supported\n", port);
-		return -EIO;
-	}
-
 	vlan_active.index =3D port + 1;
 	vlan_active.table =3D GSWIP_TABLE_ACTIVE_VLAN;
 	vlan_active.key[0] =3D 0; /* vid */
--=20
2.39.2


