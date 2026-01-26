Return-Path: <netdev+bounces-253499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMMTO1J3d2n7ggEAu9opvQ
	(envelope-from <netdev+bounces-253499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:16:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B75A895F7
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 15:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 248F7300373E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DF33D6D5;
	Mon, 26 Jan 2026 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jeOXF2mb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYzZr1jq"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F7336EC0;
	Mon, 26 Jan 2026 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437003; cv=none; b=tKtzULmVPKqqN4RZjwLm5G59zBzgGeLDc30S2+T6BPZ3cY8DszY86Px1lpwqohcEz7J4PlWK4Vk3j400rlHOc9KdGu9PNDEL9oar5G90bO5QT4W9CRciQYC2WmHOKCVFFCuRFCr4X3TERP5kCd4oB9FRWFJ8OgPxIpcpi2WtFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437003; c=relaxed/simple;
	bh=OFVfkZfQSq/IC6N/ILZo/vJ8Z4F8NfJuOsvVtPmxDEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liapdcmdppfd5BLTQCoEPD4UWWIyUvPsbn1lQufnMGrpWHWkSFX0FmVziqWPLvcSFrm6Iu7YfCXsJyurvbp/MEuMIxvehYqWvskqq+vHzYlDxcFKtgJMuTSFzDdIpyLFwOOxqZ/M/XV5OGSEYR2PGFTzZTb0k0r301SqXLf0N18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jeOXF2mb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYzZr1jq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC3E17A012E;
	Mon, 26 Jan 2026 09:16:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 09:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769436998; x=
	1769523398; bh=2v0nuC3kBXBD79NKKqugi1PyZ8oI4cF8xd3QLkXTs7Y=; b=j
	eOXF2mbiNVmXNnBoOaSwuDcB3bxOafWx2Q1Envc5vhUMEoe6mDvR8fBwRZDPrQHF
	d997vGyMkpf7GlSG3kJdyvEekrcNy3mF86I4blIVyQOQOb8nZ8ljOC2mvFDrdqqh
	oIqg6wj/Wiwe3chmJFSoMvQJ89FNeeXs9Y1vU5uBT3MfkCkc0qk1t6uDPE6yr9qG
	6DoJL1xvdHhM3b6UpaIghV0FIWknlBn9dc/ItQJ+vCEi4kjiDM2jn6EexGPM9j4q
	scVHo7Hd1NWA9yy8oKXjFMaZiTX+10dCppK2UVmoVuKo88I8jfVznzMnghf5rlU3
	oLiSNjpUJK0CBj9H9nQ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769436998; x=1769523398; bh=2v0nuC3kBXBD79NKKqugi1PyZ8oI4cF8xd3
	QLkXTs7Y=; b=YYzZr1jqsmbn67SKIjhWuErgElZ0ymnluhPWZoaBwwagumB/Ucq
	iQvj86xe5OpwwGkvbFObkdbFnEyjypu9lQ4eHJOZLCWDbg9YJiamLz0NVwhDko6g
	QO6CRiFgBnbbdaroHOB8jq/PKZ6uOTCyeMNLMf+pbJojE5tcUbcki/OHf7IQXtpx
	5ieBq9ZIU2rGbvf7J9H1DMC69cPG5TyBOe4xzQp3hR8MM2o88PBMrZ1tX5zVSySB
	d+8cPDKE5TB6ghqREI/a1YaZjLASBnV49U6nynP0ekf1Ntj504ITXo0sybtngUDB
	apDBVzh2V/pcpcLu+iP+VYdrXZCBRuvWboA==
X-ME-Sender: <xms:RHd3aamPhUZZAfHSVpwEe2iOfPUjKqONTpc_omdr-CaB9oJQvUQpUA>
    <xme:RHd3aSx_9D_F1FCuPhQC40k7VzG2KqP7C3oNbmAwBQCA-_1Zox4HZEd46EV8KtCd8
    l4QHRHW89MmJ7_cUKoYTpXuwNNlNnURE0aGj7g1OUEPfLvDNxUPXJMG>
X-ME-Received: <xmr:RHd3aY-zmCiUrGtwK1bKUG2gTMciK4ddOtbWFW2iAAsTMLiIH6rUm4Vf1yl9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepkeejvdehgeekveduudeufedugfdtlefgiedugfeggfevuedvtddujedt
    jefgleevnecuffhomhgrihhnpegsvghlohifrdhnvghtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhn
    vghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvnhhguhhinhdqkhgvrhhnvghlsehiqdhlohhvvgdrshgrkhhurhgrrdhnvgdrjhhp
    pdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhrihhsphesmhgvlhhlrghnohigrd
    gtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphht
    thhopehffiesshhtrhhlvghnrdguvgdprhgtphhtthhopehkrhhishhtihgrnhdrvghvvg
    hnshgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhgvohhnrhhosehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:RHd3adC3rLGq2o0WR1tZMzBHx9AQFgrMiC3jm0E-2LDYSY2hUkUYig>
    <xmx:RHd3afrFZGHgiSj6iNr8Q0Lk5OpJydio3J5knn0YlvWtL2d4s2HY3A>
    <xmx:RHd3aVmmg5nb19tvwEhHU5ckwCXXAlURyAT8c3FoJW6B6wrRQBuibQ>
    <xmx:RHd3aSVmb-81gBbWP0ry_LQyecV3fCqMfjtK0278EisexaxwLehcGA>
    <xmx:Rnd3aZNVkDYrOdDRpa9fVDIR31jZZKuG-SfMCVfqr1XT-jdVhqnEpFbi>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 09:16:36 -0500 (EST)
Date: Mon, 26 Jan 2026 15:16:34 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	Boris Pismenny <borisp@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>,
	Kristian Evensen <kristian.evensen@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>,
	Aviad Yehezkel <aviadye@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
Message-ID: <aXd3QjzwOVm0Q9LF@krikkit>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
 <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
 <aXIKwNJv59KnsnLw@secunet.com>
 <5811ec38-907e-4788-8a0e-7758f12dc9d0@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5811ec38-907e-4788-8a0e-7758f12dc9d0@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-253499-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,vger.kernel.org,mellanox.com,davemloft.net,strlen.de,gmail.com,kernel.org,nvidia.com,gondor.apana.org.au];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 0B75A895F7
X-Rspamd-Action: no action

2026-01-22, 22:07:46 +0900, Tetsuo Handa wrote:
> On 2026/01/22 20:32, Steffen Klassert wrote:
> > On Thu, Jan 22, 2026 at 08:28:31PM +0900, Tetsuo Handa wrote:
> >> On 2026/01/22 20:15, Steffen Klassert wrote:
> >>> Hm, I'd say we should not try to offload to a device that does
> >>> not support NETIF_F_HW_ESP.
> >>
> >> I was about to post the patch below, but you are suggesting that "do not allow calling
> >> xfrm_dev_state_add()/xfrm_dev_policy_add() if (dev->features & NETIF_F_HW_ESP) == 0" ?
> > 
> > As said, I think this is the correct way to do it. But let's wait
> > on opinions from the hardware people.

But the current behavior ("ignore NETIF_F_HW_ESP and call
xdo_dev_state_add for new states anyway") has been established for
multiple years. Changing that now seems a bit risky.

> OK. I guess something like below.
> 
>  net/xfrm/xfrm_device.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 52ae0e034d29..19aa61609d24 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -292,6 +292,13 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
>  		dst_release(dst);
>  	}
>  
> +	if (!(dev->features & NETIF_F_HW_ESP)) {
> +		NL_SET_ERR_MSG(extack, "Device doesn't support offload");
> +		xso->dev = NULL;
> +		dev_put(dev);
> +		return -EINVAL;
> +	}

I'm not sure we want to make state creation fail in this case...

> +
>  	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_state_add) {

while it will succeed (just without offload) in that case.

>  		xso->dev = NULL;
>  		dev_put(dev);
> @@ -367,7 +374,8 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
>  	if (!dev)
>  		return -EINVAL;
>  
> -	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_policy_add) {
> +	if (!dev->xfrmdev_ops || !dev->xfrmdev_ops->xdo_dev_policy_add ||
> +	    !(dev->features & NETIF_F_HW_ESP)) {
>  		xdo->dev = NULL;
>  		dev_put(dev);
>  		NL_SET_ERR_MSG(extack, "Policy offload is not supported");

-- 
Sabrina

