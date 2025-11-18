Return-Path: <netdev+bounces-239674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A188C6B49E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99268358943
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133EB2DF700;
	Tue, 18 Nov 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgxkgHY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549B2DF6EA;
	Tue, 18 Nov 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491852; cv=none; b=Lng2G1ahi4F6on7GpcATd4az5JCx/Y7xtLCuSQ5DVucu3VyHpdoSdhzRXFHV9osltMkZLyeRegJ4pXkvm/fMr1YLyNpFL3JltcFn40wcyf4qkruLJYxPvpEk4xJ9XY+0DDf4UB5o0OAhO0NzRKx8cfrp1+eZ1TVic4QwPBJ6uHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491852; c=relaxed/simple;
	bh=izTWAaIRwfEhA3shFOFsm6xfo2cpycmkBR78fGnKC5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJI6Stehj1nbNW2Sht0GW3uvhiQQAQEjzExnpc7ufeIX6YGHTCE6tGfYn4EvCZexPfeivaMHsnSvs2Wxt5Gi6/OZEYAu3WkaJg0s7NveexQei1GKTmpx82aeuKj+DWVTtx6SnIrSAax0z+rmeCqdNrqkLLtt90fCfTqmYKdW8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgxkgHY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B673C2BCF5;
	Tue, 18 Nov 2025 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763491851;
	bh=izTWAaIRwfEhA3shFOFsm6xfo2cpycmkBR78fGnKC5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mgxkgHY1vB06Vs+5qLR2BohSyTtvXGgerZ2Vd2d5LNcbSCcDkcCu/1/1UxUarQJ3y
	 gIQ2SiiQcsMoukVfHab53sOhiz+rCSU+lPrYFbQZap3hygc9pC2ilsCLL55QYCC3Nq
	 XK6WQgIAu94b3+hx9AipIrFxFxG0Jd/b1YuqQkiejIWC6ohG9z1J/kFG8R9D8GWEbK
	 T4xX0TVovRAYj8RlkHaGe3nwEvJ5rxdXqkNVf7/Q7hVSS1uU2839uJW+SIwIpHocu2
	 aryOO9she8I3SwNYDPojNOBijqrfvEK1QpnjiK0ZsxLY81lFD9QOn/DyccDWoPDJYa
	 ES2l4zydZ/qwg==
Date: Tue, 18 Nov 2025 10:50:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, sdf@fomichev.me,
 kuniyu@google.com, skhawaja@google.com, aleksander.lobakin@intel.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
Message-ID: <20251118105047.20788ed9@kernel.org>
In-Reply-To: <CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com>
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
	<CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 22:26:42 +0530 I Viswanath wrote:
> I am sorry that it is broken. I will submit a v5 as soon as possible

Broken as in patch titles or broken as in it crashes the kernel?
Both are true. Just to be safe "as soon as possible" hopefully
takes into account our "no reposts within 24h" rule.
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Also I'm not sure what you mean by RFT, doubt anyone will test this 
for you, and you're modifying virtio which you should be able to test
yourself.. RFC or PATCH is the choice.

