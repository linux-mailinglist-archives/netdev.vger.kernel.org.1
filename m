Return-Path: <netdev+bounces-49027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8847F0713
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9ED280D2C
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4A134C7;
	Sun, 19 Nov 2023 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D7C138;
	Sun, 19 Nov 2023 07:12:25 -0800 (PST)
X-UUID: 6c250ce1d55348c79c4c5818169f97d0-20231119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:d4da5ac2-ed14-4e38-acb0-0604abae64ca,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:d4da5ac2-ed14-4e38-acb0-0604abae64ca,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:1a5a3a60-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:231119230408XYBZ5UP2,BulkQuantity:1,Recheck:0,SF:19|44|64|66|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 6c250ce1d55348c79c4c5818169f97d0-20231119
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1611530766; Sun, 19 Nov 2023 23:12:10 +0800
Message-ID: <4b551600-f1a3-4efe-b3e9-99cb4536f487@kylinos.cn>
Date: Sun, 19 Nov 2023 23:12:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Use correct buffer size
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: horms@kernel.org, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com, kuba@kernel.org,
 kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shannon.nelson@amd.com
References: <20231113093112.GL705326@kernel.org>
 <20231115031444.33381-1-chentao@kylinos.cn>
 <55e07c56-da57-41aa-bc96-e446fad24276@intel.com>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <55e07c56-da57-41aa-bc96-e446fad24276@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexander,
Thank you so much for your reply, I looked at the modification you 
mentioned, it's really cool. I'll definitely try it next time.

But when using it, will it be easy to forget to free up memory?
Although 'kmalloc_track_caller' is used, according to my understanding, 
it is also necessary to release the memory at the end of use.

On 2023/11/15 23:39, Alexander Lobakin wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> Date: Wed, 15 Nov 2023 11:14:44 +0800
> 
>> The size of "i40e_dbg_command_buf" is 256, the size of "name"
>> depends on "IFNAMSIZ", plus a null character and format size,
>> the total size is more than 256, fix it.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> Suggested-by: Simon Horman <horms@kernel.org>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>> index 999c9708def5..e3b939c67cfe 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>> @@ -72,7 +72,7 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
>>   {
>>   	struct i40e_pf *pf = filp->private_data;
>>   	int bytes_not_copied;
>> -	int buf_size = 256;
>> +	int buf_size = IFNAMSIZ + sizeof(i40e_dbg_command_buf) + 4;
> 
> Reverse Christmas Tree style? Should be the first one in the declaration
> list.
> 
>>   	char *buf;
>>   	int len;
> 
> You can fix it in a different way. Given that there's a kzalloc() either
> way, why not allocate the precise required amount of bytes by using
> kasprintf() instead of kzalloc() + snprintf()? You wouldn't need to
> calculate any buffer sizes etc. this way.
> 
> Thanks,
> Olek

