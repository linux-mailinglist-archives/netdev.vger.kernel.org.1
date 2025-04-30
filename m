Return-Path: <netdev+bounces-187078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A956AA4D82
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF93B171FAF
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788591D7E52;
	Wed, 30 Apr 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="EyE/GTLK"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB71EB5B;
	Wed, 30 Apr 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019857; cv=none; b=mxd879gXx7c1Znf0T6NyLyNdurYDEdyDmwRWDp/HPfvgn3qf3woftOZ40GXjVDOooKF1VMH6pCfrmVT6L3yqprieUJOslB6+702Yv5EYK1UK6YAIHhU8ygUicVjbQAwPoslMAiEWyZIVn1zOeavWcZPlu80/LRT8KQZY1ipDoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019857; c=relaxed/simple;
	bh=rtUf7kOs0Puf2UPujlWySKy2elK/Uoh7yNJ8qWZHYmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIuqtme+cBOBRleDqMxtAx1FWjp3jEh0taCe+FfpBksJiTfzk4fLD156HizgifJb53fCzd6xuuWDxcUtQw0bkv7I0Ow2EWAMicXRjrteby4/jg05AFDo1jnTmxabaUPthKlq7DqbzdwMNjNYSUgmJIXZppbku5IPeURTIvtShsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=EyE/GTLK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746019853; x=1746624653; i=wahrenst@gmx.net;
	bh=s5jtIj5ZEfTChRlGTCSG/OOmpwscxmjvvOjSBkMie9I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EyE/GTLKk04oKWN+veW8kaT4TwQ89W/Q7SQ0jzuNHWjplIlvCuyaEZLohWUmLiDA
	 vN2Fl0BWT558kx5Fw3APfo+AFeEjULhAhNskyLCsJou5fqV2Cf59bodoXG1WbLrE8
	 u2dU3gPIZZZcU2SdFfFzsHsCtRqy7Ivwe/JaapJ8+ABNcHPXRvRlfNyRAW4l5HmsW
	 +yjIQxXBI/ivQIBkOHN8+/J5bR9UP5/pMzRi3icZ7f+mP8QUKKgnvAUpP3QKSdKgk
	 RQTnOc6NP4BgWtyRz+VaPCOPxJIPqdY5XnMtvo4Z7iUer7viPV4g1JPdxJ1U1686K
	 gOWwoMK3HbS4qSLlyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9Mtg-1v6bPN0GZw-00yWmA; Wed, 30
 Apr 2025 15:30:53 +0200
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
Subject: [PATCH net V2 3/4] net: vertexcom: mse102x: Add range check for CMD_RTS
Date: Wed, 30 Apr 2025 15:30:42 +0200
Message-Id: <20250430133043.7722-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:IphSiOkYzbSeeNZaq98VQNBTkQOqI2Hb++d72sMoFWVs4B3jZrN
 vcqmFsO4dfKSMZP96UEsHGTblN52f0lpRPl38zMHPeeOaIYpUKHKyYEG0vFhIYme4B2mPc6
 tQuTZtFMaKiXF2bGzlVjuphwf5O/HtUN02L8L4zCMS9guoVcXNlPfPWGo+1n5UMnYhSsgOx
 IBVunafMn7ONtyxirIl5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xLu90oQ6650=;KOCCObISy2W5hwLWH//JGuGuWH+
 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
 bwjG7y/m2O03oU0/o6qjE3FS+rxL4V0qtW

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


