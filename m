Return-Path: <netdev+bounces-160836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A0A1BBB4
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9848D7A5873
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979251D88D1;
	Fri, 24 Jan 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmiVc2WN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D601CBEAC
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740890; cv=none; b=s23m52cKCWbZ+E37t4Fpi8BR4BZt6J5Gqwg5TKRl0oNQ5IWMa8dM9ZjRGPitYOjsg1RXa1kZJlMtnvlagPlPSl2ShdzBZvLlYlcaGax7PQTlz4Pi9pXnHnISiaOzcFVb1IR3GyJcFa+RDToiTkDhobt2DEB2jU4/EnBLS2xrmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740890; c=relaxed/simple;
	bh=gkm5y7aae+2ucwPpf8Utov/jdQcDhYBCU2hnVFlsUdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIIrsNJFfLEduezreXDzFcOVl9C0jy/17ApVao78LCKMCsQMQqcih4SekSYssLzjATNHv9/qqaiXdEboC4pWFmhe3wC8e9Z1Mw2GQ6EVpHBHp1TlAkk6L3qPTkl/OrhZz3PW/udMi22y1FXjWzQ+fOCcR8GJoyd9P12bQKlZ0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmiVc2WN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737740887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwya/8RIFzLnwAhL9mA8dgTzVgYp1fYNxJooV1rQcjA=;
	b=YmiVc2WNPDBL8a0EIU+FDwdCyckwlL+W06m54RhWS4e99y8iGM9Pf1KJU4doevp/cW3oAm
	UTeTeepDvrk5DDGYgndIH18maprt5/ldx4dt80a/aXsQQhvxHP13hJF79okr4f7m9UQe66
	aL6ZhdZTZzYS0tfY19mntOdLGZuq9Z4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-B28uwN1POU6LykErDHT-cg-1; Fri, 24 Jan 2025 12:48:06 -0500
X-MC-Unique: B28uwN1POU6LykErDHT-cg-1
X-Mimecast-MFC-AGG-ID: B28uwN1POU6LykErDHT-cg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso2358362a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 09:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740885; x=1738345685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwya/8RIFzLnwAhL9mA8dgTzVgYp1fYNxJooV1rQcjA=;
        b=WjZacdhk8yHgBFuZg8S42/kTpG0TcSbse5clFvbMjvB8XrhXRK5kaNB/Fufn4w1ok/
         Z4fDahhadU6YlOV7VQApBlSl/PnDYI9eitU2AyatM4Sf+uyvz6N1fXHKo03XycGoD/Ju
         quPKRcUN4lY+I9kWk9wdhfQ8FrsueZv0LbMNOUAMzKA75AH101keCVG7lvqMr6tOIURm
         FeIXLQ/q3utdkV18NAVZJ8/VNO06sBRQ29WrSy4Ikp31zJioKWoQFifHBIdAEf5gDCV4
         7dWA7z/RCF0Wsv9kPbi/7DJ25FLpXxCjuAMNhXj7Id49c/BmO7gYeDcYhk6uLTAnQV8w
         jJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCX2twGXLs6RqfK2Uivwf8Lk+BrfY9pK7TfXTz6bUfiEB0YCkwYzkInOE00kG0fqmqMvQUYHqYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUIbgdCQUyS0fhjwLfsNA2/rHUdSrL111NzPvMlffi3bGxFqX
	2KPtdF7cALk+PpE8So7K2xgViLoH8Ghx/9VLcgv2BfIGd69jItEJvOyrdzAkqfFBQCg6pAzVKwz
	X4F5JVtuNTX3S7CPVKU+KT3d+gwk80DGFkWECT1xmEkZKthv7r30eRrfETjGX5dOv4gbRb8Hd96
	29RAIr2yboEygbbB7F1Nr3qxDACXR1
X-Gm-Gg: ASbGncv7ksS/RGu0KcwJsTE9hdSrBFCLEtO6OPyqFgVfoj5fv7oBQqbKpdpxIDfIrvn
	tvOtqLdk2Efw06GmdKL7HzASlURm2E6aHf3CyZmVWmrpPP6W1DSac4u1Pt83YdMS/lBoN3+SpLo
	pKZFZX+R9mjw==
X-Received: by 2002:a05:6402:13d2:b0:5da:d76:7b3f with SMTP id 4fb4d7f45d1cf-5db7d0f8663mr29732556a12.0.1737740885049;
        Fri, 24 Jan 2025 09:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyw7AoxkgXA00n0FXen38xf32uLtg66kp091LA3qIP5GlJSe5KzGAVq1vPcPh4ZZOBj2vgcqUSbkJ0Vf6ZddY=
X-Received: by 2002:a05:6402:13d2:b0:5da:d76:7b3f with SMTP id
 4fb4d7f45d1cf-5db7d0f8663mr29732539a12.0.1737740884651; Fri, 24 Jan 2025
 09:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-nfsd-6-14-v1-0-c1137a4fa2ae@kernel.org>
 <20250123-nfsd-6-14-v1-3-c1137a4fa2ae@kernel.org> <a95521d2-18a2-48d2-b770-6db25bca5cab@oracle.com>
 <4f89125253d82233b5b14c6e0c4fd7565b1824e0.camel@kernel.org>
 <Z5OdECjsie-MCFel@poldevia.fieldses.org> <CACSpFtB9yjDpKc_0QrNS2sHN9qFsVQQLvL7ALmG1OE1W+Wivtg@mail.gmail.com>
In-Reply-To: <CACSpFtB9yjDpKc_0QrNS2sHN9qFsVQQLvL7ALmG1OE1W+Wivtg@mail.gmail.com>
From: Olga Kornievskaia <okorniev@redhat.com>
Date: Fri, 24 Jan 2025 12:47:53 -0500
X-Gm-Features: AWEUYZlM7c0qsjokNJKJJdbWN10PGM35b5wTDYszNcMjfphtDMroIqWAxDWy6Ds
Message-ID: <CACSpFtA4hqoLW4_u5dxb+XxmKH1On0=OSvzMdovmimz75KzdXQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] nfsd: when CB_SEQUENCE gets NFS4ERR_DELAY, release
 the slot
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Kinglong Mee <kinglongmee@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 12:45=E2=80=AFPM Olga Kornievskaia <okorniev@redhat=
.com> wrote:
>
> On Fri, Jan 24, 2025 at 9:08=E2=80=AFAM J. Bruce Fields <bfields@fieldses=
.org> wrote:
> >
> > On Thu, Jan 23, 2025 at 06:20:08PM -0500, Jeff Layton wrote:
> > > On Thu, 2025-01-23 at 17:18 -0500, Chuck Lever wrote:
> > > > On 1/23/25 3:25 PM, Jeff Layton wrote:
> > > > > RFC8881, 15.1.1.3 says this about NFS4ERR_DELAY:
> > > > >
> > > > > "For any of a number of reasons, the replier could not process th=
is
> > > > >   operation in what was deemed a reasonable time. The client shou=
ld wait
> > > > >   and then try the request with a new slot and sequence value."
> > > >
> > > > A little farther down, Section 15.1.1.3 says this:
> > > >
> > > > "If NFS4ERR_DELAY is returned on a SEQUENCE operation, the request =
is
> > > >   retried in full with the SEQUENCE operation containing the same s=
lot
> > > >   and sequence values."
> > > >
> > > > And:
> > > >
> > > > "If NFS4ERR_DELAY is returned on an operation other than the first =
in
> > > >   the request, the request when retried MUST contain a SEQUENCE ope=
ration
> > > >   that is different than the original one, with either the slot ID =
or the
> > > >   sequence value different from that in the original request."
> > > >
> > > > My impression is that the slot needs to be held and used again only=
 if
> > > > the server responded with NFS4ERR_DELAY on the SEQUENCE operation. =
If
> > > > the NFS4ERR_DELAY was the status of the 2nd or later operation in t=
he
> > > > COMPOUND, then yes, a different slot, or the same slot with a bumpe=
d
> > > > sequence number, must be used.
> > > >
> > > > The current code in nfsd4_cb_sequence_done() appears to be correct =
in
> > > > this regard.
> > > >
> > >
> > > Ok! I stand corrected. We should be able to just drop this patch, but
> > > some of the later patches may need some trivial merge conflicts fixed
> > > up.
> > >
> > > Any idea why SEQUENCE is different in this regard?
> >
> > Isn't DELAY on SEQUENCE an indication that the operation is still in
> > progress?  The difference between retrying the same slot or not is
> > whether you're asking the server again for the result of the previous
> > operation, or whether you're asking it to perform a new one.
> >
> > If you get DELAY on a later op and then keep retrying with the same
> > seqid/slot then I'd expect you to get stuck in an infinite loop getting
> > a DELAY response out of the reply cache.
>
> If the client would keep re-using the same seqid for the operation it
> got a DELAY on then it would be a broken client. When the linux client
> gets ERR_DELAY, it retries the operation but it increments the seqid.

Urgh I stand corrected this is on the SEQUENCE not an operation.
>
> >
> > --b.
> >
> >
> > > This rule seems a
> > > bit arbitrary. If the response is NFS4ERR_DELAY, then why would it
> > > matter which slot you use when retransmitting? The responder is just
> > > saying "go away and come back later".
> > >
> > > What if the responder repeatedly returns NFS4ERR_DELAY (maybe because
> > > it's under resource pressure), and also shrinks the slot table in the
> > > meantime? It seems like that might put the requestor in an untenable
> > > position.
> > >
> > > Maybe we should lobby to get this changed in the spec?
> > >
> > > >
> > > > > This is CB_SEQUENCE, but I believe the same rule applies. Release=
 the
> > > > > slot before submitting the delayed RPC.
> > > > >
> > > > > Fixes: 7ba6cad6c88f ("nfsd: New helper nfsd4_cb_sequence_done() f=
or processing more cb errors")
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >   fs/nfsd/nfs4callback.c | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > index bfc9de1fcb67b4f05ed2f7a28038cd8290809c17..c26ccb9485b95499f=
c908833a384d741e966a8db 100644
> > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > @@ -1392,6 +1392,7 @@ static bool nfsd4_cb_sequence_done(struct r=
pc_task *task, struct nfsd4_callback
> > > > >                   goto need_restart;
> > > > >           case -NFS4ERR_DELAY:
> > > > >                   cb->cb_seq_status =3D 1;
> > > > > +         nfsd41_cb_release_slot(cb);
> > > > >                   if (!rpc_restart_call(task))
> > > > >                           goto out;
> > > > >
> > > > >
> > > >
> > > >
> > >
> > > --
> > > Jeff Layton <jlayton@kernel.org>
> >


