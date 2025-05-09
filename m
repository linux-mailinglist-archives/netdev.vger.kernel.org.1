Return-Path: <netdev+bounces-189228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8866AB12D9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40603B1171
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C028FFE3;
	Fri,  9 May 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="NQchgrPO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CC290BC7;
	Fri,  9 May 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792107; cv=none; b=dFcyCDqOmAYeK8MSnpXTGPfcGQ/xNHK4YBOrfIG1uEGCfYR+26xDKY5nbH+S4Tb2sdC+K0WTAPy9jEnDyYWJiiyMXeW3aQCMMepRNMnf4uNxz9fI03reuGZWMrm7io2M+HvC/dyJLlGs1jp0ixz0PoHwmjJ52DXqjujfRV5JBtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792107; c=relaxed/simple;
	bh=1pwz2+Q0Gd+jElqkSlVjDgmKZjTx4VsdAcXYpLc4/vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHKayl5VlFeH7DlTXuqNzZzzIP1a91sqWLFe5RWpeyr0ft5jlIZAx2Q5jwFo/IY04SiZr+rbixnVS7zgi+//FiJsRAZ9yEBP2ZkbUwXQ3yD9NVrvXrM4su9DLHEfqSK1uFUems17LsM/+L/DNnB9BsLyO6xOnJbPUek/Bs3awto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=NQchgrPO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792090; x=1747396890; i=wahrenst@gmx.net;
	bh=bnJb0uD1IRNj1rXqCbTxVCfLPON5Hahh9t8ZRFy2s8I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NQchgrPOahW5xd5qjXNBXI9cWAFxsT4h81xe/bQ76mck+c1UjklmC37l1wHzrbKs
	 17JHnBXS5sNcvfXMYhsXQmQCvBLRDE60rlVuxgdIeFPC5Qn4sto5jo2Gnlv9CaL47
	 loI1ChGvD51HH5yAP42F+AboW1WHvZV6YugZcUnMY3nI1q+BMHmp95tDr/HZgLwbk
	 5wwboPKfuP+I5xdNN8pRvJgRCdJCHZ5qdIbEdEi48xP6caBNW+l5CMxIE3Aq/aeaT
	 hBP2dTrVlTrQrkwNN8tNjQbBju3vaPOGhPTZ9MQkPIXNxfdcoB1lFHxldbSA7bPB4
	 qAXnAOyPUAvcv1SLAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1uXta03VbR-00Pk2x; Fri, 09
 May 2025 14:01:29 +0200
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
Subject: [PATCH net-next V2 3/6] net: vertexcom: mse102x: Drop invalid cmd stats
Date: Fri,  9 May 2025 14:01:14 +0200
Message-Id: <20250509120117.43318-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509120117.43318-1-wahrenst@gmx.net>
References: <20250509120117.43318-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MoYowGCeHcJ8STtNiUzilf84M6VGsAwHASWGIzOqtKTnjgikS4q
 Z77P6Sxrc1qMSk9xlbPFJo7RpL1sSeuLC7CXfa6zzYPfZUACfyPvWAD2dIyFJOstf/hBHTh
 /xV3JF7S8BwSLVpMG+MgnATzub3HzwLJY1sxUdYnP7Z0kqDXBxKIum56qkX0N/Z1vMQX1zk
 NUNffZsbf+9SOkmC5TRLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:khMUsvp2F0E=;p+ywW1bwyX2fk1kLE4sjTez8BQP
 rs9hn7/oOlOwGRaPM6xXr6J99Tu8M24XxHE4z6NJKVAnpHV4QpBebNzighYNQEDNAIvQk/2iM
 qeOl5fo+uxDn/f1rUmOUXWXnr6IQ4yEj/8tH+gIRM81RnXdj83NhOE92xKnwvScIzK9w0YW1/
 k46+ORx4aU6NIaPEFadxxlgKgqhe4yjqis72BO8NcC9JXwlqgC+QxciSr/KUyh83xQoYqQkFn
 WdG8cC1Se97EohRaSyPh60VgPqYIV+pw3f2HoH5KOGn2NAKnIii5VAfsimmzuAZ5YhxKoZNFg
 IT3KTJls8qJbbHfBVlP1Yf1m7yHPUp+aBhfcJWDV9g1an7EoGsavhTeKnk5Y4DoUUgbHeTawi
 uMJbJVol52ZXQq4Z6nJxkAP/kGNRhd2V3SI0Lk/zXOWA6PjANrSxPmK91Pbi3oj0ScpaWUGJ+
 IDFDfHbboF6YVRrJBEUcDFqF7jBzu6NUVtw8f56hf69Ns6UsEApqdTOOFNg5jiFW36tCySnue
 PlD5HXDKXIzlC4Qc7bVlVhMqHk0jwmlkTBbyjdKSXUL7poZzY31TifazvpBKSw7wVo0y21Vya
 Fqyg3QtSIiNEAOpZ6ZOm3SN02UXcEA0Ql8xNVvlsxqG1SYOCMGXdXYnjy+Ns/B0P8XsDTsmWc
 52duHVDfQSChe8RVaJvl3SdbTjgbFjK7buSBdRL5ATu5NYXQ1WMoSqlkNKfv7cH4gqPE4BNsY
 Xxj+wGKeUxQdYIFZeS9wvuTlVQ2+7uyv/52dC36eFcJuJn5kKwVueorZPb7qsD1xA2N6nXvlk
 N831wgRWvaQBsUBlobeXMHFj1U79He5+HKJbOcb3BWyJaQytNmygmHgQBGnYC4FT5CEzg6Fqq
 pY7nNBhVkG54LgEshR1nCu9cy/ADenQca7BlQyXkJ06DjVXY5X0gfihvqJd3D6jXm4hXgodgE
 jpkvr+Gow6GU1fBBxcCVshU9UFhTJDefLCHttb8Qfhvv2O4CVH7/nlK6+B9DxZmdejCbMAYSL
 S+quYI31VshClghd2kF3MFUfiw7vTP0B16PO2jrB/VvH5O4SDAsd4xGJ4ZkZNvX8KGLFGpuZA
 fNZQ2zXKWibOG2QKDeOsY5ANO/B2ST9grs5DG1QKt6jp2/5Zlnpc+vWTqhce0cJBN5EwkixxW
 KXKzT7Oq3SsFb1xAeY8Doy3WkUDvo+oVtDUAG6L1X3UR0PmGOnLV/wf4kQQmOBlOooOSAT0od
 dJwpZCU10cFBu80rbijpE9nNg11a52z9xbSLZPEsK81/ysdjLkgA5iVULz52dvAbgbqGOUA0G
 AcuEjnrXaySOLd2EGGaBgs49G2hm1f45CqlDyKC2KOiRx8EE2gliDO6mSP+pjrx55EesoCJJG
 aw+OJC+u+ro2zjZW5lbhwuZ47NlViRaz5nS/RtcAiYhJUmLgK7OAWIvXVRXP2dUsFsMlClbW7
 KLUZE6wXtoBAlj1TM/6aXo92T6rPxsYtL1cPWidgahlCK1NWiEsjQ8+QeBr6KDVk1Jz7ik7RZ
 Bxe4pDoW8RrBlorPAXAczrbLotysivOdeYhy96U8fHFM2VF+RJVffE7G/9HIF6LhpitjZGHYf
 fJFRB1fqNc3s40cbM3LmgY6XuMpLEpRLFVgzoU+QuaJ4UNyRZnmIP7lZqzTL6J0tRbjc4igdC
 Cp/qBCoBpsICpt178S1ToHafvi6Q+vEBEkwRsSLpUdEEh4pdqN/BELt2hZOdNAG7UOwqk5b3i
 Qt/epjcUpnrF97aH6XMM+YeXYkqXEKhA09JFk0WDsTh4LS8WRDnFzXWuz07ySHeN5Siar/3km
 Jaq1fkKSzfU/AAL9InEkVk5FxXE6EwIARI+o4U4kGfiOqj1nqGQ5RAUllePROoIrzVSoN41oJ
 LOCqr3fs4XRtzHkx2c40oNOFWatIQsWEgjvktWZgi++Va4mssJRrZwrtjiKwtxIxGCwVjlEXn
 hoVRUoKTuWSHY04JrR2LwJ0tRYNVu1oGoYi/AgNzsUMLmmqJaK5Cig8ifxVttge5Qx2HT4X1h
 f75wTsBjB6ip8RBeVMDJiaeDdx0OE32SSU1zPZKC3eC6c6jqVe/UfjNgIa0CmAUNzrDWQL8QJ
 BmAlAquGU4AzWzYuIyBFDQ52EPm+0dW79W15ja9DrPDC+JTc9tynsbh7hQeZ0A0GON4im5vT9
 G0qh4GkAhiWy9YFiTUJzhlbUbM/X+1FcKmtEKLLY15wrEVEfB8zahBOaY2IhwfGUplTWbNGZf
 CFDYsLiR2cB+O69UJyJSfZ97VNmKhapSs8KBZobn+gwxgM6FsYMAsgEDR0lDvVj0JsCCk6VS5
 t7GJlDgyoA0LS0y1Y+kqpm4WFdIBeSfCnN45piI0aR6MSZjUZfA0tQ9pAP0PDu/ljQ310K5zJ
 Lsbu7QCUs5W5zn6HiBr4yw4LxRmQ/4X1VY1Nwok080tKvpoPe2VOc3ZoTNofcnX/oZwzj6BbJ
 YOeyqzNMcgdvWigwQO4CTnZAFscEnYCSvD7fVJTTX50eTOnfnBTi3X0XH20WjPQICVXB/e7UQ
 rcTGPpYScJjfkKGVnJBgHWuEKZrKvv6d77Refg2y4KDZunZR3gFXJjiuSGzkRKS/QA2UWk21C
 H+SKAteZwEOD9Ex4w3Lpd20eWKPc1NFlMWE33HJKZyeQGV9nUJT1EL+hdUrOlk9TqCPvr+Gsp
 eXz2U5jnGUZBoGMCVeABh8D6njfiyKefX7Tiol3qDfOCIYXzq4B4WInKrHFiAw79yqOVpwcsR
 vRLul+7OQoO0z/M8y8/YIg9wdJYDtu3WizNoo18sdfJlTyy4j7Xts9Sy12UeE43ABAir2xdQZ
 /Onw2dDmh18qTyDeqrP6O55amqIY+aSoM86GDzPQyxhHJhZYy0dazjK2lgoDYW1wvxxRZwGWL
 acqS2apW73OLCI4xCpknG5mqpY2ZZK9+yTx67qEjL+KKhaxHQThhmTn/B+jt4yPqMe0Pl2r/n
 a8YBXFVpFYijU+L7JNIHlelMEf1D7WA5EF18nnzL2f60IIGnGgrcvIl3SpnjBdD3xBrkRprra
 89qutd7IGeHSPwSvxv+mfC8IMMhKkNC53XxLHd8cx5JyPVycWAb+jCLgKB1PThVVOLY8GhWm6
 LXFhEEq9m2wBLD2cS9hA5TbyoakdQpHI6FJCOCthIANMJ8f/NxiS8Lv5Dp6oxM2WS4FxgXM50
 /olwVyL9z6f36lEEsKrwjaSJs8EOb7DMdMwMBayew8Rrmwg==

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


