Return-Path: <netdev+bounces-253587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBJzEVzFd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5D8CC3E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78ECA30055C4
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5403B28725F;
	Mon, 26 Jan 2026 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y96vKt+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82552882AA
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456983; cv=none; b=b6xt1KjnWEw3Gag+9AhVHzeHpKRCfNrr4IUYpadHUhsoHgZ9krU+iH+Rnqaqf+XVI5F8l1+eQEpWmv3pIjwxWfJiSlZISCtsJC98LuEN9cESoL5gvfgwHPRPWQvdOpcoDN0q2s4DzJW1KJ0C+1ladPlqemSjwCqeV4V6FB5Wl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456983; c=relaxed/simple;
	bh=Ew0wil3rS4MqDg53VyMtrRBkkpZ592JhyvoxrBM5REI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bo1hquzK50HwxorNXmpxSUjDwJDd2MWO4YVhQJc0JvRUhp3DhIfDPsnhpnXqVDAnMfTiGPZkk6LEhpAkomD3u/CL+YYCKQ9rXJn5l29FNzr4iA53wOdWhz9TtUVV5c0U2Et7IT8uqPhCltoj2o2B0uC1V5ypq6BNNZ6+SmXYdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y96vKt+N; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so47404771cf.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769456981; x=1770061781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DkhtEYlu1cxCF+r3Na88j9n+YMNLVAzK55vGoP2wzQ=;
        b=Y96vKt+NNvpVdXre3Laz6OFtS78rjBVnYoiPH5hGOxDjG9eqIFqCXSxOnuKZGKoYw7
         CQSsaB/DATeLOE3JeRfqA6HARn7JJIvxyd8KhLOUw7kOEYuW4UEccjWFntYbnYBq8zLy
         oa2IgOsmgoemwZ/Wp79/ACZlOwXF60GGHJYxBhXnlsUywWmIurGp8uTvWtJ95QM1NAzo
         cCR7m/Metqljv5wPqDb6+xhxpFpRHA8hs1JCfxhu6RgfOJbI1EmdaM5n/h0VLJe/jdaq
         2rhZIS8mL59YBige1ckjK40FdqhKau4dh/1WktoAp+3ap4r63ksvs6L94WpfN5KXIT1d
         d0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456981; x=1770061781;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DkhtEYlu1cxCF+r3Na88j9n+YMNLVAzK55vGoP2wzQ=;
        b=OQEA9fp91HWMrpuANNhF4KOp8vv19viRrVh6qtS0J4KkSvdGLN4SHlj1oHfAMjCMq9
         j2vzSLwwBqx8nYOZd1ltRv83s3zRqNfziK0tpmLVgZM0Dw8jbMVdaKbZiNR8n0o1eWTJ
         vYiytbcnjlXt8fhvbzyxN4ZX5I0Uzy6Dfiqdi7kBRD0LGlzyuijIyCtAHGfTj5vRuKkh
         prCSrKxoEud9XlvU4xSuUtUPhJuF4+wuEGUclz4ecrUsitJkQLFVtHOj1W04hTuxMcC/
         7i6dBSfU1reGEWgL6azZ8G8CeIUVUWeYgCb0EckhueDWnQN5SGqoNX0wJOwnQl/G3W3z
         nrQA==
X-Forwarded-Encrypted: i=1; AJvYcCUaWCmpEyjytKOqXTM6XZuFF5RRXEDaa3l1aeocR96jUcuZD3nN2DzGXYfdpIpLfoPaaVDkTAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHOOgKOEO/ytuB73lLquiSorujiozjNEFcgMIs7myJqMkTVqk
	RO8xB0v0mTPAw1+zKzy17b1o+8LqevP34PjvoH3MaRIy/ElRcGiKh/pxS2hCLg==
X-Gm-Gg: AZuq6aJngXsOv9qdE0Tw8Qf3shOizw8Gwchx808vVWKRf5nUlmG87Ai1rHK0sjhraXC
	dl/tdOYn9ADM/WWwxuDek1S8lIv2LjLPmIa0MDwh/iz29a6ru6K6u0UoQgpDi1zpA7yQ5BRxTny
	AV2TY2HkMxQXUsMuATB/y8ASO0rgvaNmtT8FO78FNHYvgCyGGmwHw83Poi/NU1XgMIMKFFgLsdV
	qDv0V5AbXhnaZaYqt5GyruuT3JkteihOI84aHc6X39dVr+LUZIPoFr6xqGE+nNFBbjzaqpSgrZg
	F8IEuHzqKrFq3lahVdeaPYT50llZ/bh3IxvFo7y3rpCna6S0bSdAckrfI2uxdBdzKpPWMGxkyJv
	1wSnvo0Ey6uc1GAM62dub7mkYpl1cfkphI5t8IUFbLaAGP6hxDrZ/WKYshBny37iGARMVd2Mur+
	bFSrA1ukyWzfhedLm6SymqvlMfUZos8SYkoRbTQtMPLAt55tdcvxigrC4gdjc=
X-Received: by 2002:a05:690e:1503:b0:649:51d8:6f72 with SMTP id 956f58d0204a3-64970b45682mr4014192d50.5.1769450012509;
        Mon, 26 Jan 2026 09:53:32 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6495cfde5ccsm5560600d50.24.2026.01.26.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:53:32 -0800 (PST)
Date: Mon, 26 Jan 2026 12:53:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Igor Russkikh <irusskikh@marvell.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 linux-rdma@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Message-ID: <willemdebruijn.kernel.218d53621fba7@gmail.com>
In-Reply-To: <20260125121649.778086-2-gal@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
 <20260125121649.778086-2-gal@nvidia.com>
Subject: Re: [PATCH net-next 1/3] udp: gso: Use single MSS length in UDP
 header for GSO_PARTIAL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253587-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 6CD5D8CC3E
X-Rspamd-Action: no action

Gal Pressman wrote:
> In GSO_PARTIAL segmentation, set the UDP length field to the single
> segment size (gso_size + UDP header) instead of the large MSS size.
> This provides hardware with a template length value for final
> segmentation, similar to how tunnel GSO_PARTIAL handles outer headers
> in UDP tunnels.
> 
> This will remove the need to manually adjust the UDP header length in
> the drivers, as can be seen in subsequent patches.
> 
> This was suggested by Alex in 2018:
> https://lore.kernel.org/netdev/CAKgT0UcdnUWgr3KQ=RnLKigokkiUuYefmL-ePpDvJOBNpKScFA@mail.gmail.com/
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This only affects the udp header value when using GSO_PARTIAL, and
these are the only two drivers that adversize USO using GSO_PARTIAL.

> ---
>  net/ipv4/udp_offload.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 19d0b5b09ffa..89e0b48b60ae 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -483,11 +483,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  	struct sock *sk = gso_skb->sk;
>  	unsigned int sum_truesize = 0;
>  	struct sk_buff *segs, *seg;
> +	__be16 newlen, msslen;
>  	struct udphdr *uh;
>  	unsigned int mss;
>  	bool copy_dtor;
>  	__sum16 check;
> -	__be16 newlen;
>  	int ret = 0;
>  
>  	mss = skb_shinfo(gso_skb)->gso_size;
> @@ -555,6 +555,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		return segs;
>  	}
>  
> +	msslen = htons(sizeof(*uh) + mss);
> +
>  	/* GSO partial and frag_list segmentation only requires splitting
>  	 * the frame into an MSS multiple and possibly a remainder, both
>  	 * cases return a GSO skb. So update the mss now.
> @@ -584,7 +586,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>  		if (!seg->next)
>  			break;
>  
> -		uh->len = newlen;
> +		uh->len = msslen;
>  		uh->check = check;
>  
>  		if (seg->ip_summed == CHECKSUM_PARTIAL)
> -- 
> 2.40.1
> 



