Return-Path: <netdev+bounces-113149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF4F93CE4E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 08:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF43281F2E
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3E17624C;
	Fri, 26 Jul 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPNaj7X3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64762176226
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976664; cv=none; b=IZh14b6yiIw7sqt2qJbQrcwMwFUQMaAfJ/j9WM7liDOAnAhh1XYtMDJ0eUxYNgHFyF9R3uTcef8K/C70ZDv9VEZNZLNTsvkrBHf/ANd5yCwq0v1s7OxQC9Nfp62tExUt+mVPwezDIDU5ELiJErte4x3W0AYZcbRFL5yr0zBppXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976664; c=relaxed/simple;
	bh=bOrdCKvguQC+YaB6h3s3lVZl3WBnLHpu+JUwcZnQ2Yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdvWJa1dol5wDwhJyyY+Ws2qQNu0HlfZ+c/1KukF9t9m1B1Q3LUGIid49Zw3c1AVzNsXY355Wxy8OV9VJAfjh7ralOuPg49nQMUH6kRdD+c3zqZ9Esf+uNrWZCe0aPVz4CaYX7o1joW9VM9F3mPNVsevxGVLoyQKrjMJ6UNxJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPNaj7X3; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a7ab4817f34so110468166b.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721976661; x=1722581461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOLKGqHkSptnv/m/NuKOIAdG2X8Tq9WhgZPqQX5CUc0=;
        b=zPNaj7X3MPrXXKLeAhH81dfM7r6V0xFDhGQZzDA/ahW/OkNVDLkBfWPg2BBCtzlKRt
         lXnz4hBHeMf0zAiklYgwQtLglygTrbaMozjtK2BUyNvOdqsoLUG7+O6gd7GYB7CzVDCJ
         HRlJUowJYSA/fp5F+L8c2IOo4ZIGmsB90huOCaFsvhoQoEI8g91rb8pQRWUkLWoELlkJ
         JKLnRoJc0tf16Q/k1nXNcEyMDu4NA5Fbpv5qhshr5mlfih+HOyVr7LLRi5Vx+pHiaEWT
         Ebn65HQrOUpIqr5uIfUABuS0XiMnXWJUTxnRawv3k7sZfcYp81nPFemCEw1IDUvrVxRR
         43XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721976661; x=1722581461;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOLKGqHkSptnv/m/NuKOIAdG2X8Tq9WhgZPqQX5CUc0=;
        b=r4PWzbZ0NM8m6+EUjlxbZK562B2iOi9sfMtXoWEo6xxthK2uZH+Y4ophQhfNl+iQYE
         JvwCfYlGIaxqxI/EreMpL8lCMo+BZ+xr98fWi4UHJhtRthn9P0JDwtpiQpRl7Hfh/6bp
         x58qa3uUSh5PhicKUacav1EYl5Ju8KcVW75pdNWXHwTTvSaOleayqyYEmLLPH5LxX0mW
         4aBsI8YkCagGyVfuUxrCOQYf8OOMO8XSTj4fgvhqpnCqFO8mSxC3lWgHM1YWq0BM3E48
         BAyElf+6IIIARn+q35vhoV9XmWruUyNr3v9yGMaPbcEXrBCK7m9Z4mZmLrw0rIXkVPDr
         xNHA==
X-Forwarded-Encrypted: i=1; AJvYcCXH66n4nfciraWtPFroy489TqbdFDX8KJSzy4cUq6BL0aqtu+QHbfS2cMqZVgmOMZoyAL92r98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWqhDGyoH4AonOsmGxweQkBRp8qUh5guzuyRe1J4nCMFfBFy+
	AuhXoOQ7/TnoA18Dj5x68yx4MqTdFVD6T8WjuglJ6JCiOmdpUV19f4BJAj7GxKtNi7uv2M1dcPP
	ylQ==
X-Google-Smtp-Source: AGHT+IFx9VhTiVJ6SOadIa9dxcURzunfi3a2JEINT2ESVsbZ2/OWjU51l+q8FY6uKZeu50wlnGWFGbQrjdc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:dff1:b0:a7a:825a:de55 with SMTP id
 a640c23a62f3a-a7ac51735d4mr300366b.5.1721976660485; Thu, 25 Jul 2024 23:51:00
 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:50:58 +0200
In-Reply-To: <20240725.wahChei0Hoo4@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1721269836.git.fahimitahera@gmail.com> <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
 <20240725.wahChei0Hoo4@digikod.net>
Message-ID: <ZqNHQcqPuMUUjOc9@google.com>
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 04:18:29PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.=
c
> > index 03b470f5a85a..799a50f11d79 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> >  /**
> >   * sys_landlock_create_ruleset - Create a new ruleset
> > @@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops =
=3D {
> >   * Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at =
boot time;
> > - * - %EINVAL: unknown @flags, or unknown access, or too small @size;
> > + * - %EINVAL: unknown @flags, or unknown access, or uknown scope, or t=
oo small @size;
>=20
> You'll need to rebase on top of my next branch to take into account
> recent G=C3=BCnther's changes.

Actually, I have missed this particular line in my recent documentation cha=
nges,
but I agree, we should follow the advice from man-pages(7) consistently -- =
the
preferred style is to list the same error code multiple times, if there are
multiple possible conditions under which it can be returned.

(Please also fix the typo in "uknown".)

Thanks,
=E2=80=94G=C3=BCnther

