Return-Path: <netdev+bounces-185006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A5A98172
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63467A2DBE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDC526A1D5;
	Wed, 23 Apr 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="X8BO+Z2r"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894A26A09E;
	Wed, 23 Apr 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394389; cv=none; b=uInBwN4DkTxOcPeqggmxr06gXDholYR+VfEI19V2n0S2cMl/M2vC4EZeZoE5tBsv/g1Yt4Q2vGQBkE1nN20J4JX0nnPyy9M8Y4wgc5LTROlvoMNTFZI0D0S26lCdK9VCIWZAv9oGWeNTt7FMRG8plt0DyhikMuAJSOQqQz9NgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394389; c=relaxed/simple;
	bh=rtUf7kOs0Puf2UPujlWySKy2elK/Uoh7yNJ8qWZHYmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkBNUEAnWidtWLEDgNo0qOEPUpMENyoaHRg9vek5hNZxWstg0I6PbYDavkkqVSXkIBSNsMVB4PAZ2+Ur22gojZ+Nnb9M7U1kRdso2rbVYzRkhDMnoDklZ9Ymt69eNdiqIUgCWFJdyvLfy+Hf2ckIZf/L38yTIHY7/opxImsYQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=X8BO+Z2r; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745394380; x=1745999180; i=wahrenst@gmx.net;
	bh=s5jtIj5ZEfTChRlGTCSG/OOmpwscxmjvvOjSBkMie9I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X8BO+Z2rZ8/Ih9Z8bootvhvsz8oOqc1V79CtKdOz+yGS2cbnzHDLBQTBz0oG5NFJ
	 BGP72RsOian98eZOVzzYxLtNS1Epvhr0kUlYKAOcaJCS+zTVkqxwqUGFHiBphz02q
	 0oZpti4P6HKmhzuW7kFZeWDuKoUsdj/Wyhz2wetspKfI67bEqFb6KbT+uMTY2FxjL
	 t7l359rwR46x+k3nOUyFX3bURo2pXwKqUCE7vELwrZlwpHdqfRNTqWThrNDuCXpUu
	 rfiT4N5SPn7co4o0TgLonaImj9buQZ+p3UOfg+AwmadiQlIkjriQi9lGhso/CpWyl
	 o7jUc1LfCS4QKNoPzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1uM5oU3rIT-003p8h; Wed, 23
 Apr 2025 09:46:20 +0200
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
Subject: [PATCH net 4/5] net: vertexcom: mse102x: Add range check for CMD_RTS
Date: Wed, 23 Apr 2025 09:45:52 +0200
Message-Id: <20250423074553.8585-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:6Srhnfe+j2KUw2GmRtcbuA+DPM7yBrXBgPKR30cLR/GCQV881Ge
 2b0NJbSBGLr7ZzCEbyQySscEyROGpKFqHvTQv1mRU/1CCT5h+FrOXNng8rqXQp0MYA1IWEB
 NdQzCd/bQ2O0gvkVCVYDiegLQcEDhWAaZKFPxiGKxmqF1pYDoU80aRtHB7Mk2tQySS613Ag
 PXH7k8AE+WLncwRs2i+cA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TNC4KZbSeo4=;emXHaZeBOdh5FvLfIEmiPP8KyWd
 +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

Since there is no protection in the SPI protocol against electrical
interferences, the driver shouldn't blindly trust the length payload
of CMD_RTS. So introduce a bounds check for incoming frames.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 3edf2c3753f0..2c06d1d05164 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -6,6 +6,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -337,8 +338,9 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	}
=20
 	rxlen =3D cmd_resp & LEN_MASK;
-	if (!rxlen) {
-		net_dbg_ratelimited("%s: No frame length defined\n", __func__);
+	if (rxlen < ETH_ZLEN || rxlen > VLAN_ETH_FRAME_LEN) {
+		net_dbg_ratelimited("%s: Invalid frame length: %d\n", __func__,
+				    rxlen);
 		mse->stats.invalid_len++;
 		return;
 	}
=2D-=20
2.34.1


