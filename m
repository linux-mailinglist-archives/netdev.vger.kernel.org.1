Return-Path: <netdev+bounces-163999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B603AA2C43E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445A716544D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CDB1F755B;
	Fri,  7 Feb 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/j2YGfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F42E1F4183
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936726; cv=none; b=CxBz5KQ2BJvxlR5ekxE4Ud7PBu5XbjybTn+d2BFDD31mIdttFvrdtOkJnFHjc0tidKoVIsUA6JztlaRp6RDOXJBuH42VFH3uvMLmTXEq+emzh/Tb9WctQ3Cp1NF5BrxxUwRBBaNfgOGkd93zWF5anovgJTAJvjB70ClDnzzawNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936726; c=relaxed/simple;
	bh=edyX90ZXKVQy5mLW2qGNwvt9ZmSCLg56HC2dC90dogs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXuw0aXWeqPwDg2IzUPqSSqlb+5VVZcQpa8oNL9z+RAQp6uJo/UZw5sA95LTIoyc5RCaA38orocV6HDkqnkOpCKBYUbt4+GoCDrH/Ma2aXHquNJLzRRaBEjWb37/DHIch23XUy1VznMnFI1pTaRqGiQJMlqAjK3o6PxdAls+PMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/j2YGfJ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-468f6f2f57aso22958021cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936724; x=1739541524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLpU4lZklPWFAUShBA35ZwjqHgXTWN7A2jyyn80qL48=;
        b=q/j2YGfJN5SyUArXI7CcvVdhVvVq/44ixVfp2cGLgz3CfhQoOjeljmGSd0x+la0wRC
         nPjXi38F4kJFZAHitK82Y0lZnTRYfgiCDX5fDwQdZgXwN6KXBAgLBoxJNxA1WM3vO9Zm
         Lt60DiQdLfF/a0Om/dYAnlPRo4MjjEJPI8IPsVCWqNebdqhqnPcGTLCx/EGZEQLYuFu3
         /Xma+ArwR9VxJ56iXkel5XCHJpO+/7f3a5GuSrOgfis7ktf1sc3BAun7Uo4CwLM7aRV9
         SOafPt511uU6twfBZAy+QeVBgS2YkmPxDN/4A12MjAj/YxP89lr9OLfUpErhjwEUFK3o
         IGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936724; x=1739541524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLpU4lZklPWFAUShBA35ZwjqHgXTWN7A2jyyn80qL48=;
        b=DFTsDpsX0/XaixMzPXhj4MgCIEBX1d2qurcYwzJjvzetuOiU4EnmI2espY1wYhO6TA
         c/gqrE1RsUDjWXa/jtg14Q7pdDh5AEgw0aatr5LxPO185SD5Hb1d/s7e75novyjV50Sz
         6it/+AX+6P5f86aiMN6UGeQ2E7mXBsfhjnAelY7RO4StHKXQOf3Qi/+KxWQYu0LTBDie
         9uSOWLWJYGSvFYlr+K9FQBpi4RxtlanC4VbVXg6eLNEAE4wuAsWkx4+31W39fGnx4bmr
         K+m5BW55v4U3SXIK5P5GseI0vh+NpS/bIrSL6uzWT2j+KyTzivzcPhHtNVOLizsA4MdU
         dzEA==
X-Gm-Message-State: AOJu0YyThNB7njulusnd8s+JNaQmdZ+n3cXOL6/T+37XyDJ8bhTHaNvz
	5v5jN94AgqEsvvo8zDBPuJUNLIPLs/HDG1qoeJ9rg+EQg3tEW6YbT8OlaTQ5gKuSAiEhlpE77Xj
	YripVYOc3WA==
X-Google-Smtp-Source: AGHT+IFrciAS6946NeM9jPX5MzrKDJKp+iQD2bR91L1qfu4WoKL1kdk4w/zHQbJNQM2qapHknYlhxhI6jNp7eg==
X-Received: from qtyf3.prod.google.com ([2002:a05:622a:1143:b0:46f:dea3:63b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d86:0:b0:467:7725:8b69 with SMTP id d75a77b69052e-47167b2ebe8mr44774911cf.40.1738936724077;
 Fri, 07 Feb 2025 05:58:44 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:33 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-2-edumazet@google.com>
Subject: [PATCH net 1/8] ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stephen Suryaputra <ssuryaextr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

ndisc_send_redirect() is called under RCU protection, not RTNL.

It must use dev_get_by_index_rcu() instead of __dev_get_by_index()

Fixes: 2f17becfbea5 ("vrf: check the original netdevice for generating redirect")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
---
 net/ipv6/ndisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d044c67019de6da1eb29dee875cf8cda30210ceb..264b10a94757705d4ce61e1371eb4d9a699b9016 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1694,7 +1694,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	bool ret;
 
 	if (netif_is_l3_master(skb->dev)) {
-		dev = __dev_get_by_index(dev_net(skb->dev), IPCB(skb)->iif);
+		dev = dev_get_by_index_rcu(dev_net(skb->dev), IPCB(skb)->iif);
 		if (!dev)
 			return;
 	}
-- 
2.48.1.502.g6dc24dfdaf-goog


