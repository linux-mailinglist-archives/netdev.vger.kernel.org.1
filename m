Return-Path: <netdev+bounces-140221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B431F9B58FF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FC61F24051
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9842A8B;
	Wed, 30 Oct 2024 01:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C61773A
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251030; cv=none; b=WSibsISEwE0S1ITHqtmFNPEMM9/Wbiq03ughXETPnkgFwRks/3ZWwa999OzFhagDi+UzryTPsLskVXPgJJn6JF+inBH3H+35/kzLVAtZ/cXiEjGZOFbVE87/f+20xVgy0RUQ/0yz6HXipkGK1gZqZomG7FcMJAo50pI6USo1mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251030; c=relaxed/simple;
	bh=c23u1baf7tNUISYymO0T7ibON/nMCMzKfZj7UGOE/lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoVAYmJ+a+OqWEXqDsB/PY/mM6q59P/3wKgAmSJZkNBas6j4FJmL8/xfnsjo599rYhdxak9R3CZzAWy05waIc0vQQlSjUe4MaYFQ5LyiUkYr0dl5AmDj+YjDubxxYZhqoQSET40C11Yopdz0lHPMKO7qvlXHnKGidW8ke7WwyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdTjs3JJXz4f3jqW
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 09:16:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0E6501A0568
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 09:17:02 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBH8LEMiSFniytFAQ--.9126S2;
	Wed, 30 Oct 2024 09:17:01 +0800 (CST)
Message-ID: <400ccdf8-9574-4481-b1ad-bc6dca63cffc@huaweicloud.com>
Date: Wed, 30 Oct 2024 09:17:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qed/qed_sriov: avoid null-ptr-deref
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, wangweiyang2@huawei.com
References: <20241025093135.1053121-1-chenridong@huaweicloud.com>
 <116b608e-1ef5-4cc8-95ac-a0a90a8f485f@intel.com>
 <43c68803-89c4-431f-b016-62a6ad68313f@huaweicloud.com>
 <61611603-4dd0-4d75-a0b7-d21299d4610c@intel.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <61611603-4dd0-4d75-a0b7-d21299d4610c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBH8LEMiSFniytFAQ--.9126S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfCr1kAr4DCr15Aw1kZrb_yoW8WF43pa
	15W3Wj9F4DWr18Ar1Iv3W7KFy5tFW8JFyUX3WkJ34FyrnIqry7KFWxK3WUu3W3JF1xC3s0
	qayagFyxta4UXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/29 23:15, Alexander Lobakin wrote:
> From: Chen Ridong <chenridong@huaweicloud.com>
> Date: Tue, 29 Oct 2024 09:42:11 +0800
> 
>>
>>
>> On 2024/10/25 23:28, Alexander Lobakin wrote:
>>> From: Chen Ridong <chenridong@huaweicloud.com>
>>> Date: Fri, 25 Oct 2024 09:31:35 +0000
>>>
>>>> [PATCH] qed/qed_sriov: avoid null-ptr-deref
>>>
>>> Use the correct tree prefix, [PATCH net] in your case.
>>>
>>
>> Thanks, will update
>>
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Why do you commit from @huawei.com, but send from @huaweicloud.com?
>>>
>> The @huawei.com is the email I am actually using. But if I use it to
>> send email, my patches may not appear in maintainers's inbox list. This
>> won't be happened when I use 'huaweicloud.com' to send emails. So I am
>> using 'huaweicloud.com' to communicate with community. However, I would
>> like to maintain the same author identity.
>>
>>>>
>>>> The qed_iov_get_public_vf_info may return NULL, which may lead to
>>>> null-ptr-deref. To avoid possible null-ptr-deref, check vf_info
>>>
>>> Do you have a repro for this or it's purely hypothetical?
>>>
>>
>> I read the code and found that calling qed_iov_get_public_vf_info
>> without checking whether the 'vfid' is valid  may result in a null
>> pointer, which may lead to a null pointer dereference.
> 
> If you want to submit a fix, you need to have a step-by-step manual how
> to reproduce the bug you're fixing.
> 
>>
>>>> before accessing its member.
>>>>
>>>
>>> Here you should have a "Fixes:" tag if you believe this is a fix.
> 
> Thanks,
> Olek

Thanks,
I will try to reproduce this bug.

Best regards,
Ridong


