Return-Path: <netdev+bounces-121199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1795C236
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 02:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA791F23707
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638604A08;
	Fri, 23 Aug 2024 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="XJmK5dWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B7lYokOY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45891B653
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724372282; cv=none; b=qim3u56OUu/54W7PFcX7lJgS34OmoVnAFw1DgXQ4RNEMAdXOyMY/uLdAQeRNRlhdpzoR4YT+e9r069z6rYaJz2Hbc87hdv1QHRMTsIj4L/AZNPTngzS3GRU22hpvic8uFkfr0dtvIRcu8AQ9elTEySz0KMCmN8QR5vSvkHzuq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724372282; c=relaxed/simple;
	bh=zydv4H1agCQYAbA2bY5F8skc6y3QLACPCM2OrXjX2sg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Kc9e95ALTxX56HuLM/37iVk8t2opM78iZIj5cXzl4lHiJhrxIW3gqbnrLbm1gfu2YywXpjHPHeqIFmNGZmTHd/IAbjO1Xoku5A9upSrL3EujAmBrz7VPQ4th2IQT5r/1+MC6cu5JNSAVDg7svN9GppP1OGBh4S36lOZe28dBgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=XJmK5dWC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B7lYokOY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3276E114AB33;
	Thu, 22 Aug 2024 20:17:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 20:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1724372279; x=
	1724458679; bh=z8NnpkHEjKStt+d806yRog8/0B+2alYelUCXntVupUE=; b=X
	JmK5dWC2xL1eEPW8dQ7dAo6ATP7V/uxolzz9DDh2nI09y72eXgegAKQ1xtE36B7p
	xIGSJQTTbkdUFngIcenD4e+vr6QwbY/GxI0/VuN9S2hR9EJimuYk9N4kUm83F4sB
	evts8Ma7QQnSkdfetzhtofc5Cb0TEiBSRc+mX9e/anLW56VmDQQzMzhx4gdD9rMr
	oaPeiFYr3XAq2bPV+dqksgpHTXKK0YMLtxP8ATSR1XR0074jCsHxauoYTojipWGV
	gU+DbiS7eXVehxQlV3jeJ0ccX6O6m/ItZxc34qGLqrZZiOqtBVKRP3CuOW+xP9cD
	7yWTueLC3RqJfKfWVkCBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724372279; x=
	1724458679; bh=z8NnpkHEjKStt+d806yRog8/0B+2alYelUCXntVupUE=; b=B
	7lYokOY39mGVFBRkxPWWjpvvLvCpXOac9aZeGWA97kk7cQVydB5RVosmPo60534w
	bZMK1+AUcUupaQZ5r7XGy1vdhLlQUtXxEfBw/vp395gzfrjRvs2ZqEqbqzjEYjTa
	pYk+xkrrwEIpT6CFtENhIpSgHD82NRID/AFb+PrL3LlYBaSFge7ZAWKCAxjNTusX
	9VHcTp7QV/zKhpwVFWC2PITRctzrJ9H48H8lRnigUnOIZOiSiHwg6woHXPY0Nqcz
	btKSL/SPw5yFgVDzOOk5flH6Y0Yq8Cs4Zudqi5tYcQcGPUBWEyA1HDCmXt8xtT6R
	M7Xv92fLc8Ks/qShSw2yw==
X-ME-Sender: <xms:NtXHZrEGCcgamZdt2bz8z0317kestqn18ZYPm1iGSzFc6fzsSdtqWg>
    <xme:NtXHZoX7_DigdYExfHfL6DYfWHBGxlGKcaRLIJzxg3d-6yXQSJrE2wyDr2502UiRz
    vRBTfw9ROBYnGLb-P0>
X-ME-Received: <xmr:NtXHZtLtrLlsSXHZLFJ-zPQl4Qkf4lqAscyt1-9l4zKl58nwV2StV1X3N0ASfn0VK3BBhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghfofggtgffkfesthdtredtredtvden
    ucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvg
    htqeenucggtffrrghtthgvrhhnpeejvdfghfetvedvudefvdejgeelteevkeevgedthfdu
    keevieejueehkeegffejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    grnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghgrlhesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
    epjhhirghnsgholhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnrhhosehn
    vhhiughirgdrtghomhdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:NtXHZpFaxwp-Q9LZKzAfJwkDlpCP8Z4SmvjSyjGBOTal-TkqfxrM6g>
    <xmx:NtXHZhWaLyrLKwvQ5Au5DSuvViR7B4pJ4rrQd3LJgc_sBdJ1IWFLTA>
    <xmx:NtXHZkMV9nyI8rDlrhqnfjN6R8Zb088zU6nO0blFGZaCMMCoOH-kbQ>
    <xmx:NtXHZg3RQnI4N3XKQ29umdT0ah2Vvxuba2q5zX-ua_WXfBPnHut-jQ>
    <xmx:N9XHZqsuKckun6BT9rOr_6bxkgN101x3mEBzrm-af4lKyTolZnLeLJq8>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 20:17:58 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 1101A9FBF6; Thu, 22 Aug 2024 17:17:57 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 0DEF79FBF5;
	Thu, 22 Aug 2024 17:17:57 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jianbo Liu <jianbol@nvidia.com>
cc: "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
    "davem@davemloft.net" <davem@davemloft.net>,
    Leon Romanovsky <leonro@nvidia.com>, Gal Pressman <gal@nvidia.com>,
    "andy@greyhouse.net" <andy@greyhouse.net>,
    Tariq Toukan <tariqt@nvidia.com>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "pabeni@redhat.com" <pabeni@redhat.com>,
    "edumazet@google.com" <edumazet@google.com>,
    Saeed Mahameed <saeedm@nvidia.com>,
    "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
In-reply-to: <02d8277b-e6fc-44d4-8c88-2eb42813cd22@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
 <20240821090458.10813-4-jianbol@nvidia.com> <120654.1724256030@famine>
 <2fb7d110fd9d210e12a61ebb28af6faf330d6421.camel@nvidia.com>
 <139066.1724306729@famine> <02d8277b-e6fc-44d4-8c88-2eb42813cd22@nvidia.com>
Comments: In-reply-to Jianbo Liu <jianbol@nvidia.com>
   message dated "Thu, 22 Aug 2024 19:15:24 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <165729.1724372277.1@famine>
Date: Thu, 22 Aug 2024 17:17:57 -0700
Message-ID: <165730.1724372277@famine>

Jianbo Liu <jianbol@nvidia.com> wrote:

[...]
>I think it's good solution.
>So I need to add the dev_hold/dev_put as following, for example, for
>bond_ipsec_del_sa, right?
>
>@@ -526,6 +534,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>        bond = netdev_priv(bond_dev);
>        slave = rcu_dereference(bond->curr_active_slave);
>        real_dev = slave ? slave->dev : NULL;
>+       dev_hold(real_dev);
>        rcu_read_unlock();
>
>        if (!slave)
>@@ -545,6 +554,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>
>        real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
> out:
>+       dev_put(real_dev);
>        mutex_lock(&bond->ipsec_lock);
>        list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>                if (ipsec->xs == xs) {
>
>If you are ok with that, I will add the same for
>bond_ipsec_add_sa/bond_ipsec_free_sa, and send new version.

	Yes, I think that will work, but please use netdev_hold() as
Jakub requested.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

