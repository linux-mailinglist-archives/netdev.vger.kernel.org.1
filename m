Return-Path: <netdev+bounces-181154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACECEA83E85
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875C41629F0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1EF2566CB;
	Thu, 10 Apr 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MQEyoQQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDdhcBm9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221272566E1
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276873; cv=none; b=rXzosaCwJAC6MEUiRKPPaR6kRAT/sj1Q2cfCdT4bfr356JjxNZivfQNIZsqoeN5mE/KN9yrGpHr6uFwMF4aIRBoS3TXMJp64Rq0gsdznkDHUIW57qZ1jHmAbvczIZ2dy3WIpmfaLnlHGoCU+JX6ofVLOPMsmwg0I3OckEof7uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276873; c=relaxed/simple;
	bh=ZHAtDzBG1LjLiRnGYrLCqQIR8Frv1pXStwdXmALTNKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ1OcvqBwCdMxWlleInHnpztThxM6TTrnjoO9MGHqwtj/lIzmAtmlp6piNAjLPZNe7r52thnxAokdQDYYOfIDlatRzfwF0gilF3MM75rLi5inHR0VcqcQe58v8UYnyjnMPvTHq3crCi9HGPKOVER1JKns7veoOthXrhfaE4jW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MQEyoQQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDdhcBm9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17DFE1140074;
	Thu, 10 Apr 2025 05:21:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 10 Apr 2025 05:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744276867; x=
	1744363267; bh=Z76ajxZL0xKnoxMFRBYrRXT7TG+T+S3SI0wUMgCzRt0=; b=M
	QEyoQQk4b7/pNi8aA0VIlj6uF0Br3W/fgIJYPX4/xYJBRlxJ2dmJqJRwXb+hXCtb
	x2MfuS4+5fSkNI8dnsVLLKm3rgWBdS16zFV0p+3pKy0Afr5eEFyJNs0YMCa9tAB5
	DuRGkX4HEVKen1ZMY3j6oAWuvgpczH79yi649rCfL+o/9Tofvx1m1yZAaIv5pNhc
	F1H0yzlFHml8O4dOmiwrs5NlFFwpnDd5SCel0a8tRdN5YsuFgfN58K6+9931Rvup
	dV2WAlXI+0xFWcagECijI2kFNiMxTuYRCY6sGHGdYUFbcvmmlJOC+rVqjVZUAdmZ
	5EDUdeq7/l6TSsZdrEjHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744276867; x=1744363267; bh=Z76ajxZL0xKnoxMFRBYrRXT7TG+T+S3SI0w
	UMgCzRt0=; b=gDdhcBm9X9V02GmXk1GZOmiwI7Xw2z61M6fSljTKnh7dFdE8dmp
	hX+cmTymiK50chTYob6Bsz889NM5r74HTd5FGhMupCaS0SGmEzh9mD/xPwdEzffl
	kk5/iQNqZXvFz1Rg1U/Gtr3Mzj531erl8w9bPoqfzaUrrw9+wR1Lx7n5LbOy6pgc
	DmHgxHA1HcOgy/V67yKSMSLCCM3pGCkLFlRyt0F5AUpU9nIJCXGB+QY/Jlc3vBVG
	Kkl4Y7+7ebzHOc9VG9yVXbOqD438Nvvgh8M5p9zu7w4B/HkZbqAe/2TL+F8kdkCM
	FDsiV+hxLnbNsd1qgfjJGGwMZe5z7C2eRxQ==
X-ME-Sender: <xms:go33Z4eYFauGLbICFf3sk_YEHr7EmZcnjSbaiRZ16KqmVTq4_a5iig>
    <xme:go33Z6NXpTXq6nGd3YDSb6CpZH-ehGNWWc5vntNPBr3bCHZ3rvNPeaOQhkYpOjJp6
    woqdBzr1Ll9fqOMo0s>
X-ME-Received: <xmr:go33Z5gax3_xNydCWegulqR4LH41YykVdwaUsxWndF2waRXo6bpMWfIL7t8C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephffggeeivedthffgudffveegheeg
    vedvteetvedvieffuddvleeuueegueeggeehnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtph
    htthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghrnhgvlhesghhmrghilh
    drtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvhigrlhdrsghirhhgvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:go33Z99OruJJPGplP9KfT3tOUhnIKyfmAYxUphEacuAoFtmaKWaFdw>
    <xmx:go33Z0uz63K73v8pxBUnQ0H5Gtjz4Z80h-FHmkPPn1ycNU37ytg1Eg>
    <xmx:go33Z0FVe4We1Ln_siWSncbRJgKEwql_e1e1KwCDJScg48jiSiM33A>
    <xmx:go33ZzNEpQytwTURJ7ppxnby1wKedYtbYa6Weh4Q24CQAbMuSTSGvA>
    <xmx:g433Z16BZKP4UEtqC2b0s898tBLwLJXllkY84Y30M4IY29J5rluD7Vdq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 05:21:05 -0400 (EDT)
Date: Thu, 10 Apr 2025 11:21:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>
Subject: Re: [PATCH net-next] udp: properly deal with xfrm encap and ADDRFORM
Message-ID: <Z_eNgJBm5RucHjxb@krikkit>
References: <92bcdb6899145a9a387c8fa9e3ca656642a43634.1744228733.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92bcdb6899145a9a387c8fa9e3ca656642a43634.1744228733.git.pabeni@redhat.com>

2025-04-09, 22:00:56 +0200, Paolo Abeni wrote:
> UDP GRO accounting assumes that the GRO receive callback is always
> set when the UDP tunnel is enabled, but syzkaller proved otherwise,
> leading tot the following splat:
[...]
> 
> Address the issue moving the accounting hook into
> setup_udp_tunnel_sock() and set_xfrm_gro_udp_encap_rcv(), where
> the GRO callback is actually set.
> 
> set_xfrm_gro_udp_encap_rcv() is prone to races with IPV6_ADDRFORM,
> run the relevant setsockopt under the socket lock to ensure using
> consistent values of sk_family and up->encap_type.
> 
> Refactor the GRO callback selection code, to make it clear that
> the function pointer is always initialized.
> 
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> Fixes: 172bf009c18d ("xfrm: Support GRO for IPv4 ESP in UDP encapsulation")
> Fixes: 5d7f5b2f6b935 ("udp_tunnel: use static call for GRO hooks when possible")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

