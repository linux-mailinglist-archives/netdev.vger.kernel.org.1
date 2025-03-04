Return-Path: <netdev+bounces-171461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810CBA4D059
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63C73B0138
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6015E97;
	Tue,  4 Mar 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FdkYv0rB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD21E505
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741049025; cv=none; b=AsP4okkVl2QR8QsIHrEkI8zVjUydUZzqgJAm6DCALpf67bU0tsTzLS8SNZ5aY4HnoR76ZeFRSjfxA+rMG+kqi6DuFC8DyDdGm+qytkwnGkaUHx3MRXvnwviM90wjyKTeuYJwYFWNR4jb+oP2QNPxFaqmAs3uEVE/EqOJW8GqhjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741049025; c=relaxed/simple;
	bh=MF/2ibHFKzd9lIAqu4ueYTtwGXJMIPGS/h1c+k0KXxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LatvEBIb/UO3qUeiD/C1FJiJ2uIYboBL65YBlX4tlvxfViKmx7O0uH44rkpiIU9Mduh7FN/PF5zZYuL4HjU6FHxGnmic3wfzEAtoWm4KiljigoMwEu6ALeUiHBwlZmX5XJiKlTRFarI7212drsUnSV72JW4HGnoWVmcpRi1EEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FdkYv0rB; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741049024; x=1772585024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xfMtAlLOVq3FmVvnsOixpiiWskNQdNFaBCQsjKrmrP8=;
  b=FdkYv0rBIzaReMS0A86LwQAj1nEFSKaIbLbvNF+InhHaOixtsXi+a12t
   7+YvgcE1y14ByXYopy+ysiK/IjVwri5u5gXkY7ginY1pJ0dylWAdscex0
   V0nE9+ZZsEXHaB7HJrMHkRMaMkCnzh5rAZQJlER3m/vMEiK7G9x+MZqgF
   g=;
X-IronPort-AV: E=Sophos;i="6.13,331,1732579200"; 
   d="scan'208";a="723552274"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:43:40 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:37517]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.238:2525] with esmtp (Farcaster)
 id 27478c12-48c0-4e87-a864-8b54bac7e2ff; Tue, 4 Mar 2025 00:43:39 +0000 (UTC)
X-Farcaster-Flow-ID: 27478c12-48c0-4e87-a864-8b54bac7e2ff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:43:38 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:43:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/4] tcp: add RCU management to inet_bind_bucket
Date: Mon, 3 Mar 2025 16:43:26 -0800
Message-ID: <20250304004326.63309-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250302124237.3913746-4-edumazet@google.com>
References: <20250302124237.3913746-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sun,  2 Mar 2025 12:42:36 +0000
> Add RCU protection to inet_bind_bucket structure.
> 
> - Add rcu_head field to the structure definition.
> 
> - Use kfree_rcu() at destroy time, and remove inet_bind_bucket_destroy()
>   first argument.
> 
> - Use hlist_del_rcu() and hlist_add_head_rcu() methods.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

