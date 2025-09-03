Return-Path: <netdev+bounces-219466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55578B4170B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5717B3A7A69
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3F2DECDD;
	Wed,  3 Sep 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FY5a7YFA"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85D2DEA6A
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885438; cv=none; b=p3tz1I429dWnSmiGpuIbUATKl97FsUP56xf8aps6yZGUIjU4ZfCNhi55mL+ns9ssFVNzcHQ8SHJlJwBKsY1B98saNDIbrhaGqrWnd01qgTUcP4r8UgpkIznCPxG2LBKu4pssMMSwU7294dmmTTTCwiYI2jltgHDCSh7MPh8psvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885438; c=relaxed/simple;
	bh=VYRwoTz9kBAzth5kImsoE9LsX10mE0+pUipBJ4Q6LI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBb3assom7335Wom/xkBKk9gW0JmRg8L0QtpkQGjbd/jbo15NKVfYmDZTvkPaBVi1X7Hgr7xyjWJBWmF17sXKLWB9dZSzE71NTZOLqXOq3Q3PQUC12w/ecSa0CBxM4ubccnY8icaS/VKfYZdOe/qqcmUL8lLfCR2gQw6tjyrccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FY5a7YFA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1ABBAEC0329;
	Wed,  3 Sep 2025 03:43:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 03 Sep 2025 03:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756885436; x=1756971836; bh=WMFTxUFPCn2PjB5KycEoet1M3JsLe3nCtNa
	mXu9F+gg=; b=FY5a7YFAbgHbSueY0H2rVSZ6075c0ueTaAJloumZsW9eWdTJs02
	wDJ6uIf/SJfUoMl+/6GRkrBuAltalEgCZUtZ98Xiq6geCdhdZuz9d1oWDDGnYCvZ
	14jC/qOSI+G2iCTSYCWmujkIpAY/k5NM/6elIX32Wd2NlTKALcx7ZFIcwXp0NdHb
	SUUuWoA8PmMmXyFPvsPyMJquLg5lwPr3QD49hQJyT9C6K86w5bEflNLXk/XGE2ON
	FVDY8yaA4QD6TC3NsgXnsRmcu3HjNUJ050S8ZG5m6RELv2kzOICbRr1ub55XJsKZ
	POzyYMpw2u60oM1bWgAkG4IKLgZ98I/qszw==
X-ME-Sender: <xms:u_G3aAH8rLrAWLQ2kc5b8H7u7-ZOaqXi6I3Fys6r-MV5rV7QNssfHw>
    <xme:u_G3aB92Sgzc1nLxyNwPlQRaoFeECLNP2eoGWaixYg4-PF5OplBvsNY6cC9FE7T7Z
    1F4f6eC0CL5IGQ>
X-ME-Received: <xmr:u_G3aBn4TN8nIVb-MS8x8oaZk_e-bbi_8aOFeEmuHo2oyNbI29q4xngQILAF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhi
    mhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggp
    rhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhitggrrh
    gusegsvghjrghrrghnohdrihhopdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghh
    pdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlh
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihgthhgrvghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpth
    htohephigvhhgviihkvghlshhhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgu
    rhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhm
X-ME-Proxy: <xmx:u_G3aMAzg2-BmIjcrWjRv7BvaU_7XohnDNYAdZiRPvNILKxWFFlPEA>
    <xmx:u_G3aKXzjE30Q0OyzhHdVlrS1G08Dw9Yef1djiYBas-zVZdhXq0aLQ>
    <xmx:u_G3aK80VyKG6Mj4txZdA3DJRoAPaG9PmJo6Z88X1FCL1B87jTFBiQ>
    <xmx:u_G3aMTleH4tg6zvwKi227_H3UDGSAl4v3iyt33ZtVBloqbxrkQruw>
    <xmx:vPG3aBZDmtihQCOZOttrS5DNsQSlwo5D5lFq4JrtXEIMm0-W2sMjphYb>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 03:43:54 -0400 (EDT)
Date: Wed, 3 Sep 2025 10:43:53 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <aLfxueDGLngEb7Rw@shredder>
References: <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
 <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
 <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>
 <aLYAKG2Aw5t7GKtu@shredder>
 <A68375CA-57E1-4F53-877D-480231F07942@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A68375CA-57E1-4F53-877D-480231F07942@bejarano.io>

On Tue, Sep 02, 2025 at 12:18:59PM +0200, Ricard Bejarano wrote:
> I'm afraid we don't just see it with TCP or with bridged traffic.

I wrote that it can happen with forwarded traffic, not necessarily
bridged traffic. Section 6 from here [1] shows that you get 900+ Mb/s
between blue and purple with UDP, whereas with TCP you only get around
5Mb/s.

> That was my original observation and so the title of the thread, but
> it happens at a much lower level, at the data link layer. We observed
> CRC checksum failures in link stats. You can see those in my May 27th
> message in the thread.

Assuming you are talking about [2], it shows 16763 errors out of 6360635
received packets. That's 0.2%.

> The last thing we tried was to force linearization of SKBs with fragments, to
> see if the problem is with how the driver puts those on the line, which might
> offset everything out of its place, making CRC checksums fail. I was not able
> to do it, however, as that would simply hang all my tests.
> 
> Any ideas?

I suggest removing the custom patches and re-testing with TSO disabled
(on both red and blue). If this doesn't help, you can try recording
packet drops on blue like I suggested in the previous mail.

[1] https://lore.kernel.org/netdev/29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io/
[2] https://lore.kernel.org/netdev/8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io/

