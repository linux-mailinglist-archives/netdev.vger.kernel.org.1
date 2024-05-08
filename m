Return-Path: <netdev+bounces-94439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7F8BF7C4
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F80AB23953
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2283EA96;
	Wed,  8 May 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8ddtPt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7572C68F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154723; cv=none; b=FVNO7NuzP96WDTl6aD2W1TMJ+TJB5K7SBASKV2U1Shv0x+4hhiVhrE3w3HBc0dH+NEKgABRC1BXVhZ/LllMayHtUe5wkU+IX7qFFczfG38CywNz586l+kKsQ2tfYNAsCYZ0eJIgaUkhcDQUNmsVH63Rg4QJ1j15lwyS/qCgyD3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154723; c=relaxed/simple;
	bh=SkGUXLxhIZf/WEa7vtmtaJlINHyA97xY8A9l482JZ0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q7HpEy3TPG0CkwilWJHXWMG+LI7Zt39egwiijYTsO5wbFDgHRhOYkMUBIkaCKfhL/f2AyB1QdJ/HtJjA30c86Vo0M4flQ0Gl26+g2XEgwSVMbPB5AiB8LbnGd+hVavgnXjXdcJebwIYD1jgrgyPTZIvoOd8lKyKxUwwyPOoFzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8ddtPt5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso7491195276.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715154721; x=1715759521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TUySFJvY1/u3z2nLmEOERnnBTopYnCa7abTKtIfq/nw=;
        b=B8ddtPt5lljiIQ/I5bh/5I3TUOcRgkJ8bSEGeCFTnHUrm1x5JNP9oaFv4sxyQiQive
         BXvH5Yj+WHJAbQp5w5C2X403RqcYfmTmG9Q0Uo4D0ZHSQ/7NYcQTwoObdsof7gWgu760
         QHRSzlhIHukDo/AaFcXuAU2+S3UZx5y/RW+lCrF/V1nTDJWAj3Dqo624O4g2DWLGdsyq
         pAWOAJkjcOGLzfhUqSvyKu2fSabEGlejUfOfeUOlrk7bOTx5dBt9xvIwmpVPAiYQGDz/
         piw8tOek+kGBfF+KQQDqx3btWGPReEO62bG8nopaQ72sRjHTOGykKzhj19sFjfL7AGTi
         uF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154721; x=1715759521;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUySFJvY1/u3z2nLmEOERnnBTopYnCa7abTKtIfq/nw=;
        b=JCM/LN+zF+mYTutT5A3+l2m1q7UDLc1OCSi7Pa67ROAVSsBcXSAEPJ1xy4rJ4jqoZ5
         eNIVDSTNOXqNKCseyco6gxAXEhBV8elXqc08VjBzgPpJhKdmhEflCEftkEr5TJ+YH2Jd
         jHdEri+vDb8cEd6jWmSjvR0xE+He7OoX/igzAjyzA4w9dQLlJjPx8/Tb88E7PXJk6/Bx
         CVxSNfjGZvvkm6J2hoWLs7YzZBqOXoH4xytMU8qdkHUV9f4YYw0rKzYRx58tvWPmN9vE
         bsLeB/3sxL9A27meRixCgYK/ngrlTG6cI52+BK6Y8LW/3huxq3IiYLr3enwHbYQPKE2k
         xZmQ==
X-Gm-Message-State: AOJu0Yx3d3Qyf0f6J56F0JnZqt4qvVtXeUsch+6Ky7S6akKdiSsuVKP+
	vGm6Ki7ANeAF2CDNDM9Oug8BfE1/WlvaFK4pljAHbuCEghcI6x3wfAI2TTLqoeBHeb6F+RhDYjK
	Pdv3tE8BC/w==
X-Google-Smtp-Source: AGHT+IHM/gERUjVl8iHzu7aDroMyxOk/Uqa5MWgUA9t/vLi5iEKLxPXSV6grb0tZcgM4Jz8J0Mjn6tMU5ZKWDA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1027:b0:de5:a7a4:ebd6 with SMTP
 id 3f1490d57ef6-debb9de88fdmr571213276.12.1715154720817; Wed, 08 May 2024
 00:52:00 -0700 (PDT)
Date: Wed,  8 May 2024 07:51:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240508075159.1646031-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: usb: smsc95xx: stop lying about skb->truesize
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
index 2fa46baa589e5e87e12e145fe46268bdaf9fc219..0311328797c345bfa9a117596c268757808828d1 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1810,9 +1810,11 @@ static int smsc95xx_reset_resume(struct usb_interface *intf)
 
 static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
 {
-	skb->csum = *(u16 *)(skb_tail_pointer(skb) - 2);
+	u16 *csum_ptr = (u16 *)(skb_tail_pointer(skb) - 2);
+
+	skb->csum = get_unaligned(csum_ptr);
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


