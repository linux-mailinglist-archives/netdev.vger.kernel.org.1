Return-Path: <netdev+bounces-238685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A7C5D96D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBDB034A591
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698E3161B3;
	Fri, 14 Nov 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="eorJUrvf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BuNg/fGI"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F8023B627
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130151; cv=none; b=IGVvR/WeAXgJ5Hs9ZDZXVCilPV8lmiPTbwIlFM0Z/9T3Ei0Hhkd4qRvdgz151Z2lM4ygpFj4DPrBfisMWffbviaUA/Hy5KRx2A5bkF4BvKcRY+LG7plcmf61tHko+bEy+RSYtCEpPvVNfQrFR0WGBx/oTYj7C/3yjdx/wmH1040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130151; c=relaxed/simple;
	bh=MUJqG9FNSj4zKBQ/7HERCgXmej3DMBRw0bkzlZyTOco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csgx73PzDZXSwdrucE+uZdAWOA7HcIM99Fh6yCqYaDv3OfhSnEnyPT9wxTttNHOo9mUsTYbtFKQbXfGLPeEy8Bdm5SzUtd73P0FTB05Y4Knk+fAQUCvfUM28hzqNGsI+s7jvxyZjQL9D6bCKxHEQY+/RnMy9V0M4EsDhtp07wus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=eorJUrvf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BuNg/fGI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 81D2BEC006A;
	Fri, 14 Nov 2025 09:22:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 09:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1763130146; x=1763216546; bh=fTTUqkqm6SFKpxYDy0i6AFHBZrl7maee
	3/4QOe6vXeI=; b=eorJUrvfOSG698A+sqi5FZbaa+/ym+h8LlD8yAT/KgAelwNK
	Z+eMZd62HIh9CRaHihXawADkGfitkQwyQdT9tOs4mcmXGmO8w4R8maCx+QgtChG/
	rEln41UxjVwA/F6HGdxedxDgiQ8ranjmFc12dO9ptgPaNurmlRH242wkYLOllAO1
	OvybrlJaKTLisQPGsHa0VglShlkJmsOhhh+N2/wxcjOzy16yVhzU/kNZEcjAxI8C
	4Mo+G/zHmMj8jhK6m7hZxWnT6c9E9x+iMU10pSGHVzl4+rnmI3XR8tKOKUCw2/uY
	r2M76vSwhrCx0ueCTna6mtwj0u8dV2/9yzHs3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763130146; x=
	1763216546; bh=fTTUqkqm6SFKpxYDy0i6AFHBZrl7maee3/4QOe6vXeI=; b=B
	uNg/fGI2t9Kny+iI2RkjiN6Rws8YeKuSaBYu/uvSNiEeHw1u2EgCpNFlJjQ4dxVd
	K5BshyDbH/6YjTtpH5462fYckrCXBDIV0pgib1ilRsD8PCZbFzaS01qjIfOoSl4y
	KjhJ+JU5i2rQ1mK03EuYHNVbnLc0HQo5Gc4ycqF9HEsixrF9KWpsEQW9EuIwMPOi
	lJSYYxYelgG2dbot4PDQIBPkglaUXVkAItlnLT3baCkYt2+i6x1dlCeQPL6a/CCe
	UZGEjupmttTgeZR+NsX3fBinWD5SWElDAhfz0Opuikdcb75itKqwmlmBBmJgwdKA
	0x+9JLcX+bvc6qB3QdSYQ==
X-ME-Sender: <xms:IjsXaVQibvZ3R3FA7iZzKX6cAjlKgaLo9XXiq65yXk3RRtnFd9vZSw>
    <xme:IjsXaSdXnVTUf5VJ1K1_grop8ruPNka4DyGybk2GOPqX1DiNu6I0rnlVZbhOOLrVQ
    TfStGinRonEpqLx85sI_Z_O4qhTjIcAtft4zsSdtrvhWAyV5FUC7g>
X-ME-Received: <xmr:IjsXaUqAAtbrjYXfhPCLL83WHsBZfEHVtpq74wmaLHlj6KfV3tdegbjt8C_3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddttdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhht
    ohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:IjsXaT-LeLK28osc-pWEbGjBvurdXsZhBfcjwxXG_qwtrysJfjymRg>
    <xmx:IjsXaQez97CAHm7MlWzcL511iw9MQPJe4HjDJx9LEmAlKSqAJ1Y0jQ>
    <xmx:IjsXadKi84_o0GV22kccQCfn9_CDQVFyIh4i2gvYyww7XzZKbryjoA>
    <xmx:IjsXaQh2pXJYjyav5_gWGi1KWyDNWaykCjKG2j1iTWct5kyNqniNjQ>
    <xmx:IjsXaZYZ4wy10paKLcqZOrwGts4h-TXH6xioypP--dDoI84a6a4lGhZ0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 09:22:25 -0500 (EST)
Date: Fri, 14 Nov 2025 15:22:23 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/8] ovpn: notify userspace on client float event
Message-ID: <aRc7H4ne5cCgZvyL@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-4-antonio@openvpn.net>
 <20251113182155.26d69123@kernel.org>
 <fdf87820e364dda792a962486bef595cd6428354.camel@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdf87820e364dda792a962486bef595cd6428354.camel@mandelbit.com>

2025-11-14, 10:26:31 +0100, Ralf Lici wrote:
> On Thu, 2025-11-13 at 18:21 -0800, Jakub Kicinski wrote:
> > On Tue, 11 Nov 2025 22:47:36 +0100 Antonio Quartulli wrote:
> > > +	if (ss->ss_family == AF_INET) {
> > > +		sa = (struct sockaddr_in *)ss;
> > > +		if (nla_put_in_addr(msg, OVPN_A_PEER_REMOTE_IPV4,
> > > +				    sa->sin_addr.s_addr) ||
> > > +		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT, sa-
> > > >sin_port))
> > > +			goto err_cancel_msg;
> > > +	} else if (ss->ss_family == AF_INET6) {
> > > +		sa6 = (struct sockaddr_in6 *)ss;
> > > +		if (nla_put_in6_addr(msg, OVPN_A_PEER_REMOTE_IPV6,
> > > +				     &sa6->sin6_addr) ||
> > > +		    nla_put_u32(msg,
> > > OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
> > > +				sa6->sin6_scope_id) ||
> > > +		    nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT,
> > > sa6->sin6_port))
> > > +			goto err_cancel_msg;
> > > +	} else {
> > 
> > presumably on this branch ret should be set to something?
> 
> You're right, otherwise it would return -EMSGSIZE which is not what we
> want here.

But that should never happen with the current code, since
ovpn_nl_peer_float_notify is only called by ovpn_peer_endpoints_update
when salen != 0, and in that case we can only have ss_family = AF_INET
or ss_family = AF_INET6? (and otherwise it'd be an unitialized value
from ovpn_peer_endpoints_update)

(no objection to making ovpn_nl_peer_float_notify handle that
situation better in case it grows some other callers/contexts)

-- 
Sabrina

