Return-Path: <netdev+bounces-224980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B9B8C6CF
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4921E1747D9
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153A2FC882;
	Sat, 20 Sep 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixax30hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA542FC024
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368273; cv=none; b=nReVZrFfPvMu5N5POpP/Wabpx4qsBo6dLqStlCyI6oIOlAREtR5+7FBTqBbIylrXcB0/POA1bm5t08aE3dJ1tbspZXphtEqhhn23DsP1causRdGg7qJefQtoRBgZSe2tY1avcEQkaY3pF585hEtJq5815+8Vo9x7vK8ZIujNfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368273; c=relaxed/simple;
	bh=b6Fm0BmwLJwqytqC+i2BXbe8puZ6Co7RKo/QnYUhzqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PY50zUfYoEAGkCZNZIXGPfJiRuRTAWYswgdO3QDH+/y7gq0AY6moaTqvKRzFdA4E60+5OWJT08bkug/uvQ4ezwbJbVeWohpR7wBoQiWIpJ6mCATRektdD+6IKSRDIe9mok63JYI9f07Us0cEgHxWe4ydKVIOFxeZJauy2tuuVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixax30hw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-271d1305ad7so3890055ad.2
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758368271; x=1758973071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gi3z+r8fw1Fdl3f/f69x8Y4JnwjByJnQ8m85yG6rUI=;
        b=ixax30hwPiu+xxALvpR49IjXY5qvqbaNoD9kkBK4d1QqVJaAUhrC5pLOyilT+YHCpp
         1Pc3iNKZCV1Q1533r8JIRUja9HoFUQySIXKDnDaHqWyxNckg6OgGZAhUq3fmgD09zUyC
         BUHcCrLVOnvo1cJw1zjzVYWzez+JV0BGGd5+nEZBRWH9+2B6DhAz8UGo6Fr7AA2wDH0c
         5JcWaaxmKnuiQMfE1Awyn7AzUgr8flT5xE2x9GkK3GDKOSXxwl48YbyzIjSVKfJLYFDS
         sMhontiXA/jYKzgU8Q5dIE5tYKdIOB3Yt0NzKV0YVohjfvCgVsRoOnVprnNvBAeWMAzx
         P1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758368271; x=1758973071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gi3z+r8fw1Fdl3f/f69x8Y4JnwjByJnQ8m85yG6rUI=;
        b=oYaIgl2eTKb4u4VZuI9mY2FVQEn1IZWgir7Y8tibKxpwkk4BNVNwL3Tm8GNbE2E4Af
         lclsNBUx+8clN/5n4dtAYgGBh37l2DQzK9ZlNKCDPlvDm/NgjEXczqSlYYQE7CH3jVRU
         3Uw2kstcwI/ouH8OxU3YURmMP8fiMw7JzgBOpbVMkn7TfsFM8AfP1b8hLdmla3l7awc9
         7smALz0bLBfXq8birGdvMaVl0DYcIDsFeqWoAy8FJQkjpGQ4TNr1hPFsEf9r+EIHSwfF
         jThFGP0wMoa0yoOtS/veItg7eXSbs3jT88fzubf6bwoTThoIxWj7wzSBZzdSTohqDAUu
         j8Kg==
X-Gm-Message-State: AOJu0Yw+J8aAC43AyThEqhlVGxzOwpV0K9yEiLOHw+SqARvv2TAD/MAG
	mpZb/T4fHqPUG6HCUr33bnMgaUrxL/D1g27GSMfTnHoTGIW9j4Ai8VE5
X-Gm-Gg: ASbGncsaOA33Fsw9zEnSxg4j6dZx6W8Qs/RFp1LkIn/v7fklU2lEhvcdAZ6hznF6f9H
	Rut2f90bN4vHvx2larNo/Z8vesCQK8YYCI28pMyMFmmtT6v+0RpSj7xxva+rj5zsfsIFKjQKCka
	qu+toIR0pTw4FCnG6EMqSAYpDoArCM3YDpIi0jNFO5P/I1Mtj6cP9hwuzenSeFJ60yO5QboE3R+
	okWBXWuJx3QeF9sxb3HNL1pmHVm3dU5HGRyEJNn3tqFVl/TV8BJHZlbwkaBaRbwjIyDX9AkH9Ky
	PMJ/ShgrqXR5rlDcnDeOVIfGhitBHMkOvDgRn5K0zk0QurIb+U5/qkYU4OtEGFjSWNW3JrSQiPk
	+QPNn9Z2fVcBXYoGyjeNZ7uU9lRhkJZpKScwlTBx7S0cSlwwTtJJUSldS96svKHyU18qyM3wbxT
	3IFLGWQIaNeHccTuKWmLrM/Xgb2g==
X-Google-Smtp-Source: AGHT+IFwAhN6M6EFWaf1/XtyWON0Z7I+kZCi6dd4GayIfKZtJs/E8SMjeAc4Ms/se25F/OZV1Noo9g==
X-Received: by 2002:a17:903:2b10:b0:24c:9309:5883 with SMTP id d9443c01a7336-269ba511be0mr84863685ad.28.1758368270822;
        Sat, 20 Sep 2025 04:37:50 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm80857165ad.54.2025.09.20.04.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 04:37:50 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	martin.lau@kernel.org,
	mhal@rbox.co,
	almasrymina@google.com,
	ebiggers@google.com,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Subject: [PATCH] net: skb: guard kmalloc_reserve() against oversized allocations
Date: Sat, 20 Sep 2025 11:37:23 +0000
Message-Id: <20250920113723.380498-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit size check in kmalloc_reserve() to reject requests
larger than KMALLOC_MAX_SIZE before they reach the allocator.

syzbot reported warnings triggered by attempts to allocate buffers
with an object size exceeding KMALLOC_MAX_SIZE. While the existing
code relies on kmalloc() failure and a comment states that truncation
is "harmless", in practice this causes high-order allocation warnings
and noisy kernel logs that interfere with testing.

This patch introduces an early guard in kmalloc_reserve() that returns
NULL if obj_size exceeds KMALLOC_MAX_SIZE. This ensures impossible
requests fail fast and silently, avoiding allocator warnings while
keeping the intended semantics unchanged.

Fixes: 7fa4d8dc380f ("Add linux-next specific files for 20250821")
Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..98efa95ea038 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -591,6 +591,8 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	/* The following cast might truncate high-order bits of obj_size, this
 	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
 	 */
+	if (unlikely(obj_size > KMALLOC_MAX_SIZE))
+		return NULL;
 	*size = (unsigned int)obj_size;
 
 	/*
-- 
2.34.1


