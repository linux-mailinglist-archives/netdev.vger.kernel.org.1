Return-Path: <netdev+bounces-100832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B58FC320
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7331F25968
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FA21C183;
	Wed,  5 Jun 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="EwG+dJZe"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074B3DABEC;
	Wed,  5 Jun 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566613; cv=none; b=jn5bTVUkCkaPdZ9gsBQWiW2Qmr1OD17PbFcryVkO6WV2xYNodZTiwGHzaqm7cxzjl11mEYVP3QGNse8Q7I61TPugA8ObKwb5CRbhqL7uf0LOfgr88emrxLBy6sS268hIvZwlstIfrV5a7lvY0H3yxoo9dMlEOK127ssypipOoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566613; c=relaxed/simple;
	bh=C6DHcioBtZO8Ft6NCOTxg1IFxOjJNDjKMUw66WUpIkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YQb3tJXwvcZofoQDzDx71ZmoG2rdEKqO12W2xOOuQAy+gxGjMSepyzqQJLUAvwTH+c9CY2rapqgjIhf6i82bnYJGpstluD9nTS1ytyfk5FzkZ9O5LsIItGQkDGA8kByrVjt35ZnsA+jVr3dRS/to+eRo7qy520+JEVdS6kLCtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=EwG+dJZe; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717566595; x=1718171395; i=wahrenst@gmx.net;
	bh=LhDKqxW6L1Ssz9fZh25QjqFX4bDiK3gZ9H644lacdlk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EwG+dJZe9AZ8h4sOdTiiUqUb55MqpyVLJfoA0J3dr9CUdsHX3lK6crSLJ0PpA4lW
	 a4+z+XAvfGdI+FG2jiPR4gNNNf397tPCfNT9Q7yD/5JzKXo42+av1YZvFPMgzyFkv
	 4OODgLQvOmav+jl7vvWhtcoQk16XOzqqFz2/Wc4fevAxMb1w6hvkpE9/5t2U66e0c
	 8DPkUlyM0Ft7ycaK99psgv6mYE7+lClCrbWGTK89XPAmvJWO/fiWc4g7a9QxA5kpw
	 Jq7KXsOEPNSzlNbsejneRH71v+1P9z45K518cvNSmqjUpKIUl2OtvezaxADssFhus
	 HSXz+fOyGmeiBisAcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1spNwf1BN4-00pKfz; Wed, 05
 Jun 2024 07:49:55 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC] qca_spi: Make interrupt remembering atomic
Date: Wed,  5 Jun 2024 07:49:39 +0200
Message-Id: <20240605054939.34870-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TuT0o4Osg9B9GIit4JJq9P9z292nEkgMNJiZFqaUKEvnfZERxhP
 HAHXOkS05v0XhlJYA6wim8PmXErup3tIbb1RApsMpkPAuxpexH9DtB872zV1XtRk6qOBL0G
 /Tj7+zesEquAkos5OYHqqjkU7qif8YgLA+AUjLORAQ9QOboLZaHqw+Ft3HBzTqC+2voC6uA
 VoBvQl21p8jVDefFHVg9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3jhrT1xqADA=;mMaBq+QuCjkH2Ph8NfOyx7ednTR
 56IF8YgBZxwgTRnyCDIJLjn/YmsyoeMatMlafB71XASkaoPDgqhXKk9pqMqEtvXBVAQH9My3o
 70wqfDMoeTom6xgy5Fe30d5KWLhRVZk5cZg7TOv93Gf2mX6aVJJ8tAaqCUGbYOcooJIF3gFBW
 0kAspYCU5MAMC50jUF/xVoWxbz/yuEq7kWb6j2QT4bRUr/5UW6KNkUyo/e9qYKzZpU2LSjPx3
 2huG8Ur96AmsRA9Hf8rbKaxqeEHznA6NzSO5Fygx5UDC3xZzRJOn8bT2THwafvIMblIPcKdQL
 k7kAF2wPUDQyFJ0wyyBKn79GxQ3UFFIXWRGdqPqFgA9nsXdvPLAR6/tKasA/yJi3hjyCoxE8Q
 thxXc6qWcxzMOaBhfo9OnI36o+jSN1vzef06uhJvgUqmPc0ZYixir2vtpKef71HPnqRp4L70T
 D2fcHHuOTD+U8IvoV9liwXjYYYfOYzHW37jQo6g0Tsm4o0ZQjmhht5he90L8l2lOSx87MEdiu
 t9tYjc813plOy2DMrp+cr92gVvGhiG4R7DMHdFmejPYnlcRDSG3XBq5OSv1GOLYxfqtdqHqHm
 /ZP3ZQ0csrOM3cdhsBJ7cvbxjM8QYsuNT1no2nFyjKdYRGsRz82jOAZ+dCGOMDf9ZRD1IPXPz
 4OzrkVGS0KXpDVd4UFvkxVo7b9Vb1j0balFTUJAvvoXnoCSkXTmjQcsKk7F0lFFw6hja3mcjC
 5MrxIKPHZc1Hhwd7/ANQq5i2Fu0RlEYief0/tPVlcUw1n+bJpRuSk/kd+UPQinBT7Svr0Satb
 JJhx45mpFb0rSo7a3w2P5+z3QA305CiwOgGhfh+F6osto=

The whole mechanism to remember occurred SPI interrupts is not atomic,
which could lead to unexpected behavior. So fix this by using atomic bit
operations instead.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c |  6 ++----
 drivers/net/ethernet/qualcomm/qca_spi.c   | 16 ++++++++--------
 drivers/net/ethernet/qualcomm/qca_spi.h   |  3 +--
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index ff3b89e9028e..ad06da0fdaa0 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -98,10 +98,8 @@ qcaspi_info_show(struct seq_file *s, void *what)

 	seq_printf(s, "IRQ              : %d\n",
 		   qca->spi_dev->irq);
-	seq_printf(s, "INTR REQ         : %u\n",
-		   qca->intr_req);
-	seq_printf(s, "INTR SVC         : %u\n",
-		   qca->intr_svc);
+	seq_printf(s, "INTR             : %lx\n",
+		   qca->intr);

 	seq_printf(s, "SPI max speed    : %lu\n",
 		   (unsigned long)qca->spi_dev->max_speed_hz);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 5799ecc88a87..8f7ce6b51a1c 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -35,6 +35,8 @@

 #define MAX_DMA_BURST_LEN 5000

+#define SPI_INTR 0
+
 /*   Modules parameters     */
 #define QCASPI_CLK_SPEED_MIN 1000000
 #define QCASPI_CLK_SPEED_MAX 16000000
@@ -579,14 +581,14 @@ qcaspi_spi_thread(void *data)
 			continue;
 		}

-		if ((qca->intr_req =3D=3D qca->intr_svc) &&
+		if (!test_bit(SPI_INTR, &qca->intr) &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();

 		set_current_state(TASK_RUNNING);

-		netdev_dbg(qca->net_dev, "have work to do. int: %d, tx_skb: %p\n",
-			   qca->intr_req - qca->intr_svc,
+		netdev_dbg(qca->net_dev, "have work to do. int: %lu, tx_skb: %p\n",
+			   qca->intr,
 			   qca->txr.skb[qca->txr.head]);

 		qcaspi_qca7k_sync(qca, QCASPI_EVENT_UPDATE);
@@ -600,8 +602,7 @@ qcaspi_spi_thread(void *data)
 			msleep(QCASPI_QCA7K_REBOOT_TIME_MS);
 		}

-		if (qca->intr_svc !=3D qca->intr_req) {
-			qca->intr_svc =3D qca->intr_req;
+		if (test_and_clear_bit(SPI_INTR, &qca->intr)) {
 			start_spi_intr_handling(qca, &intr_cause);

 			if (intr_cause & SPI_INT_CPU_ON) {
@@ -663,7 +664,7 @@ qcaspi_intr_handler(int irq, void *data)
 {
 	struct qcaspi *qca =3D data;

-	qca->intr_req++;
+	set_bit(SPI_INTR, &qca->intr);
 	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);

@@ -679,8 +680,7 @@ qcaspi_netdev_open(struct net_device *dev)
 	if (!qca)
 		return -EINVAL;

-	qca->intr_req =3D 1;
-	qca->intr_svc =3D 0;
+	set_bit(SPI_INTR, &qca->intr);
 	qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index d59cb2352cee..8f4808695e82 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -81,8 +81,7 @@ struct qcaspi {
 	struct qcafrm_handle frm_handle;
 	struct sk_buff *rx_skb;

-	unsigned int intr_req;
-	unsigned int intr_svc;
+	unsigned long intr;
 	u16 reset_count;

 #ifdef CONFIG_DEBUG_FS
=2D-
2.34.1


