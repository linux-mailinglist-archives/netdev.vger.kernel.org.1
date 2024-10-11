Return-Path: <netdev+bounces-134739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901BF99AF5C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA7E1F225C6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FF1E2019;
	Fri, 11 Oct 2024 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TwusvqsW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0611D1745
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689119; cv=none; b=tkA0h+HUB5yv4rXc8Lr1HRcQ/Zq0MfEXzKV6qoSnkUJ4oQidd+d0oV/yd3vSAxwSdtSRU6thJjQgoBEmytTGej4MiiGuhlsTynIEGr2j7C8QsUB8HCzgZhQFXbgq3jj/TFXYnL/M5ehObhg+fpwAoFYjg2S0qLi85COx8G1oAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689119; c=relaxed/simple;
	bh=/ly3K0nPfvbSujLSlYmbijWqAc9rqb9+Yf9nP7aLdd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PN0Pj1odDXprmn/B00ICc+lr7WWAjy9Y9BVWa37OEzld2Vw0Xd6AmF3K9L0tWfL93RdA+GVo0JY9T1mWcUameJgLBx6xrSGRtfWSr2u1WxzIGZohSwPgu8tyt7dMjhDAHGEObh5t67RZ+r5z/YtFP9NF2N4vx+Bv7zau0RrfHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TwusvqsW; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728689119; x=1760225119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2DPZvHYqcyo3C6vzxH4nBnokPc4bXUqRU4xtTqNJOIE=;
  b=TwusvqsWxfb7JvcKFNAHQtDpTDLxZkDg47BnIstNu6k0+jtfFg4Sdhc5
   x0Mib8zmOX9LJeObjpUnfW037N6JIq5pu8lfBpAu1jpPsF5JYIm2gf5lm
   QGzv12A10cMGqAc2rN+Warr9fTBcq/RHJmJyokn3hg4NGSqm1+YFrarZF
   M=;
X-IronPort-AV: E=Sophos;i="6.11,197,1725321600"; 
   d="scan'208";a="375490179"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 23:25:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:10958]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 15fc717c-842e-40d3-9068-925a4d705926; Fri, 11 Oct 2024 23:25:08 +0000 (UTC)
X-Farcaster-Flow-ID: 15fc717c-842e-40d3-9068-925a4d705926
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 23:25:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 23:25:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <brianvv@google.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 2/5] net_sched: sch_fq: prepare for TIME_WAIT sockets
Date: Fri, 11 Oct 2024 16:25:01 -0700
Message-ID: <20241011232501.52893-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241010174817.1543642-3-edumazet@google.com>
References: <20241010174817.1543642-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 17:48:14 +0000
> TCP stack is not attaching skb to TIME_WAIT sockets yet,
> but we would like to allow this in the future.
> 
> Add sk_listener_or_tw() helper to detect the three states
> that FQ needs to take care.
> 
> Like NEW_SYN_RECV, TIME_WAIT are not full sockets and
> do not contain sk->sk_pacing_status, sk->sk_pacing_rate.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

