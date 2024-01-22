Return-Path: <netdev+bounces-64643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619F836205
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C36B23208
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D083FB0D;
	Mon, 22 Jan 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38qU6XXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D53F8FF
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922780; cv=none; b=DozOUhxElWNSoUSzSym8n97IICMqgj+kf7Zq4tmeFZjN3n62MS7MIfxSrfSXuK0ZwZIosTiNGrSoRU2kArKcnPZU5hrvomsmt/1jX4vV/FhFoHenNY6bLwbpIlerEBl4S6m9+TsAVt3POPoBSPSuDWJ/5bZCfvBb14TLHLk+5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922780; c=relaxed/simple;
	bh=HezA1duvjZ/sW5mwo90gRT1xJEEszUdbV/MwMHi4N8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hcPWGohOx6bWeNM9A5FRcBZRYcA/V9/3oH/wx0mMn8U/djp6qnP6cvjpNQyAFU07doPCXtPNlB7JPbiaulybQnw7COimD5MaXl2fkYY6hvfR1vSkdFNte+vqVjQKvt3nRq+EJ/P5B8XtX+F/1ExZuIYxinSxUiBo09TbQvrMD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38qU6XXs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf1c3816a3so3379989276.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922778; x=1706527578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jPYNiXucpIuy1PBjLBp84tbaqvtfecdfKCQIVbQFJE=;
        b=38qU6XXsVVyZXs0dd3liEHQygxeNY44D+MlsHNcdEpLO2AePD+xfdhHMJyN7rylj4o
         /Wt6zH5DUAer5Xg4JMXiqCv7PCSuNYBKXDj4Q+TxuFf7AIB0izrY8gkLzupZ+rnlR6Ef
         Tr+Y/pwrftbTrRi8nKuay0QfOmFq2SqGcVf6xvK/RpoqckNxSr61CdzBHv9XqCULRecq
         eDLHtae7ClJw4Oae3Xz32b5TfmkHcsMH5JJJiwLpiEfyWPkdYdZbP0DY0kF7ZHkLuKs+
         /NxexK29UyIpez059gyuMSKmXLWAfL/KzP8R0nC/yFG2orY/9vzHTTLHUpU3p8m4IVK8
         UQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922778; x=1706527578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jPYNiXucpIuy1PBjLBp84tbaqvtfecdfKCQIVbQFJE=;
        b=aHm/s9zyqDVsCkMjZlXZ6Pr1CnQDqz89z4iQSsUX2Nmvkysax93Pc0z99V3fawhT2e
         hlvbbLFIgSdA31/Wiet9l5xwsuq4GUPvpSzTBBDeIDRY/j4i04BUDz1OK1mYlPMQqjDK
         48oMelXhDM80Lh2Gr54VNd4fVppOMcDiaA8ATvZr1JmOLmIOuEAdRKbGST2ZQ+/oB1sA
         Wt9HOuJJUMHrSmlsAbTSpzj6auQGLqGxMA6JcJ0GPZD5jKUYuKOWV2PemXHRfPjZCUuW
         KttAjC6pZcpU7MTcbTE3dBkd7pY3UnfJG6Erngpb44d5Jm2BmnsJFFGTfTvspetIL5Yh
         5apQ==
X-Gm-Message-State: AOJu0Yxt01o8Vx0KX8w1WMIlw8HmCqM6aymrXpj7msC1FOdKarXFA8cL
	4W+j1nvyRkH7fL53jIkeDu8BM7IrrLIYpvRO17Ruv+COIdtZxGAKdv5BD8Jj8NgWZnKQrdPFGil
	U1/zJj4M4Vw==
X-Google-Smtp-Source: AGHT+IEOdaHhneuu5fN+Waa/QqW2Qpvh3/hsflIqOyvDI5wRWixSOBXZkjlGphVPl4T5vU7ZVKy47L1YwFigsw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:a88:0:b0:dc2:5273:53f9 with SMTP id
 h8-20020a5b0a88000000b00dc2527353f9mr242883ybq.1.1705922778612; Mon, 22 Jan
 2024 03:26:18 -0800 (PST)
Date: Mon, 22 Jan 2024 11:26:02 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-9-edumazet@google.com>
Subject: [PATCH net-next 8/9] sock_diag: remove sock_diag_mutex
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sock_diag_rcv() is still serializing its operations using
a mutex, for no good reason.

This came with commit 0a9c73014415 ("[INET_DIAG]: Fix oops
in netlink_rcv_skb"), but the root cause has been fixed
with commit cd40b7d3983c ("[NET]: make netlink user -> kernel
interface synchronious")

Remove this mutex to let multiple threads run concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock_diag.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index 5c3666431df49b3c278ef795f11ba542247796a6..6541228380252d597821b084df34176bff4ada83 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -292,13 +292,9 @@ static int sock_diag_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 }
 
-static DEFINE_MUTEX(sock_diag_mutex);
-
 static void sock_diag_rcv(struct sk_buff *skb)
 {
-	mutex_lock(&sock_diag_mutex);
 	netlink_rcv_skb(skb, &sock_diag_rcv_msg);
-	mutex_unlock(&sock_diag_mutex);
 }
 
 static int sock_diag_bind(struct net *net, int group)
-- 
2.43.0.429.g432eaa2c6b-goog


