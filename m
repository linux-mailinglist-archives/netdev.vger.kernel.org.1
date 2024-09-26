Return-Path: <netdev+bounces-129928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01904987104
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FFB1F26F5B
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E218E34D;
	Thu, 26 Sep 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STMke55m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB317838D
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345296; cv=none; b=L67CCtqReo6IfIasrZSx6n4iA1HFzXixWvC9T1fOqHfPpFwkgXdybVaXtdBC5+q735mNxOLECaJGFnc5RQJoZVbVYxF08/j4vSQb5kTgQus8jP5Xhmyiovmm98eCmzAJwGrkZ+n26pl1gLiWTdHRB4845/mglkUJ7cRXelH9ujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345296; c=relaxed/simple;
	bh=V14EwVeUr6NaVcUiMc9n7dENZpH4C6bd3x1DtyL9jJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=urzmPBZZBRdTNt+gP66Et4oV2V2LIuuU7z+9knnfAPbxszO1K0NWT789kxgU77oKcueDrlO/qsZQgc4FrSuHSzgmo4WKXp4bMrSLEPtDX4l+RDS8uXSSytM1iqsl6RjZdErG8UqdXfxze9P6jXU9ll+MS7b1SmdzYu772QKDuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STMke55m; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365b6bd901so936431e87.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727345293; x=1727950093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcvNNQUTTgfXc3CvD4Muq4pxQhalQLvx5pFoEcSlHmQ=;
        b=STMke55mmvtjJDJYlHv369NknTYRFRzGP0jwkb7AhmwgqitOV0My7lR3X6WjywbH20
         QHclnnunP/B7FAuaE3ErkN4AHuN0XX6e9YJxCO3z1/WykRqTT7bTPqLBQkDtW88xeBVH
         XxO5AuObRz0dAd0hXIphUAac0ArC40Qbzsq20bIwNS3MybB1xMi1ZOCjjqP9JMtggF02
         12W7zNgERO55PZjI0ier4H9CRWfI+c4MD+pShU0yaVvPldq+XPt1+UvZEGmzvTHVNNOH
         +oByYFn8i5X4qTZO1mKeRx15zKJKYyWR9xdV6k1Nl5W3u4TwvDW0FzFaIcpuusdrCNkw
         SxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727345293; x=1727950093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcvNNQUTTgfXc3CvD4Muq4pxQhalQLvx5pFoEcSlHmQ=;
        b=mgk8FAIJO75wdEk2dFreVL7YpaI7OqQ1bmVRhjXrYgKjTEEJz/U/t/4bSRe+CD8ITF
         vGOw12dazCt5x1Fe8c/Hkq+lXv+M2WuhDsFI8z5kH5oTK7CDGn175CYS9+UtpZ0XLwbt
         J4bFgHnLZ645rxOEP8M+Vp9ee/Sap5UK6p9UC0EXiYyx/3Tpjw0dK5UG/tICFaR/t4vJ
         f/+o7IDRAe46cLwtW+jh5SsLzVzxjufa9qfGNhh9LQh5QemZLdyTJCpckdKlqj8NgIiK
         pPD8E3SaMzVh394n+H4w6dk9xDiuTZt14sxJhaLU/dqNHM7fpmtMhwmyZdQDBRvpbBOP
         GuLw==
X-Forwarded-Encrypted: i=1; AJvYcCVXPNkXNNm1wzVZUV4dC2BwkPLO5dnvqntkz/ZiF8uutUOGRWbJNC3hCe4i3zXx/ViiOt1LToI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7o4IrId8FBHwgWyOV9EfrbUVBoyBuQbbr22mDsZnBOYQcG5Jk
	IsRtcMbxq0C39i65Jwhtz8615op/40hIHvqBEc61Hazn14V4ljoc
X-Google-Smtp-Source: AGHT+IGIy1iQhWfnAUQXm4O1jXltotppab/HbKS5Tu/2y4occEGWwmk7wV7D7cn8XAlqSSpXdVa0QQ==
X-Received: by 2002:a05:6512:114b:b0:536:548a:ff7f with SMTP id 2adb3069b0e04-53877565000mr3738265e87.58.1727345292508;
        Thu, 26 Sep 2024 03:08:12 -0700 (PDT)
Received: from getafix.rd.francetelecom.fr ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c87bca81fesm183297a12.9.2024.09.26.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:08:11 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: alexandre.ferrieux@orange.com,
	nicolas.dichtel@6wind.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next] ipv4: avoid quadratic behavior in FIB insertion of common address
Date: Thu, 26 Sep 2024 12:08:07 +0200
Message-Id: <20240926100807.3790287-1-alexandre.ferrieux@orange.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mix netns into all IPv4 FIB hashes to avoid massive collision
when inserting the same address in many netns.

Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
 net/ipv4/fib_semantics.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ba2df3d2ac15..e25c8bc56067 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -347,11 +347,9 @@ static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
 	return val;
 }
 
-static unsigned int fib_info_hashfn_result(unsigned int val)
+static unsigned int fib_info_hashfn_result(const struct net *net, unsigned int val)
 {
-	unsigned int mask = (fib_info_hash_size - 1);
-
-	return (val ^ (val >> 7) ^ (val >> 12)) & mask;
+	return hash_32(val ^ net_hash_mix(net), fib_info_hash_bits);
 }
 
 static inline unsigned int fib_info_hashfn(struct fib_info *fi)
@@ -370,7 +368,7 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 		} endfor_nexthops(fi)
 	}
 
-	return fib_info_hashfn_result(val);
+	return fib_info_hashfn_result(fi->fib_net, val);
 }
 
 /* no metrics, only nexthop id */
@@ -385,7 +383,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 				 cfg->fc_protocol, cfg->fc_scope,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
-	hash = fib_info_hashfn_result(hash);
+	hash = fib_info_hashfn_result(net, hash);
 	head = &fib_info_hash[hash];
 
 	hlist_for_each_entry(fi, head, fib_hash) {
-- 
2.30.2


