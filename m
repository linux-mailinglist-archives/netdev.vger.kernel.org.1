Return-Path: <netdev+bounces-118435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEDF951980
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F4B282844
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF381AE04A;
	Wed, 14 Aug 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpoYfdVG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A01F60A
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633067; cv=none; b=LcNDH5658iJsVE8Ab5i3htgT57dghu0ReodBUoaed21XcbRZlwnx7CrhSz3ZklcLZJoCT3oYrb1+BZ4vP5TQ8UGPF40Evf5Ec+HeSirGhhHmyWo9RExXsBgn+QpHePrs6uCjU+Wl20QCe0zpDtPar9E8b3yuPzCrUvjXqJwrvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633067; c=relaxed/simple;
	bh=rXmc4Uju7pgtTw9AWSVXgPr1M+XqA6OswcWxro12Qn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6G3vNZi+IA7c2Dlkx2DDZIZ8V6zlQWfva81maEX9ToFDElMi4QpXiIYvzbKrWzPyggeF75vKl5DIiU1qyAH4NvKyorTbiKqRwibcWdxc7OrPXNSLQNY89f5GPLO/M4OE13hDnopANbS04iTo/86CXPWirReh73dHnhd+a4bDdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpoYfdVG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723633066; x=1755169066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rXmc4Uju7pgtTw9AWSVXgPr1M+XqA6OswcWxro12Qn4=;
  b=dpoYfdVGhPRcchqhM8Uf7GNvJiuOo5VZxsZl0nFaFZvMdPMSDqu5lsgg
   4HjpdbSaC378gUlGNnc+uv86iAKllESeVJ/EbdNLIN2BLNHPvUs1ZArYc
   Cs7aEEDAZb7c/VxVM4zrD45bK+ehfhiaAL0hQ2p0D8lpugVpDmEbV9M1l
   vnNESmc+k2Z6ubfS1ih9JJWFrCClDAvbtviMAoilbq+VYSmVyAS9sR5Pi
   h6NguXVS5Lr6gSak9K01y1sdEAYFp3AF0IzLjN62GLh3D+nzfGbJ9ATCO
   3K7MSKhQTl6hcLHUF/Ehv1hgPnRukDivLt4znujBdcKq7EZNPPY22Z1ZN
   Q==;
X-CSE-ConnectionGUID: 88Ygo4moQfu9OmAQdsEJwA==
X-CSE-MsgGUID: KqYV6LRORFWcmKd2UVDEcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32515986"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="32515986"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:57:46 -0700
X-CSE-ConnectionGUID: yeUuT0TMRLO5IZDkaD48nA==
X-CSE-MsgGUID: wbHcN2QvTYiOKujl6yEoeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="63122784"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.245.130.66]) ([10.245.130.66])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 03:57:44 -0700
Message-ID: <cc23dde3-8298-4cd6-b2cd-7e9d7bb32d65@linux.intel.com>
Date: Wed, 14 Aug 2024 12:57:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: Add netif_device_attach/detach into PF
 reset flow
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Igor Bagnucki <igor.bagnucki@intel.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
References: <20240812125009.62635-1-dawid.osuchowski@linux.intel.com>
 <ZrtIO2durwKP7ue/@boxer>
 <1c0db79b-dd8c-4ab8-b108-42395a737836@linux.intel.com>
 <ZruzBXwsFswL3lUe@boxer>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <ZruzBXwsFswL3lUe@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.2024 21:24, Maciej Fijalkowski wrote:
> On Tue, Aug 13, 2024 at 05:31:37PM +0200, Dawid Osuchowski wrote:
>> On 13.08.2024 13:49, Maciej Fijalkowski wrote:
>>> What about other intel drivers tho?
>>
>> I have not performed detailed analysis of other intel ethernet drivers in
>> this regard, but it is surely a topic worth investigating.
> 
> If you could take some action upon this then it would be great. I'm always
> hesitating with providing the review tag against a change that already
> contains few of them, but given that I dedicated some time to look into
> that:
> 
I got a valid concern from Kalesh (CCd) on the v1 thread 
(https://lore.kernel.org/netdev/CAH-L+nOFqs-K5YzfrfmpRHbhDGM-+1ahhWh4NXATX1FqZiPVLQ@mail.gmail.com/) 
about the attaching only if link is up.

On 14.08.2024 05:19, Kalesh Anakkur Purayil wrote:
 > [Kalesh] Is there any reason to attach back the netdev only if link is
 > up? IMO, you should attach the device back irrespective of physical
 > link status. In ice_prepare_for_reset(), you are detaching the device
 > unconditionally.
 >
 > I may be missing something here.

I agree with his suggestion to do the netif_device_attach() irrespective 
of link being up. Should I sent a v3 with the change? I have already 
tested that locally and it seems to fix the reported issue with NULL 
pointer dereference as well.

--Dawid

> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
>>
>> --Dawid



