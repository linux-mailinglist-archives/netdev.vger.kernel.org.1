Return-Path: <netdev+bounces-147814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504B79DBFC8
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 08:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D2516299F
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1761537DA;
	Fri, 29 Nov 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TV2HOj4N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F3184F
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865780; cv=none; b=Xw61HHONvepvl4Nf5tl5E1n/iliOIKvUdoONEk+oUHqF/xKPFJFAntYXbK1P4SgY5AVb/cWX6JNOIi/dcYmDVkCFOv+0jxL9ozL92FiJYEYD3yBhdAt28wcrkNQu05w18Qkac9OmlLemj6yPlFRvZ6IqbhOyaSl8Li/87PPc94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865780; c=relaxed/simple;
	bh=C++RCFCnEmKpxpAcZXP95owrmD3LxrsxtPhDm6kuk44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U96iopIc1bKicolf+Nbj/Mv6MV1UxZ4OnRNVvqcgvOifaa51aSfk1SB0+EAFPxcbe9hJKkmuI+FmAoA9L1kbyPnbogN40QOMlM4WE2O5cdw48ASEt5aQtH7dT57jCThGeDpokVlJ/jyh0CO1c6uGSDkIH6AVouJWVMyPg5mRt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TV2HOj4N; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732865778; x=1764401778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=suiVFLSlVMWuuw5sPLr3XRGL9BvfwNQ36MD1q3sDEWQ=;
  b=TV2HOj4N360jr9uZgnk4KdGauTta6lxdxgPFTNAXrzpDo0+q+P/EiEg+
   szukVbZLKJgroKtW+es9Wu8F/GRxSmxcXgNlqOMT9IvdwN+fk7y62GyP9
   XPL3x5cYD9pNn+unDuvuJoE/9Kl8+NioSleDhe2yK0piYEKPt2daV7Dr3
   E=;
X-IronPort-AV: E=Sophos;i="6.12,194,1728950400"; 
   d="scan'208";a="148886304"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 07:36:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:40197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 99c059aa-9f43-4482-9a77-a74ae7f21ee7; Fri, 29 Nov 2024 07:36:15 +0000 (UTC)
X-Farcaster-Flow-ID: 99c059aa-9f43-4482-9a77-a74ae7f21ee7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 07:36:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 29 Nov 2024 07:36:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xiyou.wangcong@gmail.com>
CC: <cong.wang@bytedance.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>
Subject: Re: [Patch net] rtnetlink: catch error pointer for rtnl_link_get_net()
Date: Fri, 29 Nov 2024 16:36:09 +0900
Message-ID: <20241129073609.30713-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
References: <20241129063112.763095-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 28 Nov 2024 22:31:12 -0800
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Currently all callers of rtnl_link_get_net() assume that it always
> returns a valid netns pointer,

because I assume it's always tested in rtnl_add_peer_net()...


> when rtnl_link_get_net_ifla() fails,
> it uses 'src_net' as a fallback.
> 
> This is not true,

because rtnl_link_get_net_ifla() isn't called if (!data ||
!data[ops->peer_type]),

so the correct fix is:

---8<---
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index dd142f444659..c1f4aaa40823 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3815,6 +3815,10 @@ static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
 	struct net *net;
 	int err;
 
+	net = rtnl_link_get_net_ifla(tb);
+	if (IS_ERR(net))
+		return PTR_ERR(net);
+
 	if (!data || !data[ops->peer_type])
 		return 0;
 
@@ -3828,9 +3832,6 @@ static int rtnl_add_peer_net(struct rtnl_nets *rtnl_nets,
 			return err;
 	}
 
-	net = rtnl_link_get_net_ifla(tb);
-	if (IS_ERR(net))
-		return PTR_ERR(net);
 	if (net)
 		rtnl_nets_add(rtnl_nets, net);
 
---8<---


> because rtnl_link_get_net_ifla() can return an
> error pointer too, we need to handle this error case and propagate
> the error code to its callers.
> 
> Add a comment to better document its return value.

