Return-Path: <netdev+bounces-129861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E94986856
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 23:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C411F22762
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA6C147C79;
	Wed, 25 Sep 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/TywTnP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70441D5AD5
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299798; cv=none; b=k4WLbxhLv9BIc/spj2rmXkFI1sCXQ11H8fKloP5UOxspx8gRbzMQUpokl6MsvADojCivQA4b+/BPhllWxWD+vtczJgQ3Dia1upexXfcmt9XFqD7Jtz5dsqkUhlV8nIvprN8KoeqeCqm/7baOsDkJbZjYJSboL/2pTZlaPuvVSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299798; c=relaxed/simple;
	bh=oPcvEjs5Gf3WI3M0hzil/Mum/KqrVuk3eWsOj6fmbto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IY2R/PxysL6BiBSmys8Cns0rsVXVZd8UoDRaKpwydONYuBfDtffyTbbhokiRiL73T5N0uKs7o40EZu2nC6UwVPJ2xcSyl3CLNlCTzLgT8kNkMekv0BaVphJvJ91qYtub/kzbHOPvr3ETFXsMjkE+eijPU57YURfCbXN9mIq0DQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/TywTnP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a93a1cda54dso42997966b.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727299795; x=1727904595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTzoK02kTYZcBxixIlCmmqrz5NjJYrBjw1wg41nBqzI=;
        b=L/TywTnPC+2J/pZTZtHhzW+DTderNPfzcUXN9ZW4XCaqWEz28spPkxgSzgnHwRc9h8
         J9X6SFho6LWA9eCWtOSymAYboZSthilSkCw6bo35XsPheGDRhsNnJGbUd7/c5X/Gy4fh
         +Tka4FQTjOKSPlpxAwt1F22MbUYN1YUAYZvNg+waMu6qElIEdNeERuVS0PTtCsghsOtV
         1ab08M3pKcL7th2RDBtipFPM9rILb5uS6syMa7it7m9fWcqxr1T8Vy11yEC8E86DgtGI
         7mR5WYbFdi/2M4NxpaFDnNKMvXOx93djbJGiU7ADXhqQsnh8hENI/OIgg6Jr5OWSqHIl
         E6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299795; x=1727904595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTzoK02kTYZcBxixIlCmmqrz5NjJYrBjw1wg41nBqzI=;
        b=jI2klA3J0bsb4ePiVOac8zj9543kp96aQatpyxHLWpOPMO58Ml7j2kQ4vwI1cwoK61
         Gtsafun9cBqxpzgrBPA3VYvJH14sj5P3SgCHLrBVecFb+9sthL6I4YCo1E6Ti5UqaU2H
         2ZIt5pAtLoXbPQGQbAxQ7a60fuUbhlyptQaJIDOT293sf73UJRVVOPYx7Jyf9NnQ1jyb
         TWxjZ6XP2LzpEWn/ujhyo8qoe9jIbIT26VHGLO70NSv6GV01LWtRxN9WHVG/K5kPUihe
         j5KQ02qD2why6YhjsLrqWcrgeBoy2xHLdg1fQCXv2jGHKqKHDSac325RFnvmT2Y0erR4
         qGKA==
X-Forwarded-Encrypted: i=1; AJvYcCVaGCbDYgvP+AiChhq1/qcJwwqMWYIocEwsYKEJUp6OerD7WakrDHfrKx8ae1PcQdl2SMgd1Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBODttjGokPO0l7Bcfv3O1Jzqa9n1PP1bKhIcHLamhO0XHKNbf
	HMDEHD4y+Ic9bPLshhik+Bl26Rgwxl+M1RzLgkUUi6QiR0rjUwKgkNnwQkfr
X-Google-Smtp-Source: AGHT+IEo55bPlJBN1p9atGCDChXlBpZ+/BWRb3A+yu22Pys0UPNZmGJq5kmEm+QLdftlvbPy39G/5w==
X-Received: by 2002:a17:907:7d8a:b0:a8b:6ee7:ba29 with SMTP id a640c23a62f3a-a93a05e7e95mr389573866b.44.1727299794863;
        Wed, 25 Sep 2024 14:29:54 -0700 (PDT)
Received: from getafix.rd.francetelecom.fr ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f4fb94sm263612366b.58.2024.09.25.14.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:29:54 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
To: edumazet@google.com
Cc: alexandre.ferrieux@orange.com,
	nicolas.dichtel@6wind.com,
	netdev@vger.kernel.org
Subject: [PATCH net] ipv4: avoid quadratic behavior in FIB insertion of common address
Date: Wed, 25 Sep 2024 23:29:42 +0200
Message-Id: <20240925212942.3784786-1-alexandre.ferrieux@orange.com>
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
 net/ipv4/fib_semantics.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index ba2df3d2ac15..89fa8fd1a4a5 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -347,10 +347,12 @@ static unsigned int fib_info_hashfn_1(int init_val, u8 protocol, u8 scope,
 	return val;
 }
 
-static unsigned int fib_info_hashfn_result(unsigned int val)
+static unsigned int fib_info_hashfn_result(struct net *net, unsigned int val)
 {
 	unsigned int mask = (fib_info_hash_size - 1);
 
+	val ^= net_hash_mix(net);
+
 	return (val ^ (val >> 7) ^ (val >> 12)) & mask;
 }
 
@@ -370,7 +372,7 @@ static inline unsigned int fib_info_hashfn(struct fib_info *fi)
 		} endfor_nexthops(fi)
 	}
 
-	return fib_info_hashfn_result(val);
+	return fib_info_hashfn_result(fi->fib_net, val);
 }
 
 /* no metrics, only nexthop id */
@@ -385,7 +387,7 @@ static struct fib_info *fib_find_info_nh(struct net *net,
 				 cfg->fc_protocol, cfg->fc_scope,
 				 (__force u32)cfg->fc_prefsrc,
 				 cfg->fc_priority);
-	hash = fib_info_hashfn_result(hash);
+	hash = fib_info_hashfn_result(net, hash);
 	head = &fib_info_hash[hash];
 
 	hlist_for_each_entry(fi, head, fib_hash) {
-- 
2.30.2


