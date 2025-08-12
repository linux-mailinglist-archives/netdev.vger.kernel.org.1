Return-Path: <netdev+bounces-212942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D67B22959
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D24E338A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABA7287502;
	Tue, 12 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFMth9Am"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA928727C
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006786; cv=none; b=R/TXJJAxy1ovQbcMDsbMO0HbAzJMtFeUPn5Af+4+QCn49J61qb5Q++3jQP6nsaxc4/SkCx+wpwF3wBeTyOa9aLVJL5cPekUDFwG/HS7c69J2L+1a93d6/9Q6iwVK1BAWcI6Mn2Vq+Ee49zTSuuXgoAUIGtYD2ky7Tu+smamKZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006786; c=relaxed/simple;
	bh=uKL0hHlUsfEsqR5qxI8fBxhw1OJ149ywCzoSBnHLtMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptFRUFE28d/rNRCDivGB+Br53yeydi/EE0glj+JCHa+RglauD16vKD/47IQ2xadknBiQeoRXx0WA+V++A6JRiQeVfxV8HoHZ73CDGkuLKbmsnJA2OUuNTIym3PSKgVIczJE6ImE4bg+kSTZQddc33k6qSzwrzJ92pjsXkknO4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFMth9Am; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BB5F7A003A;
	Tue, 12 Aug 2025 09:53:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 12 Aug 2025 09:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755006782; x=1755093182; bh=J5j6atCjUJt/FYl9hWw2l5Vu3ZJuQ326uXw
	uAqx8vqg=; b=ZFMth9Am1RXqOJ5hc4NVfRcS6kj4g9GNiRRYGzXpBC1R1aFvv6M
	kRra5inWdNNPcO1Vs/Agc7iP2LZRYnI0zjFQnnwAomvJvR/jtV0zjcCKCs1MYknn
	pho3axzmp8xP2OntrrJSj0Ap4fyraoE29f9gXQ6O8plXEsxfYufBnvkH77Ld5Ucd
	BEsOdE80I2fzvC2ZcfIDKWc3+S/yUubee5nrE32xWKNvcl+qOI3zE02T2XET7WHh
	bqUUiAVUyNxANTIasy966yhXcfgEw/B44V1DMsCxhpD95Bolm9q6CILhiO7CLv8D
	wyTeSq+7EO0qtyWNykUN4Ka/iWPDEmc/IMA==
X-ME-Sender: <xms:PUebaI9tE4OKBT6aHebYB5A5CMwueuopzkzAesiUhLQUVC_uqbZIfg>
    <xme:PUebaOT7yzCCRdcXngOEsA8J9JTdG6HCZbTlNcOQ6dHLj6ef7-JB-_00vSOsaDG1f
    SHJx6-cQICoxGQ>
X-ME-Received: <xmr:PUebaEeGCIgps06QYYzG0csZROQyQwsIFVTCS94UEJKAuvbmrHemeOz3VkrCQhPNkNsxjMgmnLOfB3omE0n2w84HBF1FPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhs
    tghhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiie
    eguefgudffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohephhgvmhhinhhhohhngheskhihlhhinhhoshdrtghnpdhrtg
    hpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihihuhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughsrghhvg
    hrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PUebaKDKbTeDDWMIok3yauY8Z0ZTh-kmeW4241yilh7gLwtgsn0QBw>
    <xmx:PUebaOllmBsHCfOVSPBsJBDHBgCg8Q2mWQXxgPu_5fGigKCT0TJEGw>
    <xmx:PUebaNcVGSBmjtwi59JTBigEyPtI-JBx_s0niI3AAwinLeH-Lhsw5A>
    <xmx:PUebaKRx6lY3lz_nNTWVYucj6bgMrl89wEPkdIXWaIidB1qb9nos-w>
    <xmx:PkebaDvWePLArnKmHBHPPsmkO45lfOLQv7FYo0qTMptVizptQtceZu8J>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 09:53:01 -0400 (EDT)
Date: Tue, 12 Aug 2025 16:52:58 +0300
From: Ido Schimmel <idosch@idosch.org>
To: heminhong <heminhong@kylinos.cn>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kuniyu@google.com,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org
Subject: Re: [PATCH] ipv6: sr: add validity check for algorithm ID
Message-ID: <aJtHOuAc3BM3Aa9l@shredder>
References: <20250812061944.76781-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812061944.76781-1-heminhong@kylinos.cn>

On Tue, Aug 12, 2025 at 02:19:44PM +0800, heminhong wrote:
> From: Minhong He <heminhong@kylinos.cn>
> 
> The seg6_genl_sethmac() directly uses the algid passed in by the user
> without checking whether it is an HMAC algorithm supported by the
> system. If the algid is invalid, unknown errors may occur during
> subsequent use of the HMAC information.

You should explain the user visible effects from this bug/fix rather
than saying "unknown errors". AFAICT, an invalid HMAC algorithm will
result in packet drops during encap / decap, but I might have missed a
more serious problem.

Fixes tag seems appropriate:

Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")

And please read:

https://docs.kernel.org/process/maintainer-netdev.html

> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  include/net/seg6_hmac.h | 1 +
>  net/ipv6/seg6.c         | 5 +++++
>  net/ipv6/seg6_hmac.c    | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/seg6_hmac.h b/include/net/seg6_hmac.h
> index 24f733b3e3fe..c34e86c99de3 100644
> --- a/include/net/seg6_hmac.h
> +++ b/include/net/seg6_hmac.h
> @@ -49,6 +49,7 @@ extern int seg6_hmac_info_del(struct net *net, u32 key);
>  extern int seg6_push_hmac(struct net *net, struct in6_addr *saddr,
>  			  struct ipv6_sr_hdr *srh);
>  extern bool seg6_hmac_validate_skb(struct sk_buff *skb);
> +extern struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id);
>  #ifdef CONFIG_IPV6_SEG6_HMAC
>  extern int seg6_hmac_init(void);
>  extern void seg6_hmac_exit(void);
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 180da19c148c..33c1481ca50a 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -152,6 +152,7 @@ static int seg6_genl_sethmac(struct sk_buff *skb, struct genl_info *info)
>  	struct net *net = genl_info_net(info);
>  	struct seg6_pernet_data *sdata;
>  	struct seg6_hmac_info *hinfo;
> +	struct seg6_hmac_algo *algo;
>  	u32 hmackeyid;
>  	char *secret;
>  	int err = 0;
> @@ -175,6 +176,10 @@ static int seg6_genl_sethmac(struct sk_buff *skb, struct genl_info *info)
>  	if (slen > SEG6_HMAC_SECRET_LEN)
>  		return -EINVAL;
>  
> +	algo = __hmac_get_algo(algid);
> +	if (!algo)
> +		return -EINVAL;

Another possibility is to keep the HMAC algorithm logic in seg6_hmac.c
and perform the check there. Something like:

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index f78ecb6ad838..d77b52523b6a 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -304,6 +304,9 @@ int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 	int err;
 
+	if (!__hmac_get_algo(hinfo->alg_id))
+		return -EINVAL;
+
 	err = rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo->node,
 					    rht_params);

> +
>  	mutex_lock(&sdata->lock);
>  	hinfo = seg6_hmac_info_lookup(net, hmackeyid);
>  
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index f78ecb6ad838..1c4858195613 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -107,7 +107,7 @@ static struct sr6_tlv_hmac *seg6_get_tlv_hmac(struct ipv6_sr_hdr *srh)
>  	return tlv;
>  }
>  
> -static struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
> +struct seg6_hmac_algo *__hmac_get_algo(u8 alg_id)
>  {
>  	struct seg6_hmac_algo *algo;
>  	int i, alg_count;
> -- 
> 2.25.1
> 
> 

