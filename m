Return-Path: <netdev+bounces-261136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LeJLK6yn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:40:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151031A02B6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D1030EC86F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712523783CC;
	Thu, 26 Feb 2026 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MThxuy/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE2937AA93
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073421; cv=none; b=m2/Add0uhcJPGN4phvpgekeF9yDl24VKLda7dDFqJUWrlVVMTTy98Z/uihe4mY1E/do4QH0+30MzK3tA/psfGPELvBfgFjqWoBQJlHoqFLHuwzVpWdNw9efe7cWmfgekkqNqj0jdr/ptSSL0PaWLaLjfZsWCUzP8igQ61XU1m68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073421; c=relaxed/simple;
	bh=KMRsC5FmBP8JbiQ7YPqzlD3EnI3kpspdxrEou+aWzQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kKqwUuDWlZV8GkJjwGRev/9mZxt0PAiMJzh1kstNI+9mYfy9d33O+oI46TfpQI+yITfOGmxx77ylqhealBegflAsyhVQgDvn8fPi2lujXgsdjsiGmGe+Nn3vPBEA9y2S9pPZwL8qpYjx8xzud5/7E0iZDhzzQgQvFB8Mq587hSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MThxuy/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bee18a62so182677a91.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073420; x=1772678220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPQhWXFBGdLeCNckAs7jqCbb+K/TbgamsvItz4odb6E=;
        b=0MThxuy/PgJduHhC8Sbp/MlREAs2sG6K4RplZxWhE3XyfdMfEK0lqHyaXTmysj4gDd
         HE5WUJePo0btzjrFAO3LG3Y9Cw0LIv3rZ27zdZ5DiQlN7/p2/S6oxsvCJ367AjkSfpEE
         bYJmcwfWRzqBN9JfFBCIUSCi70ewgCAmnoLQpFvKxalUfGBYmru8twtMwlsjRSpQ4bND
         UgVJL6STBOK4IVjPeqUwH5R7EDFCCSeZHXBsNNjbnrli4DJqjAQWAcCtzVGJk7mGDjEb
         VRdFu38J0KO+acajpfvLEWUUtBa9B5N1mnQYtkhz3NZ4XcsuJAtqVsfEmJGAz1d3d6fu
         uipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073420; x=1772678220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPQhWXFBGdLeCNckAs7jqCbb+K/TbgamsvItz4odb6E=;
        b=F14O1qqvPYytZD2b8QMAJuM2E0mtj35py+zbpKUxHtdHg/Cv13IjyQEpsk9z+lBM3Q
         XXyZ7jevqgK/a1nHn523/Fq51nq6Fl39B8O45IiU1oBfcJAFSd4K1SCunCrZ30/R5su4
         Xp7jqJnJ9KqTLhqHRj5V9ywS814knTs/DgFYd8PGT08nLNNFG6U0mdtjzh2p0mdm7L7m
         L5RBdfG74qvuZjnx732hrJCIcj2P6etYXZHdr66sMORhUncnbO0xxyyZ45f9FutU4Mov
         DgyDcFcQg/XITeEe3vWgMoDUAJsdGXqehJSRDOXoffcuz8UnaNp6bV4+8o46VUZZHSMs
         NK7A==
X-Forwarded-Encrypted: i=1; AJvYcCW/IiBNITmqh/Cbo6vL1Y16H/Cxpe+XkojzTGmHJFU8alTu8EY2MR8IgvplUPPs2amNbmr4+7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSfgag7sYH7WqOVTu1E7uCzOkzjNZW3vvMZTZutmUfc2rvt27
	KyAq5FFQpYzqlHY7qFLZczLFVv+oc9yyblKc8CpgPILuVrHVwrRaWYrAlLBo9SNPTadO3xlLUV6
	Fzlf14Q==
X-Received: from pjni24.prod.google.com ([2002:a17:90a:8398:b0:358:ff0e:1ff2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1847:b0:356:21ff:623f
 with SMTP id 98e67ed59e1d1-358ae8a5078mr12538901a91.22.1772073419593; Wed, 25
 Feb 2026 18:36:59 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:24 +0000
In-Reply-To: <20260226023637.1335854-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226023637.1335854-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/15] ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq}
 under CONFIG_IP_MROUTE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261136-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 151031A02B6
X-Rspamd-Action: no action

net->ipv4.ipmr_notifier_ops and net->ipv4.ipmr_seq are used
only in net/ipv4/ipmr.c.

Let's move these definitions under CONFIG_IP_MROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/ipv4.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 8e971c7bf164..380ff34c0233 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -279,6 +279,8 @@ struct netns_ipv4 {
 	struct list_head	mr_tables;
 	struct fib_rules_ops	*mr_rules_ops;
 #endif
+	struct fib_notifier_ops	*ipmr_notifier_ops;
+	unsigned int		ipmr_seq;	/* protected by rtnl_mutex */
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	struct sysctl_fib_multipath_hash_seed sysctl_fib_multipath_hash_seed;
@@ -290,9 +292,6 @@ struct netns_ipv4 {
 	struct fib_notifier_ops	*notifier_ops;
 	unsigned int	fib_seq;	/* writes protected by rtnl_mutex */
 
-	struct fib_notifier_ops	*ipmr_notifier_ops;
-	unsigned int	ipmr_seq;	/* protected by rtnl_mutex */
-
 	atomic_t	rt_genid;
 	siphash_key_t	ip_id_key;
 	struct hlist_head	*inet_addr_lst;
-- 
2.53.0.414.gf7e9f6c205-goog


