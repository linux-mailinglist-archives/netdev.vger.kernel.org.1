Return-Path: <netdev+bounces-115359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FC4945FA2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF61F2178E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0261E4865;
	Fri,  2 Aug 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLAp8leG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299351F94C
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610105; cv=none; b=GAq+m51zGKqJKnZrOAW7otSwkxCwxXafkDoJE3yHCdFEpn/5+avvEEVPKCGGd45+jiaugtu9jBVCVqxQmy7uoJWwGt/8cs8djQbrzlNbFHfhZAThnsgcy80RIuKtMESG4feRIshKJZmrIPozUuGg9yGxIQrwqzvFhPV9iOgQ8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610105; c=relaxed/simple;
	bh=6vOJfKxeHCTX5DPvS49P6LOIvobGGrzQSq2y97G5Ka8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpuQnGxPPPZ6HbShUzspXccari9yo7hXBtGSSLxQ3OFI5pDMjjj5jG1DfZBz14+cLCaGyEdcKn3JTevJfoEqGcksfpiLiR3OmUwBOOmk2mDPYv0JJqZos/Jkvs+0hbhZpyGIuK4Mg+j6XHBzouH7ItCB34pehdE/qlvdcdYA1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLAp8leG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97607C32782;
	Fri,  2 Aug 2024 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722610103;
	bh=6vOJfKxeHCTX5DPvS49P6LOIvobGGrzQSq2y97G5Ka8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kLAp8leGmdSYZ5CF2JPUesQxKJTMZhKikhnktJ/MwA20YECnfpaEWgYBK3AZoyJmS
	 /odRsdw6SkF457YIyxStPnorhO5wPFU4bw4MaamVqkhvYaHGXydQ2VPLNFd77pO9py
	 xSOwYEfJGwy7zaUYkOIwExqDo58imAlPdBjtg5/oKKpie3reuplzLi1g0MZvt7xg/n
	 F0pze3FRryzwsHXQapoki6CFSIsGt4H9X0WLM3YG7VxPuCji70N9UVWGaYrBc1UnMD
	 tYal72+M5WLwvcOwyYarnR6rst+9vi7s4AU7naUMkUyfJLf08BbFf0plP+9kts7YlI
	 Iy84tv+EfMnhA==
Date: Fri, 2 Aug 2024 07:48:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next] net: skbuff: sprinkle more __GFP_NOWARN on
 ingress allocs
Message-ID: <20240802074822.403243ef@kernel.org>
In-Reply-To: <CAL+tcoBNPUCCBhH_7iy4cNXQ0Mtrpe597DXos+s+NS7FVQ__zg@mail.gmail.com>
References: <20240802001956.566242-1-kuba@kernel.org>
	<CAL+tcoBNPUCCBhH_7iy4cNXQ0Mtrpe597DXos+s+NS7FVQ__zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 12:52:06 +0800 Jason Xing wrote:
> > and there's nothing we can do about that. So no point
> > printing warnings.  
> 
> As you said, we cannot handle it because of that flag, but I wonder if
> we at least let users/admins know about this failure, like: adding MIB
> counter or trace_alloc_skb() tracepoint, which can also avoid printing
> too many useless/necessary warnings. Or else, people won't know what
> exactly happens in the kernel.

Hm, maybe... I prefer not to add counters and trace points upstream
until they have sat for a few months in production and proven their
usefulness.

We also have a driver-level, per device counter already:
https://docs.kernel.org/next/networking/netlink_spec/netdev.html#rx-alloc-fail-uint
and I'm pretty sure system level OOM tracking will indicate severe
OOM conditions as well.

