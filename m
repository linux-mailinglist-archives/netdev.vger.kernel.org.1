Return-Path: <netdev+bounces-162122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A5A25CEA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291D51882714
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9394E2135B1;
	Mon,  3 Feb 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQhOZsRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677B21324E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593074; cv=none; b=qwRb2s09Lyur3wo9UPHGQN/vl+RnPDPEUeHBgh+ZCg+CCQCrtARwCE/2DiGsaEHXnkH2L3eliDDMxvNBR4XsKBxKTXdX+MOfHe+2W21HeAc/aq7nojmPCSjjjJIVGA0N1uqxwIdRz4ywGUQFcp+q/Kl3OmxCLzJmkDc7GnxWJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593074; c=relaxed/simple;
	bh=IjoS0wZAHK91Jak8vmBaki/M3ogZdNysqnPdn+F/nUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BB9qDdXIAKUgIaAJpd11oPcmZnsQyGGyfFD5Wf+uJ6OwdOQufHzGcrJAvhCWNtlJl8k8nlxgP5H3D4qLI+oEnadaRtsbDrU+mcNixv7970d5Uix7l1Y0NgQh797oJjjQt8WcL9OOPOO2KTuhdHPsthqs5DJ4YZuqt6zUK9GLuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQhOZsRU; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-8618bb82d64so3527455241.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593072; x=1739197872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7cOpAiJ3jNVE76pwOVOdST2btjk2f5QzQeM6NMvd44=;
        b=gQhOZsRUQumfhnwn8CqZ0rAGRoKc7f8Xdb7XV+z2IIq7z7IpG5D4x7ATfjBZVb6ZUP
         Y8CaWkSgdzuMuCH4P9rcCjGIVPKzzBcQYKedK9r+5n1qpn0vQ6OdOMkkA1Uwhx6wOkNF
         HcLj2a0SyxyTfJGyOx5s37mBJDxxyeB6VNDdaNpx/+Eqe8pfKNhZ2bXbaC9w2n5NklX2
         FK4DxWRd9fYhSp0vg92iXUzfw3YA3Ls5VOiNaaLmNUnR0wZZ1pK2lERLrMLEux25TnXe
         F/JQepAZ6WEd38DPkueJj27BnAQ85NJuUr4xMEmzkQ4M89OeYrLCPaAyM3uLKckswGkZ
         ky6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593072; x=1739197872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7cOpAiJ3jNVE76pwOVOdST2btjk2f5QzQeM6NMvd44=;
        b=qJ3ZYbp2cNV/YUGGI4/knbU9j8E0fcHQNpOZ8Ageufa4PYYdsaENhuhm/6QAAk0n9D
         aq19gIbtLkLFNJ/T6dH6MKgeA3A37YghBiJIVi3FCBXap+/mIm0qHRMUNECbPn0BLwel
         pvhPujwfiCUHMF9c1F318S4NGDJrTeDO/GVe4G4ctPgBlrvUMBlT6p/hYWdENDtz40Sk
         Vaq0kNdROd7+LuMVXKrct8d42tfnM+F7iAqJ1GEE3iQfnRG7Y6gD+HfE4SoBEK+0hrkm
         vz0XrB8+GcptRBw8MP/OCJ7Ka83ZINQXvxhBgyypurMY4thJd///TTViwZro66ejNf59
         udbA==
X-Gm-Message-State: AOJu0YzNZqhRYusOqF3Lc3pOHtHjFQfhDeGmwictx+FWJt/rZ2EQ6kLT
	No3A/VS7hdRTDMEcRyBjoRGzWqOzn39saXZNGmI9tAqTAtrsdezofMdkEmOXayuCvwyh1REYbvI
	EHjIoLzm9bw==
X-Google-Smtp-Source: AGHT+IFFz3SCpMPRTODCQql3IkyG5Q3sc9i0uOkafAh/IYFDjBycQAls+X0GwOt+xnOG2FMzoXon51p3iAc0LQ==
X-Received: from vsvj37.prod.google.com ([2002:a05:6102:3e25:b0:4b6:8e99:b5b8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2c03:b0:4af:de39:8daa with SMTP id ada2fe7eead31-4b9a4f27c13mr16417753137.4.1738593071820;
 Mon, 03 Feb 2025 06:31:11 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:46 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-17-edumazet@google.com>
Subject: [PATCH v2 net 16/16] ipv4: use RCU protection in inet_select_addr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_select_addr() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: c4544c724322 ("[NETNS]: Process inet_select_addr inside a namespace.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index c8b3cf5fba4c02941b919687a6a657cf68f5f99a..55b8151759bc9f76ebdbfae27544d6ee666a4809 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1371,10 +1371,11 @@ __be32 inet_select_addr(const struct net_device *dev, __be32 dst, int scope)
 	__be32 addr = 0;
 	unsigned char localnet_scope = RT_SCOPE_HOST;
 	struct in_device *in_dev;
-	struct net *net = dev_net(dev);
+	struct net *net;
 	int master_idx;
 
 	rcu_read_lock();
+	net = dev_net_rcu(dev);
 	in_dev = __in_dev_get_rcu(dev);
 	if (!in_dev)
 		goto no_in_dev;
-- 
2.48.1.362.g079036d154-goog


