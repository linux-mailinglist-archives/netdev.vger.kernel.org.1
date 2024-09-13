Return-Path: <netdev+bounces-128253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FECF978BEA
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 01:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632C32827DB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A0190470;
	Fri, 13 Sep 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjP4g6ZB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB7191499
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726270939; cv=none; b=T/BakGuGHZVXphppw8hQNTi+iV9W82vSA1KzkhvZrmKAlOv+ew/aVc6Or/b1D5ZTMAAVSlbNHRNQdKLP5QRGK2JzfcS5VV25KxqN3YJqI5E40ji/F3O3Qu9oHW2CtxxcxmiM+50DKTE+TB6cgVyHZ2FDIwJPRAig2R9lIccp/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726270939; c=relaxed/simple;
	bh=2XLAxbp73etTa5po13qylTKRyhfeHfWQ0b8YjCrsCZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iROq/hG5vXbyX5JQFS3JUtepbYgDu0iSQ3wiHWvCl0u/zr1LbX+GwnCgXol8Kb9CnbuW6BlqK4MMv7fXDvAYbMxR7S5c55o3AGzPlPKzGq05DXTrPlJf8bmELgFfRaa/y/ol524N836SDj3nzpXUN5ZUKbiUZ4cePYX6ybq34cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjP4g6ZB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582a5b495cso51581cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726270937; x=1726875737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eqz/jIoH/Y9Xe/li9UT1UQErIQKexzS/y8YIwgcKHA=;
        b=EjP4g6ZBXPCkIrTj5ID8ICskLJ06lbZHxPdCPmzU7nKZ+rMwD2f2Y7eBvVMJN5Qbtd
         PamDzWGtr4OIJBTTaad40aLnO6Dkhwvqjbpnfum21g0kxd45yYPiIbfT2QvUzEiSeNB5
         Xxa7B3KBhDygJgcUvCgLqa8w4wTPgegQ0AWo5BdWSCywDheFz0+0OFCIS2IxVvbGUv57
         LlTIM4K28xGNoONXillY2Dw+jnHtjtW/ramS9v6G04+bhIqfu03MeCIDbLpyUkWWX64C
         uvgt3bx59a7x+g5P1ugYfQcgJbYLRvrRskH66VSOS4870G2Qz9om7gIE6qxFEd781gfV
         ksXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726270937; x=1726875737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eqz/jIoH/Y9Xe/li9UT1UQErIQKexzS/y8YIwgcKHA=;
        b=ka4AKG0bRp6e4HsY0a6UnvqwrkdG72Qo5TfGtbDxU+U6hOKPSNH5l0spVMQLqXuIX+
         xCvITk0tUyVlz+xeOiRj6zP+TnF7ixLLBMXVlme5gnfmP+aakg/YDXhFbTnPVryj3u0H
         4bXr3vjdKxBkL58GlcQTPgwJV/FYo5ftOTpyMlSiApr7P3vOPCUBjOKilNuLhgjFu+lm
         FCX0ZAp/lCxl55//KuG1s1Bw9WcGYKr1fyuzXSnlRsNrOHfXHPKJitwqc8MTFSdgsI/Q
         Q+FeCK+a9HSX/j6PEn2VYKgYYZqJDBVYWhk78RJJqbev6VmczAko07OJSom94/FJ4DCm
         6OnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwkjDDQuXEvSDqbRsJ8WJZyYrfhBh0vupMLtyS0fZ7pXMWhf1ftp+tyhzaQU/FOIkL5p3pcoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbtvCJo7HSf5LuUGg1NZoNZGOrCGqgWljntY4bKRDtGkMhdigR
	UHeVGuy4GLNFQiaEnxysrGeP6EKXYiycv6gJ+q5zrx1NB0H6iiyRpJ8MQu7LxKmgoQFEQh2u8du
	Hcj2eUr3eYoyc/rJRjaGvV24lFqC0OWg+dSAz
X-Google-Smtp-Source: AGHT+IH3zZbZh4QohcJWFEHXjz0cOSu1HMn2rw5nubBp6tmol4M2n4yhCyUvfdEUER5Xv0NwFWNI//28Gx3+wt09ejI=
X-Received: by 2002:ac8:5dcf:0:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-45860830e61mr9383551cf.26.1726270936374; Fri, 13 Sep 2024
 16:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-3-sdf@fomichev.me>
 <CAHS8izNOZMeNi4WNWL9jmLd-rJeGA=M3zBKDSzMNHZ3sZOxUuA@mail.gmail.com>
 <ZuNjz7HvlD4z6dR8@mini-arch> <CAHS8izM+J3pYi3Ut4q4RCcm68zL7LSjz9-9Fz=OAU0CjexBSGA@mail.gmail.com>
 <ZuRzGmedL2LfTKXw@mini-arch>
In-Reply-To: <ZuRzGmedL2LfTKXw@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Sep 2024 16:42:04 -0700
Message-ID: <CAHS8izM1SNJtusPScJyzrP+Afbo1G2Xdr4-KbLeyuA6P62UMqw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/13] selftests: ncdevmem: Remove validation
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 10:15=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 09/13, Mina Almasry wrote:
> > On Thu, Sep 12, 2024 at 2:57=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 09/12, Mina Almasry wrote:
> > > > On Thu, Sep 12, 2024 at 10:12=E2=80=AFAM Stanislav Fomichev <sdf@fo=
michev.me> wrote:
> > > > >
> > > > > ncdevmem should (see next patches) print the payload on the stdou=
t.
> > > > > The validation can and should be done by the callers:
> > > > >
> > > > > $ ncdevmem -l ... > file
> > > > > $ sha256sum file
> > > > >
> > > > > Cc: Mina Almasry <almasrymina@google.com>
> > > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > > ---
> > > > >  tools/testing/selftests/net/ncdevmem.c | 56 +++-----------------=
------
> > > > >  1 file changed, 6 insertions(+), 50 deletions(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testi=
ng/selftests/net/ncdevmem.c
> > > > > index 352dba211fb0..3712296d997b 100644
> > > > > --- a/tools/testing/selftests/net/ncdevmem.c
> > > > > +++ b/tools/testing/selftests/net/ncdevmem.c
> > > > > @@ -64,24 +64,13 @@
> > > > >  static char *server_ip =3D "192.168.1.4";
> > > > >  static char *client_ip =3D "192.168.1.2";
> > > > >  static char *port =3D "5201";
> > > > > -static size_t do_validation;
> > > > >  static int start_queue =3D 8;
> > > > >  static int num_queues =3D 8;
> > > > >  static char *ifname =3D "eth1";
> > > > >  static unsigned int ifindex;
> > > > >  static unsigned int dmabuf_id;
> > > > >
> > > > > -void print_bytes(void *ptr, size_t size)
> > > > > -{
> > > > > -       unsigned char *p =3D ptr;
> > > > > -       int i;
> > > > > -
> > > > > -       for (i =3D 0; i < size; i++)
> > > > > -               printf("%02hhX ", p[i]);
> > > > > -       printf("\n");
> > > > > -}
> > > > > -
> > > > > -void print_nonzero_bytes(void *ptr, size_t size)
> > > > > +static void print_nonzero_bytes(void *ptr, size_t size)
> > > > >  {
> > > > >         unsigned char *p =3D ptr;
> > > > >         unsigned int i;
> > > > > @@ -91,30 +80,6 @@ void print_nonzero_bytes(void *ptr, size_t siz=
e)
> > > > >         printf("\n");
> > > > >  }
> > > > >
> > > > > -void validate_buffer(void *line, size_t size)
> > > > > -{
> > > > > -       static unsigned char seed =3D 1;
> > > > > -       unsigned char *ptr =3D line;
> > > > > -       int errors =3D 0;
> > > > > -       size_t i;
> > > > > -
> > > > > -       for (i =3D 0; i < size; i++) {
> > > > > -               if (ptr[i] !=3D seed) {
> > > > > -                       fprintf(stderr,
> > > > > -                               "Failed validation: expected=3D%u=
, actual=3D%u, index=3D%lu\n",
> > > > > -                               seed, ptr[i], i);
> > > > > -                       errors++;
> > > >
> > > > FWIW the index at where the validation started to fail often gives
> > > > critical clues about where the bug is, along with this line, which =
I'm
> > > > glad is not removed:
> > > >
> > > > printf("received frag_page=3D%llu, in_page_offset=3D%llu,
> > > > frag_offset=3D%llu, frag_size=3D%u, token=3D%u, total_received=3D%l=
u,
> > > > dmabuf_id=3D%u\n",
> > > >
> > > > I think we can ensure that what is doing the validation above ncdev=
mem
> > > > prints enough context about the error. Although, just to understand
> > > > your thinking a bit, why not have this binary do the validation
> > > > itself?
> > >
> > > Right, the debugging stuff will still be there to track the offending
> > > part. And the caller can print out the idx of data where the validati=
on
> > > failed.
> > >
> >
> > Sorry to harp on this, but on second thought I don't think just
> > printing out the idx is good enough. In many cases all the context
> > printed by ncdevmem validation (page_frag/offset/dmabuf_id/etc) is
> > useful, and it's useful to have it inline with where the check failed.
> >
> > IIUC after your changes the frag_page/offset/dmabuf_id will go to
> > stderr output of ncdevmem, but the validation check fail will go to a
> > different log by the parent checker. Matching the failure in the 2
> > logs in megs of frag output will be annoying.
>
> Yes, it will definitely be more annoying to piece those two things
> together. But I don't expect us to debug the payload validation issues
> from the nipa dashboard logs. Even if you get a clear message of
> "byte at position X is not expected" plus all the chunk info logs,
> what do you really do with this info (especially if it's flaky)?
>

Oh, they provide important clues, even for flakes. See an example of
Taehee using these clues to arrive at a root cause here:
https://lore.kernel.org/netdev/CAMArcTUXm13xJO9XqcT=3D0uQAn_ZQOQ=3DY49EPpHq=
V+jkkhihMcw@mail.gmail.com/

> For development we can have some script to put those two things together
> for debugging.
>
> > > The reason I removed it from the tool is to be able to do the validat=
ion
> > > with regular nc on the other side. I just do:
> > >
> >
> > To be honest I don't think the ncdevmem validation gets in the way of t=
hat.
> >
> > To test rx, we can set up regular nc on the client side, and have
> > ncdevmem do validation on rx.
> > To test tx, we can have ncdevmem do tx (no validation), and have a
> > script on top of nc do validation on the rx side.
> >
> > I guess you may find the lack of symmetry annoying, but IMO it's less
> > annoying than losing some debuggability when the test fails.
> >
> > I think probably there are 3 hopefully agreeable things we can do here:
> >
> > 1. Keep the validation as is and do the rx/tx test as I described above=
.
> > 2. keep the ncdevmem validation, dump it to stderr, and ignore it in
> > the test. Leave it be for folks wanting to run the test manually to
> > debug it.
> > 3. Move the validation to a parent process of ncdevmem, but that
> > parent process needs to print full context of the failure in 1 log.
> >
> > I prefer #1 TBH.
>
> TBH, I find the existing ncdevmem validation scheme a bit lacking. It is
> basically the same payload over and over (or maybe I misread how it
> works). Maybe we should implement a PRNG-like sequence for validation
> if you prefer to keep it internal?
>

It's just a repeating sequence that's easy to implement. Technically
it would not detect if we drop an N iterations in the sequence, but in
practice it's hard to be that unlucky repeatedly, especially if the
number of repeating bytes is not a power of 2. Improving it to a more
robust sequence sounds fine to me.

> How about we start with what I have (simple 'hello\nworld') and once
> you do tx path, we can add the internal validation back? Both sides,
> with a proper selftest this time. For the time being, we can use the exis=
ting
> rx selftest as a smoke test.
>
> Or I can just drop this patch from the series and let you follow up
> on the validation in the selftests (i.e., convert from 'hello\nworld'
> to whatever you prefer)

To be honest the validation has been too important in the testing so
far in root causing issues that I would not like it temporarily
removed. Dropping this patch and letting me add validation to NIPA
later on sounds good to me.

--=20
Thanks,
Mina

