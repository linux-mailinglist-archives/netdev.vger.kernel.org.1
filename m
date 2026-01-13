Return-Path: <netdev+bounces-249356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C28D171B7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17E213019A52
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258222EA15C;
	Tue, 13 Jan 2026 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="Zpw4Bxmw"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E1625FA29;
	Tue, 13 Jan 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290721; cv=none; b=d0Bh8DIQX1nblFDQ8MEBz6GabfCalCLM5Zhju8fJBw/8m6Vi/yIAyNeJbdlwV8tQs4vIsjENrmE1j0GSzVCU8UVLuQjBjjEBzNVPIHPDaKXKyeO4vpChTKDnCI7AiM+bWbk18j4j72RA8O+Zl6QN9bgl5gwqUhu1am9yqUv3P3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290721; c=relaxed/simple;
	bh=RUV4yTMY5Evl8HqrPcPZNiruRlbq1mQJ1udb9zkdlo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUJPBOItmZLq+fQ1JplC684KevxLH+WJu3USPWBt037W2flvnWRZWrI9L5v5kkOaXh2vfn9hNvIO6jKeaWnFVfxI07z7dWWQhKyxcGHtFw507IdCYEX6/lbmQykvMHY8J9ciw2kG0Jr48dftjFwHjgdoADTGoQD2ehhWhw89GXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=Zpw4Bxmw; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.250])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.16/8.18.1.16) with ESMTPSA id 60D7plnT029996
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 08:51:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1768290708;
	bh=RUV4yTMY5Evl8HqrPcPZNiruRlbq1mQJ1udb9zkdlo0=;
	h=From:To:Cc:Subject:Date;
	b=Zpw4BxmwcObx1Yjp4O9EULBtNaHOlvHYNLk0NkrH1jXowMvCwwraenOgtvS/r0cEy
	 HomTqBt/JWYdpwo7LQP7TRUZtSlvMXeooYTiCojUfwigkgVWHNxTihms3LsYMHxlsa
	 DRqw3qqMmrWIdTvzyQsXIs1xsRJ9yTbv+B3bya4U=
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        dnlplm@gmail.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH net] usbnet: fix crash due to missing BQL accounting after resume
Date: Tue, 13 Jan 2026 08:51:38 +0100
Message-ID: <20260113075139.6735-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 7ff14c52049e ("usbnet: Add support for Byte Queue Limits
(BQL)"), it was missed that usbnet_resume() may enqueue SKBs using
__skb_queue_tail() without reporting them to BQL. As a result, the next
call to netdev_completed_queue() triggers a BUG_ON() in dql_completed(),
since the SKBs queued during resume were never accounted for.

This patch fixes the issue by adding a corresponding netdev_sent_queue()
call in usbnet_resume() when SKBs are queued after suspend. Because
dev->txq.lock is held at this point, no concurrent calls to
netdev_sent_queue() from usbnet_start_xmit() can occur.

The crash can be reproduced by generating network traffic
(e.g. iperf3 -c ... -t 0), suspending the system, and then waking it up
(e.g. rtcwake -m mem -s 5).

When testing USB2 Android tethering (cdc_ncm), the system crashed within
three suspend/resume cycles without this patch. With the patch applied,
no crashes were observed after 90 cycles. Testing with an AX88179 USB
Ethernet adapter also showed no crashes.

Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Tested-by: Simon Schippers <simon.schippers@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/usb/usbnet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 36742e64cff7..35789ff4dd55 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1984,6 +1984,7 @@ int usbnet_resume(struct usb_interface *intf)
 			} else {
 				netif_trans_update(dev->net);
 				__skb_queue_tail(&dev->txq, skb);
+				netdev_sent_queue(dev->net, skb->len);
 			}
 		}
 
-- 
2.43.0


