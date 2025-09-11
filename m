Return-Path: <netdev+bounces-222103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0BB5315B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51535164E94
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27672DEA9D;
	Thu, 11 Sep 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnPnn9lN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65C3164B8
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591308; cv=none; b=m2Wkwmiw/bIAVeSBv3/yIpdXybtJ00dAJQR8g4w0tc97TR9RW8t4JJD4DR2iREFncSejz1ji+34Lws5H7604rryZ/C9zzR5yOgcoEeRih6aB4LIVzTCOmNV3mChGW+8sIT7Pn+bDC0pCqEptq2G01A9QCGD2KJuJuoHpn1uNdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591308; c=relaxed/simple;
	bh=EkTK2XTSrHY3G5pm+FqDACFPq7N6pH7nHaRPNHNccS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb8qt/z4+NdPF/45cVfZAuOW/KxjaP7AcZr2RpfK00aTdXv5KwwCAKBrmyl8S5cHEC5I7ipSutYCFNWNThlhqpDPhEpRuC3uI2DWIKj/8PwI2giFlAcvyDB6NyB0CDkG37i7GS9eApIsDjlv9/mQAXHuu/gB2NiMz9anGpAibHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnPnn9lN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b042cc3954fso112738166b.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757591304; x=1758196104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkTK2XTSrHY3G5pm+FqDACFPq7N6pH7nHaRPNHNccS8=;
        b=WnPnn9lN6UEVALTkokHcSJwnGGCtTn2FndHOFVjUteY97stitD0fRCzqDQ0CuW0suu
         bnab8Xl22IG1J3rTS3LjYh4TPcO8KG1xSKh401ZBxtn4pCMI3lZe6+B1taDKxNGzcLBU
         jdm7/TkBM+ZobyrdQ+l0lyNwolYvSD7eJi2IPKaA04QjUkJyViB/DExHxD2KrQEdEQsm
         TEo8FTuZhY+yvchYdh4Okg+H4kyievNtVumu8rfeBJPqWTy9wzV05JJL+95FY1OZupxC
         /72RUfh7HZADmoAg7W3eUYtIWh0hDSxfCYwKn9xbZ84gSR0mMuf9XGAGnVZT3/zzB0gD
         gmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757591304; x=1758196104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkTK2XTSrHY3G5pm+FqDACFPq7N6pH7nHaRPNHNccS8=;
        b=ladvcsxvD9XSvPeiSC6GfPpgBi2VhraGqISESxB0/4a796Sxi/ndWu7SSlDBZ/bnqo
         Hc5MbUhhkfxdCbGFpTZG4kXABYPxEMT7T7WX0KkMas2zS3OKPmqkj72NE6ZUfRFf0QDD
         DY6uxX3tIVyj2G8tcuszeF4X3/SoiyZjjOarYfgd2SI12hdet0SPSU+tSrCu43RU3QzK
         6o+uM2DeW6PGEwnBFQ2xaFMyagLl0IbZNN8fUgEwqAwBzIFglGgfoTg0ASD0PwRs1UAs
         OVdO+qCcTte9kijuUTXAE4gWHs9UHw3WYeCMV+ZpAskqwY2q7UZLw3EtRzdonEiAUc4O
         GqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiVniy013yPtJ+gCmsmPOkitppYCxc8ZiAEjcWbqFiTY9imUbD0J1Qt7k6ONvxbIxkobshIc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Xcs5KKPruPAelGOzUggpQpLlCZ0n/2lHU6Cw8GiHPJoY4BX8
	/JbI9fpobwOwNyWCxnMmHUxQGSKwP4B47Q6cHG4zHaMT5ciZmGbnfL0BHqpYHdvOHA+lss1FVze
	R/61I+DH9Y/N8UvGJr6ttVe3H0XEklnE=
X-Gm-Gg: ASbGncsmfAfLrLOZvZ9UQOryzxldd6K3OmSfEnHObzg/WQYRlwBVJ6ieWZazY6cqKo3
	okjp+LXcuc8H/PDRfCMTkDp+x8s6kV9xsbksYu8WotZRL2P9xkBsPG1EZWgvyQ9tK9QZdlYNL0M
	j80ECXUOqb2RdIyhw6HXr5B3qzVDGy6Y0lerqG7wuPXHYhG3HBOOv20ol3XzDR3Mzt9SLb/JSQH
	wnt+DJ7SrTwupSmkw==
X-Google-Smtp-Source: AGHT+IFo70V+ej40+aX5Z/eRHJRCaW/Iqhahk/Ha781IK84/veOVnzt9N3EBI1U+cUalJ9ig/yIFZ2KLCeQ+wQEV8Cg=
X-Received: by 2002:a17:907:e98b:b0:b04:85bc:a926 with SMTP id
 a640c23a62f3a-b04b13fe4efmr1871379366b.11.1757591304254; Thu, 11 Sep 2025
 04:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-32-4dd56e7359d8@kernel.org> <CAOQ4uxhwJBLCzfKs0dVFOpcgP=LQU5hkRxVeLLR6g-qOxb9ocQ@mail.gmail.com>
 <20250911-ergriffen-autopilot-7e0488c135c7@brauner>
In-Reply-To: <20250911-ergriffen-autopilot-7e0488c135c7@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 11 Sep 2025 13:48:12 +0200
X-Gm-Features: Ac12FXzjtgrAdVd9rTS0ov85U74TI4ZgGunYM07J1bauwFv-Hur8qy96NfA8slA
Message-ID: <CAOQ4uxh9mWHYtP6JdvW6HEPgCqe4=3pcJ0V4SVa__8i_EFxUmw@mail.gmail.com>
Subject: Re: [PATCH 32/32] selftests/namespaces: add file handle selftests
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Sep 10, 2025 at 07:30:03PM +0200, Amir Goldstein wrote:
> > On Wed, Sep 10, 2025 at 4:40=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > Add a bunch of selftests for namespace file handles.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > Obviously, I did not go over every single line, but for the general
> > test template and test coverage you may add:
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > However, see my comment on file handle support patch.
> > The test matrix is incomplete.
>
> I mean, I'll just drop to non-root in the non-cross ns tests:
>
> /* Drop to unprivileged uid/gid */
> ASSERT_EQ(setresgid(65534, 65534, 65534), 0); /* nogroup */
> ASSERT_EQ(setresuid(65534, 65534, 65534), 0); /* nobody */
>

That would be good I think.

> > Maybe it would be complete if test is run as root and then
> > as non root, but then I think the test needs some changes
> > for running as root and opening non-self ns.
> >
> > I am not sure what the standard is wrt running the selftests
> > as root /non-root.
> >
> > I see that the userns isolation tests do:
> > /* Map current uid/gid to root in the new namespace */
> >
> > Are you assuming that non root is running this test
> > or am I missing something?
>
> No, I'm not assuming that. I just need a new user namespace and become
> root in it to assume privilege over it so I can test that decoding
> doesn't work from an ancestor userns owned namespace.
>

With dropping to unprivileged uid/gid in parent, I understand it should wor=
k.
I guess I wasn't sure if dropping to unprivileged uid/gid was required for =
the
test to pass when the test is run as root user, but with the addition of
dropping to unprivileged uid/gid - feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

