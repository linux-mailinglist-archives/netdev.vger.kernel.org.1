Return-Path: <netdev+bounces-116689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B933E94B5EE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA391C20F7D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5442047;
	Thu,  8 Aug 2024 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8YUjVqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35A33F7
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091586; cv=none; b=EwKGwrtnKd7ZY8EcLIuWEtbcymSLxbEYO2Racty0Bko6P3ekttx22KHFlFC9GVHYy9I52yW4DccbSpAh/s4NUVx8a74++Kb8cijuFa9fCOZq7KCvQJilaO9K+ivYDDkcGO02YHUJZdn8T5jP0ibhjUW3jA5mbwcxw9RR4TCkPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091586; c=relaxed/simple;
	bh=QFAy697wAN7dsEJHmIU7tIJXf6pjK+aLxUfLMhIiPtE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gV8TiY/02EE/re9jOwEwKaRm977rVevlSqtieq0udHs6icaWTus3mQn6BgdmdjNFTxNXrIFKTgnvJ5WVgtmUz3y9Pch6FtMO0Jztdx/plr0XbIFtGyUrJSctoS+FY7k8Qyxp+uiU3PYms6VoUcQKVymvrbQCOSySM43Ee5mkZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8YUjVqu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so2479231a12.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723091583; x=1723696383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXwlvPW+PJG0QNHd9hZFCpw09AesEJRm/CzjDY1GnLw=;
        b=H8YUjVqu3ghF04zlIaNoKvjUypJ5YyBDBpFjSPiQ+lLSKntNyuC1on4cUmfCZNJZkp
         vOWBjLy255Kk52PmlthUA07hQ0NdCnR0IisPIDL3NgjQkcwPafn+sZ9a894sWHb903FZ
         5FyfX/sP9ny9xaP8qUSx/H62MChYE8EyiimnIr/8gzdqwwtcCYFaPPuwqFX3cyvDPpfh
         5ayRjTUNG6Wk11AVz/bSl52fmBXVkMR9KwVi/zsvad4CofXBKi9ixXM7ZkamnLYEYKnX
         9kX91jDvR3gQUKaUk09+KGZdanXQ66KFIWq84OB2rxJo6sMtRQtlr3lZ7wjRG0+SD2DE
         a9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723091583; x=1723696383;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXwlvPW+PJG0QNHd9hZFCpw09AesEJRm/CzjDY1GnLw=;
        b=UfGIH9Yv1fCpHQCmB7J+ADGAa3HZF8rrGrHhy6Y7SaCii4YY93ARDFjamUFPNbwtZg
         RVN/RiEEFEvBnOrHmfrY6/g1/y9pXtgwMcWIZ02lGqImm9hKwF+kiCJLyoeCCpD8wbDh
         KZ6e46MX5gs+7mKg0snH6ItRd3Qx2RwxrKFdTqGIrr7dcfkrno04XDNPEZ+Mb0ZVH0qA
         hywMZRH6JJ7EgC1bnSElHbFvY3j34wU9qsY33sGytmQE+ItEHotz1WjLja0HhXDoKeOF
         g20/0v1Csxe5TkPdwSpjH0nrvGWv4rPSDymbyqaZGlpq2VnZBYn97TL3BfIHZujeyD+g
         ywQA==
X-Gm-Message-State: AOJu0YwiPJziWggDFYsKdN1q7ObmukiOgMLu+XRqRwkDb/GCKUnFEo/p
	DhJfSCI80jBly9N8b2tMg9XG78be+T39IJs1bL5clzJP6qzDU6RrZdIHI4R3RPtNdjIOCSyInMM
	rCGpVI46F+llzjYuwIj+54mePs/Az93aHGcQ=
X-Google-Smtp-Source: AGHT+IHdFw/1eKNw5QlD6RfyREpqUB2orfOCdQbDZf3exM7eNalate9ydclM60JzPzZBRLUyni1f2u8xLuIYGsTAeEM=
X-Received: by 2002:a17:907:7216:b0:a7a:be06:d8f1 with SMTP id
 a640c23a62f3a-a8092019ae6mr38771266b.25.1723091582736; Wed, 07 Aug 2024
 21:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Duan Jiong <djduanjiong@gmail.com>
Date: Thu, 8 Aug 2024 12:32:51 +0800
Message-ID: <CALttK1TYZURJo8AKtGQFcKKMvzssy3mF=iG9rODqvEiPw_qqpg@mail.gmail.com>
Subject: [PATCH] veth: Drop MTU check when forwarding packets
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From dcf061830aba15b57819600b5db782981bab973a Mon Sep 17 00:00:00 2001
From: Duan Jiong <djduanjiong@gmail.com>
Date: Thu, 8 Aug 2024 12:23:01 +0800
Subject: [PATCH] veth: Drop MTU check when forwarding packets

When the mtu of the veth card is not the same at both ends, there is
no need to check the mtu when forwarding packets, and it should be a
permissible behavior to allow receiving packets with larger mtu than
your own.

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
-       return __dev_forward_skb(dev, skb) ?: xdp ?
+       return __dev_forward_skb_nomtu(dev, skb) ?: xdp ?
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
+       return __dev_forward_skb2(dev, skb, false);
+}
+EXPORT_SYMBOL_GPL(__dev_forward_skb_nomtu);
+
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
 {
        return __dev_forward_skb2(dev, skb, true);
-- 
2.38.1

