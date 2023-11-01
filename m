Return-Path: <netdev+bounces-45527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96D7DDDC4
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F21D281154
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF411850;
	Wed,  1 Nov 2023 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B5EA6
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 08:37:06 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D8FDF;
	Wed,  1 Nov 2023 01:37:01 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VvQscqP_1698827813;
Received: from 30.221.145.165(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VvQscqP_1698827813)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 16:36:54 +0800
Message-ID: <966f6d4d-722e-045c-891c-2e3553c6b81a@linux.alibaba.com>
Date: Wed, 1 Nov 2023 16:36:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net 2/3] net/smc: allow cdc msg send rather than drop it
 with NULL sndbuf_desc
Content-Language: en-US
To: dust.li@linux.alibaba.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1698810177-69740-1-git-send-email-alibuda@linux.alibaba.com>
 <1698810177-69740-3-git-send-email-alibuda@linux.alibaba.com>
 <20231101081916.GG92403@linux.alibaba.com>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231101081916.GG92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 11/1/23 4:19 PM, Dust Li wrote:
> On Wed, Nov 01, 2023 at 11:42:56AM +0800, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch re-fix the issues memtianed by commit 22a825c541d7
> memtianed -> mentioned ?
>
>> ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()").
>>
>> Blocking sending message do solve the issues though, but it also
>> prevents the peer to receive the final message. Besides, in logic,
>> whether the sndbuf_desc is NULL or not have no impact on the processing
>> of cdc message sending.
>>
>> Hence that, this patch allow the cdc message sending but to check the
> allows
>
>> sndbuf_desc with care in smc_cdc_tx_handler().
>>
>> Fixes: 22a825c541d7 ("net/smc: fix NULL sndbuf_desc in smc_cdc_tx_handler()")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks for that. I will fix them in next version.

> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> ---
>> net/smc/smc_cdc.c | 9 ++++-----
>> 1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 01bdb79..3c06625 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
>> {
>> 	struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend *)pnd_snd;
>> 	struct smc_connection *conn = cdcpend->conn;
>> +	struct smc_buf_desc *sndbuf_desc;
>> 	struct smc_sock *smc;
>> 	int diff;
>>
>> +	sndbuf_desc = conn->sndbuf_desc;
>> 	smc = container_of(conn, struct smc_sock, conn);
>> 	bh_lock_sock(&smc->sk);
>> -	if (!wc_status) {
>> -		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
>> +	if (!wc_status && sndbuf_desc) {
>> +		diff = smc_curs_diff(sndbuf_desc->len,
>> 				     &cdcpend->conn->tx_curs_fin,
>> 				     &cdcpend->cursor);
>> 		/* sndbuf_space is decreased in smc_sendmsg */
>> @@ -114,9 +116,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
>> 	union smc_host_cursor cfed;
>> 	int rc;
>>
>> -	if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
>> -		return -ENOBUFS;
>> -
>> 	smc_cdc_add_pending_send(conn, pend);
>>
>> 	conn->tx_cdc_seq++;
>> -- 
>> 1.8.3.1


