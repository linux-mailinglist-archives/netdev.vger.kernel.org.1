Return-Path: <netdev+bounces-48347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FCD7EE20D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7471F23FBD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB1A30FA0;
	Thu, 16 Nov 2023 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF48LOMs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFB5A9
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700143174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcFm4CYE9xVUh7GTYUarkXRDjUbvhgbuzrK/6r8vxYo=;
	b=WF48LOMstUVyq4wQATbA0tuzYjHIB3h7r0mWQXLFCOohY6yXp6I2vUxaSxgNjkzrBxZPGO
	u72qLtgD83aC0iYaDX6AApE29KFSm9u9RakSscRHLSCba4taIgg+Zc0WWBtB6uauFyxA5h
	dVDNgu3zh4YpsPVYNvDSTqmMemiQIC4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-tRuM4eFGNN2-6MYcUchipw-1; Thu,
 16 Nov 2023 08:59:29 -0500
X-MC-Unique: tRuM4eFGNN2-6MYcUchipw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 488243C0F42D;
	Thu, 16 Nov 2023 13:59:28 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B06440C6EBB;
	Thu, 16 Nov 2023 13:59:26 +0000 (UTC)
Message-ID: <483acf53-fe96-4ef3-933a-c5fd446042f6@redhat.com>
Date: Thu, 16 Nov 2023 14:59:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
Content-Language: en-US
To: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 mschmidt@redhat.com
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-4-ivecera@redhat.com>
 <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
 <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
 <72250942-17af-4f8d-b11f-ba902fbe2b58@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <72250942-17af-4f8d-b11f-ba902fbe2b58@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 16. 11. 23 13:37, Wojciech Drewek wrote:
> 
> 
> On 15.11.2023 18:01, Ivan Vecera wrote:
>>
>> On 13. 11. 23 14:27, Wojciech Drewek wrote:
>>>
>>> On 13.11.2023 13:58, Ivan Vecera wrote:
>>>> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
>>>> VEB or VSI by their SEID value and use these helpers to replace
>>>> existing open-coded loops.
>>>>
>>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>>>> ---
>>> Only one nit
>>> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
>>>
>>>>    drivers/net/ethernet/intel/i40e/i40e.h        | 34 +++++++++
>>>>    .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++--------
>>>>    drivers/net/ethernet/intel/i40e/i40e_main.c   | 76 ++++++-------------
>>>>    3 files changed, 64 insertions(+), 84 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>>>> index 1e9266de270b..220b5ce31519 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>>> @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
>>>>      struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>>>>    +/**
>>>> + * i40e_vsi_get_by_seid - find VSI by SEID
>>>> + * @pf: pointer to a PF
>>>> + **/
>>>> +static inline struct i40e_vsi *
>>>> +i40e_vsi_get_by_seid(struct i40e_pf *pf, u16 seid)
>>>> +{
>>>> +    struct i40e_vsi *vsi;
>>>> +    int i;
>>>> +
>>>> +    i40e_pf_for_each_vsi(pf, i, vsi)
>>>> +        if (vsi->seid == seid)
>>>> +            return vsi;
>>>> +
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * i40e_veb_get_by_seid - find VEB by SEID
>>>> + * @pf: pointer to a PF
>>>> + **/
>>>> +static inline struct i40e_veb *
>>>> +i40e_veb_get_by_seid(struct i40e_pf *pf, u16 seid)
>>>> +{
>>>> +    struct i40e_veb *veb;
>>>> +    int i;
>>>> +
>>>> +    i40e_pf_for_each_veb(pf, i, veb)
>>>> +        if (veb->seid == seid)
>>>> +            return veb;
>>>> +
>>>> +    return NULL;
>>>> +}
>>> I would prefer i40e_get_{veb|vsi}_by_seid but it's my opinion.
>>
>> I'd rather use i40e_pf_ prefix...
>>
>> What about i40e_pf_get_vsi_by_seid() and i40e_pf_get_veb_by_seid() ?
> 
> Sounds good, my point was that I prefer to have "get" before "{veb|vsi}"

OK, got it... Will repost v2 with this change + "too many also..." issue ;-)

Btw. what about the last patch?

Ivan


