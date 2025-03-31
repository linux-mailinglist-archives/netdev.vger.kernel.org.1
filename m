Return-Path: <netdev+bounces-178383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3FA76CE2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86BC1888C62
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C31214A96;
	Mon, 31 Mar 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bxkt0eei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90081E2613
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445567; cv=none; b=PiWYtCYYQ/9rvS8rGaMhRuEswgQTRirTizFow2FLKvU1HiAespnl0H+fqfUf9IHbtl7HqaKD1aIrTZTGbSDaNj826QsGQ4foMzQE1CfUMeA392SWJMj6BZJNUVO/KsMWUyMjzqka1bGqUlAH19Ra1TmF1VdTSf2cKpAf5CiW1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445567; c=relaxed/simple;
	bh=H+zEwz5pSbjacl+3IPfEkERFjSQx5uj8byfJaCccZu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3YpJyDCiiqVCd3ZnRQvXGvx74O6QdM43Thq5hWLBhExtlsh32sTX8vNNVIikq7lMfbT/zQfxNiAV5+dVlTPlouoT1KVRPutHyblqkr8hC3WKuhYlsl6oQiNaPxrkX9LWNZqJGhHVcYNN0y+qxlAC8MEnQpFN4JZQI1M6khhS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bxkt0eei; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743445566; x=1774981566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpYF0e5btPgPi5TNRKRBrBhRzi/0wC7Bq6UQf45L4FU=;
  b=Bxkt0eeionW0p2NU0UJYwIQymyqXrGKHtiIaQfza3dGggu+ySwMvpfeV
   VE5nY0mATgLi/jPr+8gnU+I0ZLHVWxs7/Y4kDC7f6on6+Kqey5TE0HXu9
   uxV27FhiGC8bPkwt1mXXxbrMFSxIaZN5wv6jzyQDveF3RLAhVvWzGFOhC
   0=;
X-IronPort-AV: E=Sophos;i="6.14,291,1736812800"; 
   d="scan'208";a="731507629"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 18:26:00 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:39512]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.16:2525] with esmtp (Farcaster)
 id 7c8d1e28-c8ed-4f0f-927f-217f7b7f5a7e; Mon, 31 Mar 2025 18:25:43 +0000 (UTC)
X-Farcaster-Flow-ID: 7c8d1e28-c8ed-4f0f-927f-217f7b7f5a7e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 18:25:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.186.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 18:25:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net] rtnetlink: Use register_pernet_subsys() in rtnl_net_debug_init().
Date: Mon, 31 Mar 2025 11:25:27 -0700
Message-ID: <20250331182532.1523-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331154849.GC185681@horms.kernel.org>
References: <20250331154849.GC185681@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Mon, 31 Mar 2025 16:48:49 +0100
> On Fri, Mar 28, 2025 at 03:04:48PM -0700, Kuniyuki Iwashima wrote:
> > rtnl_net_debug_init() registers rtnl_net_debug_net_ops by
> > register_pernet_device() but calls unregister_pernet_subsys()
> > in case register_netdevice_notifier() fails.
> > 
> > It corrupts pernet_list because first_device is not updated
> > in unregister_pernet_device().
> 
> Hi Iwashima-san,
> 
> Maybe I am confused, but should the above line refer to
> unregister_pernet_subsys()?

Ah, exactly :)


> 
> And perhaps it would be yet clearer to say something like:
> 
> It corrupts pernet_list because first_device is not updated
> in register_pernet_device() but not unregister_pernet_subsys()?

Will rewrite in v2.

Thanks!

