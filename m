Return-Path: <netdev+bounces-118970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE768953B47
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 22:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5144282E67
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76B13B599;
	Thu, 15 Aug 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BAgm9ful"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB8A3D984
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752407; cv=none; b=EqPiA8bZwvmrFFeSfyxJ2x5iV5p/mi6NDajU9XKM22133wS8POkRe7xNgfKQj/HsL8iF0seGkm25hApn5R9G7ZH2cnfUXw9mTtVgmBW2U7Csgc1znNyaC3XLXqfpYv17mt0vIgN7Zi7ASTSQvkXayYqrDAKkwx9dRuCoCcqBmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752407; c=relaxed/simple;
	bh=RY6Aer+Sah1wzaa3DN6w1SYPubVSKdlGCHP1+GzTBFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLsVSyyITpHKOEGDydGB+z/L0wx8TMzm2Jk3hXDWV1KBx2da+x9SRlH6MSKbpG5VjsUbeNSrlFOzKGL6PQ9poALk0OrRRg289kcNvg+GkznxCJq3m/HanD4PqeY9tHfFwM43MmJ/6OVyOgVP2lhk9kwT0UCKTyGCijXq2gGaHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BAgm9ful; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723752405; x=1755288405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRKGDbI0b8iHrCf4ixpFsldL9/r1yV953mp6ooLhL3A=;
  b=BAgm9fulWx4efLkn3W130ClUU8oeL4bszhsQvZ2mpYcWL/R7kLZWDo27
   2UZScPKlszjVZ8MF5vsVc9q8UmUyQx6cXsHnMXRYUohaR+LS2nNaeuwd5
   14gui8vpA8idDHrvjocxj7U+8haKPHYPK4HeiIG1pnHGcYBxJ5ZEGblY3
   A=;
X-IronPort-AV: E=Sophos;i="6.10,149,1719878400"; 
   d="scan'208";a="115664865"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 20:06:44 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:30518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.141:2525] with esmtp (Farcaster)
 id ab6b4df0-634a-445c-960e-ed4d690879f0; Thu, 15 Aug 2024 20:06:44 +0000 (UTC)
X-Farcaster-Flow-ID: ab6b4df0-634a-445c-960e-ed4d690879f0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 20:06:43 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 20:06:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<jadedong@tencent.com>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Thu, 15 Aug 2024 13:06:29 -0700
Message-ID: <20240815200629.45526-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240815113745.6668-1-kerneljasonxing@gmail.com>
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Aug 2024 19:37:45 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> We found that one close-wait socket was reset by the other side
> which is beyond our expectation, so we have to investigate the
> underlying reason. The following experiment is conducted in the
> test environment. We limit the port range from 40000 to 40010
> and delay the time to close() after receiving a fin from the
> active close side, which can help us easily reproduce like what
> happened in production.
> 
> Here are three connections captured by tcpdump:
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
> // a few seconds later, within 60 seconds
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
> // later, very quickly
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> 
> As we can see, the first flow is reset because:
> 1) client starts a new connection, I mean, the second one
> 2) client tries to find a suitable port which is a timewait socket
>    (its state is timewait, substate is fin_wait2)
> 3) client occupies that timewait port to send a SYN
> 4) server finds a corresponding close-wait socket in ehash table,
>    then replies with a challenge ack
> 5) client sends an RST to terminate this old close-wait socket.
> 
> I don't think the port selection algo can choose a FIN_WAIT2 socket
> when we turn on tcp_tw_reuse because on the server side there
> remain unread data. If one side haven't call close() yet, we should
> not consider it as expendable and treat it at will.
> 
> Even though, sometimes, the server isn't able to call close() as soon
> as possible like what we expect, it can not be terminated easily,
> especially due to a second unrelated connection happening.
> 
> After this patch, we can see the expected failure if we start a
> connection when all the ports are occupied in fin_wait2 state:
> "Ncat: Cannot assign requested address."
> 
> Reported-by: Jade Dong <jadedong@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

