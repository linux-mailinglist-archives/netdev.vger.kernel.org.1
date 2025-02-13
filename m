Return-Path: <netdev+bounces-165765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C95A334F5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A8A188A527
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBFC78F3B;
	Thu, 13 Feb 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsX36JEh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE81372;
	Thu, 13 Feb 2025 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411463; cv=none; b=A3KDfFdxHU0EcYitodGbljG9fWxuo2viWcOId26NzhSFaDS7+1x52o7V8/Lg9rUjPM5b4rK2NtFon0cf4Q5zHj0nf9nKQYK5zm4MZnpq7aGgw4/m+jAYZhdoShQvycgqtJ0k0KD5l0qWc37sxt+th/35U4SBZkAT7qO6tnldFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411463; c=relaxed/simple;
	bh=fMrPoWeMLKbevJQlujW14HeEpI+MEWQiEqBbUoqz1Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm3yoAofyvntSLzLMaB4E4zYlcCshTuVhXxEECZjpG45m4srImqTQiqxR/9cjrEC/g/3kBYfNE6wFQQFRYgqOJrzRhOdhUqTwDKB4ZmQSvv65D+RtiGAbbB6lQYzkyUGXFyH+Ne7e3j4dEia/nApakxuYCYn29JGmlWn4F/wNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsX36JEh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216513f8104so688165ad.2;
        Wed, 12 Feb 2025 17:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739411461; x=1740016261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF+3d9YE5wll/jDVUEdSENnWO/Lio/88ULs9I5MUpd8=;
        b=YsX36JEh5llJKfUbVw1hVkWzEzZavikjniuIS+dUvaqvaa/7OmibXIjXAYaZP2Fh+B
         qJqj+FoM6MfO7efm/TKk41XnxqapkHZufN1ZkEwYmLIZ0NNJlmpCueX8xPCZ5rMQUazs
         8+qn1bYuPy6eCrLgiVsQI22Je4ulaZUoYRvijssZ8jg6LE0d2/VoSyG6eGpCH2D85vxr
         nu08jvdf5hxiZuoWIXVi5vRG7ulOzGeBPgIYyYSQOp/Ld6rXB0BKhNraWdWY2BvqykIO
         SVDGciOXPrbdr4JijiD0REUu8rudCxDGY385sA15e0VxNOxKiYAEVCaTWCFrddA2ugS4
         17iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739411461; x=1740016261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF+3d9YE5wll/jDVUEdSENnWO/Lio/88ULs9I5MUpd8=;
        b=PmCPZqNlxGuoaYD/O72JWPoX3oM3XJfiy2TalgNyCxlNLogcJEb3bqG4zICXAH2r7a
         YwWRed33WEQ1/BD/0lC70JYv5wys4cooRhN8adZVk9GXqS9TyU3Ci5Nc5RFX6uT/GLgK
         QenZ4hoI0NJwmd818HAVCO6K5nz741F7Cvsg9r472amYM1Dg+ZXlHe08qjnS7CeUN0zK
         0WcptQpiTSKmW47mWmw2FIfDAm1eyzaqLwFpXgfv4N3mAsa8A0R4XrFOTRreSpanAARz
         ShFVBSrRx/MVqOpYxHGBrL+5c8AOKKuw4SvgMgckqxt5AdekXnFejQp3li5s3zi9UsWG
         2iEw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhpK64zIxLWT1VSU8wuGRIUqCqSm9iRGcAiFj+nf9xnVredlVadzGAbmw54Dy53qQWJAaAbXm@vger.kernel.org, AJvYcCX/SijWjNgb345oP0HLxh7BarS79Oz6lWhkp3qrea/317+QPDTYjFT8Zi1drxK3qrhjimz81rIrrlxqbPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJna3IgImyAD4F+3JRm7WRvPlrV4xEHdQillJFPc+olIApcGy
	mLVRw2+XECkbRJ1MreJ9sAEdHnsGbqsqw3tkpodHq9ZEn65hxoEKqriG+BamktWv74tH2NubrXB
	4xrXw+iT2PwQL+2Uuc1ibYCHWC4uGdhM=
X-Gm-Gg: ASbGncu08dftRG3s7WBYMJJJQgXPVJZTdXCVb9jn8hSunuIIYqZXdlBCIQ7ltGk+B9G
	QojizO00OVlTvtU4X2TcDKcv0bZgh3/+Ms+mPAkHQFFyuVggYianm1N2P0cNHs72IJKU6DFAI8A
	==
X-Google-Smtp-Source: AGHT+IFMzUNH4nx8Yt+NdViQ9eOLs4WezIKfW1Xnu9XXaeSGgUXoUd6cnTuTro+aX0pUCtSkVo5z0Ezs9Q5zdCPaPVI=
X-Received: by 2002:a17:902:ea02:b0:215:3862:603a with SMTP id
 d9443c01a7336-220bbb465f2mr34801125ad.10.1739411460841; Wed, 12 Feb 2025
 17:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212212556.2667-1-chenyuan0y@gmail.com> <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
 <CALGdzuoeYesmdRBG_QPW_rkFcX7v=0hsDr0iX3u5extEL5qYag@mail.gmail.com> <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
In-Reply-To: <8e6c7913fda39baa50309886f9f945864301660f.camel@codeconstruct.com.au>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 12 Feb 2025 19:50:49 -0600
X-Gm-Features: AWEUYZkVYD9t8ecpGjfaGqr6TdWOTef7hnfeghSVidusmxHZlhnX0dA023zCsj4
Message-ID: <CALGdzurifZaqatjGRZGxA4FyNBHOYJdVXpKHSM4hQdA3qZtYvQ@mail.gmail.com>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in aspeed_lpc_enable_snoop()
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, richardcochran@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I've drafted the following patch to address the resource cleanup issue:

```
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9ab5ba9cf1d6..4988144aba88 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,11 +200,15 @@ static int aspeed_lpc_enable_snoop(struct
aspeed_lpc_snoop *lpc_snoop,
  lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MINOR;
  lpc_snoop->chan[channel].miscdev.name =3D
  devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+ if (!lpc_snoop->chan[channel].miscdev.name) {
+ rc =3D -ENOMEM;
+ goto free_fifo;
+ }
  lpc_snoop->chan[channel].miscdev.fops =3D &snoop_fops;
  lpc_snoop->chan[channel].miscdev.parent =3D dev;
  rc =3D misc_register(&lpc_snoop->chan[channel].miscdev);
  if (rc)
- return rc;
+ goto free_name;

  /* Enable LPC snoop channel at requested port */
  switch (channel) {
@@ -221,7 +225,8 @@ static int aspeed_lpc_enable_snoop(struct
aspeed_lpc_snoop *lpc_snoop,
  hicrb_en =3D HICRB_ENSNP1D;
  break;
  default:
- return -EINVAL;
+ rc =3D -EINVAL;
+ goto free_misc;
  }

  regmap_update_bits(lpc_snoop->regmap, HICR5, hicr5_en, hicr5_en);
@@ -232,6 +237,14 @@ static int aspeed_lpc_enable_snoop(struct
aspeed_lpc_snoop *lpc_snoop,
  hicrb_en, hicrb_en);

  return rc;
+
+free_misc:
+ misc_deregister(&lpc_snoop->chan[channel].miscdev);
+free_name:
+ kfree(lpc_snoop->chan[channel].miscdev.name);
+free_fifo:
+ kfifo_free(&lpc_snoop->chan[channel].fifo);
+ return rc;
 }
```

I have a couple of questions regarding the cleanup order:

1. Do we need to call misc_deregister() in this case, considering that
the registration happens before return -EINVAL?
2. If misc_deregister() is required, is there a specific order we
should follow when calling misc_deregister() and
kfree(lpc_snoop->chan[channel].miscdev.name);?

-Chenyuan

On Wed, Feb 12, 2025 at 7:39=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2025-02-12 at 19:37 -0600, Chenyuan Yang wrote:
> > Hi Andrew,
> >
> > Thanks for your prompt reply!
> >
> > On Wed, Feb 12, 2025 at 6:21=E2=80=AFPM Andrew Jeffery
> > <andrew@codeconstruct.com.au> wrote:
> > >
> > > Hi Chenyuan,
> > >
> > > On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> > > > lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> > > > a pointer check is added to prevent potential NULL pointer
> > > > dereference.
> > > > This is similar to the fix in commit 3027e7b15b02
> > > > ("ice: FiI am cx some null pointer dereference issues in ice_ptp.c"=
).
> > > >
> > > > This issue is found by our static analysis tool.
> > > >
> > > > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > > > ---
> > > >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > index 9ab5ba9cf1d6..376b3a910797 100644
> > > > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > > > @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> > > > aspeed_lpc_snoop *lpc_snoop,
> > > >         lpc_snoop->chan[channel].miscdev.minor =3D MISC_DYNAMIC_MIN=
OR;
> > > >         lpc_snoop->chan[channel].miscdev.name =3D
> > > >                 devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME=
,
> > > > channel);
> > > > +       if (!lpc_snoop->chan[channel].miscdev.name)
> > > > +               return -ENOMEM;
> > >
> > > This introduces yet another place where the driver leaks resources in
> > > an error path (in this case, the channel kfifo). The misc device also
> > > gets leaked later on. It would be nice to address those first so that
> > > handling this error can take the appropriate cleanup path.
> > >
> > > Andrew
> >
> > It seems that the `aspeed_lpc_enable_snoop()` function originally does
> > not have a cleanup path. For example, if `misc_register` fails, the
> > function directly returns rc without performing any cleanup.
> > Similarly, when the `channel` has its default value, the function
> > simply returns -EINVAL.
> >
> > Given this, I am wondering whether it would be a good idea to
> > introduce a cleanup path. If so, should we ensure cleanup for all
> > possible exit points?
>
> Yes please!
>
> Thanks,
>
> Andrew
>

