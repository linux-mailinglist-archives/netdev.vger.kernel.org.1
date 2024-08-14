Return-Path: <netdev+bounces-118590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6B09522BC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE71C210AF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9B1BE872;
	Wed, 14 Aug 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tzN0PIET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BEBB679
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723664346; cv=none; b=NGLTstfWZ7eD9+6EVLMYjFMUqwampaF3mVDBgk4jSCiPG4e0Qb/0kg/6i9hOzNGvksrC0+MtdjoQ0hyDClHMm6xSmPUkXQ8gm4PyGfRo63Ax2dOthVYBstiT989h0OLWWatZ6Iky3+jbb2svz4X7TyMD7DGsJuRTI2i6ZtNhvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723664346; c=relaxed/simple;
	bh=5o8bLJKQZXs/B1xrtD9asnPMIVh3qZvsOhfSBIbrKvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUFKU6IuR0tV6lW2ENzHrlQqHhgNYkPHcnwul3avSWKQuI/dw6xJneDfkDAD+qyFwsnReEVEVVkKqNqc4J7lLLt52V1gwsb+X+/PDM+etq0nr4c2YdX8Z4P710WrTYDNx4Z4q0SBeJa3uQX5CyccJObKJDHzIrifU9R8DeB+aW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tzN0PIET; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723664342; x=1755200342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3QLulvlesH7Cf5KgzaYpwdCDM0l4BosUdEnq871myPk=;
  b=tzN0PIETbnPtWvCGdaMzGPTOzIGoSH5NAVjexrd/bMwC9sXFURg50JGg
   ZOMOVKPrUMK1egRpu/47NkIa+UHTcGMZj+WKQNqVM7kvtD92o6fCzX4ER
   tgsmnAqo/shhRMbBZAAkUChGTsAyAvoiaCzSLNJcpafKID3YyfOSzsg9m
   8=;
X-IronPort-AV: E=Sophos;i="6.10,146,1719878400"; 
   d="scan'208";a="18978133"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:38:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:57195]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.153:2525] with esmtp (Farcaster)
 id 8798cb4a-2cf9-4005-9efa-fd8b9aae0ba8; Wed, 14 Aug 2024 19:38:56 +0000 (UTC)
X-Farcaster-Flow-ID: 8798cb4a-2cf9-4005-9efa-fd8b9aae0ba8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 14 Aug 2024 19:38:56 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 14 Aug 2024 19:38:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<jadedong@tencent.com>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
Date: Wed, 14 Aug 2024 12:38:44 -0700
Message-ID: <20240814193844.66189-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240814035136.60796-1-kerneljasonxing@gmail.com>
References: <20240814035136.60796-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Aug 2024 11:51:36 +0800
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
> ---
>  net/ipv4/inet_hashtables.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 9bfcfd016e18..6115ee0c5d90 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -563,7 +563,8 @@ static int __inet_check_established(struct inet_timewait_death_row *death_row,
>  			continue;
>  
>  		if (likely(inet_match(net, sk2, acookie, ports, dif, sdif))) {
> -			if (sk2->sk_state == TCP_TIME_WAIT) {
> +			if (sk2->sk_state == TCP_TIME_WAIT &&
> +			    inet_twsk(sk2)->tw_substate != TCP_FIN_WAIT2) {

I prefer comparing explicitly like

  inet_twsk(sk2)->tw_substate == TCP_TIME_WAIT

