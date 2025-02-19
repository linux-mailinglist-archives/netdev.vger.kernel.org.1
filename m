Return-Path: <netdev+bounces-167766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADEA3C25E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381A67A5633
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7A11EFFBF;
	Wed, 19 Feb 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w57c2KcB"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8B1EEA31
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976018; cv=none; b=s8eHkdOpa+ERM3WsLLGQ3tyHh4gdJ88Qqj40B1X7SUNMtXo46EexwNkgGfgW2QwzNL+nJs9oWcIb6cdaaYrPbLaIATQYZg1AtH+42s7ztPhp4BKaMqYjEhQQt1cQQjW+mA1EW7LIYZ/au/P6wrsOjZkVQyKAURvstcMD1ii4XbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976018; c=relaxed/simple;
	bh=xCA4qlcBMADY9k+8q6G8zDUcxkkro8BR9K7UPgThGxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZDEsXtesiT6ZfRfBb/EDsuU+0GHI1WWwrUlPgqHp1NaJBBZsJ3VYCwkNs2k8wiSobb7/GezigpYK091Sxi+Jr21xyHyJKv1CPCpvcrS6wT/jKX7HfmSd1iLeyQMbP+ihTvUfMi+3zKW4Oz9fT/juXQpqv2RcQbm5fvkMD5EXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w57c2KcB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D02231140160;
	Wed, 19 Feb 2025 09:40:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 19 Feb 2025 09:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739976015; x=1740062415; bh=RUXU+mt2mXrRWd+jtuyqxi9KUSWQmg48aro
	SCnXHBFY=; b=w57c2KcBlVajRF5ZJWV3pz1hnBDjtxx0bsFOfbH4QAhDEuWEBZT
	TOAK4REVU0oau6DTfas6tIMWQ89NXVhwBMczqA91xXoDbKCYoLz7offz2TVw8I8I
	3iKnxVnp/qubWH/P8Wnvqt9X+gLWQXCw32Ylpo0JG3rUkRv1sb/00kTphdD0QCKT
	RAshcr1Fss718UNLtdZFyoOoC7vJz7tJaILjIqOjBhLvnkKmPPP01onPrADnEzn2
	R0mLjNXSYdz35nmrfvuuSTNQtcgv2rh0L8xm3+nG+iehbl0UZ+TUv2e44/Vw5tBU
	+S1Vp2pKJHx+BhKGdLo3dItewrfbFZf8GYA==
X-ME-Sender: <xms:T-21Z_mRRMIzPCOD-iOSg3yypTIe_iMjP1BimTb_nYGKDd77uGY7TA>
    <xme:T-21Zy352RmOQkqPjNUcVsm5Gf-mqC8hSZgJwuY85HbO53411CB31w8cSmkUPA25J
    poXnl7WprxR1R4>
X-ME-Received: <xmr:T-21Z1reiYq5yyd8aUbWOQkhhf8UI6yPG7fM5zLfH0nsHr_SSoeq912vjizM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeigihihohhurdifrghngh
    gtohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeguthiiqhdtudesghhmrghilhdrtghomhdprh
    gtphhtthhopehjhhhssehmohhjrghtrghtuhdrtghomhdprhgtphhtthhopehjihhrihes
    rhgvshhnuhhllhhirdhush
X-ME-Proxy: <xmx:T-21Z3n0Uyb17VHwO0OaS_k4pzx_giWaNe1Tyh__zhM1N6aJANMAWA>
    <xmx:T-21Z92RM0krcekpSmRY15mvwIxUPhR1xpBqOLWoUoAb6FJMJrCpJg>
    <xmx:T-21Z2tFpB4pWC4o6ohMtHLQeCfEG1zOFWlpChTIxdtDvUl9KC8SOA>
    <xmx:T-21ZxVCkd1DQlHAHE7ML9HzECuxup8oUvEaOtO2L4vSRU0nmwXLcg>
    <xmx:T-21Z4Qev7SH5BM7GJZVYooTLP3D40wXCBuJQtIe0E2Lzu8caB-21JpF>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 09:40:14 -0500 (EST)
Date: Wed, 19 Feb 2025 16:40:11 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Qiang Zhang <dtzq01@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [Patch net 2/4] selftests/net/forwarding: Add a test case for
 tc-flower of mixed port and port-range
Message-ID: <Z7XtS6N9mJiLS95E@shredder>
References: <20250218043210.732959-1-xiyou.wangcong@gmail.com>
 <20250218043210.732959-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218043210.732959-3-xiyou.wangcong@gmail.com>

On Mon, Feb 17, 2025 at 08:32:08PM -0800, Cong Wang wrote:
> After this patch:
> 
>  # ./tc_flower_port_range.sh
>  TEST: Port range matching - IPv4 UDP                                [ OK ]
>  TEST: Port range matching - IPv4 TCP                                [ OK ]
>  TEST: Port range matching - IPv6 UDP                                [ OK ]
>  TEST: Port range matching - IPv6 TCP                                [ OK ]
>  TEST: Port range matching - IPv4 UDP Drop                           [ OK ]
> 
> Cc: Qiang Zhang <dtzq01@gmail.com>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Tested with offload as well.

