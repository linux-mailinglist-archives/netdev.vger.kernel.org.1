Return-Path: <netdev+bounces-222734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35698B5584B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914B11D61FEF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8CB23D7D9;
	Fri, 12 Sep 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msb/XFUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5122256B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712148; cv=none; b=KPMvsc1xXfbxm6ms/Vg3bQDId8ACZJ7j2Pmqxx8QY6UTKtoG8sBIyXUiv51MQTpUmU7HCPQzEE61dHAoST1SSWV51SWQ8rClOAr3c8OO/CGDl7UIzTOpTFA8cf1jj//q/cfUF0Z7q2PU8OmFUW/lkOzOO0fTfkBfYFNYigh9awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712148; c=relaxed/simple;
	bh=0QDEMIkD0ujZYhffTIC0PtzHOyjYuE9Qn2yWiOmBpBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCoClvGM9vh8GME0kUEQ4bs60fa69DDCnDFRO357AQ5vuZV6fPezuUVbH4eWRMVK83ptYpXxZ1aix01SP5bbMTIVrffMVQyj9V4EDFxFKbv+7rpM/3Eaqlbkli1ffZGrQsPCmmBHQQsRVpdoaZIXO4Eq9Gswz76uni6SxOI0uX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msb/XFUi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a74f9150so1399769a12.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757712147; x=1758316947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6OytC4WzM7xin5NB/68oPu8ar5BWRJQQBFVeXDGUks=;
        b=msb/XFUiz8n8cf/Kqwf9QRrfIy0DXaaO1w/BMJBHwG2tGNQh/xnJhD0DfULo5GZAt6
         0r0PZAZVAgSZc+0BEPjzJGzQH7RAmHd7A+ZoAhZw/KQQPRv/aNimLFGyWZerp3bTAokl
         GhAmSM9VJQZ1X99TqypAxFARS3M4f9TV1m+M3olW18K8T9BqEzejhimPVZLJwZdhvhLe
         e7Ts1gsHvcmybIr+k1Bn5I7uAe0nBRz3qepsCFP3j2Non9sTY7v8SSzVVlLLeHP8SaqZ
         3McjGMGhgIUl1qq2BkXvLZM8StrUb58jF4XDKOAmP0E+rYNCxZjlVNaAQzFqA3VCo6So
         P+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712147; x=1758316947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6OytC4WzM7xin5NB/68oPu8ar5BWRJQQBFVeXDGUks=;
        b=Yq9lo5RCAlFGyTf55KcW+1kozF+Y03I/vbBXxCQHy6ky5dPQRhzbAplwRBZWtm73vO
         l45k/Jw4D80VJjH6zxn+gdC6lmzN7nuMjR7PKebgwI0QYwPl1LiNTRAb+hHxTBk7RQTc
         VqVXzIXkVPP6wYPT7eLJYsYYCxWtSxVvRMchy7RAZj6+KWXJAfBThOPV4Jv3i/BAzpUB
         qdm5KQNfvFlSg5tQXYCDnsZtTvokUxZF9szFaLD+e/IHqpymlv9szf2ieilHiX7Po+7W
         dqzWRfxtMEAMAx9DZf+MHm0udL3E25bHFgffj2ZhoYbvYm8kA6B6enYqYk0aHfmFWEYI
         TC/w==
X-Gm-Message-State: AOJu0YwjJ0wbGj0cDDOmxpSs5OIJ+2FqdhsiXL/0NcB4AY69s8bGa2bL
	4nAkYRnqd4IJ//9/pw2w7bBHIOvwGtkpXZC7UIhY7fN3LvKex8CSGmwGxrkKW7dsB1E=
X-Gm-Gg: ASbGncu+tMc/qYf8q5DXOS2iKznubLgEsdg+8+Td8NpGYbA4jAqBXXllq9q0UFxxo4R
	RD7QUKVdTJSESR03ME/BNvMCi7Zg7WJLdPvl896lVELtrbspR+st4kogwQrrNy4qGr5XoWVKA0t
	efJ1H2Dx5sSjO7Op+HZOVudWMSps51tDEuucx/WQbp1TnGJFiNsbPp8lUkue5JGj4hX7Nbsnuc5
	u/PAsExKXvoG237CFqKs2w90KX66VpTgX++yw7knkZ3N58NHm/47UocTaFdLp9mToIzigwCsO8z
	Z6GFgrZNGr+5GPd/z/lbegU+GkQiba7lek4/6WPy4e6iH7fNc92tt5NGDD/mdXoSsCirKLNotV+
	X4zjV1GMYqnR95PRmnfscib+2KfgBdTXeirGjwd1Vm5CR+lHxBT0fsQ+nUg8OhYiRD8DnLQ==
X-Google-Smtp-Source: AGHT+IEQq4b8hyO+zBL1CbmGsvcwCC1z7ykCNzk57MZB1tNy3T0mA7mB7VPfoTd5YWUBYMazeI7JTg==
X-Received: by 2002:a17:902:ce92:b0:24c:8d45:8049 with SMTP id d9443c01a7336-25d27a27d59mr45376955ad.61.1757712146567;
        Fri, 12 Sep 2025 14:22:26 -0700 (PDT)
Received: from lolcat.iiitdmj.ac.in ([14.139.241.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25db018df7esm25710095ad.152.2025.09.12.14.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 14:22:26 -0700 (PDT)
From: rodgepritesh@gmail.com
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com,
	Pritesh Rodge <rodgepritesh@gmail.com>
Subject: [PATCH] net/rose: Fix uninitialized values in rose_add_node
Date: Sat, 13 Sep 2025 02:52:16 +0530
Message-ID: <20250912212216.66338-1-rodgepritesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pritesh Rodge <rodgepritesh@gmail.com>

The rose_add_node() function uses kmalloc to allocate a new rose_node
but only initializes the first element of the 'neighbour' array. If
the node's count is later incremented, other parts of the kernel may
access the uninitialized pointers in the array.

This was discovered by KMSAN, which reported a crash in
__run_timer_base. When a timer tried to clean up a resource using
one of these garbage pointers.

Fix this by switching from kmalloc() to kzalloc() to ensure the
entire rose_node struct is initialized to zero upon allocation. This
sets all unused neighbour pointers to NULL.

[1] https://syzkaller.appspot.com/bug?extid=7d660d9b8bd5efc7ee6e

Reported-by: syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com
Signed-off-by: Pritesh Rodge <rodgepritesh@gmail.com>
---
 net/rose/rose_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index a1e9b05ef6f5..6ca41cbe867a 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -148,7 +148,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 		}
 
 		/* create new node */
-		rose_node = kmalloc(sizeof(*rose_node), GFP_ATOMIC);
+		rose_node = kzalloc(sizeof(*rose_node), GFP_ATOMIC);
 		if (rose_node == NULL) {
 			res = -ENOMEM;
 			goto out;
-- 
2.43.0


