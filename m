Return-Path: <netdev+bounces-102661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F683904185
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C731F21EFB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031DA3FB83;
	Tue, 11 Jun 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dg3k7Hf/"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E51CFA9
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124235; cv=none; b=jYqiL3qLrq0UmmAj+h3jomSzn725W6Z/KAMgYr9pRsTaxN3rhDIkoVophPV/tzEbhZUnZojCMP/3j0sv1AzOx/gLU18GCPyCyKt19wL/rGUerReqCStOJnJ3zUlNV6HPj3/0xtTIzS+kjWomAMJvutYv7WR666iwQFf77fvnqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124235; c=relaxed/simple;
	bh=WRw2FQgOHPBc2G8XHnx0W5o0jbSBg7Godg/uW/XH5XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoaW5IrK29927IYKe5a8i95qDuk9qNUnz7VJw9iNrZUEkNSvBLcrPiagDiWocyJynC8gk0wA5WiaPPVs26YoRVZe95i8BWnqS5BlFzVtmSrTZEDSKi6cO4rhffrw7q//Nn85eghFoy1KEwi7cnb1zqJsBYjNKTOavqLsfeR8RTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dg3k7Hf/; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: andrew@lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718124231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BDVLU3eO/EwCDct2pFFi2rm42Ko7vIZl6fyc22jgNI=;
	b=Dg3k7Hf/nQTK5iphvQSdeQt8pxsI5LS6drfPWq699EOaY9u2Yy9FlT2I9j9iM56R4C60Jb
	3A7pWp5oRsnOAujSjD4oxJ4qb+b9n8jd84qp5Lrcjs4jFpA28B4HbyRqTyMzAGVNjea0Pi
	UsI1+c3HhTC8hYfOb6wpj784Qep5jvY=
X-Envelope-To: radhey.shyam.pandey@amd.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux@armlinux.org.uk
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: davem@davemloft.net
Message-ID: <7eccba8f-2b4d-42cc-8a12-8badc41e1c01@linux.dev>
Date: Tue, 11 Jun 2024 12:43:45 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/3] net: xilinx: axienet: Add statistics support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20240610231022.2460953-1-sean.anderson@linux.dev>
 <20240610231022.2460953-4-sean.anderson@linux.dev>
 <7c06c9d7-ad11-4acd-8c80-fbeb902da40d@lunn.ch>
 <d2cc10a6-0c6a-471a-bd5b-3e939905fc41@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d2cc10a6-0c6a-471a-bd5b-3e939905fc41@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/24 20:29, Andrew Lunn wrote:
> On Tue, Jun 11, 2024 at 02:13:40AM +0200, Andrew Lunn wrote:
>> On Mon, Jun 10, 2024 at 07:10:22PM -0400, Sean Anderson wrote:
>> > Add support for reading the statistics counters, if they are enabled.
>> > The counters may be 64-bit, but we can't detect this as there's no
>> > ability bit for it and the counters are read-only. Therefore, we assume
>> > the counters are 32-bits.
>> 
>> > +static void axienet_stats_update(struct axienet_local *lp)
>> > +{
>> > +	enum temac_stat stat;
>> > +
>> > +	lockdep_assert_held(&lp->stats_lock);
>> > +
>> > +	u64_stats_update_begin(&lp->hw_stat_sync);
>> > +	for (stat = 0; stat < STAT_COUNT; stat++) {
>> > +		u32 counter = axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
>> 
>> The * 8 here suggests the counters are spaced so that they could be 64
>> bit wide, even when only 32 bits are used. Does the documentation say
>> anything about the upper 32 bits when the counters are only 32 bits?
>> Are they guaranteed to read as zero? I'm just wondering if the code
>> should be forward looking and read all 64 bits? 
> 
> Actually, if you read the upper 32 bits and they are not 0, you know
> you have 64 bit counters. You can then kill off your period task, it
> is not needed because your software counters will wrap around the same
> time as the hardware counters.

Yes, but then our stats remain stale forever, because we don't refresh
stats before reading them as detailed in my other response.

--Sean

