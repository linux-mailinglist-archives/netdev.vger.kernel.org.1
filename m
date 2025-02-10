Return-Path: <netdev+bounces-164540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD5AA2E1FB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8056118877AD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA58F9FE;
	Mon, 10 Feb 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KFhTy5EI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9982595
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739150561; cv=none; b=bwfJmZT4oF2mPhmmbZKrRbj8EiihAlYsuNR9v89TwCEe7yJYexMgwdbMPdeb/jGfjnzfU1kTB4hGuFwxL9fiicvE0wDMFJ/QpGMqU69/MbZMMTboSsC97t320n1AWD/yVfJ4pmesyHqx4SOGgFfTNOlFqMA4+v4FhSvatAPNg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739150561; c=relaxed/simple;
	bh=SYaPEgFL5OYXWTYw/BOQV9Mv7ncHDCA+Ea+EYGczbPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S69niQsugj4wWuQySMnTF6tIGF9wyXWehZ5rG0Y5rxXQ38pO+P7ECmjNNjsjFxexxNR9WQxufPU8v5nvGnc0wIxWDS4CU6KuEPhZnir7hJWGB1m4m7uxlZgpsWzjPrTPdEcApkkRE74VNnwizNDiFWwEXpfEg5qlYTC+aagfH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KFhTy5EI; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739150560; x=1770686560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xH+/YH9o3yzTNQIvY8foRpofeOXUWnyTPOFkfc++ac=;
  b=KFhTy5EIe33kQTeRLZT1EARKPXxm4ktzxxNuDwK9MSVKVxFEH5Ize4Gr
   c89v+UxXqFCo4lkbL4Nr4EXKMjR2TRUf8cPaWIhbCCifPTDuQYGe7qGl/
   TXw7vg4UB+TTpn9Ubh9br3ECpCn8bfU7TCAKTPPEC6L6UHAev1wDRdj5m
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="171006834"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:22:38 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:35184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.236:2525] with esmtp (Farcaster)
 id 98e82478-0050-42d9-b6dc-b3ac23394d21; Mon, 10 Feb 2025 01:22:38 +0000 (UTC)
X-Farcaster-Flow-ID: 98e82478-0050-42d9-b6dc-b3ac23394d21
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:22:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:22:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 5/8] openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
Date: Mon, 10 Feb 2025 10:22:24 +0900
Message-ID: <20250210012224.55427-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-6-edumazet@google.com>
References: <20250207135841.1948589-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:37 +0000
> ovs_vport_cmd_fill_info() can be called without RTNL or RCU.
> 
> Use RCU protection and dev_net_rcu() to avoid potential UAF.
> 
> Fixes: 9354d4520342 ("openvswitch: reliable interface indentification in port dumps")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

