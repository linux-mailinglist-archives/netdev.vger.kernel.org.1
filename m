Return-Path: <netdev+bounces-214517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA41B2A01E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0EC18A02E2
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286430FF23;
	Mon, 18 Aug 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s9PdbNxY"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB5261B75
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515388; cv=none; b=gGfT0c+JM/TldMsU+RtLwfCzAMdiHW6a4Z/+Csyh8Z78zV6jeYwfy1nKIRG1C2c4sUyS5Pxw3z9A7KrVlCcb5pp9k4LpOBcXvvio/LhS+fSG3rdbhMCff+4Q8PFXn2KxsD0KXuziaPI0/IC1nJv75I79njvZ7KyQzmxQ4eHstEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515388; c=relaxed/simple;
	bh=OR2DYq8Rl0wyBBPU7bl3PHpoIKLvpH9ZHB/YJ+Qzhyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNtMjDLjQe0q+vqfPHvYH+tlO2m17UldyIQMvknuHuFacB6sxV3TJAzVa/gjkl0Vxa5TqZrTIzY390I+zB/Gzw2Hh9jiTP013/RW9K+hCTvHln1j8i1qfWdgY10fCAmrB31wroRvFG7esjfd8WF+M7otczbX6jwQ2GYW+++pacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s9PdbNxY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dcce0303-8184-4ed0-a26d-f85dc469ab46@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755515374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiI4Lo7dgIKpq91EheYYdUeo63Zgn5fpMIaRzAbNtFE=;
	b=s9PdbNxY9pt01nUa/jDZlrc+V5+s6LqfC6YacW8Hblt8ku4JeoJpyd5TUX7g/Sw5YiVcv3
	hXv8EZVYrlBG02zBty/PaGxfBLdVdWYiN78A+fcGe7nDVHfCz959hT1n05mauxBVogpjIm
	BxJinPaeDGpMAW/2zd/bo02+VeKPnbE=
Date: Mon, 18 Aug 2025 12:09:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, rosenp@gmail.com, christophe.jaillet@wanadoo.fr,
 viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com, atenart@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/08/2025 09:10, Horatiu Vultur wrote:
> There was a problem when we received frames and the frames were
> timestamped. The driver is configured to store the nanosecond part of
> the timestmap in the ptp reserved bits and it would take the second part
> by reading the LTC. The problem is that when reading the LTC we are in
> atomic context and to read the second part will go over mdio bus which
> might sleep, so we get an error.
> The fix consists in actually put all the frames in a queue and start the
> aux work and in that work to read the LTC and then calculate the full
> received time.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> v3->v4:
> - remove empty line
> 
> v2->v3:
> - make sure to flush the rx_skbs_list when the driver is removed
> 
> v1->v2:
> - use sk_buff_head instead of a list_head and spinlock_t
> - stop allocating vsc8431_skb but put the timestamp in skb->cb

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

