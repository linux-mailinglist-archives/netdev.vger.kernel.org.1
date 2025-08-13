Return-Path: <netdev+bounces-213325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E0B248E6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BA189D10A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D02F3C05;
	Wed, 13 Aug 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O+oR9Eov"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD642580FF
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086099; cv=none; b=aLzO3hR6jmiIpDJr3oCTfj6lnWMNa7WFaUuJW9qKc8B2A8nZMWkJEenFav+OCWX5mnJGzQeWPj1WDcE563w4K0e1qhdtDsX78yQDPTiwqRlJTWKLx7AGCg+T1DgGahL3EEzhTtSH23HGOXRbni88pKI7IBH7ANP79NbIfG9Rf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086099; c=relaxed/simple;
	bh=if0Dt2vZT6bwHuja9mlMfqU0jQnUlY7EXGCTaR0pcDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLAasIiZ9CWO9w7z/ATM7+fN6Xdwur2lac6O2DJ2B5kFbOMRORNsWvVFggrWfLfm23nkl7tgUPD75nW/Jbl+A8dKx1HrS7tpFuUpDkh3vWrTyr9etxiINYQlBPkQGqOfIyl33qS4uMe+p5gf/GeENKLuyeNSRdzy5nwpsPhppTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O+oR9Eov; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BDF877A006F;
	Wed, 13 Aug 2025 07:54:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 07:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755086096; x=1755172496; bh=+KPfS/q5tSRY/lEboNb8TzBgbAOaeJPEI1+
	ld4w+yQc=; b=O+oR9Eovf0FPTW4O05tgDDlipywZ0yrSuS7BcGL9W6c1k9j3ou0
	UWIrWLX5IQ+9gE0GeTX0atwziWiVocjSMkPTm8U18eDBfyMr/NEH33oKEx29CEYd
	xQvxJ51rDYm5U9Qu63fbEkBkwFVDO9+opfGkphmiF6goejKFJdOVXXQ1lisAvjd/
	FXAEBW+LgeSOHBrbNj0yydXSA/qBFX9Hj7HzzhEkcKfUVQm+OKfrjlxT5Dc+RCB2
	1UsZYVmiK0UJJJE7eyiW4cmkUDlOgw31l9MKt7bEVoNoJBFU89biHkzqM2CZytBX
	aPo8SYJXcCpYESD2S+wDI2Fpb0hEPR3zugw==
X-ME-Sender: <xms:D32caBRFQnagUtJJHK5iOpzI9qNXs6Ykv8hlxV161fc3gigQHym5uQ>
    <xme:D32caIU9-9XeLdtwx97MHC1bxsQXem2eIZERGfhxbs5wujV6ExWuE4pls91jv8vQQ
    kv2ZO35Z2T5nZo>
X-ME-Received: <xmr:D32caNQdinCo79j6h-RYcSrrLupyCEBJ7On-yqBfo9tX9zhef8TlDxLtIJuHmfow5WNeoacY3mfBfDFOmnUUsd72r1I9dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhs
    tghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduie
    efudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprh
    gtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghmihhnhhho
    nhhgsehkhihlihhnohhsrdgtnhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihihuhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:D32caKn_v6BxpL9Zztoq_ZP2gNb0wJQsklYTuSyobGxvJmdl9aU4RA>
    <xmx:D32caL4Qi4H4mZudUOVqvyy4uY3HTHXAX7TcgegaWAZEYf8zrBK8NQ>
    <xmx:D32caIgwQ8BcfG19vgKCAwivYBFW3_NsMoRVZgDP5OF1_lJwaQOn8g>
    <xmx:D32caAHV_nWAmmS5Tf3_4ioy6fA0_DJW5cZdOeoEOXsNCZilgotfgA>
    <xmx:EH2caMhCibVmbYq-1uBJpWOBI2tRcOM_iEa_SS7F0ywkmIgbdIruQcpx>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 07:54:55 -0400 (EDT)
Date: Wed, 13 Aug 2025 14:54:52 +0300
From: Ido Schimmel <idosch@idosch.org>
To: heminhong <heminhong@kylinos.cn>
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2] ipv6: sr: validate HMAC algorithm ID in
 seg6_genl_sethmac
Message-ID: <aJx9DPI8dbRUtfGA@shredder>
References: <aJtHOuAc3BM3Aa9l@shredder>
 <20250813065737.112274-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813065737.112274-1-heminhong@kylinos.cn>

Given the Fixes tag, patch should be targeted at "net" and not
"net-next".

On Wed, Aug 13, 2025 at 02:57:37PM +0800, heminhong wrote:
> From: Minhong He <heminhong@kylinos.cn>
> 
> The seg6_genl_sethmac() directly uses the algorithm ID provided by the
> userspace without verifying whether it is an HMAC algorithm supported
> by the system.
> If an unsupported HMAC algorithm ID is configured, packets using SRv6 HMAC
> will be dropped during encapsulation or decapsulation.
> 
> Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")
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

Did you see my comment on v1 about fixing it entirely in seg6_hmac.c ?

If you want to perform the check in seg6_genl_sethmac(), then I would
instead expose a function like 'bool seg6_hmac_algo_is_valid(u8 alg_id)'
which internally calls __hmac_get_algo() rather than exposing
__hmac_get_algo().

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

