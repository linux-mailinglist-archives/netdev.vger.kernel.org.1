Return-Path: <netdev+bounces-93736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08218BD047
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2928CC12
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6799F13D292;
	Mon,  6 May 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/VMv/w8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450584A52
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005719; cv=none; b=rrC8Woj18+PsxUAonBiCHrfz0IIY+6wZLqS6kiOl1XcTejVjx7EayAVLA9RU7a79/ndjYdi3lAFIj/qMoDy4iFOwWGw5KpiVHSv1N8tpVgrb6u29ocDg3j8Pqlj9ImU+ipo14fyHMEN7KAY+sBmj6CAlMv3XTGmfiyE+NzSZ1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005719; c=relaxed/simple;
	bh=8HVeWzdoe39GGjUwxxQNTcxL58702odS8HSHHUSiTFo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rRpTBrcfZJfSbW3QaLVw3W+NGI4jtutEji27Wjf8Iyao17FaOXv218oVLowdoac3aVaW3ur/C0xYQ8Zbs6wS1rJ+9xqpjEuK0dm91Tlx4Gq3uZ5mVRI6wrfsU/nW29KamCKwtaPkEcu8JZR7M9aR3esg8fNJTC7iEGTQpnfLvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/VMv/w8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de610854b8bso3793751276.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715005717; x=1715610517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7YHPf30LxxjIc9+rH712kaV3YC3y2gcz+DfW5/hnbY=;
        b=M/VMv/w8fviqm7GeU+mERogIPL+TtWyF5p1cjgYFycd8qcxT7nLulVTvc55vo3wAjR
         tJdbr4ffIlyv3Rz0WMZ2lfDb34MTpez1SN2XgO1URAaN1XRfOfqyOo8CPkzZFvrnz6nZ
         LKtnfIKi2dH8/7CONw57hRnzlEZ8oakP3ISEcWCbAvWc98dNcOvaWNTNjqo8ywSg+iWp
         b58Jh0X8iHak5CvOja54c8bEtZk9FYcvJGtMl5Xcw80LEPSf/+SXfy4zfhyoTq68m2eF
         Bb8k917hQAq+KHS5nXGZVwJhxMvvmB/aX1HJkxxYyzxu4WyxUbNozfU83exEa5ElvKLq
         D2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005717; x=1715610517;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7YHPf30LxxjIc9+rH712kaV3YC3y2gcz+DfW5/hnbY=;
        b=w8GsZTKL8Uq5oApxurgRz6kgQFz5jjzYmIj7FBkI7cTgIiVs78qseIPIosMOlsh2nE
         5GziyNWo89CTSkWcv5/pxDgA83ofIAkHeRsB0P4uA4muYE22UNx+ej7CmOaDJOK6ZFCv
         BebcnpBwMwYGCAg48gUx+lSnKf4DvgQCs+GmSTESsCdPSbP/2ntPSJr+t5wbZyntjsop
         EaPVg2WORX6YaZORveRgq9Lo+p/YDC5Zk8/jS3lFHP1zLQpXeHzYB5oRzzfEjsCY0oHt
         BE92c2RKnWIIrqmNyU1QkH1ep7HMGYp4aCVegDVbOG/qJHTtR8HaPQKU+54G4oJPnu7H
         80hw==
X-Gm-Message-State: AOJu0YwgCjpEQV6ecJumCIOy+HdikA3XjKEMyjOPsUix+3jzmy0WEz7A
	ROHq1iD1I3+VvtZQaNc/v7Txv97eO6VPoG6ADeYaeXLxX7uxKI8hy0R6O0XGOau7+URSbPxliE3
	TIqFmNcKBEg==
X-Google-Smtp-Source: AGHT+IEuSfae6LKHbsdeiycEjRIPbknAu8zuzx4pQPgXV3AzqxV4K2v8Vp6/ZB5ReirvGRtooCvvLT0P7RK5uw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1082:b0:dce:5218:c89b with SMTP
 id v2-20020a056902108200b00dce5218c89bmr1338044ybu.5.1715005716796; Mon, 06
 May 2024 07:28:36 -0700 (PDT)
Date: Mon,  6 May 2024 14:28:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506142835.3665037-1-edumazet@google.com>
Subject: [PATCH net-next] net: usb: smsc95xx: stop lying about skb->truesize
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
Cc: UNGLinuxDriver@microchip.com
---
 drivers/net/usb/smsc95xx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 2fa46baa589e5e87e12e145fe46268bdaf9fc219..54499c1a27f31805932cda9ed5ab5847f9c4fca1 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1870,25 +1870,22 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				if (dev->net->features & NETIF_F_RXCSUM)
 					smsc95xx_rx_csum_offload(skb);
 				skb_trim(skb, skb->len - 4); /* remove fcs */
-				skb->truesize = size + sizeof(struct sk_buff);
 
 				return 1;
 			}
 
-			ax_skb = skb_clone(skb, GFP_ATOMIC);
+			/* Use "size - 4" to remove fcs */
+			ax_skb = netdev_alloc_skb_ip_align(dev->net, size - 4);
 			if (unlikely(!ax_skb)) {
 				netdev_warn(dev->net, "Error allocating skb\n");
 				return 0;
 			}
 
-			ax_skb->len = size;
-			ax_skb->data = packet;
-			skb_set_tail_pointer(ax_skb, size);
+			skb_put(ax_skb, size - 4);
+			memcpy(ax_skb->data, packet, size - 4);
 
 			if (dev->net->features & NETIF_F_RXCSUM)
 				smsc95xx_rx_csum_offload(ax_skb);
-			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
-			ax_skb->truesize = size + sizeof(struct sk_buff);
 
 			usbnet_skb_return(dev, ax_skb);
 		}
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


