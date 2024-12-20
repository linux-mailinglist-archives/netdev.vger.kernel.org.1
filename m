Return-Path: <netdev+bounces-153540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636D29F89A8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57632162E1B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 01:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F572594AE;
	Fri, 20 Dec 2024 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOnKKAXE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC491F94D
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 01:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734658872; cv=none; b=HJ22WPy0TWtEL+wDosBtdfxnR7CNdd1Y/2J6hqvSxe9ReUwmQ6QUNkL7l7JwbZHCi0T9BY+zbbxSrPX1P8VVTeIGD93FN0IVDe7OrfBmkuttQD5pE0g7XQpunJiBUbrFz6nJrTnAMjuGaF4ZAH8oFF7PJB//u7+keyxlC0e2RY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734658872; c=relaxed/simple;
	bh=qsrn7LyKZ0w1BhwKJsIw12XDvy1jCdYJJORwZTL8JUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaOsGlNqc9Zzfycnaajv2BhVYU4mlvm1ITC2FU6ORw0dCeF9uoHjKAm2MHbZRm1YyMfB4II4IkJ0HeHXJDYyqgSareAvMYDAIc4MsrTuGOae4A3goOGuQVZDJWU4J5WwNLFKNXPb2GO8LheOHe9qtbqWDgckChqkadAXgoidwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOnKKAXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F32C4CECE;
	Fri, 20 Dec 2024 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734658870;
	bh=qsrn7LyKZ0w1BhwKJsIw12XDvy1jCdYJJORwZTL8JUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOnKKAXEZUmYP6R8+mQDab/SrMbi1445LyWeQxx/dAxqEYR3goSDYAbdZeF1CR59/
	 5K/WXmId2PDJYSczn3IbKTEm3/m0+xXYS6N0us1Kni7xZbo9NteOg7+Lgm0TY2L6Ds
	 AgZJvKe0SipxqfuLocWyTvugEfS+P9xN45KsqZ1s683Fp+KtfFU32atrMWRfBoEvrg
	 Rm7RmHVZHp3yxfSNR7o4v6uNtUviwK8ap8AFH46AhCZZJNkOJGvMMNt5krPDce4nff
	 kl07Z0lSBeASKkJct+0P+HDeJwFM7Dh3IJ1eHVVTX91hb1pBy7ken2WMrNa2G5/WtJ
	 QVL8sKnzcAW4Q==
Date: Thu, 19 Dec 2024 17:41:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API
 for Homa
Message-ID: <20241219174109.198f7094@kernel.org>
In-Reply-To: <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
	<20241217000626.2958-2-ouster@cs.stanford.edu>
	<20241218174345.453907db@kernel.org>
	<CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 10:57:22 -0800 John Ousterhout wrote:
> On Wed, Dec 18, 2024 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 16 Dec 2024 16:06:14 -0800 John Ousterhout wrote: =20
> > > +#ifdef __cplusplus
> > > +extern "C"
> > > +{
> > > +#endif =20
> >
> > I'm not aware of any networking header wrapped in extern "C"
> > Let's not make this precedent? =20
>=20
> Without this I don't seem to be able to use this header in C++ files:
> I end up getting linker errors such as 'undefined reference to
> `homa_replyv(int, iovec const*, int, sockaddr const*, unsigned int,
> unsigned long)'.

No idea TBH, I don't see homa_reply anywhere in the submission

> Any suggestions on how to make the header file work with C++ files
> without the #ifdef __cplusplus?

With the little C++ understanding I have, I _think_ the include site
can wrap:

extern "C" {
#include "<linux/homa.h>"
}

> > > +/**
> > > + * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided i=
nto
> > > + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
> > > + * for well-defined server ports. The remaining ports are used for c=
lient
> > > + * ports; these are allocated automatically by Homa. Port 0 is reser=
ved.
> > > + */
> > > +#define HOMA_MIN_DEFAULT_PORT 0x8000 =20
> >
> > Not sure why but ./scripts/kernel-doc does not like this:
> >
> > include/uapi/linux/homa.h:51: warning: expecting prototype for HOMA_MIN=
_DEFAULT_PORT - The 16(). Prototype was for HOMA_MIN_DEFAULT_PORT() instead=
 =20
>=20
> I saw this warning from kernel-doc before I posted the patch, but I
> couldn't figure out why it is happening. After staring at the error
> message some more I figured it out: kernel-doc is getting confused by
> the "-" in "16-bit" (it seems to use the last "-" on the line rather
> than the first). I've modified the comment to replace "16-bit" with
> "16 bit" and filed a bug report for kernel-doc.

Unless you're planning to render the docs on docs.kernel.org you can
just switch from /** to /* comments. IMVHO kdoc is overused, unless
there's full documentation with API rendered like
https://www.kernel.org/doc/html/latest/networking/net_dim.html
kdoc is more trouble than gain.

> > > +/** define SO_HOMA_RCVBUF - setsockopt option for specifying buffer =
region. */
> > > +#define SO_HOMA_RCVBUF 10
> > > +
> > > +/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF=
. */
> > > +struct homa_rcvbuf_args {
> > > +     /** @start: First byte of buffer region. */
> > > +     void *start; =20
> >
> > I'm not sure if pointers are legal in uAPI.
> > I *think* we are supposed to use __aligned_u64, because pointers
> > will be different size for 32b binaries running in compat mode
> > on 64b kernels, or some such. =20
>=20
> I see that "void *" is used in the declaration for struct msghdr
> (along with some other pointer types as well) and struct msghdr is
> part of several uAPI interfaces, no?

Off the top off my head this use is a source of major pain, grep around
for compat_msghdr.

> > > +/**
> > > + * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling me=
chanism:
> > > + * always send all packets immediately.
> > > + */ =20
> >
> > Also makes kernel-doc unhappy:
> >
> > include/uapi/linux/homa.h:159: warning: expecting prototype for HOMA_FL=
AG_DONT_THROTTLE - disable the output throttling mechanism(). Prototype was=
 for HOMA_FLAG_DONT_THROTTLE() instead =20
>=20
> It seems that the ":" also confuses kernel-doc. I've worked around this a=
s well.
>=20
> > Note that next patch adds more kernel-doc warnings, you probably want
> > to TAL at those as well. Use
> >
> >   ./scripts/kernel-doc -none -Wall $file =20
>=20
> Hmm, I did run kernel-doc before posting the patch, but maybe I missed
> some stuff. I'll take another look. There are a few things kernel-doc
> complained about where the requested documentation would add no useful
> information; it would just end up repeating what is already obvious
> from the code. Is any discretion allowed for cases like this? If the
> expectation is that there will be zero kernel-doc complaints, then
> I'll go ahead and add the useless documentation.

My recommendation is to use normal comments where kdoc just repeats
obvious stuff. All these warnings sooner or later will result in some
semi-automated and often poor quality patch submissions to "fix" it.
Which is just work for maintainers to deal with :(



