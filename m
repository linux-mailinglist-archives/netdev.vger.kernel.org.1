Return-Path: <netdev+bounces-132648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA50992A43
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488831F23229
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6951C0DF0;
	Mon,  7 Oct 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="DYiB8qZE"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0014AD17;
	Mon,  7 Oct 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300827; cv=none; b=XMorqZw8F1aWqXJ2YP0jsNyRyryR6RLz6VjCoyGjecz1/xbOrMT1oACq7EIZBKMQJvBcC1N7g+OR9CFaO+lmHN6BAz/tLpJ9jC2bLhtaPIxjv+4euoBde4gurjnkC27hpdc9zGVpv7wlPDLQgxzrJsmjx4nliclj034ch+ISIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300827; c=relaxed/simple;
	bh=UjyY8r6TxQ2fxwpNf+IAYaAzbjLczsc6jXVWy6orU7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/t3I7bzoOl76WAQHDX0xibSVi7vShnYzqsl392AwH7lIBlSY5076SKFIFH6isdYCmuOaW4QgX0LKrZAcxyulD/wA/xvfZrHV+3Z16Q9eZH4whSPfGF/2r6GD9KJ4qtaIVGhNrX4W76lsM2qNhlewjBmeUrLetAyaSRSs0j1MvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=DYiB8qZE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728300809; x=1728905609; i=wahrenst@gmx.net;
	bh=xeR1+J71FI5TqCceFTo9qw/hhrgOQZoarN08RGS2USY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DYiB8qZEg5N3paGXFghZkLyDyXoN8Mn5c8PC5k9PjF6ijIgbPrX3U7ht8ylJpQ0I
	 AHmZRtWCho7YILnd49DuUQ/ntcLPxC5n8Bwocu8j6RVLUyBfcQwiSvWGzjJ6FrCQV
	 ODsaaI1WLh4UCk3HanwpN0wSuxQB8jChj1CtrUv9sw/re6ZVt2xFcuvUXpwQa8ZrG
	 4JN9fSDMJ6c3sH0sHa6b657xc+hi3eGipjYe12cX4aW0nvEQPxQP8NNjbgSO4Vgjs
	 GvQm6pPwFOMqfTaObHn4Ig5p/9R1t4HFUWl2GbMmOHpXK4ugFlYFGxCfWAiOB9obk
	 1qLrvnNu9DXn2ZydPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1tE3Hg2hm1-00DqSs; Mon, 07
 Oct 2024 13:33:29 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Heimpold <mhei@heimpold.de>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 1/2 net-next] qca_spi: Count unexpected WRBUF_SPC_AVA after reset
Date: Mon,  7 Oct 2024 13:33:11 +0200
Message-Id: <20241007113312.38728-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007113312.38728-1-wahrenst@gmx.net>
References: <20241007113312.38728-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RS96wn1dk+EY39OR5lsWvAvrO3ZGyz41ozlzQW2fjUEXbvlaQyp
 nD3G9cRuwyWJ5s+Qqx9Q6yeQKBoFc0SV3Hy+YDF/0l+hYyd+5VDuiN4c7oRW+cNSQNbRaiz
 Sb1+mKqb8lHI/+3ogDs333cGP53s1Z3cCvBTG3i+0CokO/r4UzGrmphX8C8AAv4/5eovrEZ
 8Ky9QTgkKUrAK/ibG6Y2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:towC5MalXGA=;EaxdPfShjc+UOvbmEP/nbBO7pTb
 rIuyD3A4gUH/94t839fB48SO5OgFghU87sK2aPnuwl2DNlqIdK2EWznhQWZZZoElzmyEe/TzC
 qzkJxK9A8o1y70+wSlN8/MKtan6zbrWaajHn9Jyvmfsv7GtZjshq0iG0wUT1jVCGOCQNmtLG/
 gUzWL9vJW8HRvS+GjI8eDL0kpYbLyrKxUj6OSCVZFcKYPo2/I+x7lYnUhnekCOQMLFW3sU5qH
 Ov/vnQ/K5tENOSV1BwOQ6gvUZPdxafENCu6TrnYEUM6+RISCa6IjGX0QaQcZsJIuyKZEF4n5c
 TP/c8NrpCr9wyORKdruAKDCMWfLNGLj4xitRqeAAsCOOSpw2WC4giNb5sRhM9Fy5hW2BImSpc
 qA0iu31MKxnIpO5ojm1nf31f4dxYANCfKh1dvXDWAUT91ue4MDTR4CMDLutTc5iPdgfDMKhow
 paL0Y3tL5iWm9aJ9+LOFRK1qZGUJhfw8waTL7EeyNUTrDtI3pNMYEnl84rbb6sFe68bEVG5bl
 XfTMJM6ceo+19/szyLsFRuQqXxgaYSL2IINlF7ZiC3lHpkES2wdi3GURrFDPKRT/TiVINCinT
 Tj+Yy7ATD8zb45L4d62hbV+d1PuVwgx+EtYh8bksSeUK/nsmsDF7MWIc7iNW+FGqfmeg3t1ss
 E94C4DVXLgzqGxHvzYY1Jg21iLLA0L9faJi/qtpRwYmbcvW3jFb/yBSw/quGdWHH7ZW51ikbd
 si9mtm1r/uFE5MKf249Tezh9MwGoZm1eAxKG75EbSCW/O29OEH85No7m1JS5EE1LJwgXYpmWd
 QjRRiW+gjUScbPS7Q0g1G0Zw==

After a reset of the QCA7000, the amount of available write buffer
space should match QCASPI_HW_BUF_LEN. If this is not the case
this error should be counted as such.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 8f7ce6b51a1c..fde7197372fe 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -505,6 +505,7 @@ qcaspi_qca7k_sync(struct qcaspi *qca, int event)
 			if (wrbuf_space !=3D QCASPI_HW_BUF_LEN) {
 				netdev_dbg(qca->net_dev, "sync: got CPU on, but wrbuf not empty. rese=
t!\n");
 				qca->sync =3D QCASPI_SYNC_UNKNOWN;
+				qca->stats.buf_avail_err++;
 			} else {
 				netdev_dbg(qca->net_dev, "sync: got CPU on, now in sync\n");
 				qca->sync =3D QCASPI_SYNC_READY;
=2D-
2.34.1


