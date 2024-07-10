Return-Path: <netdev+bounces-110461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0134292C806
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD291F23970
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685D3D62;
	Wed, 10 Jul 2024 01:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nrk4CO5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56C1B86D6
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575913; cv=none; b=AV3YZIPl7TJv4kYddGwXvqu8o1c+Q52Pm7quhUjEzg84DGnjjVTs42PBxJCAO+R9sV3r/DMLGaDPJmtNMhdCYMIJ5QDf0PEPOLAZX79CVyuEcdbUALB+upD3csrw0USUt6nOsfzfrTyLSOMZKfqpgI00gh2dQCFymqW3jmdAMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575913; c=relaxed/simple;
	bh=UCOfeXPXq2unUG3L6J6wgxV7YhnU162QH+AR5rbRyGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOScBifIY9PSBi+evcO7ay1DWzRWPtG6zmkf/cOIQK3MLHytHCj0sJ5abDrsg0CgboSvWQMPgQL0thNEu2D0PwlPAGhr3ulKYIlhqb617If9LMXpFnw9U/rcs/tZVtpOeGr9GXSkmWYwiKhTF7vySjv2hBJ+wbBivpD+n3ZEZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nrk4CO5/; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720575913; x=1752111913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D65hz3P+rllqNQr8hzbekEN6F3JT+oUIUQutOZo86kE=;
  b=Nrk4CO5/ZFcEYXOrIbSEeqDFinxzh3pj/kAeDkgJVjspWtyvXsgVZ2+S
   xRquW+yy76uZ8K42L8Yu6rOL4uAd3BZ0pcPSYp15YPy7uuvvHk5POh0pA
   jTou10ed7DzEyyPFl2F95sMcJp79Ef605dd+Pgd3J5MR1VfHEsKzPe23U
   U=;
X-IronPort-AV: E=Sophos;i="6.09,196,1716249600"; 
   d="scan'208";a="310207384"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:45:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:22483]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.52:2525] with esmtp (Farcaster)
 id f3b10c92-f3c1-4dad-b9d3-41e8d11056b0; Wed, 10 Jul 2024 01:45:10 +0000 (UTC)
X-Farcaster-Flow-ID: f3b10c92-f3c1-4dad-b9d3-41e8d11056b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 01:45:07 +0000
Received: from 88665a182662.ant.amazon.com (10.119.149.200) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 01:45:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dima@arista.com>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 0/2] tcp: Make simultaneous connect() RFC-compliant.
Date: Tue, 9 Jul 2024 18:44:55 -0700
Message-ID: <20240710014456.77159-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240709125209.71d02207@kernel.org>
References: <20240709125209.71d02207@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 9 Jul 2024 12:52:09 -0700
> On Mon, 8 Jul 2024 11:08:50 -0700 Kuniyuki Iwashima wrote:
> >   * Add patch 2
> 
> Hi Kuniyuki!
> 
> Looks like it also makes BPF CI fail. All of these:
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-07-09--15-00&executor=gh-bpf-ci&pw-n=0
> But it builds down to the reuseport test on various platforms.

Oh, thanks for catching!

It seems the test is using TFO, and somehow fastopen_rsk is cleared,
but a packet is processed later in SYN_RECV state...

Will look into it.

