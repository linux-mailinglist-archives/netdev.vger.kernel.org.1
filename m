Return-Path: <netdev+bounces-48384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFA77EE335
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D33B20A7C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1330F90;
	Thu, 16 Nov 2023 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYsQLL0g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595AFD4B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700145976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTqorEhdT7DMAGJHmu4VBxw/55IAIeOOpj+g7xYY/4M=;
	b=KYsQLL0gLErIukqGFtWdjITckMilUnvKWq4cRw45yApgrBBt/wy2Wt55H5NtVOKxRXQcLy
	y3P4PVKZm/uIrEhzgDnpVheJBuIsnXlV+hwSraql7R0U+/AnXXxoZyq9zu3jP8AkmIRD76
	YpvX22Halkdwy8gcs1xbzU54/jE1Vrg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-yg6dT8FlPhCvECEC6khXCA-1; Thu, 16 Nov 2023 09:46:11 -0500
X-MC-Unique: yg6dT8FlPhCvECEC6khXCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34E38185A784;
	Thu, 16 Nov 2023 14:46:10 +0000 (UTC)
Received: from [10.45.225.144] (unknown [10.45.225.144])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 899882166B28;
	Thu, 16 Nov 2023 14:46:08 +0000 (UTC)
Message-ID: <2332ea8b-16d9-402f-8be6-683e52c6758e@redhat.com>
Date: Thu, 16 Nov 2023 15:46:07 +0100
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
 <483acf53-fe96-4ef3-933a-c5fd446042f6@redhat.com>
 <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 16. 11. 23 15:21, Wojciech Drewek wrote:
>>> Sounds good, my point was that I prefer to have "get" before "{veb|vsi}"
>> OK, got it... Will repost v2 with this change + "too many also..." issue 😉
> Thanks
> 
>> Btw. what about the last patch?
> Reviewed 🙂

Thanks, Wojciech! But I already submitted v2 of the series...but without 
your 'Reviewed-by:' tag in patch 5. Could you please "review" the v2 of 
patch 5 again?

Thanks,
Ivan


