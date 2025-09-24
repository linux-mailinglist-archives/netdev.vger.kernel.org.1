Return-Path: <netdev+bounces-225962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85AB99EE9
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FB83BE602
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6222FFDF3;
	Wed, 24 Sep 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ee/piEgm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED02E7F1C;
	Wed, 24 Sep 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718379; cv=none; b=bLCpQ82IZSOFe/1WwFFWUTKswKJmAPJk44N7fl7cDgdkwEWTsElV4MmGm8dm35b6ydhJ1Ow2mQh5+4PcnpdYA6m1O6/3UqvHhY2bTi+CL4quIc4n1mcTe/MMvl5mPqlemznBPKZWyW5siARGfzzap8T2i6mSqrDLOu3uWU65pJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718379; c=relaxed/simple;
	bh=ejr3zw/XIHULBrVIyEI6iqOV1aT6O0a9a0XRWcGXDtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzRHTGYx2E1k0EpYNFCO4lWXPMkmHZMjvGGN8OpVjuYq1zqFFD/7S48Qxuq41t1o63yO/N8wOlaGRV50EsVd1wR9hV5zJoMU38+nsKfx/a3mZJr7GkNDkHtVsu62VfN5Cb7223zvy0R/2HuJhe42nyRx1mS+uD1LkbwKbQmjp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ee/piEgm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E1F39EC0022;
	Wed, 24 Sep 2025 08:52:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 24 Sep 2025 08:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758718376; x=
	1758804776; bh=V7CZ/jkYXq2Kw7suKXVAyM/XElJWphl+8HFkAZmMpK8=; b=e
	e/piEgmWmHaG6UTD1qGM7/OVyifVr01H9pWf5ZLsD/t5TGFeoH7la05cdzGYO5x4
	n8c9LOYCKX+JKcXtPQwY+tfn/Jwi2YRmKWPjLCiAmSIm3gwYFdUHTSdCFLrv3Xrz
	LGGtpNWUL0klTvZ/SC9xRSMb/czyH0XwSaei1kCawTZRjAIsIjEop93TCBhWMAOy
	pVvWWCLA1WFyDjv2ek4Hl+OcGN26ChT2+YbmcpRcUv5JQ9u3qyDXysHj88ULKNlz
	xNHRjjubYBNWlsFvJr1m8PoJydfMK3UtSedcurgi/FmUtMUXm0jnRMKEmkcx2DeZ
	Hpxs2NUo8Xr3MTJ/D0d1g==
X-ME-Sender: <xms:p-nTaMPvqbP14B_Xg6D9iwPuOGizAuwJdWYLtKTTrDgNzY9VA0ptFw>
    <xme:p-nTaKgXGqUWSoSlyF3QDnokAKKcpCNGGflhcDk0T0yM0Y7xD6BnLu0P5xaOsIBof
    3W3rNvR6kBr-E61-wWJ_fKVx8eQtSnF0OThfKuouGYAh3b6kGMy>
X-ME-Received: <xmr:p-nTaC4N6FaCnUuzjHfWdCSBn_UlOYu67ZG8yUKNeDbpjVbhSRDheUpI2eMJRti_Nwe10QCCCTkYAgvFwfoY3JSG4yPPJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeggeevffejgeejffeffefgkeffjefhjefgvdfhfeeghfegvdevleehgfdtfeeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohh
    grnhhnvghsrdifihgvshgsohgvtghksegrihhsvggtrdhfrhgruhhnhhhofhgvrhdruggv
    pdhrtghpthhtohepghihrhhoihguohhssegrihhsvggtrdhfrhgruhhnhhhofhgvrhdrug
    gvpdhrtghpthhtohepshifsehsihhmohhnfihunhguvghrlhhitghhrdguvgdprhgtphht
    thhopehmihgthhgrvghlrdifvghishhssegrihhsvggtrdhfrhgruhhnhhhofhgvrhdrug
    gvpdhrtghpthhtohephhhgsehsihhmohhnfihunhguvghrlhhitghhrdguvgdprhgtphht
    thhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:p-nTaBdQwDqC8LsUQxAHsOdeKaQHCASPV0zLP9sdSLeZeyiJasvWMg>
    <xmx:p-nTaLBLXKe8ej8kVw1aQWg6W6aLmyZ_FyLqrjxLO9vhscS0k9hFYA>
    <xmx:p-nTaACYEnRJqiUfmn0VEb6kwEQV7vSpumQyZCQQflrbImLR_hsAvg>
    <xmx:p-nTaNbTdrbhkaD_WxF8efWo6x7DWUItcexOOEZZ4Dy76svhWgKGKw>
    <xmx:qOnTaJJo6afo-gkA3IVVA_Vi4Q-nd-9R0oHzT6VRYGKMpg9M34nVXcgh>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 08:52:54 -0400 (EDT)
Date: Wed, 24 Sep 2025 15:52:52 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Johannes =?iso-8859-1?Q?Wiesb=F6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>
Cc: gyroidos@aisec.fraunhofer.de, sw@simonwunderlich.de,
	Michael =?iso-8859-1?Q?Wei=DF?= <michael.weiss@aisec.fraunhofer.de>,
	Harshal Gohel <hg@simonwunderlich.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtnetlink: Allow deleting FDB entries in user namespace
Message-ID: <aNPppN7crz-n7bej@shredder>
References: <20250923082153.60030-1-johannes.wiesboeck@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923082153.60030-1-johannes.wiesboeck@aisec.fraunhofer.de>

On Tue, Sep 23, 2025 at 10:21:40AM +0200, Johannes Wiesböck wrote:
> Deletion of FDB entries requires CAP_NET_ADMIN, yet, processes in a
> non-initial user namespace receive an EPERM because the capability is
> always checked against the initial user namespace. This restricts the
> FDB management from unprivileged containers.

It's worth mentioning that unprivileged containers can add FDB entries,
but not delete them:

$ id
uid=1000(idosch) gid=1000(idosch) groups=1000(idosch),10(wheel)
$ unshare -Urn
$ id
uid=0(root) gid=0(root) groups=0(root),65534(nobody)
$ ip link add name br0 up type bridge
$ bridge fdb add 00:11:22:33:44:55 dev br0 self permanent
$ bridge fdb del 00:11:22:33:44:55 dev br0 self permanent
RTNETLINK answers: Operation not permitted

After (not exactly your patch, see below):

$ id
uid=1000(idosch) gid=1000(idosch) groups=1000(idosch),10(wheel)
$ unshare -Urn
$ id
uid=0(root) gid=0(root) groups=0(root),65534(nobody)
$ ip link add name br0 up type bridge
$ bridge fdb add 00:11:22:33:44:55 dev br0 self permanent
$ bridge fdb del 00:11:22:33:44:55 dev br0 self permanent
$ echo $?
0

> 
> Replace netlink_capable with netlink_net_capable that performs the
> capability check on the user namespace the netlink socket was opened in.
> 
> This patch was tested using a container on GyroidOS, where it was
> possible to delete FDB entries from an unprivileged user namespace and
> private network namespace.
> 
> Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> Tested-by: Harshal Gohel <hg@simonwunderlich.de>
> Signed-off-by: Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>
> ---
>  net/core/rtnetlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 094b085cff206..2f96258bd4fd7 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4707,7 +4707,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	int err;
>  	u16 vid;
>  
> -	if (!netlink_capable(skb, CAP_NET_ADMIN))
> +	if (!netlink_net_capable(skb, CAP_NET_ADMIN))
>  		return -EPERM;

AFAICT, before commit 1690be63a27b ("bridge: Add vlan support to static
neighbors") it was possible for unprivileged containers to delete FDB
entries and the commit message does not say anything about why this
check was added. So, unless I'm missing something, I think your patch
should be treated as a fix and targeted at "net". See:

https://docs.kernel.org/process/maintainer-netdev.html

It might be a rebase issue. Commit c5c351088ae7 ("netns: fdb: allow
unprivileged users to add/del fdb entries") removed the CAP_NET_ADMIN
check from both rtnl_fdb_add() and rtnl_fdb_del() about two weeks before
v11 of 1690be63a27b was applied.

Also, there's already a netlink_net_capable(skb, CAP_NET_ADMIN) check in
rtnetlink_rcv_msg(), so I would just remove the capability check from
rtnl_fdb_del().

