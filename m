Return-Path: <netdev+bounces-41777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408E47CBE22
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4786B210BD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35E3CD01;
	Tue, 17 Oct 2023 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F0BE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:52:17 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425493;
	Tue, 17 Oct 2023 01:52:15 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuMgVhC_1697532731;
Received: from 30.221.102.81(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VuMgVhC_1697532731)
          by smtp.aliyun-inc.com;
          Tue, 17 Oct 2023 16:52:13 +0800
Message-ID: <e89d6d5d-9fde-43b3-9cbc-ddefe56d188a@linux.alibaba.com>
Date: Tue, 17 Oct 2023 16:52:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: correct the reason code in
 smc_listen_find_device when fallback
Content-Language: en-US
To: dust.li@linux.alibaba.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231016061153.40057-1-guangguan.wang@linux.alibaba.com>
 <20231017073733.GV92403@linux.alibaba.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20231017073733.GV92403@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/10/17 15:37, Dust Li wrote:
> On Mon, Oct 16, 2023 at 02:11:53PM +0800, Guangguan Wang wrote:
> 
> Hi guangguan,
> 
> This patch doesn't apply clearly on net because it conflict with my
> previous patch 4abbd2e3c1db(net/smc: return the right falback reason
> when prefix checks fail), pls rebase.
>

This patch sent before the patch 4abbd2e3c1db applied. I will rebase it
in the next version.
 
>> The function smc_find_ism_store_rc is not only used for ism, so it is
>> reasonable to change the function name to smc_find_device_store_rc.
>>
>> The ini->rc is used to store the last error happened when finding usable
>> ism or rdma device in smc_listen_find_device, and is set by calling smc_
>> find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
>> the value can not be overwritten anymore. So the ini-rc should be set to
>> the error reason only when an error actually occurs.
>>
>> When finding ISM/RDMA devices, device not found is not a real error, as
>> not all machine have ISM/RDMA devices. Failures after device found, when
>> initializing device or when initializing connection, is real errors, and
>> should be store in ini->rc.
>>
>> SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
>> not require same prefix.
> 
> I think it's better to seperate this patch into 2:
> - one for changing the name from smc_find_ism_store_rc to smc_find_device_store_rc.
> - one for fixing the return reason.
> 
> More comments below.
> 
OK, I will seperate it.
>>
>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

>> @@ -2213,11 +2211,12 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
>> 		goto not_found;
>> 	ini->ism_selected = 0;
>> 	rc = smc_listen_ism_init(new_smc, ini);
>> -	if (!rc)
>> +	if (!rc) {
>> +		smc_find_device_store_rc(rc, ini);
> 
> This smc_find_device_store_rc() seems useless when rc == 0 here ?

Oh, I see. The code here should be:

rc = smc_listen_ism_init(new_smc, ini);
if (!rc)
    return;
smc_find_device_store_rc(rc, ini);

not_found:
    ini->smcd_version &= ~SMC_V1;
    ini->ism_dev[0] = NULL;
    ini->is_smcd = false;


Thanks,
Guangguan Wang.
> 
>> 		return;		/* V1 ISM device found */
>> +	}
>>
>> not_found:
>> -	smc_find_ism_store_rc(rc, ini);
>> 	ini->smcd_version &= ~SMC_V1;
>> 	ini->ism_dev[0] = NULL;
>> 	ini->is_smcd = false;


