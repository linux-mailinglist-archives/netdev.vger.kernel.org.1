Return-Path: <netdev+bounces-126652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26997220F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88401283335
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0018951E;
	Mon,  9 Sep 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwXZX6QJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B017A92E;
	Mon,  9 Sep 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907717; cv=none; b=oby6xep3kb4h3AkY6TJgL3OYkfALu7o4cKCzSZwiCQvq7vqVd8jfnf+nd17geS2ZBm/zygXKumdBfCCVCcH10qXDRt2fyX0ILP6qvGQ2zDSMrn77WqKdZaEPb0UwsjmMztRZtdpaaZoW1PYa4KjDnHjBtHBwaObCBlH402ZJvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907717; c=relaxed/simple;
	bh=opDvcsNzBPHx59DExhq/FmozYJ3scDPTECogRp+m2KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MF2ru6qXw9pwzRY+moTwcnmZ7rFBWgheInRiGG2guzsWAQkilJrNpChgzWra6InOqL4Xlj6NMZqC4psPUtkAbqid2B7TpMnpD10o4mVKpt0ZA5NVlp71QPkpZ4ybOfd7O4mv/m6c718IoHue1CnQgxB7B1nPO6sIRko/HxwvWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwXZX6QJ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27830bce86bso2623544fac.0;
        Mon, 09 Sep 2024 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725907715; x=1726512515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Evv02wRZtoNC+BDsMRqpz+3iRpxo+7R7AGdDISkteFg=;
        b=NwXZX6QJ/9he/sBrFaU6bW5tR66qdu5gBZQOkYfGypwh6ut4rB18e7Kd4xMJea1LbQ
         C5BrtUH50Ou6Rkzpt+qRPSMYY3rNB4GIHjoNevFt5g6c9XpuBhZihFjTE/KVO6igCl/m
         merQ9dI3fQ+oI/YHYUdhEL6kGj3JaLMrEGEL8XnkjABeecUnYiTcNEHrkfBel32l0hSR
         erZ12CPz4B1Q2I5wMD5Y/C5zwfCTXRgaEk/+9xHmovwxlpKswwCspUOhEbGJOzrVSmep
         oj3ppwDs9mx56Rk8q9QXKaaRjPM2wkbw4XT5ZIYzYT3FAQVOdCAv9u/+DDCt9nMNMaSV
         40Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725907715; x=1726512515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Evv02wRZtoNC+BDsMRqpz+3iRpxo+7R7AGdDISkteFg=;
        b=l64KCKnWuYHbsqFmTGbxbAoKa37IauBuaaXAMNKFJeqSLUzVkBf0Gn697E9IWxrvLG
         TkiLiCzu4SxRDYVFZs/CnY95R98xyuhITv9XCdA50fokBO9vrseBcgJKcycBUGSuHwVE
         3ourHzcH9c4wjBDH46JsBFDyT51qZxufZsTkZdOggAulivcYujcLJI5caQiQ6k9k+iSL
         0kgG21nx7v2GnvRXovFM9DqygLHjLJwaucr6eFQmUIC1pccWQeDezROaz51/Oe6BDSBj
         CIOsHEGsXqUqWHE6TraVzS1PzSOWlfe4w62o5iR+76Al4dlKqRrIbLbe9OzgvpwSc/16
         /VuA==
X-Forwarded-Encrypted: i=1; AJvYcCWOUFtD1+6PkRAqGTOBxiPmjrxVuSXyALLqQAtGwqA/f2oQAI1ck/i8doicVHh1RXWrQ1HVvvGc@vger.kernel.org, AJvYcCXetRJcQkVLLhtBI2oiMFimsNHR5zkHx7+/Aq5qodAHhbXf28jJCy4ZswQodpOmdCM8456FNqYnc6LMf2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCfprqcpmBHgvoUqU72dWS/Uz0sDj+kyCMkIVw9wth8ih8ofD
	431hlBeSgSXyysJoItsrACH5A6r9PjInyZ3XwWEkT9ZlKoWMvf7w
X-Google-Smtp-Source: AGHT+IEbSXmGXqSJ/Yl/Tle8iq8bB++evpdiqf0ZOMgr6sl80+BemZ0IXyPtw9UcrwpnoC7xl++uJg==
X-Received: by 2002:a05:6871:3a24:b0:277:f826:edcc with SMTP id 586e51a60fabf-27b9d7c0c39mr10652504fac.5.1725907714881;
        Mon, 09 Sep 2024 11:48:34 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc17esm3645998a12.62.2024.09.09.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:48:34 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kafai@fb.com,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] net: prevent NULL pointer dereference in rt_fibinfo_free() and rt_fibinfo_free_cpus()
Date: Tue, 10 Sep 2024 03:48:27 +0900
Message-Id: <20240909184827.123071-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt_fibinfo_free() and rt_fibinfo_free_cpus() only check for rt and do not
verify rt->dst and use it, which will result in NULL pointer dereference.

Therefore, to prevent this, we need to add a check for rt->dst.

Fixes: 0830106c5390 ("ipv4: take dst->__refcnt when caching dst in fib")
Fixes: c5038a8327b9 ("ipv4: Cache routes in nexthop exception entries.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/ipv4/fib_semantics.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 2b57cd2b96e2..3a2a92599366 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -153,6 +153,8 @@ static void rt_fibinfo_free(struct rtable __rcu **rtp)
 
 	if (!rt)
 		return;
+	if (!&rt->dst)
+		return;
 
 	/* Not even needed : RCU_INIT_POINTER(*rtp, NULL);
 	 * because we waited an RCU grace period before calling
@@ -202,10 +204,13 @@ static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
 		struct rtable *rt;
 
 		rt = rcu_dereference_protected(*per_cpu_ptr(rtp, cpu), 1);
-		if (rt) {
-			dst_dev_put(&rt->dst);
-			dst_release_immediate(&rt->dst);
-		}
+		if (!rt)
+			continue;
+		if (!&rt->dst)
+			continue;
+
+		dst_dev_put(&rt->dst);
+		dst_release_immediate(&rt->dst);
 	}
 	free_percpu(rtp);
 }
--

