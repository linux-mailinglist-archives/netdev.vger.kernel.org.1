Return-Path: <netdev+bounces-108223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A491E71B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225841F24F25
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7C15F40A;
	Mon,  1 Jul 2024 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izp3WqN4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013516EC06
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857166; cv=none; b=EuV761kw7dlWD3E7Ap2WPfpB8m016xnw3aiFk0Qcz+qMnSOQbdSU2qe797hdZPggseOgUnRA1o8FTfz2cYqwrScn+Eh6zyhNq90UOS0lwiHsO7Em1OPxTX0VyMKuRR8+gbQ8LqmPEwLk6E88Bm4gRPzyk9OtBokqN/Ivfrom4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857166; c=relaxed/simple;
	bh=/YyyPjhyPNu6/AYBPG4UFOqIDfskQ2W3tkiRGD3RunE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X8Umuj/d6oNVEFWXzGsRehCU23CimxoxfMwKIO9Hs73/6yNGXZyJBpx9IbHV34A9rpIJnX3Brh3kElu8qLy/Pm2DL78UURgH54yyahuKY4jwx4xj3rxKbx+X+c0AzHdRTqgPwK559IkqAPNm52bWe0V+C0NUF0eO8exH0x1Uok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Izp3WqN4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719857159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Wg0B6nxqEqPEWP3i9c7k0Iho5XVlEGFjVPJtv0Lhp8=;
	b=Izp3WqN4P/rZ0osqyVGlU/zI+ULXS70b8M5ZkHw7tAUDqpThcicXSpM2YWYRmFex1i3rT7
	dpO7HbXuR527YsK91NBxEI7q+iHV6W8vDO9KcWn4U/6Rbg1kzE/7l/8FV+LnBkjnlfZyKq
	kqPJm+uc2p3uriaq/xi6R8ET8GVnNQo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Tr9m5Y-9MiOFIoy79NmdGQ-1; Mon,
 01 Jul 2024 14:05:54 -0400
X-MC-Unique: Tr9m5Y-9MiOFIoy79NmdGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 964ED194510E;
	Mon,  1 Jul 2024 18:05:52 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ECD23000229;
	Mon,  1 Jul 2024 18:05:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Ido Schimmel
 <idosch@nvidia.com>,  Yotam Gigi <yotam.gi@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 01/10] net: psample: add user cookie
In-Reply-To: <20240630195740.1469727-2-amorenoz@redhat.com> (Adrian Moreno's
	message of "Sun, 30 Jun 2024 21:57:22 +0200")
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-2-amorenoz@redhat.com>
Date: Mon, 01 Jul 2024 14:05:46 -0400
Message-ID: <f7t34otxa11.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Adrian Moreno <amorenoz@redhat.com> writes:

> Add a user cookie to the sample metadata so that sample emitters can
> provide more contextual information to samples.
>
> If present, send the user cookie in a new attribute:
> PSAMPLE_ATTR_USER_COOKIE.
>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  include/net/psample.h        | 2 ++
>  include/uapi/linux/psample.h | 1 +
>  net/psample/psample.c        | 9 ++++++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/psample.h b/include/net/psample.h
> index 0509d2d6be67..2ac71260a546 100644
> --- a/include/net/psample.h
> +++ b/include/net/psample.h
> @@ -25,6 +25,8 @@ struct psample_metadata {
>  	   out_tc_occ_valid:1,
>  	   latency_valid:1,
>  	   unused:5;
> +	const u8 *user_cookie;
> +	u32 user_cookie_len;
>  };
>  
>  struct psample_group *psample_group_get(struct net *net, u32 group_num);
> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
> index e585db5bf2d2..e80637e1d97b 100644
> --- a/include/uapi/linux/psample.h
> +++ b/include/uapi/linux/psample.h
> @@ -19,6 +19,7 @@ enum {
>  	PSAMPLE_ATTR_LATENCY,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_PROTO,		/* u16 */
> +	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
>  
>  	__PSAMPLE_ATTR_MAX
>  };
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index a5d9b8446f77..b37488f426bc 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -386,7 +386,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  		   nla_total_size(sizeof(u32)) +	/* group_num */
>  		   nla_total_size(sizeof(u32)) +	/* seq */
>  		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
> -		   nla_total_size(sizeof(u16));		/* protocol */
> +		   nla_total_size(sizeof(u16)) +	/* protocol */
> +		   (md->user_cookie_len ?
> +		    nla_total_size(md->user_cookie_len) : 0); /* user cookie */
>  
>  #ifdef CONFIG_INET
>  	tun_info = skb_tunnel_info(skb);
> @@ -486,6 +488,11 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>  	}
>  #endif
>  
> +	if (md->user_cookie && md->user_cookie_len &&
> +	    nla_put(nl_skb, PSAMPLE_ATTR_USER_COOKIE, md->user_cookie_len,
> +		    md->user_cookie))
> +		goto error;
> +
>  	genlmsg_end(nl_skb, data);
>  	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>  				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);


