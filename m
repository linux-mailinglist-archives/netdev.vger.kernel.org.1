Return-Path: <netdev+bounces-31924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FC79171B
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F5C280F05
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A51844;
	Mon,  4 Sep 2023 12:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BE15AB
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 12:31:47 +0000 (UTC)
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0281AD;
	Mon,  4 Sep 2023 05:31:43 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id DCEE01866DC1;
	Mon,  4 Sep 2023 15:31:39 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id E-o2_fIMavx0; Mon,  4 Sep 2023 15:31:39 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.astralinux.ru (Postfix) with ESMTP id 79DAA1866B11;
	Mon,  4 Sep 2023 15:31:39 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
	by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l5JBjWF0Ddkc; Mon,  4 Sep 2023 15:31:39 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.71])
	by mail.astralinux.ru (Postfix) with ESMTPSA id 237F01866A24;
	Mon,  4 Sep 2023 15:31:38 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v4] drivers/net: process the result of hdlc_open() and add call of hdlc_close() in uhdlc_close()
Date: Mon,  4 Sep 2023 15:31:30 +0300
Message-Id: <20230904123130.14099-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7b8be7bd-baf2-15c0-2a0c-ddf64839a451@suse.de>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Process the result of hdlc_open() and call uhdlc_close()
in case of an error. It is necessary to pass the error
code up the control flow, similar to a possible
error in request_irq().
Also add a hdlc_close() call to the uhdlc_close()
because the comment to hdlc_close() says it must be called
by the hardware driver when the HDLC device is being closed

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v4: undo all the things done prior to hdlc_open() as=20
Jakub Kicinski <kuba@kernel.org> suggested,=20
add hdlc_close() call to the uhdlc_close() to match the function comment,=
=20
add uhdlc_close() declaration to the top of the file not to put the=20
uhdlc_close() function definition before uhdlc_open()
v3: Fix the commits tree
v2: Remove the 'rc' variable (stores the return value of the=20
hdlc_open()) as Christophe Leroy <christophe.leroy@csgroup.eu> suggested
 drivers/net/wan/fsl_ucc_hdlc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdl=
c.c
index 47c2ad7a3e42..fd999dabdd39 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -34,6 +34,8 @@
 #define TDM_PPPOHT_SLIC_MAXIN
 #define RX_BD_ERRORS (R_CD_S | R_OV_S | R_CR_S | R_AB_S | R_NO_S | R_LG_=
S)
=20
+static int uhdlc_close(struct net_device *dev);
+
 static struct ucc_tdm_info utdm_primary_info =3D {
 	.uf_info =3D {
 		.tsa =3D 0,
@@ -731,7 +733,9 @@ static int uhdlc_open(struct net_device *dev)
 		napi_enable(&priv->napi);
 		netdev_reset_queue(dev);
 		netif_start_queue(dev);
-		hdlc_open(dev);
+
+		int rc =3D hdlc_open(dev);
+		return rc =3D=3D 0 ? 0 : (uhdlc_close(dev), rc);
 	}
=20
 	return 0;
@@ -824,6 +828,8 @@ static int uhdlc_close(struct net_device *dev)
 	netdev_reset_queue(dev);
 	priv->hdlc_busy =3D 0;
=20
+	hdlc_close(dev);
+
 	return 0;
 }
=20
--=20
2.30.2


