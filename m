Return-Path: <netdev+bounces-141452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C079BAF32
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10CD1F21256
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06721AAE30;
	Mon,  4 Nov 2024 09:10:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21778BA34
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711439; cv=none; b=Cw+y/QO1OuQ0fV8gTcHLMQjiOusMwoKGW09Gs3V3nNt2t3lzABTfcsJ5wnRLmfsWLHaW+vEhovTy7V0rkYyqtAdPccFOeJ2jzgucyxO+xchHPKaugUgCUQsrsnNpK5guPjyexdVskiX7/BGUIRka2D9y2s1qB+FYFKxiZ6J2EdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711439; c=relaxed/simple;
	bh=oDCexn6pYcy21mo+TJKn7yFX4VEWXD1vcc5I1yyM3ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa3ANXnmGJ744EzIx/FMz+mAUyU1w8wUK9/+2VMv6IQviS/B+iVCRP5p6guxaN5WWNe9dDR/qwb9JaVCXpOoV3Z9+AjaxHR/X34seHpz9TcYyd+uO/wEqTPbsASqW7v97iWRtihCs4/3ETUfhTMFObAbNRTAAzh0NBKo8kcgKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (unknown [95.90.234.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 45DB261E5FE05;
	Mon, 04 Nov 2024 10:09:31 +0100 (CET)
Message-ID: <840b32a0-9346-4576-97ba-17af12eb4db4@molgen.mpg.de>
Date: Mon, 4 Nov 2024 10:09:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Small Integers: Big Penalty (was: [Intel-wired-lan] [iwl-next v6 2/9]
 ice: devlink PF MSI-X max and min parameter)
To: David Laight <David.Laight@ACULAB.COM>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, pawel.chmielewski@intel.com,
 sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
 pio.raczynski@gmail.com, konrad.knitter@intel.com, marcin.szycik@intel.com,
 wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
 przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com>
 <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
 <CADEbmW0=G8u7Y8L2fFTzan8S+Uz04nAMC+-dkj-rQb_izK88pg@mail.gmail.com>
 <ZyhxmxnxPcLk2ZcX@mev-dev.igk.intel.com>
 <ad5bf0e312d44737a18c076ab2990924@AcuMS.aculab.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ad5bf0e312d44737a18c076ab2990924@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear David, dear Michal,


Am 04.11.24 um 09:51 schrieb David Laight:
> From: Michal Swiatkowski
>> Sent: 04 November 2024 07:03
> ...
>>> The type of the devlink parameters msix_vec_per_pf_{min,max} is
>>> specified as u32, so you must use value.vu32 everywhere you work with
>>> them, not vu16.
>>>
>>
>> I will change it.
> 
> You also need a pretty good reason to use u16 anywhere at all.
> Just because the domain of the value is small doesn't mean the
> best type isn't [unsigned] int.
> 
> Any arithmetic (particularly on non x86) is likely to increase
> the code size above any perceived data saving.

In 2012 Scott Duplichan wrote *Small Integers: Big Penalty* [1]. Of 
course you always should measure yourself.


Kind regards,

Paul


[1]: https://notabs.org/coding/smallIntsBigPenalty.htm

