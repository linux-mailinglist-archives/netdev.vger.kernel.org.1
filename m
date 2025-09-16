Return-Path: <netdev+bounces-223651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2E0B59D11
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5327AA5E2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528802DA751;
	Tue, 16 Sep 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKg8DRyV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76F32859F
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039006; cv=none; b=jkW9QXpMhJWS/ZaoU5n1BOvRElpzbMlouiGxoEw0Yjj5AMT8yH7RXQai/P47N79TyLenISAFn6hxPQ8UxmIYXQmtJBFfFXvblawWCpdx+8ExAygrTUATstGgDyjNFmJobmsBHKwuUH/7ROoiNX0w1eEGLbCLvBWgN+LgR3cI4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039006; c=relaxed/simple;
	bh=oWg3YNnWYACtDAPbF196PRRm69HK4VFomSGjvc3j1jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EoZ30x5kjgtTp3Yz8SEv1HwlewOkpQq6p/6kTXSddguBrEwULU6qzr+vD+6MoD2OVWzOeWOLiR1It7ABaPsuEKzOipGFnzynMfWvkLwYf9sLC2PS4yyezaTXghml8uJ3oo5Njf+8i9Koz0Y0v6TRRbSQ52/sN6akQ208ZAmBklo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKg8DRyV; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b5f31ef7dfso102061cf.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758039004; x=1758643804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1ic1ShNX20oOOQyhH3LedNKHClWbOwoDP9AaCm/jgc=;
        b=MKg8DRyVk0IKr/6/fdv6NM90k74ISvpNP8wFvHhcSXHFI3HnOPNLr1whRylmWF1Ege
         nqrPvpTW6Y70GullV92A8xmadnmIZYFQ58HQFNUr3NFchzEu+ubi66zpDKD9w/IdwflK
         JezYWOHyPbDStxgbyQ/D3AITGwkXpxdqcKo2oxtv7R/WGqZn1GAeH7xUndlwTiVf85R0
         KkcLzwzbN15Y+LrqhmY9f/fihslbEofwnMnRn+3BFt5nE7wIFolWlg2udbL6YaUDyjP7
         BPUgoThSxAZig3paLNhlSmIMQjscqgXYho0/H9fP5ZMWgp9yZheYaCEbTgRH6ZgfsSQB
         5DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039004; x=1758643804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1ic1ShNX20oOOQyhH3LedNKHClWbOwoDP9AaCm/jgc=;
        b=hJevm4zkDGibo0+m1w3gAMORyFuJjFvI5svtyxnJK4wr6kATQfBeVt5A9TpH1eiN02
         Rzc1o1l4/EJB30qJz+HrnF331RIVimt0+eK2nGxGiKdzm219OlCHo7WuWO2Z2e/AG1UO
         /j1UPtQTOAz3qPxoCxO5m549kb4gRSPZ+jPqoHa77boBlx6ec8PGHfVs7ZbKds8OE4/Y
         U97D3jYZI2tMadbKeh/zoOhih/DzLmM0p7+P4q3uySvLSdc6k/dzTWEFi7V22pQPSVGn
         IJKiZJaj3uGPA0V5A2IJNksN25XQ3D71ZzPRafqDydJIkcQe+9UyRQ/4UiYYAq32REXT
         B9/g==
X-Forwarded-Encrypted: i=1; AJvYcCW/5GhTh9IE0lXXLXDiEi1ETVfgVJlYNq/LjvmcCjMatiLXCeZchjhdyLMqb3y1y3XLY1+zPnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvpxBfJ/0K4REbWJl4mYkLOH7nWc1qVDQ80wLyzabYkJQCACk
	1+AebcbdRUDHrJi3wnlH5sDEhilouHs5Bt8kFV4sLOPdsrzIXofMtx9xMg2yaq1ucObkp22m/pg
	1jmwUWqLGyXHV/g==
X-Google-Smtp-Source: AGHT+IGByW6xHflvJK5BPoMZboX5+Bje2atIKoUne+h4jfggV/ehCHcv1TaNHlSyq1vP8g8qz1FGdrOY9+6VTg==
X-Received: from qtxa13.prod.google.com ([2002:a05:622a:2cd:b0:4b7:aab6:1b3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:488a:b0:4b7:a8ce:a40f with SMTP id d75a77b69052e-4b7b44829c1mr28396081cf.10.1758039003656;
 Tue, 16 Sep 2025 09:10:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:46 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-6-edumazet@google.com>
Subject: [PATCH net-next 05/10] udp: refine __udp_enqueue_schedule_skb() test
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 5a465a0da13e ("udp: Fix multiple wraparounds
of sk->sk_rmem_alloc.") allowed to slightly overshoot
sk->sk_rmem_alloc, when many cpus are trying
to feed packets to a common UDP socket.

This patch, combined with the following one reduces
false sharing on the victim socket under DDOS.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cca41c569f37621404829e096306ba7d78ce4d43..edd846fee90ff7850356a5cb3400ce96856e5429 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1739,8 +1739,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		if (rcvbuf > INT_MAX >> 1)
 			goto drop;
 
-		/* Always allow at least one packet for small buffer. */
-		if (rmem > rcvbuf)
+		/* Accept the packet if queue is empty. */
+		if (rmem)
 			goto drop;
 	}
 
-- 
2.51.0.384.g4c02a37b29-goog


