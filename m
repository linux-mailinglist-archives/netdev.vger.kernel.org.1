Return-Path: <netdev+bounces-208492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E8B0BD3E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A36C3BB444
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5205280017;
	Mon, 21 Jul 2025 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AwS6st8W"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B0A921;
	Mon, 21 Jul 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081851; cv=none; b=I8HYpg6o9lAQsuNg0VFoK7kAtVhogtiyRbg4SbyAo2uLujVhcx+ABC22OK0cNPS/KrDPwsGqjAllGVktpzWmrQwYwUSo6OA/Rd9tuQ6IcWZGoAhBqq8lOkDPPmcoEQ6D8El7GUvtnB7wV0AFkzpot8jaYC7marjspOV4VRaR1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081851; c=relaxed/simple;
	bh=gP6NwIxfNawDZ8YvUCd4Y99rqdhvirRdXcA0+AAqAw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bR/kH4tcqZVof+XkrvTqXRu7xCjZlaIQEN+KpvBF4bXD0tF0ygjNDNx/q00Nyq7bkjZT7wF5waOztUUBFLxxRAVhA/75wphlukMxAeGlDxVGIdC55+odL+5wJHlIoG2KkzAz/kWcdfPtgJO5Z/s9SzawMtxDTKeA1uasuj4s1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AwS6st8W; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tx
	AeIAQ9oJAiwRFKcNeJRwzjvHrUdGEIHTuHoUzLu1Q=; b=AwS6st8W3QFPLTYQHn
	6v6CkJ2rEyFvdqbM+cwHLfDJ44tnW935u3U8lAbk3g7bbjCiE/CKQYqprssjzNTO
	OPcq8FgzFqPM1ga7A07xOJAne0G60jhHq9k33WA1jhdq431EtL7taCntwcdfeyWB
	64ESvAySpzYSk2eBGk2eP5ZWI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnl8fh531obqbQGA--.7515S2;
	Mon, 21 Jul 2025 15:10:26 +0800 (CST)
From: yicongsrfy@163.com
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: [PATCH] usbnet: Set duplex status to unknown in the absence of MII
Date: Mon, 21 Jul 2025 15:10:22 +0800
Message-Id: <20250721071022.1062495-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl8fh531obqbQGA--.7515S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4fXryfCrWrJw1DJr15CFg_yoWfWwb_Cw
	4rWw47KFyFgrW5KFsI9rs0qr90k348Wa18WFnaq34rZa42va45Jw4FyFn7XFs7Gr4UZasx
	Cw1Svryav3s7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeRwZ5UUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUBmR22h94sRrDwABsV

From: Yi Cong <yicong@kylinos.cn>

CDC device don't use mdio to get link status, duplex is set
half as default.

Now cdc_ncm can't get duplex, set it UNKNOWN instead of half
which might actually be in an error state.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/usbnet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 6a3cca104af9..c612f8f606e5 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1013,6 +1013,11 @@ int usbnet_get_link_ksettings_internal(struct net_device *net,
 	else
 		cmd->base.speed = SPEED_UNKNOWN;
 
+	/* Now we can't get link duplex without MII,
+	 * set it DUPLEX_UNKNOWN instead of default DUPLEX_HALF
+	 */
+	cmd->base.duplex = DUPLEX_UNKNOWN;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usbnet_get_link_ksettings_internal);
-- 
2.25.1


