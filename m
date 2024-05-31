Return-Path: <netdev+bounces-99619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1828D5831
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC36289178
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52B18645;
	Fri, 31 May 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kjDQ2yJg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A2C156;
	Fri, 31 May 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119359; cv=none; b=E1Jv/A0/UCuvAbZX5P8HVjXg8zAJU+6hGYklgNPVfRv/9n9n1Otp4j32kme7/+A8I0fonCI9g3OwUPkarItQidJ52r+wUTV9S24c3UhPacDRn3yNNI3CQ2W74ladHrm9LuIw1n0Uf3DtOOZTVRfiJgHhFAkhJDv3Ys2LaqfBChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119359; c=relaxed/simple;
	bh=ZApCVXmY3VKY4Y2jD64wkUq43qrLdZnkV1A6irpmLnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGfHznOYiQu6gUJlzUbI897PDwOkLlNIfEdHt8yJ9mGtBgS+E7Idsm59DmpvFIoyaCn8nw9H4OQtaURfbdRX1qPtsg7Kapi3tEs+VINm5aNr+Hm+cnk9sE9Om6r/mfsS058OyPhd9W4nLelH7Ld678ORrgLDn2YmjmQ0vrcNKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kjDQ2yJg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717119358; x=1748655358;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ZApCVXmY3VKY4Y2jD64wkUq43qrLdZnkV1A6irpmLnE=;
  b=kjDQ2yJgxKOhezNgSZuxg3FZ/cPVrZvnAnrlOy8gbslpl0pVaHJKKq+T
   skYu0XKLj6XViON1ChuOtmso3Wq7Gp66sG8cd1WmBHStRoEhyUxNoxHa8
   2k+C/ZrPN0VY6lJAG1N8cs+0LIfq2HQ2vDokxXbtn9HRmEHdQaJCR+3hw
   hVNRMG5oZMHSCVVg+qcIDQjmNw0gLQZ7HL9tonftTyJbx5R//DfdAwbZb
   QzuGobN2H+CmFoyVBP/aTckvu7SXbTYS7GItvod8anqdRUwJqar1kApBx
   cipwoA7pvdxaIXuT+AHDu3maoQC5OqfFydhnjtpXIyxDUd2+y7nNFQibz
   Q==;
X-CSE-ConnectionGUID: p7Nt11kgR9WQrbyNTGr1Dw==
X-CSE-MsgGUID: OeEJoB9GT/2cX8Cuxwz61Q==
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="26781106"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2024 18:35:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 18:35:51 -0700
Received: from hat-linux.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 30 May 2024 18:35:51 -0700
From: <Tristram.Ha@microchip.com>
To: Arun Ramadoss <arun.ramadoss@microchip.com>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot
	<vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
	"Vladimir Oltean" <olteanv@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH v1 net] net: dsa: microchip: fix wrong register write when masking interrupt
Date: Thu, 30 May 2024 18:39:13 -0700
Message-ID: <1717119553-3441-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

Initially the macro REG_SW_PORT_INT_MASK__4 is defined as 0x001C in
ksz9477_reg.h and REG_PORT_INT_MASK is defined as 0x#01F.  Because the
global and port interrupt handling is about the same the new
REG_SW_PORT_INT_MASK__1 is defined as 0x1F in ksz_common.h.  This works
as only the least significant bits have effect.  As a result the 32-bit
write needs to be changed to 8-bit.

Fixes: e1add7dd6183 ("net: dsa: microchip: use common irq routines for girq and pirq")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v1
 - clarify the reason to change the code

 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1e0085cd9a9a..3ad0879b00cd 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2185,7 +2185,7 @@ static void ksz_irq_bus_sync_unlock(struct irq_data *d)
 	struct ksz_device *dev = kirq->dev;
 	int ret;
 
-	ret = ksz_write32(dev, kirq->reg_mask, kirq->masked);
+	ret = ksz_write8(dev, kirq->reg_mask, kirq->masked);
 	if (ret)
 		dev_err(dev->dev, "failed to change IRQ mask\n");
 
-- 
2.34.1


