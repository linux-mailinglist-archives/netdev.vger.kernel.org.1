Return-Path: <netdev+bounces-102605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC1903E2E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26A21F242F5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCB817DE34;
	Tue, 11 Jun 2024 13:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C017DE30;
	Tue, 11 Jun 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114165; cv=none; b=rcwD6vdMNuNgEryhZl/pYfnPbtlOEJsBGb0LUd+GbVpYIptkucAaW/SNsMWZ7wWZ5s4cP/4FPS9EG2XSx4OMhHKVYr4KugsHON1DSGY/7GgnEao7pZchKXHgtWq+2UCxG3m2wjzN+PRWd/GcDfTfZqGf3UE2i9j2IGx2VqRJ7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114165; c=relaxed/simple;
	bh=9onUpucCUdaQ47RVEas5qURWppBYcOplNxRVA5xCvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXKEw/33n8zE4BhwLwp1oCvo7IStd0lGDOVIGb+0+21TZqZu8ohjaF3rDz9D8dHzu88J4mi0MvqrHmTJPgK0c4MTDBwqbHoCH9YPHVptv9eDAQlsJm4hn5cpiI2oWlaY9UpZB170i4r+hoWuuKIYj8bt87f/r3kWA4/dlqKz87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1yk-009QBn-7k; Tue, 11 Jun 2024 15:56:02 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1yj-0012HD-Lx; Tue, 11 Jun 2024 15:56:01 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5AD11240053;
	Tue, 11 Jun 2024 15:56:01 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E2E94240050;
	Tue, 11 Jun 2024 15:56:00 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id ACD39376FA;
	Tue, 11 Jun 2024 15:56:00 +0200 (CEST)
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
Subject: [PATCH net-next v5 10/12] net: dsa: lantiq_gswip: Remove dead code from gswip_add_single_port_br()
Date: Tue, 11 Jun 2024 15:54:32 +0200
Message-ID: <20240611135434.3180973-11-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1718114162-00EF9E81-FDCB0C6A/0/0

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


