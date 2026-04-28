Return-Path: <netdev+bounces-281703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPd5N1Fo8GkITAEAu9opvQ
	(envelope-from <netdev+bounces-281703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:57:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B747F680
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FD9130089BD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E28C313520;
	Tue, 28 Apr 2026 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqtVNFWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D81F4181
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363017; cv=none; b=Z4fWrOx37yjUgKevxkid6p6hIwKIb3gvMTRIYxBhh9ANMfSwew2nVj1p/toiGL+P9LebTC4gd6dQgfJuUT1BEnkdLkE0z0PffzuGB6LmlRjorpuQ4nUgkq7HggqYrWMF4KEyYici9ub84Iv+Jp3ctfG9w67WkCBdXf6y5CEuOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363017; c=relaxed/simple;
	bh=D02i9B/3K0svXTWT3+HTVy7iiU7dDftgrHhsn6yyDIQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eq3cmw2KlpZCS2PYb7XdQ7DEkkHYDthjBXYX2daqrmevY8uZR+0DRvuDr8C4S3A3pZbA0O8amJeB7fxPE9NPnuVNx5FeiEsDyRTWdaWLy1IAcHEJEjojS+07MQkh9WJ9GNd/W/ARGfRtkjzfFvuZofOyTP/uUS6SI1pv4sUlCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WqtVNFWp; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-953e9d7ba08so4931738241.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777363011; x=1777967811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YxJE6nEhuOle2E7GTG6uCrQ/Tnnsutz6TiuiHWgFoFg=;
        b=WqtVNFWpVK/BcjmoIDU1glSPts14JjB/YfrawLs2775vLhr1aAanCosIgIxydtuZtW
         4zoOpwtULEnPfftDLnTstFy0pcJ6PSWm1enERpF+cDZkaGwHKno0csfdjt55DlDyPTYC
         ikRsul57PkuH2hBmOJa8UHJL90PWuwciO125Nu+8Xilhinb/DRcUsG4qoHVzaBw6fPGj
         /BeWmP86dsV08OsEK7BIud/8FLyyylILcO1g5siF4h/blymg/Ci1FcO/BZVHwKefCyc1
         nZs9YMRB0Lt3AzynFi2s6ySGg+nu2r4me3zBMGzkgTeWqm/viGlyqF9eJ+XYckwu8uXw
         HtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777363011; x=1777967811;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxJE6nEhuOle2E7GTG6uCrQ/Tnnsutz6TiuiHWgFoFg=;
        b=ERuhWJc1D4nqqEAHhELlLqoFCMk4HQlcSM2ikkh+g7fZckQrc7uYrlIHCpoHzwlwsM
         ZdUxSLk9TZj1e7nX617CfBW7/QhcdCyj537R5Y8dTPpRqHzze7JCI7vsg0bPdwPEwwYc
         Rj2eygk+yDuMckiP9rCytIfP938E78Y4eeBg3jqDnRJDnDZT1TK0bIiAhU3KBDfDvl58
         RS/jf14jKQMaJJBLkHaP9aE0lLEQgnW/TAmEvoPfb1zpASiSwlGlI3SDpMkEG/u06o/W
         NTQz0fzmVQUdXHsR6MdOxOQuqqH+17Cj19yd+yARGkYUo9GM83LKNv0rdVAKuzgylvo5
         Petw==
X-Forwarded-Encrypted: i=1; AFNElJ+OOBS04al1UqJSck4bSyOWl+t3MKX4vpRCMqA6LdQlykBGynRKmc7Qu4Fhet7UZMBf8xa1Oio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUnwvdqfBsyR/NfgxfC1p9P3c5I0jcVa+Ws9NzYugmcUiHdnsj
	2MN5wvjvqKD1Iovsl6xDYt4WZCbyhaZ4fOGJF6A66W5I69NdSMbkDcNqHQ0p2lvBTwzj2EHNPj+
	libryvYbTsaK28g==
X-Received: from uabiq10.prod.google.com ([2002:a05:6130:628a:b0:954:990d:c8d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a67:e709:0:b0:607:97ef:4dae with SMTP id ada2fe7eead31-6280a3a7ea9mr602717137.16.1777363011269;
 Tue, 28 Apr 2026 00:56:51 -0700 (PDT)
Date: Tue, 28 Apr 2026 07:56:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428075647.3206962-1-edumazet@google.com>
Subject: [PATCH iproute2-next] ll_map: add RTEXT_FILTER_SKIP_STATS to ll_init_map()
From: Eric Dumazet <edumazet@google.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 876B747F680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281703-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

ll_init_map() only cares about names and ifindex.

We can save ~300 bytes per device if we ask the kernel to skip stats,
not counting many cpu cycles if per-cpu stats are involved.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 lib/ll_map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/ll_map.c b/lib/ll_map.c
index 8970c20f3cddedcdd1a6f522858fa350d2df8e5b..07937e27d4f6fb5506a3da6e9318270635224364 100644
--- a/lib/ll_map.c
+++ b/lib/ll_map.c
@@ -391,7 +391,9 @@ void ll_init_map(struct rtnl_handle *rth)
 	if (initialized)
 		return;
 
-	if (rtnl_linkdump_req(rth, AF_UNSPEC) < 0) {
+	if (rtnl_linkdump_req_filter(rth, AF_UNSPEC,
+				     RTEXT_FILTER_VF |
+				     RTEXT_FILTER_SKIP_STATS) < 0) {
 		perror("Cannot send dump request");
 		exit(1);
 	}
-- 
2.54.0.545.g6539524ca2-goog


