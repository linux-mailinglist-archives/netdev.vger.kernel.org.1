Return-Path: <netdev+bounces-128156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173A9784ED
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4DB1C23A4C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC3657CB5;
	Fri, 13 Sep 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LsVesTI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5B1C2BF
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241472; cv=none; b=HJk0gpur7Fmf+T1Q/vN3zMOhKwHyWyznC8N0qPhSAmx3K1nIjk1KlLas2AEvgLbgcBLvXIRES7f54RnXbngB4qRONcHXoqjbP71MJKtDx+wUn8Dcb60ecsm9blmP6z3Yftz/Bd6clzPoGmKy9uFT8yDOneCrNIKvuHPm5C6xXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241472; c=relaxed/simple;
	bh=q0rPh3l8zoDDkUk9crck5Z46vMvQHBWqZExec4xqolQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLjtjXjo4fmhrmF0+G4YSyQwOt0ZCD8OU0YaCO4miiU+qrItIvA6kHf1M1PyZ22EaXuIYY1Z2UlXofGIX9SEn3qT8g1OCZxNqBNck20to4XOApglUF1KV87IqS8MMvpE1btUth1pfcpNiEIXBBO6c+Z2w7qclJVNfu92S2rhnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LsVesTI0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582b71df40so212921cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726241470; x=1726846270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTxxRuvbOvo7vPeXmQGa5U0XTEz0NamiSCOXif4IBJU=;
        b=LsVesTI0CZlEfExTAWPqEaOYBSMdLU8oCjUE/AngkL2jL/1jp3liPIACww65mob03i
         2ma40c/MktOV61dCWtrTHCm+1pL7WVPsADfr8fTPKODJhuvx+ZR1hxfh8dzKl1Yakfnq
         GJaqgFvqvUgqZwxOfCjUezp9L9arNdNex1ZsbAB9hlGTmq0+UQE1C5T+et9xcDeNs+bA
         MIPcMqD05VMm6I3JHV4oJPW9aWFz/4LQj5pUN65W0RCJRATXWjD03Rb+1Cpvx+edredX
         ldLPaN3w78FSzu315SboKua2qqd4AK/hV2slsHPG/pf5hMG4A6JNTapTeA7pPIdr7kSi
         76Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241470; x=1726846270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTxxRuvbOvo7vPeXmQGa5U0XTEz0NamiSCOXif4IBJU=;
        b=kHJuvO2cGUHJch4jNynh9yQTr6y9HWsrfoe26ThOe0HDg5KnfcwakUa3WjsaIoNNQt
         9Z/kzaK8xdJ3yQ3rnFfXeGWaxQDtvr2xyoh9eVgAbixI1zkiiQeLCmURZhDVQy16yoE0
         dGk2D5jnlfGLdMoTQFHU8TQHZrothnhZpSBWvHrSfzlDnpEhfiQx8a6snnA6cTVwjFE3
         VukJALTTRSF7v4EZ+r7OreQzr4K0coLiD03fb/OkhmWC60RdWUjcDU8LOXjNPMNTHgZJ
         OgAu2hQ7w+WlGVK0wTCSj3PWq/MhNykQFOCF+pbYg7A72hb1eVjCJiINoIQtbGU3GPJr
         1aoA==
X-Forwarded-Encrypted: i=1; AJvYcCUrhHvMv3qipcnuydrXfdHM2Su9vie3FZnB5dus5us1u0Xp1uq2fONKsYx2Hu+Z07nB49EPiOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC43en227qoc3NzlxViFD9r0RshQZ3Vs3KUE9NGzwJ+4sBNA1f
	pyJssNj3VeiodU0kMpt189/Drngi1+ArorYR3OOlhsmClFdPY7ueWEq967Sgh+0dkVD3qEONUpY
	4cCkB7gMoXAvyfdQ8l8K8/qPRIaXvfvtThOZ+
X-Google-Smtp-Source: AGHT+IF9oAqXc6kwxRyqtHAZqzxBcTZqkYpXj4If+vCvXl68CCmvKKtmEYkm1MXbp00Pj0XsWLiVaD0IXBLfXCJQaX4=
X-Received: by 2002:a05:622a:24f:b0:447:f3ae:383b with SMTP id
 d75a77b69052e-45864518544mr6773021cf.19.1726241469793; Fri, 13 Sep 2024
 08:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-3-sdf@fomichev.me>
 <CAHS8izNOZMeNi4WNWL9jmLd-rJeGA=M3zBKDSzMNHZ3sZOxUuA@mail.gmail.com> <ZuNjz7HvlD4z6dR8@mini-arch>
In-Reply-To: <ZuNjz7HvlD4z6dR8@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 08:30:58 -0700
Message-ID: <CAHS8izM+J3pYi3Ut4q4RCcm68zL7LSjz9-9Fz=OAU0CjexBSGA@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] selftests: ncdevmem: Remove validation
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:57=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 09/12, Mina Almasry wrote:
> > On Thu, Sep 12, 2024 at 10:12=E2=80=AFAM Stanislav Fomichev <sdf@fomich=
ev.me> wrote:
> > >
> > > ncdevmem should (see next patches) print the payload on the stdout.
> > > The validation can and should be done by the callers:
> > >
> > > $ ncdevmem -l ... > file
> > > $ sha256sum file
> > >
> > > Cc: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  tools/testing/selftests/net/ncdevmem.c | 56 +++---------------------=
--
> > >  1 file changed, 6 insertions(+), 50 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/s=
elftests/net/ncdevmem.c
> > > index 352dba211fb0..3712296d997b 100644
> > > --- a/tools/testing/selftests/net/ncdevmem.c
> > > +++ b/tools/testing/selftests/net/ncdevmem.c
> > > @@ -64,24 +64,13 @@
> > >  static char *server_ip =3D "192.168.1.4";
> > >  static char *client_ip =3D "192.168.1.2";
> > >  static char *port =3D "5201";
> > > -static size_t do_validation;
> > >  static int start_queue =3D 8;
> > >  static int num_queues =3D 8;
> > >  static char *ifname =3D "eth1";
> > >  static unsigned int ifindex;
> > >  static unsigned int dmabuf_id;
> > >
> > > -void print_bytes(void *ptr, size_t size)
> > > -{
> > > -       unsigned char *p =3D ptr;
> > > -       int i;
> > > -
> > > -       for (i =3D 0; i < size; i++)
> > > -               printf("%02hhX ", p[i]);
> > > -       printf("\n");
> > > -}
> > > -
> > > -void print_nonzero_bytes(void *ptr, size_t size)
> > > +static void print_nonzero_bytes(void *ptr, size_t size)
> > >  {
> > >         unsigned char *p =3D ptr;
> > >         unsigned int i;
> > > @@ -91,30 +80,6 @@ void print_nonzero_bytes(void *ptr, size_t size)
> > >         printf("\n");
> > >  }
> > >
> > > -void validate_buffer(void *line, size_t size)
> > > -{
> > > -       static unsigned char seed =3D 1;
> > > -       unsigned char *ptr =3D line;
> > > -       int errors =3D 0;
> > > -       size_t i;
> > > -
> > > -       for (i =3D 0; i < size; i++) {
> > > -               if (ptr[i] !=3D seed) {
> > > -                       fprintf(stderr,
> > > -                               "Failed validation: expected=3D%u, ac=
tual=3D%u, index=3D%lu\n",
> > > -                               seed, ptr[i], i);
> > > -                       errors++;
> >
> > FWIW the index at where the validation started to fail often gives
> > critical clues about where the bug is, along with this line, which I'm
> > glad is not removed:
> >
> > printf("received frag_page=3D%llu, in_page_offset=3D%llu,
> > frag_offset=3D%llu, frag_size=3D%u, token=3D%u, total_received=3D%lu,
> > dmabuf_id=3D%u\n",
> >
> > I think we can ensure that what is doing the validation above ncdevmem
> > prints enough context about the error. Although, just to understand
> > your thinking a bit, why not have this binary do the validation
> > itself?
>
> Right, the debugging stuff will still be there to track the offending
> part. And the caller can print out the idx of data where the validation
> failed.
>

Sorry to harp on this, but on second thought I don't think just
printing out the idx is good enough. In many cases all the context
printed by ncdevmem validation (page_frag/offset/dmabuf_id/etc) is
useful, and it's useful to have it inline with where the check failed.

IIUC after your changes the frag_page/offset/dmabuf_id will go to
stderr output of ncdevmem, but the validation check fail will go to a
different log by the parent checker. Matching the failure in the 2
logs in megs of frag output will be annoying.

> The reason I removed it from the tool is to be able to do the validation
> with regular nc on the other side. I just do:
>

To be honest I don't think the ncdevmem validation gets in the way of that.

To test rx, we can set up regular nc on the client side, and have
ncdevmem do validation on rx.
To test tx, we can have ncdevmem do tx (no validation), and have a
script on top of nc do validation on the rx side.

I guess you may find the lack of symmetry annoying, but IMO it's less
annoying than losing some debuggability when the test fails.

I think probably there are 3 hopefully agreeable things we can do here:

1. Keep the validation as is and do the rx/tx test as I described above.
2. keep the ncdevmem validation, dump it to stderr, and ignore it in
the test. Leave it be for folks wanting to run the test manually to
debug it.
3. Move the validation to a parent process of ncdevmem, but that
parent process needs to print full context of the failure in 1 log.

I prefer #1 TBH.

--=20
Thanks,
Mina

