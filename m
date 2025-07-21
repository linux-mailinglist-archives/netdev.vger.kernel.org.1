Return-Path: <netdev+bounces-208640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE7B0C79E
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F673A4441
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB22DEA79;
	Mon, 21 Jul 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayjOJGUN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF22DECC0
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111803; cv=none; b=caHeVbo5nhFhVuyfBiVBnNvVIXLjJTjQgF/U5N4HjJnL1+w04elgRRHexJqZdMI3h63wKJxv1qGYzPSoxcRT+r7PB5V9/kA6oSOPemUKob8tBWF5Kn8psxz6ukU5bOb/siyzsdiuIFm/KCAwlpYMyQjevtA6htO22Dw64roIWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111803; c=relaxed/simple;
	bh=h0v2JEv2YFslte7HCpvryskVRHBdbZfWpK/kkHRicPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpvpOUBw82lyQBcUoyZ4PIhYDy5p0Kz957VFdY0ZfZiVwg9gKtoNPA2T2XLrEszq7btUogZ1n5l5a2iMtxLD9ncuNIbTH/TWxhnVRvDoZ+3olMrynDF3d1HwqAOts0VfdERhz9LYzAC3mPQkE9zdItSywaF6NGXy5XlVEvW63RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayjOJGUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BCCC4CEED;
	Mon, 21 Jul 2025 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111802;
	bh=h0v2JEv2YFslte7HCpvryskVRHBdbZfWpK/kkHRicPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayjOJGUNUhmujLQO6Z6WntDq3yzsO1csi5hxpOSEJsOUtNmHoZyzPV+EwjwzvZK33
	 vAFjOgehUgWZOihcHjGwRUlVkZAHnrvFyteYfZ+MqpBpoA5R/00SZC/qxL3z40QVl/
	 i66LKL0ZxmRAqmRCCd/7jSk8Eb7bnekv6RwDqSCy+CE2lITrABejfWV+Yv7imBHs+6
	 d0Hoy44MYLmNMotbMBnYvELPrMCJrhRJ7joMVgk0X3VvtOcgU2iZ4cR00K9ILRQCTu
	 o5pffC9eZm1/xB1bPbiLj2dxnfT8qNhkz/+HBiONpCQjPSXSM2dOPmu+S+VuXW58ip
	 AQvrdJT5xhTQw==
Date: Mon, 21 Jul 2025 08:30:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH net-next 1/2] tcp: do not set a zero size receive buffer
Message-ID: <20250721083000.5f545b8a@kernel.org>
In-Reply-To: <20250721082728.355745f2@kernel.org>
References: <cover.1752859383.git.pabeni@redhat.com>
	<3e080bdba9981988ff86e120df40a5f0dc6cd033.1752859383.git.pabeni@redhat.com>
	<CANn89i+KCsw+LH1X1yzmgr1wg5Vxm47AbAEOeOnY5gqq4ngH4w@mail.gmail.com>
	<f8178814-cf90-4021-a3e2-f2494dbf982a@redhat.com>
	<CANn89i+baSpvbJM6gcbSjZMmWVyvwsFotvH1czui9ARVRjS5Bw@mail.gmail.com>
	<ebc7890c-e239-4a64-99af-df5053245b28@redhat.com>
	<CANn89iJeXXJV-D5g3+hqStM1sH0UZ3jDeZmOu9mM_E_i9ZYaeA@mail.gmail.com>
	<1d78b781-5cca-440c-b9d0-bdf40a410a3d@redhat.com>
	<20250721082728.355745f2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 08:27:28 -0700 Jakub Kicinski wrote:
> > With just the 0 rmem check in tcp_prune_queue(), such function will
> > still invoke tcp_clamp_window() that will shrink the receive buffer to
> > 110592.
> > tcp_collapse() can't make enough room and the incoming packet will be
> > dropped. I think we should instead accept such packet.
> > 
> > Side note: the above data are taken from an actual reproduction of the issue
> > 
> > Please LMK if the above clarifies a bit my doubt or if a full pktdrill
> > is needed.  
> 
> Not the first time we stumble on packetdrills for scaling ratio.
> Solving it is probably outside the scope of this discussion but 
> I wonder what would be the best way to do it. My go to is to
> integrate packetdrill with netdevsim and have an option for netdevsim
> to inflate truesize on demand. But perhaps there's a clever way we can
> force something like tap to give us the ratio we desire. Other ideas?

FWIW didn't see Eric's reply before hitting send..

