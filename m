Return-Path: <netdev+bounces-40029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADF7C5781
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435A41C209A6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3752718AF8;
	Wed, 11 Oct 2023 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BDF1D680
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:54:49 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C46B90;
	Wed, 11 Oct 2023 07:54:46 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VtxF.Kl_1697036080;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VtxF.Kl_1697036080)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 22:54:41 +0800
Date: Wed, 11 Oct 2023 22:54:40 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net 5/5] net/smc: put sk reference if close work was
 canceled
Message-ID: <20231011145440.GP92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697009600-22367-6-git-send-email-alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 03:33:20PM +0800, D. Wythe wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>Note that we always hold a reference to sock when attempting
>to submit close_work. Therefore, if we have successfully
>canceled close_work from pending, we MUST release that reference
>to avoid potential leaks.
>
>Fixes: 42bfba9eaa33 ("net/smc: immediate termination for SMCD link groups")
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> net/smc/smc_close.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
>index 449ef45..10219f5 100644
>--- a/net/smc/smc_close.c
>+++ b/net/smc/smc_close.c
>@@ -116,7 +116,8 @@ static void smc_close_cancel_work(struct smc_sock *smc)
> 	struct sock *sk = &smc->sk;
> 
> 	release_sock(sk);
>-	cancel_work_sync(&smc->conn.close_work);
>+	if (cancel_work_sync(&smc->conn.close_work))
>+		sock_put(sk);
> 	cancel_delayed_work_sync(&smc->conn.tx_work);
> 	lock_sock(sk);
> }
>-- 
>1.8.3.1

