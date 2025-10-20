Return-Path: <netdev+bounces-230848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBEDBF081E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88853188FFAA
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E882EC0A9;
	Mon, 20 Oct 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wH7vHWvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZeh0K5X"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1212E92B0
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955457; cv=none; b=a9oFujKxuMaTKui9WpxGJkkbTOL7kmIPEXXLagIjjadrjqSdXBsR1QiegsbnueDXGsPadyXK64BEW+CHFVkFux+70Xkdep21jFEnNEhE/nUbXSGqsj4JdlJx3sr13n2ZZ4at0+HzY20AG0dgqQ02Yk1aDbfxzSxNxx1vH8GRNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955457; c=relaxed/simple;
	bh=5bDBi+YsQzx4AvB3xDoYWwAkb82BDwEcTesSJW0xAwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrtFMdORqQl0xYGfcbU8RcdisYTAh1eQrS0sNMpflPDLclPHR+DWbuBA1L7HCSXr57+zkWpXX1uvrEgxepPTbVyfO9V6JSjsfXeMnx1K9whkK0kflPPFWgfRHHlK0L7GiVgaRBQsAsYPYxhRAR8A15jpfCnDRvWQlMEbdnhskt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wH7vHWvB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZeh0K5X; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 541F21D000B5;
	Mon, 20 Oct 2025 06:17:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 20 Oct 2025 06:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760955454; x=
	1761041854; bh=1NTv9qzzGXwRKzb/6A6fdcqxaVzKfSk75sqW3Xqg5Vc=; b=w
	H7vHWvBtJxM3sXwMfojBCerlo7V6aNumcCy4DcPmtjzPjMxPUN1sNs+tbnfVI/4d
	VT7eCyFh/5fM4HvnpJoJqlhPp1fdqStEKZaCDyIUxOpZxKwuAqsrEkCOwQWeUnOd
	+ZwZRiHFMB/7pV9QXjhovttug9gwly/TfK2FY08eyuaBg7XxODJRc2TIusrsykcF
	RL6xB/6B4IeJ4x6aeq0ZuuzIHZWjXIzWcqRdew+rqu05NGdrlQfcToPif2tK91iy
	RLvu+7/tj3Ps64HKH1CGE9g+nQClFAbvRSg1TnQGKJcJprmsRNubnF+KONL+p1uR
	XpxKrk5mLcfuOgNqSYtgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760955454; x=1761041854; bh=1NTv9qzzGXwRKzb/6A6fdcqxaVzKfSk75sq
	W3Xqg5Vc=; b=hZeh0K5XGeW+C5jYd0dB8gZg3ZV74LTl5QjClgsSIXQHYwHSdT1
	8dAPBFeMZ0O0HNmTyyvpndg1r6cDikTeHL4F/+GntWHbRPhHLf9gZMNTHxTh2El+
	svJGiEbHf+UiLNMI3CCge1To3UxEykLhfsjXzPeGp945pzbSDjFgR1vC5TV80cKk
	zTkgnKKnYJOdLAz1OcXtjAvEaZgEwow+K3DLvpoDmY58SJYa+5hinBcLLFlZZh+0
	yWn4RWSNm+xea8jfjVTdYZDuQtX+Umcg9n77f9rUtoxH6ruLAT/Q2lzdS5vnYISE
	t+DVBbKXXg7A5RvrgUVpbODqhetPQMnB0tw==
X-ME-Sender: <xms:PQz2aLfIlYRLgJKq5RJZ-LoTKyEQSfExlcRnaDYuNgPnEgnvdjbzIw>
    <xme:PQz2aNzGmjgzuhIz69BfrBugsXt85yXZr5wExxoZJUhhKohMsnRmmh2mTTcUxnuhk
    qBOTSm3KByCGq7TSDSMGcC0cDg_86FDUVtjs5g7wAc9vMN5KRqT41w>
X-ME-Received: <xmr:PQz2aI-MBrcNGAMg3QCq895WzQxJBT60JO5qPlHC4X5DAoMCQ3vnyJ1yFTjp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedutddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrlhhfsehmrghnuggvlhgsihhtrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlmhgrshhrhihmihhn
    rgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvggsihhgghgvrhhssehgohhoghhlvg
    drtghomh
X-ME-Proxy: <xmx:PQz2aDxUW5YB59HwGqThpjVeu_uJB2dsvpxKySwdZnU2Fd5PgoEcFA>
    <xmx:PQz2aIqd_h0Vv5eRvBtGR-Wm8WkncLSkVCIUxJi3IyEIjmW7cpwyXA>
    <xmx:PQz2aEqHLUcv1GUUVwKN4bmIBfVUK53qg9H1ihEm4O8Z8jz9FSbc-w>
    <xmx:PQz2aIB_562KW8S6wQiYAch2LrpWHQIUcDEJbtIRuO9Lvk1EJsd9-A>
    <xmx:Pgz2aMVmtUjDB9h0t5P-oe5Xs52-S2i4_i9Xx3wGORoJmUCXju1QZBTO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 06:17:33 -0400 (EDT)
Date: Mon, 20 Oct 2025 12:17:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net v2 1/3] net: datagram: introduce datagram_poll_queue
 for custom receive queues
Message-ID: <aPYMOwuD_PO7Nim_@krikkit>
References: <20251020073731.76589-1-ralf@mandelbit.com>
 <20251020073731.76589-2-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020073731.76589-2-ralf@mandelbit.com>

LGTM, just a small nit:

2025-10-20, 09:37:29 +0200, Ralf Lici wrote:
> +/**
> + *	datagram_poll - generic datagram poll
> + *	@file: file struct
> + *	@sock: socket
> + *	@wait: poll table
> + *
> + *	Datagram poll: Again totally generic. This also handles
> + *	sequenced packet sockets providing the socket receive queue
> + *	is only ever holding data ready to receive.
> + *
> + *	Note: when you *don't* use this routine for this protocol,
> + *	and you use a different write policy from sock_writeable()
> + *	then please supply your own write_space callback.

Maybe you could document the return value here as well, since you're
touching this code.

> + */
> +__poll_t datagram_poll(struct file *file, struct socket *sock, poll_table *wait)

-- 
Sabrina

