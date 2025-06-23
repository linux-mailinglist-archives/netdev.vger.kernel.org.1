Return-Path: <netdev+bounces-200320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC249AE484C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5818A3A79AC
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EB429B23E;
	Mon, 23 Jun 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dsmeYcZB"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104428AAE1
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691790; cv=none; b=ClTZSQoM1BGFYHLZ1x2LzdIxm7Vo65ajEYdryLwHSNz8foYAGGr5jY/Ijro3KtYjzWdvYXIFiqdbXE9MKIw8RxFeVwPjKUIFS1jfzFYtJjg0sc9r3E+x0tRmgGtxYPM1MgHD12QFg58qzkeyVA+JI4FHQBmqoMLdskyAkKA2llE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691790; c=relaxed/simple;
	bh=D1GT6VbCjRAJvafapIVJiMylB6amkTDWtI4OdObQ3Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+Du2Nbh/QYK4N+9YwQKnCSlFJrKAU0OWp3q1Az1wU8H878nU411Iz+J6Z0dTMM4oR+cMusZOrgJNuau+RoIePSTHW4pKtiQGLe0pt8K02X17BRqUodIxqW7/+UCdTyd1NCGb2ui/DqYySSmIbsaQ8RcabMfT2OUs85Q/RKCu88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dsmeYcZB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0854ddee-1b53-472c-a4fe-0a345f65da65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750691776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd1u1j3eg8lhJXpqmh2gB1y5eFliojuhqpAg0rdcDaI=;
	b=dsmeYcZBdpgJopeN4LNPwALDwYY+cURYbbJFzwtvGAFWR3Lmky/rd1MjDVS5iF/C5J5Dx2
	WViTrdief/+/PyFhnRJPblh77uiIy/aKL5lLcFHLVHs/4iVkw+4eL+p5RlhkAkywMUl2Iz
	FSBlI6hQdcjFGHPHGSmncD4B4LpYKnw=
Date: Mon, 23 Jun 2025 11:16:08 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Saravana Kannan <saravanak@google.com>,
 Leon Romanovsky <leon@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 linux-arm-kernel@lists.infradead.org
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-5-sean.anderson@linux.dev>
 <16ebbe27-8256-4bbf-ad0a-96d25a3110b2@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <16ebbe27-8256-4bbf-ad0a-96d25a3110b2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/21/25 03:33, Andrew Lunn wrote:
> On Thu, Jun 19, 2025 at 04:05:37PM -0400, Sean Anderson wrote:
>> Returning EPROBE_DEFER after probing a bus may result in an infinite
>> probe loop if the EPROBE_DEFER error is never resolved.
> 
> That sounds like a core problem. I also thought there was a time
> limit, how long the system will repeat probes for drivers which defer.
> 
> This seems like the wrong fix to me.

I agree. My first attempt to fix this did so by ignoring deferred probes
from child devices, which would prevent "recursive" loops like this one
[1]. But I was informed that failing with EPROBE_DEFER after creating a
bus was not allowed at all, hence this patch.

Limiting the number of deferred probe attempts (at least before
continuing to boot) is a good idea in theory, but would not address the
root of the issue. Setting a good threshold is not obvious, since there
are almost certainly systems out there that are missing some device
links and have a lot of deferred probes. 

--Sean

[1] https://lore.kernel.org/all/CAGETcx-koKBvSXTHChYYF-qSU-r1cBUbLghJZcqtJOGQZjn3BA@mail.gmail.com/

