Return-Path: <netdev+bounces-125072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8BB96BD7F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB851C24D21
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED51D9354;
	Wed,  4 Sep 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOZ7pWl8"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEA61EBFFA
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454881; cv=none; b=AA6HV9KemEC+XddDjntOepg2Ob/69fb5xcop81bWeYTgr0S4WfwoYsNj4yrs3BkbrfqkWjxZE2iBJKLJOGhKASeOHKFQ8iwwLxpBUDaZYjCFutWkMMCbOVdJSPWyKpaHIkj+HlcFXxSlt4DJsCqC126dxVVzDTP8BjcL7Z/i5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454881; c=relaxed/simple;
	bh=THfeOhwgjXcF0mNvutJQKdFH5L1bHpUmsfmmKI1TpRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBapwbXrv9yXiJK7WOaPC7qrnFx75h9GA6YhZvdvEHgi7ORRP6bUxAhCkchZ76dXhy58GXMuuyogkl3hstCVg2NHBX2/nkcCAiL2MHxvK2Aj70fGVwOneZpxPtK4BU3d8gbdwcPrMVoStHWflOfnEZotYhhXTULMDWe2gnex3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOZ7pWl8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c3917d13-d46a-4ee6-a844-2e87de6fb2fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725454873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHAA2dvArprI5opiWit6ae0dZlZrJqDbVtuI6LjabeQ=;
	b=nOZ7pWl85dSVRHPHV1lQSoD/aHTDiTAFEIljsjVUN2BK/o/+qEDHgPSGWEnwv0+zZo3O7Q
	JtZmnEOoPFPlGBT8RIm3220aiId9GiOdRljRa1lYrlf2gn2+4kxfTbsiEcbrpFBg/GWWnP
	4Fb/oEA2BepMg+up7hkCc2A7o0GGcJ8=
Date: Wed, 4 Sep 2024 14:01:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904105143.2444106-1-martyn.welch@collabora.com>
 <fc1afd33-c903-46ca-ae4f-4e9a1c037023@linux.dev>
 <20240904111342.2lboi53cl4pav4a5@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240904111342.2lboi53cl4pav4a5@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 12:13, Vladimir Oltean wrote:
> On Wed, Sep 04, 2024 at 12:11:31PM +0100, Vadim Fedorenko wrote:
>> On 04/09/2024 11:51, Martyn Welch wrote:
>>> The enetc driver uses ifdefs when checking whether
>>> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
>>> if the driver is compiled in but fails if the driver is available as a
>>> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
>>> macro, that will evaluate as true when this feature is built as a kernel
>>> module and follows the kernel's coding style.
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>>> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>> If there will be v4, please, put yours SoB as the last tag after all
>> other tags.
>>
>> Thanks,
>> Vadim
> 
> What's the deal with this? If I give my review tag now, and the patch
> will subsequently be applied, my Reviewed-by: tag will also appear after
> his SoB.

I think it was discussed several times on the mailing list already,
the latest discussion was recently in this thread:
https://lore.kernel.org/netdev/20240903072417.GN23170@kernel.org/

But I have also seen this suggestion from different maintainers.
As you said that if the patch will be applied the tags will go in
historical order. In case of re-submission, historically Reviewed-by
will be earlier in time line, so should be before SoB, AFAIU.

Thanks,
Vadim

