Return-Path: <netdev+bounces-184336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41CA94C0B
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 07:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7413B1720
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36623255E4D;
	Mon, 21 Apr 2025 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="d3p6E9cn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvl3+98v"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001E2AE8B;
	Mon, 21 Apr 2025 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745212231; cv=none; b=pjQNHLO8eM1KUTbzwkPp7HS4CRAPtSRhsfxTJztHhOOmvz8xMT+ih+BwRU5tg+MeHV0pipRblygUE4qVX8M3W6l5yfEdXCy8NJE+KZ9a0dJFUqwnBDnHMFezYwNV+vQqTmJOYTvLxCIhCHbMrfbYWR04sflYtRjZjfAyZOZx9FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745212231; c=relaxed/simple;
	bh=ifZ054TzkWPviROXaS7e97wYSY/LdjcxMNn+uXCh1F8=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=ix0AO0u1/yVSV4EC9iaBdtku5rcPKjeugDJP9n8GkunR11/EnA6x4vZ1i6iI0VCKmiCpT31nqt2QecnyGRrMgWxzvEyxLr+Jim48e8tKjObbpQtH27FJaryCQJDqxa+3A5Izjcl07uWsCnYh0mDH9MuFTX1h/HzuyPRh2CzqnUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=d3p6E9cn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pvl3+98v; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93EAF11401F8;
	Mon, 21 Apr 2025 01:10:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Apr 2025 01:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1745212226; x=
	1745298626; bh=gZNKRlDZ7KS5u3VMG7yx75wRgEflOKQxVSXOy4SQZds=; b=d
	3p6E9cn8k1yiSfqovdgTMSLtWNzY026KIDeHe/TO7naI0pznfVGIAYo/Uz3WHkfC
	ivk7+jKBvGtWeWyp952f9MgjRkj/IysrFApuUejp7BXBIzJZ/FtZ8YshtMuviMw8
	60ARKWhdREhSSx8ddyFUtB6qjyFksxKafz8Ao8tzzWylGxbdcFw8VWh9T/QpURda
	Y+ld75wsbEWEJh2YGfpZOnbctTEHCCSnOXkHHRLz0fMUKH3rexqOUp3NAWigthge
	lqFuupY8xQn+sRdYfvq8azCQ6rBCjMVu8Ttbo9PEMrV/Oy5/iuY/bBIJ8Q3lQuZ3
	DxrUPPnmtVeEAY7ed7bHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1745212226; x=1745298626; bh=g
	ZNKRlDZ7KS5u3VMG7yx75wRgEflOKQxVSXOy4SQZds=; b=pvl3+98vRZFZNaSRg
	qWNTDYC1GgS+UVpyXAie8S5HHf0qCl12TBlFq643KSs2yB2aU1+GvYCEssUEqjXz
	eLpUCN6+xt/J0T6miM5JwkT5NRH2ZvTgUhxgw8jiOVc4MhRdtFaAb1poIymMHumy
	49Ajfv58y0b3KQULSlktH1RWukwe3AnT/bgHWEZpD0I3fqGBXmUmPBlCwl7tpNjd
	uMFHpmLgMoFSIkF2XS6vNwfBu5XYnf46rQYc0UN1LE/fkyQcXzFd4MKi6VqWHB12
	XOfWQYOocc5+A46IJWUY4KSDY45icEw6waCChTh3O4p7n2vjg/QTECHlvIZ6EEA0
	J+NPw==
X-ME-Sender: <xms:QtMFaNvr5KcBurClK7gbWVcuvygvdFHSoshAgIuUBzSHdCUcjAw7HQ>
    <xme:QtMFaGdKOcjv47evf7fLAp1EONc75U7qQe6MFe5qQOzHToCYTE6zqtxwgrp0TJvuy
    WKfsV9t65fsG12gejE>
X-ME-Received: <xmr:QtMFaAyQkZnx1lJWzOWslovvwzv5cDPYdOr9tlLi6vcUfD7SLgJkBGHo7MwzNSvRDNC-2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgffkfesthdtredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeejvdfghfetvedvudefvdejgeelteevkeevgedt
    hfdukeevieejueehkeegffejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtg
    hkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohep
    tghrrghtihhusehnvhhiughirgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhm
X-ME-Proxy: <xmx:QtMFaEOJWKK9NHPu-0IbFSwJk9yn7a-q1z4Q4M0YOtolWJtyEiWu2w>
    <xmx:QtMFaN9nDIuXLBxkwgvwLHhiRITd2T2EP3SreUfz_T8aQ1aS1-zURA>
    <xmx:QtMFaEUwFf7-HojDC9bdsB2Z5pL8dGOrF7e0pQ7RwT1xYqBk-yoKNA>
    <xmx:QtMFaOccnQAYFx0odqJLh9e946TWl_L9Vll2Yr0UwuTILw_c95roOQ>
    <xmx:QtMFaIqDLlw-PXwBik6-DpgJE3YZeZ49paMv7PlPosFoZ2QXvyw5lbn1>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 01:10:25 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 8C7BC9FD38; Sun, 20 Apr 2025 22:10:24 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 87ADD9FC89;
	Sun, 20 Apr 2025 22:10:24 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
In-reply-to: <aAXIZAkg4W71HQ6c@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine> <Z_OcP36h_XOhAfjv@fedora>
 <Z_yl7tQne6YTcU6S@fedora> <4177946.1744766112@famine>
 <Z_8bfpQb_3fqYEcn@fedora> <155385.1744949793@famine>
 <aAXIZAkg4W71HQ6c@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Mon, 21 Apr 2025 04:24:04 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <360699.1745212224.1@famine>
Date: Sun, 20 Apr 2025 22:10:24 -0700
Message-ID: <360700.1745212224@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Hi Jay,
>
>On Thu, Apr 17, 2025 at 09:16:33PM -0700, Jay Vosburgh wrote:
>> 	Wouldn't it be equally effective to, when the conflicting
>> interface is added, give it a random MAC to avoid the conflict?  That
>> random MAC shouldn't end up as the bond's MAC, so it would exist only as
>> a placeholder of sorts.
>> 
>> 	I'm unsure if there are many (any?) devices in common use today
>> that actually have issues with multiple ports using the same MAC, so I
>> don't think we need an overly complicated solution.
>
>I'm not familiar with infiniband devices. Can we use eth_random_addr()
>to set random addr for infiniband devices? And what about other device
>type? Just return error directly?

	Infiniband devices have fixed MAC addresses that cannot be
changed.  Bonding permits IB devices only in active-backup mode, and
will set fail_over_mac to active (fail_over_mac=follow is not permitted
for IB).

	I don't understand your questions about other device types or
errors, could you elaborate?

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

