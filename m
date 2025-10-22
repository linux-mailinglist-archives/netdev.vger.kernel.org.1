Return-Path: <netdev+bounces-231704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C596FBFCCE7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4BC3A18B6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54333126BA;
	Wed, 22 Oct 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uig4t4GZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D62F532C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145806; cv=none; b=JUEd5BX8XovLjw+5EEORbDfEebCUDGC7R0a4U4JphocAyQwBe12QgLk2Tzo6Y0b44THf3Sf0SePMgJ6TKDPB8gMS0gyxkhkpqF6sS/gYBpAeezgGRh7dtaDNS0NRm5QO0gAki1pr8Z9uL+j5KWnN4XlNim/HYkGy3SGtIwfAaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145806; c=relaxed/simple;
	bh=SpGvwNJis6Zu0e6/FMrDfaX9Es2m9U81jmSJ8Xbxzso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFQQ/KYjCTfnXVxjinGcfpy7ZOoJhRlwncVhHjbjzk3pJfCVGKNUSZ3Jv6jrRfCVHLBqvmpHmrQJ3I+ScXLtQ5NODCF3NkE41FAc+DnzuLy9nUe3q9hi1Jd1QjgaZ1RBtxXAHdTDz59dLaM5wt4jnZ8j8cEoP9BrJxIc0lU0BEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uig4t4GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C121C4CEE7;
	Wed, 22 Oct 2025 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761145806;
	bh=SpGvwNJis6Zu0e6/FMrDfaX9Es2m9U81jmSJ8Xbxzso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uig4t4GZLD2w5cWJ6qaQEghtUWchxU5ueFFhy/GFwaV1a4jfyG8O7xqywrMW5V+gd
	 Gz1Gu6GxIWDdcRGvcbqqqK5YUHTj4sFVeYD6S+YjEc25q8T4hSWBuAunGg2NNhf8X5
	 bMg7etsNd5nemnAUJrZBoa93CJf2yTuW4ZmruZRK6K4v4i70uEDejqd5eVCPPfn8lF
	 GkfilVq+J3EUwVS2JgruzlAIvydKDq6CqlCyBGeUAFCG79CmhLj7LLFZ1iBv1SXjli
	 Hc/GcNxAodjW657CDaWTOD9F/6Fc9Y1Hoflni2UJGomFy+maGuaQRpQwSMoJgHshJE
	 DuFfi7FW7xkTA==
Date: Wed, 22 Oct 2025 08:10:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <20251022081004.72b6d3cc@kernel.org>
In-Reply-To: <aPjjFeSFT0hlItHf@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
	<20251022062635.007f508b@kernel.org>
	<aPjjFeSFT0hlItHf@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 16:58:45 +0300 Ido Schimmel wrote:
> On Wed, Oct 22, 2025 at 06:26:35AM -0700, Jakub Kicinski wrote:
> > On Wed, 22 Oct 2025 09:53:46 +0300 Ido Schimmel wrote:  
> > > Testing
> > > =======
> > > 
> > > The existing traceroute selftest is extended to test that ICMP
> > > extensions are reported correctly when enabled. Both address families
> > > are tested and with different packet sizes in order to make sure that
> > > trimming / padding works correctly.  
> > 
> > Do we need to update traceroute to make the test pass?  
> 
> It shouldn't be necessary. There is a check to skip the test if
> traceroute doesn't have the required functionality. I'm testing with
> version 2.1.6 on Fedora 42.
> 
> If it's failing, can you please run the test with '-v' and paste the
> output? I will try to see what's wrong. I didn't see any failures on my
> end with both regular and debug configs.

bash-5.2# traceroute -V
Modern traceroute for Linux, version 2.1.3
Copyright (c) 2016  Dmitry Butskoy,   License: GPL v2 or any later


# 19.86 [+19.86] TEST: IPv6 traceroute                                               [ OK ]
# 42.27 [+22.42] TEST: IPv6 traceroute with VRF                                      [ OK ]
# 74.83 [+32.55] TEST: IPv6 traceroute with ICMP extensions                          [FAIL]
# 74.83 [+0.00] Wrong incoming interface info reported from R1 after name and MTU change
# 92.09 [+17.26] TEST: IPv4 traceroute                                               [ OK ]
# 109.25 [+17.16] TEST: IPv4 traceroute with VRF                                      [ OK ]
# 143.04 [+33.79] TEST: IPv4 traceroute with ICMP extensions                          [FAIL]
# 143.04 [+0.00] Wrong incoming interface info reported from R1 after name and MTU change
not ok 1 selftests: net: traceroute.sh # exit=1

