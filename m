Return-Path: <netdev+bounces-133976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2399797C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C3DB212C0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE517E;
	Thu, 10 Oct 2024 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JUdlFTQH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FFE632
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518847; cv=none; b=bTlAREbGPLXtSEKsH4qagbbKovsmeUY6Vz7snCNqWGTUkKhARckrc9sn2yoeATNcMH50KaEk1QYM2/SgB1kzXHS2mzYt9JKJnVAhifX/2Fp0GA6r1eNPCAK+up0s8YoZacjOYbjyXADhRmaVNLJJ6fWA6qxz86Fi4turGtFMsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518847; c=relaxed/simple;
	bh=15T1JvUbqBnMND2+U3omaDfKT9KVYIz/GxP7Iok0XwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9P2u4KNJwWrEAax6bcQREHhTEndWL3jcD+azdFF+kCwYDHmM+lcDg1vx2R3WlI6SiJ2UsoU84N3a8YMtOeYg88+XW2vFbJNDtTO21nO0h1zJnkvo2h2FGCSrKGaorW8psRMxHryb3Y2HxbsgqBmISbcV11t6xE4wfYc30A8j54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JUdlFTQH; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728518846; x=1760054846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m5Bi27aRMSLbN44//wKDL6k02RrGyb9Z/r9OXSYfuqo=;
  b=JUdlFTQHZtMuZ68Sy6XMIRGy3vnzx9NjnuG3pxiqOs5p33yLTmp8VLls
   D7CbLykDNsdCEStwFelbg0FCmnkKnZn4JoIbn6hcmDVZs0mjYT+weuZ/5
   QjJpMGtB2Racd4hIZFDeX1iaTyguki8KH5HKjlf4oW78OVDk+VIEvBKzf
   k=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="137243595"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 00:07:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:57661]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 454f4410-79a4-470f-834d-44ef6d671e08; Thu, 10 Oct 2024 00:07:25 +0000 (UTC)
X-Farcaster-Flow-ID: 454f4410-79a4-470f-834d-44ef6d671e08
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 00:07:25 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 00:07:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/5] net: do not acquire rtnl in fib_seq_sum()
Date: Wed, 9 Oct 2024 17:07:19 -0700
Message-ID: <20241010000719.61942-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009184405.3752829-6-edumazet@google.com>
References: <20241009184405.3752829-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed,  9 Oct 2024 18:44:05 +0000
> After we made sure no fib_seq_read() handlers needs RTNL anymore,
> we can remove RTNL from fib_seq_sum().
> 
> Note that after RTNL was dropped, fib_seq_sum() result was possibly
> outdated anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

