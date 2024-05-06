Return-Path: <netdev+bounces-93739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35F58BD074
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BB0B2114F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301471534E5;
	Mon,  6 May 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UV0jgXkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DF811FE
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006383; cv=none; b=QKyVCxYjdAgE24wZmF0N6AFWpMWhxqZVRO31rQbHBE5v2XAt1HM6WRETErBxOqvScfhT3f2XVLCZIWdhomVJo/00Y65fVSwHsYqjdEC5lkrT382uSv1xq32GVww42zlbAkq4QrjsXvrMcxUjZbPBS9y9ds4a92LOO3FhjaAqZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006383; c=relaxed/simple;
	bh=HX4HJ17rUPKwmnDqUum3oNFhD/RZLT1GbLHnk4RahlM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oCtDhcDY0CVm8RXUg7cpjJ4mJJltExBBX6sMQj8HtET7tYNp6I1Av6RRlqExCtEYnsZHDOJJ4bL23mnpM6UianG1E98fTl2pz4+xHvxJlU2N3WZE7IzYyghJcUfWk8YB+iTOrUKG3pY5/+bcSryAVWvNVKG8EKv7ooJCpkPNO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UV0jgXkC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59ff8af0bso3040301276.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715006380; x=1715611180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7puXbU/MeoB4y7uDUxX4C5/0n37QnPJGeNtzkvM6INU=;
        b=UV0jgXkCfrcXFDbajuBbRjghyfgz9/7i09WukoaXTKifbgGEbOhc2pkdgNK3NurjhY
         CdV2/1DpGS7aHurLSFwL2YbxGXWzM5Mca2ORpbUQy17jVIEZsE73nCXy+Ja7hOANK106
         x5uNLMwgYstD5QQ0IHQ73Y5s9K+CFJlmyxqFSQtD6OhZdcG3mnr+o4CzzS+OAz7QQowA
         FWaaUCoaeA8MNK+qdVU8hxRNIVa0D7n4ra4L+BLil/SjS7+EgxzAXUBzJlwyZjn9tqUB
         ZWtA8sEPhze6GGnLVT4OhGgyJ1qtobBaECR25q/LhIbaggFnsfWdoTrXCks+1jIM/sfA
         Duhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006380; x=1715611180;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7puXbU/MeoB4y7uDUxX4C5/0n37QnPJGeNtzkvM6INU=;
        b=jePeoBt395U4H9r15S/EkJhN24BexWoMApgAivEU3XrJG3Tx6+qGG5KMB0IGLUURtW
         tq2qISVBLoPJa6JiKJZoZ7FrZQWQ//QMP1m7Nj3aMGxEqeqETlRTxXdepsWQEy1mZ7g+
         +qXyZYYPB0K5DS1N9TtX/rPg0x8VKwTcuHDF0F5HVb0fK7VZPwK4B4rfaRVyvw7KzvfE
         7c/uMAnwUbVKOp7B8j+YbDgdJoh2I76tFy8Z1BCumk1QVGiPoU19uboZGZauIU6TxmHt
         H4Eljf1k4KiMaYFHY4P6glbKyf2MCrwqgF4hJPaszuikJbkorC7PxjYZbVCtPlbcNYd5
         qh5g==
X-Gm-Message-State: AOJu0YxSTbdr5L4ZSjK5kCMdGfSso3i4jRo/uAvcKNBCyl67hKyb/QRC
	HpbdY60iJ3S5LvIolWjQvXQ9a44mDNmXUrA9yCKpZJFUMkUTLmkaK1KwsGxjtE5WX5unzv541Dh
	CFoRAsxGf6Q==
X-Google-Smtp-Source: AGHT+IEfD4pHZbhIiPZ8sG1iiRadnfmcmA9i+ig4Km8G6KGW3jJ+5GrYKDYIr3d+1Jj9l4AXpFXGZHG5VqkUIQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d309:0:b0:de5:5be3:709f with SMTP id
 e9-20020a25d309000000b00de55be3709fmr1148782ybf.6.1715006380638; Mon, 06 May
 2024 07:39:40 -0700 (PDT)
Date: Mon,  6 May 2024 14:39:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506143939.3673865-1-edumazet@google.com>
Subject: [PATCH net-next] net: usb: sr9700: stop lying about skb->truesize
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some usb drivers set small skb->truesize and break
core networking stacks.

In this patch, I removed one of the skb->truesize override.

I also replaced one skb_clone() by an allocation of a fresh
and small skb, to get minimally sized skbs, like we did
in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
stop lying about skb->truesize")

Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/usb/sr9700.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 3164451e1010cc80a67e2fddc89a9e59a6721cab..0a662e42ed96593cf20d4209af2bc64a74f307df 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -421,19 +421,15 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			skb_pull(skb, 3);
 			skb->len = len;
 			skb_set_tail_pointer(skb, len);
-			skb->truesize = len + sizeof(struct sk_buff);
 			return 2;
 		}
 
-		/* skb_clone is used for address align */
-		sr_skb = skb_clone(skb, GFP_ATOMIC);
+		sr_skb = netdev_alloc_skb_ip_align(dev->net, len);
 		if (!sr_skb)
 			return 0;
 
-		sr_skb->len = len;
-		sr_skb->data = skb->data + 3;
-		skb_set_tail_pointer(sr_skb, len);
-		sr_skb->truesize = len + sizeof(struct sk_buff);
+		skb_put(sr_skb, len);
+		memcpy(sr_skb->data, skb->data + 3, len);
 		usbnet_skb_return(dev, sr_skb);
 
 		skb_pull(skb, len + SR_RX_OVERHEAD);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


