Return-Path: <netdev+bounces-102285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C0902378
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31110287D13
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8282814387F;
	Mon, 10 Jun 2024 14:02:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E78563F;
	Mon, 10 Jun 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028179; cv=none; b=TFnvHb1rV2uSg7hOxFZxtJqJlPJyI3QFr5b9fxfVBN+h/sogc3YpoHkP9OCTSo77pJ4CpuYH5F+840wIhki+WxOcDi27/u3xVRfbiWQ2Sihg+bzdgzlL9/BrDf/as6ynKPg6bY6xRboZJJsZBu9OSjYmgzI8fQUS7r2KYImFniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028179; c=relaxed/simple;
	bh=i1CWk2eYOi5kSnD+4MANXsOCnUVm8q1yHGW7uuSDh7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnFvD+zwlldcK6WLirFCzGwzlYSHuaa4nXAlczXIWTzZp/4czJgzeIDMKFq4K+cdWGPDRkvqLU6w1O6P2SQzKwedKwphPihg+qIiFK06xOadqIhRm/HQgQAD13FbN6BRvwQ7Ei/ZS98N5zYdLvPmGxk/c6Pr9EeUuuYalG1u24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfbr-00CS4C-U5; Mon, 10 Jun 2024 16:02:55 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfbr-00CS3S-Cz; Mon, 10 Jun 2024 16:02:55 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 21DE4240053;
	Mon, 10 Jun 2024 16:02:55 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id ABFCA240050;
	Mon, 10 Jun 2024 16:02:54 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 7660936F2E;
	Mon, 10 Jun 2024 16:02:54 +0200 (CEST)
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
Subject: [PATCH net-next v3 05/12] net: dsa: lantiq_gswip: Don't manually call gswip_port_enable()
Date: Mon, 10 Jun 2024 16:02:12 +0200
Message-ID: <20240610140219.2795167-6-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-ID: 151534::1718028175-B8ADED95-597FDD6E/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

We don't need to manually call gswip_port_enable() from within
gswip_setup() for the CPU port. DSA does this automatically for us.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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


