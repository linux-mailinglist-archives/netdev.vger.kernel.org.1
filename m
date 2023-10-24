Return-Path: <netdev+bounces-43871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7727D50BC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF33B212A2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A9266C4;
	Tue, 24 Oct 2023 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c43WzAGV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78929415
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:01:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BAB10E9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698152469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdTXynsl0mVy35KpmI9bLMXkB0nwWaN15oyfZ6foo9E=;
	b=c43WzAGVnN9/jr4LYieMT77HKdxlsceNjvouqr3faK1rGjLo11KDLco6zxaUlf4n2uQoR2
	mCRU0E2C/AmvP4KB8zxeZsnRBWLcDa5eT9Lic29bzxnYb94NWQwxv5KKPhXOD7jcGCEfUL
	ypeYYjdG5zseyxO+eU0M5s3SUnUQUKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-_Yx9v7gsPGSlGCwy8j95PA-1; Tue, 24 Oct 2023 09:01:07 -0400
X-MC-Unique: _Yx9v7gsPGSlGCwy8j95PA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8EBE857BC5;
	Tue, 24 Oct 2023 13:01:05 +0000 (UTC)
Received: from [10.43.2.183] (unknown [10.43.2.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E865A492BD9;
	Tue, 24 Oct 2023 13:01:03 +0000 (UTC)
Message-ID: <d71f2fa2-e5b7-4221-bbd0-86285b6c1c33@redhat.com>
Date: Tue, 24 Oct 2023 15:01:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] i40e: Add other helpers to
 check version of running firmware and AQ API
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20231023162928.245583-1-ivecera@redhat.com>
 <20231023162928.245583-3-ivecera@redhat.com>
 <2aba9a2d-9dfd-49f2-bfec-1ff563a5f017@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <2aba9a2d-9dfd-49f2-bfec-1ff563a5f017@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9



On 24. 10. 23 12:24, Wojciech Drewek wrote:
> On 23.10.2023 18:29, Ivan Vecera wrote:
>> Add another helper functions that will be used by subsequent
>> patch to refactor existing open-coded checks whether the version
>> of running firmware and AdminQ API is recent enough to provide
>> certain capabilities.
>>
>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_type.h | 54 +++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> index 050d479aeed3..bb62c14aa3d4 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> @@ -608,6 +608,60 @@ static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
>>   		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
>>   }
>>   
>> +/**
>> + * i40e_is_aq_api_ver_lt
>> + * @hw: pointer to i40e_hw structure
>> + * @maj: API major value to compare
>> + * @min: API minor value to compare
>> + *
>> + * Assert whether current HW API version is less than provided.
>> + **/
>> +static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
>> +{
>> +	return !i40e_is_aq_api_ver_ge(hw, maj, min);
>> +}
> It feels a bit off to have those helpers in i40e_type.h.
> We don't have i40e_common.h though so I'd move them to i40e_prototype.h or i40e.h.
> Same comment regarding 1st patch (I know I gave it my tag but I spotted the issue
> while reading the 2nd patch).

I'm sorry I already submitted v2 and helpers are present i40e_type.h.
I would submit v3 but there is also i40e_is_vf() inline function already 
present in i40e_type. Would you be OK with a follow-up that would move 
all these inlines into i40e_prototype.h?

Btw i40e.h is not a good idea as this would bring a dependency on i40e.h 
into i40e_adminq.c, i40e_common.c and i40e_dcb.c.

Regards,
Ivan


