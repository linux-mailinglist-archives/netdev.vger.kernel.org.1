Return-Path: <netdev+bounces-48113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54827EC924
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72B81C208A3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE7433063;
	Wed, 15 Nov 2023 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btjtdVd1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE12EB18
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:01:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D019E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700067709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L79P9mU6uMtA5BVIKvZRb2x0oslwt8sbrqaeDExdV6s=;
	b=btjtdVd1tk3abJohWnz1VCSEGjQxOgF7qw8/BUL0glo6C1TAPcJ9EQI0D0Qevwn7G080aH
	xUhxAUaSVEtMYEOljPwmPdomjDzr5LqyPfpj2ofDsQQKoemrn8CaCmntqizmec1FO30oOY
	CHJ4vWeZypgKsPA7nryoi+FofUxSiCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-PYBy6ho4NKS4WAf1KUKUZw-1; Wed, 15 Nov 2023 12:01:48 -0500
X-MC-Unique: PYBy6ho4NKS4WAf1KUKUZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CDFD810FCA;
	Wed, 15 Nov 2023 17:01:47 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EBFC492BFD;
	Wed, 15 Nov 2023 17:01:45 +0000 (UTC)
Message-ID: <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
Date: Wed, 15 Nov 2023 18:01:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 13. 11. 23 14:27, Wojciech Drewek wrote:
> 
> On 13.11.2023 13:58, Ivan Vecera wrote:
>> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
>> VEB or VSI by their SEID value and use these helpers to replace
>> existing open-coded loops.
>>
>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> ---
> Only one nit
> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
> 
>>   drivers/net/ethernet/intel/i40e/i40e.h        | 34 +++++++++
>>   .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++--------
>>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 76 ++++++-------------
>>   3 files changed, 64 insertions(+), 84 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>> index 1e9266de270b..220b5ce31519 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
>>   
>>   struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>>   
>> +/**
>> + * i40e_vsi_get_by_seid - find VSI by SEID
>> + * @pf: pointer to a PF
>> + **/
>> +static inline struct i40e_vsi *
>> +i40e_vsi_get_by_seid(struct i40e_pf *pf, u16 seid)
>> +{
>> +	struct i40e_vsi *vsi;
>> +	int i;
>> +
>> +	i40e_pf_for_each_vsi(pf, i, vsi)
>> +		if (vsi->seid == seid)
>> +			return vsi;
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * i40e_veb_get_by_seid - find VEB by SEID
>> + * @pf: pointer to a PF
>> + **/
>> +static inline struct i40e_veb *
>> +i40e_veb_get_by_seid(struct i40e_pf *pf, u16 seid)
>> +{
>> +	struct i40e_veb *veb;
>> +	int i;
>> +
>> +	i40e_pf_for_each_veb(pf, i, veb)
>> +		if (veb->seid == seid)
>> +			return veb;
>> +
>> +	return NULL;
>> +}
> I would prefer i40e_get_{veb|vsi}_by_seid but it's my opinion.

I'd rather use i40e_pf_ prefix...

What about i40e_pf_get_vsi_by_seid() and i40e_pf_get_veb_by_seid() ?

Ivan


