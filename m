Return-Path: <netdev+bounces-40222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52D7C6312
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 04:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBFD2824D1
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F212634;
	Thu, 12 Oct 2023 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAF37B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:50:10 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92001173F;
	Wed, 11 Oct 2023 19:49:37 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vtyo5q7_1697078970;
Received: from 30.221.149.75(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vtyo5q7_1697078970)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:49:31 +0800
Message-ID: <9f8f7a96-fcb0-3088-6d2f-d7e7d0fc83a1@linux.alibaba.com>
Date: Thu, 12 Oct 2023 10:49:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 3/5] net/smc: allow cdc msg send rather than drop it
 with NULL sndbuf_desc
Content-Language: en-US
To: Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
 <1697009600-22367-4-git-send-email-alibuda@linux.alibaba.com>
 <5e2efb4b-1d26-4159-a2c7-b0107cb6381c@linux.ibm.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <5e2efb4b-1d26-4159-a2c7-b0107cb6381c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/23 4:37 AM, Wenjia Zhang wrote:
>
>
> On 11.10.23 09:33, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch re-fix the issues memtianed by commit 22a825c541d7
>> ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").
>>
>> Blocking sending message do solve the issues though, but it also
>> prevents the peer to receive the final message. Besides, in logic,
>> whether the sndbuf_desc is NULL or not have no impact on the processing
>> of cdc message sending.
>>
> Agree.
>
>> Hence that, this patch allow the cdc message sending but to check the
>> sndbuf_desc with care in smc_cdc_tx_handler().
>>
>> Fixes: 22a825c541d7 ("net/smc: fix NULL sndbuf_desc in 
>> smc_cdc_tx_handler()")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>>   net/smc/smc_cdc.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 01bdb79..3c06625 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct 
>> smc_wr_tx_pend_priv *pnd_snd,
>>   {
>>       struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend 
>> *)pnd_snd;
>>       struct smc_connection *conn = cdcpend->conn;
>> +    struct smc_buf_desc *sndbuf_desc;
>>       struct smc_sock *smc;
>>       int diff;
>>   +    sndbuf_desc = conn->sndbuf_desc;
>>       smc = container_of(conn, struct smc_sock, conn);
>>       bh_lock_sock(&smc->sk);
>> -    if (!wc_status) {
>> -        diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
>> +    if (!wc_status && sndbuf_desc) {
>> +        diff = smc_curs_diff(sndbuf_desc->len,
> How could this guarantee that the sndbuf_desc would not be NULL?
>

It can not guarantee he sndbuf_desc would not be NULL, but it will prevents
the smc_cdc_tx_handler() to access a NULL sndbuf_desc. So that we
can avoid the panic descried in commit 22a825c541d7
("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").

>> &cdcpend->conn->tx_curs_fin,
>>                        &cdcpend->cursor);
>>           /* sndbuf_space is decreased in smc_sendmsg */
>> @@ -114,9 +116,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
>>       union smc_host_cursor cfed;
>>       int rc;
>>   -    if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
>> -        return -ENOBUFS;
>> -
>>       smc_cdc_add_pending_send(conn, pend);
>>         conn->tx_cdc_seq++;


