Return-Path: <netdev+bounces-230823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACFBF0213
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD87C341BF3
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014592E9EA0;
	Mon, 20 Oct 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KRY2lsgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOe0ig4b"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE942EBB88
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951872; cv=none; b=q5xypGOSEHaMmdxI6ujvRxRh2KtbfHIAsoZz61ltXdlF7xBdSh8v2e+I3UQ2VhWRC1EsK1PAPCD8iyh179QXoaYfeww4Di97IcD5Ux9zjwitT+KUUtc6SNR3MJjygBfD/QdoMGEWZXJHFpPuyuq4HfBSbvX7f/drFmmFfgfNMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951872; c=relaxed/simple;
	bh=IcOzGfRCiD84omBUBER3702x/g94WvAaK4yDyl2lh9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpV/G2vgm8Qnk+dqQIdY9UOPN805Y/IUeJq85FomprppCD1/rsw74lK5VGuBrKRmqp3NENVt409Rhi0yPdbsNJsWv2VVFi+tKbUME0fvf9A4UdG7+Gqc1DJiPRgC7jdA/yI/c8pGsJ/9/ffuOGaFDQdwZzNe9kmwoWLAvvXv1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KRY2lsgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOe0ig4b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D120C1D0002A;
	Mon, 20 Oct 2025 05:17:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 20 Oct 2025 05:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760951869; x=
	1761038269; bh=AIfRkYJxkIS5P5kdA6Sl13c3qk4tod36pCxOV9tgd84=; b=K
	RY2lsgSKLgfvDXeFixPglzBA+iSdEs97NWrIEhPZ0K1w7eIkSlrfd2kGCo945pqT
	55jNvHv6X7ne1IkcXo2+ZM9IIeP92GJezbHDa9dXhm9jZYyJGR6uor1+mVhwh4Db
	SBCEQXqtSWWXz8+v9Px1hU1su4DNeKXu4MoLKBoUXzHMaUye48A+AxrPgT9dbcP/
	n7GIbdUPeMoYQ3mdcEausA5Pw5GX9JJIEr0j1ziXBR8JEfe4xQGU+b4ECBz3TzR8
	jfRGZHSPa2F7F1uwI6hOGmIhf2SOBjfmOz4ETnzXaKj2VhEUmurTLK9pU62eyRv+
	aCbkY3R6tGuMfH31eEPQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760951869; x=1761038269; bh=AIfRkYJxkIS5P5kdA6Sl13c3qk4tod36pCx
	OV9tgd84=; b=VOe0ig4bLozaNZCZa6mfA+f9ryn3VXjo74zcWbGvKW147JjwUUa
	VU8rCr6oAbNTkb6WO0IGQl3KAxcfizIYVHAOTwb8/oz5XTRiEs674K0B4RxCVikh
	UnHtkyJxE4l5ZO2agKLye3UbQt03r6eSD3RWsNeY5JQoR9oSdkkg3AZFNsTrXoGY
	KFrZ2VzqM2AHIIy60GYFLToiPnYaYTPrm3mhLpbrLT+ESOQPfFTOE4cRIaQGjA3g
	Q5Z8kVOcJu4qaPuhj8AnVMk2wizjywyiaqX2yLpE8m7agoYPXmknCCfBqRPTifkr
	Y5EUVQ88rBMewP6Sw2jdgw90fK/F010x+3g==
X-ME-Sender: <xms:Pf71aDUp08oDc1vxuwjXxp8E8fMXNAjUnMGQY5bHvA8R959p4_ykeA>
    <xme:Pf71aE91MNfVR16yxCajDFbp-pnbCbwrxRZ2wTMeAXzdEyqHH32VARLbMie4fuz3C
    BYtPEDcY9v1y5dTAh7e9dtCZ4QCQaF6aorFNHdyGYFFpPtr_L74RA>
X-ME-Received: <xmr:Pf71aH4q2p8F8qw2yj15FW_rkUXk6_NQYfxiJk-KANUUsNxyj3tSr3XT965m>
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
X-ME-Proxy: <xmx:Pf71aN3Jcb7FxS48aBsobJtkf7hDWZDb5UQrTlulmIIRHLjgdtHrrQ>
    <xmx:Pf71aOyGOO4zOrRkTxU8WUZmHm0EgSklCZzBouZSC3goIzhn6Uw8dQ>
    <xmx:Pf71aGlEW-66nWk0OxyW3EVLzeO6xQCbxoSfEtH2jx2glJWE-5lOgA>
    <xmx:Pf71aB8ZFFWbzam7HQ-a-UO5hy_Jb1dTTj8YtJbY4eNppOwoPF9ycg>
    <xmx:Pf71aBPfZlpowByHHGQAMKT-PuisN9OB1228RjS90JlpgViRUw8O4fpe>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 05:17:48 -0400 (EDT)
Date: Mon, 20 Oct 2025 11:17:47 +0200
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
Subject: Re: [PATCHv6 net-next 4/4] net: bridge: use common function to
 compute the features
Message-ID: <aPX-O9vPowb_tb2U@krikkit>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-5-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251017034155.61990-5-liuhangbin@gmail.com>

2025-10-17, 03:41:55 +0000, Hangbin Liu wrote:
> Previously, bridge ignored all features propagation and DST retention,
> only handling explicitly the GSO limits.
> 
> By switching to the new helper netdev_compute_master_upper_features(), the bridge
> now expose additional features, depending on the lowers capabilities.
> 
> Since br_set_gso_limits() is already covered by the helper, it can be
> removed safely.
> 
> Bridge has it's own way to update needed_headroom. So we don't need to
> update it in the helper.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  net/bridge/br_if.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

