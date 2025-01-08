Return-Path: <netdev+bounces-156426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F9A065A4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146771888E85
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB520127E;
	Wed,  8 Jan 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TmnHBpFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459C19ABB6
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366210; cv=none; b=l3upEhtF9nq3gzd7xItPVIUxEh1nn+kl9M2wHm0vwo1zVT/xmgLyyIkJivqG93KBU06bbw273o+9XJhZX3gn+4y/9eZMMXDwXVOdfTyq6iP1RparAfNZR1XLnduimpEext+RtSfMn3fXifTJAHBSvcG9Oo2RAOv3a8rv7EcTpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366210; c=relaxed/simple;
	bh=fWkq2Ry7gq/nExb7Ac4tXYG5/DUfjevhsswBM8svATE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phiKO+yyHtsk5ObHiib3dIxZe+bDhQYGeOYXcliQafVbok4t2J/Z4uCnwhjzPv8y2PZcjiMZAe6Df1XRzTr5KXNsUkJEQSEqM0uFpojqMqxV6WRUDRnwqn9wD+3aG9Dlzyk3uy0rV50AZKnNiNTF3N+rU2CEbHeL7pDkG141JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TmnHBpFl; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3022484d4e4so888041fa.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736366206; x=1736971006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2EYNaFMuEi7gJG6lM4v49TAeFTWkkV0YaEiWcbQBDw=;
        b=TmnHBpFl7xx0DnlpNguOh1bRB6puGX34oZa0SfaDr8M1V0NQD26RgUKPjEvl4MEUMj
         IAFa+e8KzNN9JwTuvdrF2C0UvEfQA7Rx8aUGf/7r4mc54MAwM38nKm2q1qjby+wLTUa0
         Lgj/38QJw62+SWB85sH+3zdKTMFZp+pCyV1ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736366206; x=1736971006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2EYNaFMuEi7gJG6lM4v49TAeFTWkkV0YaEiWcbQBDw=;
        b=wbXHtPy+4nKE5gLqwokWtqn/O8L+c7JI0FEYU50I/3J1t+ugrnzrXOFGCEnKIIlpAh
         xVsu3DAragiQxj6yWk1/VJN2OxFY/eGb/g7w+7G7so/Av6RW1qTLruzN/jQJKE/KPhZl
         LqpjRN90Ol5A09BjF++YoOm2L0wnBIQGjwJVfzjcQQtZ4Xlbst5b5Yh8EO+2HiFfbm9V
         D27nzYKhY0IZ95hD1jl6+K142bfP3yYSvnYZKwx0IsGAZE+2SIq1h8o7JlPFRNawzyeM
         DZn4JXPQfbotF5Zy6l4KtOntpHDZ0pCSYWljy87d0fuYX3TAMDnjT58OVoiih4exo/eN
         a+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYigG57HUIuyEX5xKEi/LRqmGh8eIgivjFgluTdxPK3JbidtNC4SrAOEhkX7Kkmr9eWVy5scM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Y5GQ6CjGI2mXjAQ0m3/Z7+wO4+IZ1OvEzUYsQqFRtKpthBCn
	AszbglsEoVr64/Q7doS+S/BqKJ8QNCqOa+f0iM5z+4kSIXeMm85XXQQL8H0qoZJWX6uJvuHYsnM
	bzMS0hmfIF01CuJ5sryQMKHlsmsLUS4tHULjw
X-Gm-Gg: ASbGncsxNCef8JT9V1AZTSdRocgh5O9mVJ8uTB0CyCzBO+XV83yUxWONt+Rinhwz30W
	+cuc7Rjwl5SIwAB4nV2czf8/HpEiKUazMfqBH7Q==
X-Google-Smtp-Source: AGHT+IFNJGm9HfHOfxxUk2mG33MjpwnqogwU+ysbnjaVFZYxCfbIpp9yJNnmCoOlQAXGf7JUvw70Ig5f0D4owNk+WNM=
X-Received: by 2002:a05:651c:e02:b0:302:3ff6:c8db with SMTP id
 38308e7fff4ca-305f45b8cffmr8397761fa.24.1736366206348; Wed, 08 Jan 2025
 11:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218203740.4081865-1-dualli@chromium.org> <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com> <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com> <Z37NALuyABWOYJUj@google.com>
In-Reply-To: <Z37NALuyABWOYJUj@google.com>
From: Li Li <dualli@chromium.org>
Date: Wed, 8 Jan 2025 11:56:35 -0800
X-Gm-Features: AbW1kvakBnClUlcgk4uS_9GFWwaQ6OEmfl-h6IqXJUGhnMaRbsWLcXbmu_4LXgQ
Message-ID: <CANBPYPhEKuxZobTVTGj-BOpKEK+XXv-_C-BuekJDB2CerUn3LA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
To: Carlos Llamas <cmllamas@google.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:07=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Tue, Jan 07, 2025 at 04:00:39PM -0800, Li Li wrote:
> > On Tue, Jan 7, 2025 at 1:41=E2=80=AFPM Carlos Llamas <cmllamas@google.c=
om> wrote:
> > >
> > > On Tue, Jan 07, 2025 at 09:29:08PM +0000, Carlos Llamas wrote:
> > > > On Wed, Dec 18, 2024 at 12:37:40PM -0800, Li Li wrote:
> > > > > From: Li Li <dualli@google.com>
> > > >
> > > > > @@ -6137,6 +6264,11 @@ static int binder_release(struct inode *no=
dp, struct file *filp)
> > > > >
> > > > >     binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
> > > > >
> > > > > +   if (proc->pid =3D=3D proc->context->report_portid) {
> > > > > +           proc->context->report_portid =3D 0;
> > > > > +           proc->context->report_flags =3D 0;
> > > >
> > > > Isn't ->portid the pid from the netlink report manager? How is this=
 ever
> > > > going to match a certain proc->pid here? Is this manager supposed t=
o
> > > > _also_ open a regular binder fd?
> > > >
> > > > It seems we are tying the cleanup of the netlink interface to the e=
xit
> > > > of the regular binder device, correct? This seems unfortunate as us=
ing
> > > > the netlink interface should be independent.
> > > >
> > > > I was playing around with this patch with my own PoC and now I'm st=
uck:
> > > >   root@debian:~# ./binder-netlink
> > > >   ./binder-netlink: nlmsgerr No permission to set flags from 1301: =
Unknown error -1
> > > >
> > > > Is there a different way to reset the protid?
> > > >
> > >
> > > Furthermore, this seems to be a problem when the report manager exits
> > > without a binder instance, we still think the report is enabled:
> > >
> > > [  202.821346] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821421] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821304] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821306] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821387] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821464] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821467] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.821344] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.822513] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.822152] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.822683] binder: Failed to send binder netlink message to 597: =
-111
> > > [  202.822629] binder: Failed to send binder netlink message to 597: =
-111
> >
> > As the file path (linux/drivers/android/binder.c) suggested,
> > binder driver is designed to work as the essential IPC in the
> > Android OS, where binder is used by all system and user apps.
> >
> > So the binder netlink is designed to be used with binder IPC.
>
> Ok, I assume this decision was made because no better alternative was
> found. Otherwise it would be best to avoid the dependency. This could
> become an issue e.g. if the admin process was to be split in the future
> or some other restructuring happens.
>
> That's why I ask of there is a way to cleanup the netlink info without
> relying on the binder fd closing. Something cleaner, there might be some
> callback we can install on the netlink infra? I could look later into
> this.
>
> > The manager service also uses the binder interface to communicate
> > to all other processes. When it exits, the binder file is closed,
> > where the netlink interface is reset.
>
> Again, communicating with other processes via binder and setting up a
> transaction report should be separate functionalities that don't rely on
> eachother.
>
> Also, it seems the admin process would have to initially bind() to all
> binder contexts preventing other from doing so? Sound like this should
> be restricted to certain capability or maybe via selinux (if possible)
> instead of relying on the portid. Thoughts?

This is a valid concern. Adding GENL_ADMIN_PERM should be enough to solve i=
t.

>
> --
> Carlos Llamas

