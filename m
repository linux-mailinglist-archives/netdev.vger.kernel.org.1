Return-Path: <netdev+bounces-176341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C78A69C91
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08144188CD4F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A522258B;
	Wed, 19 Mar 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S7G9iNiK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E51C3C11
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425790; cv=none; b=W7SvAsmgDoRVtpOfzbTKE3iMF5vWXU7XtJ4URVVCzhb4ND9lWUJvWIGltgfm9upth53OLyIaRZ7lMMR1tqNVKKRO6CwFaSpYwlLmZ7qrSUWQCCRuFrVxHubCwt4+FKD0gxwtkmP7cWP8iFDAWupKqG7QLM8SAaAAJrPHmIKWn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425790; c=relaxed/simple;
	bh=H++QZvL0n4plXHyqrHVE0Azec8lhxX4ggv6epHq9ETw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnabJ0yuwLByO6GAUR282jhdJQNbdihT43wzCVeuJFzt5Mu8Vm6oooC4Qt+IvCGGYvHp3+6N0+BqZ2OQyQ72+sbpeKqrFRbppo60kIhQDPMwq2XvXx2TLMZ3JjIxJFkevd0w2k89mnESiMbdTmXFTStk5j77D41HGVe9xfIc3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S7G9iNiK; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425790; x=1773961790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tALDP/yBHDDZgdBJkgDDf7ukeMAL5QGHt+c8L1JE4RU=;
  b=S7G9iNiKCRonaOxWH0yPRzUmaJ3yjC9WzQAJh9uS7UaWPW7ZwGU/c1GS
   0wFd4Xmdoz1GENW/CUATXiJ9Rvs4Xe0yGyvBqM/L5LfOLuun5NfI/jKLV
   4SMtD8242/nP3F++gxKq0eAd/Hoj1DDkB3rxTBKMkLaUn2qldwyhVrZys
   w=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="504255071"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:09:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:20640]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525] with esmtp (Farcaster)
 id 2def29a6-c2bb-4ce7-8233-58a80787f773; Wed, 19 Mar 2025 23:09:43 +0000 (UTC)
X-Farcaster-Flow-ID: 2def29a6-c2bb-4ce7-8233-58a80787f773
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:09:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:09:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/7] nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
Date: Wed, 19 Mar 2025 16:06:49 -0700
Message-ID: <20250319230743.65267-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

nexthop_add() checks if NLM_F_REPLACE is specified without
non-zero NHA_ID, which does not require RTNL.

Let's move the check to rtm_new_nexthop().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 426cdf301c6f..fb129c830040 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2928,11 +2928,6 @@ static struct nexthop *nexthop_add(struct net *net, struct nh_config *cfg,
 	struct nexthop *nh;
 	int err;
 
-	if (cfg->nlflags & NLM_F_REPLACE && !cfg->nh_id) {
-		NL_SET_ERR_MSG(extack, "Replace requires nexthop id");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!cfg->nh_id) {
 		cfg->nh_id = nh_find_unused_id(net);
 		if (!cfg->nh_id) {
@@ -3247,6 +3242,12 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto out;
 
+	if (cfg.nlflags & NLM_F_REPLACE && !cfg.nh_id) {
+		NL_SET_ERR_MSG(extack, "Replace requires nexthop id");
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = rtm_to_nh_config_rtnl(net, tb, &cfg, extack);
 	if (err)
 		goto out;
-- 
2.48.1


