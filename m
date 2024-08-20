Return-Path: <netdev+bounces-120271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B7A958BF1
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068661F2351B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C631A706F;
	Tue, 20 Aug 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s477pmNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721D196DA2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170145; cv=none; b=DpvgoGXieiW9b4Un7dm8eGgnEMVZp5MuC0q8fEYDRGkh9Uojqdg85YFInyd0SfGMAQlyGF1cijl7Y3jvtMtPjtMY/KyDBCR+XLtuH83QptDBBJ8CZkaY64KBvFmmQPDdPpGErhZ5l4NtxBlmShW3UPCrVHFWcBx9/i0JHDf2xPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170145; c=relaxed/simple;
	bh=hzivC0QY8/OrDsjl0zLN3oA5RAsMUhmZXb81iP5BZzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0g0lObc6NqNpHkKA/1H/JCCGLM5rFd+vZPGc92L2UOMqB0NfbXQx7PrPT0yfKt9m6vopCG2Fd5LPjCH8h1lIU9IH7wlIuBiiZtFdrcqsjmR6srFUEVEau4jhR0KpTmg30VhTMV9ItFfPc+ifYv4IzCEQdlagiwry6vp4uTXY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s477pmNs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1159fb1669so8879314276.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724170143; x=1724774943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E28CXQYWoYPohvZg7/J6bFm5MrC6YxPoWTodXDcnZFU=;
        b=s477pmNspAhYOdK63QYtOnb0UnpNN7C77ZByfTtQ1nz04UJeImqfuIP3bbJ/s+76zb
         dP0yLEeUBZfp/qxwZ6FiPi8jfwTABgwAV4jNr9BUHd1nHa8PXnF1Xp+U06KuRu80mHBS
         JciIQrK7W99+CDrHEtFLlL7z3IQ+a1ATyG9496is3RCzD2vwOqgkg+A12PtoZQszAGU+
         jLmWCRQWSe8AhDGOCTP4I1wGNjU2tGP5VJnqXQfD1XoiRFfM3d3UXDOJdcZ8VIi/Wb7P
         1GoQfB2UJiuMpUeids74D9lXvADLjKLoYZNF6Q5nanFfldZ6GfbMdgo1AlmXqOXuaAVV
         HN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170143; x=1724774943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E28CXQYWoYPohvZg7/J6bFm5MrC6YxPoWTodXDcnZFU=;
        b=hX8SRtCpw8mp1V9UZItMrJ2I0HSHgiOWtm05el8BrB0m7CfNCCHFWCn/B2S1CsKSAH
         JG2V3WjfANb4XDS92pNXZD8aCHXAjqs3Iu9F+9WUuMkflH6Mez/oxtIe8bxlQVk8xkcx
         PK1JV08RbnufMi1pRhgD6u+6nIu0WEq4Ptyxoh7AwhU+4noB27hsLhlgNsUyibpfs7kL
         67IiFVWivIMf8vgiuxg2PHm4tQjOhXdDGr8T/kcdduuTddEJwTMyMX08WrYR6k4UgT1o
         VIreuzY6su6Cfn9Va1OkEoX5ngCN+BtGg8Ty9aS+cqsgKYQUSTs95i1dXrhrUgoeRNLX
         Lb6A==
X-Forwarded-Encrypted: i=1; AJvYcCU6ozqCAan5hhujHXfQmOcIoxQDBhCRjOcUNERRxQn7axFdmPh5+dW7VePV0wHlViNfsq/2vNw7MwRbc9d3sGveG5Z3USBG
X-Gm-Message-State: AOJu0YyGEMumuYRA0dEem6G+b32yx7DRBu8YFW9rrYV1iu1+CTnM05/8
	4AYdLVSY4lm4gZDMqq9/ieDXuPhY7fgOjldz/TjOtxPe/n+zT+LMKOlfyktRfnonfakiwuGwb6V
	ASJYFUSpE9g==
X-Google-Smtp-Source: AGHT+IEiwzkJmAE73h3qQODbSuiTDrrRPohI/cfxQYGO30HPZULd9EBV8unoa9anfmWGobB5mhyxt6zE2fRO6A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:943:0:b0:e0e:445b:606 with SMTP id
 3f1490d57ef6-e1180b9df3emr32369276.0.1724170143291; Tue, 20 Aug 2024 09:09:03
 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:08:58 +0000
In-Reply-To: <20240820160859.3786976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240820160859.3786976-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820160859.3786976-3-edumazet@google.com>
Subject: [PATCH v2 net 2/3] ipv6: fix possible UAF in ip6_finish_output2()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Vasily Averin <vasily.averin@linux.dev>
Content-Type: text/plain; charset="UTF-8"

If skb_expand_head() returns NULL, skb has been freed
and associated dst/idev could also have been freed.

We need to hold rcu_read_lock() to make sure the dst and
associated idev are alive.

Fixes: 5796015fa968 ("ipv6: allocate enough headroom in ip6_finish_output2()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vasily Averin <vasily.averin@linux.dev>
---
 net/ipv6/ip6_output.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b53effc80f8b3b7a839f58097d021a11f9eb37..1b9ebee7308f02a626c766de1794e6b114ae8554 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -70,11 +70,15 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	/* Be paranoid, rather than too clever. */
 	if (unlikely(hh_len > skb_headroom(skb)) && dev->header_ops) {
+		/* Make sure idev stays alive */
+		rcu_read_lock();
 		skb = skb_expand_head(skb, hh_len);
 		if (!skb) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
+			rcu_read_unlock();
 			return -ENOMEM;
 		}
+		rcu_read_unlock();
 	}
 
 	hdr = ipv6_hdr(skb);
-- 
2.46.0.184.g6999bdac58-goog


