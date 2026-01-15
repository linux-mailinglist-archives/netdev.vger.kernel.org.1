Return-Path: <netdev+bounces-250073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF5D23AB7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E047E302AFE8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55835BDD7;
	Thu, 15 Jan 2026 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zobG3wEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9F35B136
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470109; cv=none; b=e8GhQRM8sgH7gFZsCrUaEqs19ARidUcPOe+aoJfkHvK0hTJzzMmd6L7G0ElHrKhrAGPOpMYIJgBO9Fhpt73YAJz2Gz8/xIivzKS/vOZxgJUXT0/2xIyU09+gbRna5yk95aoAqM7pr6msRKks+yFeegebuutPJbfNORwvZgRMpfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470109; c=relaxed/simple;
	bh=6W48DX3XOQKQNOPVCDSmVyyOO5LHjYSOjlZw4elr6XY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uWBbbQ0matPM7VNBnqtQuxuCyKPvO3Ht+9Gdc3HCPF/je7YgAycEtjPek4raOHvXHfOupCd42+ffXrBBKjsN91LPqnVFLP3tPMpQhuJcZmrsOVBf8OTeEZj2FOMN7HCaJE/whnpMgaPab1ppH9uPRvzmGFBI/1+8FsCAfohpo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zobG3wEW; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-63e32e1737aso1037116d50.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470107; x=1769074907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=deCf4dX9C8xwn9iSMZi2UX52hjHsowlJWMzwyrW0zpM=;
        b=zobG3wEWYG8E7OGwW7QCha+PcqjCsYzwNaKt4fivkU9FzNKaSRUgvr2DsTgXy6P+SY
         qG//lb8EW7+lmlGM6QrEtvy3PrRBm7stze5pQQHolRkCy3nMvVkw5OxhRo+saU5RMRI2
         xxoN7buBgFwHi9ePaJ/uZjRDarR7elEOLwBhLcspZvv/fURX7uWfL34LXpOvxkpqPDzI
         j7quLJMvRNV6A5TRXXTj4a6FgTywigFGkyb1yauurRT3fO4J+nRqcsF0Soqv8iVXd2ak
         C7a8uEhSPVUZw4yOKl+V+bhAHq4RSsNroAEsUfdsMX5G44Dx+GTOOz2UsQvDiga+3BBb
         cvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470107; x=1769074907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deCf4dX9C8xwn9iSMZi2UX52hjHsowlJWMzwyrW0zpM=;
        b=BqQY+aKRJdU3oyFb0kegJWqJoX/kyv5QOsqrveAZTWhwDhNQEeuaky5WxI6wTGPJTx
         pF05wVia1d0aEpGNB+jhRX5mP8v19ikSC0s7eSSsRVQDTTElIcjmlz2i1/sMMhG/fg0/
         4QyU1HTzsBITw3AebVHVUEbyOInChwEwBsgXuX9r6mqkYA660DmUYiGlM5qk28WpUHNx
         Qb4VhbuofuOBzJDpwXdR25auISszQmargrQtrSH3/q36Bm/UeHMWJ9oKUK7JUnWz6Q0q
         P5rEuoAiKDyAo9juVCAlcUJtMBhcTZn2MfXH1Vwljo+iACdQNoK3qQCwHtEymMczQatB
         TX7g==
X-Forwarded-Encrypted: i=1; AJvYcCWnlP9kWEgPWN2e8rVA0zCkP6sJo3Y5wJ8neso4ylGM9svjtKXXydrI9GNljAbE1uRoVdaf2nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjmYqpEUFJd4hqZD+GANb6xhHV+YPlYO8l5uArvmPrTlp1qFY
	/MHQ01jjDEbAq2k+Alasy8K96lFx3L7klIvPD8lSGCjK82pYXsyutMkoBFZ4e8BcJLP+sRxMKLM
	vz4eCZwoxuC9z8w==
X-Received: from yxbu2.prod.google.com ([2002:a53:e1e2:0:b0:644:75c5:bab6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:134f:b0:646:6a95:9626 with SMTP id 956f58d0204a3-64903b45e81mr3579658d50.60.1768470106673;
 Thu, 15 Jan 2026 01:41:46 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:34 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] ipv6: add sysctl_ipv6_flowlabel group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Group together following struct netns_sysctl_ipv6 fields:

- flowlabel_consistency
- auto_flowlabels
- flowlabel_state_ranges

After this patch, ip6_make_flowlabel() uses a single cache line to fetch
auto_flowlabels and flowlabel_state_ranges (instead of two before the patch).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netns/ipv6.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 08d2ecc96e2b43901af6d91ae06d555b5ae9298d..34bdb1308e8ff85f04130ed25f40a4f8a24db083 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -30,19 +30,23 @@ struct netns_sysctl_ipv6 {
 	int ip6_rt_min_advmss;
 	u32 multipath_hash_fields;
 	u8 multipath_hash_policy;
-	u8 bindv6only;
+
+	__cacheline_group_begin(sysctl_ipv6_flowlabel);
 	u8 flowlabel_consistency;
 	u8 auto_flowlabels;
-	int icmpv6_time;
+	u8 flowlabel_state_ranges;
+	__cacheline_group_end(sysctl_ipv6_flowlabel);
+
 	u8 icmpv6_echo_ignore_all;
 	u8 icmpv6_echo_ignore_multicast;
 	u8 icmpv6_echo_ignore_anycast;
+	int icmpv6_time;
 	DECLARE_BITMAP(icmpv6_ratemask, ICMPV6_MSG_MAX + 1);
 	unsigned long *icmpv6_ratemask_ptr;
 	u8 anycast_src_echo_reply;
+	u8 bindv6only;
 	u8 ip_nonlocal_bind;
 	u8 fwmark_reflect;
-	u8 flowlabel_state_ranges;
 	int idgen_retries;
 	int idgen_delay;
 	int flowlabel_reflect;
-- 
2.52.0.457.g6b5491de43-goog


