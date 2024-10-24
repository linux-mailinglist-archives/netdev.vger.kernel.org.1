Return-Path: <netdev+bounces-138716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A99AE9FD
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924FAB25B25
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7981EF927;
	Thu, 24 Oct 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="goYxWV3v"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C391EC01D;
	Thu, 24 Oct 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782697; cv=none; b=KDYHqNRKy4YeODSxCOz12kN9MEWZmIyr3mKsTetB6CguQclGtVxLjVKFuXM8Sd/GGiuQBseeYRqr9uuzpGMaPx3JPkTCHhcB9VeN7WipJI8s3qmhQbUp3kP+56i/ncCHfx53/MIC/hyBmhShN9Vkjmmq/JOnCUXJjUBB0RtIPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782697; c=relaxed/simple;
	bh=kupkq+e0iXwoyEx+Mu/kldwf8T6QO/wDfPkuWUHdpWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b38tGRfpejwHPQcBDz4ejvl9cyMp0A7uX0I8RiXEHGf75sSP8rzcYlKB98R97qT0XMSYGMVPz+tK9UmXwHlCxQvW9tzgKCCdOkmHCL8yvBoCaqpjcYmvnwoe1v4wXfjr7mb1+GepooGeQArOR8chzrp3l5gPPb1Na973BBd5c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=goYxWV3v; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1729782676; x=1730387476; i=benoit.monin@gmx.fr;
	bh=h5r7XlNzCKWUXlhx2b6D+ImaHyu9K2mtKbQlo6p47pE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=goYxWV3v8zKbox0ZhWAeFTAV9qcOnLTw1PAK2ymprishR43fnggh86ry0ddK+v1e
	 /KdheEkm4PZUOtRlMaEpkjeBmsPmEKLKJe5udqTbpl+BFVPc3PSEUT7fbQ1u9O4vC
	 bgBnOTzXydiAiGg6C1hA9cvxQbwOGDS0ib/vpQ3YJpzBIdcUuBwX9/Fc6kwJjOD2l
	 SdhEZHC7JXtRugEx3fXfa9ZEMFJRznqWW7u5rbojiEeEhnh3XE+1d/8onErtoQjzK
	 7aNBvh7Jb1cq3nLFKuOaZVJ4nJkZISOsFO9uwVEiNWZKzUUTty7qGvA+OxCs4Bz3b
	 WDxkR8ttXXlbewBexg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1tOXSG3Yw3-00PNjA; Thu, 24
 Oct 2024 17:11:15 +0200
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
Subject: [PATCH] net: usb: qmi_wwan: add Quectel RG650V
Date: Thu, 24 Oct 2024 17:11:13 +0200
Message-ID: <20241024151113.53203-1-benoit.monin@gmx.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SoRCAwhh/gT1I0eJpud+LzerQvoUSVq4SKYdpFyeNZ2ddxstT4h
 M8yJitFp95yViOgHaYoeaLHaqY+Q+e4XO2isOLss+pcf1kPH4n6stvv6gx8mIMeKxcQ2J1o
 SBfKf20Y/n9HilZ99PE+lkMScGXMu8UDUcOz5QKILeqEzK6L+6IlokLAhFTq7JwunS52e+M
 QnQvCJ1L2XTR35jVsAVXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aS/qKiG/jn4=;ju14ffzvFIklat2khKgaHYdA3Vd
 r74zdrPbaVrSVfu4uiESo6gppmha/+cCknsEBZtymEWPl8Y0ndOshGDe/ccXdkQRgeE86HWZ6
 n/ETtorimTCUnowh2zSxvMZGT6tHUlj5uGgxqMapEU+q45Xai8NRqCSgunSKfGjE7f1IVfq4H
 2WWPVIWWE54sv54H32tBsXRPQI3O4ejBe0tpr3k5k0+iGMAudlK7r5BlVxUtMH3EdCQOXtYcH
 A30dA3EAnN6nkBaltKt1oHHrq/lRrwYZ6u+nJ2sGpLcv+iRLhDntHLB5D7Rmbjn3jJl67scz6
 t+eG+0voClLrYMZcKkhKObZZxXbE5vdPQtad3K96gm3vSHNdoEhLbQwr50vxtJkG65/aBspU9
 XKOz7RedNJOY84uNVWNy+TE/3EN2Hm1I6NQ+KefiH5s21oS+KafrCZu1ptqYsInbSBMiYk0cF
 tLqnYPn4Pv8e5eJCU8ZYFXtLtmJ6eC3I4uvLpt7e5BtcFVyrTEBtKPVhrxQ0JArv/mlDMTNRm
 DR3FQzX7XRagywLG9XuDumORwkhRfDzNsVrr8e4bszWFjNOiHUUMu7viUhYpAz4C00Fl0SUQp
 g8pYcrsCK2RjlQVRmav3YjgvlLUkx5oJvILUoiOuU57su1ANoD2WMCIBQ9hqZR+irTdrr2BEo
 MMLtdPkILWq+qOoLnJuyuVFIX6cHdvpIl8nYILKSILVINYgEceeH7W75xrBk/fbD8oRTBkF6R
 o5LIB+FHfJn2LwPo5umuD6Row4hGg5haHdR0e0o7SdIG/52JZjrUk5wxhftFA/Vmeo7f0+EXX
 dr5rf3bbv5Ml0Mc/glzl3vZD67n002hTG3YpPR0EkQW68=

Add support for Quectel RG650V which is based on Qualcomm SDX65 chip.
The composition is DIAG / NMEA / AT / AT / QMI.

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D01 Dev#=3D  4 Spd=3D5000 M=
xCh=3D 0
D:  Ver=3D 3.20 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D2c7c ProdID=3D0122 Rev=3D05.15
S:  Manufacturer=3DQuectel
S:  Product=3DRG650V-EU
S:  SerialNumber=3Dxxxxxxx
C:  #Ifs=3D 5 Cfg#=3D 1 Atr=3Da0 MxPwr=3D896mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D30 Driver=
=3Doption
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D9ms
I:  If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D9ms
I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dqmi_wwan
E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D88(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D9ms
Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
=2D--
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 4823dbdf5465..2b84d7211b13 100644
=2D-- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1076,6 +1076,7 @@ static const struct usb_device_id products[] =3D {
 		USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x581d, USB_CLASS_VENDOR_SPEC, 1,=
 7),
 		.driver_info =3D (unsigned long)&qmi_wwan_info,
 	},
+	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0122)},	/* Quectel RG650V */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini P=
CIe */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0306)},	/* Quectel EP06/EG06/EM06 */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0512)},	/* Quectel EG12/EM12 */

