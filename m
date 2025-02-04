Return-Path: <netdev+bounces-162533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC2A2732E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093DB1884354
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BB21A445;
	Tue,  4 Feb 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHj44hB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329D21576C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675453; cv=none; b=QG4l8naiS5OaRt/wRf8BAJQP9CsxtA/v+T0WvRpC/+k2nxIFVGMbZlvKvEUUfKTNqR7hZw+sHlNaVo3aZGyE2jxOa0Dqq0L87NCrxqjJaxFuZ5kUCKTZSx+tb8Ob92nWT2FM0AijakHBMVfvD3HNMiV01a3MqjYWkU1rZzFwN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675453; c=relaxed/simple;
	bh=wBUlXxqCOHC5mb4l82j/huFvC/81SsSroryG3eWs92Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wrvy+V1c7zbOnN6hHcJjwqGr4PUtNmSOWLjtwg1pd3AShv9uGnINaw9avtWGNuT6WkccKbbfxlF3AjetRR8Bdd8fBnDDA0oihbb+0eUdzNNJ8gRWQXTqirMzNMSiSVEvgf9qbQf3MSnfNRw/2Nntf5FeStLHmKgmA1MT0Yx78sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHj44hB9; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4679fc5c542so102636761cf.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675451; x=1739280251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0DPhFcYIwCjlPd5Kix9DbDaw6MNxiwJUB+YXQT63GU=;
        b=lHj44hB9NhlSS7+rO7Be/eF9q6ftEmvnbFOypO4yreE4GdMhwOUhjqDMPlf4fD32Sx
         Z/CW5vHkzuF2+l2XLAfylxIbP8l9IzKI6p2a2778yj8tl28f65wCxczirwvrWg7HKPis
         toAo/OoQ9S10cTW25Y7gpbAzOINQ38mGye/Z+gh1ZwF8/8BUeCqg68eDyp54a0V23qhK
         jkYlA6PGV1FpjYrVrK3ZBLwzspxkw2Kqg8JQsHLY19bC2OQ2if9wPQbwJYUvGhUGt3UX
         iZ43kyuZqLd6jh5ZFeRuUNxNIWeRJli0flmddIEOm5aL1Y6/hkuxQ7iLItpaJj3muxL9
         mlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675451; x=1739280251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0DPhFcYIwCjlPd5Kix9DbDaw6MNxiwJUB+YXQT63GU=;
        b=YRCEIWV1kzFoSUsa/7v5LprdY9HT2QywiyCE1l0HyvqmibGzDvccC12oc8tRS98XLY
         BCfyvvCyfL6VodXS9Sf1vF1JsEI6OA+rCjM8OjbJZZI1UDC11Ui3McCarY8vQsuxXbBI
         mf65UhB3kM7kyr3/Z7ec3W7QckOj4IjifvZEDOrCv6K3w8s0bzyYxuO0QLoUajn9jLfo
         78iTvee8Ukr9r0QOZxRzX1Uxa9bFBt1kccdKx3lIg/Y+R+5T3LhAPHggMm+iI27RDGgd
         EKeXu4poUx6uWOg3V2QIeqRmH+oM75WsQJew3UMSL9dm6ApLTDpUhnodJ1Hz0R87k9M3
         HJZQ==
X-Gm-Message-State: AOJu0Yw1nlfuDnrOtvWuZ2/5FPlq/1rJxABZDy2JF6lqHjau/sFxJZqX
	l5G4oiBPh3zT3uRLZTFTMn3CdMOyj10OJVtxZVlcD64By6ClXhmwJBKQVBvcfPZQ4CstH4ZIK9X
	cXlAwwXCiYg==
X-Google-Smtp-Source: AGHT+IFhjagraMPvGg9635UClSsggwkDiCrEKNAlaQDERzz/ZUR85ExBWoLc47iDr8tlva3oNgiRYdniLdiRhA==
X-Received: from qtbcc27.prod.google.com ([2002:a05:622a:411b:b0:466:928b:3b7c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5e05:b0:46f:d6c3:2dc7 with SMTP id d75a77b69052e-46fd6c32f17mr266662971cf.23.1738675451234;
 Tue, 04 Feb 2025 05:24:11 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:46 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-6-edumazet@google.com>
Subject: [PATCH v3 net 05/16] ipv4: use RCU protection in rt_is_expired()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rt_is_expired() must use RCU protection to make
sure the net structure it reads does not disappear.

Fixes: e84f84f27647 ("netns: place rt_genid into struct net")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/route.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 74c074f45758be5ae78a87edb31837481cc40278..e959327c0ba8979ce5c7ca8c46ae41068824edc6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -390,7 +390,13 @@ static inline int ip_rt_proc_init(void)
 
 static inline bool rt_is_expired(const struct rtable *rth)
 {
-	return rth->rt_genid != rt_genid_ipv4(dev_net(rth->dst.dev));
+	bool res;
+
+	rcu_read_lock();
+	res = rth->rt_genid != rt_genid_ipv4(dev_net_rcu(rth->dst.dev));
+	rcu_read_unlock();
+
+	return res;
 }
 
 void rt_cache_flush(struct net *net)
-- 
2.48.1.362.g079036d154-goog


