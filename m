Return-Path: <netdev+bounces-28309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2431477EF7F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D31A1C212B0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A0659;
	Thu, 17 Aug 2023 03:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5BC639
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:23:20 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659D26BC;
	Wed, 16 Aug 2023 20:23:18 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpyCdS._1692242593;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpyCdS._1692242593)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 11:23:14 +0800
Message-ID: <e6a97304-801d-476c-f8cf-9828175aaf34@linux.alibaba.com>
Date: Thu, 17 Aug 2023 11:23:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 2/6] net/smc: add vendor unique experimental
 options area in clc handshake
Content-Language: en-US
To: Jan Karcher <jaka@linux.ibm.com>, wenjia@linux.ibm.com,
 kgraul@linux.ibm.com, tonylu@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-3-guangguan.wang@linux.alibaba.com>
 <dc94f888-971b-dbc2-d417-9e14734266fc@linux.ibm.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <dc94f888-971b-dbc2-d417-9e14734266fc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/17 05:49, Jan Karcher wrote:
> Hi Guangguan Wang,
> 
> thank you, some minor thoughts on this one.
> 
> On 16/08/2023 10:33, Guangguan Wang wrote:
...
>>   -static void smc_clc_fill_fce(struct smc_clc_first_contact_ext *fce, int *len, int release_nr)
>> +static int smc_clc_fill_fce(struct smc_clc_first_contact_ext_v2x *fce,
>> +                struct smc_init_info *ini)
>>   {
>> +    int ret = sizeof(*fce);
>> +
>>       memset(fce, 0, sizeof(*fce));
>> -    fce->os_type = SMC_CLC_OS_LINUX;
>> -    fce->release = release_nr;
>> -    memcpy(fce->hostname, smc_hostname, sizeof(smc_hostname));
>> -    (*len) += sizeof(*fce);
>> +    fce->fce_v20.os_type = SMC_CLC_OS_LINUX;
>> +    fce->fce_v20.release = ini->release_nr;
> 
> I don't like that this is called fce_v20.release which can be set to v2.1 here although the struct is named v20. Maybe let us call the struct something like fce_v2_base or fce_base_v2.
> 

fce_v2_base sounds better.


>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>> index b923e89acafb..6133276a8839 100644
>> --- a/net/smc/smc_clc.h
>> +++ b/net/smc/smc_clc.h
>> @@ -147,7 +147,9 @@ struct smc_clc_msg_proposal_prefix {    /* prefix part of clc proposal message*/
>>   struct smc_clc_msg_smcd {    /* SMC-D GID information */
>>       struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
>>       __be16 v2_ext_offset;    /* SMC Version 2 Extension Offset */
>> -    u8 reserved[28];
>> +    u8 vendor_oui[3];
>> +    u8 vendor_exp_options[5];
>> +    u8 reserved[20];
> 
> Could we either make those variables a bit more self explaining via their name (e.g. vendor_organization_uid) or adding a comment /* vendor organizationally unique identifier */
> 

I will fix it in the next version.

>>   };
>>     struct smc_clc_smcd_v2_extension {
>> @@ -231,8 +233,17 @@ struct smc_clc_first_contact_ext {
>>       u8 hostname[SMC_MAX_HOSTNAME_LEN];
>>   };
>>   +struct smc_clc_first_contact_ext_v2x {
>> +    struct smc_clc_first_contact_ext fce_v20;
> 
> as stated at the top where the release is assigned i'm not completly happy with the naming.
> 

Thanks,
Guangguan Wang

