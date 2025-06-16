Return-Path: <netdev+bounces-198330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE4ADBDB4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9DA189309D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EA23507F;
	Mon, 16 Jun 2025 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Ls6I10"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0B233715
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116885; cv=none; b=W1oyfA/R729TGt1Wntv9si1GFKgYkwMep10P5DNpjnxwqQsRtgu8UhapC1NZ9z27R8CSI4Kf6Btokl6rev6VFu/aomo/HW9YD8NP512+sPMfO1TAY+i8WzEQG2ZHdeBahuN2yWV9+Z8uuAs/T3O1ak3XE4RWgivRexYbTJWekVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116885; c=relaxed/simple;
	bh=6OLQeX+FE/26mPd1rIZ/R9GvzW/GSrssHvxZcMF1NnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mow0z7tIh221SABlBmqyK3tjy/oZfd3vA/FbE2SXD1kRuWigjJuJSddp7DF2J7CECqC8OX44wuGF8dhzxiEF1+m5BEONG8bRiUPZfMhp1kY1ywzHTpG9mG4U2083/OuobmDXCPTvRLIwM9vu+QQPLN4qoKYPmbnhbiGYMBEaaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Ls6I10; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234bfe37cccso64906805ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116883; x=1750721683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnnIhAjJ2qDK7AN+bhZIsThcGT7sHOhZYAEsTvhgAqs=;
        b=Q8Ls6I104dxeOaRSzTm04ZgN3P9u8JDNlqNIl8S05/qHphLh0QBtXiT+qV786pFgun
         VLjPrV+0o0EbU7c5gOv3vvdbkJuHJrLYSLyGZaIsDjJP7kfSqhAHQrYww8wMPWwLF9lZ
         LIFhFN6kkz0UqR8BXVKewVBKt2n0E5spuvPjvTxd13bB/oNeDE6oKNmKzEtOi3pZ1hbj
         1aD7N4llA7QlakMT1ZRcqZo1PSp9MojEpXK7hYcyQRyEMXJ21uj70Da7Cuq9tlgU9eGU
         9khDj8+BcltsKro42hfj/9JmQWu8hjxOMh9KNc0oJzHmGX7nWSZuLRtgG1LhLPN40gb1
         6ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116883; x=1750721683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnnIhAjJ2qDK7AN+bhZIsThcGT7sHOhZYAEsTvhgAqs=;
        b=gDj/2MH1+WydorJilPcn4Ns7GmisxgaPnbGUt75rMxANi6s0MpO+hoxKR5zSnuKnPF
         NWXmuxf6Tl0eLb9h9l5wuzWzjN/8HiokmiUkqQsQEfcilQ+5UXrOamdjkfRZ3MOmJQ/G
         PBDqjyK8GE3ZHYt/yDphhiJX0RcOyBVeZTp/0JbKceqIW2BxcbOaPXDaIKhvmCmlr3jz
         nYGRnoUEhIftoP1JpZHr6iAoRoaU00AHNlxVl73umNsHhVkVAVCrMZUbfuDk9UVGrrKf
         rxEn53lb8e8sfHCLZd9rD+U8nzxX7kETlahOzE+r/Aqv/TIj7aosfQR3wTD4P2ExK9I/
         crQA==
X-Forwarded-Encrypted: i=1; AJvYcCUMzvrql6Lj6bS/jLXPhQZ4xngw5w6TOhpkhgXdXz/mxr+icnzIskGO37Mpys5W0Sy90PQ4Pec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIuDfjClFLK6vSwff/dW1EW+EYTxeN0KdWYzv86q0GOrwX09z
	1WnOFICNoQfjpR1YgkskF5ttwO1ErTVT8U9zfoBO1qm6jTExoY7HHc0=
X-Gm-Gg: ASbGncuudc9HMAs14mx6o2RmIwLh6KuPcjdOpCfGrZ4ZdDoRUU6GbIpi74gtv8acKil
	d74uZuzavftirtp1Ay2ftb7l8QVQ+SKfZ+AVTxCSbbTAO23Ulkc+MQG9sd3+wKRJoUo+07eszVM
	lRITCqbaWFyIME71CZh4mzDeOFSCh2UGW95TrbDLYz5aceSHzdfSXNtX3VtgwLSRq8yy3wndATa
	1zIP84pL8wPaYoSEsc7pd5DKsQ5uKCDw/Wx6Jg8rCYnRkH8LM34kl6t8o6GNiEZMlVDE+62v428
	kVx/X8OmT1wf5pmC1SPUp8tNDBvuvXnUExZT6Vc=
X-Google-Smtp-Source: AGHT+IEdZ0CP7FaoDFTe45NKaivJEbRgVjKtP5PMyXK8f5h6RN5A3iTIqsvvHswORyvz2So15BH1Rw==
X-Received: by 2002:a17:903:19cc:b0:234:ef42:5d75 with SMTP id d9443c01a7336-2366b00ee6bmr148410275ad.20.1750116883354;
        Mon, 16 Jun 2025 16:34:43 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:42 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 net-next 04/15] ipv6: mcast: Remove mca_get().
Date: Mon, 16 Jun 2025 16:28:33 -0700
Message-ID: <20250616233417.1153427-5-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

Since commit 63ed8de4be81 ("mld: add mc_lock for protecting per-interface
mld data"), the newly allocated struct ifmcaddr6 cannot be removed until
inet6_dev->mc_lock is released, so mca_get() and mc_put() are unnecessary.

Let's remove the extra refcounting.

Note that mca_get() was only used in __ipv6_dev_mc_inc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/mcast.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 15a37352124d..aa1280df4c1f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -867,11 +867,6 @@ static void mld_clear_report(struct inet6_dev *idev)
 	spin_unlock_bh(&idev->mc_report_lock);
 }
 
-static void mca_get(struct ifmcaddr6 *mc)
-{
-	refcount_inc(&mc->mca_refcnt);
-}
-
 static void ma_put(struct ifmcaddr6 *mc)
 {
 	if (refcount_dec_and_test(&mc->mca_refcnt)) {
@@ -988,13 +983,11 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
 	rcu_assign_pointer(mc->next, idev->mc_list);
 	rcu_assign_pointer(idev->mc_list, mc);
 
-	mca_get(mc);
-
 	mld_del_delrec(idev, mc);
 	igmp6_group_added(mc);
 	inet6_ifmcaddr_notify(dev, mc, RTM_NEWMULTICAST);
 	mutex_unlock(&idev->mc_lock);
-	ma_put(mc);
+
 	return 0;
 }
 
-- 
2.49.0


