Return-Path: <netdev+bounces-178006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B74A73F3F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EF4189A451
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C01C68A6;
	Thu, 27 Mar 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g8zTlrAz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE57DA82
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743106663; cv=none; b=dlt2cJxYQutZWDOyTrtls6HiWFgcf1CCMKi3YIyAAbxtw9ioDjIazbezg+9A4U4yr2yLyGRUiS3EAuBwVYsQ5xmXSJbUfuehZXaOtrUXtm7M8Y6Tf2/UuGjbieSDJ216e+8GTZP/zsfBaTdesmUTCvdyXxjGcoWVF6pm1I4JVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743106663; c=relaxed/simple;
	bh=sei++5fbYPD3TrLZcm/flWKntcxMTMz97Bhr5ZSpN9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqdIO7mYa1LvB38xck2inE1xHGxBPMvNgI6sd/Iky6iixY/u9tUb/grFMl9j9Fd0cRCbpNUjwM9SgwM8MiJZELNHEaODnBY1sG8G6wCY04nl6MWQxXQaKo+db864ZbgZLX/88b+RGB70z2oMlaiudiKzRdb6/PhPRhmimVrNsYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g8zTlrAz; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743106662; x=1774642662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WnHAsdCNJYLMQGnFlW5sVbU4OFO54yTdOZlQ/PnJEhc=;
  b=g8zTlrAzidiR4tBOq5R418t2gYL2q9VGYdNnfvb2xhrbm8khvDbUEK3c
   15g6qftGECpwCpokrFPjwVCSqzD0aoJdF8XqHXf5FHl8ThV2NFbT8hAVf
   Xu3HzqWAZd6YlxtzY1/1kipUvEe2vUrHCip08Kv0JsxsZGCmRpIrgvi6y
   Y=;
X-IronPort-AV: E=Sophos;i="6.14,281,1736812800"; 
   d="scan'208";a="35811321"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 20:17:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:16832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.232:2525] with esmtp (Farcaster)
 id 6108fd07-db96-41f1-a2c0-810d06c049c5; Thu, 27 Mar 2025 20:17:37 +0000 (UTC)
X-Farcaster-Flow-ID: 6108fd07-db96-41f1-a2c0-810d06c049c5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 20:17:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 20:17:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Thu, 27 Mar 2025 13:17:23 -0700
Message-ID: <20250327201725.62180-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327125119.47b25ff2@kernel.org>
References: <20250327125119.47b25ff2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 27 Mar 2025 12:51:19 -0700
> On Tue, 25 Mar 2025 12:58:12 -0700 Kuniyuki Iwashima wrote:
> > I got a report that UDP mem usage in /proc/net/sockstat did not
> > drop even after an application was terminated.
> > 
> > The issue could happen if sk->sk_rmem_alloc wraps around due
> > to a large sk->sk_rcvbuf, which was INT_MAX in our case.
> > 
> > The patch 2 fixes the issue, and the patch 1 fixes yet another
> > overflow I found while investigating the issue.
> 
> Selftest doesn't apply after the net-next PR :(

Will send v3 shortly with so_rcv_listener sorted.

Thanks!

