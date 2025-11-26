Return-Path: <netdev+bounces-241918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F8C8A5D1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2C88355D21
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3F303A20;
	Wed, 26 Nov 2025 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UktEiGnH"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A174302CC3
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167749; cv=none; b=EX/eNNUVTGTi4yKr5IDa1cyUYE+iUDgxaGHXEdDj188RSP7k/GEsuKuA5oKJOd05r/kxPwHs7hQA4N3H4MiKnNpYo03Ans96WMNDSmalGlukbuA18+f0cmOLTh6CgPxp3E5daS/Rc1l0tpIJk7Bx4L78Smb6lF//pFE3kRwicvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167749; c=relaxed/simple;
	bh=gPV8Fz1q/lh7fG2oZokvctfFp8u+yGpb1pNHshMB/kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVAuGEN4qkjT6IwEpQ4+K4IHR7zClvGj9QtTPLcwmtJ9c+3THGjzmhDfqqgFr2V0vIlQtQtsSDGM/HWhqH/rm1bLKp2gJfRkYH9XsFXrqem6jcc9qLThKJdkLmzr5d+mp9YpXNAibgyUtdR5u6BR+1iLJewOgWD3suYwhxwwN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UktEiGnH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EC98FEC011D;
	Wed, 26 Nov 2025 09:32:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 26 Nov 2025 09:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764167537; x=1764253937; bh=CWeE8C8WvKh/2yhmcgCfDSk3qxgkQAFSlu9
	ZjP12s0U=; b=UktEiGnHTq0ztl4VlZKnbYLfjdzftNYA6II5E7Z+RcEXRuw1xKO
	dWnklBbkC8OP8gtwDlq7PgyxUsWy9LgLO02oKt/rzY0HUOJsJobzUYIVwed6wBp1
	G/x0IKkjNlBJl9+zT26p2dEdmqKzR7JTef3L61rcUKt4lbAa/sj88zrSlkYHZA2v
	NKnaRM/+IyjCp9S9txDHhjAyzlk1DQS2bRJsSwB/td0KQZwRo3AHQ1Z6Hys9HXSb
	w0pqtD4Sdt1g4PGcr5djfR9YwOHE1FQ3e3MBozXav3qQuKLu9uMwABfpTJ1fsumB
	KsQY8fJVtiDsKLpXL4R6RUNVYKShBCGtSDQ==
X-ME-Sender: <xms:cQ8nab0goFnxqpfvsz3zHQShvFi5igp37WynsEL_Z7FPbgP8Itg5ng>
    <xme:cQ8nacqeh01qGAZvzpLJEB3fIdkHWNsE-S0nvZvzMSUxqdNfrWry3y48HiknOnset
    2vvrw50wNjOaAmNGKmpZNMSOXT-qx3q2K0Nrh4Nj5ti0AYGdir3>
X-ME-Received: <xmr:cQ8nafjsvfC7EstLsnLw47LJ9Um5-3FUlBeV3TyeOda2OMsCd15ptpdJhVmgNtVs6TTM5Y3joKYhavR7e_smMznrsrJu1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghtvghnrghrtheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrlhhisehrvgguhhgr
    thdrtghomhdprhgtphhtthhopegsrdhgrghlvhgrnhhisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cQ8naQ9r8bUgCuE0-9CZUYGkes8B1Pca-6B8jI1gN4Dhd4R-8o7ajw>
    <xmx:cQ8naTU_TpOBTvLW3nBuKu7LZZ3pFCittMP-Z9M12JN-d3-qnaYAjg>
    <xmx:cQ8nacA9mFFWo6dcWMbvPvLXA4l48r5xL7LQVR7gBU-lOG9fyDUFTg>
    <xmx:cQ8naQHHU7sLoJevc9VYSAs4hzR45OtEJPM2qctmWlhR1D4gC2ahIw>
    <xmx:cQ8nafvKcSPGgy73vB5-4p3iwTJFIno7eIuiQO2eVTNDmJ_kJD-sBToK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 09:32:16 -0500 (EST)
Date: Wed, 26 Nov 2025 16:32:14 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Liang Li <liali@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH net v2] net: vxlan: prevent NULL deref in vxlan_xmit_one
Message-ID: <aScPbnXHCNrpu4u3@shredder>
References: <20251126102627.74223-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126102627.74223-1-atenart@kernel.org>

On Wed, Nov 26, 2025 at 11:26:25AM +0100, Antoine Tenart wrote:
> Neither sock4 nor sock6 pointers are guaranteed to be non-NULL in
> vxlan_xmit_one, e.g. if the iface is brought down. This can lead to the
> following NULL dereference:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:vxlan_xmit_one+0xbb3/0x1580
>   Call Trace:
>    vxlan_xmit+0x429/0x610
>    dev_hard_start_xmit+0x55/0xa0
>    __dev_queue_xmit+0x6d0/0x7f0
>    ip_finish_output2+0x24b/0x590
>    ip_output+0x63/0x110
> 
> Mentioned commits changed the code path in vxlan_xmit_one and as a side
> effect the sock4/6 pointer validity checks in vxlan(6)_get_route were
> lost. Fix this by adding back checks.
> 
> Since both commits being fixed were released in the same version (v6.7)
> and are strongly related, bundle the fixes in a single commit.
> 
> Reported-by: Liang Li <liali@redhat.com>
> Fixes: 6f19b2c136d9 ("vxlan: use generic function for tunnel IPv4 route lookup")
> Fixes: 2aceb896ee18 ("vxlan: use generic function for tunnel IPv6 route lookup")
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Tested using:

ip link add name vx0 up type vxlan id 10010 local 192.0.2.1 remote 198.51.100.1 dstport 4789
for i in $(seq 0 $(($(nproc) - 2))); do
	taskset -c $i mausezahn vx0 -a own -b 00:11:22:33:44:55 -c 0 -q &
done
taskset -c $(($(nproc) - 1)) bash -c "while true; do ip link set dev vx0 down && ip link set dev vx0 up; done"

