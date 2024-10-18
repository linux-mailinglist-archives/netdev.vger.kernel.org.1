Return-Path: <netdev+bounces-136884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774669A37A7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF21DB222D8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F618858C;
	Fri, 18 Oct 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO8/stpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB172905;
	Fri, 18 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238023; cv=none; b=CqTLFJcnYoGf3c8VBYC0hGbgE4ksLV8SsFeTKjjFlF+Von24ws3d5EHB6aXCu3r91nI0c9zYP3ZpQ7wUONGvY2SecDq3SQr7G/tSeE81l5A8Z8cKLi5Wcf2CuryAFhrrJhfmrIqtYw00J+WmwUMqn3OufTsRYbK7RpP46oFznsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238023; c=relaxed/simple;
	bh=Rc4qEXMa0QYjvHOp4pyZqLnpUr0nGSD3dQ+U4hdNEaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jKtsZZSC7NKRTKXKdU9i4v8LSZeJ4eAN4OyflhkWqOYv3FSGrdQe9v/uu5TAMuou0tWbtii1BSqiva4XLMPFcjaGbcY53wPEdkhLlKS5VsS2W0k9Fp8AAFBkIFwjqr5KEeAsVxzFa1D6A5PJk+uVHe5pO9pOLM0zbjIIVE0jisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO8/stpZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-208cf673b8dso18957625ad.3;
        Fri, 18 Oct 2024 00:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729238021; x=1729842821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1isxM+T848GFvJvzymmh7gVtU9Db8eItqMO8i4yplDI=;
        b=JO8/stpZ6oUHGdv4heOiRjcsalC/SVZdygAAVy5Zip8iOvW648vw2P3dGVL3Dv1PDZ
         aQfTnVfoLdQwCvkWM0eMmEN5mYwEHzqaDt6m5xGnyiv8gVLMGMSL9QAIozTm0QC1k3kX
         WTxo4oyR4H3tNSqoqoUgP9NlJ4tAEog3/JIi5FlD2fUQpr74DKk7p3yzA4V9XoKJBq9u
         6Qc+WyeMPa0efYIw2OUy6oFAlwWLhnA753gjYBF+K1Bb9m7mRosubdeI89oDsaDSw5IW
         X1Dqs7TI6QctD208Noy0H1zp8uA7y81GB7wI+PnBS8+F872UMq9pyGBnN/Gx4Cy+c9yE
         SjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238021; x=1729842821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1isxM+T848GFvJvzymmh7gVtU9Db8eItqMO8i4yplDI=;
        b=Fz126bSB1W0I2kDmT0pCwuFOIqFsWoGn8EDmeAVioG6JgmuIGOWgFD+lsrvIvFhrWL
         CQ3yhGE5zWfH9F1GJDOBCCFPh5nY2Bnf2OqGDsfSVmkaMhEq1rC9A+yWpiJQcv3ryfqD
         gGbgJQJRc0Y39oPaQHf9VMT+YqQL8u9QQJC0lqNnfcHWFzdFew3qoPLQ8VFVeVTQpYvu
         WLMQg87jFS1IHG/rMbhK5z9yoYy8HOPCPWMTYws4hcg6XXejGV96PZgtlIxjDjbJyR8q
         4r2XHmQU7sgGX8xo0HjzZWBzJmEwe9k3t9jLXn6Vv8WHq7q5ss19u/Ty7pYU449MlKtv
         snAg==
X-Forwarded-Encrypted: i=1; AJvYcCV7UMuAxLof7DaAMadZE3rlOwj9gBcjk3Q9my6o9JdlrTAwVu+sH5v3PXRTAaAanCksmCrlOiLSFMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdXA9kxV25Nnti/3EVgJXEjVmQle4pugvltR7j6g6Ecmj48ir
	jvGN4Pp+JPSBt3LZsza41THQMUa0498+fapMHUSL9Dod526svT+5hnyMCxat
X-Google-Smtp-Source: AGHT+IHTpbK8FW3KHcz+82CcxYiIy5c4Q8VIpZDFGZdZk+tGIVTVl4hqSC2LDuKv2cn8ehsLaDuKKA==
X-Received: by 2002:a05:6a20:b58b:b0:1d4:e638:d066 with SMTP id adf61e73a8af0-1d92c4a1c30mr2084440637.6.1729238021116;
        Fri, 18 Oct 2024 00:53:41 -0700 (PDT)
Received: from localhost ([2402:7500:479:5c7a:4a5c:7794:109d:58b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f9a51sm7361785ad.215.2024.10.18.00.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 00:53:40 -0700 (PDT)
From: wojackbb@gmail.com
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	johan@kernel.org,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH 1/2] [net,v3] net: wwan: t7xx: add PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Date: Fri, 18 Oct 2024 15:53:04 +0800
Message-Id: <20241018075304.23658-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

Because optimizing the power consumption of Dell DW5933e,
Add a new auto suspend time for Dell DW5933e.

The Tests uses a small script to loop through the power_state
of Dell DW5933e.
(for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)

* If Auto suspend is 20 seconds,
  test script show power_state have 5% of the time was in D3 state
  when host don't have data packet transmission.

* Changed auto suspend time to 5 seconds,
  test script show power_state have 50% of the time was in D3 state
  when host don't have data packet transmission.

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
V3:
 * supplementary commit information
V2:
 * Fix code style error
---
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..ec567153ea6e 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -49,6 +49,7 @@
 #define PM_SLEEP_DIS_TIMEOUT_MS		20
 #define PM_ACK_TIMEOUT_MS		1500
 #define PM_AUTOSUSPEND_MS		20000
+#define PM_AUTOSUSPEND_MS_BY_DW5933E 5000
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
@@ -174,7 +175,7 @@ static int t7xx_wait_pm_config(struct t7xx_pci_dev *t7xx_dev)
 	return ret;
 }
 
-static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
+static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev, int pm_autosuspend_ms)
 {
 	struct pci_dev *pdev = t7xx_dev->pdev;
 
@@ -191,7 +192,7 @@ static int t7xx_pci_pm_init(struct t7xx_pci_dev *t7xx_dev)
 				DPM_FLAG_NO_DIRECT_COMPLETE);
 
 	iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + DISABLE_ASPM_LOWPWR);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, PM_AUTOSUSPEND_MS);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, pm_autosuspend_ms);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
 	return 0;
@@ -824,7 +825,13 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	IREG_BASE(t7xx_dev) = pcim_iomap_table(pdev)[T7XX_PCI_IREG_BASE];
 	t7xx_dev->base_addr.pcie_ext_reg_base = pcim_iomap_table(pdev)[T7XX_PCI_EREG_BASE];
 
-	ret = t7xx_pci_pm_init(t7xx_dev);
+	if (id->vendor == 0x14c0 && id->device == 0x4d75) {
+		/* Dell DW5933e */
+		ret = t7xx_pci_pm_init(t7xx_dev, PM_AUTOSUSPEND_MS_BY_DW5933E);
+	} else {
+		/* Other devices */
+		ret = t7xx_pci_pm_init(t7xx_dev, PM_AUTOSUSPEND_MS);
+	}
 	if (ret)
 		return ret;
 
-- 
2.34.1


From cd3c4bb25637348806e92e2fe9d51a05c5ddbafd Mon Sep 17 00:00:00 2001
From: Jack Wu <wojackbb@gmail.com>
Date: Fri, 18 Oct 2024 15:44:11 +0800
Subject: [PATCH 2/2] Add support for Sierra Wireless EM86xx with USB-id
 0x1199:0x90e5 & 0x1199:0x90e4.

It is 0x1199:0x90e5
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 14 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1199 ProdID=90e5 Rev= 5.15
S:  Manufacturer=Sierra Wireless, Incorporated
S:  Product=Semtech EM8695 Mobile Broadband Adapter
S:  SerialNumber=004403161882339
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#=12 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=qcserial
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=qcserial
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:* If#=12 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#=13 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#=13 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

It is 0x1199:0x90e4
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1199 ProdID=90e4 Rev= 0.00
S:  Manufacturer=Sierra Wireless, Incorporated
S:  SerialNumber=004403161882339
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=10 Driver=qcserial
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: JackBB Wu <wojackbb@gmail.com>
---
 drivers/usb/serial/qcserial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 703a9c563557..bd0768e61b26 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -168,6 +168,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
 	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
+	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
+	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a3)},	/* Dell Wireless 5570 HSPA+ (42Mbps) Mobile Broadband Card */
 	{DEVICE_SWI(0x413c, 0x81a4)},	/* Dell Wireless 5570e HSPA+ (42Mbps) Mobile Broadband Card */
-- 
2.34.1


