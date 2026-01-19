Return-Path: <netdev+bounces-251194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED918D3B3CB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111F1301F7F7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F030C608;
	Mon, 19 Jan 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/6XDHG8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EE2BF001
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842391; cv=none; b=jAK5hRPFl3BNh84VdaCG4R2mZ0UFAUyyWU0fYqf1LBWweiNJlzq42rUL+ELCBHJprQqDNrW/H+UbBbWUhi1fC8+zolZ1NlsSv9UbfcPnW09Hg4YqkQHtR9gXNrzngEuOo0QCA95+m93R49Yek96FX4tYLutjfRdqSbpRj4CibsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842391; c=relaxed/simple;
	bh=orCnM2MC4J6qS8mGSwmIakNy2ziCX2tvJHqhr9oY1V4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIbdk4hxq0yxqNiYxsvq74fLwyl3irwxQoarbq1vsL8EKtJ2K+ITWULPcnR1oE2H+ytbOFNEXAPNKV16o0C85QSRUjvJfXnX0cuOi4b9KRnmQ39i4TYnA+iDsiV4xytWM+r6d4WM3C5ajmKQvGkDwceX24RmcOH10D+jqpMMaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/6XDHG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBCAC116C6;
	Mon, 19 Jan 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768842390;
	bh=orCnM2MC4J6qS8mGSwmIakNy2ziCX2tvJHqhr9oY1V4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/6XDHG86AKSbtHyBguSRsIF1oCZc/M/aNHCsZo/1EcI8rdB+vbZHdTXaJI5ICWOZ
	 kUqI5ny9moTJUg2fNJ5Ll3ZccOGUzqfmFgfyH4IxJxDn8FUcLK9hIf64BlaX23qoCZ
	 sA11Ik2TG+V981pNZVtT0gbFU1UQJY7uI4i5evtJSbxeZclsHB9Ii2xGUsypSDTDd6
	 xx6E6q5ccQmgPfnPpwcxCpNCa0dF012PX8wtF67aPCYhZJAMmcDE2eK9o21eWfGWFg
	 i6lrsUasoIog21nTNCCuWJ+t9GR6lY08knJtnx4HTyObT+IqRg8zJcflj4wj4AwmZr
	 Pk5avS16TpfTg==
Date: Mon, 19 Jan 2026 09:06:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, pabeni@redhat.com,
 syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Mazin Al Haddad <mazin@getstate.dev>
Subject: Re: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <20260119090629.20d202e8@kernel.org>
In-Reply-To: <20260119112512.28196-1-fw@strlen.de>
References: <20260119112512.28196-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 12:24:57 +0100 Florian Westphal wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> I added skb_vlan_inet_prepare() helper in the cited commit, hinting
> that we would need to use it more broadly.

I _think_ this makes GRE forwarding tests a bit unhappy:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2026-01-19--12-00&executor=vmksft-forwarding&pw-n=0&pass=0
-- 
pw-bot: cr

