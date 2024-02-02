Return-Path: <netdev+bounces-68289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B8846675
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F75F1C23673
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C4BE69;
	Fri,  2 Feb 2024 03:17:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy3.45ru.net.au (anchovy3.45ru.net.au [203.30.46.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F24F4E0
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.30.46.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843847; cv=none; b=sjqt2nMm5STNI6q7MXLYTlejABDu+FQQFE/1QrwQB6jVFDpKE/QgLxKibhJBGAe4Lyc3rBFP8cBv6gEDVC8ULxphsUFkJ4NS349eu05NwyC7sthBi1QoojyONYjta+g0NQ6X+t6/K4Azi9JB3MiHHvaTL9ldWFZ+He+FYCsJVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843847; c=relaxed/simple;
	bh=5BqSEZGI5oRLouBUdH2wy4cRQMfnUEg237kfHxqOI+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHFTVfLOIzNgP58WzRCJeCXHgkrBULezp+zy4lvDGO+vhUXjGx+EiwsKN1qLJcHsKah7j5XnYt1lDxgeSjTxn4fsf5qS2ZS7g1F86jHH4/KyU3jA9mKnyS1UQsgwYAl12HCKPjYnWcDxXD1inrg9MgSy+RL85BKO5zkESt3rRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au; spf=pass smtp.mailfrom=electromag.com.au; arc=none smtp.client-ip=203.30.46.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electromag.com.au
Received: (qmail 16395 invoked by uid 5089); 2 Feb 2024 03:10:39 -0000
Received: by simscan 1.2.0 ppid: 16271, pid: 16272, t: 0.4128s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 2 Feb 2024 03:10:38 -0000
Message-ID: <6e6adda6-26bd-45f6-a63d-8fc73a95373c@electromag.com.au>
Date: Fri, 2 Feb 2024 11:10:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: stmmac: Prevent DSA tags from breaking COE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org, "G Thomas, Rohan" <rohan.g.thomas@intel.com>
References: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
 <b757b71b-2460-48fe-a163-f7ddfb982725@electromag.com.au>
 <20240201070551.7147faee@kernel.org>
Content-Language: en-US
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <20240201070551.7147faee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit





Richard Tresidder



On 1/02/2024 11:05 pm, Jakub Kicinski wrote:

> On Thu, 1 Feb 2024 17:38:07 +0800 Richard Tresidder wrote:
>>       Thanks for your work on this patch.
>> I was wondering if this would make it's way onto the lts kernel branch at some point?
>> I think this patch relies on at least a few others that don't appear to have been ported across either.
>> eg: at least 2023-09-18 	Rohan G Thomas net: stmmac: Tx coe sw fallback
>>
>> Just looking at having to abandon the 6.6 lts kernel I'm basing things on as we require this patchset to get our network system working.
>> Again much appreciated!
> Hm, it may have gotten missed because of the double space in:
> Cc:  <stable@vger.kernel.org>
> double check if it's present in the stable tree and if not please
> request the backport, the info you need to provide is somewhere
> in kernel doc's process section.
>
Hi Jakub
    Thanks for the hint.
I just found these patches noted in the stable mailing list on the 29th of Jan as part of the [PATCH 6.6] series
So yep my bad I was looking in the wrong spot.

[PATCH 6.6 008/331] net: stmmac: Tx coe sw fallback
[PATCH 6.6 009/331] net: stmmac: Prevent DSA tags from breaking COE

Cheers
    Richard Tresidder


