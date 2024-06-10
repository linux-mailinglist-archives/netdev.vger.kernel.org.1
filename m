Return-Path: <netdev+bounces-102293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6429902392
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455B528BC65
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAEC1509AF;
	Mon, 10 Jun 2024 14:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC112FF88;
	Mon, 10 Jun 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028215; cv=none; b=WrI5/DpA7Lfd2HAyb5VWDQNbpCzxND4GLyO8JmIlMrSorLISgOvigMZc7vzvg/+VGMBSa25e8Ozyt2Dmg0epqfJSpd57wU1pFmdfhmy9o2lultOyKE9ar6WvFbD+vRjwBz2sXgWlFDs+4UR5ZHIB0g/I3S+JBEitLcXCDw/5Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028215; c=relaxed/simple;
	bh=2dirzJRuwbGhd+6OQ/fShUFZb95MtmFHC/hdTU38XuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPm7TrkyVHW8zIGjUyCWUPEIAMHq5QMKeHRXAe1HmJ1i75VQWNrab6kZVBd7sX2AobDb6XDQL6Tt8ChQPBn7IngLCyNWS2BMp/60u6GSJ8VO5lpDERE4OLMYryQLY8jxfLQ3h9bd9SwIkuxfVNqFIvy9WQJ+/jpqIfA7OvMehl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfcS-00A3ix-8k; Mon, 10 Jun 2024 16:03:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfcR-00CSba-Nu; Mon, 10 Jun 2024 16:03:31 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 736BB240053;
	Mon, 10 Jun 2024 16:03:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 070DA240050;
	Mon, 10 Jun 2024 16:03:31 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id D0D9C36F2E;
	Mon, 10 Jun 2024 16:03:30 +0200 (CEST)
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
Subject: [PATCH net-next v3 12/12] net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
Date: Mon, 10 Jun 2024 16:02:19 +0200
Message-ID: <20240610140219.2795167-13-ms@dev.tdt.de>
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
X-purgate-type: clean
X-purgate-ID: 151534::1718028212-36129522-E7DB901A/0/0

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Print that no FID is found for bridge %s instead of the incorrect
message that the port is not part of a bridge.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index ec52c62eadce..fcd4505f4925 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1370,7 +1370,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, in=
t port,
 	}
=20
 	if (fid =3D=3D -1) {
-		dev_err(priv->dev, "Port not part of a bridge\n");
+		dev_err(priv->dev, "no FID found for bridge %s\n",
+			bridge->name);
 		return -EINVAL;
 	}
=20
--=20
2.39.2


