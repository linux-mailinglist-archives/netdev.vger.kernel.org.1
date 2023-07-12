Return-Path: <netdev+bounces-17152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3951E750993
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3750F1C20FAD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C62AB48;
	Wed, 12 Jul 2023 13:28:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC13FFE
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:28:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2C10E2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689168507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7K0H5POP60sFYme1KxrNOYaNnScjsc3LiRMbZwFElw=;
	b=Xi/JO3YFkpTQP6pb1CcxqXT0xjhLyDLzXeRK1PJryuT7O1GXNqQsSe7W6Vas4W7CygzBwL
	VzpUtiQNaBRmMZLcqncZ46zqvyc+CfM2Go0kRWmtsHEnqaZzoQsgvFJ4hHX9UcNwDr8z0o
	0iLPYsUQzaVDb3a1a8Gg55Na/QZwOLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-Z0HK6wmzPJSHIRAmB1vo8A-1; Wed, 12 Jul 2023 09:28:24 -0400
X-MC-Unique: Z0HK6wmzPJSHIRAmB1vo8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DD618EBBA3;
	Wed, 12 Jul 2023 13:28:23 +0000 (UTC)
Received: from [10.45.225.8] (unknown [10.45.225.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F4EA40C2063;
	Wed, 12 Jul 2023 13:28:22 +0000 (UTC)
Message-ID: <dc1fecb7-d144-fe8b-acb5-91510fcc7848@redhat.com>
Date: Wed, 12 Jul 2023 15:28:21 +0200
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
To: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 Ma Yuying <yuma@redhat.com>, Simon Horman <simon.horman@corigine.com>,
 Rafal Romanowski <rafal.romanowski@intel.com>
References: <20230710164030.2821326-1-anthony.l.nguyen@intel.com>
 <20230710164030.2821326-2-anthony.l.nguyen@intel.com>
 <20230711120904.GP41919@unreal> <20230711173731.54b9fa80@kernel.org>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20230711173731.54b9fa80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12. 07. 23 2:37, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 15:09:04 +0300 Leon Romanovsky wrote:
>>> +	for (i = 0; i < 15; i++) {
>>> +		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
>>> +			return true;
>>> +
>>> +		msleep(20);
>>> +	}
>>> +
>>> +	dev_err(&vf->pf->pdev->dev, "VF %d still in reset. Try again.\n",
>>> +		vf->vf_id);
>>
>> This error is not accurate in the edge case, when VF state changed to
>> be INIT during msleep() while i was 14.
> 
> Right, it's a change in behavior from existing code,
> old code re-checked if INIT is set after the last sleep.

I will simplify this and add an extra check.

Thanks for the review..

I.


