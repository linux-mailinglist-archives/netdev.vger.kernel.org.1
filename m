Return-Path: <netdev+bounces-140462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1209B695E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A81281D9E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E82144CA;
	Wed, 30 Oct 2024 16:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDB2144D8
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306313; cv=none; b=sw687gn4W/n0M1H2ooi8cAJz+fam6i3syHPVNRlxAgn1Nbmn1ogu8pjH4WRSS2wwRrPW9FxGrvnC1RMvN+iCPmNkpYhgdyQyjCICNRlXXGArSvDKG61FFbkQqpLPEt2TYK9p/Iy3NvWMhKxxqT/4jBXAQogabBsKWcKbrNbK0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306313; c=relaxed/simple;
	bh=Xx6/PgClTiin9tGh4+3BFGBstnAR4a3zTHTCiegISpc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RF8QmsZ7fQMuxYd0UJL6qCfHtSE3nGp8IZ8k3rqHMT6fRETMoeH8OAb9hrct/elQ+6DnuLmudkgijFWT26VXh7By08ypS7W91t3nwssDaT2ecy57juHEVod01oQfUdLOs+dl15RivuWZ9UJ1/66eQGKSi5eRJPByWt9XpaXsqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C478F600AA69C;
	Wed, 30 Oct 2024 17:38:12 +0100 (CET)
Message-ID: <cf6dd743-759e-4db9-8811-fd1520262412@molgen.mpg.de>
Date: Wed, 30 Oct 2024 17:38:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix handling changed priv
 flags
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: =?UTF-8?Q?Peter_Gro=C3=9Fe?= <pegro@friiks.de>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20241030160643.9950-1-pegro@friiks.de>
 <fa6a5bf6-5401-48d9-bda6-08d17c0bad68@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <fa6a5bf6-5401-48d9-bda6-08d17c0bad68@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: -Jesse 550 #5.1.0 Address rejected.]

Am 30.10.24 um 17:34 schrieb Paul Menzel:
> [Cc: +Przemek who succeeded Jesse]
> 
> Dear Peter,
> 
> 
> Thank you very much for your patch. Some minor comments.
> 
> Am 30.10.24 um 17:06 schrieb pegro@friiks.de:
>> From: Peter Große <pegro@friiks.de>
>>
>> After assembling the new private flags on a PF, the operation to determine
>> the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags with
>> new_flags, it uses the still unchanged pf->flags, thus changed_flags is always 0.
> 
> It’d be great if you reflowed for 75 characters per line.
> 
>> Fix it by using the corrent bitmaps.
> 
> corre*c*t
> 
>> The issue was discovered while debugging why disabling source pruning
>> stopped working with release 6.7. Although the new flags will be copied to
>> pf->flags later on in that function, source pruning requires a reset of the PF,
>> which was skipped due to this bug.
> 
> If you have the actual commands handy to reproduce it, that’d be great 
> to have in the commit message.
> 
>> Fixes: 70756d0a4727 ("i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf")
>> Signed-off-by: Peter Große <pegro@friiks.de>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/ 
>> net/ethernet/intel/i40e/i40e_ethtool.c
>> index c841779713f6..016c0ae6b36f 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> @@ -5306,7 +5306,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
>>       }
>>   flags_complete:
>> -    bitmap_xor(changed_flags, pf->flags, orig_flags, I40E_PF_FLAGS_NBITS);
>> +    bitmap_xor(changed_flags, new_flags, orig_flags, I40E_PF_FLAGS_NBITS);
>>       if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
>>           reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
> 
> With the style fixes above:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

