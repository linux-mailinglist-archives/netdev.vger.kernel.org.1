Return-Path: <netdev+bounces-232060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA4C006C4
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46EA3ABABE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27692F067E;
	Thu, 23 Oct 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ySJWEZSh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVPJdHwS"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679482877E9;
	Thu, 23 Oct 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214664; cv=none; b=B5DB8O7dQLp9snWJRMxtRkJ6vbQYRceyAqeAzMLNgZAx5ClAZKWbQ6abpjVFqbo41Hk+XhCy5FdBW8AP2vCja3XtylgA5SifujyS9os+UAsA1Nd8keqaRO0onKsaxVtu0SjUecifqyyTTSVCD4ohn4hfwbCLOMnYRCai9rxoWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214664; c=relaxed/simple;
	bh=PKb6OWXnBpHzzIXOW/0BX9nVRDqXeX0JLCvRZOvYUWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv7U/Mbq6sa0+/3ZvdFkE99lYVGkWZfFXon3xuFFa03zPpZcgr55fd79FrypPo834Imsqqj2RI/79joyEIUipRyxVkhZJ9qSVdHDAmiWvf7U7PVOm3+b2XI6OLLlgpqp1P3At0/f+M9IpKtEg0QnXM7MRJGw+Wocs2a41vD7YTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ySJWEZSh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVPJdHwS; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3096C14001AF;
	Thu, 23 Oct 2025 06:17:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 06:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761214660; x=
	1761301060; bh=M8v+JxvCIxN63ogr+dP2yNpm+WNZR/9guiHXDe7e/TE=; b=y
	SJWEZShMb6C58s7R9wOzaQwZLpp3R+Q3OGZiX74fe85PIZQDr4R1SDK2GyhZwxe0
	0kEYorQqmr8M20dLY7UvAOxd7ne28R8kb0tjoKPFG0wGDsPXHMr+FYMyl2Xr7JGl
	edwV0GcnjFQla/frXHhu3GsJ5OCZ5lrc+N46j7DFCiSCDZ9JU1m3cMs3RElbLBLH
	UpjCoLrtDMj/LNgAqhiURqBO2wRvmC8Yz44P+nIVDYUbMJDlQ0q00I7tAg7XrGDv
	mXqIgWSHCruKBGJX2c9Oc7i8O+9OwqmugybB5622ROjc0Unm73/rpU85mNNOctuT
	rIIUDonLGdlxKe1BiILvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761214660; x=1761301060; bh=M8v+JxvCIxN63ogr+dP2yNpm+WNZR/9guiH
	XDe7e/TE=; b=aVPJdHwSg4sepaZKN0JQL6eHfw8WX3UBzfB9YPUQrvUSI9dhPYh
	5UMMYticZqA3+ZMayZcqNIb6oSuxvKal4p4CTn1zV5U9b6lF0yqj8GFbGmjrrEPU
	klSMCVkTeXMY+PbL8RVJrBGqTn22uJxxutZYj0N7j4bGoZKTlUVRsak/DLrM2sKC
	T9sNwSDPrLSPqTjwT0Ysn9sblMFaHaRVHklnDN5oc/QY5KzPXRVyWjY1FSilAdGs
	96IjO78dHbIiQb0LI/wLOMK8euCVMvz5qtCO67EFHhBvaGrgCcusip+XFmmZ/HWY
	QFhYGsOCrpZzvPUBXXzmQE8xI/fPfiMv1kw==
X-ME-Sender: <xms:wwD6aEFhehWSxsz2UgiAlrTWWCjxajHSoYDZc-zsQmEGdGIYJs-Haw>
    <xme:wwD6aGo-VQJm3eRPIecdXTVFZhlmh6hD6pxOKO6FUKs5y3OYk3h-zws8G5zE8FYVm
    EPE4-NCtjuL1fJpg71ObRScAhtotjyUuBzn1b0G9fq9asxKuQClUNw>
X-ME-Received: <xmr:wwD6aFaejHDq4W1_C-Tiow2aLQ4YDGXvWu41ii7_xqJ_HmxQK4nPPc1sc9p8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeivddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsihguughhrdhrrghmrghnrdhprghnthesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepfihilhhlvghmuggvsghruhhijhhnrdhkvghr
    nhgvlhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wwD6aHXNmFzrIPyvmW3q6X4gOFkqyCg41rtnXkK4ZRsldZeDQohXsg>
    <xmx:wwD6aG8Pi6FeeGpZ9ztO2Yt0MXSJCj8GRj8o3YPtRw1LV8al7GbhsQ>
    <xmx:wwD6aI9QNTNBVq5KXK8LN6dyzh6qz1HsyYwwTmDJvzTCq12hZ7v_Og>
    <xmx:wwD6aOSiK-UcSDaz-xa8ZW290ExtaxTm7CqXf5DjOh_mfuWvdCTH0A>
    <xmx:xAD6aEUKE-yIa0M6KFzthzPwfs0r0xSqaxj4ccJpT4gMggcQqRbhR9Xl>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 06:17:39 -0400 (EDT)
Date: Thu, 23 Oct 2025 12:17:37 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udp: Move back definition of udpv6_encap_needed_key to
 ipv6 file.
Message-ID: <aPoAwV8fHvYuC2Md@krikkit>
References: <20251023090736.99644-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023090736.99644-1-siddh.raman.pant@oracle.com>

2025-10-23, 14:37:36 +0530, Siddh Raman Pant wrote:
> It makes less sense to remove define of ipv6 variable from ipv6 file
> and put it in ipv4 file and declare it in ipv6 file, which was done
> in 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing in
> a tunnel").

It would be good to CC all the authors and reviewers of the patch(es)
you're mentioning.

> So let's move it back to ipv6 file. It also makes the code similar -
> the key is defined right above the respective enable function.

I don't think that works with CONFIG_IPV6=m. The ipv4 code will need
to access the key via udp_encap_needed().


> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
> I'm not sure why ipv4 key is exported using EXPORT_IPV6_MOD?

So that the ipv6 code can use it via
udp_encap_needed()/udp_unexpected_gso() when it's built as a module.

-- 
Sabrina

