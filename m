Return-Path: <netdev+bounces-48242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602F7EDB7B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C1AB209DD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 06:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2093211A;
	Thu, 16 Nov 2023 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108519F;
	Wed, 15 Nov 2023 22:18:14 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VwV9lei_1700115491;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VwV9lei_1700115491)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 14:18:12 +0800
Date: Thu, 16 Nov 2023 14:18:11 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Li RongQing <lirongqing@baidu.com>, wenjia@linux.ibm.co,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <20231116061811.GC121324@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231116022041.51959-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116022041.51959-1-lirongqing@baidu.com>

On Thu, Nov 16, 2023 at 10:20:41AM +0800, Li RongQing wrote:
>there is rare possibility that conn->tx_pushing is not 1, since
>tx_pushing is just checked with 1, so move the setting tx_pushing
>to 1 after atomic_dec_and_test() return false, to avoid atomic_set
>and smp_wmb in tx path
>
>Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> net/smc/smc_tx.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
>index 3b0ff3b..72dbdee 100644
>--- a/net/smc/smc_tx.c
>+++ b/net/smc/smc_tx.c
>@@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
> 		return 0;
> 
> again:
>-	atomic_set(&conn->tx_pushing, 1);
>-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
> 	rc = __smc_tx_sndbuf_nonempty(conn);
> 
> 	/* We need to check whether someone else have added some data into
>@@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
> 	 * If so, we need to push again to prevent those data hang in the send
> 	 * queue.
> 	 */
>-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
>+	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
>+		atomic_set(&conn->tx_pushing, 1);
>+		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
nit: it would be better if we change the comments to "send again".

Thanks
> 		goto again;
>+	}
> 
> 	return rc;
> }
>-- 
>2.9.4

