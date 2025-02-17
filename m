Return-Path: <netdev+bounces-167116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD83A38F7E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440CB168573
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB301AA1F4;
	Mon, 17 Feb 2025 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="CmOfMUkO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThIg1xQQ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1B14F9E2;
	Mon, 17 Feb 2025 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834076; cv=none; b=Pn4pd8YyBEqsPguOGZHcVKyZnaJSiv6QU8C2Wcy0b5P54NRbHceweakFOHfzw7o6hh/9cPqnX7+ojlQCVMk9IB/7Rovq/K1hXK5MKUylHEIwM3B22GuHm6hXHY884IZplyLFxX38meX6mlR3A1FqKmZlF5YthrU/bhJ+h1TZ6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834076; c=relaxed/simple;
	bh=NMxipclVNI8ph4c1sJVpJ8RRFWUxSx7dZywnmy1ZJF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kATJjDYqwxKIZ7Z31YgqlFCFNx16A1hG8qqmnUI/VG8ctz0ZGlh+NeskNHgjrUjr812jKq3b4GBwWJF+gKHFk0QDjzwJ5VPSHqCtH/KO1dQ0GPxGVNHNMNYjFrfAdNYlk44dT1kRB2PL6QMRE0U/qXcrqKZj8yq84ezk809VFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=CmOfMUkO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ThIg1xQQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6610E2540109;
	Mon, 17 Feb 2025 18:14:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 17 Feb 2025 18:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739834071; x=1739920471; bh=BVPxY/AN1UFMIdx71q3f56HEcF1umPZl
	YfP8ptr5yIA=; b=CmOfMUkO2F9ADd1Z/gkU7grTYGiPLkkiuMfjHkngVml0dK0V
	gzve+SsU8usdxmbc2/zNRgSFJfOmLKCog0iC6rb2j55hN7EhWnxAMNQnzOHLvJ/p
	IUJC0B+ayuu4ZiugKoVhi97/bWET52faK9QcYmXQE1PRBFaSbuPBo2q6ZDCy1G42
	lvGAvALqUIs0RmwE7TYdrK/8iCkLUFM5VlIMwSk/6KaDAAog1nsSqXleSpHcJPwd
	kP5P2znoJEvac5EUVnw2jR1aR3CXbfbUbPnZv98c+XsgNiJXXyQ0hW8rfvo6QKxL
	PQ2aLRhrtQlrb2p89CBfTLlkgKvsl7guSRiLDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739834071; x=
	1739920471; bh=BVPxY/AN1UFMIdx71q3f56HEcF1umPZlYfP8ptr5yIA=; b=T
	hIg1xQQ7+uhwbgWpm34PmpDVjz18wOq0RT9OgZBlA7f6zhKcG1pOjaq2qakLosja
	43w1urIGfWg9V+zSbrcSyg3xSfv6fBvySa/Eb4IPZxdpmlZyj6FbjQvDSVWryQye
	76Z0/UqC1Gfq7rQAvSI4BK2gtnGMYamDjn/fOP6ceQioFkJ1dHFq7fiHqfZsIvQG
	2SFDirS2wUXZ+BM3DTZOfCViFZj6fDyR4CbAHSy7t2vhXnEzsr90sVPh/+Nxn/DB
	QyIR4VnVFTzOfhs2MUBczXXYPfVBwkJPm+lQY/c43ttL4vusTIHHC+QApZ7T150F
	UJlb7D5SvpyMbY9ifMVpw==
X-ME-Sender: <xms:1sKzZ8aVZcke_x5JuwFNc26TSafKXdZ_RB8clENV2hWyYjkoSu2KYg>
    <xme:1sKzZ3bFThM6X9xqsMjEPs3cbAwAu663UlE9sjCAauChIExLibK207O-US2luZNQ-
    i6btw59_zxvv5Bx3UM>
X-ME-Received: <xmr:1sKzZ29vGlJmKmNKCnG5poVEVLmeOfJZ6VY8S2caDK_agrWOhTbV4X58WqAr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveduvddtveehteekvdeiueegheei
    veejkeetfefgfeeffeejgfdvfedtleeufeegnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhm
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehntggrrhgufigvlhhlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohgu
    uhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1sKzZ2qYlvbmXdO9cAqBXIUloHSAq9jbskS9ZckT7aBlzknBrd8o_w>
    <xmx:1sKzZ3rlCfU_69QjVWUNtWsBF4HZvewVddqA3i_cJTKljydYGY5swA>
    <xmx:1sKzZ0TtwBK8kplrAuIThZTbIXqr5XVkEzmc7fM01qjlD0BnMDv9GQ>
    <xmx:1sKzZ3qvnXYTkHoklp7-25SPTs5c46hrQBencBveu1RWdT5cNluuBA>
    <xmx:18KzZ0jK_Jb0yx5nYrtd4hJszdCrQn1uIXxFYdqHoqJuS4vwPWv-5zym>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 18:14:30 -0500 (EST)
Date: Tue, 18 Feb 2025 00:14:28 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	linux-security-module@vger.kernel.org, Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH net v2] tcp: drop secpath at the same time as we
 currently drop dst
Message-ID: <Z7PC1JoBvgFL9JAU@hog>
References: <5055ba8f8f72bdcb602faa299faca73c280b7735.1739743613.git.sd@queasysnail.net>
 <CAHC9VhT2YnbCKcAz5ff+CCnBkSwWijC4r7-meLE7wPW6iK2FUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT2YnbCKcAz5ff+CCnBkSwWijC4r7-meLE7wPW6iK2FUQ@mail.gmail.com>

2025-02-17, 17:35:32 -0500, Paul Moore wrote:
> On Mon, Feb 17, 2025 at 5:23 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> >
> > Xiumei reported hitting the WARN in xfrm6_tunnel_net_exit while
> > running tests that boil down to:
> >  - create a pair of netns
> >  - run a basic TCP test over ipcomp6
> >  - delete the pair of netns
> >
> > The xfrm_state found on spi_byaddr was not deleted at the time we
> > delete the netns, because we still have a reference on it. This
> > lingering reference comes from a secpath (which holds a ref on the
> > xfrm_state), which is still attached to an skb. This skb is not
> > leaked, it ends up on sk_receive_queue and then gets defer-free'd by
> > skb_attempt_defer_free.
> >
> > The problem happens when we defer freeing an skb (push it on one CPU's
> > defer_list), and don't flush that list before the netns is deleted. In
> > that case, we still have a reference on the xfrm_state that we don't
> > expect at this point.
> >
> > We already drop the skb's dst in the TCP receive path when it's no
> > longer needed, so let's also drop the secpath. At this point,
> > tcp_filter has already called into the LSM hooks that may require the
> > secpath, so it should not be needed anymore.
> 
> I don't recall seeing any follow up in the v1 patchset regarding
> IP_CMSG_PASSSEC/security_socket_getpeersec_dgram(), can you confirm
> that the secpath is preserved for that code path?
> 
> https://lore.kernel.org/linux-security-module/CAHC9VhQZ+k1J0UidJ-bgdBGBuVX9M18tQ+a+fuqXQM_L-PFvzA@mail.gmail.com

Sorry, I thought we'd addressed this in the v1 discussion with Eric.

IP_CMSG_PASSSEC is not blocked for TCP sockets, but it will only
process skbs that came from the error queue (ip_recv_error ->
ip_cmsg_recv -> ip_cmsg_recv_offset -> ip_cmsg_recv_security ->
security_socket_getpeersec_dgram), which don't go through those code
paths at all. So AFAICT IP_CMSG_PASSSEC for TCP isn't affected by
dropping the secpath early.

-- 
Sabrina

