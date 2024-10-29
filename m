Return-Path: <netdev+bounces-139761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F26D99B3FEE
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B524B21280
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD369D31;
	Tue, 29 Oct 2024 01:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274438385
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166139; cv=none; b=tcu9hWoPqfYMW8R+T9MVDZSOg2mlLYzPL/obWI0oX6fHg+tESKcRhfQ7+lwUWf5TtK/ockRRapMAtVuuiWaVlQufoyqW1YIXsZA6kiMU1YKgTWn5W7s8uHvARM0iucgL6T0tVoRz1x1mTN6lM+bmJyfKgguelKEtDsss6/hZk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166139; c=relaxed/simple;
	bh=+JQheG2BKSZvqInnFo8Nh2ov6fC5mo+UGetUv2cSLQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDU7T1WvEeMgGXZ1ykCL3t4wtq1WtGnNIa7CHDNPRLtvQVMHVrmVEFF+qzdeBJnOFOJByLgoB5c8LQDIYjdTNHEMKG18HvrIPiwN2i1lb2NON5pTbib69Agl4fipvDz6wbJUQqwVgYrK/1IlSJ3jH/k0LFe+9fFSqDc2QVhX1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XctKH39K4z4f3jXh
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:41:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1CC9F1A018D
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:42:13 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDXsoZzPSBn0xTyAA--.21914S2;
	Tue, 29 Oct 2024 09:42:12 +0800 (CST)
Message-ID: <43c68803-89c4-431f-b016-62a6ad68313f@huaweicloud.com>
Date: Tue, 29 Oct 2024 09:42:11 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qed/qed_sriov: avoid null-ptr-deref
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Chen Ridong <chenridong@huaweicloud.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, wangweiyang2@huawei.com
References: <20241025093135.1053121-1-chenridong@huaweicloud.com>
 <116b608e-1ef5-4cc8-95ac-a0a90a8f485f@intel.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <116b608e-1ef5-4cc8-95ac-a0a90a8f485f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXsoZzPSBn0xTyAA--.21914S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4UGr1UGrWrZF4fGF18uFg_yoW8uF1Dpa
	15Wa4q9r4kXF18Aws7Z3W7XFy5tayUtFyqg3Z7ta4rZrZIvryagFyUta45ur1fJFs3CFyY
	vFyjgF1ftF98Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/25 23:28, Alexander Lobakin wrote:
> From: Chen Ridong <chenridong@huaweicloud.com>
> Date: Fri, 25 Oct 2024 09:31:35 +0000
> 
>> [PATCH] qed/qed_sriov: avoid null-ptr-deref
> 
> Use the correct tree prefix, [PATCH net] in your case.
> 

Thanks, will update

>> From: Chen Ridong <chenridong@huawei.com>
> 
> Why do you commit from @huawei.com, but send from @huaweicloud.com?
> 
The @huawei.com is the email I am actually using. But if I use it to
send email, my patches may not appear in maintainers's inbox list. This
won't be happened when I use 'huaweicloud.com' to send emails. So I am
using 'huaweicloud.com' to communicate with community. However, I would
like to maintain the same author identity.

>>
>> The qed_iov_get_public_vf_info may return NULL, which may lead to
>> null-ptr-deref. To avoid possible null-ptr-deref, check vf_info
> 
> Do you have a repro for this or it's purely hypothetical?
> 

I read the code and found that calling qed_iov_get_public_vf_info
without checking whether the 'vfid' is valid  may result in a null
pointer, which may lead to a null pointer dereference.

>> before accessing its member.
>>
> 
> Here you should have a "Fixes:" tag if you believe this is a fix.
> 
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  drivers/net/ethernet/qlogic/qed/qed_sriov.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
>> index fa167b1aa019..30da9865496d 100644
>> --- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
>> +++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
>> @@ -2997,6 +2997,8 @@ static int qed_iov_pre_update_vport(struct qed_hwfn *hwfn,
>>  		return 0;
>>  
>>  	vf_info = qed_iov_get_public_vf_info(hwfn, vfid, true);
>> +	if (!vf_info)
>> +		return 0;
> 
> 0 or error code?

It should return error code after I read the code again.
Thank you very much.

> 
>>  
>>  	if (flags->update_rx_mode_config) {
>>  		vf_info->rx_accept_mode = flags->rx_accept_filter;
> 
> Thanks,
> Olek
> 

Best regards,
Ridong


