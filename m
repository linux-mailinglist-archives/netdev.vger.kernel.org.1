Return-Path: <netdev+bounces-105017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7C90F70C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E351F256F2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F4B15B96E;
	Wed, 19 Jun 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="inQXRDYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F90B15B0EC
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718825641; cv=none; b=W8kvWTnB2qXYGFU6KJTG7/5+uNN3a4BYrSsBT6XKXrZj4NsgjeLYhoPAfe80pNNsyEfpKsVby91aC8zDSt1P76dWesa2TNIr7m7aJkXe1dhm54rQFHXXCCH1Ae4XsxUEAhcDz9ITb0Dn8S+steu52uzOUdQRsE6eF4GcalxXHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718825641; c=relaxed/simple;
	bh=nJhUYmrgF8khp038rH7E0vBosSYGyEPbRCtSDy5hfRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l66emza6mnuSXs1CO3WNJGuH/5FCUhSK1bg8hOVFKEC/YaDue5esuNq9hZm6Pfi75rEuaCUW8Un5vOTvrAcKqnG4JVXlPHj7wAKB8npgt7ZdzngiLgyfpaj6cRbSF4js5akqeGtiKqZzHmql41Kil10gQ1yKcsWhVqQ73K+q8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=inQXRDYO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso164745e87.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718825638; x=1719430438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rGUjDMYzm7lFpUwAY5iZvI8fijhYwMrH7RYSZjeZEU=;
        b=inQXRDYOFIhYsrTKtCMzRobUh+zh/GvRqecGnewBpBFbeXmF3OXBvXKXCvSxQ62wHX
         7JKQKoGfW33UrMopeFE4oia2NC4F0hyGnjxqbV+6ev+rr05GEr6TSkaH805CgQaI1J+V
         m5P+TBDbMkJV9gps3Um/4iX/obTU+oFDmnBlFNLZk+goHrNy/KbLkZ13IFp5t08v4ZBf
         jjkNmn2Tdb+ekmcD0cBjqybQe0RwpMJagA5Kwog/hV9OquKiZx5SbXGKCaICmI0sA4eW
         DEA2lLPTr3VARUFENgRVXF1GYZWREZnJ+AE9csuw0KOTOAzBBN/DKXQ1bnkF4QSWir6x
         YCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718825638; x=1719430438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rGUjDMYzm7lFpUwAY5iZvI8fijhYwMrH7RYSZjeZEU=;
        b=TFHMyEaa02mHAQnBSlUeAjbZy2tNZhVNp0dJXEmmXGYna+FM8V4NlB4JBLICtyk9b9
         1Dq+acHiIz8nwZVthwFiVTr/y5rkYyRo2yqi0Vu/3he7BZ0BrXoY+fJQ81NdTPpnf8PS
         SEOCNhFtgI6BCiz53B4shkN08sdz0pYUo4lijVwWJGHIbzXbdhyxOrpK3VqSnm3zHtgR
         Ej5ewWiXfmgjKaceyDWPp+pqavVg49johQHe63wYUKHd3vmQG60+109Iu4NPsfYai6V0
         NyDnnMJh/LaptLk/dgytiRwQ99NtJB3AzFkIaahdajUOZGs73If/vuQMmlTNyKReHsdJ
         8stQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5/L1NZQA4OhCbh/TwqwwsBY/3BW9r7KiFIeQBHDrfOE0p8YjMmDkNOhXA65otb5Q+vVCbmKoSmxZdQ0PXlkVS1uifJPLu
X-Gm-Message-State: AOJu0YxSf7FURCmS5QmjAL+e/mb0jKkgXFZokau8/Q0/m3Vcrmv4pjkK
	Fn9BFwUZldT1mrF0VA6iXSamoRyBSRfPq4WCKmPV+TIfJTBPp7irh0cfcut5uNzOio8T3r4k2ov
	5cBUthEhYJ37kQIY5GQqg7N7o2O7f/LscwpTlDQ==
X-Google-Smtp-Source: AGHT+IE91ezuO/TQwQfm8V42ORY0PMsANSYBITfPybm0WqpQNZwrx4Oib/yIen6E1DuqgRrLDQH+dcE2vHWlSPILDjI=
X-Received: by 2002:a05:6512:489a:b0:52c:c9b6:8f4e with SMTP id
 2adb3069b0e04-52ccaa5a0a0mr2136538e87.59.1718825637613; Wed, 19 Jun 2024
 12:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
 <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com>
 <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
 <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com> <CABBYNZ+7SrLSDeCLF0WDM01prRgAEHMD=9mhu5MfWOuGwoAkNQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+7SrLSDeCLF0WDM01prRgAEHMD=9mhu5MfWOuGwoAkNQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Jun 2024 21:33:46 +0200
Message-ID: <CAMRc=MdozeAzWJCSrDdxVBZ=fwP2yn_j-KZaTDT2Dp7YjKP8-g@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:59=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Jun 19, 2024 at 3:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Wed, Jun 12, 2024 at 5:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Bartosz,
> > > >
> > > > On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@=
bgdev.pl> wrote:
> > > > >
> > > > > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Bartosz,
> > > > > >
> > > > > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <br=
gl@bgdev.pl> wrote:
> > > > > > >
> > > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > > >
> > > > > > > Hi Marcel, Luiz,
> > > > > > >
> > > > > > > Please pull the following power sequencing changes into the B=
luetooth tree
> > > > > > > before applying the hci_qca patches I sent separately.
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-kernel/20240605174713.GA7=
67261@bhelgaas/T/
> > > > > > >
> > > > > > > The following changes since commit 83a7eefedc9b56fe7bfeff13b6=
c7356688ffa670:
> > > > > > >
> > > > > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > > > > >
> > > > > > > are available in the Git repository at:
> > > > > > >
> > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.gi=
t tags/pwrseq-initial-for-v6.11
> > > > > > >
> > > > > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f=
42869128dd:
> > > > > > >
> > > > > > >   power: pwrseq: add a driver for the PMU module on the QCom =
WCN chipsets (2024-06-12 09:20:13 +0200)
> > > > > > >
> > > > > > > -------------------------------------------------------------=
---
> > > > > > > Initial implementation of the power sequencing subsystem for =
linux v6.11
> > > > > > >
> > > > > > > -------------------------------------------------------------=
---
> > > > > > > Bartosz Golaszewski (2):
> > > > > > >       power: sequencing: implement the pwrseq core
> > > > > > >       power: pwrseq: add a driver for the PMU module on the Q=
Com WCN chipsets
> > > > > >
> > > > > > Is this intended to go via bluetooth-next or it is just because=
 it is
> > > > > > a dependency of another set? You could perhaps send another set
> > > > > > including these changes to avoid having CI failing to compile.
> > > > > >
> > > > >
> > > > > No, the pwrseq stuff is intended to go through its own pwrseq tre=
e
> > > > > hence the PR. We cannot have these commits in next twice.
> > > >
> > > > Not following you here, why can't we have these commits on differen=
t
> > > > next trees? If that is the case how can we apply the bluetooth
> > > > specific ones without causing build regressions?
> > > >
> > >
> > > We can't have the same commits twice with different hashes in next
> > > because Stephen Rothwell will yell at us both.
> > >
> > > Just pull the tag I provided and then apply the Bluetooth specific
> > > changes I sent on top of it. When sending to Linus Torvalds/David
> > > Miller (not sure how your tree gets upstream) mention that you pulled
> > > in the pwrseq changes in your PR cover letter.
>
> By pull the tag you mean using merge commits to merge the trees and
> not rebase, doesn't that lock us down to only doing merge commits
> rather than rebases later on? I have never used merge commits before.
> There is some documentation around it that suggests not to use merges:
>
> 'While merges from downstream are common and unremarkable, merges from
> other trees tend to be a red flag when it comes time to push a branch
> upstream. Such merges need to be carefully thought about and well
> justified, or there=E2=80=99s a good chance that a subsequent pull reques=
t
> will be rejected.'
> https://docs.kernel.org/maintainer/rebasing-and-merging.html#merging-from=
-sibling-or-upstream-trees
>
> But then looking forward in that documentation it says:
>
> 'Another reason for doing merges of upstream or another subsystem tree
> is to resolve dependencies. These dependency issues do happen at
> times, and sometimes a cross-merge with another tree is the best way
> to resolve them; as always, in such situations, the merge commit
> should explain why the merge has been done. Take a moment to do it
> right; people will read those changelogs.'
>
> So I guess that is the reason we want to merge the trees, but what I'm
> really looking forward to is for the 'proper' commands and commit
> message to use to make sure we don't have problems in the future.
>

You shouldn't really need to rebase your branch very often anyway.
This is really for special cases. But even then you can always use:
`git rebase --rebase-merges` to keep the merge commits.

The commands you want to run are:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
tags/pwrseq-initial-for-v6.11
git am or b4 shazam on the patches targeting the Bluetooth subsystem
git push

That's really it, there's not much else to it.

Bart

> > > Bart
> >
> > Gentle ping.
> >
> > Bart
>
>
>
> --
> Luiz Augusto von Dentz

