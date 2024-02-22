Return-Path: <netdev+bounces-73942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0685F61C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B441AB259AD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8B146B91;
	Thu, 22 Feb 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVhV1rFs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC963FB32
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599043; cv=none; b=GYKlhoXqCHdhmZA8LLksw1fIHCNdYdxemZN7RMLLchfpWHgMcOlbExZiM/52x4g00hmnpsqcVuvq/XT7sAUMDajtDW3MTaPv5Bz/cgkdIAOIlTwPVO+zcLQBYUBQD2AtfqYFT5Nf0UqR1HNlHk4K2I2/5tBgeXMFByFi73VaoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599043; c=relaxed/simple;
	bh=ZU4oeEfhU5OZbWK+BI/TSMwQ0vUnw8HyL+5sNKPGSGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FpJFGrV9F8cC3+xBwr/3G7JzWgJGHYLR/18sdZLSN3AyPjYVCGbSrJNMYVqdBrysxg02fiQmILJxxgX3XY/Yb3hhgFtuFQWw49fYmAivYNkUJLgoyVgpqdrLpXNmWRENtBWwzlu99QU46+GSvUbDs+HoQ1vDWnFK5MQUd5Tp5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVhV1rFs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so10695690276.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599040; x=1709203840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCNZ1Oh8pK4G7CjTauMRJpkImioYlZW9fkTy2ao9pP4=;
        b=AVhV1rFsvgBS1Z/Vb6WUpNt3uEYCFg3NyzN37iV7tLpSWwfwJHGUsLD+oaj0WlQInw
         J4k/sjDGY7yVsjtLwhhA/06Gw8qitiNOJcNOhKUz9BcDEewPCyiMWvTiTElE/TKmMT9x
         6NiSIj78ggZnGxA1oWa19ArQj5Q2mofNaHuGv5y9pd31tRCzVGRQBX/1401lGM14rpsh
         LVYMG8Y5KOS+4OI/xxKiA9ac9mvt/0t9y/mk6Ibhf6uCmBhPsy0iWNYLNnvr3BxAYTx4
         SEP5mmasN3dOLgyTe8mjw9PBqo73ocXkBCxokiKHhjihE3vgHcmT54/Txyl1FtJ1NwfC
         Hl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599040; x=1709203840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCNZ1Oh8pK4G7CjTauMRJpkImioYlZW9fkTy2ao9pP4=;
        b=SKN68afO+ptm6djng22kZgWnAMjoWzYPLC01kzrV7NjyOgow2g2CKgoers0kHrHBXW
         lDvM5ih7eNORwBPb/+47xbcuQEPZm7KylDMV3+w3pN+3JfKfUBTha04Xo+onGKZxPL3Z
         zdAzD/TmUeijgu6LolULpO1zBCkiQNgO7GU8/+E+RwI+0uek7XI5kdY/xW7PhyeuH5Ik
         gdmo7ZRcft1oiPw//RNFZXfglso1viVQrnVvmwceEJbaM0QSaAD0zHh16C6Xwb0SBGVw
         iz5A64pR7M8xVJCOsnER5UHO5dIh+25RzS5C82HQ26lKd6q9+FudXfHIXWUpNu8vdBG6
         EyGg==
X-Gm-Message-State: AOJu0Yxo9JO3n04EvD2KY6vUEVxOos/adCJxRJ2YdpaUHb+A8WcyOpP2
	Q8hhXzA8biP2YWih+cwRVJbdC9ZVImrtj5KkjbH5iMPnW3xCKrUkta4DHu0tpNuQ33x4Ig/OlYB
	U70VLvRvJTg==
X-Google-Smtp-Source: AGHT+IECjnBe+Q3Yg2wF+4vfmR+tArZccZHJdUWOvADWK4nVjdhz5pvR+bLxqRlkir7JSrGdNpxP1QJS+8/RKw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102d:b0:dcc:79ab:e522 with SMTP
 id x13-20020a056902102d00b00dcc79abe522mr79024ybt.11.1708599040733; Thu, 22
 Feb 2024 02:50:40 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:18 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/14] nexthop: allow nexthop_mpath_fill_node() to
 be called without RTNL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

nexthop_mpath_fill_node() will be potentially called
from contexts holding rcu_lock instead of RTNL.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/all/ZdZDWVdjMaQkXBgW@shredder/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/nexthop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 6647ad509faa02a9a13d58f3405c4a540abc5077..77e99cba60ade85d25329074905b33424c11e7f5 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -317,7 +317,7 @@ static inline
 int nexthop_mpath_fill_node(struct sk_buff *skb, struct nexthop *nh,
 			    u8 rt_family)
 {
-	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
+	struct nh_group *nhg = rcu_dereference_rtnl(nh->nh_grp);
 	int i;
 
 	for (i = 0; i < nhg->num_nh; i++) {
-- 
2.44.0.rc1.240.g4c46232300-goog


