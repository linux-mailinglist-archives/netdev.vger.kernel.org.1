Return-Path: <netdev+bounces-189222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA0CAB12CD
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6A3A5943
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD754268C69;
	Fri,  9 May 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Czfk5M3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE01A2C3A;
	Fri,  9 May 2025 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792094; cv=none; b=rjZwWb/K2Hgc58KjQas5+5fHmOCJsxVwEc17J+fpiSQnsQ9pkNILuA8nHx/OcbQonAfHUVY9j9US5K6fY5giH/M8ifyiKEtX3WE4FRwtH+KAA8IaGTgnOVHw805OataRYy4dy7SoHOO9UEfOLzaq+Lp1M1ujJBlLZbK4L63h8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792094; c=relaxed/simple;
	bh=ZHYdH6Cjd2ni/INiqSaFkkwBq9QJrWol4zYm1bSxO34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lHe1MRwYEVjzBtKCPfaI87iyD7MJIYNhMbt5E3yXz77y4PI7DTGYgBjIN5pA1H7zDV1YVqJWpYVWgsYP4CBzWWnIMV4Y0ZgPwt16+K5s/oFi+40d+zbcVxxNZ0faN+8ofL0p5wIQ9EDJtjne6n/0N0EiGoXEQ+9Zjuzyl9B8Rr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Czfk5M3Q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792090; x=1747396890; i=wahrenst@gmx.net;
	bh=LFXqYk180vc4BWrbIG8j8Csao+70h4RA417Ern7Ps/8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Czfk5M3QTB+lKl3jGIdo9euxY8xBuKO7tE587+d/xQlbVNOYJ6DxHxly6HL2Tf0x
	 ixOzGudTmWJ4C/iIQvaHD3Q52NORB+NMSullbl6VwHFG2ZPGpxd1C597zQI1svndc
	 ytDUD/ZZBD7djYRCbz8jrBUWR0sCTMeLZger20FnQTaTOAOwULQQkR0kGVsaLJ/qZ
	 HYGFj4pw9K+eLuRkeqwa19dnOKMZfrIuAdWd2SBnAAqhr/9RqclVeC/iKeK6afZug
	 3hgygdSRWHyHDxxKHIK9QHiXazUI2fWcNvtZbr7sdm9I3Rk4kqTRiGmHurVkzYcQi
	 vREJ6DAJoKwOCkZFCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1uxdL712vD-014sHZ; Fri, 09
 May 2025 14:01:30 +0200
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
Subject: [PATCH net-next V2 4/6] net: vertexcom: mse102x: Implement flag for valid CMD
Date: Fri,  9 May 2025 14:01:15 +0200
Message-Id: <20250509120117.43318-5-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:7LnhgWlf0qdQshLn2Yp9k03d8UkUCblCoQVf/1cF7cdMHpJ/9sG
 8lq+pYno3ELydvGOhaqOQ6nWKIrkooGyQuNOyubPFfUHUx2pUY+g2OY6DDfht98N35FnYkr
 1wx0hA5ZTD1gKZchP5xSOsAFJ4TkKFCqVWceuR1+6xBhE/hH7LFKMbKkG1ymp1ShvZUFRzY
 lx/3Kwrniq6/aJBhDHGtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2f7ERuVY86s=;zcO7IKpkDOaoz2b3D4G81FV57fH
 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

After removal of the invalid command counter only a relevant debug
message is left, which can be cumbersome. So add a new flag to debugfs,
which indicates whether the driver has ever received a valid CMD.
This helps to differentiate between general and temporary receive
issues.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index 954256fddd7c..c2b8df604238 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -17,6 +17,7 @@
 #include <linux/cache.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/string_choices.h>
=20
 #include <linux/spi/spi.h>
 #include <linux/of_net.h>
@@ -84,6 +85,8 @@ struct mse102x_net_spi {
 	struct spi_message	spi_msg;
 	struct spi_transfer	spi_xfer;
=20
+	bool 			valid_cmd_received;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*device_root;
 #endif
@@ -97,16 +100,18 @@ static int mse102x_info_show(struct seq_file *s, void=
 *what)
 {
 	struct mse102x_net_spi *mses =3D s->private;
=20
-	seq_printf(s, "TX ring size        : %u\n",
+	seq_printf(s, "TX ring size            : %u\n",
 		   skb_queue_len(&mses->mse102x.txq));
=20
-	seq_printf(s, "IRQ                 : %d\n",
+	seq_printf(s, "IRQ                     : %d\n",
 		   mses->spidev->irq);
=20
-	seq_printf(s, "SPI effective speed : %lu\n",
+	seq_printf(s, "SPI effective speed     : %lu\n",
 		   (unsigned long)mses->spi_xfer.effective_speed_hz);
-	seq_printf(s, "SPI mode            : %x\n",
+	seq_printf(s, "SPI mode                : %x\n",
 		   mses->spidev->mode);
+	seq_printf(s, "Received valid CMD once : %s\n",
+		   str_yes_no(mses->valid_cmd_received));
=20
 	return 0;
 }
@@ -196,6 +201,7 @@ static int mse102x_rx_cmd_spi(struct mse102x_net *mse,=
 u8 *rxb)
 		ret =3D -EIO;
 	} else {
 		memcpy(rxb, trx + 2, 2);
+		mses->valid_cmd_received =3D true;
 	}
=20
 	return ret;
=2D-=20
2.34.1


