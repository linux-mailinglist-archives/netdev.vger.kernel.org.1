Return-Path: <netdev+bounces-167676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8AA3BB94
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED272167BD3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304061DCB0E;
	Wed, 19 Feb 2025 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bmzNqNAt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D62862BD;
	Wed, 19 Feb 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960573; cv=none; b=jUe69J3YrAYwGYVAz26FdpNylQdYfB/8boMtpqpGvYDebZKsEBULRHWCRVyVt6Sv/5IGzed6aYraAWrizUm6nYGKnzKeoXX/tzK11EoyVH2f3JCpv1TWYpBWUGDEqqvqIibB0QKa7ng7ur6aO6HUQ69c+/ed3ijWVU31+nZgwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960573; c=relaxed/simple;
	bh=C3noKkJWwp17LzG7wlKjy20vi25mr9Eyjutxv9Yq1Sk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=As6IqnllJjR3uwPo05xjR9N4mLdCf4bdsK8JkhHN4B0xzdSnleGd5pjdOVXXttNJdMPb9Fh6Z1lrbQj7PfL3wL9iZ8McOFts8NMaOuXIxAPjyi9QW3jHXZlIH9Rqd593qdz2IoJ45pe5M533uqiduvm3/QX45K1yMybd+tAgUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bmzNqNAt; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739960572; x=1771496572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8PmoDecdNcK/J+X+JpbVVegKJDo4I8npFP12Uez3jOo=;
  b=bmzNqNAtE9CvbCCEtvYXXtTGRG9gq5RD0RXUDxF6ckagPLr4AdHAph4T
   +1gh66fFwKFBX7l6w+o7Fc8Gly6gFJhOq3x00Cq7CJBjSo2YGoueXlqER
   CBU2uo/W5/cstXwa1EppHN/KFdNiG0X5ge++w1laCfp8nIp/pzBtzdeoL
   I=;
X-IronPort-AV: E=Sophos;i="6.13,298,1732579200"; 
   d="scan'208";a="409856996"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:22:47 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:24318]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.53:2525] with esmtp (Farcaster)
 id bb7ec826-7ca5-4740-a4ab-9f0b515d9ffb; Wed, 19 Feb 2025 10:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: bb7ec826-7ca5-4740-a4ab-9f0b515d9ffb
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 19 Feb 2025 10:22:45 +0000
Received: from b0be8375a521.amazon.com (10.118.247.54) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Feb 2025 10:22:39 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Gilad Naaman <gnaaman@drivenets.com>, Joel Granados
	<joel.granados@kernel.org>, Li Zetao <lizetao1@huawei.com>, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kohei Enju
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH net-next v2] neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified
Date: Wed, 19 Feb 2025 19:22:27 +0900
Message-ID: <20250219102227.72488-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

kzalloc() uses page allocator when size is larger than
KMALLOC_MAX_CACHE_SIZE, so the intention of commit ab101c553bc1
("neighbour: use kvzalloc()/kvfree()") can be achieved by using kzalloc().

When using GFP_ATOMIC, kvzalloc() only tries the kmalloc path,
since the vmalloc path does not support the flag.
In this case, kvzalloc() is equivalent to kzalloc() in that neither try
the vmalloc path, so this replacement brings no functional change.
This is primarily a cleanup change, as the original code functions
correctly.

This patch replaces kvzalloc() introduced by commit 41b3caa7c076
("neighbour: Add hlist_node to struct neighbour"), which is called in
the same context and with the same gfp flag as the aforementioned commit
ab101c553bc1 ("neighbour: use kvzalloc()/kvfree()").

Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
Notes:
    One of the SLAB maintainers (Vlastimil Babka) looked at v1 patch and
    double-checked kzalloc() is clearer in this context:
    https://lore.kernel.org/netdev/b4a2bf18-c1ec-4ccd-bed9-671a2fd543a9@suse.cz/

Changes:
    v1: https://lore.kernel.org/netdev/20250216163016.57444-1-enjuk@amazon.com/
    v1->v2:
        - Change commit message
        - Remove the Fixes tag since there is no real bug now
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d8dd686b5287..344c9cd168ec 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -518,7 +518,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (!ret)
 		return NULL;
 
-	hash_heads = kvzalloc(size, GFP_ATOMIC);
+	hash_heads = kzalloc(size, GFP_ATOMIC);
 	if (!hash_heads) {
 		kfree(ret);
 		return NULL;
@@ -536,7 +536,7 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    struct neigh_hash_table,
 						    rcu);
 
-	kvfree(nht->hash_heads);
+	kfree(nht->hash_heads);
 	kfree(nht);
 }
 
-- 
2.39.5 (Apple Git-154)


