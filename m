Return-Path: <netdev+bounces-94825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E98C0CA3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B9A1C20869
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60083433A4;
	Thu,  9 May 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bL8BUGNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0938D
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243598; cv=none; b=CuT6VsrlLCgubfKgTDmqy504la3EQqVEFBNVl95jibWn3jcDITiIFRL2zNmX9H1SXxOTui58AiaIjy6kZaagTeQKusSVkPneHZazryKI0HguDZ4Zvs0pOTk7HaYdp6Xqw9gpGiYQBReVo8Yssi/dSxXPxB9jWZRqJsYO9urlaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243598; c=relaxed/simple;
	bh=DK0VIC7vlrqZuUsGXQl+yOHrnrpxXYu3PFZB/+p4UFU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BwD5L/hfuSU+B2rlfYf/UOSC31bB+Byt0f1dH4POpGQfT3dhD3Z2b3IrGLqhTTyXngLACZ/Nq/fKLM4hKYBuGuVwg/Fb3JnmPh7cQT2oVlZJKx4r8W0CQ+8HwH+BnxUdkguEYzxH8HFLWOgTg8HTNHLTzFxIXIlcKOxzz31MheU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bL8BUGNr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0949fc17so9895457b3.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715243595; x=1715848395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=06L/hAgFiE3Gl637uFdUd28QJ6MyrGIQDMBI+Gqf1Wc=;
        b=bL8BUGNrtVIl0FnK7vwmqfMHx3PIhLElpUIG631w25p1c4koSlYFFvYxmZnPB7IVSj
         VDnv/EYAI8h/WEtZmCR5ZtpaIM3B65l67lrvfWD/9YBDarJQX73chKn712bA5ZQctrJR
         RHrpSY+QCdv0s5Cil7XsPJKR7+su/tK4Fvb0ZYX1omgmm2gmNbusSPkVc++iF8irpfJU
         ZktnXcROaTkoLpybPp+3dNx50VjQTDolgRh7EgBRCjRceJVWrcG+sUSaQH1i6ba/bJcd
         h6X5zWqHNEAJOsVcRsVu3PpHg/IE67kYL8vtT/RoeIu1CtpZ4eI1/a1xNqyV+m2hbmLN
         DvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243595; x=1715848395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06L/hAgFiE3Gl637uFdUd28QJ6MyrGIQDMBI+Gqf1Wc=;
        b=xFCLZpR18WGKlyJDhuCRXViK3UmYLWX0WgS1NZ1OlWxwTuyNtxoEKq9o8Ji1+wVFA6
         wzwNgKJvqOq46GwEgRtaREAsejnZjqTVxZ9zt3fi6DLeppg2U1i+WDhok8Z4DlnV41SQ
         7NtTgqZQByQ3J75NfmaWqqvQX/gnayjDoMGnQitdwCykbwSjmz2/eBWkjm+N7fZuOoBD
         ll3gTd1Hy4/dlKp6Gc8WLS3Lpd0Iu7Zz0m74pWd40WZpn/cVfN/zkw6Qo3GZKMknXYZB
         BwU6/BzlJwIbrwlnxRX2rziE5CkyiAcNqTLTiYNOmCh59pD+3VuZ7Gm2Nu0zLhpJuQ70
         RKJQ==
X-Gm-Message-State: AOJu0Yz/2d5v68i0MJAIS+8nSVYCSebgyn0WC4nBTwqCGr9wuBFHSG5g
	uZ6yqAfoHgqoXijiIb4maxPsnoqp4lmfe36FbdPdHEsthfu+gi/HZF75ZdoAdU0CxZNuhMaVz/j
	3FCBWQdcUvw==
X-Google-Smtp-Source: AGHT+IE/sZHcTiO4o2MQH6MqBb1XW9RRhW2cp99mXMsGtsawTrl6jzi1kZ471iRrNc3zou2zIAGid5mugy0pZg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:48d7:0:b0:61a:dcd0:5a61 with SMTP id
 00721157ae682-62085b20e6bmr10591487b3.7.1715243595178; Thu, 09 May 2024
 01:33:15 -0700 (PDT)
Date: Thu,  9 May 2024 08:33:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240509083313.2113832-1-edumazet@google.com>
Subject: [PATCH v3 net-next] net: usb: smsc95xx: stop lying about skb->truesize
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Steve Glendinning <steve.glendinning@shawell.net>, 
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"

Some usb drivers try to set small skb->truesize and break
core networking stacks.

In this patch, I removed one of the skb->truesize override.

I also replaced one skb_clone() by an allocation of a fresh
and small skb, to get minimally sized skbs, like we did
in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
stop lying about skb->truesize")

v3: also fix a sparse error ( https://lore.kernel.org/oe-kbuild-all/202405091310.KvncIecx-lkp@intel.com/ )
v2: leave the skb_trim() game because smsc95xx_rx_csum_offload()
    needs the csum part. (Jakub)
    While we are it, use get_unaligned() in smsc95xx_rx_csum_offload().

Fixes: 2f7ca802bdae ("net: Add SMSC LAN9500 USB2.0 10/100 ethernet adapter driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
Cc: UNGLinuxDriver@microchip.com
---
 drivers/net/usb/smsc95xx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 2fa46baa589e5e87e12e145fe46268bdaf9fc219..cbea246664795f27618908838b37384e8f3b67d0 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1810,9 +1810,11 @@ static int smsc95xx_reset_resume(struct usb_interface *intf)
 
 static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
 {
-	skb->csum = *(u16 *)(skb_tail_pointer(skb) - 2);
+	u16 *csum_ptr = (u16 *)(skb_tail_pointer(skb) - 2);
+
+	skb->csum = (__force __wsum)get_unaligned(csum_ptr);
 	skb->ip_summed = CHECKSUM_COMPLETE;
-	skb_trim(skb, skb->len - 2);
+	skb_trim(skb, skb->len - 2); /* remove csum */
 }
 
 static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
@@ -1870,25 +1872,22 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				if (dev->net->features & NETIF_F_RXCSUM)
 					smsc95xx_rx_csum_offload(skb);
 				skb_trim(skb, skb->len - 4); /* remove fcs */
-				skb->truesize = size + sizeof(struct sk_buff);
 
 				return 1;
 			}
 
-			ax_skb = skb_clone(skb, GFP_ATOMIC);
+			ax_skb = netdev_alloc_skb_ip_align(dev->net, size);
 			if (unlikely(!ax_skb)) {
 				netdev_warn(dev->net, "Error allocating skb\n");
 				return 0;
 			}
 
-			ax_skb->len = size;
-			ax_skb->data = packet;
-			skb_set_tail_pointer(ax_skb, size);
+			skb_put(ax_skb, size);
+			memcpy(ax_skb->data, packet, size);
 
 			if (dev->net->features & NETIF_F_RXCSUM)
 				smsc95xx_rx_csum_offload(ax_skb);
 			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
-			ax_skb->truesize = size + sizeof(struct sk_buff);
 
 			usbnet_skb_return(dev, ax_skb);
 		}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


