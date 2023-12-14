Return-Path: <netdev+bounces-57508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA5E81341E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF5B20A23
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EE5C085;
	Thu, 14 Dec 2023 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rnjkgg5o"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B311D;
	Thu, 14 Dec 2023 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702566602; x=1703171402; i=wahrenst@gmx.net;
	bh=SdG5JZGe1SUnpzceGIn1uNATbX/L+NGxavKwWZ5qQwY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=rnjkgg5o0xk1tdiGaiIae7Ny9xtbNA/MuWfZOIkADZQ6G+Jj6A5z9GvLgqKczWNs
	 oEFFtxnOGFiwOdf284nvA/vxF6oITUTaHCfQwxNH+jJC2rz5nv1LTVgLX0+0UI1sb
	 D905qM34i4A/2bvHUxxfeMUKS1UB00OkXqFpKNW3450+B/3JEDs1WkpgLvVmSaNP4
	 Z8B98+pSo50RkYCrdQx3iXCgkHVTWodcmUHHYzF+DSsoS5DUMMkAoyU1+e+8hxw2z
	 /cIvW/euchEaY1eyEc38A9qGHg48hCId5tkuZWj7NnyND1XbDXhBdZ+kIC/ORFjtN
	 RaWNAx9dGbVUIDHWxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1rjoic0quq-00erCe; Thu, 14
 Dec 2023 16:10:02 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 03/12 net-next] qca_spi: Avoid skb_copy_expand in TX path
Date: Thu, 14 Dec 2023 16:09:35 +0100
Message-Id: <20231214150944.55808-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214150944.55808-1-wahrenst@gmx.net>
References: <20231214150944.55808-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CxcXeQyPbzMOKEARp7hridvQcOuDtfTlK8rzBiMHXcAv0Nl/iBR
 C6GE2LFL20clk5gv3G7a9U23SmOhhR08OYxzuz8I17wEXQaKzjYA6v1i71JnNbnH9eJszG1
 p2E5XuGEPR1W0KU8w4xesla0rijqmrE8+7e2wEbToGaA6tmyw6c+MNDfSNKbc1+Nj0CWpQC
 PwGErQ24m9qUs8UGjP0Fg==
UI-OutboundReport: notjunk:1;M01:P0:d1QZxsP7/vE=;WgD8AYmF8FaDICVVm4LDQofmLj3
 Jps9N7g4huwPz70xAx86OdpnKx4ZPIEUXsfwxfyKUymUZ2YaAdxs8OyYpTVrfd8oU824wDbUg
 +jNpYXRIUFx1k+GfXGkApSl9QnK33M/ojJU2OT0J82moBSfyqzfiADch+pHMt9rdNfV2xVRI3
 kDTTUR0mgla6AFthgWdhSqDmezu7yiJOIIxiKToRihpehCmd/wg26RysNOTWQTfLE5q9b8ILy
 JA7YiqmuF+tan2q4P/yk0RNOlIUrRMYh0oRll4H/K2kbYbxYCnUNlgU737/sq5w1Mcp5XkEGy
 xofOtq5hN1cQ2mqg3lhoV2MBXyI5+rQyKSH7AMQcyy0aM0oFIaEFuiwok/rlXodd59f78Zb4D
 bT19uY65hvIteUWYWo8yXQJ6mx3v+qwUtPQqreiUbMHD0BI/TTnYgYJvlfMS91TIzs0jIbI0x
 +qrgiNrkEVmNrX8PwDNLrndSF5Ifa59dweeZaYCC7GqCyeITpTjC19e9WehMP7V6IrZrJmevv
 8YarZtaU2tQ8fZ4mCGJw+wQJ0gy1TdMKCBlxGITAnLthjU74iwPTmJKvZH0OuVrp8jp4YUCF6
 t5Jz7oNt9pzBMmRCweyWwrxPCvXM+4MoG9H+nXE1Ym6yTZd9erjbwNaxeo5mx+1AfI7Ir/+Nk
 CHlQQ/zplWozZkErQ1BUi/gvx2QcWkpH9xdg+GvizdzDIynCpCGltNcxi/QwjELiRekEIgoE/
 sSGcjpoIavQa5PV8/LjhsnEfUicPiKexSF/rrhD6kozOg1bRwXxVJEg3sNuhoD+QqOPHsz8QX
 XU0bbao1dzoHbiq9H0u7C4x5VHeFekTrvAsYiG9S9mvfbhAgQZXgOO1mVmT8JY+LihvR7mxOK
 nNR1KUHBjvyWk1z+EH1ibHGPMpI+lDG+rLw27YbNZwyosBYYLDonzofDYW5g0jZj0MBnoYRpP
 ohyURA==

The skb spare room needs to be expanded for SPI header, footer
and possible padding within the TX path. So announce the necessary
space in order to avoid expensive skb_copy_expand calls.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/qualcomm/qca_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index 88f2468ba676..f0c99ac8d73d 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -859,6 +859,8 @@ qcaspi_netdev_setup(struct net_device *dev)
 	qcaspi_set_ethtool_ops(dev);
 	dev->watchdog_timeo =3D QCASPI_TX_TIMEOUT;
 	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
+	dev->needed_tailroom =3D ALIGN(QCAFRM_FOOTER_LEN + QCAFRM_MIN_LEN, 4);
+	dev->needed_headroom =3D ALIGN(QCAFRM_HEADER_LEN, 4);
 	dev->tx_queue_len =3D 100;

 	/* MTU range: 46 - 1500 */
=2D-
2.34.1


