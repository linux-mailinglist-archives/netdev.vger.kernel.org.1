Return-Path: <netdev+bounces-278102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BAFM48B3Wk3YwkAu9opvQ
	(envelope-from <netdev+bounces-278102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:45:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DC3ED795
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB443059FC8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8F3DF010;
	Mon, 13 Apr 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="IHncpAit";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Go1+13Y1"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632983DEFEA;
	Mon, 13 Apr 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090898; cv=none; b=qtMOUNQ2jXvakOhQBBB2jipu51xjszGbaWqIRy1puqD7Le69WYT/q//VvS/p75Yw/zFwVuC80mFG/xJkk4Mym7+LPi3cYjIOqTwWCC3PNHM880PLjU/6s05JPp0HgdU4zqbZfaA9H8GDJl1ujHFufc965K0es+M5rK+h4MMJMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090898; c=relaxed/simple;
	bh=u9MHzWE32rfsuIMBVVhBX8E0L7VK8LBR1wRiY2Kpc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7bzzqX21kOTFII1d6A/sl0IYHVMB2ClxhwyWsO0mvTWp/KKzizQSqOjE7uKtc1Ndp2n2gDiEjS1VM834CXOK8DF6yHOm1G4yRI8MErgGNGkBTfbyGwkX0gmp5sewgO3CiQmWePjJEnGYEcAkgDsE1bdX9/C7JsxYUPqIgEa7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=IHncpAit; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Go1+13Y1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2978D1D001C6;
	Mon, 13 Apr 2026 10:34:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 10:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1776090893; x=1776177293; bh=c+Cm1fLqQqo0r7NWAXt3oxDwjiggOXdc
	6m/0IzqbTaw=; b=IHncpAith9yKJIC3sJst6xA9GG0iIuQzZJnKpXQT/xvkvTcv
	7InzA0x6PEpyaOKA4UZW/QxczgNtkBWn+p2CLzD0PaPAAPvInf/2gycMF2MVm6zi
	Sl73SG9+URdhbIFYqU7/bXyIIkSYlMFhP1m7ZjvevnS5UumsC4DHLVqID16AvrGm
	U7vT++LhMws/mgXWV8kgx/wlMdsok6lA6SRLbemh3YG7nuNap35VTsV1+/Rw1/J9
	RnzY4SlQtks9NVAPR3ojA7djtHLvB7/mR9L+xtTs6xjlJS6mS+W6wwPdQ8yZxrRo
	/6V+w31Mg8/X9jqdhFvbz2CedjenWR5OyhZaEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776090893; x=
	1776177293; bh=c+Cm1fLqQqo0r7NWAXt3oxDwjiggOXdc6m/0IzqbTaw=; b=G
	o1+13Y1/4OxBAq4Am0ODhjl3cXbYJkd2kUAQok15Xk19J9RZRaTH9bwV+LfzFr4B
	sb142/tCi42mTf1MChZR5059EeECoa933YhUlZNPFLCwr/2jFxu6pLeZCRobxc7c
	ehiTX1x5r65L/SvPSEHE/cuwtbX04mFOkorFaxd6VccA7qGUuC0o2Maba8BeZnUd
	gjpxNTgitFuHCKSkzWgC2cuLFXifrUNZ12oHWmoHuf2x8a/o8/KCJA4KTzXBny90
	YRTuzzBKrADL06FEQDeop03A0dDHH+qlm7FFs3ZpCsAkw/NMAZhCbwQETyT8wTWj
	O7zTyjIbxZr4LXt7UmC6g==
X-ME-Sender: <xms:DP_cafcAeDlozZdDI8_RlU3Ijk0n_oAnk48PN2Nft93lCWOh4KWT3g>
    <xme:DP_cabvyF8SUVFUn6-Qd0ZUAkjujIy0Y27keDLDoSECl4BHXE-8v5K6zSpoVuyFGE
    a2qmr4Lk3HJsNt2yM3j9YbrvJbG8FHpUWr40yKa7hQel8QQBDIO34Y>
X-ME-Received: <xmr:DP_caWhmlInRWw2A6AKjrOJHhmvp-4n1Z5B67aEymnYY_mfiAZp0KrVR6F7p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepveduvddtveehteekvdeiueegheeiveejkeetfefgfeeffeejgfdvfedt
    leeufeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdr
    nhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehkrghrthhikhgvhiegtdeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghf
    fhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtohephhgvrh
    gsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhsse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DP_caTtWu41VvtOWbLgZp_vKa-QwyS7J55Quk7Art897fbitdgA1pQ>
    <xmx:DP_caR-cjsq-_AJ9I7rSFoCT64ykITPUna_9cxHfmQIDu_XsO5GrwQ>
    <xmx:DP_caZZGVsuaSYsS3OA8EqjCvsmY6BWqPCEjTwVF_GSyJH3-q5bPNg>
    <xmx:DP_caXof5gSGE5Gz4ChDLKoK4nCVcYXNvuorhcUtJZwghK9lEeIGCg>
    <xmx:Df_cacL3k8KoFeZLnZnbxfHrAoWhJZIkj-EPUdIY1KXcYL8HqwsqG7Yi>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 10:34:51 -0400 (EDT)
Date: Mon, 13 Apr 2026 16:34:49 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, leon@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfrm: fix memory leak in xfrm_add_policy()
Message-ID: <adz_CeDItDjznfWo@krikkit>
References: <20260412020809.35465-1-kartikey406@gmail.com>
 <adzwiKOPptwbNp7Y@krikkit>
 <CADhLXY5a7QCdp7NXC07fma905O8YJ4jPcbbdK0=kFgD3d2AF-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADhLXY5a7QCdp7NXC07fma905O8YJ4jPcbbdK0=kFgD3d2AF-A@mail.gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-278102-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,901d48e0b95aed4a2548];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:email]
X-Rspamd-Queue-Id: 378DC3ED795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-13, 19:58:53 +0530, Deepanshu Kartikey wrote:
> On Mon, Apr 13, 2026 at 7:03 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> 
> > What is missing in the current code? "we have a better way to do this"
> > is not a bugfix, it's a clean up. The kmemleak report says that we're
> > leaking the xfrm_policy struct on this codepath, which doesn't make
> > sense, that's covered by the existing kfree(xp).
> >
> > Also, please use "PATCH ipsec" for fixes to net/xfrm and the rest of
> > the IPsec implementation.
> >
> > --
> > Sabrina
> 
> Hi Sabrina,
> 
> Thanks for the review!
> 
> You are right, the existing kfree(xp) already covers the struct
> itself, so my commit message was incorrect in claiming a memory
> leak fix. I will resend this as a cleanup patch to replace the
> open-coded manual cleanup with xfrm_policy_destroy(), which is
> more consistent with xfrm_policy_construct() error handling.

Ok. Then you should wait 2 weeks until the merge window is over:
https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/

and use "[PATCH ipsec-next]" as prefix for the cleanup patch (+ drop
the syzbot references).

> I am also separately investigating the root cause of the actual
> kmemleak report and will send a proper fix once identified.

Ok, thanks.

-- 
Sabrina

