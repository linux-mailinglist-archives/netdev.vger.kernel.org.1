Return-Path: <netdev+bounces-163806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4F5A2B9CA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA877A2CA4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF61632F2;
	Fri,  7 Feb 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X/oGDqTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A62417E7
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899520; cv=none; b=p1OWNXwfqrUtsZ2b4gEuxQXIvAZZ1vnPISHKV4/99OcQYU5WBI8vwL5T2Kfh+Osv2/lFOMv1etNgBf9ZwqEOdHmTqSJ9TS7WbV7+JhFbyp7hqRg0U6Bqwx40KANiOY8tzObuR/eChtV+0J09uNms4nw394hi9e8afirJd7ED164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899520; c=relaxed/simple;
	bh=Ff5Ide4rsuAFsbUZ8FtG8TtEujx/ZXkKtij3MwLsmKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDqC+2/TLcAHYuS8kwBEukPEZslxAZTIw6dzqle//wHYXa0xUK6rQbTva/1M4k9ahrOLAFP7hJGp3G/ouxwXwPq7SQeXtBEG+JK1DQgifm5tc2bwKFwEPsKrhA0PeUqyqLFIIyuHrYfrwa0tZUpgbWWjtVnexKhfI9N63DWob0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X/oGDqTC; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738899519; x=1770435519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpTfcUasFvA7loNDgAdhgEW2CY/Wwpq46dz0wNsj6sg=;
  b=X/oGDqTCtz9xoOu0bilGbyLEL0OeWeYWuyBJQqIT/EPPBP0yjlOZvDwj
   ua59HuTHDfEzvgbOzbMOGsGvhAQKUAY0uztjWS/E143fUT6EdQqK5SZ6l
   RkNSZqXTNtDY7xrB3f1rX6fVWlO0o+L7dCIaI559yhOOQk55op2CfiqN0
   g=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="269106493"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:38:35 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:9448]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id cda0908a-e2f4-4127-a625-b95823ce202e; Fri, 7 Feb 2025 03:38:34 +0000 (UTC)
X-Farcaster-Flow-ID: cda0908a-e2f4-4127-a625-b95823ce202e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 03:38:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 03:38:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<ushankar@purestorage.com>
Subject: Re: for_each_netdev_rcu() protected by RTNL and CONFIG_PROVE_RCU_LIST
Date: Fri, 7 Feb 2025 12:38:22 +0900
Message-ID: <20250207033822.47317-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
References: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu, 6 Feb 2025 07:51:55 -0800
> Hello,
> 
> We're seeing CONFIG_PROVE_RCU_LIST warnings when for_each_netdev_rcu()
> is called with RTNL held. While RTNL provides sufficient locking, the
> RCU list checker isn't aware of this relationship, leading to false
> positives like:
> 
> 	WARNING: suspicious RCU usage
> 	net/core/dev.c:1143 RCU-list traversed in non-reader section!!
> 
> The initial discussion popped up in:
> 
> 	https://lore.kernel.org/all/20250205-flying-coucal-of-influence-0dcbc3@leitao/
> 
> I've attempted a solution by modifying for_each_netdev_rcu():
> 
> 	diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> 	index 2a59034a5fa2f..59b18b58fa927 100644
> 	--- a/include/linux/netdevice.h
> 	+++ b/include/linux/netdevice.h
> 	@@ -3210,13 +3210,14 @@ netdev_notifier_info_to_extack(const struct netdev_notifier_info *info)
> 	int call_netdevice_notifiers(unsigned long val, struct net_device *dev);
> 	int call_netdevice_notifiers_info(unsigned long val,
> 					struct netdev_notifier_info *info);
> 	+bool lockdep_rtnl_net_is_held(struct net *net);
> 
> 	#define for_each_netdev(net, d)		\
> 			list_for_each_entry(d, &(net)->dev_base_head, dev_list)
> 	#define for_each_netdev_reverse(net, d)	\
> 			list_for_each_entry_reverse(d, &(net)->dev_base_head, dev_list)
> 	#define for_each_netdev_rcu(net, d)		\
> 	-		list_for_each_entry_rcu(d, &(net)->dev_base_head, dev_list)
> 	+		list_for_each_entry_rcu(d, &(net)->dev_base_head, dev_list, lockdep_rtnl_net_is_held(net))
> 	#define for_each_netdev_safe(net, d, n)	\
> 			list_for_each_entry_safe(d, n, &(net)->dev_base_head, dev_list)
> 	#define for_each_netdev_continue(net, d)		\
> 
> However, I have concerns about using lockdep_rtnl_net_is_held() since it
> has a dependency on CONFIG_DEBUG_NET_SMALL_RTNL.
> 
> Are there better approaches to silence these warnings when RTNL is held?
> Any suggestions would be appreciated.

We can't use lockdep_rtnl_net_is_held() there yet because most users are
not converted to per-netns RTNL, so it will complain loudly.

