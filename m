Return-Path: <netdev+bounces-76909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8386F5BB
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 16:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07F51C214A5
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DC67A13;
	Sun,  3 Mar 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mp1sJ3m5"
X-Original-To: netdev@vger.kernel.org
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386D2E412
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478663; cv=none; b=UQqd9WQhyo6bdSp5i9bWR6p4tCFxm8QbKiyfVTITTu7w77VtcTImk7RTM4Rxnc63ckTbEeXGRAWixnMKzlcSeSZ37ED2qRL/1AZIf3FPsYFcgd77NO6SDXrUCI6EBXWpHoi8i9YCPy8AyxcrQ3hzOgKqjo08nX1oPE8+x2I/lCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478663; c=relaxed/simple;
	bh=sNqEaZO5zragLVVwV3XlUOltuEj+vRHS9htu4Jb+m1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSTXvwNezfgomTBt9vfRG/jE/sFJ8TqnHv+xBXXLUAG0QNmSm/StjAg4iTVFuBcpQ5k0dIkLOMqQBmEcTMQsaw9CFznImhE0Oaa3C2c7RsbYw5Ss2sjzkvis+yXVLBOoI9vE86I1T4DHmsarUaq6n4t8uLpOmzfbbIFOB/GnXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mp1sJ3m5; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 1987C32000EB;
	Sun,  3 Mar 2024 10:11:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 03 Mar 2024 10:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709478659; x=1709565059; bh=86zNFNrxvoUsFL+XMITDdJ6bPX5V
	Voo7lk/LpkYxNms=; b=mp1sJ3m5c31OM0o/OLZbbmcR77Fy2HKBN82WiqygM/xj
	yxCPrRt6kEgSNQaT0zlXV1LLw+DgqGAQ7rbALAOSMS+w261e8+w7PVkIOnXbOC+i
	Aawzk66W/8Hp0sTuZQcpuU5NKKMpuywrwxhc7qIrZGbidCjkm8KCoqZMj6kkITne
	nrnAGULAxhRQEuUmdqEoY6i6qqI+L6Rsf2YZjait6TqF0ij1L/iBI+56dmXVFbwL
	61x6aX0wIEbd6eVZ4SDk6vEgGNG+kIn/MYku5lXoBtEUpO15Egw5VKQP4j+aaFYf
	fsdBVYE4fFV7LP6tCuUUOJooZcXfLRuFcnVFGFHNww==
X-ME-Sender: <xms:A5PkZaNNTHQBdNR7ta6vD4P6JgcqVq0nIB3nbJ3NkfVdfSUruoIvaA>
    <xme:A5PkZY-cd0aQIxj9Xo6xCJT63R9dmHb9Yp1wvx5LgY6h0S2jUW3gnuQZhAmkPyKp7
    aIJlSoNz2iyGIk>
X-ME-Received: <xmr:A5PkZRR7ysT1pEVWBhQW4QvdOqerX58CgAiMxuIxj3Q9AH7Xv8fg5RfYykIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtro
    dttddtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiugho
    shgthhdrohhrgheqnecuggftrfgrthhtvghrnhepfeefueegheehleelgeehjefgieeltd
    euteekkeefheejudffleefgfeludehhfejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:A5PkZavLHchh6hmNeZ9bmfEqQZ-LkKPGDVNazC0qBMQBuIWPOqW5jQ>
    <xmx:A5PkZScek0FK7dg5AYZoRt-ve1lN4_DusAr2u2zZL6X6X948DGW05Q>
    <xmx:A5PkZe18lTcFzPc0EAbHi77UhNpx34BGAziyNjtjTORfV1xY5xveHg>
    <xmx:A5PkZaRhRBnge5-M2lkXgGvXh2A_ZFXz6h1scPbarzHwMFE6PAvJjA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 10:10:58 -0500 (EST)
Date: Sun, 3 Mar 2024 17:10:57 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, johannes@sipsolutions.net,
	fw@strlen.de, pablo@netfilter.org
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <ZeSTAXCZyxpKrhaL@shredder>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303052408.310064-4-kuba@kernel.org>

On Sat, Mar 02, 2024 at 09:24:08PM -0800, Jakub Kicinski wrote:
> Make sure ctrl_fill_info() returns sensible error codes and
> propagate them out to netlink core. Let netlink core decide
> when to return skb->len and when to treat the exit as an
> error. Netlink core does better job at it, if we always
> return skb->len the core doesn't know when we're done
> dumping and NLMSG_DONE ends up in a separate read().
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

