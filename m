Return-Path: <netdev+bounces-276588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O4/BXRx1ml2FQgAu9opvQ
	(envelope-from <netdev+bounces-276588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:17:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097D3BE106
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA82303D72A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7003D525B;
	Wed,  8 Apr 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtr5j7Yp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E653D47DE
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661030; cv=none; b=tyFBi8L+W1JJMScn88G0ME8fcH2M8FqpE+lkxApBsz0TOZbQuAmAOmc3gO62Cd7MbfLpGI65ILkvpWMMEWj5VrLrcbYV/HSvkRJRiz2y9Nzxs17fypR00cHbBG7Q9QKpOkLmCMIANXzSu+DeFFa9J6Ds51RphNeRuineWPsz30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661030; c=relaxed/simple;
	bh=vOpR3QprRCoCSUSNkfjF5VxENkiKE25FatWfq3c5xfI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jM3vmtd67Qz18FIDusnF2o08FEw4i5tsSSUgvTplxoHwHrbAKiF27OV6Ba9IHK8dzQ+Ed8TKZyLINKZtyAYlOjmbQJDD9tSMg7LgftfuhWlpPgnHYLKvCWdAzllbFvgAiBwCiHI+/M6/Z8K93YGMjhcrQtmu7lLmwFQtu8oaTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rtr5j7Yp; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79d991c7b6aso35897b3.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661028; x=1776265828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWIArzpyOOvfAEAf63T5ijzN/e9W9mTmg83yyPjlKNo=;
        b=Rtr5j7Ypk51ub5o1xrBiGukwtti9l4BH0sKzRygdmBLfTjxc0PMxVjgVtCPzCoFT3Z
         Ekw6YIabsynSFo4qw3+ijG63HzDmv8tvISZmUpmzhnWqqPqik5smnCYm1S7n2zCfY+Gr
         XwRF/+g0EMCPlzGkajo0dgubWZBlAFgHV4TcVHtJw861Q3RuYQRjnuUECpbDFKBkLA7k
         WRgUFMgGNQQBVOTR7jsDrC7cNRdaS61rZGs0u1E7meYlhzvqmbjz5q8MoymGHvphc+Af
         ltmEWw39ldh59HfiR9RoCXtxhaeYGGW3bvU3eqd7hGjNLiWurnhqD9ar0sltWsoZHb0p
         EuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661028; x=1776265828;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWIArzpyOOvfAEAf63T5ijzN/e9W9mTmg83yyPjlKNo=;
        b=Ze2yEN1M/u1SPccXyjpSXzhrfeMx59CFkTZqN+nHAQMPNbtRZ4ut+TMVtk2afzWmtc
         zWFb1mJZ2SekunyyrbhZSUUOL/isO/HZ7VKXfAcgqO60OaMYLf/AUDZhCjrYwFX4qE/P
         DEJohvX4yOaJyrJKi09aSWXlUui6b24Gd7gehbUiMmrY0m8Ig4616MKfJHcUAS6zClpG
         zOkB4WDhTOZihBajsN8zRjET2V1Azsw8z81UdEMah9JKCVJ6/rOJg0oSKr/slubVeVuY
         B/BXRvuZo0qSI9458V6lUBs9ZFSLTlQve9DZEaVQTZHYl973AFao2UDu2LOPa7h9b3II
         yW/w==
X-Forwarded-Encrypted: i=1; AJvYcCWbJMnI8OnjfjI381z1FKuvKnSB71ngQNGJQb2ToIlqeTMCuzeSLDMkOokjyWx17E5MD1BVL1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnCcCvU38hhD+PuYRhMrGiiV+C1CPQcUVLV7lb0W2B708+3JO
	e8Ji+GfRfGzeNCqo6YroE/oDHlXipxG0T+DYqQMxhn5wo/uJPXAMa1tr
X-Gm-Gg: AeBDievWrZ8IsbQco8URp6Y10muhS6geETluGoxd6J7851grQBBrCvaus62SlK+GGHS
	uWfvHqD/HCA0CcVD0h3YZk7CmP+/Wq9bhMsfNuSYzVjSGsb/eLMaJ8z/++PNUIQJjubYHQtRsH/
	KDGqJipYMXS/hlMhf64Vuaga66uUhPFMkW15dfGl216321TsOW9fkaKCRsm3erGpM9NkZwdy7Kg
	QuHbzRLUsnUZLSuGFRd5ZrD3M9q+JRIY3JSPD2Q+pDzdSJavq5p/ezxXjQm3ZlIonPf9fVcQR4U
	Cx5InEOzHsPq746uyAbg8XvrFQHnd8xWK5dC9Oyvo+BaRRebXoAYfBYJwEMf+wYfOMmL0eIpuLf
	h5g2TE8wFtTeeagc+vfWpumxwdodBCd1lQV4R1bafJzV5c0ZvBKIel0v/E55Z14UsWyxvm1fIRS
	cqkzJLtxUDMxMnNJU4C8Qdo+AxUSYRPV5QeZuNyKnGRDs0RpnUk0hClu/G9L8pvGv0BXAagvQb9
	xsf
X-Received: by 2002:a05:690c:88:b0:79f:d961:47d3 with SMTP id 00721157ae682-7a4d3ac7a52mr210788537b3.21.1775661028199;
        Wed, 08 Apr 2026 08:10:28 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff26sm89073237b3.9.2026.04.08.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:27 -0700 (PDT)
Date: Wed, 08 Apr 2026 11:10:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.245c592e6d270@gmail.com>
In-Reply-To: <20260407105005.1639815-6-nhudson@akamai.com>
References: <20260407105005.1639815-1-nhudson@akamai.com>
 <20260407105005.1639815-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276588-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 7097D3BE106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
> according to the decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}, and
>                                      SKB_GSO_TUNNEL_REMCSUM
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
> 
> When all tunnel-related GSO bits are cleared, also clear
> skb->encapsulation.
> 
> Handle the ESP inside a UDP tunnel case where encapsulation should remain
> set.
> 
> If UDP decap is performed and GSO state removed then reset encap_hdr_csum, and
> remcsum_offload.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f8d43420afb..04059d07d368 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3667,6 +3667,46 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>  
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM |
> +					 SKB_GSO_TUNNEL_REMCSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM |
> +					      SKB_GSO_TUNNEL_REMCSUM);

REMCSUM was previously not included in the series.

It is a non-obvious and rare enough feature that I would exclude it,
or move it to a separate patch.

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6 |
> +						  SKB_GSO_ESP)))
> +				if (skb->encapsulation)
> +					skb->encapsulation = 0;
> +
> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
> +				skb->encap_hdr_csum = !!(shinfo->gso_type & SKB_GSO_UDP_TUNNEL_CSUM);

Since the flag is never set, only possibly cleared: just clear this field when clearing the flag?

It appears that this is only used for deprecated UFO anyway.

> +				skb->remcsum_offload = !!(shinfo->gso_type & SKB_GSO_TUNNEL_REMCSUM);

Always zero?

