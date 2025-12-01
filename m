Return-Path: <netdev+bounces-242935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF32C96999
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1503A3789
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263CA30216F;
	Mon,  1 Dec 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoCgp+dQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1C30215C;
	Mon,  1 Dec 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584056; cv=none; b=naOQgqzH+a3+hxiDpvkd66OiYvS++7YYmDe0eXH4qlrF6LVE2q/0aI9Nsr2F3YfZcHT8OX6K3q9gQlNJmGUmhjAjVkeUHFUPEBTsalR5qJmvrqb79UaVxe1O4lCveepD+mRFfSA4OrM+nA0Lc0RV9cVLzExHMte6ZZWNUjtk0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584056; c=relaxed/simple;
	bh=jbH32GfphK99V2xFL7pk3dVlmunWspL46P+bLaITSAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2Xv5EPIyP7lA0icaDAg1yIKKWMYv5LFm9+zslTWUcPbSW1FdkbGhn7V/p044OzkTE29Hvcdbtn61gvcS6LuXqw/ktHPb3Z3jxFa6yjoyFg1Re7x7qLUIr3u6HbpiEXKT0zWeQXgV6kHK06vIQMlyVlmrAHYIt3TIwxkJPBk7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoCgp+dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9177FC4CEF1;
	Mon,  1 Dec 2025 10:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764584055;
	bh=jbH32GfphK99V2xFL7pk3dVlmunWspL46P+bLaITSAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LoCgp+dQTz1kUiasiV0fk3XCrCLAHz2QpTtnOrJYj3XqU1yDONA+FZGf4b/w9MgCB
	 S+9hYNwmGcLu+c0T6KsY2NjpsZaMuYxxwdmiKJsPTg4l2apgtyb4fw+WXI3Vs/MTSr
	 1YDiFjeI0xRpuEYriXU/2pD3FX61lztAjX1OUM6kvdVQizdl8dleaw5+iD6rkbKnNF
	 HpC9gkUKcDwNDcbyludPUXDCowsrDrTi4/wp+jgJ99b1HJ92Az40+hUXvkiS9G7g9/
	 oIuhmEvJjxL//hxS3FKZ0SkYy7oR7veieWSZPWNGPUnDEGLuemhQ1YunqI/zeONjho
	 f/RaCiRhOnlUQ==
Date: Mon, 1 Dec 2025 10:14:10 +0000
From: Simon Horman <horms@kernel.org>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ps3_gelic_net: Use napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <aS1qciHDiLaK-c2f@horms.kernel.org>
References: <20251130194155.1950980-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130194155.1950980-1-fuchsfl@gmail.com>

On Sun, Nov 30, 2025 at 08:41:55PM +0100, Florian Fuchs wrote:
> Use the napi functions napi_alloc_skb() and napi_gro_receive() instead
> of netdev_alloc_skb() and netif_receive_skb() for more efficient packet
> receiving. The switch to napi aware functions increases the RX
> throughput, reduces the occurrence of retransmissions and improves the
> resilience against SKB allocation failures.
> 
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
> ---
> Note: This change has been tested on real hardware Sony PS3 (CECHL04 PAL),
> the patch was tested for many hours, with continuous system load, high
> network transfer load and injected failslab errors.
> 
> In my tests, the RX throughput increased up to 100% and reduced the
> occurrence of retransmissions drastically, with GRO enabled:
> 
> iperf3 before and after the commit, where PS3 (with this driver) is on
> the receiving side:
> Before: [  5]   0.00-10.00  sec   551 MBytes   462 Mbits/sec receiver
> After:  [  5]   0.00-10.00  sec  1.09 GBytes   939 Mbits/sec receiver
> 
> stats from the sending client to the PS3:
> Before: [  5]   0.00-10.00  sec   552 MBytes   463 Mbits/sec  3151 sender
> After:  [  5]   0.00-10.00  sec  1.09 GBytes   940 Mbits/sec   37  sender

Hi Florian,

Thanks for the rest results and confirming this has
been exercised on real HW.

Thinking out loud:

* I see that the napi_mode argument to gelic_descr_prepare_rx ensures
  that napi_alloc_skb() is only called from softirq context.

* I see that the driver already calls napi_complete_done() in
  it's poll callback, a pre-requisite for using napi_alloc_skb().

So as I understand things the use of the NAPI API by this patch is correct.

And this provides a nice example of the advantages of using this part
of the API.

Reviewed-by: Simon Horman <horms@kernel.org>

