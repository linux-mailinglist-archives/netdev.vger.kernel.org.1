Return-Path: <netdev+bounces-141812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364479BC55A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6836E1C2166C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 06:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317481FDF80;
	Tue,  5 Nov 2024 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WEgESBbn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9E1FCC77
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787685; cv=none; b=hOtzE901ltmQwMlL2laWtAYqI9GA5EbZtS2oLO8ixhp+9JXyRwYgXOQieV3W7lhldGx7adQFhydKcOgItHVGz+56gA0tsCrgi3fRrF4x7uesl2N0JwFyCRD9QlbSr46JA3JpZTcFnctpkK76cdfhzjkAD605+6SjCPlKUY68BsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787685; c=relaxed/simple;
	bh=cw/HmaGoZEOhotsb19/dZeCnxz0RNXNOkRTvz2kQvA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIRu0YJ5b+wFpDnjMS9xLNLRMEt9xufxMvsfy4/PXrEWa55t4EctzINVfhSbxD8EvIX/XO+iiutJghdMOxwU7nzrOmnafHyqaPw9Pfy1IAlG/ZzY4kDVSu9S+bJPWGYfs/pYWi3NYZxpp4gCHy10L8xdK4htQGaKTuS7ZSJ+yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WEgESBbn; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730787683; x=1762323683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhyejYIFuPdnL4v1pHKOym6zlwKIuep6mhUK+c8sAUE=;
  b=WEgESBbnHgLTHCntEjFwe1qcETGAW0LnN1nYrkmaN69YD7AcHErdZhyl
   ZS7X5YenrexW7oO6x6brWnlizyfcQq26iARZ3LBmX17ryJmMhXPhpsm4D
   rc+3nkWYOm541oMAwJO9Y9ZuRtCgNTTo7hKV7PDqhdiiTrZA/IMhutXYE
   g=;
X-IronPort-AV: E=Sophos;i="6.11,259,1725321600"; 
   d="scan'208";a="244945087"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 06:21:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41841]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.50:2525] with esmtp (Farcaster)
 id b1b4494b-4132-43f5-8cf9-488e1744e723; Tue, 5 Nov 2024 06:21:19 +0000 (UTC)
X-Farcaster-Flow-ID: b1b4494b-4132-43f5-8cf9-488e1744e723
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 06:21:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 06:21:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <johannes@sipsolutions.net>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <pablo@netfilter.org>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net 2/2] selftests: net: add a test for closing a netlink socket ith dump in progress
Date: Mon, 4 Nov 2024 22:21:07 -0800
Message-ID: <20241105062107.64837-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105010347.2079981-2-kuba@kernel.org>
References: <20241105010347.2079981-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon,  4 Nov 2024 17:03:47 -0800
> Close a socket with dump in progress. We need a dump which generates
> enough info not to fit into a single skb. Policy dump fits the bill.
> 
> Use the trick discovered by syzbot for keeping a ref on the socket
> longer than just close, with mqueue.
> 
>   TAP version 13
>   1..3
>   # Starting 3 tests from 1 test cases.
>   #  RUN           global.test_sanity ...
>   #            OK  global.test_sanity
>   ok 1 global.test_sanity
>   #  RUN           global.close_in_progress ...
>   #            OK  global.close_in_progress
>   ok 2 global.close_in_progress
>   #  RUN           global.close_with_ref ...
>   #            OK  global.close_with_ref
>   ok 3 global.close_with_ref
>   # PASSED: 3 / 3 tests passed.
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Note that this test is not expected to fail but rather crash
> the kernel if we get the cleanup wrong.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

TIL mq_notify, and the trick was interesting that calls fdget(),
netlink_getsockbyfilp(), and fdput() to keep sock_hold() only :)

