Return-Path: <netdev+bounces-143274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B225D9C1C62
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78151286D9E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADC1E47C1;
	Fri,  8 Nov 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Y4scvopp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC51E2833;
	Fri,  8 Nov 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066274; cv=none; b=Imihh85Kw36sdrdOM5E7lfFKSykbDb3GQQ2ObCRMr4iBhveWbCIzvd/ALBrRXw8AmnUSgz/ujHtRd/Sy8F2FhB2dQTD+SteQiciVgG5vVCAgLU/E1z3Hmidshenx7P4C8achb/YYhzg1SH+NWOCdttiU26tE2s/yPZ2zt4sCAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066274; c=relaxed/simple;
	bh=oQVviN+5i+x05HgtVOFrDfC3HzwLDkP+iQb92BTx4og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIBkao0xdb6zuUTj9z1UjnhR+EdmZQQw1oO+t9VrwAeo+5I0GN3r0awypHsFltV0sPRgIdlc5vW5OzrtjUyOJCRnZckkaUzLpHDL9jgn8hHAzglV5LfZpbPFoTwKNBpFB6jzW/JanKk058WNKQ0GfcrfrF6LeVmQvFqBaavkn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Y4scvopp; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731066258; x=1731671058; i=wahrenst@gmx.net;
	bh=GxbX2oxaYRc6GmeF5zAbTlIW/0poPK+EYOQlprsP+sQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y4scvopp/F1hpDmqbVxGiCZ3tiQeiamk/dXKp9V9NdYfM7Ye6g87cNme3bQErJaa
	 SZBzWFFWHDQTcApeMgQI+tDxY991CbvEE3eoqgKaXjMwHMRkNsGZzVjiA4vi1jzs0
	 wYv7kWfJFGYxWPeLjIa20/yQ2QpIS947C9ZTR+7I/RX3fQE8P9TF1BKtDaAYjk1Oj
	 V+ikv5UDjV0t7JRd6kHwbHFWMSpC9ifbid0pxs2efviUMYN1NdbgiGN4Pj/4FBXya
	 zSWhFbst3xIdgeot4g5VNJtLWqogy69g6alSRJKZYEgAZbcWTzCbhemYhLRthQJxy
	 xEJPDlnWfrUv+WUrwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1szRnK1yDM-00FbvH; Fri, 08
 Nov 2024 12:44:18 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/2 net V3] net: vertexcom: mse102x: Fix tx_bytes calculation
Date: Fri,  8 Nov 2024 12:43:43 +0100
Message-Id: <20241108114343.6174-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108114343.6174-1-wahrenst@gmx.net>
References: <20241108114343.6174-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JiTjpa5mpNh/IquJkgXFVbPDF+YOAjJLzyr4w/Ndl2il9OlCurg
 rb3muOMLHRPX+YCcpAQ59hYci2EIrumojV2f1U3+dWdnOQq6gnjSjEcIfRVWI0Ssf09S7x+
 XaCzqzXZdsddQ7LpKqxtMARM+aI8SH29prZqwYYkpOaSk6/LP6BPQi1miheQOo6G55HoHXN
 tTI50Lz3+zYz7dfxIty6g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I/2NxXNH0Gs=;einkfVas8NSOs4mg0cIlDuoqhue
 mrPKEBZN8Ylv4ng0SwBulYAB/l9V/B0FdqFX7RoZFmCJ1Fmm7fDdQifzGDzLVVIOnPeB31u8t
 wEZRTgaE5GRJk8amtPr/5CE7j32CjDQuiyy97w98gk8x+WQV1HlPJlcRnovsO4pypZp2mlBSn
 QhvJAtuz/7yBO0O3EWVKgoEpDnRjVCCYvHxHG/6I83Dyfgpt5GVwWNGoVZRK2X2x1CECDfKaB
 S8wAHPeNG2ayAxvRwikAbY6kIOqy4zzIsqyeZbLDLW/JifjgSeGCkbo25FzOCEiwGPOnE3TgZ
 Tq73MVNjyB3xAMtPtKURM8eTpIm5QrO/+WgKsVIkvLCBCEUHPGj/0vCaPVWdnW+xmt/sqlcke
 xn9CyUv9UcdfZuMbgMg6n8Kkj7moXt8xbKCofj6Y90fT7zBgacOFW2CugSTdYbfS+j3awy9rO
 y9mqGyEFVyfy2WMeWNvS09n03VpA16M93ghxJVxZymtb57HxtXxT5ngbU8hTYN+Ydbf6iQ3CP
 paQ1aqmShFRO2PmwMn094lD6vlPkuPn5OTIqTECADT2Rf69D330Szu4RjAjs8zm7YTXUdgWtO
 rcZre03iLct7q5p2i4dLa+aVzPaFxKH2OiIYM/af0hnTPeeoIlNSEaeaNRHdyAKW4GiYmB5/w
 atrhC1Ppky7GOKMUvFSZTGvDSVlRkuaHMBZ4Ww979GtRhqZul9MHLeM+mQ48xJLUYqfJ35ukL
 2P5Il56KnsEkzlkRIF9j5WSDN5Y2CX0R8o4a1HtMncKFFUG1wt1paSRuZpO/8DmYAV3nQ08Jj
 hPwDZdus8KAbcHGsEN+hjPHg==

The tx_bytes should consider the actual size of the Ethernet frames
without the SPI encapsulation. But we still need to take care of
Ethernet padding.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 2c37957478fb..89dc4c401a8d 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -437,13 +437,15 @@ static void mse102x_tx_work(struct work_struct *work=
)
 	mse =3D &mses->mse102x;

 	while ((txb =3D skb_dequeue(&mse->txq))) {
+		unsigned int len =3D max_t(unsigned int, txb->len, ETH_ZLEN);
+
 		mutex_lock(&mses->lock);
 		ret =3D mse102x_tx_pkt_spi(mse, txb, work_timeout);
 		mutex_unlock(&mses->lock);
 		if (ret) {
 			mse->ndev->stats.tx_dropped++;
 		} else {
-			mse->ndev->stats.tx_bytes +=3D txb->len;
+			mse->ndev->stats.tx_bytes +=3D len;
 			mse->ndev->stats.tx_packets++;
 		}

=2D-
2.34.1


