Return-Path: <netdev+bounces-179631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C48AA7DE6D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E393B188B3A4
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C825335B;
	Mon,  7 Apr 2025 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="WAaYGBHD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsHlgeoZ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A9253335
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030986; cv=none; b=JGFVrNpaWDyLgsdwWAmbjyitAYqE61kZUnZ8M7N/2pIlHTxSIXGZb4Cf4V9swKNXBTVBdHt92NhmadH7Kd2wlKTvZ41dr7NVNb9Mm2BAEnpREToljwxiFIgic3fE6nuikezqnr53Ivn5mktRFohsS8XSnkp+4YeJsdSej5Sldio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030986; c=relaxed/simple;
	bh=NyTHXZ/Qrs8dSngSw3Ynxm59xTABNUuPsWauBIAZp7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQfNHoIlfF1JCe6GifGNDs9Zp3ynRg2AavSxSlMIhvUkjajFIpd5I5Y8H6tgc9ahWpxAeoZJHH3U1xnNHoQig7HqkBXZXEqG9mYSaQ60LH3T7LuWN6xP4X8ExKs3yGM0ehG6+vwiI0Zcm10cQyH/s8UN/YXNGLQ9n5h6dObZofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=WAaYGBHD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsHlgeoZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 931A3138012C;
	Mon,  7 Apr 2025 09:03:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Apr 2025 09:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744030981; x=
	1744117381; bh=/43TLzUy9h8C75z2NzRD2KcaDZ6IshxawTIxzk8PLDM=; b=W
	AaYGBHDBhENEC7Qp9uUnWg/kN4ce6FHtIMOAac7EYaqIvT7P12ifatFbo89Pezlj
	2LJrgowz9DbBfSixCB2VBh9nkMLSnHKhgwzdlpPXSt0kSu6QlxTXc5UwiHEMBam5
	vc4FJw8WwxDfa/BTXPigXnnvpTl4ltyWtZgkiqhLByIt59EgnMtId+xG5tcG2WtC
	M/Ijk0Qzmwu+GZM3Lsf3VEHsBQYgxc1TcjWSZFsD3sNLSfxSDtU88s8f0AvMOvB+
	Ecq9grat1gAEM3GRIwBdKOoU2l7Jnxih0l2FFzGSo/IFZh3FCV/dGAms+1LNPcBA
	jO5zV67Kf3iJ4ktTQG5vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744030981; x=1744117381; bh=/43TLzUy9h8C75z2NzRD2KcaDZ6IshxawTI
	xzk8PLDM=; b=gsHlgeoZQupzPgw0UaiYhdGfyTogp2A//kp/U0byJ883ORRYpo+
	KyEUk4zL5N5JUzme7hwixS1FjYXYHnVPnpInbvWT1cSnOfQnmsyyZhq53UC1uXei
	KEDKWFJEDknos0x3jCCTlNAdqBr8r0xSSD3hl+do5VkY1tiaenU8FazXO9OIc+Ps
	x2HVMgJBRa3K3UfL74zBW7AeWtU2iDPznKAZmCGq/2hT4Nx0pLiJ0lKtyjnoJ3Gn
	m+zVytClU5r802JkG52zllcepuEuMTA+d+Atl3dIYcisl/W2Hb41XYVAbgpSYQLg
	7mmzpRDZYazpdDY/t8Q/eY+B3uuOVR5ZjOw==
X-ME-Sender: <xms:BM3zZ3TF1f0Kn6xzO56zxbMSfqbr3rXDKY5-xQUSZAhQUJFhPgzxTQ>
    <xme:BM3zZ4xmUQpqgOlZ8EqdrByltergFMYvYBwW440-5PKgLRB1dxRcYuK96UEB_mKqL
    vEMOA2qQ4hDvEwoIXk>
X-ME-Received: <xmr:BM3zZ83JOm-rpm924LOx57wUFBM885fY3FMjdi3tNEEPUA7Ds-XIy1iA93QT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgs
    rhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffefgfduffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqh
    huvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohephh
    horhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghorhhishhpsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:BM3zZ3CGNUGPsiUvP4ethcXIxEHVPqbJuDwIO6KMJPVbP4FHiQr7cw>
    <xmx:BM3zZwiiFiZcM9li7Re9_BBs7xkEvSvhztSEySTUdd00AaNKCj7vsw>
    <xmx:BM3zZ7rJfF3rIsW3HluC9BwCuRgYC5IYubz9JxWca-LXgCkN9qSeag>
    <xmx:BM3zZ7iRdKEchjnQrIHxyLrdT-_4kzB_sqbqzowRx1LXtgoBIrZtVA>
    <xmx:Bc3zZ4BE5lP47QCjU6l_jS3ypJd5V1_LpvWVsVAkJzQnE5ka7GjtRe_4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:02:59 -0400 (EDT)
Date: Mon, 7 Apr 2025 15:02:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	borisp@nvidia.com, john.fastabend@gmail.com,
	syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
Subject: Re: [PATCH net 1/2] net: tls: explicitly disallow disconnect
Message-ID: <Z_PNAl-kLE4ExJ8Q@krikkit>
References: <20250404180334.3224206-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404180334.3224206-1-kuba@kernel.org>

2025-04-04, 11:03:33 -0700, Jakub Kicinski wrote:
> syzbot discovered that it can disconnect a TLS socket and then
> run into all sort of unexpected corner cases. I have a vague
> recollection of Eric pointing this out to us a long time ago.
> Supporting disconnect is really hard, for one thing if offload
> is enabled we'd need to wait for all packets to be _acked_.
> Disconnect is not commonly used, disallow it.
> 
> The immediate problem syzbot run into is the warning in the strp,
> but that's just the easiest bug to trigger:
> 
>   WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>   RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
>   Call Trace:
>    <TASK>
>    tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
>    tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
>    inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
>    sock_recvmsg_nosec net/socket.c:1023 [inline]
>    sock_recvmsg+0x109/0x280 net/socket.c:1045
>    __sys_recvfrom+0x202/0x380 net/socket.c:2237
> 
> Fixes: 3c4d7559159b ("tls: kernel TLS support")
> Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

(hopefully nobody complains about this. but since it was broken
anyway...)

-- 
Sabrina

