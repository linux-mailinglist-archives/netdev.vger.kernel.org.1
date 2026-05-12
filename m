Return-Path: <netdev+bounces-287036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL8KLRj2AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0151DF7C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC437300CC20
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B03C3BF6;
	Tue, 12 May 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ykfdx9BH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rR1fDih6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817273859D2;
	Tue, 12 May 2026 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578650; cv=none; b=Xiu1MeF9z1504VF2wIYWtkboOVpAfOE916kZH7NRY8N7xOOfXvy3cxqr6MWU1cdFMCPk++2eVzsRRifEKbwHuF3Sdj+zFYFObEBEYHnF2HdQXW/MxuP/iQ6sCx7Yk4VEqTLgQMz31uxdv4qrVwM54/p6J1VkNaucI//hBJO6PXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578650; c=relaxed/simple;
	bh=0hm3cPekJMMQolV82Yt1HCxdHPmcvpWJufglPSy9bBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/CDpT/t+0WPSuaXOx3mBnfSD8KRz0m3sQ905ladXrgz3ruT7ULCWphFB7MRysbI/0Gt1gS5+dFURzUdga+B7hqvW2wEm/pCrJMQlqbVuoE77dMmvAI7Fsaf4/cAxc/bp9hmXDRWumQvFvcqC2YJa+4e1OlUdwIksy0c5yQmyQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ykfdx9BH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rR1fDih6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18B427A00DB;
	Tue, 12 May 2026 05:37:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 05:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778578645; x=
	1778665045; bh=KZtompXgFSACAAOw8haMO9lseia0fCbyR29abWb4baI=; b=Y
	kfdx9BHaDD8vhlYzb43v4k4ro7f+rprHcajBSvQmWAeXBDROXXlnDMlOMVfqQ64x
	DfggUY/bBCIouwvhHLGx0+WKwSaY2nH/S5GcCbPB23LOfYZMNC29hKRoptuRHFhx
	VqHEBvzAdWxpNROqgEBqA6x8UVdKhHUnsTSn/SpmJIkCigo4aHyw3FMVIXI3fW3J
	zzdFemSL82a3EBs1J29Yz0JkLzNjvW7p4la94bunH9w3WeDS3REQDZlBHN3NCjbI
	W747c0sEU8gxZiWocmyo3Dn2yFBONWBTFEL5I7mrTAK73l+srywlTIJ6/Dboq/qd
	2pk8L+wJs4rlU6FVrlCbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778578645; x=1778665045; bh=KZtompXgFSACAAOw8haMO9lseia0fCbyR29
	abWb4baI=; b=rR1fDih6cX0XPQm6gbA+MIhesJJsAliscSlvjuHrmdUIKZkYm54
	D2I09B+4eWxwaCvX2STdOVAxTwM5YCMnmT7yOazPValGcjOjjNHYynkgliP3+HOV
	S73S1JVu4LJzKdpBCjqsr0YXXZcSjpa4qFLzetkGXCZ86zESwGfogiu9NcIQB5xs
	BzMMqwmbXFA7pFJ/yHXpZziGOgebvOpvnCQ6aWMyVShP0xNLNMUCc0WsxIPh6Qcw
	nSv3DBMpzA1jE6XkjwGxfcF5OFkRxjP8HbnZowy8c4ooWk0+38goSC1Uk9iamyn8
	0JP47w2B04Om7ZyO2UFantGOVdAhVjtJx1w==
X-ME-Sender: <xms:1fQCalEvN1D071S6eQU4DvKmvyhCGZHEeVQ7koJzaxr7zgnPsoJTnw>
    <xme:1fQCar4oXMvhQDagaNrRxBzs6C0Zp2qlVMUrinb7mLqxTG78LpZb-j0h24ZECCH6j
    LGyMZ0FQvWmJdm-zFpdVAd1ZWsY_QFNQ8JutLpInUg4mkCEqKGEhw>
X-ME-Received: <xmr:1fQCamajivxRjOLnhn2ek4SWJ9cKIvKMTNOmKn_0D532zGVbdMT5-D3aBCyNS6fSbjq_J5xtem8VbEdVeEH5Ezs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddugeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepgefhffdtvedugfekffejvdeiieelhfetffeffefghedvvefhjeejvdek
    feelgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegurghnihgv
    lhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvg
    hnugesghhmrghilhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgr
    iigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:1fQCahgI3FZOBz830Q-XGj1a1JPafTloBAwNpEXvOqBZv8vYXWUqfw>
    <xmx:1fQCagcQrrpAS9tmZzVyIFWTD3xsP9bIK8Om-jGjgaTWe35Wrr0YUQ>
    <xmx:1fQCaombYQmensgQaadfK_lYFygRVS7cCeesAUHOD7RmoKXu-ncfWw>
    <xmx:1fQCatxwiF3qSVmj3Dm3mhngpGYdFjFKzKmpCl-g0ZFQ-iphCipgMA>
    <xmx:1fQCaikE-Msn7iroFEwDfvQWPokJxkp00r9-w7HLrDmwNSvwpPAWpNpM>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 05:37:24 -0400 (EDT)
Date: Tue, 12 May 2026 11:37:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Sitnicki <jakub@cloudflare.com>,
	Daniel Borkmann <daniel@iogearbox.net>, john.fastabend@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v2 0/4] net: tls: net: tls: fix a few random bugs
Message-ID: <agL004kpTMjsaJJO@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
 <87se7x7z8k.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se7x7z8k.fsf@cloudflare.com>
X-Rspamd-Queue-Id: 38F0151DF7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[cloudflare.com,iogearbox.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-287036-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-12, 11:28:59 +0200, Jakub Sitnicki wrote:
> General question - do we know about any kTLS with sockmap-redirects
> users out there? I've been asking around at conferences for a couple
> years now and haven't heard about any consumers of this feature.
> 
> If there are no known users, maybe we can have kTLS+sockmap glue code
> behind a build-time config option and put it on a path to deprecation?
> 
> WDYT?

I was also thinking about this recently (well, more about ripping it
out directly, without a "polite" deprecation path). It's a lot of
complexity (on the same level as the async crypto code, which is also
causing us some pain).

In
https://lore.kernel.org/netdev/47b7dc3c-7092-49fe-b849-6847b73df86d@linux.dev/
Jiayuan Chen linked to a 2018 LPC presentation, which is... not strong
evidence of current use :)

Daniel, John?

-- 
Sabrina

