Return-Path: <netdev+bounces-173358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220EA586C3
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 19:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA93AA90D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106661E834E;
	Sun,  9 Mar 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQxlJsaZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F71EF365
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543399; cv=none; b=uS411L7W4DGPr2V1vSEN4Uxc0y8x+faOWrTXIlldWe/m0gcuBVAYlIdTvMNDR80SVLCH00CmD3A3s0ijdd0oyB2MJIqG5tjOhF+FRE6EQSHd8OgkUgxvn0eiKdHN7tvCtnXZqh26ASw3H10al5qPp72QIJqYFSH0NbaaU7cqtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543399; c=relaxed/simple;
	bh=18g5Qc6mcQU5vKCDW2eJQatowXNNEJWgAuYnIec7Rxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRKhphVlgDlPXZd6ajqR7gvYkqESaZpEHWS0q8auniU/pYo47Iw1rcwi6h6/sF2tmV24CuauRYIIfhRA9Ebqp89bNZrF/ftfbqc3Ez/CCkf82lpIlTbWDGqMEaY/5RFVhdnwHAp23Tg3/D1Dc+68nuI7dLAZF8qxrefyakFBmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQxlJsaZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4C2071382CF4;
	Sun,  9 Mar 2025 14:03:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 09 Mar 2025 14:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741543395; x=1741629795; bh=xDzjZ/dZL/yVc1m0VyOlDJKYfC2nOoWFEDL
	kvHyy5GE=; b=qQxlJsaZnaJOWQdZnRVOVuEVaXPgUm1SJ/yISGua0swDoLTIoiW
	FedmmkAx3z/D4EdG2SNgoyzOOEt0vfYCTtWF2uZOVOMVKA/BDpTi6Bf4Wmfwz8aw
	AcSCQT170l5EU9i1uCtvalLeqoAImJIBKzlrdna9OOOA0i8poQY3IMtxt/giODEp
	bA4pZyCtgVGDkgJ0drjD0hPmBO45pNVw+FdjwTU9XfPpeGr8HQScgEu7Mfqrple6
	lpqdi5IHXvCKmmIKoRRNRN5IP0XWpQdq2fcJLvOLVKHI3AOx2PWKMJ0FaigBi9Up
	agC662KBHe6djrnXCVoH5LOUrg6vX0ISQpg==
X-ME-Sender: <xms:4tfNZ8q5yvWgh7zxVBZ1Gb-ZSIKEUSd1VEbVUOqJsS8sny440egusw>
    <xme:4tfNZyqzaoTIigvOYo7BSjIsC_a7UCAZE-eXxJm-PrwfIKB1LsnWeNQCpVm4uVH8W
    Zmqh2bOCXdOjJ0>
X-ME-Received: <xmr:4tfNZxNdfsx31vVEQ9knO4NFx4Okb1sukSPwmcWQR4U8QQO-piML8bxIJI2f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgnhgruhhlthesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsg
    gvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughs
    rghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhhiohesmhgrnh
    guvghlsghithdrtghomh
X-ME-Proxy: <xmx:4tfNZz4f1CVAZFuijhTlht5izXrwQryBnWgnu-lgIaS9zv6znSBa2Q>
    <xmx:4tfNZ77FznxXH4Ja4ekgyERqfNsWQhJTxPoS3kRn80XLM39yWt33Ew>
    <xmx:4tfNZziCwXmU04ZHAwlzXvLSVUDbA-5J3n-sej7MU6VI4SFk9DQ7Rg>
    <xmx:4tfNZ15ToMAAXVxU1j38D2-vyZfil_uNzMfJXfZBRWNWAdkLT8MdFA>
    <xmx:49fNZ4GLR8hsWx-zAkvPAI_5-rpr8SzwHuMjOOAk20ha2c6OVQrzo3EM>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 14:03:14 -0400 (EDT)
Date: Sun, 9 Mar 2025 20:03:12 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z83X4KKyNOUl_jo_@shredder>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>

On Fri, Mar 07, 2025 at 08:28:53PM +0100, Guillaume Nault wrote:
> Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> devices in most cases and fall back to using add_v4_addrs() only in
> case the GRE configuration is incompatible with addrconf_addr_gen().
> 
> GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> address") restricted this use to gretap and ip6gretap devices, and
> created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> 
> The original problem came when commit 9af28511be10 ("addrconf: refuse
> isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> addr parameter was 0. The commit says that this would create an invalid
> address, however, I couldn't find any RFC saying that the generated
> interface identifier would be wrong. Anyway, since gre over IPv4
> devices pass their local tunnel address to __ipv6_isatap_ifid(), that
> commit broke their IPv6 link-local address generation when the local
> address was unspecified.
> 
> Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> interfaces when computing v6LL address") tried to fix that case by
> defining add_v4_addrs() and calling it to generate the IPv6 link-local
> address instead of using addrconf_addr_gen() (apart for gretap and
> ip6gretap devices, which would still use the regular
> addrconf_addr_gen(), since they have a MAC address).
> 
> That broke several use cases because add_v4_addrs() isn't properly
> integrated into the rest of IPv6 Neighbor Discovery code. Several of
> these shortcomings have been fixed over time, but add_v4_addrs()
> remains broken on several aspects. In particular, it doesn't send any
> Router Sollicitations, so the SLAAC process doesn't start until the
> interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> ignores the address generation mode of the interface
> (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> 
> Fix the situation by using add_v4_addrs() only in the specific scenario
> where the normal method would fail. That is, for interfaces that have
> all of the following characteristics:
> 
>   * run over IPv4,
>   * transport IP packets directly, not Ethernet (that is, not gretap
>     interfaces),
>   * tunnel endpoint is INADDR_ANY (that is, 0),
>   * device address generation mode is EUI64.
> 
> In all other cases, revert back to the regular addrconf_addr_gen().
> 
> Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
> since ip6gre devices now always use addrconf_addr_gen() instead.
> 
> Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

