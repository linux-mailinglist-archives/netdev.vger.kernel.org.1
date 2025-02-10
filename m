Return-Path: <netdev+bounces-164680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8DA2EAD0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A0B162530
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20716D9C2;
	Mon, 10 Feb 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="siyCZEM9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00601CD219
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186024; cv=none; b=m4nsqxlttyFO7VoxZWyN9M5m8uts4wHGwDFxinuo7n3bMm7/pOrL60c494TUoyWf4vOv5GAx+zKL1pNuLwvxTWdyNMWMzMYGtjhm4RNkc568WQrS9RRNsz1V/7fz1zDYwY8EDtkKvPuOE2riNxvWDz/3ivj709lsAHuowOv2dDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186024; c=relaxed/simple;
	bh=joWXMR8BxZkxBpp1PnlvAgULRI244ynbGdS6m0xRVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ+gP6g0mKk71joM4FL1A36l7OF9yjLbOT/jK4aBHTdvw9wmbWLGLd8ensxNEcuk6w38Q0YcWjd70+X5n+STAeSvTjHiliZy6tYc0DQx8aiIMCMTiiT2VGdOIMrK1gRGMuii6sSW5GA3BpQmJQUpV8z3e3ziue21VF7TM/Q/Jt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=siyCZEM9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4E0C114017C;
	Mon, 10 Feb 2025 06:13:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 10 Feb 2025 06:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739186020; x=1739272420; bh=xGqDNK2t7UcD5J1LYZS1Axq9vJt+wqTFZFZ
	fTxH7ZyU=; b=siyCZEM9X8yL0RraTh0+qiaPSLwyry4JbMTS6yjbRh/HqsIHaSZ
	dO20nE6xrbDO6GHOgKwxlP5IEtEAxm+VaSebLNPt6v6pwCcCY7zoPyNwmr1A5xvO
	ylrx0oCQN1AREihXPPgdo+WdjcEL+721NL9jV+AMKHCQI3eYrCliiNJCKo+extkH
	QRgk+IVRPk35qhJWnNimUKSqe+IEKf4qY+Val5tfl+lZj1YRUJsKt7lS6odn7oOr
	c3JMTwE5m7U1LBO+j41YA9vzbpltaC3doTL27JU3GIzxIdegF7HTOw6Ga78UmRtX
	v2NqN6fH4Wm1jY/8J5Lt2NZa3VXv+hwQokg==
X-ME-Sender: <xms:ZN-pZ9QGvkFqMFvgZ7SXbauxJdtbGOF3T-rG47oREeuNw70GAIK3RQ>
    <xme:ZN-pZ2x8cSOf5qOEfrAL2IoIAk8zKN2VbQYsD_mVYeK7fetKTG4ys-hb0VMEdwgzb
    BV1yQ5aLT8elRg>
X-ME-Received: <xmr:ZN-pZy1aC2BMJD_nBiJAnY8EMoA5ydl3WqnTKuPbX2E0l-LmZiKWA2MwacUd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghrihgtrdguuhhmrgii
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshihiigsohhtodeirgeliedvgeehle
    dvvddukegtvdgthegvjegrrgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdr
    tghomhdprhgtphhtthhopehrohhophgrsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:ZN-pZ1A_OYRy3dzSmRWjG3jfAvjaTSNx3Dfm5mvDDvojnR-gXUd7KQ>
    <xmx:ZN-pZ2iZRbXLJYwxO8e_Hh-XM2WC6FC7-M-e9B2QNonSvD4CuG1M5A>
    <xmx:ZN-pZ5pdPNPsxcgupAsct3OaL4HJsccFz8mgryjBLobvoiOV5wx_YA>
    <xmx:ZN-pZxjIYXWhOSZdgFQl-JfbMU1uscF1uTmRuNXUF25OD7gg1KNW8w>
    <xmx:ZN-pZ_UnqW0VaYUvuKlPZD4-_WZMo3RptCmv8ycScwd8VVDGhyxG7x6J>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 06:13:39 -0500 (EST)
Date: Mon, 10 Feb 2025 13:13:38 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	eric.dumazet@gmail.com,
	syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH net] vxlan: check vxlan_vnigroup_init() return value
Message-ID: <Z6nfYhddH6itouGy@shredder>
References: <20250210105242.883482-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210105242.883482-1-edumazet@google.com>

On Mon, Feb 10, 2025 at 10:52:42AM +0000, Eric Dumazet wrote:
> vxlan_init() must check vxlan_vnigroup_init() success
> otherwise a crash happens later, spotted by syzbot.
> 

[...]

> 
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Reported-by: syzbot+6a9624592218c2c5e7aa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67a9d9b4.050a0220.110943.002d.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Roopa Prabhu <roopa@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

