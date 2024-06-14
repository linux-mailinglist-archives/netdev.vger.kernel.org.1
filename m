Return-Path: <netdev+bounces-103644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAE908DDE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250C02822AA
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E58BE65;
	Fri, 14 Jun 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mkbY3dCt"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BC3E49E;
	Fri, 14 Jun 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376663; cv=none; b=k8X5QMj5roYnoJoGtXZx6ZziA5WiRj/e66on5/qGY4GBTngprDEfe13gSTJ3Mnh28AHI1s1C+Sl1KinPvPQVEvkKS7A9qGLBxYvLy2bofncUYCQZKOfxsod4f0wuRfFJdiBKozRzkioHJGHO4UN6dg34HLXQJalrebkxhy4VyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376663; c=relaxed/simple;
	bh=sri2A0ayJbrzdKWKAvmUFe3YY4mrTnbaZ63M+nVED+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ovhny6r4RPq+LbgPGWcKzUXq3zQxYAyZmrEWwctr2mm/WuA+V0mVwHT6YJmGUP5gCGSX1uI5h3Nsm6fq1JRkJqCfNQGby6qhgvXRK5YfNA35gOMNZdrIhnne48WASJnXl7UvuW6x40jDNgYaqJrOwSd7NFU/stW9l1fGGk9bovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mkbY3dCt; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1718376647; x=1718981447; i=wahrenst@gmx.net;
	bh=WulOT9HA+qRUhT4J0i1kdDLEP5zluj749l5FNLCA2Kw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mkbY3dCtIWFqjkwjHu/YykC455R+KGYJX0yUk5XT2uqcASa6PwC6N9UDatFvwEuS
	 ra8pAXeUFvKCzhnXRR1aQYYTcen6chn4/kKagvI+OSCM29baKY/J2eRsL/8+Jcofi
	 CDuQWnd5SFQeLULLXOD2kkIR6yBuHuCWCBnhtHjjRlONGJShOauihwv5ZAQTPrVeE
	 cOBw0ONdVH2JSKcM2tWvRXvIo39HbAv2Y8KGP4a8qtFLvJiMvKS4XfpmX6asrymTT
	 RoARGsTstBQI7V4avvZJcVYXQXWRy7NKGBgITXlEV0274hXNroMDjn3+ZARW4Fdqf
	 fYdQmjt4RfrWodJkxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9gE-1sARhq3wUe-00GCDd; Fri, 14
 Jun 2024 16:50:47 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] qca_spi: Make interrupt remembering atomic
Date: Fri, 14 Jun 2024 16:50:30 +0200
Message-Id: <20240614145030.7781-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MMIjMJkZN5H/uxDjyYuJvGeNKkDIiI9uqnUSl8xlTxjyPR/WdVD
 AZrP792t7Syo+HPwIzU48uQhsasl9K3UNWVOet4IOYQ7TPRii+cAazHVWhFzdyildvQYHAi
 OwXAzR7qgRWkcpCjLuw7fSR8UQWxPW+yUQRgUzhKMNUD9wWUPleKiAG5hD5aQMXmZeVE/Wf
 8emea0jLQUpW6czQ73dTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QKGSz+3Uq9Q=;Th4U6teX93NJ3IGoWxWmTQHrGik
 UdQltb5tqGoF/om2W0r6W9qTkTjKRRLhCkSUmE8kD7GUBfl7t97lD5Xhv3VZbhvo7JjRwZ/ev
 mhfBz2snMo7ScC4tKxNh5p1malrajZWxPooWKM+oiXJ3L7W5FCN6JT1bpkMxW4vM6ogAe0UB9
 87SZF1E6a/8aqkghRnPokbIQni1AHNVvrFO+fUJ+YSYXU3LBRpaz672q+1ggPL+oxxy9LJflR
 ACI0fJ/blV4ZFXeJv2msWNXqoIbFunZudmLUm3DdtazvLGPx+0L9zS/Gdxik3qx52bKFa6BvI
 oppCMxrEGCadWSUc7EsSXThFM+EtjglGlLBytvOT0h3VJfTC2lb+1UqZR6qytQ8QNdUqYuL8P
 M03GvRmYHoqWgQrTyTucXSUl6k6PfnVzpV99QCJPN6C3RNpSk7GoyNTWuVfx5r9m+hHbyKFIA
 uT2uxmOTE23NyDZRpybx+rDGaHCRsuGoyh9vIffUuIbW49gYcCdicbuQFD/P2uTvj22NktDg1
 QXKf5h41BdHzJU5aYNuBforsXwDiw7bfHMZ+pqjx5B7saXj7R7ZzpGH9ZOZJ3cpJyBSy7mHor
 HFk+lb0cBF6FF2F6nMIb0XBGYffmKGk3v+VGYcVZnz/VvzC1xwmBsnB28zYcY35zkuLr1sVf8
 8LRR06v3jyRJmZvKyMXcS+LH4PscRtwWYcYgIFVJecAH0QSXE54PTkURwMuysAovfYbJ/OgUd
 xhIngupMyjHTjcXYBj2VXAOcX18OQLS+SuFXuyneWievBppmCjcr/5Vi2mLarjPhX8dpZJEew
 8rXqus3Ul0LIsuDPBfHEpc637+U5J7VTunh2VBc+VZGxk=

The whole mechanism to remember occurred SPI interrupts is not atomic,
which could lead to unexpected behavior. So fix this by using atomic bit
operations instead.

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7=
000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
Changes since RFC:
- No change, just resend

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


