Return-Path: <netdev+bounces-49729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4A57F33BF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C9928309D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61C5B201;
	Tue, 21 Nov 2023 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="FVCy+rVG"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D89198;
	Tue, 21 Nov 2023 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1700584228; x=1701189028; i=wahrenst@gmx.net;
	bh=gFO3xN70nhDuQ7SY9QhsM0qxlVzj4P+YuVI4yCUqFa0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=FVCy+rVGHnTnh+4TAcgF3TPHxW/oZGGXiCjNbEpbt8O/b0phxICtrrOmWNSWoGG5
	 lBfbsxfDeqCACkiycmECrw+Sge3o/7CqHzLdsn2vqdUR38ddlukKjBQsCwWL+Dq61
	 DtdyLLF+sPOmgOnsKnuH9hG4MLzAFBVs98YLuA3kQu/tWVrLo0LXH3ohE3f7KaepJ
	 MjqEL6G8GIFCvtfea18o0Jz/jAiUAEqNaBKAfsCgtN31cTZA5P1WRwM82pySHZPlr
	 ENY9d6fAGaLfNl5YmzttIOWHU2PsJ57HAVaAVHQEEqZlqN2QO90EYZZyN8Q4B6li1
	 sq/+05egqArxCmgrZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpru-1rhIIY1S9a-00pKch; Tue, 21
 Nov 2023 17:30:28 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 1/4 net] qca_spi: Fix SPI thread creation
Date: Tue, 21 Nov 2023 17:30:01 +0100
Message-Id: <20231121163004.21232-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121163004.21232-1-wahrenst@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R5Og/3TXSv+EbNnWtBnjT7DeFeB/d8AD9ioj/3gA+uzLn+SXZ+e
 lagkkN/BCvhb1QAZEDH/hWfr4iBkOzpOb204fxnwFHTRixAgdTpPstG85IGTyr+T0QAYHPt
 6krSePtsml1uUDA7CPyixNf+fEurH8FrJJBAGCqyM54m736UC38W4e8KjmunN7FLB3wNicc
 OkeyMVLM2j0ajBD+ymZIw==
UI-OutboundReport: notjunk:1;M01:P0:mRSwnWXLY2I=;TWO2yF5JCazzVqnIR8NZylxkOuq
 VsOnTYCzNupNYYYa06HB+VsPVbJOaHcDc4vnx4+8BZH0ycNqKaJBU4kWfCzTUM6W1Kss1nLJt
 Bi8gUqwdAAwTs9IdMtukWLb4ZKSjihhDhpE89Yyau0nGiKfj+RSkz5Vb5E7rrwXugWxeI968z
 6wX4yOabTcTAApesXCu1Wg2A6y1KCy8lFeipMGS3aW0x51G24QbLqwZqoznfWp5JiX6G6uRky
 g0FAGRMgDN9LSS7OfsvKuu9oLTREBlY2C6OBF943B1BJ1T29H/LhnMH/GEa16JyQRRszFOHOd
 BEtam9ml0sY1ulaMcpbkYAdNt726MRp12VC/u7hf4Tesdy+8IopTvgHUyu8U34Rz2Nhamv5b0
 gz2GM44OeGUnR7+//ZVsdiTBNhfZKHXFj7yaJdVoYjC1Glb+qnjYS5BHdpBxHScOlNzCRdal6
 mILvp9oC/0WntHpZ/wbhmg70o1t5+WWTFvdx01TeE3L6FKJjc1kce8SFPrd7twKT+xgJ1pXVK
 QUQteoXH8gW44WNieQmmWhBWr6CmULKEZfBi7RuAenpLhhiFnyof4P/zlI9o3EIqNiOmuCV7A
 Z+i7GNP9/HnA9u7V+dhlFg3orD3qd2gkKjtDDXcKtIUkC/x3fpTHJgxQqf9MP9gQM1mAkB0/9
 WFLJalhQQOfMKWIsiwCoDap8XCvYYiGGfzkMCpXLAR8iNslvGlT/enDnFIfI4ndhCbb+67by5
 I6rhNrS9moUyTHnoyyLH73gZG8GhyP4CccyOW1TITL3ZMlbi5ZrZUt7lD/XvC/xZLH2HXZ0Cg
 w+uxD6NAKaHKHAIbJOQLpYPdJByyNPJrFM3xvteGMFPN61jYIdJ6yQtLxVuuYQqUfD8Ovz27W
 LXvfUFlv5DTuyMM/nzK7jE71ZnffwZ5jayHjJttEcv4eo7X4VQ5Gsa/K5ZlvIThlrIVAsaJpX
 FOzs/A==

The qca_spi driver create/stop the SPI kernel thread in case
of netdev_open/close. This is a big issue because it allows
userspace to prevent from restarting the SPI thread after
ring parameter changes (e.g. signals which stop the thread).
This could be done by terminating a script which changes
the ring parameter in a loop.

So fix this by moving create/stop of the SPI kernel into
the init/uninit ops. The open/close ops could be realized just
by 'park/unpark' the SPI kernel thread.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index bec723028e96..b11a998b2456 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -580,6 +580,11 @@ qcaspi_spi_thread(void *data)
 	netdev_info(qca->net_dev, "SPI thread created\n");
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_park()) {
+			kthread_parkme();
+			continue;
+		}
+
 		if ((qca->intr_req =3D=3D qca->intr_svc) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();
@@ -679,25 +684,17 @@ qcaspi_netdev_open(struct net_device *dev)
 	qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);

-	qca->spi_thread =3D kthread_run((void *)qcaspi_spi_thread,
-				      qca, "%s", dev->name);
-
-	if (IS_ERR(qca->spi_thread)) {
-		netdev_err(dev, "%s: unable to start kernel thread.\n",
-			   QCASPI_DRV_NAME);
-		return PTR_ERR(qca->spi_thread);
-	}
-
 	ret =3D request_irq(qca->spi_dev->irq, qcaspi_intr_handler, 0,
 			  dev->name, qca);
 	if (ret) {
 		netdev_err(dev, "%s: unable to get IRQ %d (irqval=3D%d).\n",
 			   QCASPI_DRV_NAME, qca->spi_dev->irq, ret);
-		kthread_stop(qca->spi_thread);
 		return ret;
 	}

 	/* SPI thread takes care of TX queue */
+	kthread_unpark(qca->spi_thread);
+	wake_up_process(qca->spi_thread);

 	return 0;
 }
@@ -712,8 +709,7 @@ qcaspi_netdev_close(struct net_device *dev)
 	qcaspi_write_register(qca, SPI_REG_INTR_ENABLE, 0, wr_verify);
 	free_irq(qca->spi_dev->irq, qca);

-	kthread_stop(qca->spi_thread);
-	qca->spi_thread =3D NULL;
+	kthread_park(qca->spi_thread);
 	qcaspi_flush_tx_ring(qca);

 	return 0;
@@ -807,6 +803,7 @@ static int
 qcaspi_netdev_init(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);
+	struct task_struct *thread;

 	dev->mtu =3D QCAFRM_MAX_MTU;
 	dev->type =3D ARPHRD_ETHER;
@@ -830,6 +827,15 @@ qcaspi_netdev_init(struct net_device *dev)
 		return -ENOBUFS;
 	}

+	thread =3D kthread_create(qcaspi_spi_thread, qca, "%s", dev->name);
+	if (IS_ERR(thread)) {
+		netdev_err(dev, "%s: unable to start kernel thread.\n",
+			   QCASPI_DRV_NAME);
+		return PTR_ERR(thread);
+	}
+
+	qca->spi_thread =3D thread;
+
 	return 0;
 }

@@ -838,6 +844,11 @@ qcaspi_netdev_uninit(struct net_device *dev)
 {
 	struct qcaspi *qca =3D netdev_priv(dev);

+	if (qca->spi_thread) {
+		kthread_stop(qca->spi_thread);
+		qca->spi_thread =3D NULL;
+	}
+
 	kfree(qca->rx_buffer);
 	qca->buffer_size =3D 0;
 	dev_kfree_skb(qca->rx_skb);
=2D-
2.34.1


