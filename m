Return-Path: <netdev+bounces-207846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF39B08C8D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08EE7A886E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7F29DB97;
	Thu, 17 Jul 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YqFTEXi9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3429DB8E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754288; cv=none; b=sVxTv2g+egQhAQ6m1NngYmovRWmVjFT1n0UCaWDrYwFc2Gb2kynsPBVCHq7/bL5fAmPKIsB9+dExNdyoep9wiq9emSuxA//mdHJH7sKrhpPYpYr/qNAVZBcZqwIQBLL2Zk8WcU65H6H1j67xsJbPBhYw4Afm7elk9Agy5RHnwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754288; c=relaxed/simple;
	bh=P8vk5Hgw1tgxUgUlGpEEfcEnINzDHJTtnJgc36ojQPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jw08QcmpUHQXkIBSloakRmwhmfDyJjDMTicwNPaDhSD6/Uv+kIMY1l4YA/dH8MUYgCnSX3W1gYwztqbKBGQIH5vE7HSq7DuJCIUutBmvqkOcpVooX+mpd8dQZKxZwDXMhvWv1XKJiiZcIbpcZkldWrlSlINpPL6kIT+lAO3NulA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YqFTEXi9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad572ba1347so127573366b.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752754285; x=1753359085; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OKtnDxQN1rQvgUExQEfgNocGu+aFrd+PlVCR98yHgE=;
        b=YqFTEXi9NAioggDzwMmOxhXF0esWRaJQp+X1D+N2LPEXYvu9GqKzZk7bUEvUCTtOod
         ynH8hRlTzFZYjizI6fW3wwHrAKfG97UpbSiPMF0PeqNbh/pt755++LAEs7UnaaQg19eM
         NoJpZzfLWmogNw00UlOUSxf2U+Je1zkF45GBnQo1axme5ZD9e8y7QdErJRhQf9uv0Pmj
         KWLR8BDtueSEv5lGDy0pfnV7ftkg2Ej9jIFifIUKo+dDjXTEs1JjAmqTp2F93B5xDOpQ
         eOLr1wDZn8s1SwnYiYviJsEd+697LnDBCa1Yb1uXncQxGyu3bEp50AGlkRe48ztysmZ3
         3T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752754285; x=1753359085;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OKtnDxQN1rQvgUExQEfgNocGu+aFrd+PlVCR98yHgE=;
        b=rNOeR+5woJtmKqP5D9f/aivIGf9SN9b1ynkMADpqOYEUhI4E0lbqOjiBCCDOFMfnXL
         f9S3lnnVEgdpT7EeKBU6FWCUoo8xbfhT+rc/rd9v75lKE1SXHAyaVtNQAPI1CT1d4aMD
         kUbB9kzl2ojn3/te0jBGgrrB2TcKoUwvVGiXikdqLxEgw3nMYBIuECARU2So4E8wX+Q4
         bU6KZjw3OmvUzT/E96w4CLOmsbUNiGzcLqI4eRwA/S0cQBOvgVDPfEJ29/TJUyDsnHbC
         A5LCmAYcAgA4JYbj/OR0HlcP3tj7Qa3ey8v2Qfupkkojz+nhmnClM7urLfo+BlxI6LS1
         accQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzoBK9mVGAkIYSD0qHbEOik0Nnh2PWPe5LjQTTnD8lkmxrJJzEwoAdCxChrf5lt9PHrPZO5QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg6FLNBiheaJENERYZ2Am1SJD4ibiXttWtmPWmY5nS2jCL9Wy
	ghuz0f1PwkEAdzKkxn7wqdvMlE3IOoHWA7sQZvWdZfJTrBBbWQy+n3VospjwAmHXFg8=
X-Gm-Gg: ASbGncvXRG5s/eHAeezYQD8ZYaUMYVExNLrDs5VHVEZriVNLnDjA2vDLhkLRS4NP8Gr
	RHDC5arYpBZdep/xWa5t1NsHKGsmu4+FtMTNwVHMURJunTUcecA1pbGS4A3KqiwWuztJpvtSqB/
	Eym7Xlfzn6SuSKPGO4FdcIbJ3YAYwXuWAa++VvKazv65g1tW+rvTIbPsikrVlAGsY8yanWwkDPv
	13S92GGsMtykEkpnzz914xFh4gD+QHYW84zf0Pqyy3oR/6BH+6VvGn6mqW0HYXe3Q+hiOBeddtO
	AjgW6zwJNONYobJeXguSBlIZsV+9CEkDVPMVeFwN1FUQzdw48+jst+4rOkov8H1dK3Mz+aoFDWN
	xe1vryxlxTzoTGLs=
X-Google-Smtp-Source: AGHT+IEQBx5AReVAmevU1wjvhgFcUY3uymJWzKp1I9F2AG1oQKieVEeU4QVXRXuh/1fjL6QehswnJA==
X-Received: by 2002:a17:907:b1a:b0:ae3:cc60:8cf0 with SMTP id a640c23a62f3a-ae9ce0b938cmr429270066b.34.1752754284873;
        Thu, 17 Jul 2025 05:11:24 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee48f6sm1372348366b.55.2025.07.17.05.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:11:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  Jakub Kicinski
 <kuba@kernel.org>,  lorenzo@kernel.org,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <borkmann@iogearbox.net>,  Eric Dumazet
 <eric.dumazet@gmail.com>,  "David S. Miller" <davem@davemloft.net>,  Paolo
 Abeni <pabeni@redhat.com>,  sdf@fomichev.me,  kernel-team@cloudflare.com,
  arthur@arthurfabre.com
Subject: Re: [PATCH bpf-next V2 5/7] net: veth: Read xdp metadata from
 rx_meta struct if available
In-Reply-To: <175146832628.1421237.12409230319726025813.stgit@firesoul>
	(Jesper Dangaard Brouer's message of "Wed, 02 Jul 2025 16:58:46
	+0200")
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
	<175146832628.1421237.12409230319726025813.stgit@firesoul>
Date: Thu, 17 Jul 2025 14:11:21 +0200
Message-ID: <87a553dnkm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 02, 2025 at 04:58 PM +02, Jesper Dangaard Brouer wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Report xdp_rx_meta info if available in xdp_buff struct in
> xdp_metadata_ops callbacks for veth driver
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/veth.c |   12 +++++++++++
>  include/net/xdp.h  |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)

[...]

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 3d1a9711fe82..2b495feedfb0 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -158,6 +158,23 @@ static __always_inline bool xdp_buff_has_valid_meta_area(struct xdp_buff *xdp)
>  	return !!(xdp->flags & XDP_FLAGS_META_AREA);
>  }
>  
> +static __always_inline bool
> +xdp_buff_has_rx_meta_hash(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_META_RX_HASH);
> +}
> +
> +static __always_inline bool
> +xdp_buff_has_rx_meta_vlan(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_META_RX_VLAN);
> +}
> +
> +static __always_inline bool xdp_buff_has_rx_meta_ts(const struct xdp_buff *xdp)
> +{
> +	return !!(xdp->flags & XDP_FLAGS_META_RX_TS);
> +}
> +
>  static __always_inline void
>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
>  {

Nit: Why not have one set of generic helpers (macros) for checking if
the flags are set? If you want strict type checking, you can
additionally use _Generic type dispatch.

[...]

