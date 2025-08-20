Return-Path: <netdev+bounces-215269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79576B2DD9A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C7F5C5452
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2F31CA72;
	Wed, 20 Aug 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ENwthEb+"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47F17BEBF;
	Wed, 20 Aug 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695896; cv=none; b=omWgzDg6218xhtbvSqK+3RRIAdHo3rkxYgD1vbmJyNlSn7JvY5C5eNC80WbtlqGeq2aH29ci6uYyAgOSD8fNeuzfQKg2Q6+psU5ejwHEMmZXBk1nEAu7YD6xPCN57KU4cIXQj932oMn3ryh9vJlDJHmv4j4FMVdqIAV3DtKSAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695896; c=relaxed/simple;
	bh=DOeocE2TSMK2zhBIMAISf0bA1p+4iSO7xk5SPu2tIfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Doj94pHRqjC/H+u/+WvnzhYhYnRJZzTWNcvxh5XTCFjhKN9GnT57E8J0BAw4tYUmI5I3M8tcb6sFcYZRbovi46/vrDSYCAuarUwwGQ166r6h2+IU433DvPr+hAndKQQ04iJh2SppphJ/8pOS47F8ex/KCKJjRt7alfiXmf3ihM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ENwthEb+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EE3714003B9;
	Wed, 20 Aug 2025 09:18:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Aug 2025 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755695893; x=1755782293; bh=dzEYBhueTWc89/MISWU3UFuCYVd1T4k9Kq6
	zJAOupw0=; b=ENwthEb+Ky21vZLrX+qnv+f6AyHsIx3sG86siSeLtTHUVMBax0t
	F8LjXTrl6bDCwwkpazNZ1JKKI8SUZfUdNRJQTYAB6zwsMzCxcsyjC2rfilufvjJm
	fHeFGSgxSoLbr4Hv4hvFxdxN9my4gqkHxG8mHZLLoiXw+Yo7Lg0dyOTqSIXZ/apW
	5lOzUhGnEstpFRCgGnhwNFkxOEQ7f4wue0v29runO6+kn2HMc6y8BUxk/rqwgkXJ
	616kKKbNb+2n8TMJ7Cl52mtSsn1K2cWoPbv971dmy+sHg6cv3Wq9+ezIROl1ukYW
	150wojWK9rXge+VNLyR5fzzopoHYCqV7npg==
X-ME-Sender: <xms:FculaCYGrrWPF0axijoXPinf3zDEc23SrYUvRpMwO2-YuvP5dgLb4w>
    <xme:FculaNAdgcf33lpjBApqpzPojukmSZwNBvB8-ClHh9iWZgawiGXRqjlknLbOU6PhI
    2eZLay7Xo5c95g>
X-ME-Received: <xmr:FculaKmM61xFbleSxj4UZnpMkvqtc-1v_Vd-iHYpfmWnjhGXUPLIvTr6zhBR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhghh
    hoshhhsegtihhstghordgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrihgughgvsehlihhsthhsrdhlihhnuhig
    qdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmrhhinhhmohihpghgsehhoh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepphgsrhhishhsvghtsegtihhstghordgtohhm
    pdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrgh
X-ME-Proxy: <xmx:FculaOx3A_6SA5pGhBWbRiMK4Rv60ltL88f9wjl8fyvvfTSvU-KhVw>
    <xmx:FculaEQ1se9V8cAT_kw_d2MzpUhDW8u0-7FP4MopGEVwFX1JJczLRQ>
    <xmx:FculaG9UPX8vb_kM0Zr0onUtfO7JIAFIGY4uZPGw6PHKxS2dNiAjPw>
    <xmx:FculaCurBEBKqQ2g7j75PTVVDoj8tlOEatuaO6tpPTfNfJRH0kBslA>
    <xmx:FculaMqjobtMGghfqMasYWhjjWBzFWAVbdBa_9J9KjRWlAEW__FgvqKB>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 09:18:12 -0400 (EDT)
Date: Wed, 20 Aug 2025 16:18:10 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mrinmoy Ghosh <mrghosh@cisco.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	Mrinmoy Ghosh <mrinmoy_g@hotmail.com>,
	Patrice Brissette <pbrisset@cisco.com>, razor@blackwall.org
Subject: Re: [PATCH] net: bridge: vxlan: Protocol field in bridge fdb
Message-ID: <aKXLEiY8gd0sNGrW@shredder>
References: <20250818175258.275997-1-mrghosh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818175258.275997-1-mrghosh@cisco.com>

+ Nik

Please use scripts/get_maintainer.pl when submitting a patch.

On Mon, Aug 18, 2025 at 05:52:58PM +0000, Mrinmoy Ghosh wrote:
> This is to add optional "protocol" field for bridge fdb entries.
> The introduction of the 'protocol' field in the bridge FDB for EVPN Multihome, addresses the need to distinguish between MAC addresses learned via the control plane and those learned via the data plane with data plane aging. Specifically:
> * A MAC address in an EVPN Multihome environment can be learned either through the control plane (static MAC) or the data plane (dynamic MAC with aging).
> * The 'protocol' field uses values such as 'HW' for data plane dynamic MACs and 'ZEBRA' for control plane static MACs.
> * This distinction allows the application to manage the MAC address state machine effectively during transitions, which can occur due to traffic hashing between EVPN Multihome peers or mobility of MAC addresses across EVPN peers.
> * By identifying the source of the MAC learning (control plane vs. data plane), the system can handle MAC aging and mobility more accurately, ensuring synchronization between control and data planes and improving stability and reliability in MAC route handling.
> 
> This mechanism supports the complex state transitions and synchronization required in EVPN Multihome scenarios, where MAC addresses may move or be learned differently depending on network events and traffic patterns.

[...]

> Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
> Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
> Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      | 132 ++++++++++++++--------------
>  drivers/net/vxlan/vxlan_private.h   |  21 +++--
>  drivers/net/vxlan/vxlan_vnifilter.c |  11 +--
>  net/bridge/br.c                     |   4 +-
>  net/bridge/br_fdb.c                 |  52 ++++++++---
>  net/bridge/br_private.h             |   5 +-
>  6 files changed, 127 insertions(+), 98 deletions(-)

Please read these two documents and make changes accordingly before
submitting a new version:

https://docs.kernel.org/process/submitting-patches.html
https://docs.kernel.org/process/maintainer-netdev.html

At the very least the patch should be split to a bridge patch and a
VXLAN patch. I will provide more comments later this week.

Thanks

