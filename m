Return-Path: <netdev+bounces-186479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F15A9F579
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5973BEE48
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57A27A916;
	Mon, 28 Apr 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTt7ggte"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508A26FA75;
	Mon, 28 Apr 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857036; cv=none; b=tZexM8WKC/YRfMvzTPUMZK0LOS96uyjQn7Rvnn6m030lTDeMpEaMVn3jypvCqp2AqlqqbRhS3dhlCXMdlayeHDRncEZnpTBnoBXN2J75tdgWXc1h8jbM4bZTRH8VXxdUIUgRQxXeOoxblEtyX2F/0BNrVPhXylo/LKiw76Mfg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857036; c=relaxed/simple;
	bh=smtAkwkKGL4pz7JirGODi4I7qmws05BLdagkvECz3yU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uIw487N+0S82XzEMf3fROa57AM1TmS68D9K6B+bcnVACJpKhVIWFY167vMjJPyh8FVHSS7paM2wTvKpfftl+YbNmT3seugfeFYuoigbfGHK2YKSUBQtr30Gzh3gJyxGI5imbGrFArz8Xs3lWGVnHeIqZLMDkiOzUNBKOHv1fM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTt7ggte; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47677b77725so64715091cf.3;
        Mon, 28 Apr 2025 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745857034; x=1746461834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULQRpv1NjsBQK88YiSUNUqXdXU+PuBF6RG1mBP+jTS4=;
        b=mTt7ggte+u0XWsfag5oHGcJeEp7pvSeR2kxBz5NZ/bH0aSh2Zv+X5JBWzqcTw7LziG
         AAZLS8XElgAChwEZlF7toL0y56JhcSXd+9mjY9CswsbOUuTFeTpg1WSa4NPzkt0thO/C
         z6Ux2BA4QlN0U4wPNawbvxWKa8uCxhn5yKC82gRw8colq2OPsKX5LimsRh9OQe7RIJnI
         LFNzJSZrxyztjxUuNUYVAxq5Ejrc7SfsobJnkomeJdjnEKORYHJRKkfxl4SWXlbrGEYW
         1H/mECm+Ig2DQ9dNnC0sfln/iw9RoyEpEecvey6llGtzucOHgsGF/Y+1jQWQuka2I5X2
         rKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857034; x=1746461834;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULQRpv1NjsBQK88YiSUNUqXdXU+PuBF6RG1mBP+jTS4=;
        b=FuEmxzcDZUnK+pt5y3chJkJ3bveJTPyLq7Ve9UrWHKgnP9/xS6KAqKXZDV4z531izS
         Loq1TBLPuHSeeSAO9tnBlg68DNtuBecm5ZscE7LOsgHI3wVEr3JvjOO1yaaq06JaseSH
         ZBwt31MF3RzMz11LaUvY8EYMzlO/CPsmOHHvH6eirUblnaUtfQn5vCL0drldeUAahyP7
         9mgAUZtbVHAwsyfaiHfXGm1FtfluWN68549V71y8+8/ilRzfMvWJa0A2DTDJe4PBKM74
         /IL9fW0iKr7oRVawSCzrpbneYeiyuB/GP4p/nWCoKeF8LTbwvIoPSwaU0B076+z6YcIa
         eEWA==
X-Forwarded-Encrypted: i=1; AJvYcCVJyUijHAxyMZJEV1GPcDym34+qH33yPjbjjcev8x+g2vhu2GovOXYdTZZZOq2g/BVKMT0W/Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPo+1XO7+26oQ4XGK9kPoENy5LnpRU/ipTML+AhlPzQezL5MQ
	CZ3AdW6YNIhUNgQYtuVkqDuUqXHCKybYqSgToBsxy004Lou5xJzZ2BRX6w==
X-Gm-Gg: ASbGncvSCTEvFjiX3AxGZZgycu0QQYmTz8bkEYk8mk/tCBrSgwE/E8KOX440S5JRInt
	pBHdFtK7aN2X7CUcHqL9we8I+cIGznihCAatsDd9wmbsdaik2Hy1zqA+gOpGoYAuORahK4maBlj
	Omn3PYPuWOpVG67dn9YwaKZ6+iysw8gdlH01DTIwZ7IVZPYEQC6rmqSGcrGi1A3F5ZYa2FWJ+Qt
	xby6M0NQJ8D3QH4+BvzoyInjvdr1XHxAPqPwZbM4OC4Is+DmdyfOKOSRHONcgKstw5xWupoiyNE
	b94PfcUsy/SpT87QK7V47GG09g/BX9GfxCuZpcmJDN+kz14pCzKx/YVAHCcUXpyYoSd7WJlDy8j
	CWX2Rsj0BeK3udX73vJ05
X-Google-Smtp-Source: AGHT+IHjCa5N/2jvOCmGNWAVcaatEwZ7bYOXfdQFYukG472HngLmvE+FZLIw62Qiw1pnw5U18T4N4g==
X-Received: by 2002:a05:6214:2469:b0:6eb:2fd4:30bd with SMTP id 6a1803df08f44-6f4f0613b55mr5483426d6.30.1745857033550;
        Mon, 28 Apr 2025 09:17:13 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c5d919adsm57066036d6.22.2025.04.28.09.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:17:12 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:17:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <680faa08829e9_23f8812941f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250426153210.14044-1-nbd@nbd.name>
References: <20250426153210.14044-1-nbd@nbd.name>
Subject: Re: [PATCH net] net: ipv6: fix UDPv6 GSO segmentation with NAT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> If any address or port is changed, update it in all packets and recalculate
> checksum.
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Willem de Bruijn <willemb@google.com>

This is the IPv6 equivalent to commit c3df39ac9b0e ("udp: ipv4:
manipulate network header of NATed UDP GRO fraglist"). Not sure why
IPv6 was missed at the time.

> ---
>  net/ipv4/udp_offload.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 2c0725583be3..9a8142ccbabe 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -247,6 +247,62 @@ static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs)
>  	return segs;
>  }
>  
> +static void __udpv6_gso_segment_csum(struct sk_buff *seg,
> +				     struct in6_addr *oldip,
> +				     const struct in6_addr *newip,
> +				     __be16 *oldport, __be16 newport)
> +{
> +	struct udphdr *uh = udp_hdr(seg);
> +
> +	if (ipv6_addr_equal(oldip, newip) && *oldport == newport)
> +		return;
> +
> +	if (uh->check) {
> +		inet_proto_csum_replace16(&uh->check, seg, oldip->s6_addr32,
> +					  newip->s6_addr32, true);
> +
> +		inet_proto_csum_replace2(&uh->check, seg, *oldport, newport,
> +					 false);
> +		if (!uh->check)
> +			uh->check = CSUM_MANGLED_0;
> +	}
> +
> +	*oldip = *newip;
> +	*oldport = newport;
> +}
> +
> +static struct sk_buff *__udpv6_gso_segment_list_csum(struct sk_buff *segs)
> +{
> +	const struct ipv6hdr *iph;
> +	const struct udphdr *uh;
> +	struct ipv6hdr *iph2;
> +	struct sk_buff *seg;
> +	struct udphdr *uh2;
> +
> +	seg = segs;
> +	uh = udp_hdr(seg);
> +	iph = ipv6_hdr(seg);
> +	uh2 = udp_hdr(seg->next);
> +	iph2 = ipv6_hdr(seg->next);
> +
> +	if (!(*(const u32 *)&uh->source ^ *(const u32 *)&uh2->source) &&

only if respin: this could be a simpler equality test?

