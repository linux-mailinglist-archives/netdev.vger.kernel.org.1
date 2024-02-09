Return-Path: <netdev+bounces-70639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253D84FDB1
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A331C21DFF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A3B171B4;
	Fri,  9 Feb 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPVpIfSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F76AD7
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510910; cv=none; b=ZC7YOgbURaeuACmKPZwpJql8/KwrCJXc3JAA2/c0CNbc1kRS/4cn357lRKIkzXkX79NX7ILD+mt653+CV9VtQUYviTv9GDDoEcDHzrcWcI11WXAA5vwRuWoZUrOnJXtFC+u+q4vvHzTXqXYxXOYUFlfnAQV8wGgwKZ4cHy/Nxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510910; c=relaxed/simple;
	bh=agQBBe3gGEuUVQmqiN2/BV7cXJovu98w3yyooCl1rCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dzAEolNb+QeW1pY4/77t+q7xe901jUB2eyzcJ8R27lbf+VeGyfNp/r9dapJltbOQYSRSy8D/KI8ZGUaAP+aih5GwgMIzA44bGu21on6ydtocEN2W6p7jCvyCLUBdhK6CHV28BeabjJcSBxbwvZMGl+Go5M+4PW4JJdafe7NLFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPVpIfSn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so1857189276.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510908; x=1708115708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHXOpWBVrruiE3l6dQqMCwanEDTCE2ZLCZC+dweAjwk=;
        b=bPVpIfSnZKDfeDHieRaefIVv3PQI0hDn9PWVuz+cEOZETc2TX5ha26amhlAeRNTzPJ
         yuiJJKL826TdaN69peWOyMY5/OkTdZmba8GXa9Bz5MrZ8cQqJ4OZe8D+GAelMQhUOp2E
         GJThOVHR4Ks46iETqzIqh2hk3GUnDBlXl/XcKv9K2373POt41/4NSY95rVMhYsatuSgj
         fuWg4RGuulnQbP/peZgeXWTm5KC46jQlhvcq4TFqS80ajh4Q1Dp9KRkL8DSdjcP5WQoE
         cZZ8wLYk9HROd2UA6g+zDrqffwcmb/TyWbLTmpuZx4RCzPDy8YzAt2vWsBq8uI7usmCD
         qApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510908; x=1708115708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHXOpWBVrruiE3l6dQqMCwanEDTCE2ZLCZC+dweAjwk=;
        b=H8GqBQ9n+AQnmOPDO8hCuPzY7/uAJCBsbp+e+jJ20C8QJChWd4wT8EOMuA5tFGov/k
         s9+PC+gktMYEiW1xKPEZ5MlJZMTvZMxFIll7mmnWN80ZwTp1sNp+yiyK68TfanZbRT5b
         G4yEyA3BeAu4x9+u18+xjrfGDAwJTvoH9LXMLViDxlDv8NlkoilN/j3qUpkfcT1xnuGO
         UAgp7oQKytaoT/r+Z0SilDqy8s8De09X8h7nNzG4gL1+NjPXBZ9PnPIs6s5y6C7k+GRk
         PCvJ+fply0kKHjlrlMKZYdb81/Mo+u0lK6zNKQVEQTyherWVF04PTpoSgzfINlZPyErl
         v+YQ==
X-Gm-Message-State: AOJu0Yyae+cJtXxriNEKazOLhsGB2EPVWBxue7z3M2IktWwZvr8L4VWI
	ZpUSMmO22VyvbGyzfw2ftf502RQoVH7+f3eMfmJwGO1sHWq9kKJcLC8Q9qUwGxaOfAXR7e03KTU
	bC3fIbU44iw==
X-Google-Smtp-Source: AGHT+IHBlzEyUILr78Kdg4mmMHWodAuS8DPgflPO5fQNY2sVHxfWX+qYMG094SlnOGvGhfmZVnz2ljCbeHl+eQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:dc6:d7a2:bc2 with SMTP
 id w4-20020a056902100400b00dc6d7a20bc2mr4777ybt.9.1707510907957; Fri, 09 Feb
 2024 12:35:07 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:23 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-9-edumazet@google.com>
Subject: [PATCH v3 net-next 08/13] net-sysfs: convert netstat_show() to RCU
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
2.43.0.687.g38aa6559b0-goog


