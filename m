Return-Path: <netdev+bounces-254838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB6QAAiFe2mvFAIAu9opvQ
	(envelope-from <netdev+bounces-254838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:04:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0DB1C71
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21593301BCC6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CD318B96;
	Thu, 29 Jan 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="cj96tuZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2ClMyNy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8003148B7
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702368; cv=none; b=cxKz1S3F9MGP4eWWVZysBtPQxbNKO3e8xnaPSMRpj2wuwYZ4nmzIYMHuqv6llF1n0GSPPmNrSuqn93dhbnGmZzb6N9AcjbSExj1UEd1RnjP83mSbvmLmghRgol1B81vdtqCixr5MNRTQwGVS6GEm9psVE8LI5OL2CDLonyMi5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702368; c=relaxed/simple;
	bh=PWW0F/zRm+a0GqjDCqEKHTZX3Cza7nR1+oK3mDoMDDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZGYS9/79/Q3QIB2lJoh6hkJJF0UksgFs6iEvoN09ehmfyKA4nmHOV+bnT9L4uPX5ceFvsA51OaraSaRW71avNwFQ5DAcUGjRW3P+C3zDBPaqEBf0d1oOhMKxzd5EorrVsTmxNCHTGcdlTKgmwkwIEsUTvP3LkKqGep9C9tK4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=cj96tuZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2ClMyNy; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D7F701D000DE;
	Thu, 29 Jan 2026 10:59:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Jan 2026 10:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769702362; x=
	1769788762; bh=zFVkX3Ag4iba/kgingqtDScKZFkBv4AbQZvdE//Qyeg=; b=c
	j96tuZYJO0N9GlS+HBx4VGdaYREN7p+pfJxS/QLmcE0Yvjg3f/HYMyzN9pq+lgbZ
	Ah5sIs2eO4EbPargl+GyCLDUZOeiO+MHIA3WBlrdMsWjX/ebaSV2ljS2vnCt18P8
	jN/gXxBHnG8HNiPTZ10SP+0lMiz98vP9h4jv7emlOxOsSUAgkfxkz1/1alOhiXXZ
	gUEtMA6iuTQVI4yeJwryD7owtFPytEyPUeeP9lpdLh+qvDCmOs21I7v9MiiUdu1U
	0tzQvu68c0sJPZ5Xk/x+p6oda93HYoDq0uL2mfK973F3Wv6+UieKn++I3JUjnvUu
	x0vKz0yLu5Mt/SBfsFh7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769702362; x=1769788762; bh=zFVkX3Ag4iba/kgingqtDScKZFkBv4AbQZv
	dE//Qyeg=; b=I2ClMyNy2up1ebBNJKX72guDYXkI6Vcsja4gPpJWLkzMsuSIVAO
	OzSywxgUEvVhM8KQqCqYCbnuZjGEv+lT4hv6REjcmE86jmmlq1GComm8ralmbEna
	y496WK3N/YlEpzB5ME691QZiSbYdRWoMnICbkILtGwgbWfYGEjvkDwRo52VNzc7k
	HQlR/0O+5fUc0k6iFTrJDKOtT15nEEzkjtfGO/WfV2FxsGX+lZgrSauW3WiAzFJl
	ILngD188JbEzAMFHuWH/tCLZZDwgNmmdf3bcgYnl5wx0yfM8gUQ5Z9NjLhi6QIKw
	Ze/rBLe8M+DNyHUrGrrZy1ZhlShwAhGPMIA==
X-ME-Sender: <xms:2IN7aUyD4xz6hqehZmtt43nIIuCVu-Zrp2fKN3Z6GgbhR9FzAC6dhw>
    <xme:2IN7add2Zdd0pFsx1vVFoqIY-QawM3ZZAebZRLJTDW9CYLdCW2_l7aOt4aJ4xzAwY
    lwfPvVaiHzUJu6BKW2vfSIdLKzpW4Pq9yKQGb1pqucreYUpKUlk7ScC>
X-ME-Received: <xmr:2IN7aZtLl_7GwHNNo8QYC777K2338jM7gliDrEumMT3idYfVJrB0E1MdsVQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehpvghnghhuihhnqdhkvghrnhgvlhesihdqlhhovhgvrdhsrghkuhhrrgdrnhgvrdhj
    phdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvg
    hffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohephhgv
    rhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegurg
    hvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2IN7aSCyWg-ZScFEmKep9MoNDawY-1bhyE9KKCKHebqqg9Kckg_pnw>
    <xmx:2IN7aRErot3q8dfHPUdT9-It8s9U54dG44szzo69r_gZbinx78iJ8g>
    <xmx:2IN7aSscSsOmcoXb7ZUHldtB-ItKpNvSThlYZSbKiC5tapjh7IOg9g>
    <xmx:2IN7aXkxPEC8ndct5xGBXJ6Snbp1zZg_3xo_XbkTfgIGWwoAvy-kOw>
    <xmx:2oN7aRA27GNqWeZvcypONsADfSsYVpgthoRTbKwsb5_-Tfxuuck0h8qw>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 10:59:20 -0500 (EST)
Date: Thu, 29 Jan 2026 16:59:18 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leon Romanovsky <leon@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Message-ID: <aXuD1vcKs65NQ_Qe@krikkit>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	TAGGED_FROM(0.00)[bounces-254838-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 62B0DB1C71
X-Rspamd-Action: no action

2026-01-29, 17:06:08 +0900, Tetsuo Handa wrote:
> On 2026/01/28 21:35, Leon Romanovsky wrote:
> > On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
> >> On 2026/01/28 19:24, Leon Romanovsky wrote:
> >>> I think this can work, but IMHO the more robust approach is to ensure that all
> >>> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
> >>
> >> The transaction will become complicated, for dev->features manipulation
> >> function can fail.
> > 
> > Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
> > and remove everything.
> 
> That answer needs more clarification. I came to get confused about what we should do.
> 
> Question 1:
> 
>   Since NETIF_F_HW_ESP is a hardware dependent flag, not all "struct net_device"
>   support NETIF_F_HW_ESP flag. Is this interpretation correct?

Yes.

> Question 2:
> 
>   Sabrina Dubroca commented
> 
>     But the current behavior ("ignore NETIF_F_HW_ESP and call
>     xdo_dev_state_add for new states anyway") has been established for
>     multiple years. Changing that now seems a bit risky.
> 
>   at https://lkml.kernel.org/r/aXd3QjzwOVm0Q9LF@krikkit .
> 
>   Is that comment saying that we have been permitting a "struct net_device"
>   to be selected by xfrm_dev_state_add() even if that "struct net_device"
>   does not support NETIF_F_HW_ESP flag. Is this interpretation correct?

Yes. You can verify this:

    echo 0 > /sys/bus/netdevsim/new_device
    dev=$(ls -1 /sys/bus/netdevsim/devices/netdevsim0/net/)
    ethtool -K $dev esp-hw-offload off  # clears NETIF_F_HW_ESP from dev->features
    ip xfrm state add src 192.168.13.1 dst 192.168.13.2 proto esp spi 0x1000 mode tunnel aead 'rfc4106(gcm(aes))' $key 128 offload crypto dev $dev dir out
    cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
    ip xfrm state

(if you replace $dev in the "ip xfrm state add" command with some
device that can't do ipsec offload at all (no xfrmdev_ops), for
example a veth device, you'll see in the "ip xfrm state" output
something similar but without the "crypto offload" line)


> Question 3:
> 
>   Leon Romanovsky suggested that, as a more robust approach, remove all states
>   and policies when the NETIF_F_HW_ESP feature bit is cleared.
> 
>   But I consider that such approach will not work, for (according to Q2 above)
>   xfrm_dev_state_add() can be called even if the NETIF_F_HW_ESP feature bit is not
>   set. Also, I think that there is no guarantee that dev->features manipulation
>   function is called after xfrm_dev_state_add() was called.
> 
>   Therefore, we need an event that are guaranteed to be called.
>   The NETDEV_UNREGISTER event is guaranteed to be called when unregistring
>   a "struct net_device", and therefore a good place to remove all states and
>   policies.
> 
>   Is this interpretation correct?
> 
> Question 4:
> 
>   If Q1 is correct, Sabrina's comment
> 
>     Changing that now seems a bit risky.
> 
>   in Q2 might be applicable to xfrm_dev_down().
> 
>   That is, someone who is using xfrm with a !NETIF_F_HW_ESP hardware might be
>   expecting that state and policy are not flushed upon NETDEV_DOWN event.
> 
>   If there is such possibility, I think we should avoid changing xfrm_dev_down()
>   and instead re-introduce xfrm_dev_unregister(). What do you think?

True. This is possible with

    ethtool -K $dev esp-hw-offload off ; ip link set $dev down

though not with mlx5 because dev->hw_features does not contain
NETIF_F_HW_ESP in mlx5 devices (this looks like a bug in the driver).

-- 
Sabrina

