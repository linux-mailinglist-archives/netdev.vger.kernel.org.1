Return-Path: <netdev+bounces-54750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B108080EF
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 07:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9278281A53
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE56DDB4;
	Thu,  7 Dec 2023 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E7T8cDDL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC4137
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 22:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701931390; x=1733467390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9RH2AOG3BpxaeetIcAcNowgWH/+6AkkWOcLtceN0xOg=;
  b=E7T8cDDL11qz8foHU2PSwWKPoHXWnAVrQg1+fu+Dv/6/N2Txh9u9tfwV
   /7g3Q2+C/Wy9oQqMigrQyLRI62BBkeVanaKKdGBKarwz6zldAL1vO+EaU
   jXJlzTx44A4eVCCzAK0qfKcs9w4pK4yWb1Eq/Dht1OT5wm7a+UI86Qkj9
   M=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="381278777"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:43:02 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id C7AB28359C;
	Thu,  7 Dec 2023 06:42:58 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:57328]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.23:2525] with esmtp (Farcaster)
 id 6956a1c9-a95b-49aa-a0a3-566c19d16e72; Thu, 7 Dec 2023 06:42:58 +0000 (UTC)
X-Farcaster-Flow-ID: 6956a1c9-a95b-49aa-a0a3-566c19d16e72
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 06:42:56 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.249) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 7 Dec 2023 06:42:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <v4bel@theori.io>
CC: <davem@davemloft.net>, <dhowells@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <imv4bel@gmail.com>, <kuba@kernel.org>,
	<lukas.bulwahn@gmail.com>, <mkl@pengutronix.de>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] appletalk: Fix Use-After-Free in atalk_ioctl
Date: Thu, 7 Dec 2023 15:42:44 +0900
Message-ID: <20231207064244.22412-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231206120923.GA14115@ubuntu>
References: <20231206120923.GA14115@ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Hyunwoo Kim <v4bel@theori.io>
Date: Wed, 6 Dec 2023 04:09:23 -0800
> Because atalk_ioctl() accesses sk->sk_receive_queue
> without holding a sk->sk_receive_queue.lock, it can
> cause a race with atalk_recvmsg().
> A use-after-free for skb occurs with the following flow.
> ```
> atalk_ioctl() -> skb_peek()
> atalk_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> ```
> Add sk->sk_receive_queue.lock to atalk_ioctl() to fix this issue.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
>  net/appletalk/ddp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 9ba04a69ec2a..f240d5338bc9 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1775,15 +1775,16 @@ static int atalk_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  		break;
>  	}
>  	case TIOCINQ: {
> +		long amount = 0;
>  		/*
>  		 * These two are safe on a single CPU system as only
>  		 * user tasks fiddle here
>  		 */
> +		spin_lock_irq(&sk->sk_receive_queue.lock);

nit: please call spin_lock() after declaring all variables; otherwise
checkpatch.pl will complain.


>  		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
> -		long amount = 0;

Also, please keep the reverse xmas tree.


> -
>  		if (skb)
>  			amount = skb->len - sizeof(struct ddpehdr);
> +		spin_unlock_irq(&sk->sk_receive_queue.lock);
>  		rc = put_user(amount, (int __user *)argp);
>  		break;
>  	}
> -- 
> 2.25.1
> 

