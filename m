Return-Path: <netdev+bounces-46290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557677E3199
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6D280D87
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 23:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BEB2FE20;
	Mon,  6 Nov 2023 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyDtD+NY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F122747F
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 23:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A0FC433C8;
	Mon,  6 Nov 2023 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699314493;
	bh=Iv24+mEJW7DXWrDVIYI3Vflj7t85vsr1hfSqUvp0TOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dyDtD+NY1uSWj2twavzWD0Ojli/Woa0a9laU99VK+VxfnrgPDBVNPoElcZ1hr/iTz
	 7Rz0AxmBX02V/NKLYj/VxrViXK9iZQZQUH/pyo60DUNGSqahEhtDik+NYzrd815Jps
	 T67/aCQI1qjJT0+XcV0nWSWdb5e+bAbaGkToxIfg1iD98+fm2Ebdubb4rplVKezcgB
	 61He1QXDEci5sqFlq6tRfAQ2gL6KFRNO6Jtnm3Ynu0X2oAq9OfyuUyzNTs1cQtJ/M/
	 OL6cdsloZ6+sKcGare5314sV2Z4oS9kf5RciEk99YS0Zi1eRnAo895R+dhC8ZU3DN5
	 +XWQ05WNQEenA==
Date: Mon, 6 Nov 2023 15:48:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jong eon Park <jongeon.park@samsung.com>, Paolo Abeni
 <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dong ha Kang <dongha7.kang@samsung.com>
Subject: Re: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Message-ID: <20231106154812.14c470c2@kernel.org>
In-Reply-To: <20231103072209.1005409-1-jongeon.park@samsung.com>
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
	<20231103072209.1005409-1-jongeon.park@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Nov 2023 16:22:09 +0900 Jong eon Park wrote:
> In very rare cases, there was an issue where a user's poll function
> waiting for a uevent would continuously return very quickly, causing
> excessive CPU usage due to the following scenario.
> 
> Once sk_rcvbuf becomes full netlink_broadcast_deliver returns an error and
> netlink_overrun is called. However, if netlink_overrun was called in a
> context just before a another context returns from the poll and recv is
> invoked, emptying the rcvbuf, sk->sk_err = ENOBUF is written to the
> netlink socket belatedly and it enters the NETLINK_S_CONGESTED state.
> If the user does not check for POLLERR, they cannot consume and clean
> sk_err and repeatedly enter the situation where they call poll again but
> return immediately.
> 
> To address this issue, I would like to introduce the following netlink
> poll.
> 
> After calling the datagram_poll, netlink poll checks the
> NETLINK_S_CONGESTED status and rcv queue, and this make the user to be
> readable once more even if the user has already emptied rcv queue. This
> allows the user to be able to consume sk->sk_err value through
> netlink_recvmsg, thus the situation described above can be avoided

The explanation makes sense, but I'm not able to make the jump in
understanding how this is a netlink problem. datagram_poll() returns
EPOLLERR because sk_err is set, what makes netlink special?
The fact that we can have an sk_err with nothing in the recv queue?

Paolo understands this better, maybe he can weigh in tomorrow...

