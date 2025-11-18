Return-Path: <netdev+bounces-239300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3AEC66AF0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD7B036040F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF862F0C79;
	Tue, 18 Nov 2025 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUulNNBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B392DE713;
	Tue, 18 Nov 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426526; cv=none; b=BW1ViKQFmD16Dh56YjkRLI2HiV/ENamfzbKBzVFkB0zK3bxaSDrxOuALmCS0Iu9oqJD4HFAqWmloXXlv21E1e6QF9aTGkRYdahx39y5ckY/h7P7UA+TxcfFhvnGq9jFMfOZYWXrKcKNv1AIa6UZwOvDGDns3VrSem95VKitiVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426526; c=relaxed/simple;
	bh=/GKsD0BhufTJ6wRfNulFoQMdWWtwIMQAwE64QvEwZ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiFL7Jz0ogQL5wwZdDHSTkeO/T/u49N9imsqi+eL6z4PHcLE/EOedGwghQwdMMUk9f7cILBzIJssi4rQ0ghq4r4na3mikfbwZbkpilQtH2SRordaU3A1P4d1j99OeHl0A1UDXWPMhdtxylApjygMXlVWzEymoWSoH1JNdnO9gmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUulNNBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3C0C116B1;
	Tue, 18 Nov 2025 00:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426524;
	bh=/GKsD0BhufTJ6wRfNulFoQMdWWtwIMQAwE64QvEwZ7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUulNNBbzNwtL/T3upy1FGnSFVlZz3EG8qHVVubwJ6VFceLUuWMgEMtoeR80o9Zwu
	 9+HDxaIbwikh0OPBA8isT3u2YoWmWL5mNFKR8S8O4Kz0NybGbu5PWKNdPVK7n2xQCe
	 6OJ0ArIS2AyzfPzemFriH5OxyOhACZMitBiX39agBAQD7xl0ApBKALSZJYYnJfbTkn
	 PPDriXJctTGHYVLY2lbaMWNtIeiDVCJb1h/2MyMYI3+dbl5C6WGNAdIIcQTaC9mvjn
	 GwbP0huZsiGhREVC4UWeF7VEIK5C/X+1cuqApfTe3XjC+bjzSmqh4PVDiMHnadGAZv
	 hoINreWRbrs3w==
Date: Mon, 17 Nov 2025 16:42:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiefeng <jiefeng.z.zhang@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: fix fragment overflow handling in RX
 path
Message-ID: <20251117164201.4eab5834@kernel.org>
In-Reply-To: <CADEc0q5uRhf164cur2SL3YG+fqzbiderZrSqnH2nY0CkhGHKTw@mail.gmail.com>
References: <CADEc0q5uRhf164cur2SL3YG+fqzbiderZrSqnH2nY0CkhGHKTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 19:38:54 +0800 Jiefeng wrote:
> From f78a25e62b4a0155beee0449536ba419feeddb75 Mon Sep 17 00:00:00 2001
> From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
> Date: Mon, 17 Nov 2025 16:17:37 +0800
> Subject: [PATCH] net: atlantic: fix fragment overflow handling in RX path
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

This submissions is not formatted correctly. Use git or b4 to send your
code. Please also make sure you read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

As for the patch -- what's the frag size the driver uses? If it's 
larger than max_mtu / 16 the overflow is impossible.

