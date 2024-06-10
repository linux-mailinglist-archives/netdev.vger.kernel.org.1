Return-Path: <netdev+bounces-102290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FE902389
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596C11F25C84
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFEA13E8AF;
	Mon, 10 Jun 2024 14:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA586132108;
	Mon, 10 Jun 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028206; cv=none; b=O5s/Wd27oxa1S3gpWw2N8PW027/8MzfM4UIRL+eugozBHBOmXSyOpF5URWbWh/lU7r+Pi2euS1MtKRsuR90iTuZduAeMyUa7dk+5HckE0LsjpzrxGjBLqwOHFvSNye3rLQDAPo078CclifLCAYyaudtNbu36hXnPkImYfVIxmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028206; c=relaxed/simple;
	bh=9onUpucCUdaQ47RVEas5qURWppBYcOplNxRVA5xCvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHc3D1biH8nQbKLkK2MSHHlSNnkK5CKn8j9hp4EkrHuavGMT7tb9k2o0+MIjHIzAIE6FzOKqYCoz0vaKUKdqiWYgr5rR8STI/crjtqW4KGB6/QbjUNv5+etion0bbnAZLaB00/SPdW/VxVoHJunE6uX/ivgsyeIRoOQ5JOPjnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfcI-00A3b7-TX; Mon, 10 Jun 2024 16:03:22 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfcI-00CSZ8-CE; Mon, 10 Jun 2024 16:03:22 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 1E6B5240053;
	Mon, 10 Jun 2024 16:03:22 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id A97B1240050;
	Mon, 10 Jun 2024 16:03:21 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 5A9BD36F2E;
	Mon, 10 Jun 2024 16:03:21 +0200 (CEST)
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
Subject: [PATCH net-next v3 10/12] net: dsa: lantiq_gswip: Remove dead code from gswip_add_single_port_br()
Date: Mon, 10 Jun 2024 16:02:17 +0200
Message-ID: <20240610140219.2795167-11-ms@dev.tdt.de>
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
X-purgate-type: clean
X-purgate-ID: 151534::1718028202-36936522-CE61F4A9/0/0
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


