Return-Path: <netdev+bounces-238718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD8CC5E658
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C8693C88EE
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187924E4D4;
	Fri, 14 Nov 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ASMgdnZb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y5bmtOFK"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932535CBC5
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136410; cv=none; b=eyd0zh+kgLJREaJ1lxDMiOZ3Bwkq+jYWZCjlba35QXX8W2j6Wzr9jEdsUs/s2EyO1YvC69Gp2UaCYiH3O1+RbQYgflp5qsPQRWk82YVTMX4gNDfbfG7URLonWPYscvoJdlbSG0aWS1fKCa1XyOHqUkIQwRdceKhgXTV5g98ATNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136410; c=relaxed/simple;
	bh=+lYDOG6lRA6BkSzkyT9d9FXHdD/8bfvxNmPGkRr6Irg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW6qgmcsDBjlASBIjhcvr7xnyWu/gsjtOZ7gZQyUlsShESGJdqBEZlk32ILok8y8+dh0ulnse+lh8eUauEWmrDma788siOzI91MpGkyNBf47yfguQVOYxHHojPaFNNJ4ImfzxN/jEltoUJdx81mQvWjbZSyTeqy7kILOUG0chYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ASMgdnZb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y5bmtOFK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BB823EC0098;
	Fri, 14 Nov 2025 11:06:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 14 Nov 2025 11:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1763136402; x=
	1763222802; bh=em5CO+bzBfII1+vUokrDxzmR0ZmmwRpqpHHRY+DLu1o=; b=A
	SMgdnZbSsfs+0TuXprZ57fJlRK3mcfTI0HTOkiNPxwSz5ithcFMKfDL9pI+OjK/E
	syuOZjvD8F+CKon1oC/EszqQkRlX551YUjwcp0Fyiq/tJOD9j9d5K5kdwiiNvyrY
	L1ULD59aEXAewo/Ps8NuWfiysv/5pg7558Ko3/K2V11Sv5Hr7yxF5uCUot5y2fRR
	MtKuNKcN+LZP+Zc72xryyGJMZqj0JQ6VZjjk+z6W74MPnmhApaOpnit1RQBCios2
	5m39YlAY8ipAzJwvY7DNIlH2YFh3vk6MMDm13Wt8t/1ojSvfzVaIY+DzqfhfKOPh
	MtL+4yiXUot9qPpza0xIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763136402; x=1763222802; bh=em5CO+bzBfII1+vUokrDxzmR0ZmmwRpqpHH
	RY+DLu1o=; b=y5bmtOFK8Xufmt4ftbfxvAdmYlWjD+wpd/FHfzLzW8M9Z+ksPqW
	jue04unlasXOPpH7RzRLdDOMBKzy8RTBVFtwskA00QmMnA29jFRTgkXudHZaJKEa
	1vwmryewFYn/RvoxmdYRRd3yopN/OVDylJdw04O7uOX3YszC2Jc7jaFa48kI89TU
	gQUKD+gHXrewWksnCQjbAAqdqfxyQdbSEknZqkeBBffPx28kEM5AH2X7vNNFs+p0
	pQaEEhKCSwcWBaR8qJ95uHK6AMPWk6WjY5G4B3nu/uBl/0ATNSB0UwU3Ehr/3Gpc
	0hhl1ZzbYN34EIRZdRwbHiLqub7QUoYwFhA==
X-ME-Sender: <xms:klMXaYKN-_Sctz-1_ElKY8nkdYLt0Ir7RNvKzAnnvG5PXaOHlkVCxA>
    <xme:klMXab1Nh3f3wT6YrE4JQsOHLgs0XORPLRgt_1jPzGfS9YCNbb8-FYT_wJr6vluHk
    S1iRUFMEplZAGxmJ9Qw7XXCpLrUpbAN_XZhq7LRE4KkVFnjVIEzaBs>
X-ME-Received: <xmr:klMXaShCc01gPjoAKACuyG1Ttn9qCs713Dt_BF9N4xotao-FQePkw3XrR1i9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehrrghlfhesmhgrnhguvghlsghithdrtghomh
X-ME-Proxy: <xmx:klMXacWKUBgE683JeOXgqZIJmvMQcnwKgJnBsdNH0GltIM75p6cPWQ>
    <xmx:klMXaRXjCeHdKBHkLqCrKQBzxduuI2GTAFrAadNf5UE7vrTQy8JnfQ>
    <xmx:klMXacisxs-_3mhUZpZVHSo4lfMIGnpIReLDBTTcLz4Lfdsc_gh-zA>
    <xmx:klMXaca3O726u28hmdg79Bm-cmFZrJe5sWknH-xGmwbL8Wj4zk_tPg>
    <xmx:klMXaWR6eOZAn_xzqDLsPkaUQj8WFQ26Ysg5rVhA5cpFa5KPcNk6NXeo>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 11:06:41 -0500 (EST)
Date: Fri, 14 Nov 2025 17:06:40 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net-next 4/8] ovpn: Allow IPv6 link-local addresses
 through RPF check
Message-ID: <aRdTkDHlRi0WbsVS@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-5-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111214744.12479-5-antonio@openvpn.net>

2025-11-11, 22:47:37 +0100, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> IPv6 link-local addresses are not globally routable and are therefore
> absent in the unicast routing table. This causes legitimate packets with
> link-local source addresses to fail standard RPF checks within ovpn.
> 
> Introduce an exception to explicitly allow such packets as link-local
> addresses are essential for core IPv6 link-level operations like NDP,
> which must function correctly within the virtual tunnel interface.

Does this fix an existing bug, or does it only become a problem for
some of the new features in that series (multipeer-to-multipeer?)? If
this is a problem for existing use-cases, there should be a Fixes tag.

-- 
Sabrina

