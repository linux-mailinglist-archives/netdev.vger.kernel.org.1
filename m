Return-Path: <netdev+bounces-48263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9A7EDD93
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE871C20832
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880C18053;
	Thu, 16 Nov 2023 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E81B6;
	Thu, 16 Nov 2023 01:28:25 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VwVpH1q_1700126902;
Received: from 30.221.129.201(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VwVpH1q_1700126902)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 17:28:23 +0800
Message-ID: <d8c0ac0d-f28b-8984-06f9-41bfdcb03425@linux.alibaba.com>
Date: Thu, 16 Nov 2023 17:28:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH][net-next] net/smc: avoid atomic_set and smp_wmb in the tx
 path when possible
To: Li RongQing <lirongqing@baidu.com>, wenjia@linux.ibm.co,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com
References: <20231116022041.51959-1-lirongqing@baidu.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231116022041.51959-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/11/16 10:20, Li RongQing wrote:
> there is rare possibility that conn->tx_pushing is not 1, since
   There
> tx_pushing is just checked with 1, so move the setting tx_pushing
> to 1 after atomic_dec_and_test() return false, to avoid atomic_set
> and smp_wmb in tx path
                         .
> 

Some nits:

1. It is normally using [PATCH net-next] rather than [PATCH][net-next]
    in subject. And new version should better be marked. such as:

    # git format-patch --subject-prefix="PATCH net-next" -v 3

    And CC all relevant people listed by:

    # ./scripts/get_maintainer.pl <your patch>

2. Few improvements in the commit body.


Thanks,
Wen Gu

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   net/smc/smc_tx.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 3b0ff3b..72dbdee 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>   		return 0;
>   
>   again:
> -	atomic_set(&conn->tx_pushing, 1);
> -	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>   	rc = __smc_tx_sndbuf_nonempty(conn);
>   
>   	/* We need to check whether someone else have added some data into
> @@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>   	 * If so, we need to push again to prevent those data hang in the send
>   	 * queue.
>   	 */
> -	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
> +	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
> +		atomic_set(&conn->tx_pushing, 1);
> +		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>   		goto again;
> +	}
>   
>   	return rc;
>   }

