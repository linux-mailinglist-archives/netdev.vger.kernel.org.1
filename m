Return-Path: <netdev+bounces-17149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D4750975
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD111C20D85
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C532AB44;
	Wed, 12 Jul 2023 13:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AF1F923
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:18:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178601736
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689167915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZ9jbrL7ChxPnbNJWeExyxNwGNiOqBVO5rf0E7pvFGA=;
	b=SvGQPPVPD9XtcqqRKTk9I2i0JP6U4RS4Q8tib5fDoStEf5nH7vu7SgNbW9V62KjG3Km6Jg
	3/G+d/0SKUrDWHZ3uC0UoVonuJU0IwF7fLwzwcypwbjLvd32fcK0n00keG4Bl7BmexQklN
	11IuR3LzQdPMPIpyNS7xvSyEu2f0v3Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-HLZlD_h1NYSyxCJ9qcGwzA-1; Wed, 12 Jul 2023 09:18:32 -0400
X-MC-Unique: HLZlD_h1NYSyxCJ9qcGwzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D3543C025AD;
	Wed, 12 Jul 2023 13:18:31 +0000 (UTC)
Received: from [10.45.225.8] (unknown [10.45.225.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC4924028AB7;
	Wed, 12 Jul 2023 12:40:23 +0000 (UTC)
Message-ID: <cd7a39b2-c73e-6919-7ae5-5a2cea5a3ed9@redhat.com>
Date: Wed, 12 Jul 2023 15:18:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] i40e: Add helper for VF inited state check
 with timeout
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, Ma Yuying <yuma@redhat.com>,
 Simon Horman <simon.horman@corigine.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
 <20230710164030.2821326-2-anthony.l.nguyen@intel.com>
 <20230711120904.GP41919@unreal>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20230711120904.GP41919@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11. 07. 23 14:09, Leon Romanovsky wrote:
> On Mon, Jul 10, 2023 at 09:40:29AM -0700, Tony Nguyen wrote:
>> From: Ivan Vecera <ivecera@redhat.com>
>>
>> Move the check for VF inited state (with optional up-to 300ms
>> timeout to separate helper i40e_check_vf_init_timeout() that
>> will be used in the following commit.
>>
>> Tested-by: Ma Yuying <yuma@redhat.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 47 ++++++++++++-------
>>   1 file changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> index be59ba3774e1..b84b6b675fa7 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> @@ -4304,6 +4304,36 @@ static int i40e_validate_vf(struct i40e_pf *pf, int vf_id)
>>   	return ret;
>>   }
>>   
>> +/**
>> + * i40e_check_vf_init_timeout
>> + * @vf: the virtual function
>> + *
>> + * Check that the VF's initialization was successfully done and if not
>> + * wait up to 300ms for its finish.
>> + *
>> + * Returns true when VF is initialized, false on timeout
>> + **/
>> +static bool i40e_check_vf_init_timeout(struct i40e_vf *vf)
>> +{
>> +	int i;
>> +
>> +	/* When the VF is resetting wait until it is done.
>> +	 * It can take up to 200 milliseconds, but wait for
>> +	 * up to 300 milliseconds to be safe.
>> +	 */
>> +	for (i = 0; i < 15; i++) {
>> +		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
>> +			return true;
>> +
>> +		msleep(20);
>> +	}
>> +
>> +	dev_err(&vf->pf->pdev->dev, "VF %d still in reset. Try again.\n",
>> +		vf->vf_id);
> 
> This error is not accurate in the edge case, when VF state changed to
> be INIT during msleep() while i was 14.
> 
> Thanks

Would you like to add an extra check after the cycle or just increase 
limit from 15 to 16 (there will be an extra msleep)...

Ivan
> 
>> +
>> +	return false;
>> +}
>> +
>>   /**
>>    * i40e_ndo_set_vf_mac
>>    * @netdev: network interface device structure
>> @@ -4322,7 +4352,6 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>>   	int ret = 0;
>>   	struct hlist_node *h;
>>   	int bkt;
>> -	u8 i;
>>   
>>   	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
>>   		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
>> @@ -4335,21 +4364,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>>   		goto error_param;
>>   
>>   	vf = &pf->vf[vf_id];
>> -
>> -	/* When the VF is resetting wait until it is done.
>> -	 * It can take up to 200 milliseconds,
>> -	 * but wait for up to 300 milliseconds to be safe.
>> -	 * Acquire the VSI pointer only after the VF has been
>> -	 * properly initialized.
>> -	 */
>> -	for (i = 0; i < 15; i++) {
>> -		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
>> -			break;
>> -		msleep(20);
>> -	}
>> -	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
>> -		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
>> -			vf_id);
>> +	if (!i40e_check_vf_init_timeout(vf)) {
>>   		ret = -EAGAIN;
>>   		goto error_param;
>>   	}
>> -- 
>> 2.38.1
>>
>>
> 


