Return-Path: <netdev+bounces-132649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2378A992A44
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C410E282756
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF21D1E91;
	Mon,  7 Oct 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="g4uUvBUe"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D1101C4;
	Mon,  7 Oct 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300827; cv=none; b=TEMKATMjmcjGnUhkdHO2MqlBr8Sy1OaxuTIf2pjUoC/3p4s/L4vGo6kBlUJW9IHDQp+vI4cy/30tCADXSWMA30Fsa0L7CwPc+Xq7I9cNy8ovRx65B8eUME/kRYy5gFOF5iDKvumm6gjQOCwtxxuc/2251I2GsLlL0NZslf38NgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300827; c=relaxed/simple;
	bh=62QDIxmSWTrnrXu44YKt8uHSPpZYXk71NEfzgPe03jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNa2A5I63tx9vL80l6kbu4gzOY+01EtvOmlORyqwviFIIH90ad5+oZEny6ek/pildyslboM7ZbY+lh7qV7UI542R0DNorRsYqIBkYFx6TDU2vtVL8dMwQewnj8lgHYdIzD4TGppo2w81jlpAPG2dC6sfD1/Ig8mjAAXw+YfMRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=g4uUvBUe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728300810; x=1728905610; i=wahrenst@gmx.net;
	bh=pvflpRRcQ8zmpRqzWFEb37Up3Laahcfpm5VEYL3qNDE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g4uUvBUeqCc/nbd4gTmwA+s33kKS7jwjOCCbkLjxdumaFvk4QyJ30EFkwX4Ll30K
	 S066eFheieHVU1plU5YNHEBDJqCOhBoxLJU2lj5eil4wADJegVkUdu3Uqv28n9lGx
	 2diXr79qKtzD5yDKNRP8BekZePc/EBCkpMw+byxSwDYBrPmwiWe4M0wTuiMmrlyiM
	 R8rpN7gpc6TcCYgsYUFxxI5FY5TnyBUz2l3uTs8FEusIQzg2EaHel+2YPFLvok3iI
	 vs6aJY42yj3fnRoVxuNLGjYQtb8J79hWS16R/ZgeIk3Ex0+r2A+LShfH9QYbdCviR
	 ngei87uKq0AoDbI9bA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1tqq9O4Amd-00qycG; Mon, 07
 Oct 2024 13:33:30 +0200
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
Subject: [PATCH 2/2 net-next] qca_spi: Improve reset mechanism
Date: Mon,  7 Oct 2024 13:33:12 +0200
Message-Id: <20241007113312.38728-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:NPLHNP9KVStcNrSSuOhvb6jeipujIrljpji5fCC5xNiGlz0MhJg
 9wCiexBaZw0abPtkRWq13BViY+r6qWIpMElUhzO0xYVp1KQv5pLBNbTh5WCn9vPkDjeZ9lw
 XdrKkUU5lvCjCBz32UqBlP/XUV2bKYarm3FD7i6q27U9XsdzJMV1gikiqhDpGPUn0Fb+c4a
 d6bqg+sGNYEpKLqift1jQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hGq4UUDKIts=;4mlIJuK1aIibPwE7Gs8Y+IO+EYx
 XDw2rwaqK0EsuVxgfDQC5RN0Xngqe+R6WVLhFsixbRbo82m/eQAzH4VeUEmuRJGs9/ZVdl8G2
 smYEmABPc9yIDkT8oq6VIvm/OX3BrsqhR3nkOljfXBg1Q4FCD2lEmH24ZGvcBoHPfkmXCTWVb
 8lS47oQVe+7pSh2WvrWyDDqRy42NPsrSQmXiNUdWbCaE0vrjoHLeyO/+MALLNH6kwq+/tPAFb
 zY4IZu/VMWJkOe79hOnXLMQGxUHtUhkhyx57NOYi4iij8DthsoIQFkjxyFfXg/KDXKab/f6Fs
 q8Pg1rEcsKfIxrJIa6UQb3P2sJ3sHCZTuNknuwTLnDX1OGzSxCkMGzwVX+jWi09CLtgcsGNTA
 QZttXoV6+2yct4B/c+2KHu4ctZ3xDmQ+4d79ED/VnPz2VC8gAvoqQlW/VAZtNMJ3r8M6UTig3
 UvScB2egYmdShtv6+r/F/QQCSgydSQY0ui/90v1+q1AUR7W2Uh9CXLCCm2GE1CAL5C63rjJqs
 UJ5nW+l2BqbpdvaM7aQnRG3s9tGveIiN/gcuzFRhGwtbi/p/4pjHlVNvE/PWdR5teggsJd3QV
 IfKI0Ay70MafK7VvTIcu5wEgQgcMRrD7ATUOjjT+SnNtvhoMbroQO26ohcGZncclbK0JHFiRn
 BuKGWJtuXyNi2xn9O5x1NLPdmIlFZmlree6Jec29XiZocLzlqINej1FfCslHIAC0fXCgLMzXI
 JDCsNVlnaYCiQmziKQ3q8q3BEaP7546a+D5GeJmJobeG3M76Pl64OfWBeJiA4/8lspqJK2s7c
 wanTQFXo01PPtAMYYqGmyFoA==

The commit 92717c2356cb ("net: qca_spi: Avoid high load if QCA7000 is not
available") fixed the high load in case the QCA7000 is not available
but introduced sync delays for some corner cases like buffer errors.

So add the reset requests to the atomics flags, which are polled by
the SPI thread. As a result reset requests and sync state are now
separated. This has the nice benefit to make the code easier to
understand.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_debug.c |  4 ++--
 drivers/net/ethernet/qualcomm/qca_spi.c   | 29 +++++++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h   |  2 +-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ether=
net/qualcomm/qca_debug.c
index ad06da0fdaa0..13deb3da4a64 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -98,8 +98,8 @@ qcaspi_info_show(struct seq_file *s, void *what)

 	seq_printf(s, "IRQ              : %d\n",
 		   qca->spi_dev->irq);
-	seq_printf(s, "INTR             : %lx\n",
-		   qca->intr);
+	seq_printf(s, "FLAGS            : %lx\n",
+		   qca->flags);

 	seq_printf(s, "SPI max speed    : %lu\n",
 		   (unsigned long)qca->spi_dev->max_speed_hz);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index fde7197372fe..b8fa6c56104e 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -35,7 +35,8 @@

 #define MAX_DMA_BURST_LEN 5000

-#define SPI_INTR 0
+#define SPI_INTR	0
+#define SPI_RESET	1

 /*   Modules parameters     */
 #define QCASPI_CLK_SPEED_MIN 1000000
@@ -495,7 +496,7 @@ qcaspi_qca7k_sync(struct qcaspi *qca, int event)
 			if (qca->sync =3D=3D QCASPI_SYNC_READY)
 				qca->stats.bad_signature++;

-			qca->sync =3D QCASPI_SYNC_UNKNOWN;
+			set_bit(SPI_RESET, &qca->flags);
 			netdev_dbg(qca->net_dev, "sync: got CPU on, but signature was invalid,=
 restart\n");
 			return;
 		} else {
@@ -512,6 +513,10 @@ qcaspi_qca7k_sync(struct qcaspi *qca, int event)
 				return;
 			}
 		}
+	} else {
+		/* Handle reset only on QCASPI_EVENT_UPDATE */
+		if (test_and_clear_bit(SPI_RESET, &qca->flags))
+			qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	}

 	switch (qca->sync) {
@@ -522,7 +527,7 @@ qcaspi_qca7k_sync(struct qcaspi *qca, int event)
 			qcaspi_read_register(qca, SPI_REG_SIGNATURE, &signature);

 		if (signature !=3D QCASPI_GOOD_SIGNATURE) {
-			qca->sync =3D QCASPI_SYNC_UNKNOWN;
+			set_bit(SPI_RESET, &qca->flags);
 			qca->stats.bad_signature++;
 			netdev_dbg(qca->net_dev, "sync: bad signature, restart\n");
 			/* don't reset right away */
@@ -553,7 +558,7 @@ qcaspi_qca7k_sync(struct qcaspi *qca, int event)
 			   qca->reset_count);
 		if (qca->reset_count >=3D QCASPI_RESET_TIMEOUT) {
 			/* reset did not seem to take place, try again */
-			qca->sync =3D QCASPI_SYNC_UNKNOWN;
+			set_bit(SPI_RESET, &qca->flags);
 			qca->stats.reset_timeout++;
 			netdev_dbg(qca->net_dev, "sync: reset timeout, restarting process.\n")=
;
 		}
@@ -582,14 +587,14 @@ qcaspi_spi_thread(void *data)
 			continue;
 		}

-		if (!test_bit(SPI_INTR, &qca->intr) &&
+		if (!qca->flags &&
 		    !qca->txr.skb[qca->txr.head])
 			schedule();

 		set_current_state(TASK_RUNNING);

 		netdev_dbg(qca->net_dev, "have work to do. int: %lu, tx_skb: %p\n",
-			   qca->intr,
+			   qca->flags,
 			   qca->txr.skb[qca->txr.head]);

 		qcaspi_qca7k_sync(qca, QCASPI_EVENT_UPDATE);
@@ -603,7 +608,7 @@ qcaspi_spi_thread(void *data)
 			msleep(QCASPI_QCA7K_REBOOT_TIME_MS);
 		}

-		if (test_and_clear_bit(SPI_INTR, &qca->intr)) {
+		if (test_and_clear_bit(SPI_INTR, &qca->flags)) {
 			start_spi_intr_handling(qca, &intr_cause);

 			if (intr_cause & SPI_INT_CPU_ON) {
@@ -628,7 +633,7 @@ qcaspi_spi_thread(void *data)
 				/* restart sync */
 				netdev_dbg(qca->net_dev, "=3D=3D=3D> rdbuf error!\n");
 				qca->stats.read_buf_err++;
-				qca->sync =3D QCASPI_SYNC_UNKNOWN;
+				set_bit(SPI_RESET, &qca->flags);
 				continue;
 			}

@@ -636,7 +641,7 @@ qcaspi_spi_thread(void *data)
 				/* restart sync */
 				netdev_dbg(qca->net_dev, "=3D=3D=3D> wrbuf error!\n");
 				qca->stats.write_buf_err++;
-				qca->sync =3D QCASPI_SYNC_UNKNOWN;
+				set_bit(SPI_RESET, &qca->flags);
 				continue;
 			}

@@ -665,7 +670,7 @@ qcaspi_intr_handler(int irq, void *data)
 {
 	struct qcaspi *qca =3D data;

-	set_bit(SPI_INTR, &qca->intr);
+	set_bit(SPI_INTR, &qca->flags);
 	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);

@@ -681,7 +686,7 @@ qcaspi_netdev_open(struct net_device *dev)
 	if (!qca)
 		return -EINVAL;

-	set_bit(SPI_INTR, &qca->intr);
+	set_bit(SPI_INTR, &qca->flags);
 	qca->sync =3D QCASPI_SYNC_UNKNOWN;
 	qcafrm_fsm_init_spi(&qca->frm_handle);

@@ -800,7 +805,7 @@ qcaspi_netdev_tx_timeout(struct net_device *dev, unsig=
ned int txqueue)
 		    jiffies, jiffies - dev_trans_start(dev));
 	qca->net_dev->stats.tx_errors++;
 	/* Trigger tx queue flush and QCA7000 reset */
-	qca->sync =3D QCASPI_SYNC_UNKNOWN;
+	set_bit(SPI_RESET, &qca->flags);

 	if (qca->spi_thread)
 		wake_up_process(qca->spi_thread);
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h b/drivers/net/etherne=
t/qualcomm/qca_spi.h
index 8f4808695e82..7ba5c9e2f61c 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -81,7 +81,7 @@ struct qcaspi {
 	struct qcafrm_handle frm_handle;
 	struct sk_buff *rx_skb;

-	unsigned long intr;
+	unsigned long flags;
 	u16 reset_count;

 #ifdef CONFIG_DEBUG_FS
=2D-
2.34.1


