Return-Path: <netdev+bounces-185005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BFA9816F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F26717BA02
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF81DF982;
	Wed, 23 Apr 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Amb7a1Fi"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053911A2557;
	Wed, 23 Apr 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394386; cv=none; b=dYtoIT8AzIREA2EhQMGsFw6KDm5kBI90l9Gp9eA2RrapLaFu+mZ/fXaNGGeiVoxNzpABWPTaOAymnBnlVa9vpdQfdFht3x6V/odeJFPHz+bL1iLzYzdtIjZvahiXYjlo8Zz0lXQYNzy8gJ4uUqBeI2ZDiDSuDvabOq5XNsuUsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394386; c=relaxed/simple;
	bh=JnI42D8gnyQIiAq6rTseCR4+UVuJOHXMODheJ8QYLL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1JfUNkS0v4eXKKbVMduEZXi2YZH0UhYzxV5yriKamBgw6m8g2IQLqBbKi4xHDvSXaZzVciDOx6H2yX0FYcHDSpEsl4tRRvDTZl3Ov7X7tXwsQamJY2iUWgtCGA06K+Urzbn42Db0nOW3oh2078tsoCZx7HTEcBRL8DztV+K/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Amb7a1Fi; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745394379; x=1745999179; i=wahrenst@gmx.net;
	bh=6Qnka5fdg7WyXfCC1kVmA4SZaNXQgpnVMsbi+lOFjiA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Amb7a1FiKIv2H1GG1JSfPImbEeB9QDu/X4r7jmGSvLbmX4K/h/5QCsad8nPDcYAQ
	 HNgfpthSXthCXXxxGfOG2HOMpCkzdjFAK5tfF5S838bAQtXsxHBZZMfcBxvBFdlW4
	 OfdIBKdQqHJcH0FwkzW6drguYwd8quhO7zI1qjroCnrid0Q2R4rbq17j531HK0DEz
	 GqLbVKzwwOyRB9g8UoHbNoxgPyXrNN8rmzdgsHGBR4nvNGtZfbJKFnjm2vLTVJ++0
	 VlMHsoLMx9sh8ipt+tRx5tJHJaIpNLRhe8Y5NJfwyyMUge4MKWlza4YDvgxZ/y7ua
	 PzUjm1IFQQcVUQCdyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1v09Qi1k8d-0189DZ; Wed, 23
 Apr 2025 09:46:19 +0200
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
Subject: [PATCH net 3/5] net: vertexcom: mse102x: Fix LEN_MASK
Date: Wed, 23 Apr 2025 09:45:51 +0200
Message-Id: <20250423074553.8585-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423074553.8585-1-wahrenst@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VgVy13nL0ScqfCSFbGxaOXEncyk5S8feQdoG8bFEyZSh/zQCeVn
 NU85JCrw50vk/SpkwwIMmxKLL7XZ1y5TpqNufSqpYAtftKWliNiucHMPpTspZkofkpOXAYy
 L/iPJ4K15O7BpVu2ydDCAp+17tpH3ITqtZn6wNpK5aMVb9ry7bFnypM3R6i6HoIV1iEGqjJ
 g2XqJQaWtH2uR4/vB7xSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C/i5ry7xYwc=;AWP5y3vXEkxikeWhb8y4Ahu0jgv
 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

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


