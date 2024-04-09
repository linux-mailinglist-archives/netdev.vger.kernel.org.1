Return-Path: <netdev+bounces-86053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5C189D623
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F7AB249EB
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D0D80604;
	Tue,  9 Apr 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPJd1uu5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3797F482
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656736; cv=none; b=WOPHNdJhQw7gspvg7hOOt3G2wdahDHqmWUPAqDCHHC5hQl5ZnWXfynRHQODZa0cg++HyYlPILhW/K9L5N3O6uYF7bwJQ54UjMKC789p7QSv/tVxSeVp7A9AAg/pT0P6kiPNzUoUUWJ8y9Nf/4mAE0EYqX6rvh516VZ2EL6jpZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656736; c=relaxed/simple;
	bh=vUR4p66RXngqZSeAcDLcnYuA/3PwSKeNiFVCX93F5Jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVoMOh5VVJcNNuqnhEQFXvsI0GhbgA2cvSo+HOMFJuU2zYKMDFkwg0gGIpkUB5KIMT7KAN3cFuoX9dvTmxqG/3kfIaEpY76M/w85HZHSX9mRc8UKs/nDipElV2dkyrKHeMEo/caFrXymi3SF9TjUfLx6fzMSMg4hBg+r265XfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPJd1uu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712656734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7zuE+xPAOM8zPOC5fNZH/amelC05Afkl7PPcHnnGjvc=;
	b=hPJd1uu5N2cpVwLZEhb1Eml7T7fXOctVDqSECUMpOn+Wm+zV2UuDyFpCfLVh9vpl4IpWih
	s+ExjoL2WUG8kRTByT5WtMTDPuZ8dYGN6VtRP8sXfwYTnLDDxuccPUbdzXOd6E1lKfmci4
	u4VWLjRjrJ+kIz3tdb7LWRrsZA/H6vw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-ah6b1FExPzy979WWCBRAjw-1; Tue, 09 Apr 2024 05:58:52 -0400
X-MC-Unique: ah6b1FExPzy979WWCBRAjw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343edd4ac01so846014f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 02:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656731; x=1713261531;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zuE+xPAOM8zPOC5fNZH/amelC05Afkl7PPcHnnGjvc=;
        b=hKCuN9DNi+5PX8D512wLkoQ8+uwmB37+vnpRmOL0jF2jye7XHM62/EuhU/vYB4H7+e
         qEGgHajofLI5abH1hrhxcyd4/krZJX24Rh3sY/2PSLFbiwlhY5ZfxG1RAQbOfBC18Ee0
         bbsODkSy4ErkH/U5jKB4SHNJQCQKoRtaipZ80LTuxfYwKPO8v7gZbc3TTEq3SxZ4n2y4
         igW+XEHXr261dBz2x4rgo8d3RO1XlwNm0/Bc0UQ/dMwCKSwBJ5YKRmg2wBxJGtndP3Tj
         oNKZGYe8IhxvVp187WTrnfCR3Ux/jXjVoiFf93ms30SVFOMF58TaDleaPMhF2tapWCsD
         xYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUNH8zUSiJKgAZvhW3swbGGGtLu7BpsiwFUYBqj689PzLxuJA1Fo0qoszodQMRQqoVeRa2mkKCHXqt+t9Ip8uZWZ0FFHVtE
X-Gm-Message-State: AOJu0YzxcNe3noEZ0DS1DCK5BtHCNxE9Ltb+Pc+O2YzetPRyRURM9nxT
	7EasPVA96qvrZyYYzoYP8LYBRUrMiuQUuD3gpuhar3ml+wnUm/vsIQ8yqtz/GHWT+vxyrc4JqMd
	XAAyZxKVv2TOSxwqu90WFfUrZOTlfW9CdWbEgEoCKsQYNStdPIkCNCg==
X-Received: by 2002:a05:600c:1c94:b0:416:7470:43c4 with SMTP id k20-20020a05600c1c9400b00416747043c4mr3442297wms.2.1712656731555;
        Tue, 09 Apr 2024 02:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGguZu5+2YV4hQJdjSsJOxAYF1eNjysTYQmqBgVOnL+56jb/H7pnwmyQBzcifA5koV0nmlw4A==
X-Received: by 2002:a05:600c:1c94:b0:416:7470:43c4 with SMTP id k20-20020a05600c1c9400b00416747043c4mr3442286wms.2.1712656731203;
        Tue, 09 Apr 2024 02:58:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-144.dyn.eolo.it. [146.241.244.144])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b004169df54d19sm2763336wmr.28.2024.04.09.02.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:58:50 -0700 (PDT)
Message-ID: <68085c8a84538cacaac991415e4ccc72f45e76c2.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn
 with a per-cpu field
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Date: Tue, 09 Apr 2024 11:58:49 +0200
In-Reply-To: <20240407093322.3172088-3-edumazet@google.com>
References: <20240407093322.3172088-1-edumazet@google.com>
	 <20240407093322.3172088-3-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-07 at 09:33 +0000, Eric Dumazet wrote:
> TCP can transform a TIMEWAIT socket into a SYN_RECV one from
> a SYN packet, and the ISN of the SYNACK packet is normally
> generated using TIMEWAIT tw_snd_nxt :
>=20
> tcp_timewait_state_process()
> ...
>     u32 isn =3D tcptw->tw_snd_nxt + 65535 + 2;
>     if (isn =3D=3D 0)
>         isn++;
>     TCP_SKB_CB(skb)->tcp_tw_isn =3D isn;
>     return TCP_TW_SYN;
>=20
> This SYN packet also bypasses normal checks against listen queue
> being full or not.
>=20
> tcp_conn_request()
> ...
>        __u32 isn =3D TCP_SKB_CB(skb)->tcp_tw_isn;
> ...
>         /* TW buckets are converted to open requests without
>          * limitations, they conserve resources and peer is
>          * evidently real one.
>          */
>         if ((syncookies =3D=3D 2 || inet_csk_reqsk_queue_is_full(sk)) && =
!isn) {
>                 want_cookie =3D tcp_syn_flood_action(sk, rsk_ops->slab_na=
me);
>                 if (!want_cookie)
>                         goto drop;
>         }
>=20
> This was using TCP_SKB_CB(skb)->tcp_tw_isn field in skb.
>=20
> Unfortunately this field has been accidentally cleared
> after the call to tcp_timewait_state_process() returning
> TCP_TW_SYN.
>=20
> Using a field in TCP_SKB_CB(skb) for a temporary state
> is overkill.
>=20
> Switch instead to a per-cpu variable.

I guess that pushing the info via a local variable all the way down to
tcp_conn_request would be cumbersome, and will prevent the fast path
optimization, right?

> As a bonus, we do not have to clear tcp_tw_isn in TCP receive
> fast path.
> It is temporarily set then cleared only in the TCP_TW_SYN dance.
>=20
> Fixes: 4ad19de8774e ("net: tcp6: fix double call of tcp_v6_fill_cb()")
> Fixes: eeea10b83a13 ("tcp: add tcp_v4_fill_cb()/tcp_v4_restore_cb()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

[...]

> @@ -2397,6 +2397,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  			sk =3D sk2;
>  			tcp_v4_restore_cb(skb);
>  			refcounted =3D false;
> +			__this_cpu_write(tcp_tw_isn, isn);
>  			goto process;

Unrelated from this patch, but I think the 'process' label could be
moved down skipping a couple of conditionals. 'sk' is a listener
socket, checking for TW or SYN_RECV should not be needed, right?

Thanks!

Paolo


