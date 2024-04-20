Return-Path: <netdev+bounces-89804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269848ABA09
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 09:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77BD1B20E14
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A610A3E;
	Sat, 20 Apr 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8GKubQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F5101CF
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713596480; cv=none; b=R0wYcvOlrxSzSqpuOk7uwPLqtXAGsBAAcSIBn52pAmiIgf6/jyAFFEI98mXT4YB4CZN5wXkRzQLnt/uRy8lMgI+w6F5A3icQW0UUUHAwDbPeGb2O/8svlwNQHuf5fG6MYclDyyt53N21IgI9e3plT7yv46z3S/HNKq8bHX8bOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713596480; c=relaxed/simple;
	bh=ZMUUqOB4D5t5yMFOwxUxpJqh/1JOdrP1d4t4rajhJGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gQdIsxIufE3w3f8/HRQEuxEAKipFOSq3J9AwwSHY34nDznq8AGb3DUEoQkh9krOLce6Y210N3Of4ZLkyxUsVh3uVzqL00mns/Vow4e36ZTRTlMhB5Iyu1Q+s1ih/uLryCYpmSSTQUfumSzza/Xc2Lmdg95ApHIaH5nGl/BSz4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8GKubQ2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b3b02f691so21238967b3.2
        for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713596478; x=1714201278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P57su8mgviErUG7NWilf3GARZcpiMCmVmtOu5jbcJr4=;
        b=H8GKubQ25xmtOqNHr9e3zX3S2/nE1OGNqUFYh+BoU9dJvFKzp6l2ri2QCoqOLp7nJ3
         ymMQawra4ZO282vezM1kxpO6MbcU0Bqbma0kvp8xWu9UOAUim+COXEe26VI0/HHjkEOa
         pVTPct0/0Xynz+9T3ndBEfl/YtDRgju3D+uPLTsKdBdZw8ZuscOaB5MTk4oJn9+FxZs4
         W54ZtDVGkZ8JPIoMTx1vB2AI/cOhoSY7HSFsF0W/7kE0IBVSVmCPJuNa66t2X93jR1Pn
         TvnaDFdRKh/ndt/ItALXyWQqlaaslrY/j1J4ThiGLSdqr+HGLxetAm+4olIJpS9Jkzgx
         yUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713596478; x=1714201278;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P57su8mgviErUG7NWilf3GARZcpiMCmVmtOu5jbcJr4=;
        b=pzG15CO6Ut2MZzH2C1BaQZ8xwWKwR7Z9TFZScXZOcE7Dk1kmhyise5A9DocNp5L/rx
         1BNjlNpchcBShs8vC/yF+QCuc70FIBS4yW5Nlnr9M7ydTrX/BRR/X1GM1wt2BI7Buil0
         Z2rPli7RBv58bOIO2ySWoQ2cJNu/ec1+gpeyruT2m0ekeCZVLekuap0Dqpr2LmVu//iD
         oFAJ+vs4dNUviG/971NcqnJHC4YolFmjCezUIQ3VlciGt4EaaC8tLIOXiQirk/ni+A1f
         o8o25xS1vU2LESItPH3F7cuSf8njTgbYPy8/84tAAxCj88zaV0n7wbfefFCLqDX8IvSK
         +3+A==
X-Gm-Message-State: AOJu0Yyi/ITyU2tLtf5h5jdHjgEfyLeQBhHsH9/PBdvDql0Zp30wZFQZ
	CXdA11SOjJ7rrE80VecGYK8Kz1stvLRf3dwXYqc/cWlWNA0yZzj8jZ8zX1KzHPf+IHbf7XRNWJM
	ZCjFJWXC1mg==
X-Google-Smtp-Source: AGHT+IFf2j7HIJXbSXSQDR9b/QLUS7qbiUTgGsKdvmYvHcwjk6Dxco80LBT3HKiDw9cfJUSlYXuYYyxX4l6XCA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154f:b0:de5:78:34d2 with SMTP id
 r15-20020a056902154f00b00de5007834d2mr62426ybu.6.1713596478100; Sat, 20 Apr
 2024 00:01:18 -0700 (PDT)
Date: Sat, 20 Apr 2024 07:01:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240420070116.4023672-1-edumazet@google.com>
Subject: [PATCH v2 net] icmp: prevent possible NULL dereferences from icmp_build_probe()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Andreas Roeseler <andreas.a.roeseler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

First problem is a double call to __in_dev_get_rcu(), because
the second one could return NULL.

if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)

Second problem is a read from dev->ip6_ptr with no NULL check:

if (!list_empty(&rcu_dereference(dev->ip6_ptr)->addr_list))

Use the correct RCU API to fix these.

v2: add missing include <net/addrconf.h>

Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Andreas Roeseler <andreas.a.roeseler@gmail.com>
---
 net/ipv4/icmp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e63a3bf99617627e17669f9b3aaee1cbbf178ebf..437e782b9663bb59acb900c0558137ddd401cd02 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -92,6 +92,7 @@
 #include <net/inet_common.h>
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
+#include <net/addrconf.h>
 
 /*
  *	Build xmit assembly blocks
@@ -1032,6 +1033,8 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
 	struct net *net = dev_net(skb->dev);
+	struct inet6_dev *in6_dev;
+	struct in_device *in_dev;
 	struct net_device *dev;
 	char buff[IFNAMSIZ];
 	u16 ident_len;
@@ -1115,10 +1118,15 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	/* Fill bits in reply message */
 	if (dev->flags & IFF_UP)
 		status |= ICMP_EXT_ECHOREPLY_ACTIVE;
-	if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (in_dev && rcu_access_pointer(in_dev->ifa_list))
 		status |= ICMP_EXT_ECHOREPLY_IPV4;
-	if (!list_empty(&rcu_dereference(dev->ip6_ptr)->addr_list))
+
+	in6_dev = __in6_dev_get(dev);
+	if (in6_dev && !list_empty(&in6_dev->addr_list))
 		status |= ICMP_EXT_ECHOREPLY_IPV6;
+
 	dev_put(dev);
 	icmphdr->un.echo.sequence |= htons(status);
 	return true;
-- 
2.44.0.769.g3c40516874-goog


