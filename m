Return-Path: <netdev+bounces-141305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DCE9BA6A2
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2EAB21D39
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254AD187346;
	Sun,  3 Nov 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7tWqc8h"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190ED185B7B
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730651159; cv=none; b=t7eIp3zGR0wxIY90B7xM4DWATB6Gb/JRq2bJXB3IafYW1EdYx/EIe7N2ZuW62hBE+4liP6qWIuL4+KveM0FH1CRlPTbl/zPY2UZ8gMKZ3g3xTVGB5we7WJfmhRGG0t4T4irhXIaZHVJj7dyVMAG3+qfwXSUPh3+rlrVnjpilQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730651159; c=relaxed/simple;
	bh=YwTQ9j5iQttLa6olf1aekppLGlucGpR666jUAjtNtRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUnAOM+9k4hFgD4xBR0HYgGLMmX2mjMxnRJ8b1jL7eQM88Wq00lLRW6mTy92SJA6BwXF8IWHZqHTEd/YccyWVenl0O7DVR/wBCKHd/y9Gfxs9I8LsEeXFc5KVhGqrHh/bKZsQ5QAv/tvy3+9amu9vN4SuaZGpRKy/2rLh3ut4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7tWqc8h; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DA7031140081;
	Sun,  3 Nov 2024 11:25:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 03 Nov 2024 11:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730651155; x=1730737555; bh=TXhBYn6xKl1Q3WRdH+tX/2Z2Q1++GW8TghT
	3LA7EcWo=; b=g7tWqc8hEXXg1k9BJOFdOb+Sjg2Nz9dkGyXmyrtMOkLr5ulR0fQ
	O99Td5PJ8W0lxYpMmP/QsUiEN7G3frCqE8KLP4ZEz6FPdKdaBVgNMYHLNHaL71Tm
	6vNZw82xZ9cKXLlY2pIiPAxfCuyOU+Zx3hkAPumYsBTUgnb8x0nud3wMIcNi8Msd
	huvImvJ0qvOc58sBG/trnQvJQL0470CJ3eNy00li9jpzjIFvQ46bVAmoZcOhKfMW
	UD8nOX/yfyoJHs+7bBBfLeINuxhxQem8NZzER4SxErNlBYSGgroxkbm81CwhDBxc
	XBBMWp2PtsxLV5F9OSIZYWjF4w5sP+QfDRA==
X-ME-Sender: <xms:EqQnZ7kY-_ATLRam0TRrwXCPxCQVYhkKYLVcrjLBSH1JFGHPENHqUg>
    <xme:EqQnZ-3YobNv_4wRZctmd_P2gKEF1y-tCJaKs5rZbyXRvIMVMsEBxIZYlH1-ma9_R
    M7z_XhEu_9B5bk>
X-ME-Received: <xmr:EqQnZxqjqlyEvTVA7KyvtEu5f_qvrAexDUQlOPM-P-P12jz6NDKkkn0Atp41>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfdu
    ffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhes
    ihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegrnhhnrggvmhgvshgvnhihihhrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hfvghjvghssehinhhfrdgvlhhtvgdrhhhupdhrtghpthhtohepvgguuhhmrgiivghtsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllhgv
    mhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EqQnZzk6DPCFZdnvgTCKBv4asuqX3qmdXwAkPHUYFBmcKKPvTrVNXQ>
    <xmx:EqQnZ53EU4hbFO_egtG-cyVP8Mp2XcDQQSmAMdXwN1X54CKUfKtHTw>
    <xmx:EqQnZyth8jW49lWQ4ryR022hfF3aR56kEyuxE100axrTWwxrQ8xuFw>
    <xmx:EqQnZ9WSwQvaL9ChhMe18VoslVWRIeCykr1bD3BokKy2b-b_m8kS1g>
    <xmx:E6QnZzoeNGVyrDWptu0RUzKfsqkh-F2jYK1v7kQjMT6TUUZkxHiMvAQ5>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Nov 2024 11:25:54 -0500 (EST)
Date: Sun, 3 Nov 2024 18:25:52 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 0/2] support SO_PRIORITY cmsg
Message-ID: <ZyekEJHEzJnyX6_j@shredder>
References: <20241102125136.5030-1-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102125136.5030-1-annaemesenyiri@gmail.com>

On Sat, Nov 02, 2024 at 01:51:34PM +0100, Anna Emese Nyiri wrote:
> The changes introduce a new helper function,
> `sk_set_prio_allowed`, which centralizes the logic for validating
> priority settings. This series adds support for the `SO_PRIORITY`
> control message, allowing user-space applications to set socket
> priority via control messages (cmsg).
> 
> Patch Overview:
> Patch 1/2: Introduces `sk_set_prio_allowed` helper function.
> Patch 2/2: Implements support for setting `SO_PRIORITY` via control
> messages.
> 
> v2:
> - Suggested by Willem de Bruijn <willemdebruijn.kernel@gmail.com>
>   introduce "sk_set_prio_allowed" helper to check priority setting
>   capability
> - drop new fields and change sockcm_cookie::priority from "char" to
>   "u32" to match with sk_buff::priority
> - cork->tos value check before priority setting
>   moved from __ip_make_skb() to ip_setup_cork()
> - rebased on net-next
> 
> v1:
> https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@gmail.com/
> 
> Anna Emese Nyiri (2):
>   Introduce sk_set_prio_allowed helper function
>   support SO_PRIORITY cmsg
> 
>  include/net/inet_sock.h |  2 +-
>  include/net/ip.h        |  3 ++-
>  include/net/sock.h      |  4 +++-
>  net/can/raw.c           |  2 +-
>  net/core/sock.c         | 19 ++++++++++++++++---
>  net/ipv4/ip_output.c    |  7 +++++--
>  net/ipv4/raw.c          |  2 +-
>  net/ipv6/ip6_output.c   |  3 ++-
>  net/ipv6/raw.c          |  2 +-
>  net/packet/af_packet.c  |  2 +-
>  10 files changed, 33 insertions(+), 13 deletions(-)

Please consider adding a selftest for this feature. Willem already
extended tools/testing/selftests/net/cmsg_sender.c so that it could be
used to set SO_PRIORITY via setsockopt. You can extend it to set
SO_PRIORITY via cmsg and then use it in a test like
tools/testing/selftests/net/cmsg_so_mark.sh is doing for SO_MARK.

