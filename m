Return-Path: <netdev+bounces-197910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC2ADA38B
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 22:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C947A6F7F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6CD27E1C6;
	Sun, 15 Jun 2025 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j58uOYQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F025FA31
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750019721; cv=none; b=SI/oUPTubs4giRVdrWUuWJnlzGrg1NMIIBIkQuas4me7SUIX7BHR8O8HC3VA3btVUOt0NRb2JcFwJbsZN/aNuV1LFK6ugSEF/LoUBCRgrJ2Se6VrDaEao3mmNN9aGskGHfd3Wkip8Ky03Rlq3ang/11ZXS88FKBYdj2mOh45Rsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750019721; c=relaxed/simple;
	bh=hTKdS9FbvzhPeEzVA/l/oUc1Qn5lQUnlHrMSxWhY3j4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V2m9UbWbjDw+NDYqglzCWPV1Jzh156MG/T8osfdFGLe8bfjbgRadDvQ8N+kRVMJFfbWkpva3Hi7Hlwt+YoCeEZh0ncjxmAhk0b2lB/4WMcxPUG63HeMgqBAel8rooL6ov9wXhOOBC+65H5ygtcnNUzYHvqIh4nLwH0z1rcir7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j58uOYQs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23632fd6248so33324335ad.3
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750019719; x=1750624519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TnJOTvPpBZ4s9blihdz8QHYWoHM5MocYduDMaUYYCKg=;
        b=j58uOYQsh6v6ePcU03wlPusr6ITlpxn8/A7zyUFhBNPNHSTRDn/Q1Q/j2cfd3TVj+m
         Tz1Z8AOneaW09P0FRxODVY9CFMBbJRoHU45TJEnKVyM2KaulMrEtw1jLPbfUNd9umXe5
         0VMgU7bxwSLaSNGouBHP7/crKOipQwDHb+MmtqwxFaR+EAyYmZFQBsI80NodQKBiNX8o
         /9RmsA/nu5/sdFG1gmrDN1xbXVoTnBunPCjFrSy+z3i8R/x9yqN04XvOr5oe4un3IC1M
         V6cq/J7Pn34Ip/8Vm8pw2aRBuS16Eri4VW4bj0qNO5i80B7SRq5QVVrHyu4kVtiwU09e
         +ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750019719; x=1750624519;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnJOTvPpBZ4s9blihdz8QHYWoHM5MocYduDMaUYYCKg=;
        b=OuP7+GUIpZ73D4iT+QtIORVmdW/tw8yZjyoFyG3S1Lu8Q1szVkfMvMPOB+eQEhnjZS
         pT/Q43i4X1ikrruyAeBWCS+4xGU83rjzB+L+oMSXS2WOQ7MPQMnHgMptogJEOLA5mNlQ
         fHt8+RfzcV8HgXJ08nOBpOPcd5PmlFirCYZzJ6IPOO7hNGVx/c1wIeEeXP4YGP50EVdJ
         oGIV9hEDPo6P/APR/7liLtsh7bGxbjjkkduj0ghRQSwi0niIJltsxTFUrX5+dvXHx/rR
         tmP0vpXX0m9nkOtJOE5q/xgbyfFVgpAUSDlwguOHJJvH8mw32PF1jsNLoYC4UWSX6SX4
         cIVg==
X-Gm-Message-State: AOJu0Yy6JwYmhARDmLl2ObvZ1MSdQOtsFmpIicRJkInHWWgf2yC0DOJQ
	1+2/f/2OBiNTgUvyNLSUSWE1Ym5T7uxzbWA+ykz8bjLhxyGHMbaA/H0xs7I3EtMxhUjwaEkIS1P
	yNBKujEDeQjal3SL1por/riWzPLQ5dHVMmvPEQVEW/npAL6dSddWzpYRrGXvAfYGbu3mP6U+ETo
	yykqS7pzgN7LjCiciERgB1WCGASXEEQtPsMARpKxkRqdnBaNOKdGzuzKkqEMH1QlI=
X-Google-Smtp-Source: AGHT+IEwZSAcU4kaXuKVgkMjf0a9b/HiTa8nTDiEYfTo3yZsML1DJgkgidP9XnaWOOl2cec2ZBI3/xpDqQ+ecXcFIQ==
X-Received: from pjzz13.prod.google.com ([2002:a17:90b:58ed:b0:2fe:800f:23a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a6f:b0:235:129e:f649 with SMTP id d9443c01a7336-2366b344077mr117727625ad.12.1750019719118;
 Sun, 15 Jun 2025 13:35:19 -0700 (PDT)
Date: Sun, 15 Jun 2025 20:35:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250615203511.591438-1-almasrymina@google.com>
Subject: [PATCH net-next v2 1/3] netmem: fix netmem comments
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"

Trivial fix to a couple of outdated netmem comments. No code changes,
just more accurately describing current code.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2: https://lore.kernel.org/netdev/20250613042804.3259045-2-almasrymina@google.com/
- Adjust comment for clearing lsb as (Jakub)
---
 include/net/netmem.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..850869b45b45 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -89,8 +89,7 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
  * typedef netmem_ref - a nonexistent type marking a reference to generic
  * network memory.
  *
- * A netmem_ref currently is always a reference to a struct page. This
- * abstraction is introduced so support for new memory types can be added.
+ * A netmem_ref can be a struct page* or a struct net_iov* underneath.
  *
  * Use the supplied helpers to obtain the underlying memory pointer and fields.
  */
@@ -117,9 +116,6 @@ static inline struct page *__netmem_to_page(netmem_ref netmem)
 	return (__force struct page *)netmem;
 }
 
-/* This conversion fails (returns NULL) if the netmem_ref is not struct page
- * backed.
- */
 static inline struct page *netmem_to_page(netmem_ref netmem)
 {
 	if (WARN_ON_ONCE(netmem_is_net_iov(netmem)))
@@ -178,6 +174,21 @@ static inline unsigned long netmem_pfn_trace(netmem_ref netmem)
 	return page_to_pfn(netmem_to_page(netmem));
 }
 
+/* __netmem_clear_lsb - convert netmem_ref to struct net_iov * for access to
+ * common fields.
+ * @netmem: netmem reference to extract as net_iov.
+ *
+ * All the sub types of netmem_ref (page, net_iov) have the same pp, pp_magic,
+ * dma_addr, and pp_ref_count fields at the same offsets. Thus, we can access
+ * these fields without a type check to make sure that the underlying mem is
+ * net_iov or page.
+ *
+ * The resulting value of this function can only be used to access the fields
+ * that are NET_IOV_ASSERT_OFFSET'd. Accessing any other fields will result in
+ * undefined behavior.
+ *
+ * Return: the netmem_ref cast to net_iov* regardless of its underlying type.
+ */
 static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 {
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);

base-commit: 8909f5f4ecd551c2299b28e05254b77424c8c7dc
-- 
2.50.0.rc1.591.g9c95f17f64-goog


