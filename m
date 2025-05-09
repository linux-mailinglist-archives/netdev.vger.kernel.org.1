Return-Path: <netdev+bounces-189229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E91AB12EA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF55189CD73
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AE82900AD;
	Fri,  9 May 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="EolhaV8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87328FFEC;
	Fri,  9 May 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792286; cv=none; b=lWMP6OeS8bs0W67tFcP6xdNtCJUPbYhnwW6P0EN8Gu+4etp7lmEQgBLoJckqZU6Ir7UwJ42R0mc0o1k+CZKstbHO4ldCvIupCNKk2jv8VYur6k+/csYcZzkmYUhkrXCRFJw/U+AIGCJrWtYlz8wwH4el6Jc5TdrvFxhUz44bqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792286; c=relaxed/simple;
	bh=1pwz2+Q0Gd+jElqkSlVjDgmKZjTx4VsdAcXYpLc4/vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnnDQC0B8FtYN3Hxvy/PV1rshg9IX63AJVmqsQfWfkYbVDYoRdospsugMQkworHuup/NglFX/RqwO9/FO85+AJMle6Nqgqw5bEQ6Ls1Sq9NPMCdkEgzjTJHrytXLcVq3pagbOQOYRsP0A/BHIIQDk+Kn0MMjb5gTi2Wd3ORz1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=EolhaV8Z; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792282; x=1747397082; i=wahrenst@gmx.net;
	bh=bnJb0uD1IRNj1rXqCbTxVCfLPON5Hahh9t8ZRFy2s8I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EolhaV8ZUoMPoyx3bWPWvL8semFdyVaR36JOiXOh6E0V3jxkgParQpjmC84fo5g0
	 OT4lmjbRycCDz50fp2bv9CIGbpxB8ZzSAyczSq7xsti1yAEHX9M6xC9d0OuL7OVwu
	 QIsppw5aHtzOwp2x8s+FFKHTwfui3QnDVgkKR89B/VdXIkxw+AjMt/UEpxE3CEoGH
	 VDciOV+VSsmUkaK2/h6cp1dhVTYEFoVUL5FbAy42XnIpqwmzVGGl9t865yMJUH1Ob
	 bs3eZfzfnvSVbilHn5Nk/rtwc4y7YsoD3MgyPQ8MBxWiWWeuRgFsSs06p2V9wNjxm
	 M6Lv/F2WPXPLfnWBEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1v1kA62a9Q-00vile; Fri, 09
 May 2025 14:04:42 +0200
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
Subject: [PATCH net-next V3 3/6] net: vertexcom: mse102x: Drop invalid cmd stats
Date: Fri,  9 May 2025 14:04:32 +0200
Message-Id: <20250509120435.43646-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509120435.43646-1-wahrenst@gmx.net>
References: <20250509120435.43646-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rD5zWXzNqIbmCcR+9PfBPgwFgpV1AQCBjVE1VGgb02c0l3WvB0T
 tg1beeefrII3S7XJue+3kZAsic9OYj3WBQCNjKpBCiK1OlSdW08hGgIU7PC2NfD3wNblOAq
 /yNz7iG9hdv2wjr65onB27RREZYIKRFG0nWib94PkT6WhUv394Zdrm1WGFMTMe7izS7j6I4
 QgzNcEoyOL5ScghNY3EOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j77RlVcJA1E=;o4mZZTQQyt29HARqSIRpwXU9/MH
 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

There are several reasons for an invalid command response
by the MSE102x:
* SPI line interferences
* MSE102x is in reset or has no firmware
* MSE102x is busy
* no packet in MSE102x receive buffer

So the counter for invalid command isn't very helpful without
further context. So drop the confusing statistics counter,
but keep the debug messages about "unexpected response" in order
to debug possible hardware issues.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 78a50a68c567..954256fddd7c 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -46,7 +46,6 @@
=20
 struct mse102x_stats {
 	u64 xfer_err;
-	u64 invalid_cmd;
 	u64 invalid_ctr;
 	u64 invalid_dft;
 	u64 invalid_len;
@@ -57,7 +56,6 @@ struct mse102x_stats {
=20
 static const char mse102x_gstrings_stats[][ETH_GSTRING_LEN] =3D {
 	"SPI transfer errors",
-	"Invalid command",
 	"Invalid CTR",
 	"Invalid DFT",
 	"Invalid frame length",
@@ -195,7 +193,6 @@ static int mse102x_rx_cmd_spi(struct mse102x_net *mse,=
 u8 *rxb)
 	} else if (*cmd !=3D cpu_to_be16(DET_CMD)) {
 		net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
 				    __func__, *cmd);
-		mse->stats.invalid_cmd++;
 		ret =3D -EIO;
 	} else {
 		memcpy(rxb, trx + 2, 2);
=2D-=20
2.34.1


