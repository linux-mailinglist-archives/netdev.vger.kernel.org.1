Return-Path: <netdev+bounces-149992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3899E872C
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF30281A41
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437231865E5;
	Sun,  8 Dec 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXihdZu/"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFD14601C
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733680676; cv=none; b=XOqzrH0E4Is8g6UEi0+wJm0gQC4jrkqGKMsfLTtx8B0z75XxI5y8eiNySWgnElsLzlIgo4bKfUAGI4l7MoKkStAAj0z0myuun2CXV8ofBVnRMFf1eGP0KwudqfT9sBIxTXgTtvidCDjguLcxRMrrKvK4Lr9HozHFWRUhQkizQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733680676; c=relaxed/simple;
	bh=/aqbPxn48DneYtRTSd9rDcyHDrC+l3dzU02zomWYyEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQcTPRTmeI1pkl5cUZ5TgJViaotQ4UIRJK/xmEz28DgMqt2HZ3cbC/qm+K1OIK0hfxHR8u/btL+oFmAMq+e60D6ucaF08KpVQTUGQNXhT1B5DZY2e6bhusJxdGa4YqdsafGmR4hG4KgFVHO4Grx6a6KHAma1icRWjTPxMeVi5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXihdZu/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0790911400B4;
	Sun,  8 Dec 2024 12:57:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 08 Dec 2024 12:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733680673; x=1733767073; bh=znbVZgP3QlOrZjo5Oc1Xd33fmA0dvrWTQyl
	tWq6+rQE=; b=wXihdZu/I8i5EU3hVlDmn4X0B6Rb0OBndLPFh9BExwfpqrPWXDP
	Fs3CdryHbsiCtas3o/eo/rxR8j1t3n3MukDVgZX8PByb3uK4pwrHZ8lmBAGgPmjG
	ltO0z+vUOH0rS370DwSgCWVFEH1Y7PRV1TsLOe5rGXkGB5M1KBjBY6iidkh9Qewy
	6lz3x8oDFNfdRSQYlHoY4u3/Gni5QXNUoAn6V/7MYIXtlxtbnJmhJbbv3Jk6wTNg
	6ESdJYoaw0zDZ5A1oNuIfbCfs390PLhPB9XmnI/qD5gMY2l4uyrQtYqzYwvsvqYB
	EfmkRsEWa2gTQEBGl2T6HecGW84diarx1Qg==
X-ME-Sender: <xms:IN5VZ4MifGAjDuxlpc7vnQj7f5GzU4T1BmUqwOp4GHg45OvG5-_UqQ>
    <xme:IN5VZ-9_lk5q_b-kfRlXvioZIsGP6jFu4NRI7CZyaLpJqDHx6oJzgwdYsYy3qmC4v
    899d36lRrsdMws>
X-ME-Received: <xmr:IN5VZ_SKudYqULnFwWDhJqbGlQ-biOeVqix01QGhsCNA7V5U2u6kxvrfFPCT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgddutdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:IN5VZwvOqhUAkntuYOyif8eqlv7rDVFDtVe0yTtTVB8pnJLUmfQx3w>
    <xmx:IN5VZwdhP2fiLtsmtp02lEhdL7MjIISuEAQmwe7un1ybxYir7TL_mw>
    <xmx:IN5VZ002g-x3kXIUIFTUygbI9OJHqh-mihR_0mQ-07vSRpHfnFgb0A>
    <xmx:IN5VZ0_eQN7w8th56rwkKVlTLlH8WGXl3QNY7f-2K_JSsbx64tf6IQ>
    <xmx:IN5VZ3wYcabqj6-S2ObVHSQOUvpDVUJNTh4xYT_dNdlTdE5IEcaM07jW>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 12:57:51 -0500 (EST)
Date: Sun, 8 Dec 2024 19:57:49 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/3] rtnetlink: add ndo_fdb_dump_context
Message-ID: <Z1XeHQJkeJQ1OBFz@shredder>
References: <20241207162248.18536-1-edumazet@google.com>
 <20241207162248.18536-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207162248.18536-2-edumazet@google.com>

On Sat, Dec 07, 2024 at 04:22:46PM +0000, Eric Dumazet wrote:
> rtnl_fdb_dump() and various ndo_fdb_dump() helpers share
> a hidden layout of cb->ctx.
> 
> Before switching rtnl_fdb_dump() to for_each_netdev_dump()
> in the following patch, make this more explicit.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

A couple of nits in case you have v2

> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  3 ++-
>  drivers/net/ethernet/mscc/ocelot_net.c        |  3 ++-
>  drivers/net/vxlan/vxlan_core.c                |  5 ++--
>  include/linux/rtnetlink.h                     |  7 ++++++
>  net/bridge/br_fdb.c                           |  3 ++-
>  net/core/rtnetlink.c                          | 24 +++++++++----------
>  net/dsa/user.c                                |  3 ++-
>  7 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index a293b08f36d46dfde7e25412951da78c15e2dfd6..de383e6c6d523f01f02cb3c3977b1c448a3ac9a7 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -781,12 +781,13 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
>  				    struct ethsw_dump_ctx *dump)
>  {
>  	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
> +	struct ndo_fdb_dump_context *ctx = (void *)dump->cb->ctx;

Any reason not to maintain reverse xmas tree here?

>  	u32 portid = NETLINK_CB(dump->cb->skb).portid;
>  	u32 seq = dump->cb->nlh->nlmsg_seq;
>  	struct nlmsghdr *nlh;
>  	struct ndmsg *ndm;
>  
> -	if (dump->idx < dump->cb->args[2])
> +	if (dump->idx < ctx->fdb_idx)
>  		goto skip;
>  
>  	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,

[...]

> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 14b88f55192085def8f318c7913a76d5447b4975..a91dfea64724615c9db778646e52cb8573f47e06 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -178,6 +178,13 @@ void rtnetlink_init(void);
>  void __rtnl_unlock(void);
>  void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
>  
> +/* Shared by rtnl_fdb_dump() and various ndo_fdb_dump() helpers. */
> +struct ndo_fdb_dump_context {
> +	unsigned long s_h;
> +	unsigned long s_idx;
> +	unsigned long fdb_idx;
> +};
> +
>  extern int ndo_dflt_fdb_dump(struct sk_buff *skb,
>  			     struct netlink_callback *cb,
>  			     struct net_device *dev,
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 82bac2426631bcea63ea834e72f074fa2eaf0cee..902694c0ce643ec448978e4c4625692ccb1facd9 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -955,6 +955,7 @@ int br_fdb_dump(struct sk_buff *skb,
>  		struct net_device *filter_dev,
>  		int *idx)
>  {
> +	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
>  	struct net_bridge *br = netdev_priv(dev);
>  	struct net_bridge_fdb_entry *f;
>  	int err = 0;

Unlikely that the context will ever grow past 48 bytes, but might be
worthwhile to add:

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cdedb46edc2f..8fe252c298a2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4919,6 +4919,8 @@ static int rtnl_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	int fidx = 0;
 	int err;
 
+	NL_ASSERT_CTX_FITS(struct ndo_fdb_dump_context);
+
 	if (cb->strict_check)
 		err = valid_fdb_dump_strict(cb->nlh, &br_idx, &brport_idx,
 					    cb->extack);

