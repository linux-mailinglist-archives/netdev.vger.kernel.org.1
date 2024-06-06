Return-Path: <netdev+bounces-101319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF18FE1D1
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF131F2621E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730914D2A2;
	Thu,  6 Jun 2024 08:54:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A71474BD;
	Thu,  6 Jun 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664097; cv=none; b=Ml3vmjJz8WHvh3Um0IWN3uoFzzhVzcgNcX5I8z+ufV8rtqqwIj11AUMVJ+ZjTaemDzp/tcNbSIay8e1VbTCdgULld4HnNxUk7dPQmwv/83+HVEhyplxeicVW6GhuxqMwlhtmH2oURaf/wmfKNacwybNp5CC9uPKZyVUWM87s+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664097; c=relaxed/simple;
	bh=fSzXFHz8So6LOSgm/n9bpHmuN4nc6jc2gCVZIUfzEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7bw5ITSq4wedRR6SSSyvD5In3caetRJnl1yezC2tyw9Cn/90mCnN4c/n5dU/e/DlONLUJlEvr4lFXfh4aUX6iP++SoilRarKP7B2UxYwvI8dP3xiajt+WW3lSnf8zxggKGN3ChtUQ77naXCsBz94IlnueVQAr5ThBwaTNNSMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9901b58ca3=ms@dev.tdt.de>)
	id 1sF8tZ-008wxL-VN; Thu, 06 Jun 2024 10:54:54 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sF8tZ-002l5c-E4; Thu, 06 Jun 2024 10:54:53 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2A630240053;
	Thu,  6 Jun 2024 10:54:53 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id B4E99240050;
	Thu,  6 Jun 2024 10:54:52 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 87EBE379F6;
	Thu,  6 Jun 2024 10:54:52 +0200 (CEST)
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
Subject: [PATCH net-next 10/13] net: dsa: lantiq_gswip: Fix error message in gswip_add_single_port_br()
Date: Thu,  6 Jun 2024 10:52:31 +0200
Message-ID: <20240606085234.565551-11-ms@dev.tdt.de>
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
X-purgate: clean
X-purgate-ID: 151534::1717664093-AECA0257-5965B5D2/0/0
X-purgate-type: clean

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The error message is printed when the port cannot be used. Update the
error message to reflect that.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index d2195271ffe9..3c96a62b8e0a 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -658,7 +658,8 @@ static int gswip_add_single_port_br(struct gswip_priv=
 *priv, int port, bool add)
 	int err;
=20
 	if (port >=3D max_ports || dsa_is_cpu_port(priv->ds, port)) {
-		dev_err(priv->dev, "single port for %i supported\n", port);
+		dev_err(priv->dev, "single port for %i is not supported\n",
+			port);
 		return -EIO;
 	}
=20
--=20
2.39.2


