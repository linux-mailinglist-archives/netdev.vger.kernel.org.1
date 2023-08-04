Return-Path: <netdev+bounces-24266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC46876F8AF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 05:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DE4282449
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 03:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C41878;
	Fri,  4 Aug 2023 03:59:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BC15D0
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 03:59:12 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BE2D69;
	Thu,  3 Aug 2023 20:59:09 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vp-rj4V_1691121545;
Received: from 30.221.100.251(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vp-rj4V_1691121545)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 11:59:06 +0800
Message-ID: <995aeae7-86f5-494a-3f7a-1fcc32f27181@linux.alibaba.com>
Date: Fri, 4 Aug 2023 11:59:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH net-next 1/6] net/smc: support smc release version
 negotiation in clc handshake
To: Simon Horman <horms@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
 tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-2-guangguan.wang@linux.alibaba.com>
 <ZMvnIszqS4ZpkYHj@kernel.org>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <ZMvnIszqS4ZpkYHj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Simon,

Thanks for the review.

Before this patch set, the ini pointer is NULL when sending accept clc msg. This patch set
has changed the ini pointer to non-NULL value both when sending accept clc msg and when
sending confirm clc msg. And the ini pointer in smc_clc_send_confirm_accept will not be NULL
any more.

I will remove the ini NULL check in the next version.
if (ini && clc->hdr.type == SMC_CLC_CONFIRM) => if (clc->hdr.type == SMC_CLC_CONFIRM)

Thanks,
Guangguan Wang

On 2023/8/4 01:42, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 09:24:17PM +0800, Guangguan Wang wrote:
> 
> ...
> 
> Hi Guangguan Wang,
> 
>> @@ -1063,7 +1063,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>>  				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
>>  			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
>>  			if (first_contact) {
>> -				smc_clc_fill_fce(&fce, &len);
>> +				smc_clc_fill_fce(&fce, &len, ini->release_ver);
> 
> Here ini is dereferenced...
> 
> 
>>  				fce.v2_direct = !link->lgr->uses_gateway;
>>  				memset(&gle, 0, sizeof(gle));
>>  				if (ini && clc->hdr.type == SMC_CLC_CONFIRM) {
> 
> ... but here it is assumed that ini may be NULL.
> 
> This seems inconsistent.
> 
> As flagged by Smatch.
> 
> ...
> 

