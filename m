Return-Path: <netdev+bounces-35728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3827AAB73
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 10:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id C60611F223CA
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1080D1DDC3;
	Fri, 22 Sep 2023 08:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609E14F81
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 08:05:29 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727311B7;
	Fri, 22 Sep 2023 01:05:26 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VscdTnn_1695369923;
Received: from 30.221.128.225(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VscdTnn_1695369923)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 16:05:23 +0800
Message-ID: <2c9d570c-f780-0484-a26c-78b115e1a6a3@linux.alibaba.com>
Date: Fri, 22 Sep 2023 16:05:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 01/18] net/smc: decouple ism_dev from SMC-D
 device dump
To: Simon Horman <horms@kernel.org>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
 <1695134522-126655-2-git-send-email-guwen@linux.alibaba.com>
 <20230921204153.GQ224399@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20230921204153.GQ224399@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/22 04:41, Simon Horman wrote:
> On Tue, Sep 19, 2023 at 10:41:45PM +0800, Wen Gu wrote:
>> This patch helps to decouple ISM device from SMC-D device, allowing
>> different underlying device forms, such as virtual ISM devices.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_ism.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
>> index fbee249..0045fee 100644
>> --- a/net/smc/smc_ism.c
>> +++ b/net/smc/smc_ism.c
>> @@ -230,12 +230,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>>   	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>>   	struct smc_pci_dev smc_pci_dev;
>>   	struct nlattr *port_attrs;
>> +	struct device *priv_dev;
>>   	struct nlattr *attrs;
>> -	struct ism_dev *ism;
>>   	int use_cnt = 0;
>>   	void *nlh;
>>   
>> -	ism = smcd->priv;
>>   	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
>>   			  &smc_gen_nl_family, NLM_F_MULTI,
>>   			  SMC_NETLINK_GET_DEV_SMCD);
>> @@ -250,7 +249,10 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>>   	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
>>   		goto errattr;
>>   	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
> 
> Hi Wen Gu,
> 
> priv_dev is uninitialised here.
> 
>> -	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
>> +	if (smcd->ops->get_dev)
>> +		priv_dev = smcd->ops->get_dev(smcd);
> 
> It is conditionally initialised here.
> 
>> +	if (priv_dev->parent)
> 
> But unconditionally dereferenced here.
> 
> As flagged by clang-16 W=1, and Smatch
> 

Hi Simon. Yes, I fixed it in v3. Thank you!

>> +		smc_set_pci_values(to_pci_dev(priv_dev->parent), &smc_pci_dev);
>>   	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>>   		goto errattr;
>>   	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
>> -- 
>> 1.8.3.1
>>
>>

