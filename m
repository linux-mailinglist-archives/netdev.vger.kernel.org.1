Return-Path: <netdev+bounces-232501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E0FC060BE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6939C58590C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E531353E;
	Fri, 24 Oct 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="q64VYH5O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="otfw8ptK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B553128DA
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305208; cv=none; b=EPfZS8VqachuET0L//dm4mnqYNa5FKH0I4wa7JkQ0r/KUDkWGm8SfXIZLHL+Ad10R3dcXT2xHk/7YwI13b2O1lRg2OH0xUUxvVGBXeDm8KEWR8//MyBqPzZ/Ip89vqjpCNE9jG+2Y3jnGP+me9ybCKHsyVpjGR/JZIGSkTRZLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305208; c=relaxed/simple;
	bh=MRpGFE/nF5iTX6ftFSQeha0skf1GZ2BAH/qN06gnGK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzLUG1VGzGxxdTS+zbxwpG3lsTPjFYMgtoeDpMYPrOUH7zwG62AAE/P0IUv5RMVl2nu4xxUiBPYaQ0qxFIQZQV/xotv0MyY0lD/2tnDQIPupbbuw88NkeH/O8VUrqcD5WCgsT1ONzmsAu53XUbnTCaZYia9xWdTGi4BWqPdOKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=q64VYH5O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=otfw8ptK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E3B6AEC027D;
	Fri, 24 Oct 2025 07:26:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 07:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761305203; x=
	1761391603; bh=7/8KOV/xaG8pdgGbXFKGL25SDXCG7VcV2qIuUmFjreM=; b=q
	64VYH5OS4mlK+0V3QZIu1M8fEfMoReHkW4R6HpQ6VgVyt8rhceTjeP7e9NjoX+PR
	ZRhtPGoYP9uWX1HoffUKq36n/vvkyWhZ3Lop5Lx1Mh490J7yJzQkeZ/NARX7qgac
	Yocl9Ur/nOqKwSxhsZU9uVYqp2BgTVL2jycnpXZF+Rk2mmXhBoiGAdCyLgrjvkb2
	RMwOQ9UqwiEk3vHsnQ7D1r2OKV/JVbBV/8d3Lxzp19X1uVZ5wMdv6T+ui9DR3lue
	Ac5cSljRh4EIC4WcGnmP0vTMBdbbMcve9s3wCrvs9KFjm/sR+aGUqpl0qovpurwI
	dCCfl0JvW2lmvGexQ4FfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761305203; x=1761391603; bh=7/8KOV/xaG8pdgGbXFKGL25SDXCG7VcV2qI
	uUmFjreM=; b=otfw8ptKG6RweiIxDcLXEhF6H/lwkkXqJOP8Oeje3ZVOTQl+TMs
	OBZRcX53gGUx6BT2GBn6QNA4F3XoJWQs0/H44roOIMYP3FcGX6PfxDtliFrm0ZFU
	Q8FFeUx+hJEK8WYrflKJf9LhtHrNKwwhk2uSiujCQNxjfbXimdJE8+lBbl4oZkKt
	T1dCwAg+uePQ63Mp7MIvyAptni/B3W57Bty0/PAG22xEboJp/sI70olgywbiqmuN
	22izhMK0EY7iMmqwVC47XDEBGlfskmM9zTHUJV5VMemx1QX+256A2o7q+5mkyk6V
	0u0G0kDAkMfbnQ/rjNK5+VYS0M3OUoT8yLg==
X-ME-Sender: <xms:cmL7aKxaVAfVODiARhH0gV4rWDvXbII6wGqRC5AzoAJHc4X-s_ZPIQ>
    <xme:cmL7aMSa83-fhyPixEZDVPjyQ-xopd6LWEMVxT-BjwSUTDgw9XhJzGSOszgbe_GZU
    eho8u8s5Zhxx-B2QQCVYZJFWFMaHVYbCn5Xa_asgoTR_rbLYQ8HWA>
X-ME-Received: <xmr:cmL7aHJmNZCzD3RjkmFGFJv8s-7fghtVRI_hVhzLyyl2grEgN6KY-jEXxZyP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirghnsgholhesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhht
    sehsvggtuhhnvghtrdgtohhmpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtg
    homhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdr
    rghupdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:cmL7aDUbUXBlueaxN62MvIYjK7ISGBUbBFq_UDNa530ReVvGKQtugQ>
    <xmx:cmL7aLT1UEUy0e0p_61n0tmwZA6MhgIUcxVdpcgj52idbcnkXcxb6A>
    <xmx:cmL7aLDboDy-m-xhg02MlXyHtZLVj7r2gbSlgST3ZWkoXWozH7sjyA>
    <xmx:cmL7aKLta3PS8WHdqC8hf2PhHsiFCoBYH9wmAThSkJjFT0a20Gq-aA>
    <xmx:c2L7aK4QXSdEjmi1H1YKMQh2U_Dub30GYzGwZKuBeejIsHILJItX6RWj>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 07:26:41 -0400 (EDT)
Date: Fri, 24 Oct 2025 13:26:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com, Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/3] xfrm: Check inner packet family directly
 from skb_dst
Message-ID: <aPticHQQSugMGgs1@krikkit>
References: <20251024023931.65002-1-jianbol@nvidia.com>
 <20251024023931.65002-3-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024023931.65002-3-jianbol@nvidia.com>

Some general notes:

 - ipsec patches should go through the ipsec/ipsec-next trees
   maintained by Steffen, not net/net-next directly, and use
   ipsec/ipsec-next in the subject prefix

 - this patch looks more like a bugfix, so it should target the ipsec
   tree and have a Fixes tag, instead of -next


2025-10-24, 05:31:36 +0300, Jianbo Liu wrote:
> In the output path, xfrm_dev_offload_ok and xfrm_get_inner_ipproto
> need to determine the protocol family of the inner packet (skb) before
> it gets encapsulated.
> 
> In xfrm_dev_offload_ok, the code checked x->inner_mode.family. This is
> incorrect because the state's true inner family might be specified in
> x->inner_mode_iaf.family (e.g., for tunnel mode).

I wouldn't say inner_mode_iaf.family is the "true" inner family. AFAIU
it's the other possible inner family for states that accept both
(I got that wrong in 91d8a53db219 ("xfrm: fix offloading of
cross-family tunnels")).

> In xfrm_get_inner_ipproto, the code checked x->outer_mode.family. This
> is also incorrect for tunnel mode, as the inner packet's family can be
> different from the outer header's family.
> 
> At both of these call sites, the skb variable holds the original inner
> packet. The most direct and reliable source of truth for its protocol
> family is its destination entry.

(the IP version would also work since it's in the same place for both
v4 and v6, but we have other uses of dst family in xfrm_output so it
should be fine)

> This patch fixes the issue by using
> skb_dst(skb)->ops->family to ensure protocol-specific headers are only
> accessed for the correct packet type.

Do you have an example of problematic setup? I didn't run into that
when I wrote 91d8a53db219.

-- 
Sabrina

