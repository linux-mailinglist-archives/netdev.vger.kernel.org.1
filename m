Return-Path: <netdev+bounces-72970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA2285A731
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 16:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6161F1C212C5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956337704;
	Mon, 19 Feb 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiHrWfZh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646E3984D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355801; cv=none; b=GQrYPbnySu6zEqisxniz4s+kxT1sHvirSoz2xtB6OjWJyNG1bPZUnwqrafUtzwuMaVPzonYtuYSydnYF2BoNaIoPA/S+Qxmaoj/4Cr+wetKLv7oqiSqu9gQ6B7YcyF9agKwlE7F4rpH6MbceqDqTpxBroT5h+STw3o0JSZCruZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355801; c=relaxed/simple;
	bh=Kqf1k1OnKD+/fHJ/GoeK/SXlY+uPPpzpeTE2a4L5IIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic1iZXkFRJerzGytfrqlkZ83djJRvCrhmGSnjqq/1qGR8rPo86Pvnza9xM4zOF5lGsI4orWG9ZW2dvfckhBmmd0DISeKrPM8wzUoSqLkWS3uy8S43zG4kv8ilAd+UnfY9oTOM/HeSOJaz4AJ2Ip3kQ0TGx60rEzIzMCW2atEWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiHrWfZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9826CC433C7;
	Mon, 19 Feb 2024 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708355801;
	bh=Kqf1k1OnKD+/fHJ/GoeK/SXlY+uPPpzpeTE2a4L5IIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiHrWfZhEn0Whacp+Gan0hp4xKM8R3HmDvN3bzFWm76eSL0f+EHMpP+p7hf6uMXjS
	 MRqdPGrb+4a4lJW8opxo3O9l8nh30eNKUb4ibGfGKyZImml7Q0/KXRs6LacFnrZmMH
	 0JkE7+fnqr0yKUO/r54WDI6CJaU8YgQiJsErZE8iYklrYnQAbXNBj2mRZ9RnbZLSjI
	 DIOJn6otqBxnt+m++Abto1uq10UBflFJJKHtfYdDwjlDsEgnI2s0utX5lcZIxHslo5
	 su/Qv5T9RT9Si9q3hvmByu/7F6pDmX4lxScFcVhdHW58YRe4yvRUYtKU31M2wPQ06d
	 FSqGfBhvK0whw==
Date: Mon, 19 Feb 2024 15:16:38 +0000
From: Simon Horman <horms@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] net: skbuff: add overflow debug check to pull/push
 helpers
Message-ID: <20240219151638.GD40273@kernel.org>
References: <20240216113700.23013-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216113700.23013-1-fw@strlen.de>

On Fri, Feb 16, 2024 at 12:36:57PM +0100, Florian Westphal wrote:
> syzbot managed to trigger following splat:
> BUG: KASAN: use-after-free in __skb_flow_dissect+0x4a3b/0x5e50
> Read of size 1 at addr ffff888208a4000e by task a.out/2313
> [..]
>   __skb_flow_dissect+0x4a3b/0x5e50
>   __skb_get_hash+0xb4/0x400
>   ip_tunnel_xmit+0x77e/0x26f0
>   ipip_tunnel_xmit+0x298/0x410
>   ..
> 
> Analysis shows that the skb has a valid ->head, but bogus ->data
> pointer.
> 
> skb->data gets its bogus value via the neigh layer, which does:
> 
> 1556    __skb_pull(skb, skb_network_offset(skb));
> 
> ... and the skb was already dodgy at this point:
> 
> skb_network_offset(skb) returns a negative value due to an
> earlier overflow of skb->network_header (u16).  __skb_pull thus
> "adjusts" skb->data by a huge offset, pointing outside skb->head
> area.
> 
> Allow debug builds to splat when we try to pull/push more than
> INT_MAX bytes.
> 
> After this, the syzkaller reproducer yields a more precise splat
> before the flow dissector attempts to read off skb->data memory:
> 
> WARNING: CPU: 5 PID: 2313 at include/linux/skbuff.h:2653 neigh_connected_output+0x28e/0x400
>   ip_finish_output2+0xb25/0xed0
>   iptunnel_xmit+0x4ff/0x870
>   ipgre_xmit+0x78e/0xbb0
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Simon Horman <horms@kernel.org>


