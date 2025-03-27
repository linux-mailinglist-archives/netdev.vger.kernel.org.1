Return-Path: <netdev+bounces-177953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E304DA73385
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E579188E2E6
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A8921577C;
	Thu, 27 Mar 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HGN/jeKe"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899420CCC5
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083037; cv=none; b=drdv/E6xWyR+UMMbKc3S3Q2S+rdn0ib97Ip1H6YH+h3Rb+TroybxtZd/siyAAl3Mm10hjOCkTBiK4Ka/+JgHtE3qTYUbLSZOXVCx+RkbR5K/+iuH+YKITuE0eIzvmECMDFnDNQMxc8GYDeBcgAepOO/Zx68rL3Bs9pFwfJYhP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083037; c=relaxed/simple;
	bh=9AMtvw3nS69g7hxNbflJz2CtocyZRMh5pJ9kNRdrSj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9td5zBVkKAwqQ+xEB8/5X/lI1fu43nBQ2IaCABjUC9ll06oVl4NqbNOcLZHdVVhdb20HWi0OmetDZ7w/lgL9y7DAF4FGf+Ve1asRAQ4rSWW1Wi0rjQZpySZ6gZxJfdOzQZQ6gX0BvNQckKX9Ccniz2z2nLeZ8XS9j2Qg7Da3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HGN/jeKe; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743083023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uOgBF8XHFaV92u3aPPoV9+GCkDsVe8HhK8jkJWca9bM=;
	b=HGN/jeKeQv2DMu40CwU2DiYI8ELROdxkfr4p4tKRnXNL6yTJFrIOGXJ5H3enAYYHpCoe1K
	J7EVo1CM3Sahr/d36OS2sd5zKT8mpGhgdxy7JehyZ3/qSGRG/beLxfFe6LmUq2dsBpmuId
	+jPXjzAsIw36w3bryEmal+1KVymEr6c=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
Subject: [PATCH net v1] net: Fix tuntap uninitialized value
Date: Thu, 27 Mar 2025 21:41:22 +0800
Message-ID: <20250327134122.399874-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Then tun/tap allocates an skb, it additionally allocates a prepad size
(usually equal to NET_SKB_PAD) but leaves it uninitialized.

bpf_xdp_adjust_head() may move skb->data forward, which may lead to an
issue.

Since the linear address is likely to be allocated from kmem_cache, it's
unlikely to trigger a KMSAN warning. We need some tricks, such as forcing
kmem_cache_shrink in __do_kmalloc_node, to reproduce the issue and trigger
a KMSAN warning.

Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/tun.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f75f912a0225..111f83668b5e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1463,6 +1463,7 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
 	if (!skb)
 		return ERR_PTR(err);
 
+	memset(skb->data, 0, prepad);
 	skb_reserve(skb, prepad);
 	skb_put(skb, linear);
 	skb->data_len = len - linear;
@@ -1621,6 +1622,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		return ERR_PTR(-ENOMEM);
 
 	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
+	memset(buf, 0, pad);
 	copied = copy_page_from_iter(alloc_frag->page,
 				     alloc_frag->offset + pad,
 				     len, from);
-- 
2.47.1


