Return-Path: <netdev+bounces-179751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8EA7E6FD
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AE1899DC8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92620E01C;
	Mon,  7 Apr 2025 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZmWza5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830420DD6D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043770; cv=none; b=r/liD01sXgoWWea8UzuLyU9Z53wlDYoaFPmyGolE2eMVY3uBf9G02BASYivl0jAUTvlXMpTPsjapJeyaqaSTEibZGebAl4mhqM5gwfczFk6a8O2KIHMJlkruN5VZ+bXHsu61unSuWeM2/S2oHSetHs9HdgLLBUw67EhmSxDBToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043770; c=relaxed/simple;
	bh=mmCBiDD4NCOPe4hbQrJVDziA5wv/UyzyAhNvyxP2SDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rd/lDOqrHJsBGHA2UEtohhckpyFnaWEskhCg19zXDsmkPIiYm4rdq2oa8NNtYUhSDgCCUlPfnWn5e+URUmp+YxF1Q3clnqoNPZX6G7/BqOUCGsjqWnogtA8CWdP7RTsUEAKIrVhmmECFbHtLhVYI77zkNJB0HR7wlnTl044k59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZmWza5C; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4767348e239so90899821cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744043768; x=1744648568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMr5C2o766gb7ANZP/l/JYnVF4FmnlL5quz8zVXfGfk=;
        b=QZmWza5CcSZDrigxbeK/JbPKFQI2om2jlEY5cELYCyoQH1NmcAdTiOtAsfEmvLIbp2
         8EGo/5otY+n3qhhmj1WjTQxGt/9lpYE8NU2rlTKGQgKVNkcy5tEejORqiA286jLY74xU
         JBK0DfquoHykJ3pFXLZI5SAULpxWYhvG8mswOioIoIdcdBx6UG/B6DmTcugkSPCCP3Ez
         CIijNCvEZdaJ7vRHc7OMkh8rq09gGh5+3HxlgJdhJCHs3RMF8+wuMjOWrYKQZMc9pCSC
         3Y/WAks3wbamzw4XWcc0fWzeaXfsg9ToMAM2BbMwAIhebgREB3bQbWDsj3VTjHxRDgZc
         fQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043768; x=1744648568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMr5C2o766gb7ANZP/l/JYnVF4FmnlL5quz8zVXfGfk=;
        b=f6+T1nkoDl3V0PW1Bv9nwsEW80pvpffoqKat/Y0JJvZm4kkvEAAEhoFa3vh/29BnrX
         b0ShyWZcD1lN4BQtulku9jrX4dKR93WmxAnuLLXthid9CK4BX0OdcvPvBiY/MKPhRwLU
         kX/rGL6cu4DVFMvqbcL+NZ7jGq4UVZevVcJ583b5b7yO9hJOAU0SbA68NNINkqBppPMK
         BqPdup8/mNkQ479zrOb826qk0AqRojR/91JdoXsfC77Kdo4r+fS5TvOZSLMSVd21u8OU
         h1wdDQCVjwxb6gnQwqkMF3RmSc3cfpURDa/H/UiAe2dSAR9FO8Pad4qeR2MZZqcVyM9N
         /WKA==
X-Forwarded-Encrypted: i=1; AJvYcCWaUIXC8CRKLiNQwdKYgzkfiQU1St0xLL3H3VUIzLI6GFmjMYTVzd3Cx8lfGLRe7IkSXAcEDC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsNliMmUvq7LS/90pUF2k8XU1aqt0Zyi4jEOCz4qhnQtZE4JT
	g/Ufw6EibDOrVhEU7X1eqaTaA7lKNkmUkCLUDSrU69oC2TnAE+zf600A/sgMHna2ECT/hNrfTOB
	7wGtMMokO1A==
X-Google-Smtp-Source: AGHT+IEYAYVTUR7JHir4go59GCUMVkuDyE/MGShC5BIxF8rGmGTO58ztneuzPIFaew81sHxs8xvTMf3Ivo1oBw==
X-Received: from qtbbb1.prod.google.com ([2002:a05:622a:1b01:b0:476:8edd:2de2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15d4:b0:474:e3e8:1a58 with SMTP id d75a77b69052e-47930f967e0mr142149571cf.16.1744043767790;
 Mon, 07 Apr 2025 09:36:07 -0700 (PDT)
Date: Mon,  7 Apr 2025 16:35:59 +0000
In-Reply-To: <20250407163602.170356-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407163602.170356-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407163602.170356-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: rps: change skb_flow_limit() hash function
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

As explained in commit f3483c8e1da6 ("net: rfs: hash function change"),
masking low order bits of skb_get_hash(skb) has low entropy.

A NIC with 32 RX queues uses the 5 low order bits of rss key
to select a queue. This means all packets landing to a given
queue share the same 5 low order bits.

Switch to hash_32() to reduce hash collisions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c             | 2 +-
 net/core/dev.h             | 2 +-
 net/core/sysctl_net_core.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0608605cfc24..f674236f34be 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5038,7 +5038,7 @@ static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
 	rcu_read_lock();
 	fl = rcu_dereference(sd->flow_limit);
 	if (fl) {
-		new_flow = skb_get_hash(skb) & (fl->num_buckets - 1);
+		new_flow = hash_32(skb_get_hash(skb), fl->log_buckets);
 		old_flow = fl->history[fl->history_head];
 		fl->history[fl->history_head] = new_flow;
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 7ee203395d8e..b1cd44b5f009 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -16,7 +16,7 @@ struct cpumask;
 #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
 struct sd_flow_limit {
 	u64			count;
-	unsigned int		num_buckets;
+	u8			log_buckets;
 	unsigned int		history_head;
 	u16			history[FLOW_LIMIT_HISTORY];
 	u8			buckets[];
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index c7769ee0d9c5..5cfe76ede523 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -248,7 +248,7 @@ static int flow_limit_cpu_sysctl(const struct ctl_table *table, int write,
 					ret = -ENOMEM;
 					goto write_unlock;
 				}
-				cur->num_buckets = netdev_flow_limit_table_len;
+				cur->log_buckets = ilog2(netdev_flow_limit_table_len);
 				rcu_assign_pointer(sd->flow_limit, cur);
 			}
 		}
-- 
2.49.0.504.g3bcea36a83-goog


