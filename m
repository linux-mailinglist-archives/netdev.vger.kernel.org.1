Return-Path: <netdev+bounces-290435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLxmL8oRD2pzEwYAu9opvQ
	(envelope-from <netdev+bounces-290435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:08:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D65A6D8E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A994D3305549
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BFA3E00B6;
	Thu, 21 May 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwnkry5N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD438332E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369569; cv=none; b=JG2r/lmGvZbLwzmDNNlGw5Ag17ZBL0RXMI+tJJni1S2O6eAOADNu97moLZxl1ZhVFq5W3+lFzGNNu/QnOImdBVuUVLT5BW14ER/LdAtxBAy/YSsrjywKVfzlXPtv2puECGvbqvOyS6XbYEslc43gQkknl/tH0rCBrEbthHYF7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369569; c=relaxed/simple;
	bh=zOGULb7ajL+R3yoLcxIEMi+8032+JRRGHilgDHwOCLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FIMXZ6fdbLpW5MO0TodWHKKbFQDvRG8LpgcNOV0a6OtTxyRD+ZoMkMRIUHF0ifP6oHtQBU4So8eSxQmbR04C6FEVsPLbZyHjoyzfx3S7cL+bvQGQ/uGQdcgXfxo8ytMZXSjdHA/o+mdut2u7dZreVQh0SYB4F7lxPQKsYkD6GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwnkry5N; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51605cf3c60so73971121cf.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369567; x=1779974367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qXFYHo9PbtkkqJbmyHKb7fXZBpJcL6acph5TZjKHys=;
        b=cwnkry5NuAq4/E4bpo/+lmJfTE/4BgckHu3YBF7nKlQVUDe/I4vWv0Upp5CzlUqZsZ
         g9UHE73s9oSsG5cwMsKEO6IYOEBLFyhGNVygOVSX9DgzO5BdMKDr0gS5qa8HzzF7o+Rt
         +E6jcWrUh8dqMRqNtwD1Kyuh8HogcZUaRInC9as+g9N/eRTGD0uEt9IYlUz6iYwOBC0Z
         4MzdVqjxAQBlFyYMXYrHPF5HIv/QYSCXxooPP7V9ekWM9kC8mgvREbqxtjCUviFLDvVK
         o7y3jZgToOZR7pgG9+0j5PcgO3u1JbszG+eFEADuChUHEzKubjbxGUOuL0CSlASzu47p
         Bcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369567; x=1779974367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qXFYHo9PbtkkqJbmyHKb7fXZBpJcL6acph5TZjKHys=;
        b=aGWD5nSyzn12OgPx5+JQwjW9UZ/HX12TAmDH47pLSxK9mJir3dB0w8S7+tMqPtQ/A4
         xTVZB2rpZ9GOkzL+3A9/AAlBAnGc3/NCDRaOlpH144bhkVa5UDXkPvs5FuDetu3SUhJJ
         RYii6IEd7Xrrf1KcaJA0dimgnzGygb1u2CHpcFhiKEtGBoVi24bj74zLgq9vmA2XZGHA
         y6HqubQ/RiRU1S1q4i3UvFfctdXzVhUZSstxmC1W9KoFUVA50dzZrWw1X2DNSY2XXgoC
         NZ5aeWOE6bNg0DrMe7yESCtELZEyIeJxhAiXxniz5zL5SBFpfP4SQdLdcKEnAsOlm7Uo
         2MdA==
X-Forwarded-Encrypted: i=1; AFNElJ9qM2Klzu59vrkN0eprgHYqvzXzPtwlA+oNmq+sQU61ujyyzI0stVeAeEf6a7bqPjdKugb6WIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLR71xefD44/GaVa3Hk9OlXLNS337J4yllNE7BWc29qU7Ypo3n
	ZcZdOBV0HcKJLy3pMo5nIy++QY+Dk6AsC78pchM9IVGSZQOmrD1O15RbK0YSM6mLQMrKGvR+mCz
	deeR7t7Nj7UAdPg==
X-Received: from qtto1.prod.google.com ([2002:ac8:6d01:0:b0:516:cbf0:55fd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:588c:b0:509:2527:d789 with SMTP id d75a77b69052e-516c53d6cfdmr38740241cf.6.1779369566863;
 Thu, 21 May 2026 06:19:26 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:09 +0000
In-Reply-To: <20260521131916.3627204-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521131916.3627204-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-5-edumazet@google.com>
Subject: [PATCH net-next 04/11] bridge: use BR_ADMIN_COST_BIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 372D65A6D8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use set_bit() and test_bit() lockless functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_if.c     | 2 +-
 net/bridge/br_stp_if.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 3169fab686a534cf2a6458ff228eee2b6fc7e7e4..0bd5cf925fa321b785e3578d6e99d8d7003fa89f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -75,7 +75,7 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 	struct net_device *dev = p->dev;
 	struct net_bridge *br = p->br;
 
-	if (!(p->flags & BR_ADMIN_COST) &&
+	if (!test_bit(BR_ADMIN_COST_BIT, &p->flags) &&
 	    netif_running(dev) && netif_oper_up(dev))
 		p->path_cost = port_cost(dev);
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 28c1d3f7e22f6e0a0edd8b3b3f501ea7acc31394..b29dc97b9ad8a5b5c56517d34fe426abd00e2ad6 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -340,7 +340,7 @@ int br_stp_set_path_cost(struct net_bridge_port *p, unsigned long path_cost)
 	    path_cost > BR_MAX_PATH_COST)
 		return -ERANGE;
 
-	p->flags |= BR_ADMIN_COST;
+	set_bit(BR_ADMIN_COST_BIT, &p->flags);
 	p->path_cost = path_cost;
 	br_configuration_update(p->br);
 	br_port_state_selection(p->br);
-- 
2.54.0.669.g59709faab0-goog


