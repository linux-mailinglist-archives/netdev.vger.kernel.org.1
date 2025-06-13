Return-Path: <netdev+bounces-197425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C78AD89E9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C03189A152
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724DC2D4B67;
	Fri, 13 Jun 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hY6aifoZ"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4682D5421;
	Fri, 13 Jun 2025 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749812393; cv=none; b=E39XaPOn7PBIpBum99ZZtkGjCIvvvGaMDG9Uc6t7V8vkm7qYjrP+ey3iRaJlZUPc6sJH6jN1QIMBfmyeCYgNfzJ2tJQeMm6/OLdiW5h+5JJs394Je7OpAd6RIRJN721zOebhLbFVIOlHjA1zjyp2outTg/ogkI6M7AszEYQTcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749812393; c=relaxed/simple;
	bh=lNlHr4fN+kW1hphV1mf8s//XHzAcGEu6x4XIaFIdJVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T13nfgnCl2iQJTd+szGsE8Ubo3njMUfr9B+7VxcGzr0TXI4Q92TvIEJibQMySgVvP1RDKiq0EYtMItG4oO62IoL+P0TcAK9zXHKyI43wQ8VbOX8ccQhwu5a5Fzt9wpVcmDE0sRHKP+sgo4UY1IYE816LvoVlm50Qubg97W8caCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hY6aifoZ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55DAxHoL1961667;
	Fri, 13 Jun 2025 05:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749812357;
	bh=ECNdaOgprCZ21ffz0S0ElddSmNcpxaOPXvRqQLB08fs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hY6aifoZtXHMKs15wOkCqYOJWD+HDjcuOyx2WlKxO1qshiV17P0bGLtYjWCINj4vJ
	 FRoQoGS8OauWjIiC7dQZl1PUwHupCluhYFVRyqvYvUrbwtC+vwtMzQl5Z7nijEhXcU
	 tgh1tFNqYEAyTZLPQ6wctoH2X1aOT/jX9s7ZGt0M=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55DAxH6O2682137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 13 Jun 2025 05:59:17 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 13
 Jun 2025 05:59:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 13 Jun 2025 05:59:17 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55DAxBK73455305;
	Fri, 13 Jun 2025 05:59:12 -0500
Message-ID: <65bf4f83-43c2-4640-9858-afb96fa1cfc7@ti.com>
Date: Fri, 13 Jun 2025 16:29:11 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Meghana Malladi <m-malladi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger
 Quadros <rogerq@ti.com>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
 <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
 <20250610085001.3upkj2wbmoasdcel@skbuf>
 <1cee4cab-c88f-4bd8-bd71-62cd06901b3b@ti.com>
 <20250610150254.w4gvmbsw6nrhb6k4@skbuf>
 <10d1c003-fcac-4463-8bce-f40bda3047f0@ti.com>
 <20250612151043.6wfefe42pzeeazvg@skbuf>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250612151043.6wfefe42pzeeazvg@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 12/06/25 8:40 pm, Vladimir Oltean wrote:
> On Wed, Jun 11, 2025 at 03:10:35PM +0530, MD Danish Anwar wrote:
>>> I am not very positive that even if adding the extra restrictions
>>> discovered here (cycle-time cannot be != IEP_DEFAULT_CYCLE_TIME_NS),
>>> the implementation will work as expected. I am not sure that our image
>>> of "as expected" is the same.
>>>
>>> Given that these don't seem to be hardware limitations, but constraints
>>> imposed by the ICSSG firmware, I guess my suggestion would be to start
>>> with the selftest I mentioned earlier (which may need to be adapted),
>>
>> Yes I am working on running the selftest on ICSSG driver however there
>> are some setup issues that I am encountering. I will try to test this
>> using the selftest.
>>
>>> and use it to get a better picture of the gaps. Then make a plan to fix
>>> them in the firmware, and see what it takes. If it isn't going to be
>>> sufficient to fix the bugs unless major API changes are introduced, then
>>> maybe it doesn't make sense for Linux to support taprio offload on the
>>> buggy firmware versions.
>>>
>>> Or maybe it does (with the appropriate restrictions), but it would still
>>> inspire more trust to see that the developer at least got some version
>>> of the firmware to pass a selftest, and has a valid reference to follow.
>>
>> Sure. I think we can go back to v9 implementation (no extend feature)
>> and add two additional restrictions in the driver.
>>
>> 1. Cycle-time needs to be 1ms
>> 2. Base-time needs to be Multiple of 1ms
>>
>> With these two restrictions we can have the basic taprio support. Once
>> the firmware is fixed and has support for both the above cases, I will
>> modify the driver as needed.
>>
>> I know firmware is very buggy as of now. But we can still start the
>> driver integration and fix these bugs with time.
>>
>> I will try to test the implementation with these two limitations using
>> the selftest and share the logs if it's okay with you to go ahead with
>> these limitations.
>>
>>> Not going to lie, it doesn't look great that we discover during v10 that
>>> taprio offload only works with a cycle time of 1 ms. The schedule is
>>
>> I understand that. Even I got to know about this limitation after my
>> last response to v10
>> (https://lore.kernel.org/all/5e928ff0-e75b-4618-b84c-609138598801@ti.com/)
>>
>>> network-dependent and user-customizable, and maybe the users didn't get
>>> the memo that only 1 ms was tested :-/
>>
>> Let me know if it'll be okay to go ahead with the two limitations
>> mentioned above for now (with selftest done).
>>
>> If it's okay, I will try to send v11 with testing with selftest done as
>> well. Thanks for the continuous feedback.
> 
> I don't want to gate your upstreaming efforts, but a new version with
> just these extra restrictions, and no concrete plan to lift them, will
> be seen with scepticism from reviewers. You can alleviate some of that
> by showing results from a selftest.

We will make a complete plan for fixing these restrictions and I will
update the community.

> 
> The existing selftest uses a 2 ms schedule and a 10 ms schedule. Neither
> of those is supported by your current proposal. You can modify the
> schedules to be compatible with your current firmware, and the selftest
> may pass that way, but I will not be in favor of accepting that change
> upstream, because the cycle time is something that needs to be highly
> adaptive to the network requirements.
> 

I can tweak the script to use 1ms cycle time. I tried to run the script
however I am not able to run the script due to multiple package
dependencies which I am currently trying to resolve.

I checked your commit [1] where you have introduced the tc_taprio.sh
script. You have mentioned,
	"This is specifically intended for NICs with an offloaded data path
(switchdev/DSA) and requires taprio 'flags 2'. Also, $h1 and $h2 must
support hardware timestamping, and $h1 tc-etf offload, for isochron to
work."

My NIC does support offloaded data path (switchdev), taprio 'flags 2'
and hardware timestamping. However we don't support tc-etf offload.

Will it be possible to use this script without the support of tc-etf
offload?

> So to summarize, you can try to move forward with a restricted version
> of this feature, but you will have to be very transparent as to what
> works and what are the next steps, as well as give assurance that you
> intend to keep supporting the current firmware and its API when an
> improved firmware will become available that lifts these restrictions.

We are working on a plan to get full taprio support and I will update
the community accordingly. I want the driver to get upstreamed with
whatever support we have right now and add things later on. If I am able
to verify the `tc_taprio.sh` script then I would share results from
there. If I am not able to verify the script, I will at least try to
mention what we are supporting now and what are the limitations and when
do we plan on addressing those limitations.

[1]
https://lore.kernel.org/all/20250426144859.3128352-5-vladimir.oltean@nxp.com/#r

-- 
Thanks and Regards,
Danish

