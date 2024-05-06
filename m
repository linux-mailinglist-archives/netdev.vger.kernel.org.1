Return-Path: <netdev+bounces-93734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97DD8BD038
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F128C464
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25313D242;
	Mon,  6 May 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIVfSIrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72213CF8A
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005443; cv=none; b=lOR0BwmZ0JKKvw28tI375uRn19l4AQy72tbMKrsLMHxCbs/Qa8mif8pperj5dcsLzbwl1kzkdHz2WI7R8yHXQgAZMt/BYTpNU75enQSivrgtlxVs1KBcah96xZDI4ySPL8Ox/hUHE3EKZVgmgTevGEoNGU8m1JAtrpNFrWQWJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005443; c=relaxed/simple;
	bh=tGPfksd6LF5TqaSBiXaHUwtoIvjgRIUN4iZ2HI5Y8Hc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NX2vKFesT9wN5YAEwednv5dKtfdMs9qD/82IPMVY2/jgbYvPElHbOQR2EZKXO4fKsySzStUb4blIxqsqwuRN4QTqpKKTKQOfqPBuKeH+ZwdMVTPywx5osG3uP/4pCT5Q3kTzzRTRwYGvWS5jObKjHSKReR2X5oiajNzp8UlXVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIVfSIrG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de74a2635e2so3483007276.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715005441; x=1715610241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j8B9dP3a3+pd+AfKiKM3nL9T92nsSecldEPBGfyPYfw=;
        b=VIVfSIrG8NTp/kL/lgy8XO28Cw20ABk7jWYpkLdgdsS4JO70hzZ7TNpbpcatdPLeHv
         myACAZwh26a5XKs/Cxz3c5D1U81acAIrw3S5a+xp0VmgPQc2UEiV+uMRPJw6UHBIE9wR
         FjnMRtrV/nprZ83PBYDEYApjzmc0p3GolvyVEwQMsUjfJE47C+ei49DrzfIjs7h2uoIH
         cPvlBbY8dtMoPUaxtJnLzFPToW1b0wSaZnaHVZZ7Dy4vjWtw+/1AmAG6vS8uJemMLUcG
         uvNWhTBXQzV0wa2uNMIxOqq1LrOeDeeITICM9XikAZcz7ldAqXyDNkYOCJgyPUnjyHYc
         J5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715005441; x=1715610241;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8B9dP3a3+pd+AfKiKM3nL9T92nsSecldEPBGfyPYfw=;
        b=Zq31QqKCRN2lpXvqBKCTZRjMGRxSj40f6C6YTCgd5pJoKUaMCyKNP73FdI5kCZQAu1
         5iY6N3XLkz9p+bMDCN0f5m9QbGoxgstHBQ8m05A2J08b8F9nsrMU3hNO0Uo9yJUfoAD/
         OYnCCb8Jo+YaZiF3mcRMM1dg42fVP+LjhW8/+KaOmwzHcZAB9wus5H/32xpjr2QwBHd2
         Broa19Xw0xBfo/ID2I5rEPbvNxcqiTB4TcWuX/2lShp3Psq4/5OAgOVhuU1VyfsfceYi
         QLzwSuDwNrcQDueINB4fKkuSDZW2gcBXhoPa13WitJQwdvyrTySlXhu/16B6r2tmMGqk
         ph1Q==
X-Gm-Message-State: AOJu0YxoKnIt0h+ZnFbrOCMStUUCj4UWquQplyJU2xoBURwD4kTo+l0A
	0UUqdkyygpAE1RPrhZFGvqaujHOKCFrjI5xSBRh6fBU4VzUXXv4UjfNlelpL89gHi+pUJh4B82Z
	JCh4cBg+atA==
X-Google-Smtp-Source: AGHT+IH0d2ExphDDSCKJECUrLDVLhE4lQXbAvlKTILDudzVU1WUXqcILZE6Vpeo538D9dI0lPiYGvguswk3nlg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1007:b0:de4:7a4b:903 with SMTP
 id w7-20020a056902100700b00de47a4b0903mr1431924ybt.3.1715005440807; Mon, 06
 May 2024 07:24:00 -0700 (PDT)
Date: Mon,  6 May 2024 14:23:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506142358.3657918-1-edumazet@google.com>
Subject: [PATCH net-next] net: usb: smsc75xx: stop lying about skb->truesize
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Steve Glendinning <steve.glendinning@shawell.net>
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
---
 drivers/net/usb/smsc75xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 78ad2da3ee29b225f41eddc90b08d43257d01e8f..0726e18bee6fcf3cbe4b3d2006d40cc2f781b64c 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -2234,27 +2234,23 @@ static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 					rx_cmd_b);
 
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
 
 			smsc75xx_rx_csum_offload(dev, ax_skb, rx_cmd_a,
 				rx_cmd_b);
 
-			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
-			ax_skb->truesize = size + sizeof(struct sk_buff);
-
 			usbnet_skb_return(dev, ax_skb);
 		}
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


