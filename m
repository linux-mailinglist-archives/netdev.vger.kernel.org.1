Return-Path: <netdev+bounces-238273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E7C56D0C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3BBE4ECCF3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA52E975F;
	Thu, 13 Nov 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ90IUcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F0299A87
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029215; cv=none; b=E5jpjDBDvVwxoDZTEt9C4TkbSoP0GM+Be3Loo1iwPgHnE9wvsQQTnRaQ4TCJLO0FMI477QQZp+vNQsdlfp1sikGLqcTmc2xdJliJrfNej3H7/fBW3pycmzfCx48qOmc30vL9gjR7Z0znvNaKzlAMnQpiwUOHfxdE62GzQLG486I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029215; c=relaxed/simple;
	bh=DJZn8hUcr7qrXuuyp5TspC4wXrB7yMIW9ad/R+jXQq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfpsjrCq8h0PC66KuGVt3T91EIF/gmJtWN9eF1thKqy21WZPWawu1QbPoAqEVZ5+vFdJbXbdtY4p4O/LD8O8xlek3oGBwhXqyS6aH8f7lgBIUnOym06nHYaj0NmkojKtw4+XjcORM5dpfWwsM+algy3J5NfIOk96r8exHGGS3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ90IUcC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so80354866b.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763029212; x=1763634012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=;
        b=KQ90IUcCCH41by4dG9uXHjmxEo5GOXEmfOtimJWDiJwavXQuTtDnWq1if/VZ8HSypB
         2hUrhw6L+68gPf0/Z1ufmC9tBhHjiokV3HmlIc7qctyuRzsbs+R+ZHBft4RouFGgexwL
         bw0uWxKOofubjtRVFsTjr3fzJmS/QmERzmYsHYzQ1kL9sj+sDMI8DQv19V8arpNwZXqN
         ozFmniPWds1+k62xnGe9YZL/G+f9o4iDlKpVBNAo9J3FSmIHI2vkOfgy6fXSswnmp6qi
         skv0RtfKNocC3V6ly44SzP3Viot49KNOsaH4yEPBC6xNJ3JUPxuhHJg/CQFcqI+V+/Ie
         hWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029212; x=1763634012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IaLuTVv6ogQrV7pgPnqPwD8BmOYnKQewjeQIkkX8Rks=;
        b=RQHi06/f2SJUEjB7Npk4fk87F7NtoM8oje18EnbJbd8V3NACGtQfjQ4KlYoqMORw+Y
         RIwmCwMhuOh6clEBIqrfWkEEm5jUkbn8gQYFQQcLXfoVeL06oreiuNhXDODMk5Y4btnj
         YniQZkP9VTYlFnW/1pHH8/PKLqiZUn3WzDhuVfxlE3iGAoh1AeIqysPc2zdrWi8HhiMq
         rVovNi/wZwE1+O7eUoLvlRZt2T+dkacoVH5gR+RoBBpoKN5mvdBj2mPGBGsiiQ6DsAU/
         /QlxRJE6LaRzvcKgQYjeVgdChT1c84UEC/J3ufzfzs759t2YRTya0kyrUaPXM+q2MkIB
         OzEw==
X-Forwarded-Encrypted: i=1; AJvYcCVT2GPF6cUSwudgGl6X6UxbxSakTS3UZoZNmgxINqmas7rXuPfmQzgUj70B81CNQdwJbBhX9+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwfvXaF0cbXXoNTDQhZDrfZdRUQX71OwutL7+nn5NGNYr1G7b
	FTaZbA5fEd39wWTMmXSbAc7NJUyKEsg8yaCpJGITMcD08PdeN/jrdSrRZ7g+QtfPoYZzS45oZqN
	WzTGVi83VTF1RZruh3TN1bswqXv0z4zc=
X-Gm-Gg: ASbGnct1bTjt93cu5Yl2+hfFzeuvj+viT5SzTEXZwF0ocZTP2gXzbctDrveO1NPS7vi
	j6P3eW8CPw5QKi/BCR0dv3l31Ja9tw8L0Mb/I+sPJCQ5x9XfmNLBq1gY8yu2CzW38BVSvOQRsSj
	W261+Iw+Bhr9xdk8j1ZpsTN38bQ3fmonQ4zoQvesInlN3U/ilWaW8BtUwDJe7plhrdef+EzVW8I
	JR6iSaX2A3YvTWD9hUu7cHNMYZ7odRONPjw7FE2ixyaKYKcS/lwcg7y8F/XM3zK6wKV3dzgO9Y/
	3r17FZ8nPk8yoRo=
X-Google-Smtp-Source: AGHT+IHW+MEeffc/pTPQLmL7Dde2CnR8q/jO4iZvJp6R/AepiIuZRquQtp0We7AMZrEbstFQ9LYr74m01iZsJkJ+N6k=
X-Received: by 2002:a17:906:f58a:b0:b72:6d3e:848f with SMTP id
 a640c23a62f3a-b7331a372c0mr637454366b.19.1763029212208; Thu, 13 Nov 2025
 02:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-3-alistair.francis@wdc.com> <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
In-Reply-To: <49bbe54a-4b55-48a7-bfb4-30a222cb7d4f@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 20:19:45 +1000
X-Gm-Features: AWmQ_bkRDLojedW15PfOpNiK2JsU2DoevPnRuJfyF_0Rq1ckrKQa8VpTESFPsDE
Message-ID: <CAKmqyKN4SN6DkjaRMe4st23Xnc3gb6DcqUGHi72UTgaiE9EqGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] net/handshake: Define handshake_sk_destruct_req
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:47=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Define a `handshake_sk_destruct_req()` function to allow the destructio=
n
> > of the handshake req.
> >
> > This is required to avoid hash conflicts when handshake_req_hash_add()
> > is called as part of submitting the KeyUpdate request.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> > v5:
> >  - No change
> > v4:
> >  - No change
> > v3:
> >  - New patch
> >
> >  net/handshake/request.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 274d2c89b6b2..0d1c91c80478 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -98,6 +98,22 @@ static void handshake_sk_destruct(struct sock *sk)
> >               sk_destruct(sk);
> >  }
> >
> > +/**
> > + * handshake_sk_destruct_req - destroy an existing request
> > + * @sk: socket on which there is an existing request
>
> Generally the kdoc style is unnecessary for static helper functions,
> especially functions with only a single caller.
>
> This all looks so much like handshake_sk_destruct(). Consider
> eliminating the code duplication by splitting that function into a
> couple of helpers instead of adding this one.
>
>
> > + */
> > +static void handshake_sk_destruct_req(struct sock *sk)
>
> Because this function is static, I imagine that the compiler will
> bark about the addition of an unused function. Perhaps it would
> be better to combine 2/6 and 3/6.
>
> That would also make it easier for reviewers to check the resource
> accounting issues mentioned below.
>
>
> > +{
> > +     struct handshake_req *req;
> > +
> > +     req =3D handshake_req_hash_lookup(sk);
> > +     if (!req)
> > +             return;
> > +
> > +     trace_handshake_destruct(sock_net(sk), req, sk);
>
> Wondering if this function needs to preserve the socket's destructor
> callback chain like so:
>
> +       void (sk_destruct)(struct sock sk);
>
>   ...
>
> +       sk_destruct =3D req->hr_odestruct;
> +       sk->sk_destruct =3D sk_destruct;
>
> then:
>
> > +     handshake_req_destroy(req);
>
> Because of the current code organization and patch ordering, it's
> difficult to confirm that sock_put() isn't necessary here.
>
>
> > +}
> > +
> >  /**
> >   * handshake_req_alloc - Allocate a handshake request
> >   * @proto: security protocol
>
> There's no synchronization preventing concurrent handshake_req_cancel()
> calls from accessing the request after it's freed during handshake
> completion. That is one reason why handshake_complete() leaves completed
> requests in the hash.

Ah, so you are worried that free-ing the request will race with
accessing the request after a handshake_req_hash_lookup().

Ok, makes sense. It seems like one answer to that is to add synchronisation

>
> So I'm thinking that removing requests like this is not going to work
> out. Would it work better if handshake_req_hash_add() could recognize
> that a KeyUpdate is going on, and allow replacement of a hashed
> request? I haven't thought that through.

I guess the idea would be to do something like this in
handshake_req_hash_add() if the entry already exists?

    if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
        /* Request already completed */
        rhashtable_replace_fast(...);
    }

I'm not sure that's better. That could possibly still race with
something that hasn't yet set HANDSHAKE_F_REQ_COMPLETED and overwrite
the request unexpectedly.

What about adding synchronisation and keeping the current approach?
From a quick look it should be enough to just edit
handshake_sk_destruct() and handshake_req_cancel()

Alistair

>
>
> As always, please double-check my questions and assumptions before
> revising this patch!
>
>
> --
> Chuck Lever

