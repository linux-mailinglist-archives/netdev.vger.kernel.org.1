Return-Path: <netdev+bounces-190920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C8AB940F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AED4E6B46
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12022A4CD;
	Fri, 16 May 2025 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ol7joY6o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC334CF9
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362595; cv=none; b=JAuTOZaw0Y8yy6fgCoizKwc6tSNh+5WEm/UzvgHF7FQMjQ+7+D1FEWGf/viLT1crZIGrrynRkodycJIZYl7DLyiJNrqiP7/YTU5BSVtjON/vHCAhTKUuFjY1ZS7QnatwPxGsSW3z5w5jKNk71d8tpML08NDuwkjKmoHa5AHQJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362595; c=relaxed/simple;
	bh=EulLZD6cvCzDXpmFMkWHfoTkv8hXkEt0nyU+f/1B+xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSoF2MKKcAtX30DCnbRkJLTUhO+3Q/GcCisuYYF5dw0MHOAcHH5pW8Upet9XfqCrHBie9r93KlAjNkll23zdNjcjzcGpbNPG/xwQ/Cp9P5na+QVz39jpDLcrF4jUtQmOKB1fr0gPRUstBOi9558llY3Z6tZUdbeCbyVCIdtUTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ol7joY6o; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747362594; x=1778898594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egWY3QAZnKOQHHMgQ5/05DWYZdYd/8wAAOyFHlGYh2g=;
  b=Ol7joY6owdyXXBiHq1g60Vno+qfzMnOrO3Q1tAu0uGqwoWIWRIpdHsqT
   f5kxDtdUd2VoOGX2JzEtmJ9ST6Y9Aj2FTl37SEvgn2tE5GvxRLj/+7VhW
   y2d72hmXPxKO3HVcRk2M4JIaKeagyidOLO3/SIXzbrkhMOJlQITw829z/
   BTiPMGGAW/fIhp+ScBrj1BYKVnFFCOPyFmn9PRG07ik54T3RaDVhqEDw3
   N0YRHGDIthcgNWR42E+SocYlEFOORsxidgZiiHjgrmL29CH1IXc5LJF9u
   eG+j4RY6s56Jg1DWDaFa6T4IuvIiWVepfMwSybxzuthVqayB3eO0ZCwjC
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="20284890"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:29:49 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:2508]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.177:2525] with esmtp (Farcaster)
 id 12be8d8e-4159-48df-981a-bead93dc4220; Fri, 16 May 2025 02:29:48 +0000 (UTC)
X-Farcaster-Flow-ID: 12be8d8e-4159-48df-981a-bead93dc4220
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:29:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:29:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/7] Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
Date: Thu, 15 May 2025 19:27:20 -0700
Message-ID: <20250516022759.44392-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516022759.44392-1-kuniyu@amazon.com>
References: <20250516022759.44392-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
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


