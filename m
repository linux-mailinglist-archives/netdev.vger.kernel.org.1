Return-Path: <netdev+bounces-101318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644B38FE1CE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D99D1C24FBD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E011514F4;
	Thu,  6 Jun 2024 08:54:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB413CFBC;
	Thu,  6 Jun 2024 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664092; cv=none; b=EnKYKmaj5ibVfLb7c3Wps91stMRB2iYz+p4PavAQAexxK18GAkv/QXveh36sJp04R6Wlm0a9NidgXLMo+0NRfRrwICQK1ybqAs8HiOvjUOKLKT/n8E7PBDtoKrQ8S/ppW7C7//j3dOE4Xkqi/pzkZdtblE0OtoVKuQdrWYbrM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664092; c=relaxed/simple;
	bh=CwVmWu56KuGwPm5oczbn1YtNSkQIFslQ4iVcM+3rwS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kusQKjZfRnFDK+Rg2CpJj28LRh87n6MIldQ22auV96rkoqf3ELAs1SwePwNyf0p8pcBLJZAYcEf0MDgTgEL8NleGvk2qSiMc+XiPSu9qTjp3Q3l+R1RMF/PpejvJZ4yl+AQa7/Fr4NmwkBKGK6KAIWuHfuhndI0OrEcK7teW9H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8tV-008wwQ-CV; Thu, 06 Jun 2024 10:54:49 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8tU-008ww4-R0; Thu, 06 Jun 2024 10:54:48 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 8C7A7240054;
	Thu,  6 Jun 2024 10:54:48 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 22AAC240053;
	Thu,  6 Jun 2024 10:54:48 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E563D379F6;
	Thu,  6 Jun 2024 10:54:47 +0200 (CEST)
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
Subject: [PATCH net-next 09/13] net: dsa: lantiq_gswip: Forbid gswip_add_single_port_br on the CPU port
Date: Thu,  6 Jun 2024 10:52:30 +0200
Message-ID: <20240606085234.565551-10-ms@dev.tdt.de>
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
X-purgate-ID: 151534::1717664089-AFCA6257-36AAEA49/0/0
X-purgate: clean
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Calling gswip_add_single_port_br() with the CPU port would be a bug
because then only the CPU port could talk to itself. Add the CPU port to
the validation at the beginning of gswip_add_single_port_br().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index ee8296d5b901..d2195271ffe9 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -657,7 +657,7 @@ static int gswip_add_single_port_br(struct gswip_priv=
 *priv, int port, bool add)
 	unsigned int max_ports =3D priv->hw_info->max_ports;
 	int err;
=20
-	if (port >=3D max_ports) {
+	if (port >=3D max_ports || dsa_is_cpu_port(priv->ds, port)) {
 		dev_err(priv->dev, "single port for %i supported\n", port);
 		return -EIO;
 	}
--=20
2.39.2


