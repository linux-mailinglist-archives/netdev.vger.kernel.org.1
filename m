Return-Path: <netdev+bounces-49078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B27F0AE7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 04:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C181F216E4
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 03:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27671186A;
	Mon, 20 Nov 2023 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598BD5D;
	Sun, 19 Nov 2023 19:20:33 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vwg4HNF_1700450429;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vwg4HNF_1700450429)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 11:20:30 +0800
Date: Mon, 20 Nov 2023 11:20:29 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Li RongQing <lirongqing@baidu.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.co, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <20231120032029.GA3323@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>

On Fri, Nov 17, 2023 at 01:27:57PM +0100, Alexandra Winter wrote:
>
>
>On 17.11.23 12:16, Li RongQing wrote:
>> There is rare possibility that conn->tx_pushing is not 1, since
>> tx_pushing is just checked with 1, so move the setting tx_pushing
>> to 1 after atomic_dec_and_test() return false, to avoid atomic_set
>> and smp_wmb in tx path
>> 
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>> ---
>> diff v3: improvements in the commit body and comments
>> diff v2: fix a typo in commit body and add net-next subject-prefix
>>  net/smc/smc_tx.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
>> index 3b0ff3b..2c2933f 100644
>> --- a/net/smc/smc_tx.c
>> +++ b/net/smc/smc_tx.c
>> @@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>>  		return 0;
>>  
>>  again:
>> -	atomic_set(&conn->tx_pushing, 1);
>> -	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
>>  	rc = __smc_tx_sndbuf_nonempty(conn);
>>  
>>  	/* We need to check whether someone else have added some data into
>> @@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
>>  	 * If so, we need to push again to prevent those data hang in the send
>>  	 * queue.
>>  	 */
>> -	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
>> +	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
>> +		atomic_set(&conn->tx_pushing, 1);
>> +		smp_wmb(); /* Make sure tx_pushing is 1 before send again */
>>  		goto again;
>> +	}
>>  
>>  	return rc;
>>  }
>
>It seems to me that the purpose of conn->tx_pushing is
>a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
>b) Repeat, in case some other thread has added data to sndbuf concurrently.
>
>I agree that this patch does not change the behaviour of this function and removes an
>atomic_set() in the likely path.
>
>I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
>So how can we ever run in a concurrency situation?
>Is this handling of conn->tx_pushing necessary at all?

Hi Sandy,

Overall, I think you are right. But there is something we need to take care.

Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
without checking sock_owned_by_user(), which would caused a race condition
because bh_lock_sock() did not honor sock_lock(). To address this issue,
I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
we now defer the transmission if sock_lock() is held by the user.
Therefore, there should no longer be a race condition. Nevertheless, if
we remove the tx_pending mechanism, we must always remember not to call
smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.

Thanks
Dust

