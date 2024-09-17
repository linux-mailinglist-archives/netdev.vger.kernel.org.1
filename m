Return-Path: <netdev+bounces-128747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894A97B645
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 01:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F891F24AE6
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960AF185953;
	Tue, 17 Sep 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANkkvke2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572C157A59;
	Tue, 17 Sep 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726617074; cv=none; b=cqRwYVW8WCgEiEQ9VjQiC+HNxxusoknlaBDZcY9MDdYwTP+vFVLdhhZzkiEw4xz2t6PSG6IngkAbD84935NDYV7ngKm3N9RBeXxI04sYE86w/ErFgW6VKR7JdJ8j8Z2PZpXBdXRwgAugqVALc9EMFmxpmGtEu2x68r5Li2E0E6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726617074; c=relaxed/simple;
	bh=xcHAOsKBR2gQj7KOe3HCpZDMgUntyav83uHQfBdRACE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oppKTuwlfkr+IkB3yjjriInpRYhp1Biw8GcPNi0FtiuUXlousTNJSSTqom/TiUoI7WJm637l+OJCZzvi1Gy+LO8FrhO0LLVsxuQJMwqi0mE27ADeLUx3crh2NPjetUoz/vznwLlv0PiGJBPoDj1eTugworWPRGZnh3q8QbkaIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANkkvke2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6dbc5db8a31so1846367b3.1;
        Tue, 17 Sep 2024 16:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726617072; x=1727221872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7f6Rap9GInB3jhZCI147pU6ziaVSuDrXS8t69Acemw=;
        b=ANkkvke2U+Z0gQNUD+Rxc3NCe4xQr6UlQUY167C830h+oRtfzk4J7Ac/vj1CKYA/+h
         YaivtKjAVKLRRWJfVN6nCw37N49COn6C+EvQaDvTu5EzD3f9IDwouy1a/YMx0pC+avXb
         d59FUWznieZrsRv9EpX1+mEiN0gufa+L8HYYECoM15ZYxnqmphX60wtcbXqYUWSNAVXC
         JSeGSQS5Z/pQbrDypBx1NW7eoJYOXxXIsbSChDjkXER4iIVQNKuYu/EITIvsZxfF8NGM
         ZMeAVYJ05T+PVEagURW0xvyMceFC7IVG+UF/aWEtB+bxnkZcthzcHm57aslTK9o3aF+P
         kcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726617072; x=1727221872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7f6Rap9GInB3jhZCI147pU6ziaVSuDrXS8t69Acemw=;
        b=d4lxDvJTiedRTVqpQJkgAZfSzYYWFz5pyFvrdhmQtdZ6v9yyHeJpxM8K4VsJ1qbXx9
         5pQkQp0o+bIEJmTOeZzOTxtw+W3cTHAk/8peBjw76rNkkzLj5UTQQGvn8qxs6NvBwpcD
         y0/lynumNJ7DhgttZJMDFZfyZ/5bPezO0vgz1lRYhCQLv2PgWb84xc0Hm29DGbOv85QQ
         2W4tWVUW7FkqruN+H+ol8r1csz+VpsuLvh+RNUaFa4VXiE5Qu1iOt5SWNJ9p5TgFbfHz
         3Gx2eyL7Yig/VyzN6d8GpgJAlsjFsL9IQZeS7LjSJyBOUhyR4qnjt196kfen+VT3UaMD
         VSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEzv3hTwqsA8zmLBmoiTrlSNk0uRys6P8vSw4LD1Zb0gBv5580en+lvQvpyjYLaU5wDKLTUd/K@vger.kernel.org, AJvYcCXBOkXJ3rl+Ubk0eJ9XWA8icsvIWB2BOoxjWYmtvZtQNIi8zVSi16le5O8NQSor313l4/cg7aR/CLrj/+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLgwcNW3jitxJC9/qYvKyA65JP6rLahypGfxv/wpV9QVJ+VHg
	T4EpBiI6OQm1WMTlEZORHNBSK3ROD7zXhjQtexGzE280mX7Z5Lmz
X-Google-Smtp-Source: AGHT+IHOx4BfGCxcoN97vV2yYUsMS7RZh+W8Zg/p8G7CjiFca8pkVSlom3/MUkdSBGtLhyrK6TNiOw==
X-Received: by 2002:a05:690c:6c11:b0:6db:d02f:b2c4 with SMTP id 00721157ae682-6dbd02fb3e9mr123327167b3.7.1726617071865;
        Tue, 17 Sep 2024 16:51:11 -0700 (PDT)
Received: from zerochan.lan (c-71-56-174-87.hsd1.va.comcast.net. [71.56.174.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe3b3baf9sm15426007b3.145.2024.09.17.16.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 16:51:11 -0700 (PDT)
From: AnantaSrikar <srikarananta01@gmail.com>
To: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Cc: alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	schnelle@linux.ibm.com,
	srikarananta01@gmail.com,
	syzkaller-bugs@googlegroups.com,
	wenjia@linux.ibm.com
Subject: [PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop
Date: Tue, 17 Sep 2024 19:50:28 -0400
Message-ID: <20240917235027.218692-2-srikarananta01@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <00000000000055b6570622575dba@google.com>
References: <00000000000055b6570622575dba@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the circular lock dependency reported by syzkaller.

Signed-off-by: AnantaSrikar <srikarananta01@gmail.com>
Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
Fixes: d2bafcf224f3 ("Merge tag 'cgroup-for-6.11-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
---
 net/ipv4/ip_sockglue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..a8f46d1ba62b 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1073,9 +1073,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	}
 
 	err = 0;
+
+	sockopt_lock_sock(sk);
+
 	if (needs_rtnl)
 		rtnl_lock();
-	sockopt_lock_sock(sk);
 
 	switch (optname) {
 	case IP_OPTIONS:
-- 
2.43.0

