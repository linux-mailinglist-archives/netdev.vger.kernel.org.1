Return-Path: <netdev+bounces-80005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0554A87C6D9
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC14A282BEB
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 00:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E381E;
	Fri, 15 Mar 2024 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QpVYv5gX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1719F
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464119; cv=none; b=qXU+I7FV5JnoMlP2XOC3T4QUjTANER+aVKktLMMIkenFLw54vI5CwSAk0xbdkhxfhhZTrfWuHcDWc5CxuUkxKujTTsPli6IAiTKZ9Xd6JJkM5zYq/xpjH960wNTyrYcGa4ys21QQ1ay8LWqVxqSEDybInaIt+kNnnSyWOIIv+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464119; c=relaxed/simple;
	bh=bjWOomYUZqZJTO33ZrQMa77ODKPd97U81J45TigL5Lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VycWVsOLSSMogVOc6TqEWXF654+TyMari/dqQaeatt2lOkW4T/aJ1+99Ni6BhCMXjsfBbo5upkzd4KR26ELQTseGNRg4PMbD5M9lZBPfN7W7sVCtoZbLKiPMVRgdz+z+Yz23DrkvxkfSifeUgu4XphFf3ZerBLYOnkRGzfy1MPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QpVYv5gX; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710464118; x=1742000118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abveaZmTf9ceywz7Kw8PorzFZf8Uk8v0INvtUM2GO2s=;
  b=QpVYv5gXjJN48AX8OrLy+uYqxh+IkqcKzAkR02vEpdNHwEtr9KFWSj82
   lcnWL77EK9wLRXTKO+JmAbYta4WLcxVL+7nvAGh3Y0lD0gjrU4KOiIaxO
   JhdMKdohmT6WogKq/fqwANhm//t29afv6qrWxxhltYwbr894TSNLSOJ0m
   s=;
X-IronPort-AV: E=Sophos;i="6.07,127,1708387200"; 
   d="scan'208";a="644890716"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:55:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:6769]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.10:2525] with esmtp (Farcaster)
 id 76e0cd1b-4a74-4151-b1ad-e98ba4c82d6a; Fri, 15 Mar 2024 00:55:13 +0000 (UTC)
X-Farcaster-Flow-ID: 76e0cd1b-4a74-4151-b1ad-e98ba4c82d6a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 00:55:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 00:55:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <chenyuan0y@gmail.com>
CC: <andriy.shevchenko@linux.intel.com>, <anjali.k.kulkarni@oracle.com>,
	<davem@davemloft.net>, <dhowells@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pctammela@mojatatu.com>,
	<zzjas98@gmail.com>
Subject: Re: [net/netlink] Question about potential memleak in netlink_proto_init()
Date: Thu, 14 Mar 2024 17:54:58 -0700
Message-ID: <20240315005458.10355-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZfOalln/myRNOkH6@cy-server>
References: <ZfOalln/myRNOkH6@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Thu, 14 Mar 2024 19:47:18 -0500
> Dear Netlink Developers,
> 
> We are curious whether the function `netlink_proto_init()` might have a memory leak.
> 
> The function is https://elixir.bootlin.com/linux/v6.8/source/net/netlink/af_netlink.c#L2908
> and the relevant code is
> ```
> static int __init netlink_proto_init(void)
> {
> 	int i;
>   ...
> 
> 	for (i = 0; i < MAX_LINKS; i++) {
> 		if (rhashtable_init(&nl_table[i].hash,
> 				    &netlink_rhashtable_params) < 0) {
> 			while (--i > 0)
> 				rhashtable_destroy(&nl_table[i].hash);
> 			kfree(nl_table);
> 			goto panic;

If rhashtable_init() fails, the kernel panic occurs, so there's
no real memleak issue.


> 		}
> 	}
>   ...
> }
> ```
> 
> In the for loop, when `rhashtable_init()` fails, the function will free
> the allocated memory for `nl_table[i].hash` by checking `while (--i > 0)`.
> However, the first element (`i=1`) of `nl_table` is not freed since `i` is
> decremented before the check.
> 
> Based on our understanding, a possible fix would be
> ```
> -      while (--i > 0)
> +      while (--i >= 0)
> ```

Change itself looks good, no need for cleanup in the first place though.

