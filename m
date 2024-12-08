Return-Path: <netdev+bounces-149994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219559E8741
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18338164189
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4B1865E5;
	Sun,  8 Dec 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CU+QMUbl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508214601C
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682026; cv=none; b=LvE1AlBAWuOkig1VQqQTn1wQGR6L5bdywF8kXQdf4rpZtNhqg3vAluocPw86rgv6k32Qp1QT6ZFyzY2BwjN52ntE+s5Fo+CYI5yp9cTndTw+CJECtn+4dV2/EO+M8WGfwrx6A0AHPrsOygjOziQ/ipukaV8FZghHtz5bEoogphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682026; c=relaxed/simple;
	bh=F2KTZKgqk9/mrddu5ONC7vRDRlZ1Vagyg/rsk5xe7Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIKSMTGAWv/vaR+/sau3arZTKh4bqZE1Hbq1cCdE5e2hVSYftKmfHma1r+R5syH938cCQ0hf7yGS9auLnxctUn1D6hWVsBSSt2wMwtbTz6RWdw39lAm55k+nc+HkoNEl0CbeLdr1tQO13B6f/RNvFGe/JCwqBKPT2wC1ECJZChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CU+QMUbl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E4A0138370D;
	Sun,  8 Dec 2024 13:20:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 08 Dec 2024 13:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733682024; x=1733768424; bh=Xtru2baCC7llWZMkYPIKR1zhs5rHaITOgfj
	LvdRH2zI=; b=CU+QMUbl3u4BAaMI9yHHWylSzIn54QuET+RexqTnq8DA2XqdCXv
	hlAbsYHGiTCofJxRmY75Z+tKBILq2Cwj0cwvSf5fZQ7gKASDRy62BJ1mdotzjino
	+udpaQkIVMcdW/7nYam0qAGP4VGD0sGxHvXgJHYXszGhI1+owpdUFXcjgoGxKv2o
	23Th9KJl5i/P2k+N3dQ2dHFin88LXHRr6lkkdTB5WG4SdURBL47ARFB6OkjAgq7Z
	62weln3eBQu0tWBsJoPG0FiCBYNPs60dtvxn0wkR/wMok/ITkruvVAH7p6N4KQxD
	ZCNiUCUw+CtFjL7rq/HZBSUkElejsOzi9dA==
X-ME-Sender: <xms:Z-NVZytpU9WfqpleE3wn35ezA5AVQsTOm_xMBCBOwq8MqeunM67WDQ>
    <xme:Z-NVZ3eFmkpWvekQ_fAa2BMqxfwwq-_fmDbw4wfE_UJDOJtsA5THxC-9PwsBNY-0s
    PPlVRU363YDUzU>
X-ME-Received: <xmr:Z-NVZ9wVyMpNmrKfQ4xDgIo0joZYzENXrPlOPCvIWBswDnOyimRpyGWRlWyt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhoohhprgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhunhhihihu
    segrmhgriihonhdrtghomhdprhgtphhtthhopegvrhhitgdrughumhgriigvthesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:Z-NVZ9NiiE6CMZiZf36SlDaETDobghRcjzs5GRbWCllmkyJLN0CnNg>
    <xmx:Z-NVZy9qo0mBZhZZ5xnwIWdbK_3ilf617s2LdqJRP7y3SH-JmK6ukQ>
    <xmx:Z-NVZ1UMNVIkoV7ZlWmVetL6ywMVGKGxq7_9hw688IBVR2jPv7QndQ>
    <xmx:Z-NVZ7cvpDAVSOE5H2PELTu8tc-Xm8TbZ8ZRknAlaBKe_Pk0vvgmKQ>
    <xmx:aONVZ2QtWKwGMKedsaCQZib-GJeyqeFqNQtbIbvM3eTeIu4I0mkOAK0N>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 13:20:23 -0500 (EST)
Date: Sun, 8 Dec 2024 20:20:21 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] rtnetlink: remove pad field in
 ndo_fdb_dump_context
Message-ID: <Z1XjZb5ZCqjTveo0@shredder>
References: <20241207162248.18536-1-edumazet@google.com>
 <20241207162248.18536-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207162248.18536-4-edumazet@google.com>

On Sat, Dec 07, 2024 at 04:22:48PM +0000, Eric Dumazet wrote:
> I chose to remove this field in a separate patch to ease
> potential bisection, in case one ndo_fdb_dump() is still
> using the old way (cb->args[2] instead of ctx->fdb_idx)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

