Return-Path: <netdev+bounces-202217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D2AECC10
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E9818877CC
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814221770D;
	Sun, 29 Jun 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBRLnn4f"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A31B6CE3
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751191481; cv=none; b=hBpwQ/E3pMxHlmbONyGzg2jNA+wfvPE+kkkN3LVIgrDqAr6moerE6I0ORP/kDoWgZsQ/eVu81PBWyuthIGvPNRwiPz5OXIT+nTq7Pt2m5HUS6e9C7wtgIkhJvBzDzGJL/G6vKtn4a2X5TUUtk6XQY5b6T5gvWFbKmSIuluBRpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751191481; c=relaxed/simple;
	bh=MHUw+Ea6EVN75dCPT0C0rNMMDUosxpqkUHin2ZSK5Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POglapA0XXmjX8SRyutQz/WVNi6WqGm99/jJ2pSx+R0a0B2wtTThxLrevBS0tZWVFSwMcubElizo07VR051wtk6HMuRq0efy0pRNts4wbhIpVc5/2C3PQ2pcNMqkaKRXKFnfwxO0FeOThjro6q17y3joii+/WQjUBTmtGp5dYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UBRLnn4f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AFC261D00193;
	Sun, 29 Jun 2025 06:04:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 29 Jun 2025 06:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751191478; x=1751277878; bh=ZzomQUF6p5nxj1MqjuH+Qbz4WFD2Eei7Mng
	8tsp4RSA=; b=UBRLnn4fKanzl7ivCaB//U5+iQqC/ogwx9sIbOQSPFwgPlMi0Eq
	aYVwYpjY+ZMEZDYAZA5FfUmsE+wjm234kQGHKWDoeWcwqMc/quEEbUtLu6OacQsr
	NhPWlSMIqJxKf6aXzOq5IZtTMTkva4k8LWwYU1uKy1BJLAq9uqT0nd1heaAH1XvM
	Gbhj6u/zQpw3iFxMOOf1ag8RMXhFbWsHntlxcneS3jcbroDktGj676RcFlMpuZ5P
	fBdJ/kSeGJ05l6ii4EbFpzyyhji3ZsVCyr5IEPGJuXFAN2rBZ8qNzR4QoLdZdROM
	Mz9Uw8+vNGDOMyctl09eEbL0IuPP2NVxGCg==
X-ME-Sender: <xms:tg9haGOkViDZXza4bDD52Hp0HfX3t1D_492VAjfwDojycVSsYsvbZA>
    <xme:tg9haE8Mz0mW6A63_k_qZIFQ1HfXJGXqCTCQgmn-me7gyc_8uHpjkdJqB_YDb9rJK
    lgk-pPqQubmjsM>
X-ME-Received: <xmr:tg9haNSPa0SPfYGhTzT6iFhbQi1oBd_BUH-J2z_GoqRVPXuS4pqV8j413g8e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghh
    rdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefud
    eifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtph
    htthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnih
    esrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshiiisghothdogeeftdhflehfjeeiieeffeeigedurgeivddvudejsehshiiikhgr
    lhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifse
    hluhhnnhdrtghh
X-ME-Proxy: <xmx:tg9haGshWHlg-H6anZ-Ja2jskz-cxhyQqGWPeXEUlJ5kAjrJ_07Shw>
    <xmx:tg9haOcgdK05F7rcSGkCfW_O5RWlgD1BZDby_KHdnXCi9xtAPHFy_g>
    <xmx:tg9haK0o3FcoZKDSWmB7qINUmiv7w5vMypxhwzB8mBJVEUXi879izQ>
    <xmx:tg9haC9RYi20X7hE1YD6nTuYPoRe57ywSDLGt_rYRupkWvNi27q10w>
    <xmx:tg9haIVPWYMC0OCDVzprXdFnjbxtRHFXMitQdIgOWmpspspCplL-l35a>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 06:04:37 -0400 (EDT)
Date: Sun, 29 Jun 2025 13:04:35 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	syzbot+430f9f76633641a62217@syzkaller.appspotmail.com,
	andrew@lunn.ch, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next] net: ethtool: avoid OOB accesses in PAUSE_SET
Message-ID: <aGEPszpq9eojNF4Y@shredder>
References: <20250626233926.199801-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626233926.199801-1-kuba@kernel.org>

On Thu, Jun 26, 2025 at 04:39:26PM -0700, Jakub Kicinski wrote:
> We now reuse .parse_request() from GET on SET, so we need to make sure
> that the policies for both cover the attributes used for .parse_request().
> genetlink will only allocate space in info->attrs for ARRAY_SIZE(policy).
> 
> Reported-by: syzbot+430f9f76633641a62217@syzkaller.appspotmail.com
> Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks, we hit that as well.

BTW, shouldn't you also release the reference from the net device if
ethnl_default_parse() fails in ethnl_default_set_doit()?

