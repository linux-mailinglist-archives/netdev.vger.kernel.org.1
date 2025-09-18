Return-Path: <netdev+bounces-224222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE01FB82720
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EE34A2919
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2511386C9;
	Thu, 18 Sep 2025 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCkaMBJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66C2D023
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156744; cv=none; b=lPWI2AQ0Gld9dSHxLofJ9TrraVAAy9Gjoez8ldED2HY46AU2EfOhz/119rliC02t9MvR1+xDhShE/1W/JDTVa96Xccd0LBCObiMLHHVrzWYpTbGrEgAbnVS4LrvDO/ZpjS3ndRIqn2gEd0kfMaaf6/L6Uo31/s4QnnVeXAZ9fUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156744; c=relaxed/simple;
	bh=jXrD0GXja0Lm3Lw3thdNtsHfNVThEO7c5zpe5BVTGFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8q7rqJtqoHd6l6RG2GBRq765Y6s5Q2FoBboaYK3T3lk8R/8LXIYHNDKPp8CNCum9mfy8syKW+ouHytQSHLMsbSXB2vpMlGRf7OzjLZdc9qrxx15v+3d4hInyIZv4oLacqM8y9NJkeyBAC+x8RPb96eQNtPvD+eY3xVK4rW4LuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCkaMBJj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7762021c574so447595b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156742; x=1758761542; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yxv7uLRKATc0Q07our50qKqXbkjD8v5tzWWZDxiVATo=;
        b=YCkaMBJj5IZp/KaQBfXIKMeTQRJ6QULPr1uwZuFKc8SwTfG+A1k0R6K7TPxRGaD1of
         eUJ3A7LDeCsCq0wxkUUpPAki4d4+VqWlImS/NX1rWIXTLhVTQ8n1MzPq5gqEQIHpTZ3a
         krjt2Ty2aOlEfXVOhBYi3wWHFdxJYhfcVOfwU0mm0Bd97qJv4SBq1rU9m2zM7zXat7Ei
         Y7GTpiqZsLkGBx6QQ86dzo+CJx8sI+9O+S6gNl3sMkLfVtgM7kSwR++tpQCAhQLaAfAS
         MY3B3bJCk+CwFayjjoH+z1gfGJOGFoZ9YqEfIWaj0WxZw4NiSXyIPaM/RhnGcvJSNY8d
         IrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156742; x=1758761542;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yxv7uLRKATc0Q07our50qKqXbkjD8v5tzWWZDxiVATo=;
        b=iiS76W8LgxO16eBVYVxAwZw7adPtxrKmcaLPzUxlXrlfhV0Sh9xBoWQmCfIzcairRE
         v2MBCrsZ7wU9olvua/dDQ/u5z4QbxiGfUvP+dq/5UojouGXRwPfgGrWmEXW9lY+wN4WY
         AdqOmygi+nxIV98wotcoO5/Gu/EOcnAc0fg4J/oiAIjXaEFDkEIDua9ygXFeTQRe5/jb
         Et6wH3/krKG/awAlnPWyyZ/eD2EoKzgCa55vFPqlu/3bpMyOjKdKl2w1Vr2TwmOImFJx
         iW0ZulfWUxxawv2rE0cyfifdAHQgyl9zv6tRfPHdUr7+18CgbSVICdjM2FLi1IGPLATA
         CueQ==
X-Forwarded-Encrypted: i=1; AJvYcCU98mZVfp7OD/hvLpXBlAn9/fkn3YQZySWTvgaWd1WG2aNCr99UH+TEbJneoYQ9j4Ombn45ivM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLtQkQO8PCdW6rB+G8JlS1y1MBiV5xpqRsex+JIZhcoNz4fFEm
	XZSwQrEy8TuECWM5VcYx/77QfjmdvKWrj6TedKzEppQczuAiKm0Nle41
X-Gm-Gg: ASbGncuyqfvvlLKyvKHfP4dsDew7xAdJNfb8lgU5aBen3DuXT1UOGeyUkHzmLooQ8Lf
	bpqGMytGXn7qHho+WLJzfJkgritq3D0vjqRl1cZMxET9gRNNVzR1tbezeCvCgA6KIQvdgXh06OR
	TG2YZ8DMCiDx/NndRPz75ka6WLw9Qfo0MgB8BI48ZiC3F35N27ZNnKKMQBiKGmDYL4ULP5q1vQJ
	HbAoWIW9uiASzeO82cC3yqgS0GDmeHkitVUZsP5Dj0AHcS1BIJ9bzpX8XdhK2fqGUSbWi4/IOV1
	ObCu399GRtu+OSSEq+R4YK/ElRmZwPFN7Nbl2K2VYOwmZWftnm/fgULKOL+JtyQ59cCNCcNwzE1
	95pp3TnLymP+NGpPdebqvrOl9xq6+aWBzQ5zS7uc6w3bocb3pPpF7lbPw
X-Google-Smtp-Source: AGHT+IGXmmHPEnY6H6+5F3iPmqIk0vAxTrpXRFEvnkjQcLB0Mhgn7u+aK1yYyWHFr/7bekRJ625OwA==
X-Received: by 2002:a05:6a00:2d9d:b0:772:4d52:ce5a with SMTP id d2e1a72fcca58-77bf926aa20mr4335425b3a.26.1758156741707;
        Wed, 17 Sep 2025 17:52:21 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe66916csm594713b3a.51.2025.09.17.17.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:52:21 -0700 (PDT)
Message-ID: <05dc7efdb45363358825ff3782d3006ef9c6cea4.camel@gmail.com>
Subject: Re: [PATCH v3] net/tls: support maximum record size limit
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, 	horms@kernel.org, corbet@lwn.net,
 john.fastabend@gmail.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alistair.francis@wdc.com, dlemoal@kernel.org
Date: Thu, 18 Sep 2025 10:52:14 +1000
In-Reply-To: <aLgVCGbq0b6PJXbY@krikkit>
References: <20250903014756.247106-2-wilfred.opensource@gmail.com>
	 <aLgVCGbq0b6PJXbY@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Sabrina,

Sorry for the delay in getting back to this! Responded inline.

On Wed, 2025-09-03 at 12:14 +0200, Sabrina Dubroca wrote:
> note: since this is a new feature, the subject prefix should be
> "[PATCH net-next vN]" (ie add "net-next", the target tree for "new
> feature" changes)
>=20
> 2025-09-03, 11:47:57 +1000, Wilfred Mallawa wrote:
> > diff --git a/Documentation/networking/tls.rst
> > b/Documentation/networking/tls.rst
> > index 36cc7afc2527..0232df902320 100644
> > --- a/Documentation/networking/tls.rst
> > +++ b/Documentation/networking/tls.rst
> > @@ -280,6 +280,13 @@ If the record decrypted turns out to had been
> > padded or is not a data
> > =C2=A0record it will be decrypted again into a kernel buffer without
> > zero copy.
> > =C2=A0Such events are counted in the ``TlsDecryptRetry`` statistic.
> > =C2=A0
> > +TLS_TX_RECORD_SIZE_LIM
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +During a TLS handshake, an endpoint may use the record size limit
> > extension
> > +to specify a maximum record size. This allows enforcing the
> > specified record
> > +size limit, such that outgoing records do not exceed the limit
> > specified.
>=20
> Maybe worth adding a reference to the RFC that defines this
> extension?
> I'm not sure if that would be helpful to readers of this doc or not.
Good idea, I'll add that in.
>=20
>=20
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index a3ccb3135e51..94237c97f062 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> [...]
> > @@ -1022,6 +1075,7 @@ static int tls_init(struct sock *sk)
> > =C2=A0
> > =C2=A0	ctx->tx_conf =3D TLS_BASE;
> > =C2=A0	ctx->rx_conf =3D TLS_BASE;
> > +	ctx->tx_record_size_limit =3D TLS_MAX_PAYLOAD_SIZE;
> > =C2=A0	update_sk_prot(sk, ctx);
> > =C2=A0out:
> > =C2=A0	write_unlock_bh(&sk->sk_callback_lock);
> > @@ -1065,7 +1119,7 @@ static u16 tls_user_config(struct tls_context
> > *ctx, bool tx)
> > =C2=A0
> > =C2=A0static int tls_get_info(struct sock *sk, struct sk_buff *skb, boo=
l
> > net_admin)
> > =C2=A0{
> > -	u16 version, cipher_type;
> > +	u16 version, cipher_type, tx_record_size_limit;
> > =C2=A0	struct tls_context *ctx;
> > =C2=A0	struct nlattr *start;
> > =C2=A0	int err;
> > @@ -1110,7 +1164,13 @@ static int tls_get_info(struct sock *sk,
> > struct sk_buff *skb, bool net_admin)
> > =C2=A0		if (err)
> > =C2=A0			goto nla_failure;
> > =C2=A0	}
> > -
> > +	tx_record_size_limit =3D ctx->tx_record_size_limit;
> > +	if (tx_record_size_limit) {
>=20
> You probably meant to update that to:
>=20
> =C2=A0=C2=A0=C2=A0 tx_record_size_limit !=3D TLS_MAX_PAYLOAD_SIZE
>=20
> Otherwise, now that the default is TLS_MAX_PAYLOAD_SIZE, it will
> always be exported - which is not wrong either. So I'd either update
> the conditional so that the attribute is only exported for non-
> default
> sizes (like in v2), or drop the if() and always export it.
>=20
Yeah, that makes sense I'll drop the If() so that it's always exported
then.
> > +		err =3D nla_put_u16(skb,
> > TLS_INFO_TX_RECORD_SIZE_LIM,
> > +				=C2=A0 tx_record_size_limit);
> > +		if (err)
> > +			goto nla_failure;
> > +	}
>=20
> [...]
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index bac65d0d4e3e..28fb796573d1 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -1079,7 +1079,7 @@ static int tls_sw_sendmsg_locked(struct sock
> > *sk, struct msghdr *msg,
> > =C2=A0		orig_size =3D msg_pl->sg.size;
> > =C2=A0		full_record =3D false;
> > =C2=A0		try_to_copy =3D msg_data_left(msg);
> > -		record_room =3D TLS_MAX_PAYLOAD_SIZE - msg_pl-
> > >sg.size;
> > +		record_room =3D tls_ctx->tx_record_size_limit -
> > msg_pl->sg.size;
>=20
> If we entered tls_sw_sendmsg_locked with an existing open record,
> this
> could end up being negative and confuse the rest of the code.
>=20
> =C2=A0=C2=A0=C2=A0 send(MSG_MORE) returns with an open record of length l=
en1
> =C2=A0=C2=A0=C2=A0 setsockopt(TLS_INFO_TX_RECORD_SIZE_LIM, limit < len1)
> =C2=A0=C2=A0=C2=A0 send() -> record_room < 0
>=20
>=20
> Possibly not a problem with a "well-behaved" userspace, but we can't
> rely on that.
Good catch! what if we don't allow tx_record_size_limit to be set if
there's a pending open record. This should avoid userspace from atleast
causing the record_room < 0 if we somehow end up there.

So for example:

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7c0367dc5d40..34bb6690016c 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -841,20 +841,27 @@ static int
do_tls_setsockopt_tx_record_size(struct sock *sk, sockptr_t optval,
                                            unsigned int optlen)
 {
        struct tls_context *ctx =3D tls_get_ctx(sk);
+       struct tls_sw_context_tx *sw_ctx =3D tls_sw_ctx_tx(ctx);
        u16 value;
=20
+       if (sw_ctx->open_rec)
+               return -EBUSY;
...

And to your follow up response:

```
> I suspect it's not a problem in practice because of what the TLS
> exchange between the peers setting up this extension looks like? (ie,
> there should never be an open record at this stage - unless userspace
> delays doing this setsockopt after getting the message from the peer,
> but then maybe we can call that a buggy userspace)
```

Yeah, record size limit extension occurs during a handshake
(Client/ServerHello). AFAIK, all of that is handled in tlshd/GnuTLS. We
shouldn't have any open records here at this point. For user-space
context, this is what support for record size limit looks like [1] in
tlshd.

If for whatever reason, as you mentioned, userspace decides to set it
later, change above could mitigate it for the open record case? I don't
think we need to try to fix things (or even can for records already
submitted to TCP) in the kernel.

[1]
WIP:https://github.com/twilfredo/ktls-utils/commit/73cb755acb4589ba31e4c42e=
f6b16cf5efdf3892
>=20
>=20
> Pushing out the pending "too big" record at the time we set
> tx_record_size_limit would likely make the peer close the connection
> (because it's already told us to limit our TX size), so I guess we'd
> have to split the pending record into tx_record_size_limit chunks
> before we start processing the new message (either directly at
> setsockopt(TLS_INFO_TX_RECORD_SIZE_LIM) time, or the next send/etc
> call). The final push during socket closing, and maybe some more
> codepaths that deal with ctx->open_rec, would also have to do that.
>=20
> I think additional selftests for
> =C2=A0=C2=A0=C2=A0 send(MSG_MORE), TLS_INFO_TX_RECORD_SIZE_LIM, send
> and
> =C2=A0=C2=A0=C2=A0 send(MSG_MORE), TLS_INFO_TX_RECORD_SIZE_LIM, close
> verifying the received record sizes would make sense, since it's a
> bit
> tricky to get that right.
Yeah I agree, I will work on that. Thanks for the feedback!

Regards,
Wilfred

