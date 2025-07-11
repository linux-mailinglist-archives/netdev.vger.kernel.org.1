Return-Path: <netdev+bounces-206051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7EB012B8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2362A5A6294
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 05:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460D8F54;
	Fri, 11 Jul 2025 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBK0LgU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE353625
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211933; cv=none; b=uf0kvValnoihuOIj/lgzL8uF+LNGBwKWopjhrfOcnZRILep8ol5zaawW1tG6q+pDNv08Fw/+BBknSStP59273aAOb5O0mkdeI5rYOqvKK6MEw8yPdG8uUDfm9pjCYuM0JSRU7UDHfyW48iRwIqnDpXJQ0LoQ04rjI2PxgOWNzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211933; c=relaxed/simple;
	bh=YvGgwL+U6Lw9F2MqRICbQeZggtn9fyJsXdAv22NAYpg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZSakGSTLnJFC/ASUvwpDNGTpQxxq7HLq+aI2dED05YALb75n/Tfc7819oSz7K0EjG8p8amt2iLTJ2okgnFHtSuuFhUURUsFvgCQU8Gn0zIKzqgbG6pTZP49BO3mObC8/hmGODTWBirr0DRJPV9s4Fh0F6q7hvTBdtqzWG9mmsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBK0LgU/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313f702d37fso1859178a91.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752211931; x=1752816731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=to8LUEEWePW5vOL9+mdZts8hAQhgCYx2zuIVL7aP9E8=;
        b=oBK0LgU//Q5u4MMrZmr+LAlb42HYFOMqD/wWz/aubWbVelgisybr7Reb2XiH7Jow8x
         e8xgH+27AhQeAdCO/td9tyAcb5HZpVEa5qm6m4AxLWxlvjUR0wvP/6bKY5ZjpgOLWnB3
         D4X0cxGkzYGpFoYH2ifNjtBBaN3tC2eOIju0BeDypFe1T2WCtKA9VReoSyhjlKHoRTl9
         eBf5N0uYr4yXOxmKJKOKdlD7x1oHvYYFzKceOsTfDrFFJTMhsGud4WtCErn9otiKkD9H
         fXPpqLCc6gZTNULqd6oewJ/6X9hYdSFSCPH2pjDwkfquCdvRnwczsT52JZtfzvlcgseD
         12VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752211931; x=1752816731;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=to8LUEEWePW5vOL9+mdZts8hAQhgCYx2zuIVL7aP9E8=;
        b=Ix/35dICh8L+IFpS82JRKVgASZSrDDW+9vQrGE62mc7xobLTXtsMk1a7jTHH70R0mL
         DqfVveFMrQctTr02SYTMx4SdzFhAGGtkUd6mW83r/NoKKefJhjhkeMt3oDDqy5Uzox6O
         owFkeO0V9vlN+PKzjLEvIR3ANaoYJKDrhoxAa0oq40k1seYNDfa0jRaRzU/JzYlhljUw
         m4VB3IHB7yYOEAuYOPRAVVqO7ppHQ/V2zvsLDOEmgXMTrdfmSkejyqb3g/Ja3wZd3BdB
         X+FeIY4tWbtCvS+MSn1m++isSZpEobT2fhfsk1nb3wKm6VXhFjIyhQNJ1LFV+ui6p2yU
         MLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP9+bbV43LCvNEiL5zjXB7eNvidgZWdFnxekrKy4qHBueE/TayvDhz+p6r/+d3yIHpONRxjDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ggBJcXzkkUR+7opSoDNad6uwA8RmiDyAKYhpxQYyE1FkCu8N
	faBkv1ya0DPTO5DML9vxt0LL+qdRev680VMjXxlZW1PyIT3EvyaTYZXsaTTfksWnZN2Ar1gBZwL
	jVm3Ruw==
X-Google-Smtp-Source: AGHT+IHCKx9hCFV6evQH0LTGzIfcK9waQIJWfhNGr3rtH0NqYo/z3TDmPQBAhzWOvN+HguUl/mALkD5RDiw=
X-Received: from pjv16.prod.google.com ([2002:a17:90b:5650:b0:31c:32f8:3f88])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180e:b0:311:9c1f:8524
 with SMTP id 98e67ed59e1d1-31c4f4bf9d7mr2129604a91.15.1752211931063; Thu, 10
 Jul 2025 22:32:11 -0700 (PDT)
Date: Fri, 11 Jul 2025 05:32:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711053208.2965945-1-kuniyu@google.com>
Subject: [PATCH v1 net] netlink: Fix rmem check in netlink_broadcast_deliver().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We need to allow queuing at least one skb even when skb is
larger than sk->sk_rcvbuf.

The cited commit made a mistake while converting a condition
in netlink_broadcast_deliver().

Let's correct the rmem check for the allow-one-skb rule.

Fixes: ae8f160e7eb24 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 79fbaf7333ce2..2d107a8a75d99 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1395,7 +1395,7 @@ static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 
-	if ((rmem != skb->truesize || rmem <= rcvbuf) &&
+	if ((rmem == skb->truesize || rmem <= rcvbuf) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


