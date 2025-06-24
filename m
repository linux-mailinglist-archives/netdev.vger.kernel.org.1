Return-Path: <netdev+bounces-200821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FFAE70A7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9699D17E673
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFF2EA75A;
	Tue, 24 Jun 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3znuBNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC32E9ECC
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796791; cv=none; b=cGgiY0U4UwwWj/7Pt5ZqEbJvQLbVzmB4ylU8BrDwa4h1g7ElXwZh9faGo1eME/Mgs8J3/L5HOF04dX0c8hzM0N4Sfy0Odn0TCKnNrqPularzkdq+aBuasHxLsBetuyTFszrNBpKgpCNldnsR9rKHOJ+ilk1J0qkALitshWmAhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796791; c=relaxed/simple;
	bh=6OLQeX+FE/26mPd1rIZ/R9GvzW/GSrssHvxZcMF1NnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMqDuzFAQODHAhSFWuC8R9ycRBiZY5mjp0ZoeEvjlx0cMNOuyQvKQezeWQqddfdSNlUmKO7uULjFTUee+mGf7tXMdy04wGTtXWWTpoJTruY8xxnaKNp/eVUnrgU6LQlMGcNL0QjXI4e08dN5MmnChVpzrMoGT9lh95Q38UucdXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3znuBNO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fba9f962so150583b3a.0
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796790; x=1751401590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnnIhAjJ2qDK7AN+bhZIsThcGT7sHOhZYAEsTvhgAqs=;
        b=B3znuBNOItO4TCQEYnq1OwC9eGm3TVZfNAYW2KE13LWd7VpwoRmn8r+OUwakO7lmGu
         HRoaD4Q0UTh3FyLYZmxBmlMecKNfB89xVCykhovutR7MXBaHAWgjNjLORrcnOU3CZuHN
         HbkKtkKLvVN0+/pxEQa9Ag5jRALGFysTJ59ESXM9gTt+8qjPLvjJhYuTOGk0UoizzUW2
         n4PI45piJrBzvUXHCfwsCKhmkZQdNpnV9+5YUIZlccniGU6DLzvAI3MeEj4eG5qi3joy
         CWFOVWUkHrefFQoAdO+UxYzeGCqfUSmGNTQ1idzg38DckUNS7IpRiDUYJL4gvPRPxvs8
         CVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796790; x=1751401590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnnIhAjJ2qDK7AN+bhZIsThcGT7sHOhZYAEsTvhgAqs=;
        b=gBZiHWd2yD5aKkJji/NEHdu3XAXpeZ3AIoh1k1snlqnRVzKuvMwZ3KFGTFClOrJMK/
         kXbe3ZX1TRoEYEt/vCaQiWv6J6rQLdRE11q6pD+oB+/o8NpSZQ373/2m2atmzlzkvmdg
         zD2F5kIOWxASivzoFTPhhZrbJ0r9ugM3mKZeVgn2QOHdTpAvDJPX9DxN0fBIn5lLXtq5
         ceD2dhVOKPXpeXVuQqGz3ha4l01QbiEmhM0aRdIP41jNnntMvfZIHlWz3tqZDO5bL+C2
         JnUph2i/4o/80hG6SpU0jRaN+t0SVqGTBZPrOlux3vVN/9OYqtOQzRxBTsr/RxIuqX0v
         RBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLFF7hSsBTPLRYKBrcSS63lMAeOhaUn9pVj6mKe2ihkjiZucN8XOd7N70HiCS2ERNscXN7bL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHlXUoXFIon0WQXjnQc1UuhLcGfD314XdVmble7+fdIKNxGy3i
	fLUED1/zfYmwoRbPPkyloP0s+FL7RtnMmfDagFXbCCKll63cNdBmYwY=
X-Gm-Gg: ASbGnct6rnl7kbin5YT9jRxEdKWC0cro34v95EqZlcJN0Pd+t91nw9IYIz2nZEaVBDu
	diVudaFJsHyV1b8WCrmqg0v4i/DSysPeEUnRRBtsx30wHTxh1nG39sPAm/0QOGq0mX+ONUgOOl3
	Mowx7MXVkCOLTzC8RevD9W9P2R5GFUfxb0kEZVhzQqO0CuYcDbVzLfV/qt+4Hx+FHqtmMMwSHhd
	9y04pRMaMKD9U+g+qbzWpP5prK9w1w0DrhTMcU0JY1gwfU15m7DqZBZq76gfYYfwQsbmy7osIpc
	CPoonEOWEe2LkrlSPTb/PBtiG6MJzg3x0f9cX+E=
X-Google-Smtp-Source: AGHT+IG9kfYBhc5NSK7OaxOd7sHrs1KTfkzWmH+JgZXdfYXnGMUShZnMWEv2PvG/BrrdG2Lgyrmxfg==
X-Received: by 2002:a05:6a00:1789:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-74ad4af17famr508451b3a.4.1750796789875;
        Tue, 24 Jun 2025 13:26:29 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:29 -0700 (PDT)
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
Subject: [PATCH v2 net-next 04/15] ipv6: mcast: Remove mca_get().
Date: Tue, 24 Jun 2025 13:24:10 -0700
Message-ID: <20250624202616.526600-5-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
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


