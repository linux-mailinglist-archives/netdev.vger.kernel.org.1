Return-Path: <netdev+bounces-131089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793F98C961
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D451C20B33
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D091CEE9C;
	Tue,  1 Oct 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXEQm2oY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1150D1CF28B
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824490; cv=none; b=srsJ2dHaRhlp+gGlTVFX9jE0IYIJMJ+AREQkPHWnF5IMCEAdksEmm9wLPg6630a1oijZUr0Vv7rPy5KF7VPVuAM01fNHH4oLdxZGQ3syw7TlCkJ4+v2o7PAyxZC6y43HetteRYI4kTfyZlz39NzT7yG190aNKA/zp4tnFdlkqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824490; c=relaxed/simple;
	bh=asTZzM567pcKSUn11YDuhEmh5VGtwemnVvE7YgvnZAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DqiW6xMLFrYKwdxxTn9GdbngnoiV1V7Ut6TiSlLUr9n0Y7RIipmuUzuLw4/aKh9j7kYXjMDd6+CTglHH3nYam5oO9R/515A2IBa8GXeU4msiiFpE7zOT1E+SD3cglv4z6eRezHse8TwLz6oa00DoKP2VNAOTjFaTzkvlgHb0sWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXEQm2oY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so7926723a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727824487; x=1728429287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hXKyvSGYCFtYl7ZCgnYaWtIrO9omUE74W7krvfzgvxI=;
        b=QXEQm2oYjCRsjVoZfGWjf8LCvOceXQi8duE+jpk/uGBCP/3T0UbvDp9up7PYu9SvfW
         BcGs/4Zs8p7vp599SL6/1uaIJXGcbux569Tj2wVfhgzNW7sp9/J7ipWukvdkK/nfKqQj
         /8LJQsDq00/oP+3qd67DAAnU7zzHKnjy0jezcAw/8TVhMyk1JweOCyujDfvbsi6O+Twk
         gDpGNWemVtm7lSoDXap9MSs1GJLBWbVE908mAj2hzcMR1ihQqK4I7XuCxhHsTgFHvnZf
         RUHAfaqI6qtMepnPjwpL0YEkSbJwziXkq8uWuJ/6TcbqR30WFOC0irg0Br+66a/xt+af
         aw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727824487; x=1728429287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXKyvSGYCFtYl7ZCgnYaWtIrO9omUE74W7krvfzgvxI=;
        b=ei2L9kTZB9w1mUckM0N+i9AulyWrlu3yLTvcHcqUTydzIA1Yd3gDpqoHjs2gGV5HPV
         7eRsqR/FMzh3rfKRWfhZ8jv5Xk4QMd8m/sBtAuazfOJCr38J1YNl4PyS/aehVyUSmhJm
         QBG/kYbQKBiapNQa2Bu27Fdd+EXDpKrC0pobqXJb1iOnmbcBW3ku53vK8DsRDxozNHWp
         6uKOwbmA0mGMwrXq742qBoyD3Sl79EOI5CVwSAzBQ+3Gj4P6db5IH6BqPvSqoJqil8Mu
         UsT9w7UR4/EiTCIQs/nR5InVKNVFWCixZkA8JspEZxxbrYCj4iY7qB9vdisd/icq9I2l
         Eh/g==
X-Forwarded-Encrypted: i=1; AJvYcCV6kMWE4ydywzMbfQN42BS0N1eFbH+L1udooeB3G8gJga5aMGVJQBUXZIysLkNrkcWqZK9PBWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78e7ctUfcNJw/GboSXVbbgbXQWDD7YJDE6rxOogUTsLr9sJay
	M4oicg2004SmxB4bzd9pUjREPtFA9u71z/fSljYyy+w2V3937zypKFy0Dg==
X-Google-Smtp-Source: AGHT+IF0Ya5dKrGwTmfW9ooJ1b0YUkgsCfgGzZCjjQYxt3+nMrSZIR4L1sk3xwPdha/a2vvBfpzkwA==
X-Received: by 2002:a05:6402:5002:b0:5c8:8d5e:19b0 with SMTP id 4fb4d7f45d1cf-5c8b1b863ecmr691436a12.30.1727824487161;
        Tue, 01 Oct 2024 16:14:47 -0700 (PDT)
Received: from getafix.rd.francetelecom.fr ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248aebbsm6679102a12.61.2024.10.01.16.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:14:46 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: alexandre.ferrieux@orange.com,
	nicolas.dichtel@6wind.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] ipv4: avoid quadratic behavior in FIB insertion of common address
Date: Wed,  2 Oct 2024 01:14:38 +0200
Message-Id: <20241001231438.3855035-1-alexandre.ferrieux@orange.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mix netns into all IPv4 FIB hashes to avoid massive collision when
inserting the same address in many netns.

Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
---
 net/ipv4/fib_semantics.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ba2df3d2ac15..1a847ba40458 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -347,11 +347,10 @@ static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
 	return val;
 }
 
-static unsigned int fib_info_hashfn_result(unsigned int val)
+static unsigned int fib_info_hashfn_result(const struct net *net,
+					   unsigned int val)
 {
-	unsigned int mask = (fib_info_hash_size - 1);
-
-	return (val ^ (val >> 7) ^ (val >> 12)) & mask;
+	return hash_32(val ^ net_hash_mix(net), fib_info_hash_bits);
 }
 
 static inline unsigned int fib_info_hashfn(struct fib_info *fi)
@@ -370,7 +369,7 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 		} endfor_nexthops(fi)
 	}
 
-	return fib_info_hashfn_result(val);
+	return fib_info_hashfn_result(fi->fib_net, val);
 }
 
 /* no metrics, only nexthop id */
@@ -385,7 +384,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 				 cfg->fc_protocol, cfg->fc_scope,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
-	hash = fib_info_hashfn_result(hash);
+	hash = fib_info_hashfn_result(net, hash);
 	head = &fib_info_hash[hash];
 
 	hlist_for_each_entry(fi, head, fib_hash) {
-- 
2.30.2


