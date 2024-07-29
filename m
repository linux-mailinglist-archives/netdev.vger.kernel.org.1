Return-Path: <netdev+bounces-113714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D702993F9E5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815151F22F01
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4D15A853;
	Mon, 29 Jul 2024 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oIEMV/F8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477B15ADB3
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268655; cv=none; b=QEE4jsdSo02RTnmyeqiC7EN8BwdhZEKcOSHa1/FOSgUwWXGDrqhTlQKl3a9cK70GwLDJKOgq1eKFs5veAHS/dx1eptIIB1tfgT8nu8BQfE6taLPyoRKUFNQhtajq8QWZ/7eQoVJklGNTo/ZNoPEtdeZDZ6uYoN6SzFyabOT9/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268655; c=relaxed/simple;
	bh=ucUhcYSRsYEahY7wy1BH/gijtmU50uA0UuFTSNRZi1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yvi9PuNOsjnq2T5ZmpjfdyQ5qIgjl5FIpVg/H0kZPhzkC38g5jD3A7+KTvxnL+kBZYjJ3KiASC9q8pZ8XfSBWE3dEzqMeYx8qQkmtE3Hb51pCXgdgjA5Y/oYA0uZRd5sPqcXWaku1iYYO7HvTS2F8/Hqmu/2VloeUvctbbWdl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oIEMV/F8; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722268653; x=1753804653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vosuElsoUZ1rr23/WJK7LYXzSWOyH+LpKusr2zDOfVU=;
  b=oIEMV/F80mzdIZcwuWipq2Lk0K/R1Vd0A2z4yAAOIJA7B3XgK4+/Bq0j
   blb37dwPmnmOaMKqF3VyxAreMjWJnxkiv/TrFAttJxa8xNDdnNPi5ayup
   VjkfQJr7zrP5qTNmrdqnz+I22yZYFGqdEUPIpAhhEcbjfSVst6WT4SW/8
   I=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="110552743"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:57:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:56105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.228:2525] with esmtp (Farcaster)
 id 5f238b81-d970-4baa-917e-cbb5686a355a; Mon, 29 Jul 2024 15:57:31 +0000 (UTC)
X-Farcaster-Flow-ID: 5f238b81-d970-4baa-917e-cbb5686a355a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 15:57:30 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 15:57:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <xiaolinkui@126.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] tcp/dccp: Add another way to allocate local ports in connect()
Date: Mon, 29 Jul 2024 08:57:19 -0700
Message-ID: <20240729155719.73646-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240729095554.28296-1-xiaolinkui@126.com>
References: <20240729095554.28296-1-xiaolinkui@126.com>
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

From: xiaolinkui@126.com
Date: Mon, 29 Jul 2024 17:55:54 +0800
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> Commit 07f4c90062f8 ("tcp/dccp: try to not exhaust ip_local_port_range
> in connect()") allocates even ports for connect() first while leaving
> odd ports for bind() and this works well in busy servers.
> 
> But this strategy causes severe performance degradation in busy clients.
> when a client has used more than half of the local ports setted in
> proc/sys/net/ipv4/ip_local_port_range, if this client try to connect
> to a server again, the connect time increases rapidly since it will
> traverse all the even ports though they are exhausted.
> 
> So this path provides another strategy by introducing a system option:
> local_port_allocation. If it is a busy client, users should set it to 1
> to use sequential allocation while it should be set to 0 in other
> situations. Its default value is 0.
> 
> In commit 207184853dbd ("tcp/dccp: change source port selection at
> connect() time"), tell users that they can access all odd and even ports
> by using IP_LOCAL_PORT_RANGE. But this requires users to modify the
> socket application.

The application should be changed, or probably you can put your application
into a cgroup and hook connect() to call bpf_setsockopt() and silently
enable IP_LOCAL_PORT_RANGE.

