Return-Path: <netdev+bounces-51272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7D17F9ED4
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DF728148D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC41A706;
	Mon, 27 Nov 2023 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNI5gvkR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D1C0
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701085326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgfHvbnKvtVzSiQZSRNSSQTDRqwdBucSl/vL2ksBJaM=;
	b=KNI5gvkRs+EzcwQSOQ8s7bnlvQqoXpPriYlVwTHabTxuhof0hqzYtPZ+YWEp95DqgN52FI
	fzd0IzG3lrOZES5Vt4XGu1MTfNsU0vDYLLEblHL7CVKFIZUNSBcP5HIrm/B4ZP5RvIbXFw
	oXt0S75WgTw6A/v5EH80xt8qQCCswqg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-nPiTHW-nODSOmq03EFl5RA-1; Mon, 27 Nov 2023 06:42:04 -0500
X-MC-Unique: nPiTHW-nODSOmq03EFl5RA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cfd5971eb3so1877015ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 03:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701085324; x=1701690124;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgfHvbnKvtVzSiQZSRNSSQTDRqwdBucSl/vL2ksBJaM=;
        b=CW9hgMYPGFs9Ka0ldKz/oJbhhTAhG5KtssJKJUVEcZhRFKgVky8YT6nR9rssqdob0z
         VO7aWLqpSyLYIx+8FRUL2XM3rfd4joCkuRiKHjEeeb8AGQf657+H43ObuFLSJNO2K80X
         MXsm2VlhxXNXwMDBe/I3qosmYJtbMB7CUh3/BNxawe9c0e+ONmy20iDGx+tJslDIJb1f
         zC2R/j7xiraxxxcfUiGH2cGZCFfkLNh0kefxMbIrzps3UnST396x+EiYOhcoDkRe5cN9
         TMgZbqdPU1UocrS0yr1JDYhfB4crcZEHObdrcEm1SNIkh8+AkpO5TlCNbfOaJYf3SGc6
         jYew==
X-Gm-Message-State: AOJu0YwhwVul/byk8bwVnVchrdsWBea7MhAUfzBQoGaLFqHx3SMtua2n
	CJXLt2VqYwVP09Q/r3bFe+b8/W1Rp2QhrvGskvTYTW4uu0sQ08gVjwIfPA82amE+K4U9FFmb4aP
	hEZrfk15lUix9efG3
X-Received: by 2002:a17:903:32c7:b0:1cf:c37f:7164 with SMTP id i7-20020a17090332c700b001cfc37f7164mr5897667plr.4.1701085323838;
        Mon, 27 Nov 2023 03:42:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlvrpl5W2JC7dHM3k+IROnuhVGVxKpSiKgXaIaPdXpbCl6ks6O8Zu38IyXekLY0o5MwrUB1A==
X-Received: by 2002:a17:903:32c7:b0:1cf:c37f:7164 with SMTP id i7-20020a17090332c700b001cfc37f7164mr5897645plr.4.1701085323480;
        Mon, 27 Nov 2023 03:42:03 -0800 (PST)
Received: from gerbillo.redhat.com (host-87-11-7-253.retail.telecomitalia.it. [87.11.7.253])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902700200b001cfd5a59c73sm1192456plk.38.2023.11.27.03.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 03:42:03 -0800 (PST)
Message-ID: <1c769b1a72c5a7f6e19010dfccc78b2502484cf3.camel@redhat.com>
Subject: Re: [PATCH v2 6/7] net/tcp: Add sne_lock to access SNEs
From: Paolo Abeni <pabeni@redhat.com>
To: Dmitry Safonov <dima@arista.com>, David Ahern <dsahern@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
 Francesco Ruggeri <fruggeri05@gmail.com>, Salam Noureddine
 <noureddine@arista.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
Date: Mon, 27 Nov 2023 12:41:57 +0100
In-Reply-To: <20231124002720.102537-7-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
	 <20231124002720.102537-7-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-24 at 00:27 +0000, Dmitry Safonov wrote:
> RFC 5925 (6.2):
> > TCP-AO emulates a 64-bit sequence number space by inferring when to
> > increment the high-order 32-bit portion (the SNE) based on
> > transitions in the low-order portion (the TCP sequence number).
>=20
> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> Unfortunately, reading two 4-bytes pointers can't be performed
> atomically (without synchronization).
>=20
> Let's keep it KISS and add an rwlock - that shouldn't create much
> contention as SNE are updated every 4Gb of traffic and the atomic region
> is quite small.
>=20
> Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/net/tcp_ao.h |  2 +-
>  net/ipv4/tcp_ao.c    | 34 +++++++++++++++++++++-------------
>  net/ipv4/tcp_input.c | 16 ++++++++++++++--
>  3 files changed, 36 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 647781080613..beea3e6b39e2 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -123,6 +123,7 @@ struct tcp_ao_info {
>  	 */
>  	u32			snd_sne;
>  	u32			rcv_sne;
> +	rwlock_t		sne_lock;

RW lock are problematic in the networking code, see commit
dbca1596bbb08318f5e3b3b99f8ca0a0d3830a65.

I think you can use a plain spinlock here, as both read and write
appears to be in the fastpath (?!?)

> @@ -781,8 +780,10 @@ int tcp_ao_prepare_reset(const struct sock *sk, stru=
ct sk_buff *skb,
>  		*traffic_key =3D snd_other_key(*key);
>  		rnext_key =3D READ_ONCE(ao_info->rnext_key);
>  		*keyid =3D rnext_key->rcvid;
> -		*sne =3D tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
> -					  snd_basis, seq);
> +		read_lock_irqsave(&ao_info->sne_lock, flags);
> +		*sne =3D tcp_ao_compute_sne(ao_info->snd_sne,
> +					  READ_ONCE(*snd_basis), seq);
> +		read_unlock_irqrestore(&ao_info->sne_lock, flags);

Why are you using the irqsave variant? bh should suffice.

Cheers,

Paolo


