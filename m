Return-Path: <netdev+bounces-94120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453158BE427
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E372825A0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05141C8FB0;
	Tue,  7 May 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4be7akK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A315F3F0
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088003; cv=none; b=P1cd8yWawzKLqtFf8u/iJVaMxnatBBsFBeqanNDzNCx4onQJeEH3f1jqbWcbHZgeZlLft1lzmV2VTlKaUFfir54z4lphsl+TFT3kqTSHrdU6832t/v69BvR3e0kDDXNjVd2Z9euttT9Mt9uqbk5W4CifgJqmsFbewyBGJvtfwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088003; c=relaxed/simple;
	bh=l3p6SvTPym4Oeo+BJ/ZjXEM0782YPWrx47g9A9DR8ac=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F7zOq1cTvnM6xlp8bLMrordBw7C9bhIBD+HYSL5wylrmZdnO1vRSe0w108c25+SWtNkoKC1LK8xaCzTS4wQ4zvUHm17Hm8twfjvo+omuqkQ7kvNnF/+XtFgz22VRUcdjZEB18t/sRVGeTKjDESSdoaeBpdosEJsQp5klQ88SPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4be7akK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2ef746c9so57838547b3.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715088001; x=1715692801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aHxYB9MPH3G+6WDL276VecDzswDWyYyWhk0nupo94+o=;
        b=I4be7akKSu5d2yWYGXmtKeZ/Abyg3Z7kHMKpEP8Q6ve67awi5zl/Eanou12eWqesEX
         a2mJKq6Z9uDggYz1Th1krb2f0Yfr6pndJEqij8E4t+rKC4qgiCE+FkHC9k77cz1jPVVZ
         RkCxwpi7Zrt94h3SQ8V8apoclTYuuRJHp1vhbhH5CPZPFZNq+j5JNCIJ15QkMq8j75Sc
         kRdavhCq2XUg18uDKmJW5aMqkCkmLVxfX2i07EDlvBEYP9Jam4P78SGk2AxH4FdR/HJ3
         B0nGK/6E8fJRxw/MC52gCNoGba3HJtlUMAhlSS0lx7KsDp3YyRmPZ6xjh+yGf6Qbs0Vi
         NWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715088001; x=1715692801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHxYB9MPH3G+6WDL276VecDzswDWyYyWhk0nupo94+o=;
        b=ciEFnorfZ4vsCgPXl72NoqhxTqDUgEbYGLMRBPp27/7J/VIZ7fIjCMUl1KGwAIS1qA
         4Sa9BBwHcz9NNLkCAnO2G2a2hCqiw/HkbsfyeAwv0wy4TrIyk5NoCcGm3LQSI/s+HJrv
         32VeHoRg3qX3M0dePAPe3TeNIYVNV8EUEYlIsSjLHOYGLexfdk8mNiKQLcuXGfPZymp+
         1i3KSpElS2L1zj7eovJi/LJhg9ZLUUdJiUaBCW3Y2M1YJc/kGTYYnFkP98XcsNxu9stw
         AycGcet21frp3qrdeS5ERSJpFt0LFbzSGTKJMbviobzRxvuvrK0aW1m/6jTQOFkGkyMT
         3OOQ==
X-Gm-Message-State: AOJu0YyBxre7XK47rrzYeyUnW2HhZ8RhYodU/XaaY9fkHcxcjXOakEp3
	7mELVBSOLHSlS9gNerNmctXecZ43CvO93olSbZFtnrLfZBzNpP64rEWl8mMTKsHEyjjsko9XeoL
	+t6+s1P4J6Q==
X-Google-Smtp-Source: AGHT+IHWUJ8huTe0qVjYJsUPauDwq1gtXIF5SZg+603xirio3Lj+Lol++GCZXhsypdirr/gWxYx4NWDnVoeWfA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1023:b0:dd9:1db5:8348 with SMTP
 id x3-20020a056902102300b00dd91db58348mr4480474ybt.8.1715088001497; Tue, 07
 May 2024 06:20:01 -0700 (PDT)
Date: Tue,  7 May 2024 13:20:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507132000.614591-1-edumazet@google.com>
Subject: [PATCH net-next] net: dst_cache: annotate data-races around dst_cache->reset_ts
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dst_cache->reset_ts is read or written locklessly,
add READ_ONCE() and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst_cache.h | 2 +-
 net/core/dst_cache.c    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index df6622a5fe98f0a9732617bb2a757ef9c9611797..b4a55d2d5e71b974b0012bc7ec9a5970a6c0dffe 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -76,7 +76,7 @@ struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
  */
 static inline void dst_cache_reset(struct dst_cache *dst_cache)
 {
-	dst_cache->reset_ts = jiffies;
+	WRITE_ONCE(dst_cache->reset_ts, jiffies);
 }
 
 /**
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 0c0bdb058c5b1ab81e14aa48d8612a6253a7c852..f9df84a6c4b2dbe63c6f61fb431e179f92e072e0 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -47,7 +47,8 @@ static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
 	/* the cache already hold a dst reference; it can't go away */
 	dst_hold(dst);
 
-	if (unlikely(!time_after(idst->refresh_ts, dst_cache->reset_ts) ||
+	if (unlikely(!time_after(idst->refresh_ts,
+				 READ_ONCE(dst_cache->reset_ts)) ||
 		     (dst->obsolete && !dst->ops->check(dst, idst->cookie)))) {
 		dst_cache_per_cpu_dst_set(idst, NULL, 0);
 		dst_release(dst);
@@ -170,7 +171,7 @@ void dst_cache_reset_now(struct dst_cache *dst_cache)
 	if (!dst_cache->cache)
 		return;
 
-	dst_cache->reset_ts = jiffies;
+	dst_cache_reset(dst_cache);
 	for_each_possible_cpu(i) {
 		struct dst_cache_pcpu *idst = per_cpu_ptr(dst_cache->cache, i);
 		struct dst_entry *dst = idst->dst;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


