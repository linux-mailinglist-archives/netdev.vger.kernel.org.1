Return-Path: <netdev+bounces-133191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D399544F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C801F25F0A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6255897;
	Tue,  8 Oct 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nn/jEWoa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107538DD6
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404632; cv=none; b=Uip4gsENWE+ohYPNpbUAIb3jO75bXvxQAXHL5gsVUcAoqBjb3aJaJGEjFFRtr5hvEA3jgb7UUphnP0qWV+moJDvGrIpcWWs+/bLnSgJdC200y6J/2lx/qhKkurg3XMOTc5J/kRmzyuambKO6AtRcQSi0/CAjdDpoRWWgFPqJ93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404632; c=relaxed/simple;
	bh=uK2M2sK0ZgBAuHgBClWgNvIUUjyMmtcsATvT2D/0oQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3VWx33T1sOJY77F1aAAFEXsI21UvcQWXwVqw49EgLHnnFDDFCzg6yyLhAZKuNPyAGa2ysGcW+HeHvJsRTuPqmdG3Rwsxf0EF9HXRvfyAXeRL+Kjgzw0cunBM5UJreNRdQtzslTi840Ex+tMlryVwnnRGrN7WeD15SCayNbOfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nn/jEWoa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728404631; x=1759940631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qKZut+MuqB3q9ijY/08gORVUFCKDkclOx49oSkuWE6U=;
  b=Nn/jEWoaSx+JhQBh8nPkF+vyzw4WpSldD0Mwy9ViL/dJhGtuMpLPjpNb
   AdY61oDS5WSNYIDcEd8zlpnTf9IJ2YDbcz04KpFXCEFeHsoQeC+xT8Y9U
   yXgcuQrwsWis+DnvEY+byambTgN+BHrpx05npyk9tfTlMaeY5X6+S2DlS
   4=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="341172725"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:23:28 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:20723]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id f2de39b9-16bb-485d-97a9-f2bb63d8b9f8; Tue, 8 Oct 2024 16:23:27 +0000 (UTC)
X-Farcaster-Flow-ID: f2de39b9-16bb-485d-97a9-f2bb63d8b9f8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 16:23:21 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 16:23:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv6: switch inet6_acaddr_hash() to less predictable hash
Date: Tue, 8 Oct 2024 09:23:10 -0700
Message-ID: <20241008162310.94808-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008121307.800040-1-edumazet@google.com>
References: <20241008121307.800040-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Tue,  8 Oct 2024 12:13:07 +0000
> commit 2384d02520ff ("net/ipv6: Add anycast addresses to a global hashtable")
> added inet6_acaddr_hash(), using ipv6_addr_hash() and net_hash_mix()
> to get hash spreading for typical users.
> 
> However ipv6_addr_hash() is highly predictable and a malicious user
> could abuse a specific hash bucket.
> 
> Switch to __ipv6_addr_jhash(). We could use a dedicated
> secret, or reuse net_hash_mix() as I did in this patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

