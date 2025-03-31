Return-Path: <netdev+bounces-178392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98DA76D13
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456AE169A32
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC22144B7;
	Mon, 31 Mar 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wn9TSOjx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C728635B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447334; cv=none; b=V2r4wFAWNdvWhDAuHW6WMakvng1W9vngCweQvQMJcRsp7zFrrKU/feW5IApcg/PhAzTJS/R4q9iaaSGEk8HQ+uzPVgVjbtErvD8z6Fw/Nw54gS/BWholbgkzQohGLu1C2A6PgBr22VuNw3xo4BvsgW0BKBFa+cCv+rZ3vzoWjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447334; c=relaxed/simple;
	bh=Qj7REN69Q2Q5fkBstZyHGKN0Nvla9IUlBM/6tFuaR3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZEPDgL1plzUOjeKwuWgY6W7p0ufNOjNyyZpmHxU4JFyEx8U61Ky3Sih/tONIVGo3sMhxhl4mu1ts0evWeBWblteTe00KQUvM62mFFeK2vTqs/rHhnQsPrlZ5g5tjlDnge54EcYoDmhOZRH5kg89Qpo1quaoMLQNIh8cditAjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wn9TSOjx; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743447334; x=1774983334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WnckPdpFzv1e2LW4/fZWTEJP3tJY3enhwvrZf/tc/NI=;
  b=Wn9TSOjxv94j3ctRyP+HCmlS4x+i6axvSxAkz/7I5LNonlLBKn13QQTe
   0fYSTDcjte+8DBHKf9+gQzeRirOyRvUY0bFQX+25jIzo7TfN2tkzLJ57Y
   9NqEDvAZfFMi4IH6VkDpK8j99IChucIBnS/aY0PoB4XxE+O/EcndqaDSD
   U=;
X-IronPort-AV: E=Sophos;i="6.14,291,1736812800"; 
   d="scan'208";a="476059626"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 18:55:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:34540]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.232:2525] with esmtp (Farcaster)
 id 3c3c88cc-b7b8-4439-92de-ce562e456e5f; Mon, 31 Mar 2025 18:55:27 +0000 (UTC)
X-Farcaster-Flow-ID: 3c3c88cc-b7b8-4439-92de-ce562e456e5f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 18:55:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.186.82) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 31 Mar 2025 18:55:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Mon, 31 Mar 2025 11:54:53 -0700
Message-ID: <20250331185515.5053-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331113603.6b15bb9a@kernel.org>
References: <20250331113603.6b15bb9a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 31 Mar 2025 11:36:03 -0700
> On Mon, 31 Mar 2025 11:21:34 -0700 Kuniyuki Iwashima wrote:
> > > Plus we also see failures in udpgso.sh  
> > 
> > I forgot to update `size` when skb_condense() is called.
> > 
> > Without the change I saw the new test stuck at 1 page after
> > udpgso.sh, but with the change both passed.
> > 
> > Will post v5.
> 
> Please do test locally if you can.

Sure, will try the same tests with CI.

