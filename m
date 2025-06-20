Return-Path: <netdev+bounces-199643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B1AE1120
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 04:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E4119E2E33
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 02:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896511993BD;
	Fri, 20 Jun 2025 02:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tYqPjCAW"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E671917C2;
	Fri, 20 Jun 2025 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386820; cv=none; b=kdc6NziqftU37WE0Sz6ZAfJqFhM3hrcbN6Q+9FidXE2cUS4jFmdVwTIt/4J72dHYaKSvt+5EMpcQNlM7eHqXU2rfxp2evYsXIOIATka9xfkuQQnPEGmIA759x8FzMiraVk2FZ6w17rxRx54VNuUsY+UNQxkNRK6T6ervi81ry1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386820; c=relaxed/simple;
	bh=XQXUqFfq3buRGME+Ywlj7bDw1KuC7eb1sCe5qRyjEzM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=I4NfoF61SI/hY2Kk0UIi2Sp7og8R3nOn6zmLZyz8cAJMYCMRs7GMyKVFgxSR00orsELYb/lY8hhQnMvHSLSHuf55c4ue5Yl9mky0XXCMdkZP7qvzKxQIqI5wAiQZn6ds7j0OLC4eBiIOZnAdnXuTn+egertu25zkcPbLxuyxVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tYqPjCAW; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1750386812;
	bh=G3jmoCnm4ZgV1ruasiCK8ltLWRVdeBzmx8JVzDyzva0=;
	h=From:To:Cc:Subject:Date;
	b=tYqPjCAW9rwyKDE9+z0xPpSt2ScV2oirU7x9wMp9kKQlHXY6YNlNghtaijsB5N0ay
	 HDW+k7H2t80XBQmpintIbdoVllP1fO3fa0YU4aGmiEa1UIFENkFRZAwDAX94vJh+5t
	 52RJ1gLVa4ebUfO0eN+LdVId6AlMzAaVdHBlb/k0=
Received: from localhost.localdomain ([60.17.1.79])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 6CEAB685; Fri, 20 Jun 2025 10:27:14 +0800
X-QQ-mid: xmsmtpt1750386434t4jzkuwnj
Message-ID: <tencent_21D781FAA4969FEACA6ABB460362B52C9409@qq.com>
X-QQ-XMAILINFO: NkuxlZMduZQq0MY1NE1qeNc+1tJeYbksRKPPIhIyZHwtwP9INkNUAHqjzbo5hD
	 Q8toCvLWfJ43VOj16ZQed4LLX2nqUPuJ66+ychz4z82Q/pnRjevD9F7DmASW9qhmGRFCei85koDt
	 IZHKp/GyeB6I8ygfS1ri1J45zFktMjrCwKeQMnPXyVO1rkI3hFCuvHiBZk0Um0I1Jam6eWFNif3Y
	 3C/Nf0RwcKJfo1H8hp50h+KXX03hvDPNLoiCtUAQ7BAhcUM08fWSj3WctuE0boCndZdqMnjFCdu4
	 3jp0FqHhG9uUtviD6q+AFfn5SRX4DSgj33rewMP6+eTTlLyNuMStyOiphifXGLr/oPIwL8OqIhRR
	 snpwqtGReuKYuUU0vZlurRB7twhkXQpy+oKAhilTrjA0b8HU8kDaNwR+We4L10O5rzKcZKty1VFk
	 qmzodmHsIvylHHSJNXPMVy0/GWo1Cq0IT/FWMB8t0g7poNO6wbhlTf1uG0Fry1C5nFtHPz4g2ff4
	 B46c7nvwrHLsWJ7BwdHXz6l7VETiUpRNjta2k8rjECBdbYmpSk59yK/yl7FEMNAXxGGZfZpC6QcS
	 lxT/PYJm94hNYoOOPOuEZBw+QtSXKuF7Aarir2vWEpXsXSFqC/NSxygkJk8JeH0R89OVq0bYoqw5
	 AiSS8IgRXKztowDBsfCtW9bCirxh2Z05+gArhTRFQsOcArg8iG4gkpY8TbDKLkhdHrNmZiZmHkcu
	 cM4Xrc1O6GQmXuPJV+tFVCSq5ItvtAPDfD20vz7tHqHfQ2GKap3YEn3MP9Q7DXV7XFjriN7skOI7
	 juZakJay2QzcUp8qUkERiNDopCra1O2SDZErYOkhVi0Xas7fg11XtK17DgKI9Yp5OAMLD9UFUuOj
	 ruQx5RlKYO/LR5mWT7yi/92fu0hqPG2Pu7UR2NIROgjiO/ptQvRAy7xjOgQKREdIIJgQYpq4TyNS
	 N74GMnu7p4nw8jtF0K//+qGi4bDEmNOTAQSihNV/B5uGCYvdkHznwLoWRDMyC8p2RSbzJzJIg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: dataonline <dataonline@foxmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Xiaowei Li <xiaowei.li@simcom.com>
Subject: [PATCH] net: usb: qmi_wwan: add SIMCom 8230C composition
Date: Fri, 20 Jun 2025 10:27:02 +0800
X-OQ-MSGID: <20250620022702.3491731-1-dataonline@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiaowei Li <xiaowei.li@simcom.com>

Add support for SIMCom 8230C which is based on Qualcomm SDX35 chip.
0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  8 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1e0e ProdID=9071 Rev= 5.15
S:  Manufacturer=SIMCOM
S:  Product=SDXBAAGHA-IDP _SN:D744C4C5
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=86(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=none
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Xiaowei Li <xiaowei.li@simcom.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index b586b1c13a47..f5647ee0adde 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1426,6 +1426,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x22de, 0x9051, 2)}, /* Hucom Wireless HM-211S/K */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E ++ */
+	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9071, 3)},	/* SIMCom 8230C ++ */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
-- 
2.34.1


