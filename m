Return-Path: <netdev+bounces-125463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230E96D279
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059D0288B67
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA64194A60;
	Thu,  5 Sep 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adlyV1oU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE62193409
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526182; cv=none; b=DY2ipJm6GaOBmxonZxISzmmlseoB+dEIQWMpJCz6NXZvyUM7zToCHmqcRvFUwzdCwH5bmOJam7nFJBMgi/ZBJvG6nmpnO9aATUaU1Pz9h32dshkgTtJf7YJ+vpS2jaV3VpvSmGSeYpEf9oL7iJvSzd24kElKynAuyNdQzBqQfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526182; c=relaxed/simple;
	bh=q9/k5LfTfOc5pQVWiiw6GZ9xJE8spFogmerznd/58xY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea69WHwlJdUjyQbmt/d/Kv63qzOGY/b5IeixA9UJtmxYkfsESmnR89zv2j5JfcuuIMmnHDQiNVIKsG0kamx5gYfAdhKPxhCQ6g9m36DVZLTMfYYjfQ3OvH2oSjKk26D64X9kSA0m6YNlwbIwhuH8orsxOZgM3wap0I3D9uTBcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adlyV1oU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39d2e4d73bcso2166635ab.1
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725526180; x=1726130980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPZ+n4FOKV6xJ4Pa/nYmCRSqGoqTikA3v3p25M2PmUE=;
        b=adlyV1oU6zkK2aPoWseOUshl1zSdc1gwDyeh7oQFOg+GZZmH/nrmPjUUOaIEx8RXC6
         ZDi+qtNs6HZpEiAL9jf3UXGe25OxaCuGU3bDLU6U8X0Vs5ZhgjSDL28+QXZo6+5/FA0F
         x0oTMxu7u8igq3pnhxn3jYFBp1X1O7HUNbX+hZSqN2MUTAGy5xiJdwUgP0e7xEz4R4Ja
         zZoV2gaAZXU7ONy576r1SaluOljONQ06Qdxv7+ejHv59JPo2Zox6dQ8s4BoA2Iwv6v2n
         KjqBXFL6iIUsGZ3DnY7Lu5u3x4ZuEtPxPePs1Z+bDNmj/QWbAGcJ03kA7Ary1SfLfXfM
         uEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725526180; x=1726130980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPZ+n4FOKV6xJ4Pa/nYmCRSqGoqTikA3v3p25M2PmUE=;
        b=epE72tJxUOhIdfnNfldNiIyNkWl0erJ1HppVnoLaTzSu7V2qLfqWOllwhumu0rbQJ/
         dMnhanRCQ3plc7wwzCLl5t73iH1ACO65VDRlu60ZcsFjY3gVmOxdWMdwguVJmN1TonwX
         sTIg3FgVWt/EeZmFdX1cz3camaob4lutbMsIIcvp5Gq2+QVjs9nEeXvVeBYMV/Lo5HS1
         PNefgqPnTnLPeo05/Tp6t4Cb7/ze/0MxbhCgKoKAxu0XpXWMxFxXMhpgo/CWgiivrqQj
         HFeXE/sNLjHK+ekRZRVLeW2UViWIroNewrpZS3ctJmN7cs+FwHwaVAA0gFSn+66F4Z27
         AiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW87bTMF4S88C+fo0wNg+h4CgRsuOD9plORgUEBchpZb7SEEqPGHcBpJi43CzdJYQP7VTWic9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+uh3orh+H5UfbF/L5Zbe5nMegTZV8lQPGi8G+2RJqDjv6PIi
	mW4+Pm/4nbXueHGDVnJWpK6FPSlIP3zCWAI4vsA/neCc/2510xcUPfUbX7Nb4BkoCYULu10swge
	4pcnd7uL1XBZFIDdWKAH6XpVgHlM=
X-Google-Smtp-Source: AGHT+IGgutmhCjDCGYb+knQ1GI7LJQkf/QSswiG/Rhx2+KaChzwBHUODO/HdlevU+CA7MZHlcrdBUuDndJoMyvetv0g=
X-Received: by 2002:a05:6e02:144e:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-39f5efeb18amr146832645ab.5.1725526179899; Thu, 05 Sep 2024
 01:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904113153.2196238-1-vadfed@meta.com> <20240904113153.2196238-2-vadfed@meta.com>
 <CAL+tcoAO=0g0mkmgODzNWLJZgRxNvJiXM7=DgoCgdbFsJ0cJEg@mail.gmail.com> <ac14161a-33e9-4fa0-8e8c-1d7ea42afc56@linux.dev>
In-Reply-To: <ac14161a-33e9-4fa0-8e8c-1d7ea42afc56@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 16:49:03 +0800
Message-ID: <CAL+tcoATsEEqsNPqoL0aPZDkeb-6KPmrzokiB2PiOEmE9kjfhw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Vadim Fedorenko <vadfed@meta.com>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:34=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 05/09/2024 09:24, Jason Xing wrote:
> > Hello Vadim,
> >
> > On Wed, Sep 4, 2024 at 7:32=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com=
> wrote:
> > [...]
> >> diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_=
tstamp.h
> >> index a2c66b3d7f0f..1c38536350e7 100644
> >> --- a/include/uapi/linux/net_tstamp.h
> >> +++ b/include/uapi/linux/net_tstamp.h
> >> @@ -38,6 +38,13 @@ enum {
> >>                                   SOF_TIMESTAMPING_LAST
> >>   };
> >>
> >> +/*
> >> + * The highest bit of sk_tsflags is reserved for kernel-internal
> >> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMP=
ING*
> >> + * values do not reach this reserved area
> >
> > I wonder if we can add the above description which is quite useful in
> > enum{} like this:
> >
> > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_t=
stamp.h
> > index a2c66b3d7f0f..2314fccaf51d 100644
> > --- a/include/uapi/linux/net_tstamp.h
> > +++ b/include/uapi/linux/net_tstamp.h
> > @@ -13,7 +13,12 @@
> >   #include <linux/types.h>
> >   #include <linux/socket.h>   /* for SO_TIMESTAMPING */
> >
> > -/* SO_TIMESTAMPING flags */
> > +/* SO_TIMESTAMPING flags
> > + *
> > + * The highest bit of sk_tsflags is reserved for kernel-internal
> > + * SOCKCM_FLAG_TS_OPT_ID.
> > + * SOCKCM_FLAG_TS_OPT_ID =3D (1 << 31),
> > + */
> >   enum {
> >          SOF_TIMESTAMPING_TX_HARDWARE =3D (1<<0),
> >          SOF_TIMESTAMPING_TX_SOFTWARE =3D (1<<1),
> >
> > to explicitly remind the developers not to touch 1<<31 field. Or else,
> > it can be very hard to trace who occupied the highest field in the
> > future at the first glance, I think.
> >
> > [...]
>
> That's a bit contradictory to Willem's comment about not exposing
> implementation details to UAPI headers, which I think makes sense.

Oh, well, I missed checking the filename... it's an uapi file, sorry
for the noise :(

>
> I will move the comment to the definition area of SOCKCM_FLAG_TS_OPT_ID
> and will try to add meaningful message to BUILD_BUG_ON() to make it
> easier for developers to understand the problem.

Great! Thanks!

