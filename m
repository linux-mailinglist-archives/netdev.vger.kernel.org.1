Return-Path: <netdev+bounces-187741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D7AA95B3
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8DF16A1E2
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33D25D1EE;
	Mon,  5 May 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="VYPstTX2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C7A25C831;
	Mon,  5 May 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455097; cv=none; b=P2yNFVJZl7O59zmASyivpzSAS6fcS8JWM/9kFfYaH6hYWqVlzHYWKfrjuUHS/rvdozeA7aRXggCjPxhhAlupBiBkBWRGyTAHuTVgiZbXrBGsKMLnRxlF3RO+WoFqAl8U07z2d8myR1CflnTDzlnrBR3A983B4OIhUu4lmcK1878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455097; c=relaxed/simple;
	bh=J3GH4nP05oaf3AlH+LoSwS4kKeGNOjN3B0ykXLThk20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0KORu219oaMHUu4fvfoTizg6ZmYR8V8A1V5UBEhpwTZJHIYMdFWrb3OHs99w3zlKebRqUGhfTq4XZvGZRauBu7eTovzmNf/L/E41lWRiTya6Xf2Ebh4PmIeKQ7jqwO0aUIvWGVHeLURbQJFtu/8owwpm2jtbHXw9EstIwHU9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=VYPstTX2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746455087; x=1747059887; i=wahrenst@gmx.net;
	bh=UZRXWA14115pxf43FGDTlcXbmzmHkk+uGw6Mq4Kl7u4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VYPstTX27SPHGG5OT5IZ3MY02HpMZkaRi6uGph+n9V06YW61YpytK0M5eSQotxXq
	 l6X0IvuZz3LeiYTp5Qv0KAu/ypFhHsQNyB2ja0JkGjEcr9xWgOvLE4SSA8n/VPuQ5
	 Qvx5mXMiCHAVQmR0A0OEmPSZJj463H8C2bZikbVRspbwRjHJ1mS6y9U/49scxoKPk
	 hRu6PgN0WnxX4UbnjptUM/hYvsOm2U4UtBnaQT7mdGdF6LOTUu3WnLZ9c5OivgTgb
	 fbq4wPhLEhcQnSOzWyPj4eeX88gMed8FEuPZV0GarPjGs3EXgaGfY4iClE3sjuvUV
	 8FiRLZsWLcITEDzTqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1urO242vKB-00how5; Mon, 05
 May 2025 16:24:47 +0200
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
Subject: [PATCH net-next 3/5] net: vertexcom: mse102x: Drop invalid cmd stats
Date: Mon,  5 May 2025 16:24:25 +0200
Message-Id: <20250505142427.9601-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505142427.9601-1-wahrenst@gmx.net>
References: <20250505142427.9601-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KPMwMDLAAVX0PfHxCFFHlzb5f9UIe704zCBXKX0YJnGqgYdL3Rv
 8DwJyq35xy9EdHeAReCnAsiGJnG5GBOBx61loURyHHPcu0mNxXHgfwEfJkNPx9TOJq16xxj
 GegGD9ioqIYuoljLnaLNQXPquq3RvKW8Yje4jWyzWEj7VLrxY6nQjHLV/QCW0ZMSkuQPw1h
 BM3olWNuxAzlrUXNWG2hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gRQ+yp67gR8=;N6Ih9iTxfH8arX1JkneZM0XirrI
 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
 NI3b9OIARaPQw=

The SPI implementation on the MSE102x MCU is in software, as a result
it cannot reply to SPI commands in busy state and increase the invalid
command counter. So drop the confusing statistics about "invalid" command
replies.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 33371438aa17..204ce8bdbaf8 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -45,7 +45,6 @@
=20
 struct mse102x_stats {
 	u64 xfer_err;
-	u64 invalid_cmd;
 	u64 invalid_ctr;
 	u64 invalid_dft;
 	u64 invalid_len;
@@ -56,7 +55,6 @@ struct mse102x_stats {
=20
 static const char mse102x_gstrings_stats[][ETH_GSTRING_LEN] =3D {
 	"SPI transfer errors",
-	"Invalid command",
 	"Invalid CTR",
 	"Invalid DFT",
 	"Invalid frame length",
@@ -194,7 +192,6 @@ static int mse102x_rx_cmd_spi(struct mse102x_net *mse,=
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


