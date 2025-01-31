Return-Path: <netdev+bounces-161792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B5A241A3
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D37188A63E
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481DE1F03C4;
	Fri, 31 Jan 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czy10cD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B61CBA18
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343623; cv=none; b=EhK+eEY6Hd2gce7Vrq68jIC4AsQu2YILmPGUniLXMUVSfgGjjyng/D094/TKujSd8Jly7c7UA2/wDdvedhyNGLu67x+ESsbe2ksz1hoQOQKYQi0ZN2PJb4r5vaK2Xa9iYS0fFxkQ74UVMQaz73nNLJXuGs2T8Gzk6IXnWKG4Pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343623; c=relaxed/simple;
	bh=xXgc4Sduo1CFevQ7c/LaDTOMMqPiBo/n8KBpuOLAges=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdX94lefoFHkUlNLIJCQ1NyYnbLhhJ3d3GupdRB80MUXXyIr0l+MO3U+Wde5Fqa4t7ZmnbrYO5L8LEcEscA2LYoz4Ef2nvuDnpu0y+sS/P4MO6Owui7iNTBToxe+erT1ERFi/PEas8J7ercJszspAoDj9n6ZfZ/3PLtVNxmTAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czy10cD+; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6dd43b16631so25761196d6.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343620; x=1738948420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1sV2PSp5eBVlqTics1iOeb/nbhMMTCnjhD5M/2eNwCQ=;
        b=czy10cD+EPfaqam/MyKW8ubWmyRZRAERhy2e8ucSWV/SvOB+Mu7ftQZWVGOrDSwIzL
         epKho9OfTTwXD8IDKiR3RuU9xqAHnIDVbi/cuIL/aYSvI5rLKghOn1pftggVeW9sKnfK
         ztNMjE2ppcZKXCno/MfEMfQSoDxgpV2fPM2NzieyzYpFZkCXwovTvKuqz/32PKWx+Hhe
         /g63vj54uD5VARalchAnd3trb9EsmKvdqytb4HN+pJwRMXzx89l+od21SD3GvYSDDfRc
         GYSWYXNYU3wZiN8qfIn2MT+bB3La13dCYpg0kvSg9a0S9FdbfwbOE+3ODAurkjS/6DEW
         Bpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343620; x=1738948420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sV2PSp5eBVlqTics1iOeb/nbhMMTCnjhD5M/2eNwCQ=;
        b=COAdpmiV3b2lsuU1J1qp0EUdGvM2j2p3NaQSxrv/bnsgJ0MfJBsHHtFhZLpS6fwIjp
         1JJuLV0u8Nx2c735gmtfnrDtCZrnxfVLm3Ew/cn5NFG0C2RQBV4QDA77MR/wAa96+D5L
         wUfvCgdF1tXHNXb8d5EvhrX5zkqpvOAjT1B3jiTVXau8JowMJZ92m/g0xboJQsqowqMt
         HsrChl2rlSDsS3VbTJGxUWJuOC4CnX1TnBDZ7dv88BxjYlGpmJFEBiuOn6Hkn+Co21AX
         yPXxuqjNgU3gkp+sbSx0IRtE/zifK9tyxxG/xuflKdCMRJjnLsH4755u6VM7R69yFiWN
         wgaA==
X-Gm-Message-State: AOJu0Ywa1UNbpj54K7lzHTO/WBUZ/ceoSiyUiHEonNjaD36zwWpuaQjx
	w+7DZPjTCXQfuziKyVZzj/hTqOXZNDrhaHHr1t85+zlnezN8lT1QtDHnhBs4geVjXxbqaDBzoOj
	5VO6yn9o7xQ==
X-Google-Smtp-Source: AGHT+IEd9tSBbZuj4TZBdK/0zPv27KY0BRarl9lCUjHtf6Qlq2sOp7zGmKjUWjaKdu8F/zOL27gVqxnfESogrQ==
X-Received: from qvbmf15.prod.google.com ([2002:a05:6214:5d8f:b0:6dc:c098:fa40])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5dc8:0:b0:6d8:8f14:2f5f with SMTP id 6a1803df08f44-6e243bf8ce0mr193896876d6.23.1738343620436;
 Fri, 31 Jan 2025 09:13:40 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:19 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-2-edumazet@google.com>
Subject: [PATCH net 01/16] net: add dev_net_rcu() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->nd_net can change, readers should either
use rcu_read_lock() or RTNL.

We currently use a generic helper, dev_net() with
no debugging support. We probably have many hidden bugs.

Add dev_net_rcu() helper for callers using rcu_read_lock()
protection.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h   | 6 ++++++
 include/net/net_namespace.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2a59034a5fa2fb53300657968c2053ab354bb746..046015adf2856f859b9a671e2be4ef674125ef96 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2663,6 +2663,12 @@ struct net *dev_net(const struct net_device *dev)
 	return read_pnet(&dev->nd_net);
 }
 
+static inline
+struct net *dev_net_rcu(const struct net_device *dev)
+{
+	return read_pnet_rcu(&dev->nd_net);
+}
+
 static inline
 void dev_net_set(struct net_device *dev, struct net *net)
 {
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0f5eb9db0c6264efc1ac83ab577511fd6823f4fe..7ba1402ca7796663bed3373b1a0c6a0249cd1599 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -398,7 +398,7 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
 #endif
 }
 
-static inline struct net *read_pnet_rcu(possible_net_t *pnet)
+static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 {
 #ifdef CONFIG_NET_NS
 	return rcu_dereference(pnet->net);
-- 
2.48.1.362.g079036d154-goog


