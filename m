Return-Path: <netdev+bounces-103089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD49906402
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 08:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25F8285093
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741D13698D;
	Thu, 13 Jun 2024 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmey8kFz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="77i2TfOn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBE135A4B
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259871; cv=none; b=R9lTHcKCZM2h71Pagc9erU5iKZ93rHHZtJchi4LHAUIvSkFdJV9ZTTAYy+IfOQ2Rylx7q1vc9qA1uGMETt4WgczL7zEzZgOi9/ThI+ein4sGlQz5mA+BP9wqnEnylquqBYg/wz7qxNrTF+xm3qxprtZI6hRb+Q3COMaHYfdfOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259871; c=relaxed/simple;
	bh=++QBLxfIGEfI/6MFJ8ZTewcLVbgbhL8bzVpPAw9gl3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTrvbdN5a17L3mIqF1iFeZe4K0OPRwiV4fb2rzQKNALYz7s2f5hyllLdLb49Mc9TlGBnf/huvN/yZBW9Yvf4Cy14w/dFmTUFAhNfC5mvxipMw0zziG2B1K0u21TuLw7/6WjJj/xI7wMkzf8uoO5oOQFwYc31YrSNU3rmzZH2deM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmey8kFz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=77i2TfOn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Jun 2024 08:24:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718259867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggWtUz970+22vIg8AApyNoSovE25dgcCqbLcSQYA7ss=;
	b=dmey8kFzxUJnouRynx6sLFJpldCURUSbiAiTajD5k03Q4UVlytx1xxnIn3XTPR0EtmtCY5
	sNlouWWXpsh3vM+dmn6zTud75A8P87N+6GQxMkJTrRkhR3qr4HV/V5U2SP/cEFmADRfT2o
	BwSH073nFXG5eYFFrTrGGKSEs66RuckkOrTlP1CDHLFimOUy71PWm69uFcXCIRLsSTIV9c
	O64Dqu9nEtbpS/gSHVHIc1nu7lYPAE+BIDtJlcTZrsiy50sGM03eva9Nh0BYg2wKdEb8uI
	vU8gtKUQV8cfk9CPwwgDzYftLaoOOJpuF1kKwmBZ1QUhNDxz4nEqNtDryyfGEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718259867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggWtUz970+22vIg8AApyNoSovE25dgcCqbLcSQYA7ss=;
	b=77i2TfOncktpUw7ZTTtHDJja9aripZJhBwDzcQvqkEB7y/2Rlrz4kkx/yZdcHAO1ct6gcn
	pY3REh8SpInUnSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
Message-ID: <20240613062426.Om5bQpR3@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
 <87sexi2b7i.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sexi2b7i.fsf@intel.com>

On 2024-06-12 12:49:21 [-0700], Vinicius Costa Gomes wrote:
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 305e05294a26..e666739dfac7 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -5811,11 +5815,23 @@ static void igc_watchdog_task(struct work_struct *work)
> >  	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
> >  		u32 eics = 0;
> >  
> > -		for (i = 0; i < adapter->num_q_vectors; i++)
> > -			eics |= adapter->q_vector[i]->eims_value;
> > -		wr32(IGC_EICS, eics);
> > +		for (i = 0; i < adapter->num_q_vectors; i++) {
> > +			struct igc_ring *rx_ring = adapter->rx_ring[i];
> > +
> > +			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
> 
> Minor and optional: I guess you can replace test_bit() -> clear_bit()
> with __test_and_clear_bit() here and below.

That are two steps, first test+clear is merged into one and then __ is
added. The former is doable but it will always lead to a write operation
while in the common case the flag isn't set so it will be skipped.
Adding the __ leads to an unlocked operation and I don't see how this is
synchronized against the other writes. In fact, nobody else is doing it.

Sebastian

