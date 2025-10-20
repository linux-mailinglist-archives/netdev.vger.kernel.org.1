Return-Path: <netdev+bounces-230820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BABF01CD
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 166CA4F09E4
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A052ED16D;
	Mon, 20 Oct 2025 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="X2goDTtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eJNNtYcQ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D02ECEA3
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951498; cv=none; b=Zffh6YsZaJOtZomjFuEAmo3qmqhrKHMhvOncgn7MBz/qWisFnAq6dR108vfthxWji06wzVu23cN9EaIHjHpBriY6d4hf7hZRIihzhU4UdHwkwTkVMy4Fkin0TM2tYMmDEHplRXSGiuWRLV/qGTynEjZrY3WEmC67biFhMbcwBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951498; c=relaxed/simple;
	bh=r05lQ8QjsXHO/YtNy9p9A+fhssnqL2q9NxJ9w9nL3bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzaHFj7ze18/MaGI9wwGQBdmzm2Z+P5eUBzOJw3sxGVYDe2P3vPp7kVvOKjK30L9wdi7P4w2PDTa3dVzMHrCVjliEkufuLjsYQgPsVY8mzPFmhZrRjr7FO/Yr588Ge2wazNal6mI+tyYnE7A9M/mfs11rsOPKsEsuOrH/1eDOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=X2goDTtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eJNNtYcQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E01D37A0027;
	Mon, 20 Oct 2025 05:11:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Oct 2025 05:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760951494; x=
	1761037894; bh=4Nwekh16SpF5rye+o1P7aLYihsMbKaZuUyC1glA+aIc=; b=X
	2goDTtlkt4Few3Y3IMUjM89Pxr5DBsYKE5ECEJHBq3Af6x9IoEDficsG8guXDj5d
	Z+fgSpnYZEwGlYxJkQbWMltkYrjUhTBZikQaPSxsITssdKHsVkjVXpCiIr15FCMd
	xEzh3cEC7X2i9I7AxFNovXXYsjKfci2UF/babh0yY0NrcQs1KgbXL+Xk4qSrcnz9
	WsDp76Xr8afaAYpRJCZofOWmiie2sP0LwH0Oo3tOXmk0YLWdhDdTIqIXJ0F6SnzJ
	qKCrEJrvCk2tfvJD00K1U7oUeq+7d+7WRDQY1oJpGYsnAwbrhGSIHT5anXLCBnxj
	l0BO3yDWKYeuTRuUegDUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760951494; x=1761037894; bh=4Nwekh16SpF5rye+o1P7aLYihsMbKaZuUyC
	1glA+aIc=; b=eJNNtYcQSObbwrQdP+dp0gcGhSUG9mzPuLGuXDTXs/Ckr4KloiT
	N+OjEr9CSMy2w+z2IJhuXC5pOkTp3NwG3L3vtEY0/Dvz9UUIptxbp3zECmZJIzXK
	IK3XZZTjstU8rGlXAib+fI3PWfusrqH4BQLzr5IV2ukhs1RLeFe+HmImalipS54G
	XtbF9tZNxZWSNfosoMCu1Grhu/Z3UJqsez1fuG6LnSA1DnRobhqPyl8d62CY8l/U
	Q34b7gNghA6oddboYg0RJ5YYgMYiVXvZTpBOkLQ00sUR4nq9j0m3vTO1ysHUU2nz
	lr3UANfTtIvhdfGixwinnPr1HZIFR/gu39Q==
X-ME-Sender: <xms:xvz1aKWD_wumE50r5HBkJd4dPt0V1qfYvVQHsU7Z7WZRM-u7ghMSUA>
    <xme:xvz1aP-Wk--0n6YbAKrkf7oHjEyrd_kxeVidq-3xjhINNMGyiQid6QOLk28WJWep1
    Gj-tmTqxooMAc0fCfnD2KHVvP_nIJ43SS9XwNMvtAicAyuLo0ll>
X-ME-Received: <xmr:xvz1aG6ik8DHpntr29BHpjGEzW4WwEf2DNsCFOD_jWGsTo0l28Y9HjjG0p9R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhird
    hush
X-ME-Proxy: <xmx:xvz1aA17awBfJjX_xdW9fJTnyYQN056E3917g7M0vB8rJ0E5MhxeSQ>
    <xmx:xvz1aFwY-lK0qDcR1nDDdDAWPwj9JUu13UtvkajRHkLWoOP658yiFA>
    <xmx:xvz1aBnRsPCRx-VA8NEiSrfbKydQmOC5xujlJtfww3eK4gkPiR1aTg>
    <xmx:xvz1aA8gJ4KgP_eCOPnqkXSZjBiDoFxqAwtYVoUDIl5moncRvNVXOg>
    <xmx:xvz1aEOkNyM_-MPXE25wMp9Jn7DL3EPuRLaQQmj9cWX0EOiWstOGpFTS>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 05:11:33 -0400 (EDT)
Date: Mon, 20 Oct 2025 11:11:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 3/4] team: use common function to compute the
 features
Message-ID: <aPX8xEOcG_b0JQ2P@krikkit>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017034155.61990-4-liuhangbin@gmail.com>

2025-10-17, 03:41:54 +0000, Hangbin Liu wrote:
> Use the new helper netdev_compute_master_upper_features() to compute the
> team device features. This helper performs both the feature computation
> and the netdev_change_features() call.
> 
> Note that such change replace the lower layer traversing currently done
> using team->port_list with netdev_for_each_lower_dev(). Such change is
> safe as `port_list` contains exactly the same elements as
> `team->dev->adj_list.lower` and the helper is always invoked under the
> RTNL lock.
> 
> With this change, the explicit netdev_change_features() in team_add_slave()
> can be safely removed, as team_port_add() already takes care of the
> notification via netdev_compute_master_upper_features(), and same thing for
> team_del_slave()
> 
> This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
> features.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team_core.c | 83 +++---------------------------------
>  1 file changed, 6 insertions(+), 77 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

