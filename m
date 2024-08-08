Return-Path: <netdev+bounces-116692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B9694B61B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AFB284288
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C169C12E1EE;
	Thu,  8 Aug 2024 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCX7ZV5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363E13664E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094009; cv=none; b=QxDtznsYGONXgCkVbaMIVfADFvZW10TE9CrG7QkaOqE4QjLI+79kPG+u+oO1/Qc7fzdOnA9Uu7ngNtGD61Zx1HAsOwICW+aud4LfaTu0oxcBLjCwzpR4QVRCc3KKG5bBv+JVG1BfrTqbwT+ZbjGiZvh/1A0xkNP4I2TDd43yZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094009; c=relaxed/simple;
	bh=cPD1pIiWUn+cYGze+tKTPLOnA0b+RPL9mgx9NVLQWMQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NLDU39pjq2dk+hsHr63ib8yl5yqMlAOiUp5JtiPIAbTevDKW3FSuRF2hQ12WqN4iTRQkBdR8b4kI5pdh55Q9xefUB5AZ2pgdKRAinCvwU5Ig89MF54VVv3ATTCwCGfLCsf7CmWe+I/7VMOUMoe+b6xhORR5WZ6j4czF0B9c+sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCX7ZV5l; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so88269066b.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723094006; x=1723698806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxqJMTEBLyimXdcjh0YCvCyxuwpdP8N9ZRFFZFxrzNk=;
        b=WCX7ZV5lDUIxQE+N1wH6199T7mgROC6Lev9QXIziX+/BIp3CWIdiMYN+KwLc6j7yoU
         IsE+L6d33sfvEJ49oMCzuDvMvJj6j1eH1F9UYMkNvAciM/5USxpB14ex1Hna9e+fWwdw
         MPSyavmLghT0UB5bpV0MLA2EW1W65molf3vqw0c1kQqmibA2A21LII1+TUyKUsgqCXBv
         yo0l3d4/jRIcSa94L/msw5oVltfJP0Ri8lj4MoY9LBaez0OsyEmcd7ZVBp0IqQ2iTgNP
         uf8xca+wlC66jWV2+ymo0GCLIpeuzy2au8db9lmzNVHreJAzDz4JEDk8KKZHf4Nv3/3/
         UU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094006; x=1723698806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxqJMTEBLyimXdcjh0YCvCyxuwpdP8N9ZRFFZFxrzNk=;
        b=i1fNjPOpfreqZrRmc5GV2LnjBEwpDNhvL6Z+eS1oIQ75zK0fKGFZ3txLKYYO5evU/s
         c/wYElzLvhuXLn42m2aHb6YVpTtQZIpMJFLtvQWU6qSX/Ltq1wBxSqhgYsR8UG5TUBYP
         F7kY39VIRvfOv1i56vHDyG7rD9pZqPkBaTWFVGgiSElvo37FvWFG0hYzufkbVTadP5vf
         iA52r6ivRjH3FZBu0f2fOZlyVDdv778YcdMyzZqPIZi5/bFEIjwXrTqmXlXpxXg8P9MV
         TwQSWYHkr0UWZ1N7QugQu8KZJ/F58XUD2dlLokUelj0dsaW2fUpHOW5eFrjZNlsrZOiG
         pSrA==
X-Gm-Message-State: AOJu0YyFu1plCQij8Xmn1UFqWLs0YGLEFbTzfE2KGUeCq812AmXYu1MD
	33gfIauWFhAGmWJ1h81txKxUfNBT6BLGqrQmrB3cybQg021ZPAp8Mj0474f1Vo2NLL3WIH/gMfC
	qHGWsUjWKiHkSdfSM1bHOTUMQn9p/a+juqT0=
X-Google-Smtp-Source: AGHT+IE62fdyvTUH7WgY/VgIQvpYTrc3tLU0IsRACM8+RzHAJPqix1o/SHUlRW2WVyAc4lNNaAUrXKJDeY5Cs/07NyQ=
X-Received: by 2002:a17:907:2cc5:b0:a72:4207:479b with SMTP id
 a640c23a62f3a-a8091ec7f57mr47987066b.5.1723094006093; Wed, 07 Aug 2024
 22:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Duan Jiong <djduanjiong@gmail.com>
Date: Thu, 8 Aug 2024 13:13:14 +0800
Message-ID: <CALttK1QVnmgmqZdE6nE5izAPABMGD22DWO2Zru=3V0dXKbDDDg@mail.gmail.com>
Subject: [PATCH v2] veth: Drop MTU check when forwarding packets
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

When the mtu of the veth card is not the same at both ends, there

is no need to check the mtu when forwarding packets, and it should

be a permissible behavior to allow receiving packets with larger

mtu than your own.


Signed-off-by: Duan Jiong <djduanjiong@gmail.com>

---

 drivers/net/veth.c        | 2 +-

 include/linux/netdevice.h | 1 +

 net/core/dev.c            | 6 ++++++

 3 files changed, 8 insertions(+), 1 deletion(-)


diff --git a/drivers/net/veth.c b/drivers/net/veth.c

index 426e68a95067..f505fe2a55c1 100644

--- a/drivers/net/veth.c

+++ b/drivers/net/veth.c

@@ -317,7 +317,7 @@ static int veth_xdp_rx(struct veth_rq *rq, struct
sk_buff *skb)

 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,

      struct veth_rq *rq, bool xdp)

 {

- return __dev_forward_skb(dev, skb) ?: xdp ?

+ return __dev_forward_skb_nomtu(dev, skb) ?: xdp ?

  veth_xdp_rx(rq, skb) :

  __netif_rx(skb);

 }

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h

index d20c6c99eb88..8cee9b40e50e 100644

--- a/include/linux/netdevice.h

+++ b/include/linux/netdevice.h

@@ -3943,6 +3943,7 @@ int bpf_xdp_link_attach(const union bpf_attr
*attr, struct bpf_prog *prog);

 u8 dev_xdp_prog_count(struct net_device *dev);

 u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);



+int __dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);

 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb);

 int dev_forward_skb(struct net_device *dev, struct sk_buff *skb);

 int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb);

diff --git a/net/core/dev.c b/net/core/dev.c

index e1bb6d7856d9..acd740f78b1c 100644

--- a/net/core/dev.c

+++ b/net/core/dev.c

@@ -2190,6 +2190,12 @@ static int __dev_forward_skb2(struct net_device
*dev, struct sk_buff *skb,

  return ret;

 }



+int __dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb)

+{

+ return __dev_forward_skb2(dev, skb, false);

+}

+EXPORT_SYMBOL_GPL(__dev_forward_skb_nomtu);

+

 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)

 {

  return __dev_forward_skb2(dev, skb, true);

-- 

2.38.1

