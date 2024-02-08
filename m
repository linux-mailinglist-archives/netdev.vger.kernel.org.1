Return-Path: <netdev+bounces-70258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FE84E2DD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268061C264E2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78F7B3DF;
	Thu,  8 Feb 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpSp+Lh1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712ED7AE67
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401548; cv=none; b=F/ikcZMDTeXVykhmQICU18zV1+Tb8xYrx/ND3iwp8vMAiZ2KWFaJBKWDYNanbURzpKOfqREAhLCj9upIWUr4g0Aqz11tBYPS2j5N8+vXenGFotLoVk3JyHd52pBr63YGGAVFfk5HdcB1/UGpnqdo1a3kJ8rOlwgQwmj0zNeUE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401548; c=relaxed/simple;
	bh=25ClL7WoqH767H4g7uyDndpTdLFT1mSh66swzGoqCYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AwUBDrxbMeNL0m1IwGfEYAdC2SekQT1eYlmtJo4Gw67oO6prmxSdxOJFcBwgF5f9zZfl66c1GuGFFx9glBgyq9y63u0dC6YJJ6WJuhFYFKZ6ehaDvLqjgkgdsMMlKYyxljd19MKUuima/gjmntgwcO4jsX0VqWtmEfzyhJLKqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpSp+Lh1; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-783f4adb738so185212285a.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401545; x=1708006345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0IAsWsB1rkkDQSBmIH07o3Uzv0VcNGVc215KBSmS+E=;
        b=zpSp+Lh1fvkL7/uMBYw+7pQJhdRdBx4Yf02RIs4A+g6VjXjl7f6lYJSFjwfGiqjUST
         cAPH4umO8Zb+WZOsR5Q28p9QpLjcV1eW5Od8A1K/F8swSWivIU9HcQsQxqiyeiibJyk4
         G6b25nLwd4jf5J4y2I33Rbr8DvrrdWPGHpxaaEmo4wKGLkq22hi33yqgTIMHQvTI7ssG
         cat1+CQtXgU+1Wf+G0tzaAmYD2tW3tf9N5oIxgRKqE2py6bc5fEviyCbtX/UJU4iiMpM
         GCwlOmH3UKEsdSuxwy6UQoz8JE5v51padNig+b0hBPeVBcWlevT+fipmzCcOmgmcIdvJ
         CJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401545; x=1708006345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0IAsWsB1rkkDQSBmIH07o3Uzv0VcNGVc215KBSmS+E=;
        b=Cd45TsdHsL9GRBM07ja0IhKb1WBQh8FtbKQZTD9iPriJzxiqxGkW3VeDud+pqukB7O
         e+rwtAPMpFDoZvvqccyzTevZCfWf0sJJ7C5fPYt1p426UciCLrTyDCOTWlZK5qwMixUE
         InxAv85GIQR3G8ITIO5OF3PP8wvv8qYJ/q84IZooVz2Lom9pxgoKBGBLyZsrJGBOFTa4
         vlm2ueoAVcnjkGzBgQtNDWS5N27iirFwrTQnFGXbgLjjrP/Ax7gGYJqtu+Gh5QNTEL1v
         ggC9b9SEHtA1bzcj5itdn94/6u27P36QnXgAmrwIZQGYsdHTHjP4THhQfEG0fcfHa9R1
         fDQw==
X-Gm-Message-State: AOJu0YwXM7+FJpOEjGoOtoCpeOezFozIib6mD34FPg5wQ2AiOViuSeyu
	BthGw0DB/JhTNmGAk7jmsD+XgDdXE+SR7xjESoAIWGCItOfybqcjC/KRXmpHDwIruLb6eeDJV3N
	0iV0VUsFnUg==
X-Google-Smtp-Source: AGHT+IHBhxntKJu67RYzXIacIj2rboyewQeEnydfrOSJl5p2z23rqo7b5czVZ1ePTRM6Yv7jAy6xEQFqdrS83g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:2cc1:b0:785:445b:e40 with SMTP
 id tc1-20020a05620a2cc100b00785445b0e40mr43322qkn.2.1707401545198; Thu, 08
 Feb 2024 06:12:25 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:49 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/13] net-sysfs: convert netstat_show() to RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_get_stats() can be called from RCU, there is no need
to acquire dev_base_lock.

Change dev_isalive() comment to reflect we no longer use
dev_base_lock from net/core/net-sysfs.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c5d164b8c6bfb53793f8422063c6281d6339b36e..946caefdd9599f631a73487e950305c978f8bc66 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -34,7 +34,7 @@ static const char fmt_dec[] = "%d\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
-/* Caller holds RTNL, RCU or dev_base_lock */
+/* Caller holds RTNL or RCU */
 static inline int dev_isalive(const struct net_device *dev)
 {
 	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
@@ -685,14 +685,14 @@ static ssize_t netstat_show(const struct device *d,
 	WARN_ON(offset > sizeof(struct rtnl_link_stats64) ||
 		offset % sizeof(u64) != 0);
 
-	read_lock(&dev_base_lock);
+	rcu_read_lock();
 	if (dev_isalive(dev)) {
 		struct rtnl_link_stats64 temp;
 		const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
 
 		ret = sysfs_emit(buf, fmt_u64, *(u64 *)(((u8 *)stats) + offset));
 	}
-	read_unlock(&dev_base_lock);
+	rcu_read_unlock();
 	return ret;
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


