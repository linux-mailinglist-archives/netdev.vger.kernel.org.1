Return-Path: <netdev+bounces-47150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB87E8516
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 22:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228391F20632
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78A53B28A;
	Fri, 10 Nov 2023 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gy55nQLL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5393C691;
	Fri, 10 Nov 2023 21:32:04 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DC4205;
	Fri, 10 Nov 2023 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699651924; x=1731187924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqcEiMovyEdWADV3nVvr7tGxPcK5AkK82nsGuLxcaeM=;
  b=gy55nQLLiHNCjYJO8oZ2fpeUwT+ymQR5EjJbs6D6sden9BzAn2vPvYyq
   BN/Pw1f/6jxg5gGvYJHQLnZXgNnJXOH0ZHl41UdmEFkEdLigNORAlYp2w
   UpqBIx/F3qIh9ptHCgRahEgrvejFYCdvDEci3+yuJaP1w0mh0fAzNDW/Q
   s=;
X-IronPort-AV: E=Sophos;i="6.03,293,1694736000"; 
   d="scan'208";a="367405578"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 21:32:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 452D2A0D1B;
	Fri, 10 Nov 2023 21:31:59 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:42729]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.85:2525] with esmtp (Farcaster)
 id cc3de777-ea4a-4c4d-95f7-1c856f0df8d4; Fri, 10 Nov 2023 21:31:58 +0000 (UTC)
X-Farcaster-Flow-ID: cc3de777-ea4a-4c4d-95f7-1c856f0df8d4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 21:31:58 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Fri, 10 Nov 2023 21:31:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bragathemanick0908@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-hams@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <ralf@linux-mips.org>,
	<syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] net: memory leak in nr_rx_frame
Date: Fri, 10 Nov 2023 13:31:47 -0800
Message-ID: <20231110213147.68823-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231110173632.2511-1-bragathemanick0908@gmail.com>
References: <20231110173632.2511-1-bragathemanick0908@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.8]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Date: Fri, 10 Nov 2023 23:06:32 +0530
> The condition (make = nr_make_new(sk)) == NULL suggests
> that nr_make_new allocates memory and returns a pointer.
> If this allocation fails (returns NULL), it indicates a
> potential memory leak.

If make is NULL, nothing is allocated and leaked here, and
your code will never be executed as "if (make)" is always false.


> 
> Added sock_put() for make which can potentially solve
> this issue

Sounds like the patch is not tested with kmemleak.


> 
> Reported-by: syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0145ea560de205bc09f0
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  net/netrom/af_netrom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 0eed00184adf..7d7cda4ae300 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -970,6 +970,8 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
>  		nr_transmit_refusal(skb, 0);
>  		if (sk)
>  			sock_put(sk);
> +		if (make)
> +			sock_put(make);

Also, make could be uninitialised here if the first two
condition is true.

   if (sk == NULL || sk_acceptq_is_full(sk) ||


>  		return 0;
>  	}
>  
> -- 
> 2.34.1

