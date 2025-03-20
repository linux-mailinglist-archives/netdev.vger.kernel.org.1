Return-Path: <netdev+bounces-176498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1609A6A8E0
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DCF8A0127
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED71DE3A9;
	Thu, 20 Mar 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ZB9YkaC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LhKiJafH"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6D1DEFFC
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481851; cv=none; b=BrhXc4LVf/cLrkBga6gj3pySHkKJtMtW5ErWI5mLGgP/zNKU6sZAuBNtNpuUEISCJiEWAd23bO/yQ1ThSl2Tz10YLKUxl/wKGSqJ33G65FJFaji5O7WkC5P/Nm+KzVYgChxlb72d3ILf3Af7Drv7QRmAng3IDBmZE7qi0t1NEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481851; c=relaxed/simple;
	bh=njoQx6qpC6FxQritPAnKD+HRl2wCL+8HDybLAhG1W9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5UsLwMTx1D5VWdcPz8YhuQHW9pqRTCFqfmXQFWHbA/TtruJvmR94B/WN9IVOLVQl4wVZ2x4BXaf6mehhcD8uKvU7V5IYmABefTjcrISdAY8kM1LW2Jjgz8yR6vzs+Uuf0rO88GnkW5brPVOEy1PlkQXK9/jXknYSBFEkdsMLno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ZB9YkaC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LhKiJafH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4188013834BC;
	Thu, 20 Mar 2025 10:44:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 20 Mar 2025 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742481847; x=
	1742568247; bh=wRGIcTtEAi63fSKwrWewyC7+lRdsxKDMeOLm2hLaq2M=; b=Z
	B9YkaC0mrF9jm0dwLTlI1rVNc7qbXBEj+nSKjNbTjKLNoTfMmA5Q0NvCQLQwGAqZ
	0w5H8A0ii6/DpHZesk/JneVf8I5G1way3riKRD+G35R6rAEmJgL3lXOmq4qIBTvq
	BKP8VBmTBIJaLAUqTFHl9KVwRnxsqJAXozYdM6fO4W94aLr5t9Aol0wKG3UB/0iU
	OkrJPtdBwBAwLVeaJCswCK78dj0LeK+zSXQ8dhFzpa5sIvLlt7z+xP/qMS3/EkgW
	ekpSdPNjocX7xgP/yaDP39YtNzMQpOfOLh8nki0NPkrn8Gv4lObnI9pD2GVr0tV+
	rnut/ZBkhA9H/1bLyTeow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742481847; x=1742568247; bh=wRGIcTtEAi63fSKwrWewyC7+lRdsxKDMeOL
	m2hLaq2M=; b=LhKiJafHAdIs3UqBlzZtvkyId9ROJi7JbY3qNZ3124cQv+quxZa
	EJTntCjvgdqztGyHKKo+zX2JaXhJ3VZNTEciOYyJ9ZyZrTSG10q7p2dFHXRdj03r
	91JtKDG/C4pL3RXrMZDHCWLlQq/dkKzDW33kGoNyFzZPuiPER3RT6m9pRqSa+M61
	COP2iMWOiWAo0tNZa4mH4hw6vdPCdc9ZaEOKIyJ2HkCx6xzmSgf7hYaQsyAaTYbI
	fUTmHuA5Lgj1bW+Pk7EwPtt/nzw55MIKGbdPLlY6X3mwjHiBt2VKgykdz221mfBs
	EBDKBx+PghHkGSRJ1qkJf3l0NypuG8wtRxw==
X-ME-Sender: <xms:tincZ-SQk22L4WG84i15P3i6lZcuRNWfSPdxRXWUa9ULaC1O8SD-7A>
    <xme:tincZzylJ85OWT8VJppDn-5HMUGhfGy_U4Qux2ACyodTbp2IhZ5Bv0d61LbHS3JTi
    BGNmNcM6-3YQKClfA8>
X-ME-Received: <xmr:tincZ72aBbgndpLt5BGleNNPQ7L1vK32sYUIhmUbNJvA0RJoikb9abwKAL84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephffggeeivedthffgudffveegheeg
    vedvteetvedvieffuddvleeuueegueeggeehnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtph
    htthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrh
    hnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
    dprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeifihhllhgvmhgssehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:tincZ6AciDT6kJPp8pm_msZp67JMjNDyj8rsAsRH3wrsclUPsyY3iw>
    <xmx:tincZ3i0bwcaDQtTStekscvwqp_Hgv6fvHQY2TBdfpJMww7uxF9TvA>
    <xmx:tincZ2pDOnZWerYnzZJjXVNkvniMhUOuVJ4ZS7tAvC3lvT4gjaFTSg>
    <xmx:tincZ6iBtTNe1aNCPr5ZPy2wDkyWmEVmuwQunmdZzBnSbM8HPN2TjQ>
    <xmx:tyncZ8ZUjBnK9-WhyZGy1nbgggvok-MgNVw0NmndjIw5QbDFk3tTbkVO>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 10:44:06 -0400 (EDT)
Date: Thu, 20 Mar 2025 15:44:04 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>, steffen.klassert@secunet.com
Subject: Re: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
Message-ID: <Z9wptMoWONs0FAFo@krikkit>
References: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
 <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
 <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>

2025-03-19, 16:49:21 +0100, Paolo Abeni wrote:
> 
> 
> On 3/19/25 3:35 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> The blamed commit below does not take in account that xfrm
> >> can enable GRO over UDP encapsulation without going through
> >> setup_udp_tunnel_sock().
> >>
> >> At deletion time such socket will still go through
> >> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
> >> trigger the reported warning.
> >>
> >> We can safely remove such warning, simply performing no action
> >> on failed GRO type lookup at deletion time.
> >>
> >> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> >> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > Because XFRM does not call udp_tunnel_update_gro_rcv when enabling its
> > UDP GRO offload, from set_xfrm_gro_udp_encap_rcv. But it does call it
> > when disabling the offload, as called for all udp sockest from
> > udp(v6)_destroy_sock. (Just to verify my understanding.)
> 
> Exactly.
> 
> > Not calling udp_tunnel_update_gro_rcv on add will have the unintended
> > side effect of enabling the static call if one other tunnel is also
> > active, breaking UDP GRO for XFRM socket, right?
> 
> Ouch, right again. I think we can/should do better.

We should be able to adapt xfrm to use setup_udp_tunnel_sock, but it's
not a simple conversion because GRO could be enabled separately from
the encap itself. I'm not sure there's much benefit except for a bit
more consistency when we enable the encap with GRO at once (but we'd
still have that odd set_xfrm_gro_udp_encap_rcv to enable GRO after
ESPINUDP has been set up). A few of the UDP encaps that precede
setup_udp_tunnel_sock have been converted, I don't know why ipsec was
left.

-- 
Sabrina

