Return-Path: <netdev+bounces-132274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8720991265
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC71F22805
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA31B4F26;
	Fri,  4 Oct 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t3idoJKa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D3143C7E
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081589; cv=none; b=m+t99bQoISN/t0XYb+Y0ogQfrHPiFAPcEP/FHve9SLjtZ5IdcnEDd+K8wqVjCukSXYuu9KClLtPrUZCSS1Gj/VvTI38wTazp2bHsnE9pniTTjmg0BaX7NMGMuuijwUulqpkw5NJGB8gagZLyS0iWnwnV7mUtO8cNadvZogC10rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081589; c=relaxed/simple;
	bh=Vo7GJKCdowIN4LuGxc4b9rZS5O3UcSoka4+Lf0yygUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrQE5XJmFWTnnu0cbmicaZkrOYffdUFNIhzIvrLAMfbBtx8/j78ts1A9dMYiaLDK9QgQKmSBsWoaN/pADuYE9xRcLKtV8mBrn7rCs9nyBLtWSmr7itgojqHKSdLzTF7gwn2uHyEy0fchYds8rO3ZVBFcdgPATKUeuVwBsgKfN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t3idoJKa; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728081588; x=1759617588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yW2CneO8cvPiR8XG8W+p3sMNab5D72EpVtFhII3Cpyo=;
  b=t3idoJKaijBwo8dur8hdTav4tFtuCYq3+J6g9bI+1YM4DIrGT6ChY9TR
   XdnNS0XyP7kyH8WkBbjE5MnkMlsXyb+HOBuboi0N9NZkk8XGzSpfbOfzu
   +Cq/D9mbJhDKf9nw4/UJx/XMS/izleeRNJPj7q+rk8VWPHGZY7kAIRdOL
   U=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="373166808"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:39:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:58067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.158:2525] with esmtp (Farcaster)
 id 9490e037-b780-49be-9297-417a261f2137; Fri, 4 Oct 2024 22:39:41 +0000 (UTC)
X-Farcaster-Flow-ID: 9490e037-b780-49be-9297-417a261f2137
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:39:40 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:39:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alexandre.ferrieux@orange.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/4] ipv4: use rcu in ip_fib_check_default()
Date: Fri, 4 Oct 2024 15:39:29 -0700
Message-ID: <20241004223929.81691-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004134720.579244-3-edumazet@google.com>
References: <20241004134720.579244-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Date: Fri,  4 Oct 2024 13:47:18 +0000
From: Eric Dumazet <edumazet@google.com>
> fib_info_devhash[] is not resized in fib_info_hash_move().
> 
> fib_nh structs are already freed after an rcu grace period.
> 
> This will allow to remove fib_info_lock in the following patch.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

