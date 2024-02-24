Return-Path: <netdev+bounces-74693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2C8623B1
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 10:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25C5B2305D
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349C1400B;
	Sat, 24 Feb 2024 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ld5RTbL9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE31B7EF
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765594; cv=none; b=OoNsiiEFyf+pkCwCaDzL+RXxQTXuuMFmGtj8W5KNCeobETljsZlj16FWS2as/orog6X+slLRDcbOXKpQSZxAFAsUUrwLKXqRuwqAkZVhzq17AVsFyTb24mmzyxQztngRjQNqOJaZV91SQ6TjKG4d3JtErstL5x68hCuNFLS0Zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765594; c=relaxed/simple;
	bh=iD50daugB74s/+w+Lq8Lb/RiziCJ9Vz19AzGZrZwkA4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DJ+hddkfu9C+TpsCLyqzXGcvYm3ti3lcg+fAD0Lz6DFPbW5Jjhgz+7/qO06mBloSn6rGUnTGY92EXMD8b8QCRALTGQoB+i7Y5JcW3lc0AzZbNcPd2me1i1Sg3ISEk6+nP1pd7QvzfaFatxheAyjRna6UAv4XUtAVrPU5qy058fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ld5RTbL9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dce775fa8adso3077656276.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 01:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708765592; x=1709370392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x5vXPgtRlLZWq2ENSppXDg70t7OcaA1Q4JPwPsN1gcU=;
        b=Ld5RTbL9O9AaUb5qVZsVTOZ2x2XgFe0SpNzJCDxW7zSH0rMMvhsBHW0gVCk6In2Lmz
         OzAEZzDSeG+BHCvkSG+lvwitrlTcfzqTrzrvYzcxzeQ+EMWw3oyZ1yvEM/x7XGdecYZl
         DPJxNGf+vNZq3r7HJx93vjVGpccCb6hi4Mh9gCsl2X/fY/HFjMFrmJz2TXGX7ePxIo54
         fD9Fjy29rSIRkYGCHENeMFsrym7RohNtPwy88tX3fL9x8Nmrw6VOwSDHe3Bag4hNg3Z4
         5d5B62GgZFJKQW3NEDpQb0di5Xeh2xoTQiNvUW26zdWfQ/JK0+acHNogPwI07KT/kKQs
         xw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765592; x=1709370392;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5vXPgtRlLZWq2ENSppXDg70t7OcaA1Q4JPwPsN1gcU=;
        b=Fa4SraLwPeDfo7zuklnkDQ5d+lLPAZsHPyrTK22pV8RdktSFIYNicMOj4FCh4NInCA
         zc6Lt3cODF42BEiGJOf2S1ODZlL8dQj3zy5qJDfDp1roo8fbJ+sYWliyRp0O9gPYwqoM
         MwEcVsFMv67xJpH6ByY43/NVXAI+q/WqKf3qpwiaDiTTqFd2q5wjrXIBF8MkJol6wHbJ
         4FT1MmwIm6ZUVZKFXXFm/pSbUBmK1swPQRhNKXML66P8+ez0LuI9qwZr9bl7fAa1wVnO
         qbAFCRWP+M1EwiQDibJyIgNgmEsrw/42kNEpEbju8oh4VcKU591Fh5McWeKFwKdKOv93
         Ze4A==
X-Gm-Message-State: AOJu0Yz15mep+Ry85GfqqGcYdZ5HKjjUtHzAT5oa6iR0/DyKuZY6GZKO
	WkE5SL+a83OhrTOQkGo8bLszGXUuWAuWxr7QhVvHAucabwY8rGyyaTJsNvPjPa++6P7OFYnWrK9
	PqM5+ujN9dw==
X-Google-Smtp-Source: AGHT+IEo+FXpDfV6ayBLWOA9yzzpJbfyhzKwS6a8/37v6cHxjd5BJAnQx3nFD53/x+mLQjAihEZKse9EsuLmsA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2602:b0:dc6:519b:5425 with SMTP
 id dw2-20020a056902260200b00dc6519b5425mr598651ybb.11.1708765591820; Sat, 24
 Feb 2024 01:06:31 -0800 (PST)
Date: Sat, 24 Feb 2024 09:06:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240224090630.605917-1-edumazet@google.com>
Subject: [PATCH net-next] netlink: use kvmalloc() in netlink_alloc_large_skb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Zhengchao Shao <shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit 234ec0b6034b ("netlink: fix potential
sleeping issue in mqueue_flush_file"), because vfree_atomic()
overhead is unfortunate for medium sized allocations.

1) If the allocation is smaller than PAGE_SIZE, do not bother
   with vmalloc() at all. Some arches have 64KB PAGE_SIZE,
   while NLMSG_GOODSIZE is smaller than 8KB.

2) Use kvmalloc(), which might allocate one high order page
   instead of vmalloc if memory is not too fragmented.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/netlink/af_netlink.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 9c962347cf859f16fc76e4d8a2fd22cdb3d142d6..90ca4e0ed9b3632bf223bf29fd864dbb76f3c89c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1206,23 +1206,21 @@ struct sock *netlink_getsockbyfilp(struct file *filp)
 
 struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast)
 {
+	size_t head_size = SKB_HEAD_ALIGN(size);
 	struct sk_buff *skb;
 	void *data;
 
-	if (size <= NLMSG_GOODSIZE || broadcast)
+	if (head_size <= PAGE_SIZE || broadcast)
 		return alloc_skb(size, GFP_KERNEL);
 
-	size = SKB_DATA_ALIGN(size) +
-	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-
-	data = vmalloc(size);
-	if (data == NULL)
+	data = kvmalloc(head_size, GFP_KERNEL);
+	if (!data)
 		return NULL;
 
-	skb = __build_skb(data, size);
-	if (skb == NULL)
-		vfree(data);
-	else
+	skb = __build_skb(data, head_size);
+	if (!skb)
+		kvfree(data);
+	else if (is_vmalloc_addr(data))
 		skb->destructor = netlink_skb_destructor;
 
 	return skb;
-- 
2.44.0.rc1.240.g4c46232300-goog


