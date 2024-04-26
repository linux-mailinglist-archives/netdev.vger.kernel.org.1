Return-Path: <netdev+bounces-91543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D098B30AB
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30F528610C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F0513A41C;
	Fri, 26 Apr 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tH+dcbX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D613A276
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113746; cv=none; b=UNxFVpKHOYCU0rmYQT2HWPx98EeEPyYn9+lNKUhplugHrPL87nP25Gci4pyFAsMeEYqbpjj27DxwzddyZG2N+vtA/hN6f8wTOzSEpswhYrEtoSIoSaGrOTB9MEP9JhbQUAs8WxjMtarkPTIxW7A8b9PmLRB6HXDJ72tRA/bUqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113746; c=relaxed/simple;
	bh=LZwh41/3PCO7nP/qbJGU/4fUJ/+xlFL1F1d2eurLsE4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LP+wUmv0ZT4KXwNdh4gMQGoiAgrqKAUYpVP/6E0ZS1pS6t3BjMwPE7C+LfV9IXhUO4LjXWKxdxAEeF+2Yvc34lRYcn0LXh1GjLcDSFzdHAOnWSlzSFdGOqYYKBmjh3xoy+DUmzIEeZDeVg1LvOL7ygaW4E2/grAmRhOGdBQMtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tH+dcbX/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54be7066bso3365407276.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714113744; x=1714718544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muRECqqD2zKbdayMfwLzQyKulFPXE4rtS1RKzbbrQP0=;
        b=tH+dcbX/r9UjoMJh+HWm2hljXThnZCta3gIEvVac7+xK1yi8apgyNzUCfNlrReTFD2
         Y2z7OBuZ1pWUGzce1RWUdXiDFNdPZwbqsTuYlE70Rxw4DMdBYslkdFsgKt75aFLezHxB
         lVWmLpM8OrD+3lmgzSJGHhgccAXO9T3918O2KyPqLnJ+gl+Ls7HXZLxtXcb/uJojq4is
         2eod4ubTvQTQckQedSa40ysnVIYtjR7NVBB4Pu+Ek954HHwTFc7Rak87nbehcTvv5Jxs
         owaqOON0+SX/xnv5xryBO6EWqZlMuNe7FAc5RS9381PdFTbwH5QCfPTP7H8D5LN4rJt8
         aEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714113744; x=1714718544;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muRECqqD2zKbdayMfwLzQyKulFPXE4rtS1RKzbbrQP0=;
        b=EgNDV5MClef6FucmyOGOTIroZoupGhUxFnfZbcoerMgKPBmH51/d5/9eQcLlai3jwP
         X1jtyLLMNkeGrfdW5oM2kCQ3viTkh/D/CnMTycYu3/NBqt95GDSF5kc9QdhIj1ojx3C/
         suINmpalTQbFqn/zmV0ntEYB3irjbGwy0lYJt9RGry5muBEbIH44W5YAZi+F/GZKy4ZZ
         1i3xK3+mPi8IMErmN9grDuwF3v9npNUTFuewBdyGMzZH+VbjsP37Dt5/eOhICNdagMeN
         eQNiQtsTGIgDYzyUqjLAbaclSNKlyaXWvN4+Rtv3PaTHQm7GDgqWGK19FE/XfYSsMGm8
         pdVw==
X-Gm-Message-State: AOJu0Yy4N4Tf4bWak9amGKfAdgo1Zclr25P+n7XfQiwbiw1GOj8JbXn/
	xOVW9csAkwypiKFHHVZgTJEBjTkgQPnQleEGd4wELGpxq4oURnwBCjPZyUC9U7q8EwNFKG7iPRj
	1aKDZ0DzV8A==
X-Google-Smtp-Source: AGHT+IE+I0FokLBW/rUVcyKHufxqMjk7LQmsekapz4mmLCO4qotcmwcthd/Pl8zsEr4sjdghkR3T+E+nhC9ijw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:a28e:0:b0:de5:5225:c3a4 with SMTP id
 c14-20020a25a28e000000b00de55225c3a4mr518250ybi.7.1714113744350; Thu, 25 Apr
 2024 23:42:24 -0700 (PDT)
Date: Fri, 26 Apr 2024 06:42:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426064222.1152209-1-edumazet@google.com>
Subject: [PATCH net-next] net: give more chances to rcu in netdev_wait_allrefs_any()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This came while reviewing commit c4e86b4363ac ("net: add two more
call_rcu_hurry()").

Paolo asked if adding one synchronize_rcu() would help.

While synchronize_rcu() does not help, making sure to call
rcu_barrier() before msleep(wait) is definitely helping
to make sure lazy call_rcu() are completed.

Instead of waiting ~100 seconds in my tests, the ref_tracker
splats occurs one time only, and netdev_wait_allrefs_any()
latency is reduced to the strict minimum.

Ideally we should audit our call_rcu() users to make sure
no refcount (or cascading call_rcu()) is held too long,
because rcu_barrier() is quite expensive.

Fixes: 0e4be9e57e8c ("net: use exponential backoff in netdev_wait_allrefs")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/all/28bbf698-befb-42f6-b561-851c67f464aa@kernel.org/T/#m76d73ed6b03cd930778ac4d20a777f22a08d6824
---
 net/core/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e09aa3785c159b4ab0fe7eb3546f9dd6797ebce2..c9e59eff8ec841f6267c2749489fdc7fe0d03430 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10566,8 +10566,9 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rebroadcast_time = jiffies;
 		}
 
+		rcu_barrier();
+
 		if (!wait) {
-			rcu_barrier();
 			wait = WAIT_REFS_MIN_MSECS;
 		} else {
 			msleep(wait);
-- 
2.44.0.769.g3c40516874-goog


