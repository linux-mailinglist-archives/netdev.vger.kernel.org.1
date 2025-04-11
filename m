Return-Path: <netdev+bounces-181486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A3A85211
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2273BFD92
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543891E04BD;
	Fri, 11 Apr 2025 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qjpaP23J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E341DF974
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342396; cv=none; b=pbIrXJKYdnv5qHLMjOCI0vpUmPKNUI0umrLCJYTHgZ4SCCOjY2NT1rwWMQxlM7ptqd+R3j/4OoGIJrQEf0oOFI4LElxus4R/jX5SYnFK/DwmIZ2qUjvGLH95H1HcO+8u2116iFWWxaecbdeEHkpEn4whv4hWu7m6bMEjCzrVUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342396; c=relaxed/simple;
	bh=iZz528PagEUKplbtSO4isurUbYG/5iwL8KiOaNJbiGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ/kYdM6fvUgMv9El4OZp3OAdMk8aVYIyzl+GJE71p0uqPWRLWJB59nBLA6S415uEnrAx3gd951IeVWaoxgHgoAgkxCNyO6n1ttuYU5gHjqcverMtyqCJ3IN+Rh74w6GvZ/IJX2KXnLmgxdfWUUNjR/pDr5XuZIdHfm/WNdFVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qjpaP23J; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744342395; x=1775878395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMPSGH4p/XusmtNQlCyysx0DNlvkjuNQeIg3l7Wfsmo=;
  b=qjpaP23JIUhrMua2WlEVY9sBhqQQ28VsuW12c0erqzCmg5k/Bs6zEaGW
   Tf78K/zHaLJLyJAw9IRiVNYUdP/viAO60+bTA99Kt2hZCw507pghnxQDX
   dJrqtXk1OSd5NshmdC5fquDErpHUnW6n2Y59HrzNSY/vlvJ0NnM/A2Ns5
   0=;
X-IronPort-AV: E=Sophos;i="6.15,203,1739836800"; 
   d="scan'208";a="287544009"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 03:33:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:63161]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 733eeba0-9e09-4ba4-86d1-9053b7fa04dd; Fri, 11 Apr 2025 03:33:10 +0000 (UTC)
X-Farcaster-Flow-ID: 733eeba0-9e09-4ba4-86d1-9053b7fa04dd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 03:33:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 03:33:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>
Subject: Re: OA[PATCH v1 net-next 02/14] net: Add ops_undo_single for module load/unload.
Date: Thu, 10 Apr 2025 20:32:49 -0700
Message-ID: <20250411033257.70991-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <202504111024.Qc5fW99d-lkp@intel.com>
References: <202504111024.Qc5fW99d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Apr 2025 11:16:36 +0800
> Hi Kuniyuki,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/net-Factorise-setup_net-and-cleanup_net/20250410-102752
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250410022004.8668-3-kuniyu%40amazon.com
> patch subject: [PATCH v1 net-next 02/14] net: Add ops_undo_single for module load/unload.
> config: loongarch-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111024.Qc5fW99d-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111024.Qc5fW99d-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504111024.Qc5fW99d-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    net/core/net_namespace.c: In function '__unregister_pernet_operations':
> >> net/core/net_namespace.c:1311:17: error: implicit declaration of function 'free_exit_list'; did you mean 'ops_exit_list'? [-Wimplicit-function-declaration]
>     1311 |                 free_exit_list(ops, &net_exit_list);
>          |                 ^~~~~~~~~~~~~~
>          |                 ops_exit_list

I missed one instance when CONFIG_NET_NS=n.
Will squash the diff below in v2.

---8<---
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 9ab3ba930d76..f7a99937645f 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1326,8 +1326,9 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 		list_del(&ops->list);
 	} else {
 		LIST_HEAD(net_exit_list);
+
 		list_add(&init_net.exit_list, &net_exit_list);
-		free_exit_list(ops, &net_exit_list);
+		ops_undo_single(ops, &net_exit_list);
 	}
 }
 
---8<---

