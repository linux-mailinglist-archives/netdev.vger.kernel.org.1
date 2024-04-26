Return-Path: <netdev+bounces-91821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC95C8B40D0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 22:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDF71C206AA
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFD7208CA;
	Fri, 26 Apr 2024 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWZn92fW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619E25619
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163337; cv=none; b=U6CCEjP/eL60BM1XXfOfxPFL6q8OGnb4kM8QTjT0Giast2kKzSDcU/16wQaOBoTknl/7S3c7B64NB5APTkTU3RCIDiJCDCQ8cJ4J4LVZ8KFZEZ3skWhXz0AxTmIDt6Ol+w2gM2lGt3cJ+aLO2frO6FesMVj2LqqPk4RnK4ahHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163337; c=relaxed/simple;
	bh=z5hC/HoyR1LOcof3xYI/9AVRa3HTGHJ5Tt/grQR8lWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCCLeJeuClD8hd4iJOrylrfqkYtdlXRH7A8Gri8n7WnUhOZLIqMl1wJZz2Z510eK6zr+eg3P/MsZIthp3b52QPArALrkrmvEPIv1FVozKSMotDCFmg1hxT6e9c/tVXm+nBvoe+OnnXeXMjSTMksacMS7p8K/PL8ghSQg6IDdhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWZn92fW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81986C113CD;
	Fri, 26 Apr 2024 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714163336;
	bh=z5hC/HoyR1LOcof3xYI/9AVRa3HTGHJ5Tt/grQR8lWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWZn92fWe0KWS5xyuKQueCVyrwpPfkkxZoUqBjCgEQV8AFGqgdQD59gnR2MkK4+mF
	 yXYXIs13/V+vHlHBYswPABXocuGXIa5wWGbvWrMgfR67hNobwRwvvc5kN8fgTNXPp3
	 nAH099ZkJHjGZTh9ion+KJZiRgP9lTbtE1Icm7wmF1u8J2mY0cnfYsi5dGw7MR5Ssl
	 X56OtqwuAILst1dw48HPT98RSvnAEJvfc5Aty7cjpSyFZgcmevUKigqlgq3wyJ6SQ8
	 /8BYVPF3/l2iwLWlCwZSS86FYwxAzrD20GDpMdDjBxln/E+ZWW6zrQv5ueC+oupwBH
	 RTdzZXura8+fQ==
Date: Fri, 26 Apr 2024 21:28:52 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 02/12] gtp: properly parse extension headers
Message-ID: <20240426202852.GD516117@kernel.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
 <20240425105138.1361098-3-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425105138.1361098-3-pablo@netfilter.org>

On Thu, Apr 25, 2024 at 12:51:28PM +0200, Pablo Neira Ayuso wrote:
> Currently GTP packets are dropped if the next extension field is set to
> non-zero value, but this are valid GTP packets.
> 
> TS 29.281 provides a longer header format, which is defined as struct
> gtp1_header_long. Such long header format is used if any of the S, PN, E
> flags is set.
> 
> This long header is 4 bytes longer than struct gtp1_header, plus
> variable length (optional) extension headers. The next extension header
> field is zero is no extension header is provided.
> 
> The extension header is composed of a length field which includes total
> number of 4 byte words including the extension header itself (1 byte),
> payload (variable length) and next type (1 byte). The extension header
> size and its payload is aligned to 4 bytes.
> 
> A GTP packet might come with a chain extensions headers, which makes it
> slightly cumbersome to parse because the extension next header field
> comes at the end of the extension header, and there is a need to check
> if this field becomes zero to stop the extension header parser.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  drivers/net/gtp.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/net/gtp.h |  5 +++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 4680cdf4fa70..9451c74c1a7d 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -567,6 +567,43 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
>  				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
>  }
>  
> +static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)
> +{
> +	struct gtp_ext_hdr *gtp_exthdr, _gtp_exthdr;
> +	unsigned int offset = *hdrlen;
> +	__u8 *next_type, _next_type;
> +
> +	/* From 29.060: "The Extension Header Length field specifies the length
> +	 * of the particular Extension header in 4 octets units."
> +	 *
> +	 * This length field includes length field size itself (1 byte),
> +	 * payload (variable length) and next type (1 byte). The extension
> +	 * header is aligned to to 4 bytes.
> +	 */
> +
> +	do {
> +		gtp_exthdr = skb_header_pointer(skb, offset, sizeof(gtp_exthdr),

Hi Pablo,

Should this be sizeof(*gtp_exthdr)?

And likewise, in the ip_version calculation in gtp_inner_proto()
in [PATCH 11/12] gtp: support for IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP 

Flagged by Coccinelle.

> +						&_gtp_exthdr);
> +		if (!gtp_exthdr || !gtp_exthdr->len)
> +			return -1;
> +
> +		offset += gtp_exthdr->len * 4;
> +
> +		/* From 29.060: "If no such Header follows, then the value of
> +		 * the Next Extension Header Type shall be 0."
> +		 */
> +		next_type = skb_header_pointer(skb, offset - 1,
> +					       sizeof(_next_type), &_next_type);
> +		if (!next_type)
> +			return -1;
> +
> +	} while (*next_type != 0);
> +
> +	*hdrlen = offset;
> +
> +	return 0;
> +}

...

