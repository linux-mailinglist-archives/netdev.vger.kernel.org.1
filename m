Return-Path: <netdev+bounces-239703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A70FC6B9F3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3697C382D78
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7509333C1AF;
	Tue, 18 Nov 2025 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbiDW1IC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100A2F617B;
	Tue, 18 Nov 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497475; cv=none; b=bFvz8F/lo7d2wnOl5V/sQfBpHYBfG4cQ3BX1kxDAFKS2LsjJofoZlWFTR3qZUOXgoOz38WiBJoc4UK40nMPGHRJfakXy8Rfk11OMKqTPVjz7ZoTKdcUMmniXVnyy++v938Ly67+XYdGxHcUtDcOZ77Q3Ta9s4+XikyU1szJZZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497475; c=relaxed/simple;
	bh=Q8olBVnZEAzUcW+zVw/ny0i3wL3dDPF5Wf+3Nc1j/+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkmBbinN8OECyqUJB/vi3rhC4+EGAotJNcUIYr6xmsm+2ajBj89vKBttU0AEooYyQJEkQvyPaJ6Aahfl02DzvA71f+LRL7tnDowGQq+chYR10f7TRmvbmMVLwaJmxM80+yPGWwicw/IdGFMEm3A4jGTl6hRcCTinOb/X3lMJasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbiDW1IC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6021C2BC87;
	Tue, 18 Nov 2025 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763497472;
	bh=Q8olBVnZEAzUcW+zVw/ny0i3wL3dDPF5Wf+3Nc1j/+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NbiDW1ICA+TF6h7y/gbxuxxRkVUlxzkQwpVlPKwtBT/CHb8EgfHiUY5o7ogzAdaeG
	 9e1GwIVLdxaZmB7Y+Hf0VY8bnYfJBdBZiLb54TUni16nLAJR9oCA1d6Ey6m/NiRzAq
	 4y9UodQj+fAFzxwKgwU3NnJFiLkJT88HSPadDOyYTDl+YJNQmCnK272BN+eGPS/4H/
	 zKtgZs8oVGtiN4HP4ju/wyC7m9ufDGDxw5GOKfjZ03H9h6+Tm2oN+7+Npm8P4DPTtH
	 ZCJ9ALSDr3WME8L32CHNCf4t+DajyDAMee3EgfmjYcb0XI51XfpJv8GfY+nF10y1oC
	 MmtivsLQH6ymw==
Date: Tue, 18 Nov 2025 12:24:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: jiefeng.z.zhang@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org,
 irusskikh@marvell.com
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX
 path
Message-ID: <20251118122430.65cc5738@kernel.org>
In-Reply-To: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 15:04:02 +0800 jiefeng.z.zhang@gmail.com wrote:
> From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
> 
> The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
> fragments when handling large multi-descriptor packets. This causes an
> out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.
> 
> The issue occurs because the driver doesn't check the total number of
> fragments before calling skb_add_rx_frag(). When a packet requires more
> than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.
> 
> Add a check in __aq_ring_rx_clean() to ensure the total number of fragments
> (including the initial header fragment and subsequent descriptor fragments)
> does not exceed MAX_SKB_FRAGS. If it does, drop the packet gracefully
> and increment the error counter.

First off, some basic Linux mailing list savoir vivre:
 - please don't top post
 - please don't resubmit your code within 24h of previous posting
 - please wait for a discussion to close before you send another version

Quoting your response:

https://lore.kernel.org/all/CADEc0q6iLdpwYsyGAwH4qzST8G7asjdqgR6+ymXMy1k0wRwhNQ@mail.gmail.com/

> I have used git send-email to send my code.
> 
> As for the patch --The aquantia/atlantic driver supports a maximum of
> AQ_CFG_SKB_FRAGS_MAX (32U) fragments, while the kernel limits the
> maximum number of fragments to MAX_SKB_FRAGS (17).

Frag count limits in drivers are usually for Tx not Rx.
Again, why do you think this driver can generate more frags than 17?
-- 
pw-bot: cr

