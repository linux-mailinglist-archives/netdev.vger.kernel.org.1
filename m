Return-Path: <netdev+bounces-103324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30149079C2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F821C24D0A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23344135A71;
	Thu, 13 Jun 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3mFxOZt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5886136
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718299403; cv=none; b=J99bTz30yCzorqUwDykDyua+GgjEW2KWuI1cc0n3IeY/pW/0aY4kmfopPPYkXM9a6A32pArJZBeNcIvV+IJAR9n7tdr7fwoVNTbufQRZAFz7L5CBUhjZykIe2QIEv5b84KSWFtiGUstfKmMDSStYH5vVbjdwhEDRBbKvemxR+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718299403; c=relaxed/simple;
	bh=e6rKQpRlmAH1EX8gKCOUsRHowPiyIj3aOyUvXvTlxw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSL9J7lmSoH8fV1ZOI0DuRsQmV2mA+pS8OZWk7slvcTEV30n/vMZh7HFCbu/ZsBRZCIlQRD1VZ76POXG64nWPO9pWTC2kKYR0jnpxd0vHB6JX5TecKUI2FIEf0CDg2gAlBQIzDJsfKPfDZRJ0j4jhbeOfK9ELa6JFgjwBJUAJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3mFxOZt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718299401; x=1749835401;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=e6rKQpRlmAH1EX8gKCOUsRHowPiyIj3aOyUvXvTlxw8=;
  b=b3mFxOZt50n83fVSG/KnWaySaCmJC6/xMy7D7Jf2ZFp7HRbeHaOxO3xY
   qjx6s7658BStUBz+wBV7xM3CRrwxo8E41P52xrqOn67/JcOYtmwXCcZwS
   JQ8sEEcpwLrCrC7i8IidEQQ6LyRkpMVhZuCK5RqUFynPH8zHQsUS3909P
   99n1LXAGpQ5oQjQjTYYnvFtTmZ4tlyaY0T+gtKEtx6QuAGaSmRvuYbmtM
   rdcV5p1R/9udGds7BnOFUyy4VYHrZ79kzSLWQyrTZp/q8HyuIIofgk9Av
   lmp7vq7qZU/0vIaVyYcKt8tBjX8kHi+2rDb4BqCpX1IZAorqDOSqfufkO
   Q==;
X-CSE-ConnectionGUID: BT3Y1K1ORi67TKyYIeV8vg==
X-CSE-MsgGUID: 3cngvZp7RO+U3QfexkLrQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14872183"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="14872183"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 10:22:36 -0700
X-CSE-ConnectionGUID: hHZs3CiiRqyGTWeE/3mU9w==
X-CSE-MsgGUID: 5kLqhRwWRm6CdGteSgRC1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40078523"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.223.58])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 10:22:35 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next] igc: Get rid of spurious interrupts
In-Reply-To: <20240613062426.Om5bQpR3@linutronix.de>
References: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
 <87sexi2b7i.fsf@intel.com> <20240613062426.Om5bQpR3@linutronix.de>
Date: Thu, 13 Jun 2024 10:22:35 -0700
Message-ID: <87ikycwyec.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-06-12 12:49:21 [-0700], Vinicius Costa Gomes wrote:
>> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> > index 305e05294a26..e666739dfac7 100644
>> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> > @@ -5811,11 +5815,23 @@ static void igc_watchdog_task(struct work_struct *work)
>> >  	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
>> >  		u32 eics = 0;
>> >  
>> > -		for (i = 0; i < adapter->num_q_vectors; i++)
>> > -			eics |= adapter->q_vector[i]->eims_value;
>> > -		wr32(IGC_EICS, eics);
>> > +		for (i = 0; i < adapter->num_q_vectors; i++) {
>> > +			struct igc_ring *rx_ring = adapter->rx_ring[i];
>> > +
>> > +			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
>> 
>> Minor and optional: I guess you can replace test_bit() -> clear_bit()
>> with __test_and_clear_bit() here and below.
>
> That are two steps, first test+clear is merged into one and then __ is
> added. The former is doable but it will always lead to a write operation
> while in the common case the flag isn't set so it will be skipped.
> Adding the __ leads to an unlocked operation and I don't see how this is
> synchronized against the other writes. In fact, nobody else is doing it.
>

I just took a look at the available operations, and thought that this
one could save a few lines of code. But didn't think too deeply about
that. Thanks.


Cheers,
-- 
Vinicius

