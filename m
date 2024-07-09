Return-Path: <netdev+bounces-110202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA80F92B46C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944DE2844C0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03422155A53;
	Tue,  9 Jul 2024 09:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE155A26;
	Tue,  9 Jul 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518743; cv=none; b=dR5N2Oi/XrBHCLaRp260RWIv7TCBiVa3e1W0uguIBoMcUQCd2igf5EBYF1P7nzs6n52OWMnQfg7vFALsGeZCLuU3hEaLutmTEIoLgPk4N5xW6HcrJ3vLamtjycJDzLTsSO6YBT6faAx7fm/i7lowVAFHRqz9tSTwm+cDbpf+KGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518743; c=relaxed/simple;
	bh=PqQ4ueVIFosN7qzIDNxoq5cnPev0B8p3RjSPH63gS64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpwbQwL2+LIkTGzjd7Cicj/7NNM/m9z8Ncgt5+PkH4EAVxq1X+N9sitHEaK3PlXLaFvsk+nZcZ8rosCCEdFXU+Gxro2PonYMb10rJ1fuF8vp4ym9Jlu/NTMweTyAmOa6OwcLgL7gs6FK+zQL2I043v1uOTWaOwKmGTd86LjaHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CE0261E40617;
	Tue,  9 Jul 2024 11:51:00 +0200 (CEST)
Message-ID: <56160e13-662d-4f7e-86d3-1a88716f01d9@molgen.mpg.de>
Date: Tue, 9 Jul 2024 11:50:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ice: Adjust over allocation
 of memory in ice_sched_add_root_node() and ice_sched_add_node()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Mishin <amishin@t-argos.ru>
Cc: lvc-project@linuxtesting.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <20240708182736.8514-1-amishin@t-argos.ru>
 <033111e2-e743-4523-8c4f-7d5f1c801e65@molgen.mpg.de>
 <23d2e91c-4215-4ea5-8b3c-4dd58a1062af@molgen.mpg.de>
 <190d0cdc-d6de-4526-b235-91b25b50c905@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <190d0cdc-d6de-4526-b235-91b25b50c905@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Przemek,


Thank you for your quick reply.


Am 09.07.24 um 11:11 schrieb Przemek Kitszel:
> On 7/9/24 10:54, Paul Menzel wrote:
>> [Cc: -anirudh.venkataramanan@intel.com (Address rejected)]
>>
>> Am 09.07.24 um 10:49 schrieb Paul Menzel:

>>> Am 08.07.24 um 20:27 schrieb Aleksandr Mishin:
>>>> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
>>>> devm_kcalloc() in order to allocate memory for array of pointers to
>>>> 'ice_sched_node' structure. But incorrect types are used as sizeof()
>>>> arguments in these calls (structures instead of pointers) which leads to
>>>> over allocation of memory.
>>>
>>> If you have the explicit size at hand, it’d be great if you added 
>>> those to the commit message.
>>>
>>>> Adjust over allocation of memory by correcting types in devm_kcalloc()
>>>> sizeof() arguments.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Maybe mention, that Coverity found that too, and the warning was 
>>> disabled, and use that commit in Fixes: tag? That’d be commit 
>>> b36c598c999c (ice: Updates to Tx scheduler code), different from the 
>>> one you used.
> 
> this version does not have any SHA mentioned :)

Sorry, I don’t understand your answer. What SHA do you mean?

>>> `Documentation/process/submitting-patches.rst` says:
>>>
>>>> A Fixes: tag indicates that the patch fixes an issue in a previous
>>>> commit. It is used to make it easy to determine where a bug
>>>> originated, which can help review a bug fix. This tag also assists
>>>> the stable kernel team in determining which stable kernel versions
>>>> should receive your fix. This is the preferred method for indicating
>>>> a bug fixed by the patch.
> 
> so, this is not a "fix" per definition of a fix: "your patch changes
> observable misbehavior"
> If the over-allocation would be counted in megabytes, then it will
> be a different case.

The quoted text just talks about “an issue”. What definition do you 
refer to?


Kind regards,

Paul

