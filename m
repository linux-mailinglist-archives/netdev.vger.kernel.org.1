Return-Path: <netdev+bounces-35371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0F37A9138
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307C82815B2
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979D1FAF;
	Thu, 21 Sep 2023 03:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399A3D79
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:20:02 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E20ED;
	Wed, 20 Sep 2023 20:20:00 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VsWyC7J_1695266396;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VsWyC7J_1695266396)
          by smtp.aliyun-inc.com;
          Thu, 21 Sep 2023 11:19:57 +0800
Date: Thu, 21 Sep 2023 11:19:56 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() while
 closing listen socket
Message-ID: <20230921031956.GA92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695211714-66958-1-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 08:08:34PM +0800, D. Wythe wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>Consider the following scenarios:
>
>smc_release
>	smc_close_active
>		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
>		smc->clcsock->sk->sk_user_data = NULL;
>		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
>
>smc_tcp_syn_recv_sock
>	smc = smc_clcsock_user_data(sk);
>	/* now */
>	/* smc == NULL */
>
>Hence, we may read the a NULL value in smc_tcp_syn_recv_sock(). And
>since we only unset sk_user_data during smc_release, it's safe to
>drop the incoming tcp reqsock.
>
>Fixes:  ("net/smc: net/smc: Limit backlog connections"
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> net/smc/af_smc.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index bacdd97..b4acf47 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -125,6 +125,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
> 	struct sock *child;
> 
> 	smc = smc_clcsock_user_data(sk);
>+	if (unlikely(!smc))
>+		goto drop;

Is it possible smc != NULL here
> 
> 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
But later turns to NULL in 'atomic_read(&smc->queue_smc_hs)'
> 				sk->sk_max_ack_backlog)

Seems there is still a race ?

>-- 
>1.8.3.1

