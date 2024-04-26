Return-Path: <netdev+bounces-91775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62FC8B3DB4
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235661C21F2B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC115D5A2;
	Fri, 26 Apr 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaQzblg2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6715B15D
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151795; cv=none; b=LNn70Fa12nt0f07lL7uEXFNlJwLLI0K4ffwMHrOofkQ8Nv1qpYy4J+ox2C4EEI3u2aYe7PBLuUn5abl4YsK0cnUYHVRVZkBodSZ2rnPeh7HeD1/AKQi3ok+LUjteQ/giIUnPSQVF0NgBiODI18NdBvBvR1Q87ypRKnE5Jvlzl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151795; c=relaxed/simple;
	bh=5GBgcTHzbOIEDgorcFEzrdXexOgGt8UtgP6HqH2srao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/5l0Sco+U2cNEtBUGI5wleav6YyHYP1Wc4biz6NRI+F9EAMgRkzMudJYGP86RQxI3f9nIZSgKu50RIDyGw2vFpCIebK7UCBjdYViL5RFNnR+sLIrbvV8b63aPj/sJhSlc7H67Yp0QlfS+EHyfVNrvVbvWgrhYD5o72Mzx51OH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaQzblg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714151793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eZ7lmSsHEeWREkE8QMUgqjdRO8mkI1U+zkRl58HfpU=;
	b=MaQzblg2NYVCe2IsckoFrq+r2AvGBmdv/O3WGPbF1iBB3/MbnKnwaNjVuEu61IOCqvzu4m
	HIErDP6oWGHhRz9BP/oyJDUtQvEcgyTghimI74NqsvWjm7LGM8zXZMxAAZlvdEdhvOmUSx
	EnLuW+gTiYPazxWLoQh7jryfjNox2gc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-F2z9VHWJOKyN98hUIR0s_Q-1; Fri, 26 Apr 2024 13:16:29 -0400
X-MC-Unique: F2z9VHWJOKyN98hUIR0s_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1699F830D37;
	Fri, 26 Apr 2024 17:16:29 +0000 (UTC)
Received: from [10.45.225.10] (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C79A40C6DAE;
	Fri, 26 Apr 2024 17:16:27 +0000 (UTC)
Message-ID: <914424cb-d74a-40b3-95e4-03d17d653467@redhat.com>
Date: Fri, 26 Apr 2024 19:16:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 0/7] i40e: cleanups & refactors
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mschmidt@redhat.com, aleksandr.loktionov@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20240327075733.8967-1-ivecera@redhat.com>
 <3bd08423-18cd-6e12-38ab-4d9656c9ecf1@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <3bd08423-18cd-6e12-38ab-4d9656c9ecf1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 12. 04. 24 23:19, Tony Nguyen wrote:
> 
> 
> On 3/27/2024 12:57 AM, Ivan Vecera wrote:
>> This series do following:
>> Patch 1 - Removes write-only flags field from i40e_veb structure and
>>            from i40e_veb_setup() parameters
>> Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
>>            and i40e_notify_client_of_netdev_close()
>> Patch 3 - Refactors parameter of i40e_detect_recover_hung()
>> Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
>>            in existing code
>> Patch 5 - Consolidates checks whether given VSI is the main one
>> Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
>>            in existing code
>> Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
>>            particular and uses it to replace existing open-coded pieces
> 
> Hi Ivan,
> 
> With the new checks on kdoc [1], this now reports issues. Can you fix 
> those? Feel free to send the new version to 'net-next' as our validation 
> has finished their testing on this series.
> 
> You can add my
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Thanks,
> Tony

Huh, I missed your email. Will send v3.

Thanks,
Ivan

>> Changes since v1:
>> - adjusted titles for patches 2 & 3
>>
>> Ivan Vecera (8):
>>    i40e: Remove flags field from i40e_veb
>>    i40e: Refactor argument of several client notification functions
>>    i40e: Refactor argument of i40e_detect_recover_hung()
>>    i40e: Add helper to access main VSI
>>    i40e: Consolidate checks whether given VSI is main
>>    i40e: Add helper to access main VEB
>>    i40e: Add and use helper to reconfigure TC for given VSI
>>
>>   drivers/net/ethernet/intel/i40e/i40e.h        |  30 ++-
>>   drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
>>   drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
>>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 +--
>>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
>>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 205 ++++++++++--------
>>   drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
>>   .../net/ethernet/intel/i40e/i40e_register.h   |   3 +
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  98 ++++++---
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   3 +-
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
>>   11 files changed, 282 insertions(+), 173 deletions(-)
> 
> [1] https://lore.kernel.org/netdev/20240411200608.2fcf7e36@kernel.org/
> 


