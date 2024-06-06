Return-Path: <netdev+bounces-101322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93578FE1E6
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01561C25638
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CA155A5B;
	Thu,  6 Jun 2024 08:55:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA016155A46;
	Thu,  6 Jun 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664111; cv=none; b=rcIvhXjm4YmCSpeNpcIjJO1JaD+Utv6vaKRcjM5ayGtmXXZHh54UvVX56dqV9c1bkRVjxLcmfNBhnxYAByR9vxGfVDaUGNAsnwAWWCXtAOsoR53a4LbcWbCO+vHb/RJXuaoNshfcMApVxnoTlexTgINfwWWZ8MwSa06u2XdJTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664111; c=relaxed/simple;
	bh=Bn8X3b011v9yLue7/qfY2gNcWkxvqcOkHg5uIA94qxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEZwRN/E0U74yySJX+8pOhY1gImNRmI5r65qsb/9L/KphWf2DM1tczuItJyqFhhS4ASC4O2UJMEB6D936i+pkbQ6RV1ahwuPztQJVD/uI8WVMaSr5LFQIDqlwZEtHG6HHdJU/hj8SKeZpzB1GE6ghdZiViJBL4DiemZz6oiHqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8tn-003wJX-S1; Thu, 06 Jun 2024 10:55:07 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8tn-008x2v-AZ; Thu, 06 Jun 2024 10:55:07 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0EF2A240053;
	Thu,  6 Jun 2024 10:55:07 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 996C3240050;
	Thu,  6 Jun 2024 10:55:06 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 6D083379F6;
	Thu,  6 Jun 2024 10:55:06 +0200 (CEST)
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
Subject: [PATCH net-next 13/13] net: dsa: lantiq_gswip: Improve error message in gswip_port_fdb()
Date: Thu,  6 Jun 2024 10:52:34 +0200
Message-ID: <20240606085234.565551-14-ms@dev.tdt.de>
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
X-purgate-type: clean
X-purgate-ID: 151534::1717664107-834B4642-90B4C736/0/0
X-purgate: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Print the port which is not found to be part of a bridge so it's easier
to investigate the underlying issue.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index 4bb894e75b81..69035598e8a4 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1377,7 +1377,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, in=
t port,
 	}
=20
 	if (fid =3D=3D -1) {
-		dev_err(priv->dev, "Port not part of a bridge\n");
+		dev_err(priv->dev,
+			"Port %d is not known to be part of bridge\n", port);
 		return -EINVAL;
 	}
=20
--=20
2.39.2


