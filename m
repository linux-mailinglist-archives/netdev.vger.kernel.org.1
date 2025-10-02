Return-Path: <netdev+bounces-227549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4715BB2A8F
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 09:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C78E188940E
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 07:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549EC1E1A3B;
	Thu,  2 Oct 2025 07:07:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58EA59
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759388844; cv=none; b=Pad4f/0P7Pci737szP54ty04Ox2ivpzGUsnz9hFWvhJzlWGjrdQzBYJ/r7PiA9+JXsMdVhKJj/O6HYyHZPcRAvC9PNaKlSG3TNF7eEr6M9t2hJprWVg9GuJW0cgnZAbjFnlpeAwV2UKZ7JNs4Ysx2yNOuWgTvFyOyWVgjCjYYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759388844; c=relaxed/simple;
	bh=3mjrPKAz4c+KE+in1OXYMJVsP3rIqSikUVXvPk0p5Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRcNjbnSAzrjnLujs9+sPoi6vHlVlUedx4Gj631OLjQ6cfO6QXWR51p1h7saihXWcyYXmkWC73Pv/E5EjGV5sw9tGWscU6nnp6+xhA+ZLoMPuVjNiGN5YHs1xqCr5xew3V5qh5gm8ZRnKXRQ3QE6IC7KKI+gtW+sL0m8gHQuaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5dc550fa.dip0.t-ipconnect.de [93.197.80.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 693E86028F34B;
	Thu, 02 Oct 2025 09:06:26 +0200 (CEST)
Message-ID: <c86bccd6-9e9e-4355-8e3b-81df181d3c44@molgen.mpg.de>
Date: Thu, 2 Oct 2025 09:06:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbe: avoid redundant call to
 ixgbe_non_sfp_link_config()
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Jacob E Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Alok Tiwari <alok.a.tiwari@oracle.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: Anthony L Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20250924193403.360122-1-alok.a.tiwari@oracle.com>
 <20250925102329.GE836419@horms.kernel.org>
 <a7b1bc0a-26f0-4256-b52f-3580711be98f@intel.com>
 <PH0PR11MB59024649641B7ACB09ACD402F01AA@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <PH0PR11MB59024649641B7ACB09ACD402F01AA@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Alok, dear Simon, dear Jake, dear Jedrzej,


Thank you for your patch and review.

Am 30.09.25 um 10:33 schrieb Jagielski, Jedrzej:
> From: Keller, Jacob E
> Sent: Tuesday, September 30, 2025 1:04 AM
>> On 9/25/2025 3:23 AM, Simon Horman wrote:
>>> On Wed, Sep 24, 2025 at 12:33:54PM -0700, Alok Tiwari wrote:
>>>> ixgbe_non_sfp_link_config() is called twice in ixgbe_open()
>>>> once to assign its return value to err and again in the
>>>> conditional check. This patch uses the stored err value
>>>> instead of calling the function a second time. This avoids
>>>> redundant work and ensures consistent error reporting.

Using 75/75 characters per line would save a line.

Also, following up on the discussion, resending the patch with a 
comment, that calling this twice was not done intentionally would be great.

>>>> Also fix a small typo in the ixgbe_remove() comment:
>>>> "The could be caused" -> "This could be caused".

Personally I prefer separate patches for such things, making reverting 
easier.

>>>> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>> index 90d4e57b1c93..39ef604af3eb 100644
>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>>> @@ -7449,7 +7449,7 @@ int ixgbe_open(struct net_device *netdev)
>>>>   					 adapter->hw.link.link_info.link_cfg_err);
>>>>   
>>>>   		err = ixgbe_non_sfp_link_config(&adapter->hw);
>>>> -		if (ixgbe_non_sfp_link_config(&adapter->hw))
>>>> +		if (err)
>>>>   			e_dev_err("Link setup failed, err %d.\n", err);
>>>>   	}
>>>>   
>>>
>>> I am wondering if there is some intended side-effect of
>>> calling ixgbe_non_sfp_link_config() twice.
>>>
>>
>> Good question.
>>
>> It looks like this was introduced by 4600cdf9f5ac ("ixgbe: Enable link
>> management in E610 device") which added the calls to ixgbe_open. Of
>> interest, we do also call this function in ixgbe_up_complete which is
>> called by ixgbe_open, but only if ixgbe_is_sfp() is false. Not sure why
>> E610 needs special casing here.
>>
>> I don't see a reason we need two calls, it looks redundant, and even if
>> it has some necessary side effect.. that should at least deserve a
>> comment explaining why.
>>
>> Hopefully someone from the ixgbe team can pipe in and explain or ACK
>> this change.
> 
> Thanks for your vigilance! :) but i am afraid there is no reason for
> having it doubled here
> 
> Unfortunately it looks like it has been introduced by mistake
> and is indeed redundant.
> 
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

With the comments above addressed:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

