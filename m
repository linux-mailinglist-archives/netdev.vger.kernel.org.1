Return-Path: <netdev+bounces-55778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48CA80C4AB
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26CE1C2090D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069321360;
	Mon, 11 Dec 2023 09:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05DB3;
	Mon, 11 Dec 2023 01:32:16 -0800 (PST)
X-UUID: 90c14759aec244f18e5f35bca88012e0-20231211
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:50c7ce0a-480d-4ee8-af05-9623a3f8ed38,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.33,REQID:50c7ce0a-480d-4ee8-af05-9623a3f8ed38,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:bc2809bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:231211151625B9OJXTLD,BulkQuantity:4,Recheck:0,SF:17|19|44|64|66|38|2
	4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 90c14759aec244f18e5f35bca88012e0-20231211
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1128353985; Mon, 11 Dec 2023 17:32:02 +0800
Message-ID: <3231a5d7-29bc-4464-a26c-803b95774f86@kylinos.cn>
Date: Mon, 11 Dec 2023 17:32:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ice: Fix some null pointer dereference issues in
 ice_ptp.c
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jacob.e.keller@intel.com,
 karol.kolacinski@intel.com
Cc: michal.michalik@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211062649.247148-1-chentao@kylinos.cn>
 <447d130a-e1ac-02f6-e168-b04bfa9c6004@intel.com>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <447d130a-e1ac-02f6-e168-b04bfa9c6004@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for your suggestion.

I made the patch based on linux-next.git(tag:next-20231211).

Our code is just self-similar, i didn't override the old name.
I keep the logic as it was before.
The newest code is:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/ethernet/intel/ice/ice_ptp.c#n2747

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/ethernet/intel/ice/ice_ptp.c#n2993

I'll update v2 patch with:
1. update suject prefix to "[PATCH v2 iwl-next]"
2. remove 'dev_err'


Thanks again,
Kunwu

On 2023/12/11 15:15, Przemek Kitszel wrote:
> On 12/11/23 07:26, Kunwu Chan wrote:
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
>> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> I would suggest adding "iwl-net" as a target here
> 
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c 
>> b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 1eddcbe89b0c..59794ce4f243 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2668,6 +2668,8 @@ static int ice_ptp_register_auxbus_driver(struct 
>> ice_pf *pf)
>>       name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>>                     pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>>                     ice_get_ptp_src_clock_index(&pf->hw));
>> +    if (!name)
>> +        return -ENOMEM;
>>       aux_driver->name = name;
>>       aux_driver->shutdown = ice_ptp_auxbus_shutdown;
>> @@ -2929,6 +2931,10 @@ static int ice_ptp_create_auxbus_device(struct 
>> ice_pf *pf)
>>       name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>>                     pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>>                     ice_get_ptp_src_clock_index(&pf->hw));
>> +    if (!name) {
>> +        dev_err(dev, "Failed to allocate memory\n");
> 
> Kuba @ [1]:
> no warnings on allocation failures, there will be a splat for GFP_KERNEL
> (checkpatch should catch this)
> 
> [1] https://lore.kernel.org/netdev/20231206195304.6226771d@kernel.org/T/
> 
> so just "return -ENOMEM" would be sufficient
> 
>> +        return -ENOMEM;
>> +    }
>>       aux_dev->name = name;
>>       aux_dev->id = id;
> 
> I didn't checked but having same code in two places raises questions.
> Are you overwriting old name here, or our code is just self similar?

