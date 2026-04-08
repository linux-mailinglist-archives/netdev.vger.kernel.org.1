Return-Path: <netdev+bounces-276693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNjQBaus1mmZHAgAu9opvQ
	(envelope-from <netdev+bounces-276693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:29:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F53C3139
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F7CF30530C2
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425A3D6CB9;
	Wed,  8 Apr 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LMZm0HzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E83290C7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775675483; cv=none; b=K6fQI/GNmSDc6i/OFlnKvDs5G+YQHwJ5E15bLfkDwdOn8lR91Up/ZjEIjeDY/YPGJlSvgQ2nqMao2Xya3AQZXGs+Q9jwqhTfm2OkKHMXIxHCB1+8WBI2l+K+CWGaHhZ8ll6TJvKpXyUYj2rAUqeE594iyW3TolUYp+lWGbyZ2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775675483; c=relaxed/simple;
	bh=QywkMKt9HfbdvydAmCDLA/mewW0A3C9JQlo+MYVYw00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLxEFyLMWe2bkJiXQGC1QbCKbD3GzHUqBpp4WRaTEDUF8VDuAS3gxOI1t4SsiIawnr69yKyu/sD/HscG9zS9YNAJiPQfnsDoQ9+cFWvAYBI/ullKg3TU26stS/dS6aj4kKnHpv7LNHx+sZvYE0vaaPSqRtLtZ/SbtLy6FuDF6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LMZm0HzU; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbce74e537so85107a34.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1775675481; x=1776280281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWlPCpaM6YJiK7lQXjNJIiFwkV0uyI0s2T5X9GR48qE=;
        b=LMZm0HzU/Z9SjWgXYja7mHAMOwVclB5jDfApGeJ+EmAA1/4et5n3Gdsnepy3LhVAa4
         8NIMgRmIcfmQJ65eVT0VdqawlOKRxNKsZ9Mi5jbsX1C+BnL4DCkpnB7RJY0oOd6H8UCi
         mtY4aivM6iNdMeLZ+IEAzxeaAvx/SArWJWXyMRttgb9U5n1buDepbwmZWzRlg1FXQkPZ
         K86JN+JCLdn5L3hC/ZP3ukMl+UXSweRxMrmSh9QAmKKfd0KBnRDfg86zRfWBGfYI+mRJ
         f6XzoQzxZluXmrPBK6pltuLe35BuWoZ47ndnLxUzu1nXyM2YmYgMNnmBbAgOJONy6FOs
         8O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775675481; x=1776280281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWlPCpaM6YJiK7lQXjNJIiFwkV0uyI0s2T5X9GR48qE=;
        b=Y43vpPb4ZgR8ZdzyI5wTn0mwjjHNRARkeCyDqNtJFY8Ev50MbbzzvaQjxBcPguY2/r
         HhTByC/lNGkIUoAkf0d2IcPd8ESFg/MbTucGToZW/0xW3+SyHj+ztFMoXs8NN8/xiuId
         KygA4XYKOsCBxUxjVJrAEtkpxJtXd5pAv78yGnv1NwXdLJh8x7B3eVGTQ3ornUnVWU6F
         Yeb5ysFVDed2ygIVeFPhdlxJdnhkTiGgQgkGzvz0pypIki1pjmk+MbxLWO67/5Exd4d5
         8s/5ssqyw8kxhdNTxuEei77Glfmc1fCOUeXmrXRwmAigFxh3G8A/5FwuMmJvU5ZjaAGv
         VBvg==
X-Forwarded-Encrypted: i=1; AJvYcCVG1pUkfVs7hxL7RrtRHIChciyBaUpPmbiYvdasuFlK9r5ennjfvNX+gklAV8l2S05uflod0sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VOCWV4713gP6wfIKrLgLd6Obet5HnTakk/h7DO7KLbNL1Efe
	gLncb7hW9gY7nXmaRdXuMuDk/Jl6MwXtS5jzZvor1qQhliGzKMTbfN373y31BtCtpu0=
X-Gm-Gg: AeBDies1d+V4MLcsO6wy1popqCJ1qSrflt0EN+wHJIlkCNbCfcCqWNstt7BILnFTxMI
	8tcb41qG+UWWV3LAMH+BnwEBJggk98peZXbE2YfJ33LUEErFNzNwVuCBJl8hljoToNTQCK0uq4M
	xBL3s40qVeh3WELVuAQtRF1jOqUSe7ISDwna784JiMZQfoqa+Ut71L9Z+cCQjth8PVw7DzEzhr6
	GEm8UBfL9vzWHrYfue6EzF44r1Wa2CIATuQel2eYqiRnbZNPcj6l9cPijpIM7GPRD0FXyC3lcik
	vMSEXFgkU9J8vxSipukgsFztneKawDbzDF9XKK72D/IL5UeSkpI0NwpFCsY6haw1h6Y/tZX9cFC
	nk1jqF6Iipac3Jq3tij6BhgNVL5gqiiAtuSxcbuPSF4hcvc/VzhPlt2T6n0CPsS3IvdmHaxgqFr
	uQYHb4d6jdmA==
X-Received: by 2002:a05:6830:2aa5:b0:7d7:cc2f:babb with SMTP id 46e09a7af769-7dbb72f9c3fmr16664921a34.2.1775675481129;
        Wed, 08 Apr 2026 12:11:21 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac6:bf21:2e28::499:49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc098578c3sm1979035a34.25.2026.04.08.12.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 12:11:20 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: Add net_cookie to Dead loop messages
Date: Wed,  8 Apr 2026 14:10:47 -0500
Message-ID: <20260408191056.1036330-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276693-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: 780F53C3139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Network devices can have the same name within different network namespaces.
To help distinguish these devices, add the net_cookie value which can be
used to identify the netns.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v2: rebased on net-next
---
 net/core/dev.c            | 5 +++--
 net/ipv4/ip_tunnel_core.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5a31f9d2128c..3c752ba3aa29 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4886,8 +4886,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	} else {
 		/* Recursion is detected! It is possible unfortunately. */
 recursion_alert:
-		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
+		net_crit_ratelimited("Dead loop on virtual device %s (net %llu), fix it urgently!\n",
+				     dev->name, dev_net(dev)->net_cookie);
+
 		rc = -ENETDOWN;
 	}
 
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index f430d6f0463e..2667f53482bd 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -60,8 +60,8 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 
 	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
 		if (dev) {
-			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-					     dev->name);
+			net_crit_ratelimited("Dead loop on virtual device %s (net %llu), fix it urgently!\n",
+					     dev->name, dev_net(dev)->net_cookie);
 			DEV_STATS_INC(dev, tx_errors);
 		}
 		ip_rt_put(rt);
-- 
2.43.0


