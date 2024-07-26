Return-Path: <netdev+bounces-113293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F993D933
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 21:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82E21F2125C
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE944C76;
	Fri, 26 Jul 2024 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L6iU35Oa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF54AEE9
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022910; cv=none; b=TH0OGxI51vd6s4ijm2TBZttlbIKi5AyxSYhmAJiO5coXd+tveXN3crvlrPDRU4hKMscazwBHpEAx2gmW9g+GOAQ52akrKgtyEMn8R0FBBNB/U6owJ4kz21fLSRD3hYexX/hvI47SMUPdCf7VXOnjSdp78qWTaaMOT//KsP8eU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022910; c=relaxed/simple;
	bh=eV6Yy+/c65ODYtFWkt1GujLZCm0b2U+qafWEg50toGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5c8NSwE9BRCSgyKSi4/rbr2nFMCS7KNIn3z2o0ab8k+2/fuIZNUNGsdW2bgts8tgZy4HEQmAe1F8fYA+KdcU5+MtQptTGDz3phvUPsJMNSxK3K3kpD1w+gT0zgWKLbIQRe9Vz2Lw9V/m5QvYPTBDfvLIY8Sjn6jQCvrdSKWzdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L6iU35Oa; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e05f913e382so37574276.2
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722022908; x=1722627708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HARFxWIFPEm9vWTWeOJWegog5BOk60egFlOmdNasrqk=;
        b=L6iU35OajprD93F0DF48GWaFc4C0PcmmMrtY+KFxsAN7bmaCdiGVulqDRNqnwMXXDa
         ntI0CXrHOxKtOE1MlLQdFhs81/0uxFlrJviQOVuq2CKBeIqibGerKAQf4xbXpXLx9mqe
         mbTJ7B6CG1DZJvh7KGO4eSadRwc0pFW9V1ZRy7uMY/60qlGFpGvhqk+GknaGEBxk7w9r
         RtL1GpNKQwbhlL5M0nqF0mgcFHM240y569gbET31gmMs5fzXRL0no6swn2tPaFKAodV/
         CBOQ7+AOusevT/k+bd/MdOWqs2x3X1/pUw7XpxQYfxxJlft4Ko1r/4t+Sn1wzzxBc+Rr
         8iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022908; x=1722627708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HARFxWIFPEm9vWTWeOJWegog5BOk60egFlOmdNasrqk=;
        b=og+o3taEAelIoMaXP+ic4lJEzvjtnsU0Oj08crPkE84YzG3Kyjh6HbvkKx8No1pFlh
         hAaJT5cHNt4A4G3G6CdZ9ng7jzMl9YM46nt8kNaUzKb6UT+yLq06ucNgZD6qqon1QDg6
         hdb/BdzsU+Rrf9WufZzOWZ5ed5CilPzLqr0LwaimqEB6oAvvmmsnvI0i04lCasEDk6gs
         rKwRq/I4Xn47aCXTyUppU41ap+RBVNgMeSPbMwU7G/mmjU1mKbj36sztPS5Me2b5T2FA
         9lbUCrpTPCyiyj/PCXTaUoICNIUU5pqpafY35YdDqNI5aoRkSYh5rKSaZLF9/BmCMLzP
         39nA==
X-Gm-Message-State: AOJu0Yx/MllB90qLppuvW+p3Ad1v1oYSzyleEkfQikUNRQqMQl8V7/O6
	QyUgpRmg7gN88WmbRWt8hxoD5aNAEj1cclh8YmxHvJpdHl8nGUAC72Xw8nFdguf09CsjqzhxED+
	eRADSvkKa+wc+2Rb/Ko6qmUHLxDp78fZPMHpL
X-Google-Smtp-Source: AGHT+IHT02FMlg0Pdb4O1dWACOWR5w+ot1eBVewHBOXgqkXnR8YtOLgmhvt0jxizos97VmglFufrpBqIct6MnrWAuUM=
X-Received: by 2002:a25:c502:0:b0:e08:6bb2:ed3d with SMTP id
 3f1490d57ef6-e0b54403a01mr868535276.12.1722022907866; Fri, 26 Jul 2024
 12:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
 <CAHC9VhSRUW5hQNmXUGt2zd8hQUFB0wuXh=yZqAzH7t+erzqRKQ@mail.gmail.com>
 <1902e638728.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAFqZXNsQQMxS=nVWmvUbepDL5NaXk679pNUTJqe8sKjB6yLyhg@mail.gmail.com>
 <CAHC9VhTwFyMhYK448gBpwO7M4bEBCOq-f=-ztn1vro9nQU9v0A@mail.gmail.com> <CAFqZXNuwruVUeLV8PKBbxBqa9ubbvE+NGVnOumzH+BCXcRNZBw@mail.gmail.com>
In-Reply-To: <CAFqZXNuwruVUeLV8PKBbxBqa9ubbvE+NGVnOumzH+BCXcRNZBw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 26 Jul 2024 15:41:36 -0400
Message-ID: <CAHC9VhT4BSKfdgbYNnXsXkwrqxPAuEuJFf6tYYbMCPq4JxK+Jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Thu, Jun 20, 2024 at 4:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jun 20, 2024 at 6:03=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > On Wed, Jun 19, 2024 at 4:46=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On June 14, 2024 11:08:41 AM Paul Moore <paul@paul-moore.com> wrote=
:
> > > > > On Fri, Jun 14, 2024 at 3:20=E2=80=AFAM <patchwork-bot+netdevbpf@=
kernel.org> wrote:
> > > > >>
> > > > >> Hello:
> > > > >>
> > > > >> This series was applied to netdev/net.git (main)
> > > > >> by David S. Miller <davem@davemloft.net>:
> > > > >
> > > > > Welp, that was premature based on the testing requests in the oth=
er
> > > > > thread, but what's done is done.
> > > > >
> > > > > Ondrej, please accelerate the testing if possible as this patchse=
t now
> > > > > in the netdev tree and it would be good to know if it need a fix =
or
> > > > > reverting before the next merge window.
> > > >
> > > > Ondrej, can you confirm that you are currently working on testing t=
his
> > > > patchset as requested?
> >
> > [NOTE: adding SELinux list as a FYI for potential breakage in upcoming =
kernels]
> >
> > > Not really... I tried some more to get cloud-init to work on FreeBSD,
> > > but still no luck...
> >
> > As mentioned previously, if you aren't able to fit the testing into
> > your automated framework, you'll need to do some manual testing to
> > verify the patches.
>
> Sigh... okay, I now did test the scenario with a FreeBSD system as B
> and it passed.

Great, thank you.

> I'm not saying the concern is not credible or that (in general)
> testing this use case is not important. What I'm missing is some
> explanation/reasoning that would make me think "Oh yeah, these patches
> really could break this scenario" ...

One of the challenges to network testing is that you don't always know
how other network stack implementations are going to react when you
start getting into corner cases or lesser implemented protocols.  You
just need to test your patches to make sure nothing breaks.

> > > You see something there that I don't, and I'd like to see and
> > > understand it, too. Let's turn it from *your* concern to *our* concer=
n
> > > (or lack of it) and then the cooperation will work better.
> >
> > It's not about you or I, it's about all of the users who rely on this
> > functionality and not wanting to break things for them.
> >
> > Test your patches Ondrej, if you don't you'll find me increasingly
> > reluctant to accept anything from you in any of the trees I look
> > after.
>
> Paul, I don't want to break the kernel, but that doesn't mean I will
> do an excessive amount of work for someone else when there doesn't
> seem to be a logical reason to do so. IMHO, just because someone
> somewhere has a special hard-to-test use case that is very important
> to them doesn't mean that it is your job as a community project
> maintainer to force other contributors to do work to defend these
> peoples' use cases.

I have a responsibility to ensure that we provide a stable, secure,
maintainable kernel that is as bug-free as we can possibly make it.
If I see a patch that I believe warrants a certain type of test to
help meet those goals I'm going to ask for that testing.  Of course
like many things, even things we believe to be very clear, there is
always going to be a chance that disagreements will happen around what
testing is relevant or necessary.  How you handle that disagreement is
a choice you will need to make for yourself, but I would encourage you
to consider that more testing is usually a good thing, and aggravating
those who review/ACK your patches is generally not a good long term
strategy.

--=20
paul-moore.com

