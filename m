Return-Path: <netdev+bounces-109091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7BA926D8F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795BB28459C
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313AE175B1;
	Thu,  4 Jul 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi7rpBWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE741757D
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720060931; cv=none; b=CwCNdYbNkc5PCvgn+QnoOcVzxF/3r6V+9hLIdFkzvHomSe+wSpIPYXmQieyJMFAHJSfFLC+UEQOHiqXsXJAsxCVQBD2MXGLZuCGtjUJnfhenpnMfJteMICPoFbMdeN6yg/rB8Zag2lv1ZEFf4v+KyqmXmHO+mbIhNFi+uXC+sHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720060931; c=relaxed/simple;
	bh=IsXqF/U7scbYExy2ttF0ANNg1l9mfmTVZRHRgRKz7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgUXT91CKL78T6zI3+xPXoInPFfzHUutA+CtLV3E1raRZYYeSs2FQmRYJrNjXtwAPM8HhSUKIOCYXrdsT653dui/+MjgF3NpyPaEZEFfBlkhqFmCJnUsC5q2Strrc3fsW/El9wdK0aGkawZneLxGxGP0OiqQhaSr53QEq5qHSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi7rpBWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EE8C3277B;
	Thu,  4 Jul 2024 02:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720060929;
	bh=IsXqF/U7scbYExy2ttF0ANNg1l9mfmTVZRHRgRKz7Yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bi7rpBWNqwp7nurSFgRw85lPmlk/5TnTj+49nKkgkCtOEFZOWf0/zS8L4FLEVEzFZ
	 kh4VtFtkTv/wyqVmNEVyRpeIjB1R44PTxAZMYdPY34Czjva/27Y+AMVcMJzpPshT+4
	 d1f5zsgiMNH3mH3/7xEvjUOGimG9vYW3HKYlJxgG473fE5dMQfHX3VMTgVOrrtJoUW
	 iQ09mRlmv3mntI0Y/K0YrLn1092syAjpjRaCEMg7IpPES3DK8//Yyv6t3VU9hSOfHI
	 +dVhyaIpL5PtQIGsKyj5qr0hKl/rgCtxca/NKd9ez7FCdAfrSw5OVRy8FawIwb5oku
	 vTqNuEbnT0A3Q==
Date: Wed, 3 Jul 2024 19:42:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
Subject: Re: [PATCH net 1/2] selftests: fix OOM in msg_zerocopy selftest
Message-ID: <20240703194208.7650d8bb@kernel.org>
In-Reply-To: <5eddb78a-ba1a-4568-aeac-0dc296efdd51@bytedance.com>
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
	<20240701225349.3395580-2-zijianzhang@bytedance.com>
	<20240703185003.6f11ff73@kernel.org>
	<5eddb78a-ba1a-4568-aeac-0dc296efdd51@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 19:32:33 -0700 Zijian Zhang wrote:
> > This test doesn't fail in netdev CI. Is the problem fix in net-next
> > somehow? Or the "always exits with OUT_OF_MEMORY" is an exaggerations?
> > (TBH I'm not even sure what it means to "exit with OUT_OF_MEMORY" in
> > this context.)
> >  
> The reason why this test doesn't fail in CI:
> 
> According to the test output,
> # ipv4 tcp -z -t 1
> # tx=111332 (6947 MB) txc=111332 zc=n
> zerocopy is false here.
> 
> This is because of some limitation of zerocopy in localhost.
> Specifically, the subsection "Notification Latency" in the sendmsg
> zerocopy the paper.
> 
> In order to make "zc=y", we may need to update skb_orphan_frags_rx to
> the same as skb_orphan_frags, recompile the kernel, and run the test.
> 
> By OUT_OF_MEMORY I mean:
> 
> Each calling of sendmsg with zerocopy will allocate an skb with
> sock_omalloc. If users never recv the notifications but keep calling
> sendmsg with zerocopy. The send system call will finally return with
> -ENOMEM.
> 
> I hope this clarifies your confusion :)

It does, thanks!


