Return-Path: <netdev+bounces-149993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2041C9E873C
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 19:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B52616419E
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DB170A15;
	Sun,  8 Dec 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aVBTII4b"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545314F11E
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681755; cv=none; b=n3aPkprbE1AvV8+ppDh4/TBW0+4CANZ12OdIALnF9QbHQKZlNT/LDaHmgdoGq/eUgY49eh53V0hTEEM4ajL2tKhcKnxpcO+OkTWUQ94I8/TlZGGWl0ZyZwaHUlttoC98o8r/1H0IaMsP7V1hrwcE2fadFkwUwbkbIbhV+j5OglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681755; c=relaxed/simple;
	bh=sMC6BO0cvjvC+0KTXdXtBOcLWIMR/z5FRUDqb+RyBZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZfIpHs5gHXAoNyhlHwOwcVBXmt5jPWsXw9AhTqn+sNshefK+UOLZzJzVpwLy96sMfKPAAbYMpo1MOL8r37wzWqo5d2/I3FehpdrhqNK88cQE7u6AX+TBD3QrAkN6xUnClzWPn2ae7SPoUOsTifffS5JFTYCUIW0RbHEWkAjcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aVBTII4b; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 568C5138370D;
	Sun,  8 Dec 2024 13:15:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 08 Dec 2024 13:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733681752; x=1733768152; bh=FLnbMIlg24XpZCWZP+Es/S5Wq3XTM8SEg01
	ety7QCW0=; b=aVBTII4brvRFDafxkopS22ZOxRdMy0CsXDnNx9Xtjze9pcesjkg
	QtEos91fpl9KrKJYGesYP4j6x1SeZ7gKxXPgFvLNdqak8SaEFFbDwBV7O+yZkzfq
	s4NAmEGPpsXLbsimmFWvtaoLwAHra6GdRwefKp1e28K5VbO8fGH5oC77lceQzsDI
	jsv/suFaGULh1R8bIHTkK2EdIfkEpJQRAHKnZLuNNbsGvfPQVhlkinzvAj1rV8LD
	8bpZEriP9ZLUOU9gP4olvUjAOo1AKh35Fd8AFAGN5eGTmdlrs4qTESkelPzhJC7d
	JI2QViTEh2/iZmRCTzCrull9YmsSjj7oV1w==
X-ME-Sender: <xms:WOJVZzU876pS25oDlFi0PMdDtt3Rla7FUdAZDhGG1atnoVL3ykVIqg>
    <xme:WOJVZ7lcxnbRtzJWZEvW2Lv6qKpdIuamUou6sqYw-HXwu4OtKj-aEYWOaHHcw7BY1
    WcqO3gg_fYzPvQ>
X-ME-Received: <xmr:WOJVZ_YIsKnTgXMoPdpHk71_FKTel6zxerQe0m9OvgWtSc87O_jIHXLN8NQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdduudduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:WOJVZ-VArEN0PVfPOo0Kzlf3zymICFXPc6w6tTfHgJ5Z4PchAYqQ4Q>
    <xmx:WOJVZ9kjBTgcdrUyRSBZtAuAuFHb5Etia8Hd5VQCiNU0bIXao0z2LA>
    <xmx:WOJVZ7fVVzObGexApgnpqgsiNiMCRZIi_caJTDJSMh0TaR1avkZiOA>
    <xmx:WOJVZ3H6ue-2X9V05e1rYclRUvnxt7OdxG_KWJX4Lv3epIuaxi-4Vg>
    <xmx:WOJVZ_4a6_z_xblBhM8Jl-4Gy0PBWqrqjr1Dtwg8udaPn4CrLJrTXxCv>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 13:15:51 -0500 (EST)
Date: Sun, 8 Dec 2024 20:15:49 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/3] rtnetlink: switch rtnl_fdb_dump() to
 for_each_netdev_dump()
Message-ID: <Z1XiVUeTpNCjC4YF@shredder>
References: <20241207162248.18536-1-edumazet@google.com>
 <20241207162248.18536-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207162248.18536-3-edumazet@google.com>

On Sat, Dec 07, 2024 at 04:22:47PM +0000, Eric Dumazet wrote:
> This is the last netdev iterator still using net->dev_index_head[].
> 
> Convert to modern for_each_netdev_dump() for better scalability,
> and use common patterns in our stack.
> 
> Following patch in this series removes the pad field
> in struct ndo_fdb_dump_context.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Conversion looks correct AFAICT:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

