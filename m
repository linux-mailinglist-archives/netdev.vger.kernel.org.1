Return-Path: <netdev+bounces-174803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E10A60943
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECECD3BAA73
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524213D279;
	Fri, 14 Mar 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VnhxBSj5"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD553AC;
	Fri, 14 Mar 2025 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934791; cv=none; b=CRlvmiFlXXKMqlHlBnXwr6X8K6efXse9olo1kAI9GeZTT8DYqOqcpskguRoZ6iolQaKVyKLHfcZnzAgHKv35RmFUiw4ANW/Y8cZ/q/AEUdhq38XbJ70aFvOo+V0omBdXkWr6mvmJS+XhjkWkbcl6lz0PsofyYPdJT6HxLNIQP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934791; c=relaxed/simple;
	bh=2v5M3mN5vDhx+eD6btPkhGPIFik+gMa4uX/FFac4Buc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qPztc+CJnzNm4ZvCq6a9hj20+67+WtiLSddYh6ZlBhv5JEHt4afeawfhS8Eirl2+1azWMooHNsRrg3wTAsotxm0VQhHzUJKOWS+tEgg8IUsjVjYKOLUG3g5FejpTeaf9pjsUH9kZLE7WAVU0jRCWImcqcF1aId57ixTY3VdetL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VnhxBSj5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6jtUS1566271
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Mar 2025 01:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741934755;
	bh=uOAP9mRHAXh/9Z10zpIVpYptP4wDPHvl/0FeEXfQ/J4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VnhxBSj5zPPVduDolbJosbiBpcZeIIDXwRdM/NBqE2CGjHMNXloSjmxb5Ci0hjzBT
	 12NbcYcbqZieAoxK2qx5UYDeuYmgrZQJYw4nHEDxM0dLDkAjhR/WKzw/u2Bx9+MXj1
	 SlJbiDk7lUz35VBSaBck1UYE7ulwMXx2Y15+a3oQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E6jtVJ118405;
	Fri, 14 Mar 2025 01:45:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 01:45:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 01:45:54 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E6jYiA084213;
	Fri, 14 Mar 2025 01:45:35 -0500
Message-ID: <c9e208e4-af14-424b-b09b-3e5068be2706@ti.com>
Date: Fri, 14 Mar 2025 12:15:34 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: Add ICSSG FW Stats
To: Jakub Kicinski <kuba@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Meghana Malladi <m-malladi@ti.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Lee Trager <lee@trager.us>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Roger Quadros <rogerq@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>
References: <20250305111608.520042-1-danishanwar@ti.com>
 <20250306165513.541ff46e@kernel.org>
 <3931a391-3967-4260-a104-4eb313810c0d@ti.com>
 <20250307083959.33098949@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250307083959.33098949@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 07/03/25 10:09 pm, Jakub Kicinski wrote:
> On Fri, 7 Mar 2025 16:00:40 +0530 MD Danish Anwar wrote:
>>> Thanks for the docs, it looks good. Now, do all of these get included
>>> in the standard stats returned by icssg_ndo_get_stats64 ?
>>> That's the primary source of information for the user regarding packet
>>> loss.  
>>
>> No, these are not reported via icssg_ndo_get_stats64.
>>
>> .ndo_get_stats64 populates stats that are part of `struct
>> rtnl_link_stats64`. icssg_ndo_get_stats64 populates those stats wherever
>> applicable. These firmware stats are not same as the ones defined in
>> `icssg_ndo_get_stats64` hence they are not populated. They are not
>> standard stats, they will be dumped by `ethtool -S`. Wherever there is a
>> standard stats, I will make sure it gets dumped from the standard
>> interface instead of `ethtool -S`
>>
>> Only below stats are included in the standard stats returned by
>> icssg_ndo_get_stats64
>> - rx_packets
>> - rx_bytes
>> - tx_packets
>> - tx_bytes
>> - rx_crc_errors
>> - rx_over_errors
>> - rx_multicast_frames
> 
> Yes, but if the stats you're adding here relate to packets sent /
> destined to the host which were lost you should include them
> in the aggregate rx_errors / rx_dropped / tx_errors / tx_dropped.
> I understand that there's unlikely to be a 1:1 match with specific
> stats.
> 

Sure, I will try to add such stats.

>>> This gets called by icssg_ndo_get_stats64() which is under RCU   
>>
>> Yes, this does get called by icssg_ndo_get_stats64(). Apart from that
>> there is a workqueue (`icssg_stats_work_handler`) that calls this API
>> periodically and updates the emac->stats and emac->pa_stats arrays.
>>
>>> protection and nothing else. I don't see any locking here, and  
>>
>> There is no locking here. I don't think this is related to the patch.
>> The API emac_update_hardware_stats() updates all the stats supported by
>> ICSSG not just standard stats.
> 
> Yes, I'm saying you should send a separate fix, not really related or
> blocking this patch (unless they conflict)
> 

Sure. I will send v3 of this and a fix to net to add spin_lock before
reading stats. I will try to make sure that they don't conflict so that
they can be merged parallelly.

>>> I hope the regmap doesn't sleep. cat /proc/net/dev to test.
>>> You probably need to send some fixes to net.  
>>
>> I checked cat /proc/net/dev and the stats shown there are not related to
>> the stats I am introducing in this series.
> 
> You misunderstood. I pointed that you so you can check on a debug
> kernel if there are any warnings (e.g. something tries to sleep
> since /proc/net/dev read is under RCU lock).
> 
>> The fix could be to add a lock in this function, but we have close to 90
>> stats and this function is called not only from icssg_ndo_get_stats64()
>> but from emac_get_ethtool_stats(). The function also gets called
>> periodically (Every 25 Seconds for 1G Link). I think every time locking
>> 90 regmap_reads() could result in performance degradation.
> 
> Correctness comes first.

Understood.

-- 
Thanks and Regards,
Danish

