Return-Path: <netdev+bounces-104996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD190F697
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283C81C2419D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360915886C;
	Wed, 19 Jun 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5dLTt8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913F15746A;
	Wed, 19 Jun 2024 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718823579; cv=none; b=hXy3EhIpi4an/DUdR8jTJJiyEOo0gXcV8KyZXsQBuhmtdelgGo0pg0vhRk/osAcoR2OAQsadF0ZoGjauG51W1yQLuKseklXUCARoPT5kUOob+43+TA0GOuyxSrD+IQn4+wmhu83DkRkHKDV5snr5kWI/sqWAD412pcLZ0WxyJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718823579; c=relaxed/simple;
	bh=AbDCZR6rtnoVh3Q+LWHr4xNPU33oG6JRD0p+ibkqUTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKEZ6bcCp3RaVGc+avtq4j7/UsXmuHbs5xEE2Si6t3lOQQ74w/d12/6vvkLorsKqCw/h5H+JQqce9q44wzoHs58A9+JJ7dxS/AW4shN2B+qIGsAA8OvXNHgo6U6B5LNs9AneZnaeLebTxKcyLshN2PGXbGX4IEKPrW/Si1Lnsx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5dLTt8O; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso690141fa.2;
        Wed, 19 Jun 2024 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718823576; x=1719428376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZenQCaH+ZdCQPpWoM19NHpqEacZDxEuvdit/MjorSCI=;
        b=L5dLTt8OMpfdQiO8gop/jHjbqtUXVZDBH5pG+b5uRrYuYDlo3ZThleSwoCMdNiRZzI
         KKqLDTjRUNYPipCiuVZwKXOAdDmfYD+4L2Mw/vl868M0OF0KVzntUajTJDPVpLYXx6Uy
         8TX0/qGtYz0hMlBziVV+iK87ctFaCcWtdeypLZDJX/pEthhvc39dGZjcvpjgihp+l6QP
         0uVhE2VJeljr81ZiFQIVmqnj+xwYLgnjMwVglsZzwVsQ+W+1xveEENhz2qu5wu4kXMdz
         Pi6o8cNTVNpiVAZTe7wWPDQFodb59cpzmq9ZYDCd4JcjpLc/MbAYMxP8v6O8qNMfZVJG
         G99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718823576; x=1719428376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZenQCaH+ZdCQPpWoM19NHpqEacZDxEuvdit/MjorSCI=;
        b=QQF6IUn2aG2iOtAuDIqDEg66u3ihUHvPfq8Q6IhmFeKxiBirex3+H3XXPbyJ6VX+Wz
         p8SCEaOZu3h1KAqUUJydwJIT9vgExyx/pXlGFHFd3NbKTDRrR6sixeZWLvLn1GkQPjR7
         sqDfL/Zr6pgssQbjg5hRPqfSTxHK/bXhbPYM/LO4YjedYKeZbz6T07cG4F9KfwrspCCk
         nNmIkP2tM88UE5kQzAaS1xen8N6KYetUsqGbLG+k25VniU0UnZsfOKpKgmfrmJlQXk8H
         b98eoK3dhNvNBwIatI5ocfdyTGbFyys1x5XI8g4/5+dWyxdUKiOZ0CKDEq83CQeNsQEj
         hEbA==
X-Forwarded-Encrypted: i=1; AJvYcCWjzH0Nb88eWzy+/x8UFBqQekZOqn6AmK2kKq7o8wnnXWTvg3f7rL95h9EN9Vs08M27BOVke7R5TedzVKZPO9GpFkbdZYKDnEIsR1H3oO9g+EJ6L8w8YKl2gm3yVyCRmAuG5OURov1HSnB6h9D9uiRQ8rFWoN0J44hQM5K5gwWMoWoODVaiR1hdC2iA6ldbyL4YNL60RanTXTPF9SEfFxXuwg==
X-Gm-Message-State: AOJu0Ywdx+NRwjT3GcwPRq9scf98FkiARMYbnTEAqQkUQE6jyVKELtp/
	8tIbGlFwzvCEtxi8QXRBBYZZ2NaTd60trJ5GAjb7m2YP5Ahkfvtu7RAUIfc0Z/wOk2qqiMmLHsu
	aBnrVjPobLr5Z2NUNOh5KEmFGNbrx+cu/
X-Google-Smtp-Source: AGHT+IGoHkVG4a4nmBiilF1j+3f6y8TethA+TK0xS0ef6S14rvGX0+Quf84zWgVHRtxJEOPdCpZRjTkzuZNWpcTihEo=
X-Received: by 2002:a2e:989a:0:b0:2ec:21cc:ca6f with SMTP id
 38308e7fff4ca-2ec3ce94139mr19700521fa.17.1718823576005; Wed, 19 Jun 2024
 11:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
 <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com>
 <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com> <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com>
In-Reply-To: <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Jun 2024 14:59:23 -0400
Message-ID: <CABBYNZ+7SrLSDeCLF0WDM01prRgAEHMD=9mhu5MfWOuGwoAkNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Wed, Jun 19, 2024 at 3:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Jun 12, 2024 at 5:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Bartosz,
> > >
> > > On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@bg=
dev.pl> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Bartosz,
> > > > >
> > > > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <brgl=
@bgdev.pl> wrote:
> > > > > >
> > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > >
> > > > > > Hi Marcel, Luiz,
> > > > > >
> > > > > > Please pull the following power sequencing changes into the Blu=
etooth tree
> > > > > > before applying the hci_qca patches I sent separately.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-kernel/20240605174713.GA767=
261@bhelgaas/T/
> > > > > >
> > > > > > The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7=
356688ffa670:
> > > > > >
> > > > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > > > >
> > > > > > are available in the Git repository at:
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git =
tags/pwrseq-initial-for-v6.11
> > > > > >
> > > > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f42=
869128dd:
> > > > > >
> > > > > >   power: pwrseq: add a driver for the PMU module on the QCom WC=
N chipsets (2024-06-12 09:20:13 +0200)
> > > > > >
> > > > > > ---------------------------------------------------------------=
-
> > > > > > Initial implementation of the power sequencing subsystem for li=
nux v6.11
> > > > > >
> > > > > > ---------------------------------------------------------------=
-
> > > > > > Bartosz Golaszewski (2):
> > > > > >       power: sequencing: implement the pwrseq core
> > > > > >       power: pwrseq: add a driver for the PMU module on the QCo=
m WCN chipsets
> > > > >
> > > > > Is this intended to go via bluetooth-next or it is just because i=
t is
> > > > > a dependency of another set? You could perhaps send another set
> > > > > including these changes to avoid having CI failing to compile.
> > > > >
> > > >
> > > > No, the pwrseq stuff is intended to go through its own pwrseq tree
> > > > hence the PR. We cannot have these commits in next twice.
> > >
> > > Not following you here, why can't we have these commits on different
> > > next trees? If that is the case how can we apply the bluetooth
> > > specific ones without causing build regressions?
> > >
> >
> > We can't have the same commits twice with different hashes in next
> > because Stephen Rothwell will yell at us both.
> >
> > Just pull the tag I provided and then apply the Bluetooth specific
> > changes I sent on top of it. When sending to Linus Torvalds/David
> > Miller (not sure how your tree gets upstream) mention that you pulled
> > in the pwrseq changes in your PR cover letter.

By pull the tag you mean using merge commits to merge the trees and
not rebase, doesn't that lock us down to only doing merge commits
rather than rebases later on? I have never used merge commits before.
There is some documentation around it that suggests not to use merges:

'While merges from downstream are common and unremarkable, merges from
other trees tend to be a red flag when it comes time to push a branch
upstream. Such merges need to be carefully thought about and well
justified, or there=E2=80=99s a good chance that a subsequent pull request
will be rejected.'
https://docs.kernel.org/maintainer/rebasing-and-merging.html#merging-from-s=
ibling-or-upstream-trees

But then looking forward in that documentation it says:

'Another reason for doing merges of upstream or another subsystem tree
is to resolve dependencies. These dependency issues do happen at
times, and sometimes a cross-merge with another tree is the best way
to resolve them; as always, in such situations, the merge commit
should explain why the merge has been done. Take a moment to do it
right; people will read those changelogs.'

So I guess that is the reason we want to merge the trees, but what I'm
really looking forward to is for the 'proper' commands and commit
message to use to make sure we don't have problems in the future.

> > Bart
>
> Gentle ping.
>
> Bart



--=20
Luiz Augusto von Dentz

