Return-Path: <netdev+bounces-132574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB2992269
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 02:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29DD1F21E43
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82B1859;
	Mon,  7 Oct 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ0X+HmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F3800;
	Mon,  7 Oct 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728259825; cv=none; b=YJdCgGk7Q1wv42nFbIzZb3DTS6aH7msfJdHPHBWUrDtNU69aO4Vi9SamklJLygIKhM6pbg6ZX7xgc8kapeYuPU1kK5nc0vv74+8euSxh2S6Fv5rCM9QThKJWRJgFhGAT24hDG8V1PHkzyZx3HxH4B1+E2ZKnK8Btc4RVqz1dJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728259825; c=relaxed/simple;
	bh=fg021ep1byjw4tWhEaB88P+vmjFuA5wTZOIdd6/FVo0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=e5GidSyy3y1CH1Zl3RrCrKKscg15eMcwveT12dEd2rLPmDv+wlnWDiSrDXF5PDBMp5arRd0C4M3jlfhWaHI7AdZTDKIXh+tnX0rEUDukHjpjcJ0Sc9eODf/yiKSpiWGDvV6eR6pMYyZERw0ed7wGUccMwgq/OHx81svSvGD95xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ0X+HmQ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a99e4417c3so324762385a.1;
        Sun, 06 Oct 2024 17:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728259823; x=1728864623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhhWHH0miwXsKsyLxNCHn9I5FF0NznVLiuppVDG9nLg=;
        b=PJ0X+HmQcoGuuFJkfwdbtLPeGDx2gPHd3zRX7aoc0QeLOJ0xoOr8HAfzIfxECQVG4f
         Qz/a2Yw49w/mhaHCNwek3Okj9vm9wKmn+fA9nokDRymhfXGzAkSxKboKyRNQlMdGK8JK
         CNp+K8dZr7jDUEYKTW0pPa1TFQxtOeirI/OPziEy1P2wpUeyVZ3amlWR2lGg3F762xtb
         dOBF7qEgm9m4qJx1beHSnklKturM+wGCoIf+/BXPRnbKxJgDU5uHo0+idSgAJ8c9UKoy
         Sctctg5ACo29n+UYI/CZV0T+ueLAfViHQgqeajGP6QvfS3V/m5bQDgarHNrJKdvWIaKF
         J8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728259823; x=1728864623;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fhhWHH0miwXsKsyLxNCHn9I5FF0NznVLiuppVDG9nLg=;
        b=ZPHl+deU2ouHF4HYSGqXOI5kzPuV2RMqKxHtbgGp5LlYmkrdhJRBXQjm8NnE/1dc5z
         cZL10/12l7xfN7nVsRQtsk56QGIDjbtm1OTP3wQnpuOR6TBPFoyDn+GHiZt9q8pOI+AS
         qiqofLyEwCH5t6csIPQXDTZk1PIL2SmWqnwxXr59JgRxoKFU0pi9aRTqDMSlt2bgknoo
         3FWzyV7ESln5xv32t5eg80ndXTsO+JGX2h6Fl4n7hlo33lnoCV0STJvLZwpSRWJ+jNQe
         Y6RJtXxO6PC6LHM8Dyr4Tdx8/Oy3GFVLYpy4MUWLSR1gb+YLpyFf1wTmI0QjphhdVk5k
         ccnA==
X-Forwarded-Encrypted: i=1; AJvYcCVRaLZXiopassHAi/qo7OIEVSxOJO6TEzAHdWycFCCihIF076PQhv2DLaY1khA5zq6og4K/NDl8fMauYr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG25jnzYTsoIpoGn4qnrqjF6UEoiP3xxBpq2uNfwEDRS4fejcN
	PJ7P8GUTVtBdvXh6P8tROMPn06h9fopJguxO/ueS90vSYssqUkts
X-Google-Smtp-Source: AGHT+IEsjpDQVCDTk8XErSaRe1YyX91Rh7iqvh8hhpE7VQm7mvMlqQozxbNWde3vOvT2pcQyx7O00Q==
X-Received: by 2002:a05:620a:25ce:b0:7a9:9ec7:63d1 with SMTP id af79cd13be357-7ae6f437564mr1638620085a.18.1728259822689;
        Sun, 06 Oct 2024 17:10:22 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75615955sm204597985a.19.2024.10.06.17.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 17:10:21 -0700 (PDT)
Date: Sun, 06 Oct 2024 20:10:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>
Message-ID: <670326ed8220a_135479294d1@willemb.c.googlers.com.notmuch>
In-Reply-To: <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
References: <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
Subject: Re: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Beno=C3=AEt Monin wrote:
> Devices with NETIF_F_IP_CSUM capability can checksum TCP and UDP over
> IPv4 with an IP header that may contains options; whereas devices with
> NETIF_F_IPV6_CSUM capability can only checksum TCP and UDP over IPv6 if=

> the IP header does not contains extension.

Are both these statements universally true across devices?

I can believe for NETIF_F_IP_CSUM that this is the definition, and
that devices that cannot handle options must fix it up indivually in
ndo_features_check.

And same for NETIF_F_IPV6_CSUM with extension headers.

But it would be good to see where this is asserted in the code, or
examples of drivers that have to perform such actions.

> Enforce that in skb_csum_hwoffload_help by checking the network header
> length in the case where the IP header version is 6. We cannot simply
> rely on the network header length since the IPv4 header can from 20 to
> 60 bytes whereas the IPv6 header must be 40 bytes. So we check the
> version field which is common to IPv4 and IPv6 headers.
> =

> This fixes checksumming errors seen with ip6_tunnel and fou6
> encapsulation, for example with GRE-in-UDP over IPv6:
> * fou6 adds a UDP header with a partial checksum if the inner packet
> does not contains a valid checksum.

Where in the code is this conditional on the inner packet csum?

> * ip6_tunnel adds an IPv6 header with a destination option extension
> header if encap_limit is non-zero (the default value is 4).


If this is a fix, we'll need to target net and best effort find a
suitable fixes tag.
 =

> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> ---
>  net/core/dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/net/core/dev.c b/net/core/dev.c
> index ea5fbcd133ae..199831d86ec1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  		return 0;
> =

>  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> +		if (ip_hdr(skb)->version =3D=3D 6 &&
> +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> +			goto sw_checksum;
>  		switch (skb->csum_offset) {
>  		case offsetof(struct tcphdr, check):
>  		case offsetof(struct udphdr, check):
> @@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  		}
>  	}
> =

> +sw_checksum:
>  	return skb_checksum_help(skb);
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);



