Return-Path: <netdev+bounces-198283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3CADBC9E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3AFD7A1DF7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D8207A18;
	Mon, 16 Jun 2025 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV+myg+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF74A0C
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111744; cv=none; b=rdt2ozgNreHHZXeriZQaIko/zMRxmvhfHy5PP2xBT+qzn/6RRKR9poe6MymDlk3W8p6t32pVe7+WOWDO+q9f1rWYNf84YgJHTls3364ljWDwM8CmUo6M7m9CjFdqJO4dsReZAnkd/hEA8Zig4ovJdq84WG0o4HymEqNREeKpOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111744; c=relaxed/simple;
	bh=vYJpBTvfuq8Upf0+nkXo+v/e5F2R4i4pocTjq7n+Rko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5hSE0/eu9HRpAMiWU5mOQsDsoJwi4iQloYhBbvUlORYTKHAxXmcXJpqGrULORx543hGmhd37QfxP4zPBVw9VXjY6X4CFnj/vzpP9u16ZbEAoQlSY5h7DgYlFIcaVhemwDfe69+fx398a++UELaM9mx2Jf3LBNMyI38FTik9PZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV+myg+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356D3C4CEEA;
	Mon, 16 Jun 2025 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111743;
	bh=vYJpBTvfuq8Upf0+nkXo+v/e5F2R4i4pocTjq7n+Rko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AV+myg+MbIarm4vd01R9EHeA9vukFt7e5lWxdXVDbvaf3ndCZCuT+xS/gFEymSoF3
	 eTsmakY3gYxjJMlSaQX+SQa6u57ztWHYFrkdBmTujaVShyZk/ZxOYXN04kVGmn0825
	 WCep3DsSjPFaJHT6j0dvbGObX6iP86PHSm9+CnTDjRsDkikjhNebAGZ/IaW6zZFDSM
	 NRMm3Buj2QEIETxP7QyPaE0g9RAjpfeAdDjih8F/eKQ3g1uXu0slRRj2pBzjJsOtpN
	 8IsKtbNLcW4JTe7QlTP40VkTYLonCOfhfRqU2Ff7Drn0fxa/D0J4nDVqK8Az/pED49
	 VwtDeVzTByugA==
Date: Mon, 16 Jun 2025 15:09:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Gal Pressman
 <gal@nvidia.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, "David S. Miller"
 <davem@davemloft.net>, Aaron Conole <aconole@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Eric Dumazet <edumazet@google.com>, Ilya Maximets
 <i.maximets@ovn.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net] openvswitch: Allocate struct ovs_pcpu_storage
 dynamically
Message-ID: <20250616150902.330c4ac3@kernel.org>
In-Reply-To: <20250613123629.-XSoQTCu@linutronix.de>
References: <20250613123629.-XSoQTCu@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 14:36:29 +0200 Sebastian Andrzej Siewior wrote:
> PERCPU_MODULE_RESERVE defines the maximum size that can by used for the
> per-CPU data size used by modules. This is 8KiB.
> 
> Commit 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into
> one") restructured the per-CPU memory allocation for the module and
> moved the separate alloc_percpu() invocations at module init time to a
> static per-CPU variable which is allocated by the module loader.

IIUC you're saying that the module loader only gets 8kB but dynamic
allocations from the code don't have this restriction?
Maybe just me but TBH the commit message reads like the inverse :S

> The size of the per-CPU data section for openvswitch is 6488 bytes which
> is ~80% of the available per-CPU memory. Together with a few other
> modules it is easy to exhaust the available 8KiB of memory.
> 
> Allocate ovs_pcpu_storage dynamically at module init time.

Gal, should we wait for your testing or apply?

