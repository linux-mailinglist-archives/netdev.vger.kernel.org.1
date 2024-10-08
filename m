Return-Path: <netdev+bounces-133087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312899947EE
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866CBB207D2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643301DE4C9;
	Tue,  8 Oct 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+1MrJWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E51DDC31
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388865; cv=none; b=EMNpX/RadZQ+g0gnLyia/XwsmUBnJp6EK8N8Nrc5qpwCJ/syrrlAYGAmdSkMV2hE5c2YTNpCEfkFusUkJ+IsWiCbRR5sozJnM+V0jjuAGocGn2wY3GlAaYtC5cdkTeNCcHEYmyyIIHTd42VTozEQXdfwKq+6KMzYoF4r+vj1jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388865; c=relaxed/simple;
	bh=pIUNOW+x8+cddA8EU0k6XBOnOykXWiOrnMeD9mP/aJk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u5SVNoAwTP6Jubq7xjyVa2Z2YmcbK1BQK8eEYG6cPg53azbp9cA47y4FxAddOI5+UNyHGgqeaL28bDPA0ufe7ac26QhwUYua7d8aQSWfLv2xVf8TAEA5sNnUmS6v63toUbgx+QjIXRHxXkzyY8UoDTVsBlVq3RKy5h561+VE/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+1MrJWP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ea737dd5so1555513276.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728388862; x=1728993662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0XNtlx+MfNq/0PMnsRxp66PQApBp7DpZQv+3dFIOUR0=;
        b=j+1MrJWPf82IsoOVJu0c/gODAGQgmisThT5LGCYoer6s8104HKkyNOnTtknqFGOz2t
         vFUkyeCpxeS772cMSFWTjk6sqYX4yh3Y85oqUtRJpDsKxhgNURU08UXwhY96piinoTKt
         7vkjTKb2PcmqlFqKxZ6+Z233ttbaezuWXkgFL74GXNCoCVfoxAGKk+XzqcgxvPYDT331
         QbwOxwivDVxo47EWqqQyDSzpRTnPxtSXk9K9CVZFhK1FD/VntBCTyAm8Eht9wK8AzbHg
         nks4IhEBJS4sRLkHV9YtlO/jjMR2zXZnwTKi8O5DJNf1sWF7nPrk/CZbYDGDmBcGnfgm
         tjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728388862; x=1728993662;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0XNtlx+MfNq/0PMnsRxp66PQApBp7DpZQv+3dFIOUR0=;
        b=TBTBkxITIEFcSUqXetLkHP2dZ/3DRnf8A1NPhJQ2ExApzbVfdEJ1xAo2wHFhKwXJb5
         CnUlf48FXRy0gY+iO7tweUAeUFAiNfX4Oe+6ybd5PsjoTwrA5CePNZQ+gd9tMJeuw6d5
         xNi2jsFT9gHMrbwjB4L+GV0LJEhuvZcnO8pvzPbH6EgmgJ81KlHd87Sw/XY1S+cjoR7u
         EJH9Y/zztzdYdFmlWdiRnfbop4WvAfdYQmCEWgYpzVQiE6+gegGZ6TttpLJo6DXLm2mf
         sh2+Yo2rYsjamP6EeKtZ/qtsr2+J26Wrc6ZrR+NiqoI6LTM7K79Jv5B//pSnSj/OxMHx
         MNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZmgMYHYv3oC2Qq4KZjydQpo0vWg5ut3OM5I0EFqTIjYyknRlO7YuNC0VWLd1H6JMtONTzOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRWEXl8Wl/4lg4VHCkygf1pg3I0mtk8isDfMqIw5/vKkd5BWx
	WUXJXpoMecnfTfEj3C8XgQoCUSDp3yHRK+nS+XxjOlERvWxNhTsonYbcN0gffAudNwhZ1qJWydQ
	D4NxO175MEw==
X-Google-Smtp-Source: AGHT+IEjmCIx/NTQiS9/6F8u53kpy3V46OXZGBgAAPIu7oR2DnlegsrEd/54RaCdtBQEO5DPdqaZWuOhorWWSA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a5b:f01:0:b0:e28:f6f6:81a5 with SMTP id
 3f1490d57ef6-e28f6f682ddmr181276.0.1728388862488; Tue, 08 Oct 2024 05:01:02
 -0700 (PDT)
Date: Tue,  8 Oct 2024 12:01:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008120101.734521-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: switch inet6_addr_hash() to less predictable hash
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit 3f27fb23219e ("ipv6: addrconf: add per netns perturbation
in inet6_addr_hash()"), I added net_hash_mix() in inet6_addr_hash()
to get better hash dispersion, at a time all netns were sharing the
hash table.

Since then, commit 21a216a8fc63 ("ipv6/addrconf: allocate a per
netns hash table") made the hash table per netns.

We could remove the net_hash_mix() from inet6_addr_hash(), but
there is still an issue with ipv6_addr_hash().

It is highly predictable and a malicious user can easily create
thousands of IPv6 addresses all stored in the same hash bucket.

Switch to __ipv6_addr_jhash(). We could use a dedicated
secret, or reuse net_hash_mix() as I did in this patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 94dceac528842c47c18e71ad75e9d16ae373b4f2..f31528d4f694e42032276ddd6230b23911c480b5 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1016,7 +1016,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
 
 static u32 inet6_addr_hash(const struct net *net, const struct in6_addr *addr)
 {
-	u32 val = ipv6_addr_hash(addr) ^ net_hash_mix(net);
+	u32 val = __ipv6_addr_jhash(addr, net_hash_mix(net));
 
 	return hash_32(val, IN6_ADDR_HSIZE_SHIFT);
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


