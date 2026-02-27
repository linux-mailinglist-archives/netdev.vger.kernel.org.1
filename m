Return-Path: <netdev+bounces-261708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJvlGRQSoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FBE1B2520
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD265306DD91
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A851D332904;
	Fri, 27 Feb 2026 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5+srage"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724273328E7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163568; cv=none; b=Ay0G2MKY159qR5fuSbNjgORbkRWeBz80i6Mq7z9jUzM/A2qjZc6f/Vj6FAIamlHMOGxDGxTloCoEGAnta5LkMnHokXXtynZBPYdlfjmlIHQVa0qBRgtv3dxncHf8JEs2gK89BHdyAXzy4PJveSw2jLNp9npD8N5QrkbmUNhhKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163568; c=relaxed/simple;
	bh=1kyvYDYo1abV3tMN2MGNSZq424YM/STVyxuShGKeSFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCRZd33rhKHuG8MTDdEm8A5xEC+sH+7JLISnaEckK3R83UtEm5wJ6PxdxC900h5AP7+Jww9wvGy8Ba3MdOb1I0/DH9888KMGVoWu7cRrGg4awWufRERLwNRUWTHPmObDElDr4iLzinpBdqGwJ445I/m47VDMFSPFDZuSO5dUGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5+srage; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3594bf70b25so894972a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163567; x=1772768367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ9XuHBvek4dGZTXd40rms1d3T8K06CvZy/YHc+GWLE=;
        b=n5+sragejSKszBc/5VzCOvBKqaePC6RtEMYpsDKAOior1ayedyfjxezMVqOfdT7pCq
         NnV151bGM8V0D8Qg6nOKs/LVpTvZhyff5mF2CJ+11SUUcoMI9QXY1+VKC4JaNVGthilS
         mad9cbNb88no/dTsuYbS5htXGqVfyCRkOkdvYeRThgFb1uKzFefmC6Jth9r2fNgIFLI4
         SyCAtkHU2wAYQrYHa5LCM4GyIDTAVSFTKfVRNtK1jqShzVCLSG/A/elV2fSGaEASZviK
         m6VISCV3I2J/PPVnnCVquL8pjTCDnp041YnJRqJkXaXulB7XedFWMjHQxpO/ZB/3PAk1
         SO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163567; x=1772768367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ9XuHBvek4dGZTXd40rms1d3T8K06CvZy/YHc+GWLE=;
        b=SmUI+L91M1RC89TYjWILkZKJDrHsi0GmgS4hBsMLt99I52sGygM2qKBSNLMZrS4yVM
         SiCnFWmeftXhfZZcINtfzmjD5rbSqhGQ9TLQaE+nIklUKeo66XIEZDiKMacwio1LLAYl
         yQB+3FX2t5Bjw05Xfb/z97FQAIlmLiYNAlAgSxlEF6ukc8groiHzeENQlWitWs1H1lZa
         o/NTPxZ2pf7/f++qPM0/l34vWmk2OQC3JMa8ZoY3Xh/GMjEoEpq/7GwQHKYUOK+/wd18
         WIo49PO76NqldvHhACBe6EWIs9KAE+nMVgdjkQ0iG1rRIiXsf1AuwbireP7v9rlY6AKr
         D7rw==
X-Forwarded-Encrypted: i=1; AJvYcCV/vzl/52KAE+G+0+3yOU1ByBOChTN/sOWULLwEOKYU0p81xIrWpIFazmReKt9h/WA8Dd2cJEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7EG/fIXnkQIysCE82fNmGAf1KZocpngZ2gTnQv7BOikhFhu7S
	4BK2s2qkLwmxanS/7Sk0etV7C6JstFnYMCj8zEpAMPB0GNQi8o9m79BUmP04HYbNLqfdPVZIQql
	z/+ZkIA==
X-Received: from pjvb14.prod.google.com ([2002:a17:90a:d88e:b0:354:3742:4ba7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2cb:b0:32e:64ca:e84e
 with SMTP id 98e67ed59e1d1-35965c49948mr1465426a91.15.1772163566710; Thu, 26
 Feb 2026 19:39:26 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:35 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/15] ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq}
 under CONFIG_IP_MROUTE.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-261708-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D3FBE1B2520
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
2.53.0.473.g4a7958ca14-goog


