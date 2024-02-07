Return-Path: <netdev+bounces-69846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A197C84CCB4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554B61F21679
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F07E590;
	Wed,  7 Feb 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsxmVct2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7837E567
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316009; cv=none; b=QZ8msfTMt5KxOVBHLUr2GjElEQ7Yyzg2EIdgmxLhWEAJ7i/EQhn5PR3xSuC96NM5rmpfHKxSkkkhzNGhoZXym+B58pCSrdzI6qR1+nEh9gJvZ3SGbNBKUYWiOG+CFMC0dee7HnEuIQ+ReDZT9g3PUEPgeF50CuoDpKkgfwQJ9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316009; c=relaxed/simple;
	bh=25ClL7WoqH767H4g7uyDndpTdLFT1mSh66swzGoqCYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SvMex+WuM/IoQmeKvxEv56CrHW0V0LLNwLyeeRo1/0ER4qR+Zcj37d/MSG8nGq6kHW3HtVamz9RhGPChi/EQ1HbpIqpwFVGa4FwvNK16j5K5L/s3Atiw8QMHOuOWLnJymwzkJBdTtfX/SXi8KPRK9RNPaDo7UhNkWQGyIki91d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lsxmVct2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6df2b2d1aso854745276.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316007; x=1707920807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0IAsWsB1rkkDQSBmIH07o3Uzv0VcNGVc215KBSmS+E=;
        b=lsxmVct2mqJVDJbIcTwfNqyme+DNirGycn4bweXFuDMWx9bp2/BO3zEiGs+K5OO1op
         ZXYe8wigYxY5g09qxx8D2NCvh//jgXvAR17NFb2th+zEypzapNkE1w9e8XCy4CqicEP0
         SknIcRHKctRbmGWOxfEUL7wNlj6FniNxlbMf260ynpecNgPUh3AlpBW+ps8diLNpjjN5
         nfQTdtJAchESnbTKManpg+TaPKLhrHrMg2r2g7+KE0QUzSeZaCVRDKk1bxmzHbrsgsP/
         vw2n3vqMnXYJhf188VQf1UPKPPEtXFP+ulBglGAW/Ubxjmp0q2UxOCfeFYg8dBGHaxpd
         OTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316007; x=1707920807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0IAsWsB1rkkDQSBmIH07o3Uzv0VcNGVc215KBSmS+E=;
        b=qq7vOhiewPGk8Hv8RBbGkpAIvSOgg6P1JGKkS9hW9FJGFY0mUBpAsOhKEPdpOGxOAJ
         2qcV03SMVhagS7dyz9+y42CQnBgeWhIoXqstvdNmov4Q39a3ldzideggF6jSxVeFqXqB
         aCx7euiKXy15uVYzX8EHXz6wybqMW7Sr2Ea6B54Mwh720v5ThgS46L8WK3i6BbLJ0Pkf
         WlJkkPWb+LHSqvkU0AM04rC7lg/J2Pch11kggIm/FWP5wXphKOA20tbCSt4FR9APW80m
         bTcLBGdMpDHrszFRamS78z96Dtd6dVueDzk1N9d6vX/0EU3fxBUdMFBZxDf+Oy7A5nbe
         hDfw==
X-Gm-Message-State: AOJu0YyFvk6c3rb40E8vT+zVBugCDQAMAQKvnKCo/8dNk6TMXEAmRIyN
	/WyPIgo7luKxc+ThjAXuAnghukUmOa7lIfvDSoPSQxvHFKaeoBETCEbs2KGwUNPIovH23m1DiT8
	DDcjYAb1+GA==
X-Google-Smtp-Source: AGHT+IEfU9i8Dic/6/T5TTaK5E65VIFzt/ENU/4yZzR634OYNlGv6k4n1lH1pggLE+kEaEjeqizG9bPCNusv4w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:178f:b0:dc1:f6f0:1708 with SMTP
 id ca15-20020a056902178f00b00dc1f6f01708mr178870ybb.7.1707316007420; Wed, 07
 Feb 2024 06:26:47 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:24 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-9-edumazet@google.com>
Subject: [PATCH net-next 08/13] net-sysfs: convert netstat_show() to RCU
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


