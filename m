Return-Path: <netdev+bounces-107701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB691BFBB
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C961DB2056C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 13:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DC1E529;
	Fri, 28 Jun 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBBhvc1/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBB1E4A1
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581977; cv=none; b=T6vu4aTGyFXHDaUtrUkgXX3CrA0pBQ7AsPj1gCJnM9KbdJ543sctVY1Hh+Crz9Gb6HFpfZwNXQoJWc0p8opxi1ei65hCt6tl7q/TwA8qV8O6EUbivIXbF61rlzXuQ6QTTd0dH6EZxPwDvEEXKP+pqJun6bdGoodoZKti4+43IcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581977; c=relaxed/simple;
	bh=faYMoe80vaKC3QXdB853GMfAvH8zjYHBxZAuLm8qo0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9TJBvd3EtTBVk+LN+bn0X0WFCr2j4zbCBRjeCMIgyVPofdix5cJ86JpWCL4ZImPDltMl5WYYx0KCxV5nMOHLDgPUHgHAXZYG1LhhGbpQOycETUcuVkRRQW3GPehbS6CirSqFoh6sGTT/AcnTiHYWeIp8S6uXvSGK3TjvUUNsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBBhvc1/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719581976; x=1751117976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=faYMoe80vaKC3QXdB853GMfAvH8zjYHBxZAuLm8qo0o=;
  b=CBBhvc1/PVyTm6q9vuv/tuDxcN3w2NRcH+JrLetF27fXsUiNw80muxRb
   o9HXbeYz5wiNwKjY45CjKka70tZsU0u3TjBsT8HbDRbST04zkD4cZWojh
   Zgdw9hWgI9rqAsuRRlgFcfgMpFBY26qKklboOnKlhQf7yZJNCpE1MaaxL
   T+hqjGl6SRwQ7gWfj09TbK8pG2of/wVEADWIjhPlux7pbaSB2+WIN8qQI
   0KhfACe4Pj61uc4ZUmIl95eINSgAkALPrifZ4gz8fPnb0gK0zU8qrh/PF
   aVrYiQaix8eqcMSfMPTjHKY2bG03takfWurRyd3ujo4U3QNM6I7m/4xPY
   w==;
X-CSE-ConnectionGUID: gUaaEHQCRAC2KETQV7PuWw==
X-CSE-MsgGUID: BcwoWcjgQtuOVa4XHcc6IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16503419"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16503419"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 06:39:35 -0700
X-CSE-ConnectionGUID: J+pl2M/eQFyiRAJKeWbYMQ==
X-CSE-MsgGUID: 5oCMnSywSvW5oGRBOKWoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="82293240"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.26.245]) ([10.246.26.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 06:39:33 -0700
Message-ID: <96df3ad4-dd4b-409d-98ed-aa5c6173b579@linux.intel.com>
Date: Fri, 28 Jun 2024 15:39:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 5/6] ice: Optimize switch
 recipe creation
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 przemyslaw.kitszel@intel.com, michal.swiatkowski@linux.intel.com
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-6-marcin.szycik@linux.intel.com>
 <20240628124409.GD783093@kernel.org>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240628124409.GD783093@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.06.2024 14:44, Simon Horman wrote:
> On Tue, Jun 18, 2024 at 04:11:56PM +0200, Marcin Szycik wrote:
>> Currently when creating switch recipes, switch ID is always added as the
>> first word in every recipe. There are only 5 words in a recipe, so one
>> word is always wasted. This is also true for the last recipe, which stores
>> result indexes (in case of chain recipes). Therefore the maximum usable
>> length of a chain recipe is 4 * 4 = 16 words. 4 words in a recipe, 4
>> recipes that can be chained (using a 5th one for result indexes).
>>
>> Current max size chained recipe:
>> 0: smmmm
>> 1: smmmm
>> 2: smmmm
>> 3: smmmm
>> 4: srrrr
>>
>> Where:
>> s - switch ID
>> m - regular match (e.g. ipv4 src addr, udp dst port, etc.)
>> r - result index
>>
>> Switch ID does not actually need to be present in every recipe, only in one
>> of them (in case of chained recipe). This frees up to 8 extra words:
>> 3 from recipes in the middle (because first recipe still needs to have
>> switch ID), and 5 from one extra recipe (because now the last recipe also
>> does not have switch ID, so it can chain 1 more recipe).
>>
>> Max size chained recipe after changes:
>> 0: smmmm
>> 1: Mmmmm
>> 2: Mmmmm
>> 3: Mmmmm
>> 4: MMMMM
>> 5: Rrrrr
>>
>> Extra usable words available after this change are highlighted with capital
>> letters.
>>
>> Changing how switch ID is added is not straightforward, because it's not a
>> regular lookup. Its FV index and mask can't be determined based on protocol
>> + offset pair read from package and instead need to be added manually.
>>
>> Additionally, change how result indexes are added. Currently they are
>> always inserted in a new recipe at the end. Example for 13 words, (with
>> above optimization, switch ID being one of the words):
>> 0: smmmm
>> 1: mmmmm
>> 2: mmmxx
>> 3: rrrxx
>>
>> Where:
>> x - unused word
>>
>> In this and some other cases, the result indexes can be moved just after
>> last matches because there are unused words, saving one recipe. Example
>> for 13 words after both optimizations:
>> 0: smmmm
>> 1: mmmmm
>> 2: mmmrr
>>
>> Note how one less result index is needed in this case, because the last
>> recipe does not need to "link" to itself.
>>
>> There are cases when adding an additional recipe for result indexes cannot
>> be avoided. In that cases result indexes are all put in the last recipe.
>> Example for 14 words after both optimizations:
>> 0: smmmm
>> 1: mmmmm
>> 2: mmmmx
>> 3: rrrxx
>>
>> With these two changes, recipes/rules are more space efficient, allowing
>> more to be created in total.
>>
>> Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> 
> I appreciate the detailed description above, it is very helpful.
> After a number of readings of this patch - it is complex -
> I was unable to find anything wrong. And I do like both the simplification
> and better hw utilisation that this patch (set) brings.
> 
> So from that perspective:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> I would say, however, that it might have been easier to review
> if somehow this patch was broken up into smaller pieces.
> I appreciate that, in a sense, that is what the other patches
> of this series do. But nonetheless... it is complex.

Yeah... it is a bit of a revolution, and unfortunately I don't think much of
if could be separated into other patches. Maybe functions like
fill_recipe_template() and bookkeep_recipe() would be good candidates.
If there will be another version, I'll try to separate some of it.

Thank you for reviewing!
Marcin

> 
> ...

