Return-Path: <netdev+bounces-49982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836C7F4315
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2547FB20DE3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698012111D;
	Wed, 22 Nov 2023 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL+2vsQJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271110C0
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700647141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCjzWXii4u28sN5GkNkdatJx6cXmhKIdL34C9BKN+9E=;
	b=DL+2vsQJ6TwXpENXXY7qbpIt3L8wf+kTgXzMUkvoI8HwzBOwLyfGrvj7Wm75220njJroLg
	SYAJ4Zbm9zEAlpYFEXpdzPLJ2PoR9sQILWzUwndn8ppbr7oJ6gyMDMpDNjGwL3mguIVezL
	GtSCq4ky5KmIuQddYWSrHqdbS46+gqs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-QhcexgQrPJyp37D1Ovkadw-1; Wed,
 22 Nov 2023 04:58:56 -0500
X-MC-Unique: QhcexgQrPJyp37D1Ovkadw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 322863810B1A;
	Wed, 22 Nov 2023 09:58:56 +0000 (UTC)
Received: from [10.45.226.4] (unknown [10.45.226.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11EE82026D4C;
	Wed, 22 Nov 2023 09:58:53 +0000 (UTC)
Message-ID: <48330ace-2b5f-4919-b5cb-7ac4372120bf@redhat.com>
Date: Wed, 22 Nov 2023 10:58:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Simon Horman
 <horms@kernel.org>, mschmidt@redhat.com, netdev@vger.kernel.org
References: <20231116152114.88515-1-ivecera@redhat.com>
 <20231116152114.88515-4-ivecera@redhat.com>
 <f90bc4fc-d9e3-468c-8b94-73bea4b2d764@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <f90bc4fc-d9e3-468c-8b94-73bea4b2d764@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4



On 22. 11. 23 0:05, Tony Nguyen wrote:
> 
> 
> On 11/16/2023 7:21 AM, Ivan Vecera wrote:
> 
>> @@ -13197,17 +13193,14 @@ static int i40e_ndo_bridge_getlink(struct 
>> sk_buff *skb, u32 pid, u32 seq,
>>       struct i40e_vsi *vsi = np->vsi;
>>       struct i40e_pf *pf = vsi->back;
>>       struct i40e_veb *veb = NULL;
>> -    int i;
>>       /* Only for PF VSI for now */
>>       if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
>>           return -EOPNOTSUPP;
>>       /* Find the HW bridge for the PF VSI */
>> -    i40e_pf_for_each_veb(pf, i, veb)
>> -        if (veb->seid == vsi->uplink_seid)
>> -            break;
>> -    if (i == I40E_MAX_VEB)
>> +    veb = i40e_pf_get_veb_by_seid(pf, vsi->uplink_seid);
>> +    if (!vsi)
>>           return 0;
> 
> In addition to the kdoc stuff that Simon pointed out. Should this null 
> check be against veb?
> 
Oops, the check should be against veb here not aganst vsi...
Good eyes, Tony. Thanks, I will fix this.

Ivan


