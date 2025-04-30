Return-Path: <netdev+bounces-187081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C64AA4D8D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5327F7B85F1
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F225A323;
	Wed, 30 Apr 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UoBl87DC"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8525D8E1;
	Wed, 30 Apr 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019866; cv=none; b=BtNSwC1nHhb2lTh4wUEAzlgs0TDMw5L3ZajSNWB0eHcfCN6q/GpShIn5TN8qwDFzkx9TBe88mCnueN+twsI+flUtfPz6lY4D4ovlw+R6xena2fk/+mewCdJ3gdpBAL3eMAbCzlqNijpY6Osh5oTpR8Vvd5qcrWT7MPXRcUCyaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019866; c=relaxed/simple;
	bh=JnI42D8gnyQIiAq6rTseCR4+UVuJOHXMODheJ8QYLL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWJnT3qahsdwB4l/PK/Lsel9KK4QNAGm6wad+S+POq5MRhodIhTik7wqdJR9cYxQFFBgAeD6nUyG7wwQ2oXgXd8JLOfq5xkWp7g7U0nRCOK+MfjEdiYQF540nboGQjnMioinJcueMF578KfIra+xA97+BcDD197M/nFvl/XJBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UoBl87DC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746019852; x=1746624652; i=wahrenst@gmx.net;
	bh=6Qnka5fdg7WyXfCC1kVmA4SZaNXQgpnVMsbi+lOFjiA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UoBl87DC9nb/zQgxaSTXjW+nUEIxXX1xRewaswtgK1d6jRR6icCZAUtDnjUICxQz
	 js9n4FRyBIdJ34zdnROuC6XUq6uMwwkMY2SjkwVQ49YFYKvpVZEYgnrnPaLIEkCDQ
	 hIj4HMJ2UudrDKNYsilrraGUB1PjmcKPpXkncKAyUHL7Qt+h2hYrfPmOWCp/l6rJq
	 PRFVX1Ju17M+vK2AJ1B9URW0bm+ks5mZ52FHVgB06UnlzKHoi4HMjKPcNf2GROTQe
	 bKmsfgdg5s7EcMi3tEGhiuzSZq1NzMwFa91maUk4a2cpqOS8Mjr8Z+xlHVc3tCiSx
	 H8Q5I6p2HLgoggyQKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1unHqA2WDS-00gROW; Wed, 30
 Apr 2025 15:30:52 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net V2 2/4] net: vertexcom: mse102x: Fix LEN_MASK
Date: Wed, 30 Apr 2025 15:30:41 +0200
Message-Id: <20250430133043.7722-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430133043.7722-1-wahrenst@gmx.net>
References: <20250430133043.7722-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yVqTm0S4DZudVaC/yIcz9lbcB/CMft7ztzV5Ljthv1NKmegA9fp
 wpD86zCOCioSyktuDzNMy4owliVNc5XIIgpb2ajy76cv71uhjAKulIJCU2NKA2dAz007GPi
 PKWh/IomN42P/Mr4g2U5oXfushSOeG2FZek7QQDW0vcJnTRv8unch5D3t4T1eCW3JFYX8Ew
 C66PJZOMTsIuJN+MG8KMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QnRO8j9J8cM=;s2mSNVEnoVgPD83xRH1bx8PnDNs
 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
 VczwiNGr1dR5JVRBXJpnvc=

The LEN_MASK for CMD_RTS doesn't cover the whole parameter mask.
The Bit 11 is reserved, so adjust LEN_MASK accordingly.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 92ebf1633159..3edf2c3753f0 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -33,7 +33,7 @@
 #define CMD_CTR		(0x2 << CMD_SHIFT)
=20
 #define CMD_MASK	GENMASK(15, CMD_SHIFT)
-#define LEN_MASK	GENMASK(CMD_SHIFT - 1, 0)
+#define LEN_MASK	GENMASK(CMD_SHIFT - 2, 0)
=20
 #define DET_CMD_LEN	4
 #define DET_SOF_LEN	2
=2D-=20
2.34.1


