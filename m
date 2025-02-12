Return-Path: <netdev+bounces-165576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E60A32999
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B41F7A0F6E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61021128B;
	Wed, 12 Feb 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b="kz9BXHLv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1E205AD9
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373124; cv=none; b=EAxb/ZuraABM42cjOOF18bA26bfCASpUEoN7hEPvP3Q8B9i0S6Ns4jBALS+FqI2iN5QmHehVhUJXj7hjSmsgPB1cJr4Xr6DIP22xD3/9jlstOZccpnVIUd+51sT4mnOU5TxoibOrf2KuKS04DpXQ/guBCREUhCsw7k5cTrmjPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373124; c=relaxed/simple;
	bh=iYYgOVh/wMPRfKLMkmfkwGvXX3aTI7asNbgiuPtLu7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWW9Q22yDtJ/RGdq00QJZPThYGDU4/XuWAMiTVMFHWUNaaeoIH8WnliXRW7FkiTXTMCWY+6jLw/ZWstM3xeayBU17Nbeoj7TtwNwEDOh2Q+x77sc9byuxfQl5Dt/fDZZqbi0X5Y82v0GIYtQRlyoTpHSAX7CJ/5i06u8CTI4T2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=max.schulze@online.de header.b=kz9BXHLv; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1739373110; x=1739977910; i=max.schulze@online.de;
	bh=69iOg/ICZX5QDn2FKF/ks/dYJcXUBDzwvR/qt3V+nNg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kz9BXHLvd7Flo9CkJD/itQxMUI9zh9C0HwNKPCxH48bxpPSplMdO+rGSxtnxz4Sy
	 j+P6ymb6SZr8TKxBjFLOkT+IPbVFpbencFTtiTueNIYw58/7e9gdTYTWteLwPktvd
	 4JCNFqdLW63nCL/z8nOF0mOg64MNgJcVa24xAI/OSLrn+m7puChLcJikc4c16gvsj
	 mWsbJgmlhOtiWKFtbX+gGipFwZFN4I9mOuCEtSXjwRuQ3BJ21zRS6nuhJstS4zhxm
	 +MuftuHQMa40Bon0qvh1ajnEGoFSFqfwbKqxOfRkx1HN1tbyZdrbr6xnr8y7NVCCu
	 hLcnPZm3a6peN0egYw==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from ubu24desk.fritz.box ([84.160.55.49]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7Qkv-1tJ5Kd0WIX-00w0Qq; Wed, 12 Feb 2025 16:11:50 +0100
From: Max Schulze <max.schulze@online.de>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch
Cc: Max Schulze <max.schulze@online.de>,
	David Hollis <dhollis@davehollis.com>,
	Sven Kreiensen <s.kreiensen@lyconsys.com>
Subject: [PATCH net v3] net: usb: asix_devices: add FiberGecko DeviceID
Date: Wed, 12 Feb 2025 16:09:51 +0100
Message-ID: <20250212150957.43900-2-max.schulze@online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126114203.12940-1-max.schulze@online.de>
References: <20250126114203.12940-1-max.schulze@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FpQOv4c81lDl0TY7hu4HmoYJXfhtj5eMm0a+IF0S/wTTHXdqqdO
 H68pxB94g7xeiaEKbOn+3RgaYDx4k7rS9rxAGwzoQg0Aqe3owoN9CHrmdBZKdad34gv6Qjy
 di4MDdKWYI2I+G+bM5ea2EuTqAUnr/BJRrPLOvUt2XrWjAKNDOaPabLq+H/hzZrMIsiXQc5
 RSNB8N46LfAnGdRxImzag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AxDoK1LWJpM=;tV7ojFVKSpd3BJCmVkPZnYb/Wuv
 tGmwzKkC3YzuHoLTR624M3q9dNnZIb9RGfkTuJlqSy9SAOCaGFmhkPryO4oBuWx1k8ZTt/kWc
 9Oc9PQ9QziyFGc1+27g4BFH1sj0RzVJCCwyeW5f2nJQptNQ/EZujHDkn3slFS53YD9X7npBZj
 OW5Cny5essFtNW+hGo4ZNY4biPpEj+SPoWtNQwW1YWEMGc5+aeVeTpVp2Qkb2NUINSuXlTqPP
 uDTDjABPLqL2oHtyE5BHq9zc0xPP9uKf0uRc6Ikkd9vO6D9OcQJj2+lO1tq//eTVpl/ql9RHU
 nTgo96yMETsBTZK69xWqgcB74PRNdwyCosgbKQZr4o+KnW2AHmAaclO6BMYuDzMfSYmfZn1rm
 c1Vpo73GpR4/8svvvUiZ+W/EuY71e76YiHHJBnSgdDCQl3AzJpOX5APPBO4Heec3PkiuNRO8v
 3+0VaJVE/xtnFWKMo2OjVhTiSqg1XUW5ltNfIylASNaVETy8ZR7WJLstNbLcWxPawISqbOgcD
 Tb8SQcz3YvWYJPdugDuHebyb93B/O/i6zkLyj6y2VbQtSTangbzAw6asMgpB7Upg8BUCwarHq
 qqm38TljLHiKok1c5VnIUsk6RHM0MO88YKtxlfxDamJxQxRcx8IaQJcpf9/gVl+VTYi8/mu4u
 B2vO7HgayisXg81uMKs3q8zbVV+TOvpekdt2dJqb9EtXw5+njnv2yNlba5RAt1itwrtBkrwx1
 ypLmhsVwj4Fo89F0XMcarMA9yReG4fQgGKb11HQVBG1/JXD2ZZaWM+8tNpE00dZZlfVolgc1M
 SY3mG6EzEhl08d0m18ZTBwT9Rlw/ohCZLt3MArRkyeJc4T18RU8raX7qidezipjqKu0Y2GK8o
 ihVQm0t3yZkwBmgcGKNhanFrSOJoNV9eDT7SUk5mMYuK9Hf4gHk0ijJWR6ll9cD92OL+lauAO
 HEmDSA8GGPlhRfeVLIyJ5FCKSVXaUDgcuXJvc0jdZ2kUapJrPsabhKo1Ad5ROqGAsQ0wfoLNo
 F7hwnX3Z7w63unsDDCwTLS9jbXo5/Q0z7QiZmiOFlnWdyJo1AnF3onMcX/yGoYbOg55zrMX9a
 /X11jHpnMrwQgmyE2kOhi3WbuoBWfOnIujG/JuVfVyKC7KtH6n2KAFaBpKxheTKW/+uNqJe2/
 K/a0DIKVwdGmBRjdXBAdxkNSgSihZEVUCVc3gg24HPy/KPMM5muK7WkvEdDdzhir0cZJPMcUA
 pUx9/bOeI4hr3rlKRmlf5COBHBSFoQo25R7wIasB2WhbWezHd18XnpXQ9+oNjv90jLWJ8TSzi
 d7gGaGOcPMQe97KC7CLCMUf4hSiI9rlukCGV+4KqzSB27IY4e6znsPFpA1R3FfauAl9

The FiberGecko is a small USB module that connects a 100 Mbit/s SFP

Signed-off-by: Max Schulze <max.schulze@online.de>
Tested-by: Max Schulze <max.schulze@online.de>
Suggested-by: David Hollis <dhollis@davehollis.com>
Reported-by: Sven Kreiensen <s.kreiensen@lyconsys.com>

=2D--

v3: resend out of merge-window, with commit message

v2: change Spacing on Initializer, change Mailing List link
This patch had previously been suggested at
https://lore.kernel.org/netdev/1407426826-11335-2-git-send-email-dhollis@d=
avehollis.com/

However, I found that the flag quirk is not necessary and I suspect
it has never worked (because it references ".flag" whereas the
identifying value is in ".data")

I have compiled this and tested successfully with two devices.
As it now only adds the USB Id it generates no extra maintenance
burden that's why I suggest it for inclusion.

 drivers/net/usb/asix_devices.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices=
.c
index 57d6e5abc30e..ef7aae8f3594 100644
=2D-- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -1421,6 +1421,19 @@ static const struct driver_info hg20f9_info =3D {
 	.data =3D FLAG_EEPROM_MAC,
 };

+static const struct driver_info lyconsys_fibergecko100_info =3D {
+	.description =3D "LyconSys FiberGecko 100 USB 2.0 to SFP Adapter",
+	.bind =3D ax88178_bind,
+	.status =3D asix_status,
+	.link_reset =3D ax88178_link_reset,
+	.reset =3D ax88178_link_reset,
+	.flags =3D FLAG_ETHER | FLAG_FRAMING_AX | FLAG_LINK_INTR |
+		 FLAG_MULTI_PACKET,
+	.rx_fixup =3D asix_rx_fixup_common,
+	.tx_fixup =3D asix_tx_fixup,
+	.data =3D 0x20061201,
+};
+
 static const struct usb_device_id	products [] =3D {
 {
 	// Linksys USB200M
@@ -1578,6 +1591,10 @@ static const struct usb_device_id	products [] =3D {
 	// Linux Automation GmbH USB 10Base-T1L
 	USB_DEVICE(0x33f7, 0x0004),
 	.driver_info =3D (unsigned long) &lxausb_t1l_info,
+}, {
+	/* LyconSys FiberGecko 100 */
+	USB_DEVICE(0x1d2a, 0x0801),
+	.driver_info =3D (unsigned long) &lyconsys_fibergecko100_info,
 },
 	{ },		// END
 };
=2D-
2.43.0


