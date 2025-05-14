Return-Path: <netdev+bounces-190535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44CFAB76F8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8981BA6FC9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98A295DA6;
	Wed, 14 May 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qrX62YPe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6D295506
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254095; cv=none; b=YHa3uUUhDcopNuJ5JzYGPUUVe9D/LbR4IXZhto0b9pra4qB38p94DJpsOhnGEoqNXYB/8h8o3e8PzMz3Ev7bdnJMsjCoNIYdGYz4AM5GPSSTExvun6vTrbEgpgRgfdh/ajM+CbNd0DqJwzrLtHwhhFlL351hQnYO1hmG7ep/dd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254095; c=relaxed/simple;
	bh=EulLZD6cvCzDXpmFMkWHfoTkv8hXkEt0nyU+f/1B+xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJxtlRo9vkZVE2tRUKI9xdtsninbjOpwqcAtwrmNdyJzVeKfV9VOoTzZ9qrvRKYOH+jr39Oufshs5zg13l+PpKD88yznvCGAwuH/zbDOraSKO/SBmX0BsdRPEWGLWOl7P5IaIKGKx36mXsfzWEzdKpUiQHSk7+r9NNtbEaQZD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qrX62YPe; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254094; x=1778790094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egWY3QAZnKOQHHMgQ5/05DWYZdYd/8wAAOyFHlGYh2g=;
  b=qrX62YPe9UqabbS5ctj3Qise5iib1PBIaF7GRj8BpAkCuHl7ePQie7Zx
   zksRPrqHM+U749ka7J2SdGH8QxbQMFT2ph6NlBt9fxK818XeN+nmcJA9L
   nvOoUFSNegr5J4ZnMRiBMGR3L8VU3XwloxqUwHLtpI5YVsemuwFmo7U2f
   BmpEV8RIl5DcH9lP4lvaBMjveESIXfyxfreWg3kFlyXJOC2o6kwXWqcU1
   Cx3rdXhVGifwvUa4VuRahkqB/5OSh2X6qF0Gv9hqoFspuQma/mvh+sR6v
   8dYzFmXzcT0HI+P3PXnDYeK8w3nsqKwkkpilzpeVCvEUSWcDIK/tIaBP/
   g==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="405316220"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:21:33 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:60707]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.52:2525] with esmtp (Farcaster)
 id 92508567-64b1-4290-a5df-440d72bcc7cb; Wed, 14 May 2025 20:21:32 +0000 (UTC)
X-Farcaster-Flow-ID: 92508567-64b1-4290-a5df-440d72bcc7cb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:21:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:21:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/7] Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
Date: Wed, 14 May 2025 13:18:57 -0700
Message-ID: <20250514201943.74456-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The previous patch fixed the same issue mentioned in
commit 14a0087e7236 ("ipv6: sr: switch to GFP_ATOMIC
flag to allocate memory during seg6local LWT setup").

Let's revert it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/seg6_local.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index ee5e448cc7a8..ac1dbd492c22 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1671,7 +1671,7 @@ static int parse_nla_srh(struct nlattr **attrs, struct seg6_local_lwt *slwt,
 	if (!seg6_validate_srh(srh, len, false))
 		return -EINVAL;
 
-	slwt->srh = kmemdup(srh, len, GFP_ATOMIC);
+	slwt->srh = kmemdup(srh, len, GFP_KERNEL);
 	if (!slwt->srh)
 		return -ENOMEM;
 
@@ -1911,7 +1911,7 @@ static int parse_nla_bpf(struct nlattr **attrs, struct seg6_local_lwt *slwt,
 	if (!tb[SEG6_LOCAL_BPF_PROG] || !tb[SEG6_LOCAL_BPF_PROG_NAME])
 		return -EINVAL;
 
-	slwt->bpf.name = nla_memdup(tb[SEG6_LOCAL_BPF_PROG_NAME], GFP_ATOMIC);
+	slwt->bpf.name = nla_memdup(tb[SEG6_LOCAL_BPF_PROG_NAME], GFP_KERNEL);
 	if (!slwt->bpf.name)
 		return -ENOMEM;
 
@@ -1994,7 +1994,7 @@ static int parse_nla_counters(struct nlattr **attrs,
 		return -EINVAL;
 
 	/* counters are always zero initialized */
-	pcounters = seg6_local_alloc_pcpu_counters(GFP_ATOMIC);
+	pcounters = seg6_local_alloc_pcpu_counters(GFP_KERNEL);
 	if (!pcounters)
 		return -ENOMEM;
 
-- 
2.49.0


