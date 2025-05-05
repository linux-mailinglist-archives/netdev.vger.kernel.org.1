Return-Path: <netdev+bounces-187676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9357BAA8D27
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9741892D98
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D031AAA1F;
	Mon,  5 May 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUd4RoEr"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AC14AA9
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430727; cv=none; b=Xmr46C6bFYWhi33CEVUtXgn2tjEqn6VFK7VuUOh38081JfMIiRvv4ZE7b60spHueWD4GnMN0YMq9WezeSBXO70c9f0pS0OcftA/0KXiSDz7mVnluCUWWnctvYUVGJQCS87ckPZ419IdTLnSqorkpXOqzfbdfFz55U/DkD1CkzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430727; c=relaxed/simple;
	bh=Z6Gb8mwLjXQ0Zk5osbDPifZ1fceJUjnD5q3DxKLdXO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKe+RnDxfS42yTmNa9dZy5W7/jJiVeEZ2bxtYVYoWp4Lw6slX1Q1NDzn/1gEv2f8bf61MpIPAt/h5Aq81DQtWwafF2qWr++jjiJIe12yGPCemGaoTF57AeKCL+cmiSpOtozyyX/lmg0YUMOLKLvx2hSgltLxsdZ9WYzucNiroWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUd4RoEr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E66C1114018A;
	Mon,  5 May 2025 03:38:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 03:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746430724; x=1746517124; bh=24Ylv/f2AxNlgILEtbkWVvD3+rIOnpfmIEb
	4bdzPL1c=; b=iUd4RoErMdc0OGa9jCIooL/maly6wZSw92d+4PqcSiY5ak0oxuY
	OHnMh7Edwk5mojN/WNWIr4iVhVnBzLO9BbwwtJv9OcUYdTLWw7rNMU4sfss9T4re
	UOj3PD2kTg6HeVo6VD/yBy8fGQKnavnSk27nHvWkEwTB8y95UN2Owbtl1uviJIvy
	2XM8pmvgoW5pneIVeHL4fGgjldgie6shXYq4bJ/5lMkNGYzUrBtKP2YjBdv002h2
	rKSa5Y3rNYxkg471qbPlnDETM7ClWp1Rk9iCjSGeea18hS0qFIeAmBlgSF9jHI3S
	O9S0Jn50yvySdDeyssAkwXQDVbiPNO3e7Mg==
X-ME-Sender: <xms:BGsYaEkQKfybklkS_y290I3bVfuWbL32Zo3XhwRRK402fF3oLb1Qgg>
    <xme:BGsYaD2hX9u4jHJKveKStPl1Gn4wlvcs1M2FBeWuob5m-yy6gxZIfyIvilYfYNtSt
    _a6WMzzVCW_3CY>
X-ME-Received: <xmr:BGsYaCrNMNR78LeLMSp8Rk0CLTA4oaOGXU9b9-JBKdYt5VkfjrhXAYUuajS7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeegjefhffeigffgheevfeffteekveekudeu
    heeiieduleegtdelleetkedvfeeknecuffhomhgrihhnpegtohhnfhdruggvvhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhes
    ihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhnrghulhhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrnhhtohhnihhosehmrghnuggvlhgsihhtrdgtohhm
X-ME-Proxy: <xmx:BGsYaAmDtgTAQ2jxwVxOV_7PJbMurxgdDiS2T2QDx23nXzCmK2jn7Q>
    <xmx:BGsYaC2l_9GABme0FEV3pyx-eef7LM6BhyxDFS8MU6h6NB9n5Nebcg>
    <xmx:BGsYaHteouQoELPwFdfy6LDJdA0D04gPyW3dRMuNb3Eg-PWjBD-knA>
    <xmx:BGsYaOVNBnBZnMcvqexZUsgcGh5svobKi48ktO_wJJlpZHt2fNC7ZA>
    <xmx:BGsYaG3AdtEaEsqa18QI1l7DF_IiCbe0jT6hByXtD4M7dezJw2Qu3EGw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 03:38:43 -0400 (EDT)
Date: Mon, 5 May 2025 10:38:41 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <aBhrAacLs1H1KliD@shredder>
References: <cover.1746225213.git.gnault@redhat.com>
 <2c3a5733cb3a6e3119504361a9b9f89fda570a2d.1746225214.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3a5733cb3a6e3119504361a9b9f89fda570a2d.1746225214.git.gnault@redhat.com>

On Sat, May 03, 2025 at 12:57:59AM +0200, Guillaume Nault wrote:
> GRE devices have their special code for IPv6 link-local address
> generation that has been the source of several regressions in the past.
> 
> Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> IPv6 link-link local address in accordance with the
> net.ipv6.conf.<dev>.addr_gen_mode sysctl.
> 
> Note:
>   This patch was originally applied as commit 6f50175ccad4 ("selftests:
>   Add IPv6 link-local address generation tests for GRE devices.").
>   However, it was then reverted by commit 355d940f4d5a ("Revert "selftests:
>   Add IPv6 link-local address generation tests for GRE devices."")
>   because the commit it depended on was going to be reverted. Now that
>   the situation is resolved, we can add this selftest again (no changes
>   since original patch, appart from context update in
>   tools/testing/selftests/net/Makefile).
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

