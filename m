Return-Path: <netdev+bounces-136783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC34F9A31FC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3341F2271D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132303D0C5;
	Fri, 18 Oct 2024 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fZr3/X5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD328399
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214580; cv=none; b=lPdzq47+kf5Dnf1r5198OgNIAAwWvSBcmdl3BuUu+76/xvIk2Fe+mv9WH5QA+2jfnfAe8b066ALB60/B+rkFeZm1fgWRRj8crRu5ghyaFmKYfrDb3kQdPryHjBQ49Mrafri0oCMhn8pF3ZQwE8sZyy/5cIl1A4zNeuqy3STsLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214580; c=relaxed/simple;
	bh=tqa5tY8exuXgp1BaxnL1wepA2L0nmLIbBVD+iY2O6HI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEcrsnCXEPJAUnJ++0zDO19jQ2ajuwEJJDr7NqmtsdNFX3vr9qRZ8zT/vIyk6GhwWYNOKFkKb23wN+NuMLvDHMF4LbrCBSgr6oKI6djCcR5RYwbE+kkJ79djlQnVs8eZRmiG3yBIAvFFBAztXIUlLZlHcLcUBPu9pTyRGXhSn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fZr3/X5V; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214579; x=1760750579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tgiuh+IJ6oi6rH1j8ukSa4LOlosF6t9uEV0M4JxgZqE=;
  b=fZr3/X5Vv014giw+whmN0fHim9tYMkvolcY7z7F7z3o5S+5uHdM9os7F
   UNVpSUCdygBvoGnvc1Jgsfr/DcH+T1+8ntlTSn0WiP/iJkGqddSJ33PAp
   Y32U361pHLR/ZUN8vHHDY0tbQWoK2dM8r45f4fuYkzRYavAvagebNsviv
   4=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="377430589"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:22:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:28680]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 092a3154-ea9e-4d41-8ba7-cc725b751ac3; Fri, 18 Oct 2024 01:22:53 +0000 (UTC)
X-Farcaster-Flow-ID: 092a3154-ea9e-4d41-8ba7-cc725b751ac3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:22:52 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:22:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/11] rtnetlink: Define RTNL_FLAG_DOIT_PERNET for per-netns RTNL doit().
Date: Thu, 17 Oct 2024 18:22:15 -0700
Message-ID: <20241018012225.90409-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will push RTNL down to each doit() as rtnl_net_lock().

We can use RTNL_FLAG_DOIT_UNLOCKED to call doit() without RTNL, but doit()
will still hold RTNL.

Let's define RTNL_FLAG_DOIT_PERNET as an alias of RTNL_FLAG_DOIT_UNLOCKED.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bb49c5708ce7..3fa9da93364b 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -11,6 +11,7 @@ typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
 
 enum rtnl_link_flags {
 	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
+#define RTNL_FLAG_DOIT_PERNET		RTNL_FLAG_DOIT_UNLOCKED
 	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
 	RTNL_FLAG_DUMP_UNLOCKED		= BIT(2),
 	RTNL_FLAG_DUMP_SPLIT_NLM_DONE	= BIT(3),	/* legacy behavior */
-- 
2.39.5 (Apple Git-154)


