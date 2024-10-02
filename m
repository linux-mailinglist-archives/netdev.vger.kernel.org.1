Return-Path: <netdev+bounces-131115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0A98CC6C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400A71C22677
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 05:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB35C7BB0A;
	Wed,  2 Oct 2024 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyv+rwBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B02C6A3;
	Wed,  2 Oct 2024 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727847545; cv=none; b=g4k4I1A06ZNIsjWwyySjcCmyg8XVd2RdCHij8yjrmNRTdUe3Ms2I6MT4KxvJGj/y1zGctsqv7oMZRhDmtdAi/NpLUfX68p4j6cbhbOSm2wNHjsRXsW/G9aUT8Kec5qAyctzj6n1DWiMtIPm76s45pleJFEzI22bhKenDWhEdXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727847545; c=relaxed/simple;
	bh=CWAlae4n0Xym+X2rxoOoi/ROSGeuFIXCUd5yA4HSFxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3HUzUBoSdfyqaDmh4XslhHw4fqdorpYC0ue55Cy9Q/6AdKw0QvH2mV+hmXjzSZ0fjK9yKxVG22z9iE4MlRxh1f0gE9VqaL99ZN0IQyM31ydFeo2BoZNEO984XIO4Hmkheds/UfVIErT4SAO5jcG9S0cgemi6jSQFuEO386oV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyv+rwBS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo4035621a12.1;
        Tue, 01 Oct 2024 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727847543; x=1728452343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSrUYkMkE9zvEkFMuzZvZC7ntTwDRME/kSuxsY5XPhA=;
        b=Gyv+rwBSLrQCAsW3vYTJTfaIHg3zDol1YpCe48O6iUgAi39L20S0bTG6uh8LszHZ5G
         YrFGkKFXiksoF0p9afr6ZZ7VXt4PUfMw0xbFxJzoieVMy31VZojBjmOvi0rogwh/O3ve
         az9bY5qUx44XdhBjL77QG6DfObZnsLrcHoGsnEMzh0lOK/+t5kp+kiZOj9OPMjP+Ou9S
         R9TrjnJgmGAZr/mw8IJcJ4IM7Dt1RRfNHHAVfludDJC8CXsiFtvjTD5WoB9Rw1F2SrpO
         QpRUm1yKrzi7pj/66rtL6B8hmPvRz7KHe0LxNJ/fBu5BA8EWpaNU2XvrpITxoclIxzr6
         tqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727847543; x=1728452343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSrUYkMkE9zvEkFMuzZvZC7ntTwDRME/kSuxsY5XPhA=;
        b=TFbN5j/u/Mb/6JqpDT6K/CZfpfObGLU5jY2cDbMBFrh+yc3/hS8C5wHB6vVckVdLpt
         S3RCL7vbqolMjHIwqNHTnz4PWkzQyiwd0W44mlk5njXzyTY8y2wfrirXcQJ8vSlHeq2E
         evTsdB7jVshj6rVYmYdMHTtf2BgyUg0/DdRVPW4rYy8R7jooXsbzia4Qb2uvlJL/yHJC
         L25ih/Y9z3RTGzj/DfqdHFHlljKSKDogXwMzwj1DuF1FVEzX1lGSy2OhG/Lz+Y3CZjLA
         V8KL1yPy/u6VUfRaJoaVAniOlyCotY0PfQLCAjs+MnBW9yM0UQxNPzBFBTA+vR0Bh9CO
         Jjyw==
X-Forwarded-Encrypted: i=1; AJvYcCVXfXEZGnnEiK4mREvYnpqXjeket6ynBR0YnGgsAJcHijA8RKRqkSBYPwavjkwSe3KOHOnSV3may6zVlNg=@vger.kernel.org, AJvYcCXtsvyPRQq74YLh/pm+E7wit1bRVRX272/bTBjrZ9ERV5v9hMv0yHFcCyxXw2LrbDqEegAFDfMF@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFv2OkW1JLQQS6gGMaZIaD0fZu/iy36673VKrmL213VIKmNJj
	GdkmEcsgALaBW2Jaf4c+QZ3BvgraBM4YlVwrKGkLO6yBF5n0POfD
X-Google-Smtp-Source: AGHT+IGe7SRHq/UhxjX93rKEdK5jRM5R2AjL7SEDR/7Xgu12OiPTbdTHs73fmNGyYdnEcNv17lbUZg==
X-Received: by 2002:a05:6a20:561a:b0:1d6:376b:b404 with SMTP id adf61e73a8af0-1d6376bb414mr2345731637.1.1727847543415;
        Tue, 01 Oct 2024 22:39:03 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e6db2c7f9dsm9278876a12.50.2024.10.01.22.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 22:39:03 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"GitAuthor: Daniel Yang" <danielyangkang@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Subject: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
Date: Tue,  1 Oct 2024 22:38:42 -0700
Message-Id: <20241002053844.130553-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pskb_expand_head doesn't initialize extra nhead bytes in header and
tail bytes, leading to KMSAN infoleak error. Fix by initializing data to
0 with memset.

Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Tested-by: Daniel Yang <danielyangkang@gmail.com>
Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 74149dc4e..348161dcb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2286,6 +2286,11 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	       skb_shinfo(skb),
 	       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->nr_frags]));
 
+	/* Initialize newly allocated headroom and tailroom
+	 */
+	memset(data, 0, nhead);
+	memset(data + nhead + skb->tail, 0, skb_tailroom(skb) + ntail);
+
 	/*
 	 * if shinfo is shared we must drop the old head gracefully, but if it
 	 * is not we can just drop the old head and let the existing refcount
-- 
2.39.2


