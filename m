Return-Path: <netdev+bounces-103564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4F908A6F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED161F21A60
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBD194C84;
	Fri, 14 Jun 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9KDp6n6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6167194C8F
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362183; cv=none; b=p9x3H3RNBs4Z5naJ0SiFkEmQn8E4onvDul0YPTe0gOk3IY+tqeJbP1hDoXnKYto22YMhRILT9mdHMdz+YU/rxDzYdZjq6DjYqgjkrWOz9HT7s7fwlozZnll59u0B+I/l5kyew9PI6Wfl2OULJLSnpQwLmiV84QwjrdWbamEuUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362183; c=relaxed/simple;
	bh=lz3gBvGKZGrjNrKMZMPEqqmXEgZ7hszVqmxYWCJ+w+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EMv84P/oE+1T+ICeH7DInrdQlX2ulA3v8aHk4Vuch41AMHfDpsSgD2ywYTQwTKUfYPUhSWCbn6KuNYiKP5yPlAp5TVXMUfdG0mk7RMYyvFQVDtMv7J6mr7lFV1dMdu/ExTIdSccTMBe2S6/Rf9GCxByOtkNkKYNElnRtocQvv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9KDp6n6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718362180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5+WkkywUcCHnTHUHiRM/u2JzTiYbc4RzqgsHk8W7jFU=;
	b=J9KDp6n6D9z4EiuHvhyRrrkywti6rSsBdAOL+dBPLXWknd61ja6DTtKD0vUQP0rdk1E8UM
	Yo1iLcKAAeZaQ/ruIugPBGsCweARq6ZegSLHpQOP1tD3NTqCUM+50zltt9FvWGfEn29SRt
	vrRqkgKZWxashFqBGj1Td2PBuCcJ1A0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-ducRil9aNRO69niAyAsoeg-1; Fri, 14 Jun 2024 06:49:39 -0400
X-MC-Unique: ducRil9aNRO69niAyAsoeg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57c9cd1f794so236197a12.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718362178; x=1718966978;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+WkkywUcCHnTHUHiRM/u2JzTiYbc4RzqgsHk8W7jFU=;
        b=Pfi/NydLdilTlejQ0q6CBwauogkbGxKuhgH1uZBw31HOi6cnCOed9T03hV15zmEv7E
         KWRqLPoIhmh20ov31iXkMKeOknzqANaEGs9jQ7RPa1UMSmJoTjsRwkTpNWnc8BZP475p
         91iuk5vjlbSEspjkz4daVB5QxdkP8kbb/LL2NoSBOD7fmnA0IrjOGv/TFQz956yTBTup
         qyJT0JC4CHSazK8ZV5q5Pz9vzR/YMGFOgfVagCsd1uVVP9Ofj2Bymr9w61ikBaPwW6D9
         H5qKCdyzMew4OyJT/tCsK2N9bzw0T0Bg3BVBNHTnHMi4ZdcsFVs86ZXADRtePPHfR2O+
         VPvA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EPN+FOM90eGvGOAUOWu9SCudgEIMteY5F6c1OOEd6kdJcL/njL0NAK1UI27UpWM/NSE3W8i7fKfWDLHwO7yypuGHbn1w
X-Gm-Message-State: AOJu0YwfIdN8iqwuVoK4ayuXcEQsQzaFEGO2lNqp/HyS53K0MiOE9tpC
	PqmQDHD5jwTqD1nIJtfv/EM93i8JDTSNu1sK3na/bThGwpu6BHnXCw2Q4gOdOKwNnKJtT38GaOD
	u6muk7kjJoJpv4FcE9Ewlw1pBuqY5MMeWoh6PF4MywdjOEIN1ORd2RItDVOVssw==
X-Received: by 2002:a17:906:b246:b0:a6f:5ff7:6e5b with SMTP id a640c23a62f3a-a6f60dc508emr120496466b.4.1718362177995;
        Fri, 14 Jun 2024 03:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rI5Lgl4ALkCM8dncnqnt8J3aS62Nq+khTGKDuWfnGLrjyEqVUvJu1pxs63emiMEy5Yoqkg==
X-Received: by 2002:a17:906:b246:b0:a6f:5ff7:6e5b with SMTP id a640c23a62f3a-a6f60dc508emr120495266b.4.1718362177420;
        Fri, 14 Jun 2024 03:49:37 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b083:7210:de1e:fd05:fa25:40db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5c8e2ef2sm134699366b.213.2024.06.14.03.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 03:49:36 -0700 (PDT)
Message-ID: <9cb5259943f767d8107df2f004e1d364f9a0076e.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 03/11] af_unix: Don't retry after
 unix_state_lock_nested() in unix_stream_connect().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	 <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Fri, 14 Jun 2024 12:49:35 +0200
In-Reply-To: <20240611222905.34695-4-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
	 <20240611222905.34695-4-kuniyu@amazon.com>
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

On Tue, 2024-06-11 at 15:28 -0700, Kuniyuki Iwashima wrote:
> When a SOCK_(STREAM|SEQPACKET) socket connect()s to another one, we need
> to lock the two sockets to check their states in unix_stream_connect().
>=20
> We use unix_state_lock() for the server and unix_state_lock_nested() for
> client with tricky sk->sk_state check to avoid deadlock.
>=20
> The possible deadlock scenario are the following:
>=20
>   1) Self connect()
>   2) Simultaneous connect()
>=20
> The former is simple, attempt to grab the same lock, and the latter is
> AB-BA deadlock.
>=20
> After the server's unix_state_lock(), we check the server socket's state,
> and if it's not TCP_LISTEN, connect() fails with -EINVAL.
>=20
> Then, we avoid the former deadlock by checking the client's state before
> unix_state_lock_nested().  If its state is not TCP_LISTEN, we can make
> sure that the client and the server are not identical based on the state.
>=20
> Also, the latter deadlock can be avoided in the same way.  Due to the
> server sk->sk_state requirement, AB-BA deadlock could happen only with
> TCP_LISTEN sockets.  So, if the client's state is TCP_LISTEN, we can
> give up the second lock to avoid the deadlock.
>=20
>   CPU 1                 CPU 2                  CPU 3
>   connect(A -> B)       connect(B -> A)        listen(A)
>   ---                   ---                    ---
>   unix_state_lock(B)
>   B->sk_state =3D=3D TCP_LISTEN
>   READ_ONCE(A->sk_state) =3D=3D TCP_CLOSE
>                             ^^^^^^^^^
>                             ok, will lock A    unix_state_lock(A)
>              .--------------'                  WRITE_ONCE(A->sk_state, TC=
P_LISTEN)
>              |                                 unix_state_unlock(A)
>              |
>              |          unix_state_lock(A)
>              |          A->sk_sk_state =3D=3D TCP_LISTEN
>              |          READ_ONCE(B->sk_state) =3D=3D TCP_LISTEN
>              v                                    ^^^^^^^^^^
>   unix_state_lock_nested(A)                       Don't lock B !!
>=20
> Currently, while checking the client's state, we also check if it's
> TCP_ESTABLISHED, but this is unlikely and can be checked after we know
> the state is not TCP_CLOSE.
>=20
> Moreover, if it happens after the second lock, we now jump to the restart
> label, but it's unlikely that the server is not found during the retry,
> so the jump is mostly to revist the client state check.
>=20
> Let's remove the retry logic and check the state against TCP_CLOSE first.
>=20
> Note that sk->sk_state does not change once it's changed from TCP_CLOSE,
> so READ_ONCE() is not needed in the second state read in the first check.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/unix/af_unix.c | 34 ++++++++--------------------------
>  1 file changed, 8 insertions(+), 26 deletions(-)
>=20
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index c09bf2b03582..a6dc8bb360ca 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1546,7 +1546,6 @@ static int unix_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
>  		goto out;
>  	}
> =20
> -	/* Latch state of peer */
>  	unix_state_lock(other);
> =20
>  	/* Apparently VFS overslept socket death. Retry. */
> @@ -1576,37 +1575,20 @@ static int unix_stream_connect(struct socket *soc=
k, struct sockaddr *uaddr,
>  		goto restart;
>  	}
> =20
> -	/* Latch our state.
> -
> -	   It is tricky place. We need to grab our state lock and cannot
> -	   drop lock on peer. It is dangerous because deadlock is
> -	   possible. Connect to self case and simultaneous
> -	   attempt to connect are eliminated by checking socket
> -	   state. other is TCP_LISTEN, if sk is TCP_LISTEN we
> -	   check this before attempt to grab lock.
> -
> -	   Well, and we have to recheck the state after socket locked.
> +	/* self connect and simultaneous connect are eliminated
> +	 * by rejecting TCP_LISTEN socket to avoid deadlock.
>  	 */
> -	switch (READ_ONCE(sk->sk_state)) {
> -	case TCP_CLOSE:
> -		/* This is ok... continue with connect */
> -		break;
> -	case TCP_ESTABLISHED:
> -		/* Socket is already connected */
> -		err =3D -EISCONN;
> -		goto out_unlock;
> -	default:
> -		err =3D -EINVAL;
> +	if (unlikely(READ_ONCE(sk->sk_state) !=3D TCP_CLOSE)) {
> +		err =3D sk->sk_state =3D=3D TCP_ESTABLISHED ? -EISCONN : -EINVAL;

I find the mixed READ_ONCE()/plain read confusing. What about using a
single READ_ONCE() caching the return value?

>  		goto out_unlock;
>  	}
> =20
>  	unix_state_lock_nested(sk, U_LOCK_SECOND);
> =20
> -	if (sk->sk_state !=3D TCP_CLOSE) {
> -		unix_state_unlock(sk);
> -		unix_state_unlock(other);
> -		sock_put(other);
> -		goto restart;
> +	if (unlikely(sk->sk_state !=3D TCP_CLOSE)) {
> +		err =3D sk->sk_state =3D=3D TCP_ESTABLISHED ? -EISCONN : -EINVAL;
> +		unix_state_lock(sk);

Should likely be:
		unix_state_unlock(sk)
?



Thanks!

Paolo


