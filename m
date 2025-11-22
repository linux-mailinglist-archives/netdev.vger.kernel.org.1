Return-Path: <netdev+bounces-240925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE68C7C192
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 02:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 560884E0356
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E63287269;
	Sat, 22 Nov 2025 01:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpLKmaPe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8F239E80
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775382; cv=none; b=s8cS0DBQmwFw0LZ88GY/QIrSYC61HpenE50ZBP6yq/a7SCLdURCDVuB/zoJAurWbJWhwz5p1Gk5hXgLU5v5UbCqYagL1YHDYwB3CKuqs03RWwlOhKz0XK1RU1ueZNzzcFkgLDjVJl/dtpzJJjgfC6OlQT1nEEpcdp0sKLJgL/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775382; c=relaxed/simple;
	bh=kuI0GP+ShTf7R/XL76GGtF+acOQYlgcj3X+TMQ43+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdpeUbEaysEe7m0QS3OzHD6g6LDnVC+bzBAyWBLB+PkvaoXpE0zkpdU6wLuOxF+Tz0fx4yStI/NEPI0LkxpvSaxoUSZs6gFYyKjtuxrH4rU9tes5IUNWpENSvVVIxbgR90ntucLEt9q/VRQAyMu+M7jaKqrGS9LW0BBuPTQZ2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpLKmaPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A7CC4CEF1;
	Sat, 22 Nov 2025 01:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775380;
	bh=kuI0GP+ShTf7R/XL76GGtF+acOQYlgcj3X+TMQ43+TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WpLKmaPekYRo7LyVqOB9gwyPGKdLZlomT7o5K057XTh7GoIpjhGjdX0dWGTV41RLP
	 a8HqXMPhyTz3tCcNbyrm9OCshy5WCpQvIkOoGvn8cg7uQtBvEVOH5dmTfOH4R/2+xD
	 eJbEzgOVoAc1WfYDGd7/VEN8Ak96l8c5weAUdb/KdsHaU1LXGhgrJgAFzI9AvlzbAk
	 JNL96eztqU+DsI4GK/QeDUfkAZo+v2oB5jD6A2HDcR7UjkhjINvC6MLBAMfkXIQaqz
	 PCdSm502UfJA32jFOgVIAHK5oc8+VuvePheTE5+GIfEtiydbqHmeBPcr9bwT5igM9I
	 mFSM1Gb6Rcg/g==
Date: Fri, 21 Nov 2025 17:36:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 5/7] selftests/net: add bpf skb forwarding
 program
Message-ID: <20251121173619.32584592@kernel.org>
In-Reply-To: <214709f6-e9e8-471a-9913-26e2ee438fc1@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-6-dw@davidwei.uk>
	<20251120192045.1eb4a9b0@kernel.org>
	<214709f6-e9e8-471a-9913-26e2ee438fc1@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 09:40:56 -0800 David Wei wrote:
> On 2025-11-20 19:20, Jakub Kicinski wrote:
> > On Wed, 19 Nov 2025 19:30:14 -0800 David Wei wrote:  
> >> This is needed for netkit container datapath selftests. Add two things:
> >>
> >>    1. nk_forward.bpf.c, a bpf program that forwards skbs matching some
> >>       IPv6 prefix received on eth0 ifindex to a specified netkit ifindex.
> >>    2. nk_forward.c, a C loader program that accepts eth0/netkit ifindex
> >>       and IPv6 prefix.
> >>
> >> Selftests will load and unload this bpf program via the loader.  
> > 
> > Is the skel stuff necessary? For XDP we populate the map with bpftool.  
> 
> I have no idea what I'm doing with bpf and was copying from
> libbpf-bootstrap :D I'll use bpftool to attach the bpf prog to tc
> ingress + set the vars. If xdp is using bpftool then I presume it is
> already a dependency on the DUT?

Yes, FWIW tools/testing/selftests/drivers/net/xdp.py is what I meant by
XDP

