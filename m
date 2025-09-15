Return-Path: <netdev+bounces-222975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F87B575C0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC017FB11
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE82FB09D;
	Mon, 15 Sep 2025 10:12:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4662FABED
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931144; cv=none; b=fgYnU2TvDcz3XnrsfLAsKWIyscyhsL3FcxWmLuiZIagE0537YOhcuhtj3V0p8rNVR5Vz36yOHIz0dw75CnVe9gc7PtOlc7WdGsnyq85WIXo28ETgeBJMs6oneca5d4yxixLvzwx61WzrCKBogYOtZxOY/xAvJM4aJKuAI2ypS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931144; c=relaxed/simple;
	bh=vIUYP9BX5rUWQSuXHG3gQWK6hZeuVQ8Jp+KcBeZYm8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLtIgRjYLiX9uAV6GEb/Et/IXaais2mAlovYHRzvilT1vAI9Dp/HCFvTGBetuvvS/ZmhqSH3EYZ6XMCWyIr8qwNTvF4j6+eEws8kHKF/esIoECxofXepl0Ta1nMECCdCffqQqQ4xzqLCvqNIgHfKUxYuMaFkPd/goiMwunA3YXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9E4CB6028F364;
	Mon, 15 Sep 2025 12:12:03 +0200 (CEST)
Message-ID: <015b02e3-a9b7-4f4f-99da-fdf9bd1f8202@molgen.mpg.de>
Date: Mon, 15 Sep 2025 12:12:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] iavf: fix proper type for
 error code in iavf_resume()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
References: <20250912080208.1048019-1-aleksandr.loktionov@intel.com>
 <8c3d7bc5-7269-4c8c-922d-7d6013ac51cb@molgen.mpg.de>
 <679b3ad8-91fd-4570-9e63-c6c5e22a8820@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <679b3ad8-91fd-4570-9e63-c6c5e22a8820@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Przemek,


Thank you for your quick reply.

Am 15.09.25 um 11:58 schrieb Przemek Kitszel:
> On 9/15/25 11:12, Paul Menzel wrote:

>> Am 12.09.25 um 10:02 schrieb Aleksandr Loktionov:
>>> The variable 'err' in iavf_resume() is used to store the return value
>>> of different functions, which return an int. Currently, 'err' is
>>> declared as u32, which is semantically incorrect and misleading.
>>>
>>> In the Linux kernel, u32 is typically reserved for fixed-width data
>>> used in hardware interfaces or protocol structures. Using it for a
>>> generic error code may confuse reviewers or developers into thinking
>>> the value is hardware-related or size-constrained.
>>>
>>> Replace u32 with int to reflect the actual usage and improve code
>>> clarity and semantic correctness.
>>
>> Why not use `unsigned int`?
> 
> I don't think we need to provide rationale for "kernel has adopted
> a long standing practice of encoding errors as negative integer codes"
> each time we change a type, IOW it's too basic thing to mention.

Well, if it was unsigned before, than apparently no negative values were 
ever returned.

>>> No functional change.
>>>
>>> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>>   drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/ 
>>> net/ethernet/intel/iavf/iavf_main.c
>>> index 69054af..c2fbe44 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> @@ -5491,7 +5491,7 @@ static int iavf_resume(struct device *dev_d)
>>>   {
>>>       struct pci_dev *pdev = to_pci_dev(dev_d);
>>>       struct iavf_adapter *adapter;
>>> -    u32 err;
>>> +    int err;
>>>       adapter = iavf_pdev_to_adapter(pdev);
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Thank you

Actually looking at the involved functions

     err = iavf_set_interrupt_capability(adapter);
     […]
     err = iavf_request_misc_irq(adapter);

they return (signed) integer, so in my opinion, this is the actual 
motivation for the change, and it’d be great, if the commit message 
could be amended accordingly.


Kind regards,

Paul

