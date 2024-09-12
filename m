Return-Path: <netdev+bounces-127952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433AA9772D5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058A0286054
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77891C174F;
	Thu, 12 Sep 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFlx9HxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC41BF81C
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173843; cv=none; b=kD+FBr0ZTVLwmqmSEZBvX+5m+JodXha8a74GgALnNIpVuCTqs6J+3jZs15YtPIb+dSK33qzflubirvO3YQKp4a6Y1fisMPkjICVFEFHz3uMwR+EHHzNG8ILwPDs0/0yCfe2j2WgwBg9NEhRv6mVjdQSh5GwcHhKnOY+LVkLBU6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173843; c=relaxed/simple;
	bh=POeMZyrSzWfT0c/EFYH4aVeVC1H3dWbv5VrEhXmoxgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7DcIszzHF4Jalf9pqwG/UhWHt0m7AG8pOWZPlvhUay2kCtlh12D+TBbFHA4OcGGnZHjwmINuGw6yb3CJ1/UQG4HDLyKyFiIz/IbNkG4nHd5mk+ycf1CKWJQWhxV/nZYyEhwHCLvIiDCM63ML3cZRX0NHM1YDZPiueAnDLfPtZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFlx9HxJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49bdc6e2e2cso493486137.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173841; x=1726778641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DjwiIxMiUHr1M6b4I5f9AEu55zXyA3J0twzo/v710c=;
        b=wFlx9HxJS6WhEJjtnpyuDRH6cxGr+0GWzT35/x2kDdCv9W2k4A7/T3uzsAHFgjNkQ+
         TdAEI9ebLq91wjS8R2Ot8kKSRmHf93bwVmU/KoLBDP4Q5x72t/Z51T9rLT7wn9DueLSU
         D0hGu/BRwlcdn6CMokng56PFRoSakH9BmsO2Ik9R4WabwzyEGdC/a4hOlCZJcxKpVih4
         EPIJcTzVkUqF7+WFPr5icBgxt7mDRWTcFX6m/Jc3xAoBb6lfVA5TD+1w89bqIZGEY+CE
         ljHVZpjgLB9UnclbR2aCe0r9k7cKmWV6f2slht/jUIRBOgtvkYeHP441A3ht5vSoAaK6
         ykmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173841; x=1726778641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DjwiIxMiUHr1M6b4I5f9AEu55zXyA3J0twzo/v710c=;
        b=HBMW/Njo3ykjUJmSVoOgJ7gwswmbpTwOdhd+n0OpU9oEcLQKdAB9PjOj7Qr+MjTzQi
         zCBUooTu4ji8yH/MC0v2f9dStcVd47GmGLtOA/ADZrrMNa2BDrof0oYhQVJ6dcq61efT
         YzeNFpDjYHV2iMAhJ3vInW3SEWxveDGoA2WRgHAfakyvxpLdi9op9UahbaoSjG4LVwNb
         UJjZHtVdPbOPvTWrEMy55hRoSD/edeB5oMmQNlzgf8OOtu0nuNeMUU7rAxRza1RDigpl
         woe6gYH3510qV5dRXYWMwhCCC7wn8pw6rKxCVpVknfKQCVeYaTSXqtLH2VEHoIY03CcL
         SlVg==
X-Forwarded-Encrypted: i=1; AJvYcCWFi67hgly+d+Byip43X9IxTySxfJpILYJvtIeic4hIxmVAMYTuQcfibO4TciDKJpS1if7EyUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOa5R+tiJDXN2HitaYJqgEsfdBt8jyEUiea9Do1okj+Khj+z3i
	HMR3+TQO6P8Cj8AenHa9BU2bZH/7WemWk92OZ5SH46rfh0B2VLey5+SiW6zMQcU/SY1qxTC0s22
	fuWOUWwRH2MJSFHCstQc3bwljFvTeyfWvfY2s
X-Google-Smtp-Source: AGHT+IHCLGoDTbD9LAUphE9SPUrx3KUcIqiqyoGvbi+stviqZGZ5BDOXy0oCRC9AnOS0a9EEOZIMy5Ntm4L7cGK4dJE=
X-Received: by 2002:a05:6102:a48:b0:49b:e7d7:3e1b with SMTP id
 ada2fe7eead31-49d41468125mr4919245137.3.1726173840757; Thu, 12 Sep 2024
 13:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>
 <20240910093751.GA572255@kernel.org>
In-Reply-To: <20240910093751.GA572255@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 13:43:49 -0700
Message-ID: <CAFhGd8qQ_e_rh1xQqAnaAZmA7R+ftRGjprxGp+njoqg_FGMCSw@mail.gmail.com>
Subject: Re: [PATCH] caif: replace deprecated strncpy with strscpy_pad
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 2:37=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Sep 09, 2024 at 04:39:28PM -0700, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings [=
1] and
> > as such we should prefer more robust and less ambiguous string interfac=
es.
> >
> > Towards the goal of [2], replace strncpy() with an alternative that
> > guarantees NUL-termination and NUL-padding for the destination buffer.
>
> Hi Justin,
>
> I am curious to know why the _pad variant was chosen.

I chose the _pad variant as it matches the behavior of strncpy in this
context, ensuring minimal functional change. I think the point you're
trying to get at is that the net_device should be zero allocated to
begin with -- rendering all thus NUL-padding superfluous. I have some
questions out of curiosity: 1) do all control paths leading here
zero-allocate the net_device struct? and 2) does it matter that this
private data be NUL-padded (I assume not).

With all that being said, I'd be happy to send a v2 using the regular
strscpy variant if needed.

>
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90 [2]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  net/caif/chnl_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> > index 47901bd4def1..ff37dceefa26 100644
> > --- a/net/caif/chnl_net.c
> > +++ b/net/caif/chnl_net.c
> > @@ -347,7 +347,7 @@ static int chnl_net_init(struct net_device *dev)
> >       struct chnl_net *priv;
> >       ASSERT_RTNL();
> >       priv =3D netdev_priv(dev);
> > -     strncpy(priv->name, dev->name, sizeof(priv->name));
> > +     strscpy_pad(priv->name, dev->name);
> >       INIT_LIST_HEAD(&priv->list_field);
> >       return 0;
> >  }
> >
> > ---
> > base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
> > change-id: 20240909-strncpy-net-caif-chnl_net-c-a505e955e697
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
> >

I appreciate the review.

Thanks
Justin

