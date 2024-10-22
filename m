Return-Path: <netdev+bounces-138019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B159AB826
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510B2845B4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA701C9EB3;
	Tue, 22 Oct 2024 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p3E+C+9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2B13AD2A
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631017; cv=none; b=Di05aw337Vcb/RtaTZZdOW5pxjU61QTTnFki4T3+r/zevh7ueqmFYV16HJYO+0Smr/fjyMZrcOkUJu2s2NLlVGBXxqcfQ8u1qBwiN18IkJ4Vd84jJvP2C6tVpv8W6qyDSGIyqi/njlrr6sAnjsksI00tlEKEbk6AkGc+IOAQiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631017; c=relaxed/simple;
	bh=uA5yjTR63PNSWMpsHnRtZDY7s4TjvvFGrrkVDhjkbJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BPeyXzykMu/n65CAlgqwSFtoKlupneRar0XUzFpyKi33VTeA7fy743y1WIxAjg0+7ou/agKncfr/8qe+NQs+mBCP94fN4718tOWXnBxpOtEY/ZVIVLy+IcQOBh5uEZDXJw16TilFauGQeZd8UEHzDYurKJmhlzD6JyuqXzLM8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p3E+C+9l; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729631016; x=1761167016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OUjYVkjamefnSf+/Cpkocl5tRdkoJ0UWeCiOeBifDk8=;
  b=p3E+C+9ly4dmjIFh33CE8a1A/OEc8nyuiNiZqeS5jzTLIquI/8GS29Si
   kVdAXg7zyrHBVO7Medrv3f9330jl3qpLsp/0c7zPwhjpK3Mq9ATLSKD74
   7IXTz+HzVdwGmtj5H54GiXDDsfDP0aytSPO4nEOesLaqeSpJ1reLYcIL3
   g=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="463687017"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:03:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:32340]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.247:2525] with esmtp (Farcaster)
 id f3f9fcf4-e1ad-48c8-9d60-cdbed0f04f30; Tue, 22 Oct 2024 21:03:29 +0000 (UTC)
X-Farcaster-Flow-ID: f3f9fcf4-e1ad-48c8-9d60-cdbed0f04f30
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 22 Oct 2024 21:03:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 22 Oct 2024 21:03:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] rtnetlink: Fix kdoc of rtnl_af_register().
Date: Tue, 22 Oct 2024 14:03:20 -0700
Message-ID: <20241022210320.86111-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The cited commit made rtnl_af_register() return int again,
and kdoc needs to be fixed up.

Fixes: 26eebdc4b005 ("rtnetlink: Return int from rtnl_af_register().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dda8230fdfd4..b70f90b98714 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -708,7 +708,7 @@ static void rtnl_af_put(struct rtnl_af_ops *ops, int srcu_index)
  * rtnl_af_register - Register rtnl_af_ops with rtnetlink.
  * @ops: struct rtnl_af_ops * to register
  *
- * Returns 0 on success or a negative error code.
+ * Return: 0 on success or a negative error code.
  */
 int rtnl_af_register(struct rtnl_af_ops *ops)
 {
-- 
2.39.5 (Apple Git-154)


