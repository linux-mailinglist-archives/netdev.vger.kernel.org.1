Return-Path: <netdev+bounces-242604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 226ACC928B7
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA7B04E1053
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04428725F;
	Fri, 28 Nov 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="KPtDlWim";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huEhCA3g"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6422F389
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346487; cv=none; b=LmOow7ZlSKX/6oWlJnotAloM1mrBxR2F0KXRyfBdsz4IsGtzZmcV+GsrnPpcA6lFE15HUES+0AIrhrK1n0uo5nvuM9DFj0L7iQGkx7lLL4oxiJVznaO+wVr2tc9XepJqYrUesbuS1BHve44h/T1clTjcruflhmMNszWOtZpXTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346487; c=relaxed/simple;
	bh=TxBipie9Ud3lXjHMdugPgo/Lxop4PotVr4DLpbWwP0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4lT/cw0dphd+HQ5oxCC+wBMuh2BTejrifciftn8s8gU1mJMZatN0LpamMwAW2LjQ51VZqaQLiW9bCfqryZyYwINYtrpwEhqnGI/vX0/MDfeOy3lRwlR8XZFAEw1+E9HTy5KnSCOy7bL7LzXrpmghBAecwUn+AItenerX6RRbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=KPtDlWim; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huEhCA3g; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D3B57A0853;
	Fri, 28 Nov 2025 11:14:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Nov 2025 11:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1764346483; x=
	1764432883; bh=NWDdTy6GJqiUjaPU4nhovGWEgEL15+6E/4RuCvIGZwM=; b=K
	PtDlWim9lrmjyOLe8JPRPMI/Ge+exTF9seMxw4qkjFsQ4FQ2Fi3NNcyzX8yH5eja
	uK+tWtZ0Hl/Wy58JXQ5hoyxvmwbkg+BLvcsFdJOX78HBDlv+5MPV6qkntJIpMUyt
	yA4OiCPiDdm/TjyTTN5APEuCCYQmi1XYJtZ37XVJc0hwHwqATKKmr0vSUDKtjjXT
	OPwLV4MmJVhbSRriUdGEGGhSYzZeMbfUkIazly9fi143oS4VmAYDSr9ZPdM+KzPl
	bCs8E2z/naqFLZRCv5MaIbroo9n+zKDfM8wnhCm2HJFaKCB+/YhUlUb04s3MmDFO
	DZITXd5mhy8Y4ufQ+yAbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764346483; x=1764432883; bh=NWDdTy6GJqiUjaPU4nhovGWEgEL15+6E/4R
	uCvIGZwM=; b=huEhCA3gV8D6QjRfGul/bHQ5pGyp6u4n8Vy9BoEQNV8nUCYmSqc
	kwL9FW8Jr/pIjRwD58QqsR01B+CT3sYW1cferu3CmwsB1pCbScJ4i+34x9pNIt3y
	Oo6GbmWn8hPr8dzMH7kZfPVED2aD3xu7iKq+c8ADKJjrPtH/R+d7Krn24uN8371S
	DEcDNoLZdlXFv6JNLdQRKhNgI5sxrlcKHwO/ljkMvx/WqbH2TZKSOODPArIFdKea
	8ZV/S2VyDIG5OP7sNnTBA2sRjrPtBmPAk2trp0ig0qWwzT+PacQ+JmaRNvc/b8lA
	sgTqSx0pKVn1ykFbKxvLpNlgQwNfAV9t7eg==
X-ME-Sender: <xms:ccopaS-jiZTyA8Ip2z4P-Kgv4_k7m3wwWxWXR5K7xTA6_SiBb08Khw>
    <xme:ccopaemHbw8eR1wASxCxSAXQFThowpEV_FC5PXShKrR-SeNawUEHmxn55Z_Rtg5Ip
    NaeYQi0GCMwfPhXw1x3igwTTIr2MAwF6qMQrCvM9t5p_tel4t8_8TdP>
X-ME-Received: <xmr:ccopaVBPL-_bsftvKCuEhpd8djPNz4OePS9R9jA87H7zB1YoN3RgXQP4skrSZ63BhxuEXELDu08g1MSAcW-o7UHwHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirghnsgholhesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhht
    sehsvggtuhhnvghtrdgtohhmpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtg
    homhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdr
    rghupdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:ccopafUPWJMNmpC91UvFR8KjazDzPKrcfzHpnQKTY4nR2t_bMn0VlA>
    <xmx:ccopab8iAs-ZbiKn27RafoVADTMD8siSpcsDDoedI2sTV3CpkRGUCA>
    <xmx:ccopaZSi4us-AxGhvpZpYFhh6XSFThegsApPe-xDw3oIbkgY2zWw7w>
    <xmx:ccopaYTHioxS5gyq3tbfxHN0NiaGx8rCwJWBJDXwROllRTioY88Qlw>
    <xmx:c8opaVL3O5k4KlYxtHs22r5iDgKsCU2E2LgVAQcmlKiRyxCbkQ3YDGUB>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 11:14:41 -0500 (EST)
Date: Fri, 28 Nov 2025 17:14:39 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	steffen.klassert@secunet.com, Cosmin Ratiu <cratiu@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH ipsec-next v3] xfrm: Use xfrm_ip2inner_mode()
 unconditionally
Message-ID: <aSnKbzhftKx9f2yW@krikkit>
References: <20251128035014.3941-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251128035014.3941-1-jianbol@nvidia.com>

2025-11-28, 05:48:04 +0200, Jianbo Liu wrote:
> Commit c9500d7b7de8 ("xfrm: store xfrm_mode directly, not its
> address") changed how the xfrm_mode is stored in the xfrm state. The
> inner_mode NULL check is redundant as xfrm_ip2inner_mode() now returns
> the address of an embedded structure, which cannot be NULL.
> 
> Additionally, commit 61fafbee6cfe ("xfrm: Determine inner GSO type
> from packet inner protocol") updated xfrm_ip2inner_mode() to
> explicitly check x->sel.family. If the selector family is specified
> (i.e., not AF_UNSPEC), the helper now correctly returns &x->inner_mode
> directly.

Note: that commit is not in ipsec-next yet, only in ipsec. This patch
should only be applied to ipsec-next once the trees have been merged
together.

> This means the manual branching which checked for AF_UNSPEC before
> deciding whether to call the helper or use the state's inner mode
> directly is no longer necessary.
> 
> This patch simplifies the code by calling xfrm_ip2inner_mode()
> unconditionally and removing the NULL checking.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
> V3:
>  - Change the commit subject (was "xfrm: Remove redundant state inner mode check").
>  - Call xfrm_ip2inner_mode() unconditionally and update the commit message accordingly.

Other than the tree scheduling comment above, the patch looks ok,
thanks.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

