Return-Path: <netdev+bounces-102600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31785903E1D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F611C24500
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262917DE0D;
	Tue, 11 Jun 2024 13:55:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B317D8AF;
	Tue, 11 Jun 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114137; cv=none; b=f6GW4tUzsezH67Ze0G8ozVV6I2o2VNuwPLMSnuuHWydp/tXAg3T6+YYanQYHRVsZVK02MMZ65U8Vnhj9hJpELV9hep9Zjp1BlGCrXp6squAthKansAgS6xdyL3KRDIzeLp3STfuQlZUYnEy1kUy2KATRuY03G5izKKfbg8HoPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114137; c=relaxed/simple;
	bh=taDd5iOXcMi1GDYjC36QIK9CTE076C7/N4X93v5aW10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaBsNWIEkwFb7x7hAS8briIRWYT+2FAdbWrALaKh41labEyaV7tKuyeSsjrb/kFGpapIy8iql49sz9dubrqhrCi412r5EiYsbCamvW2kh0BLTg4y8vJPXtbqceBF+blGagyHMfmpwVsk/hPYKWXtWW3P//ISfo8Jaag7qw1cb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9906f4c1d5=ms@dev.tdt.de>)
	id 1sH1yI-002Ydp-6M; Tue, 11 Jun 2024 15:55:34 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sH1yH-00369r-LF; Tue, 11 Jun 2024 15:55:33 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 60920240053;
	Tue, 11 Jun 2024 15:55:33 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E97C5240050;
	Tue, 11 Jun 2024 15:55:32 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B0451376FA;
	Tue, 11 Jun 2024 15:55:32 +0200 (CEST)
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
Subject: [PATCH net-next v5 05/12] net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
Date: Tue, 11 Jun 2024 15:54:27 +0200
Message-ID: <20240611135434.3180973-6-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-ID: 151534::1718114134-C1C4D8CF-5F3975C0/0/0
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

We don't need to manually call gswip_port_enable() from within
gswip_setup() for the CPU port. DSA does this automatically for us.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/dsa/lantiq_gswip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 37cc0247dc78..c1f9419af35f 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -898,8 +898,6 @@ static int gswip_setup(struct dsa_switch *ds)
=20
 	ds->mtu_enforcement_ingress =3D true;
=20
-	gswip_port_enable(ds, cpu_port, NULL);
-
 	ds->configure_vlan_while_not_filtering =3D false;
=20
 	return 0;
--=20
2.39.2


