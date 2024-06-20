Return-Path: <netdev+bounces-105335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A72910807
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439B91F21A1A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671081AE865;
	Thu, 20 Jun 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB2NegJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAA1AD499;
	Thu, 20 Jun 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893247; cv=none; b=OzzoIGjkD4s4Ko9FAafopeJkHnXWDW6j8uHnqasPuYoA8Jwb06lrcBu6p27ceuqvrMyxDw4iwSlF9dKNx35XaDYUQIJiMF9gFyxtJs8tNklTK8rePadr+st/TXpc/Bgo8b4xfwNCgWy77ugHFTRG5qj6yA95RvG+X0FsYQBv/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893247; c=relaxed/simple;
	bh=RpDzMEPAkTH0gCUtj8Zipc0F542rspFE5ClM8an0Mto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhmViT5JCVqpzYs2yBb014Nvm1jhukrRvAm5pkSj+RnzYRrVdx2TQ/ijsQvFtWWYB46J/iYxEaPHiypmx0BkGTssdRYdtV0ZYQ1KGeKhR6o746/WNVDhIkrGVBlH3Yce39xEehqpIL9qp9qzG3We1yq+/S/GgIW7p6kQYNdY9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB2NegJh; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so10885081fa.2;
        Thu, 20 Jun 2024 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718893243; x=1719498043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE+vLn2GjGuqLu8n+Texxnq8vZV2TJlYRLG7tNkSm9w=;
        b=lB2NegJhi6qat4W54xuOimsqp8F6UDTWxzUFkOrPnrfQsrP3rfIMgVI6Su+epJXtp8
         ZbFYqoeOUKMrUqKkm0gdB2BOMiIO5HBUfozD7h8wpiQDB2kK9ps7v8eRQKs4X/EK6vha
         B7LsM+O0FdUB/fXp/ReojMhcrxQBxJjPoEpNUt6UaR64eiZoAdmUBL5m1goCg5XQcK3z
         I32TDs0UixQUkEas+mvpzcT40MtpVAH8iZ9o6qgPhSXwjEpl/p0l5oWdN/kI3UNk0sEC
         Wr7kQVyrVc08R81yM+QXxJJnPu5aPgM9fwYzq6sOpCxpZRLiMbfXTmfozsrZbyK5tSYC
         vUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893243; x=1719498043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE+vLn2GjGuqLu8n+Texxnq8vZV2TJlYRLG7tNkSm9w=;
        b=sIZRWq8XKChomKpPruZkIGWFdbQD4HNA5FHt4m3dmqF2T5mPyYQI2f0MHXo+Us0AYZ
         W+pYhrSLY6Wwvfl6U9tOjqqqBAhk7FkJknkX2nua0Oi8tR+8ejZ12YjHf71zQ/xXfv3E
         NvslcySxqrcWn2P4FqpwXkbm35Nqhlo1GjBKiFFxKcqTMYCv3D1/ort7XcKQ6TetlLV4
         RGin5/gEjR0Et7k3+MxDsYgODOgPbVy+LquK3mC9v2W3F9nyvtesUw2WtIFWc9dSf0Y2
         uTvkmrJgLqIoSkwE2L/4UYnrV2881FJVfWiFte57jtWFPMq1q1I39mGFoAvJ+Z1+KMmu
         dtLA==
X-Forwarded-Encrypted: i=1; AJvYcCWfpuY7v8FXGLUi1Yp9s2nEE8ULeOATd5KXt59ou4Di9w7LA+YBS6aPvcqnhp3a2dbamm+ToCbC3vvhHXfzZQjYgYgYF7MVOc5T3XXARxh9Vdz+3lrW1hXrdtpA2FxF26PJCT8WtZooFVgclgx5qOTpNcFxieSXeqKPtMTC9ovZpgmj3O1X8Ip5MkEUhhsPDYMdLndxpmB8fSVkCgGT99I2Eg==
X-Gm-Message-State: AOJu0YxsxI2gWy+j6IDcxPtxHX3l1xJ+Qb6GvGY3GrutQ6LnVqWAdSZ4
	fVET5q5gLH3mIfEdFkn+VKJcAWEB3Ijp54+9Wf48Yh5aRCPuPC8HsTGaLO4UHuoHOcvPlzKdpDd
	yePl8MbUmOqgz1Ysm3qbdbiho2H0=
X-Google-Smtp-Source: AGHT+IGfHPFkchZI4XFBDyNkcZVktC7kVtwWWeNopv9MwMRTymLvl60lvFyANEtN7uERk9DW2caXasLHMpYMVL3ALww=
X-Received: by 2002:a2e:9a8e:0:b0:2ec:429a:a807 with SMTP id
 38308e7fff4ca-2ec429aa8b1mr25630481fa.7.1718893243411; Thu, 20 Jun 2024
 07:20:43 -0700 (PDT)
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
 <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com>
 <CABBYNZ+7SrLSDeCLF0WDM01prRgAEHMD=9mhu5MfWOuGwoAkNQ@mail.gmail.com>
 <CAMRc=MdozeAzWJCSrDdxVBZ=fwP2yn_j-KZaTDT2Dp7YjKP8-g@mail.gmail.com> <CABBYNZKA7-PAODStTZO33KfHOrGmZHjbEQcP+DKq-CVNwEce4w@mail.gmail.com>
In-Reply-To: <CABBYNZKA7-PAODStTZO33KfHOrGmZHjbEQcP+DKq-CVNwEce4w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 10:20:30 -0400
Message-ID: <CABBYNZ+x-HPCEwQVPONr6pF-Kvss=gJxqdosNGUfFFQDLz75DA@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 10:16=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Jun 19, 2024 at 3:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > On Wed, Jun 19, 2024 at 8:59=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Bartosz,
> > >
> > > On Wed, Jun 19, 2024 at 3:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 5:00=E2=80=AFPM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> > > > >
> > > > > On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Bartosz,
> > > > > >
> > > > > > On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <b=
rgl@bgdev.pl> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dent=
z
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Bartosz,
> > > > > > > >
> > > > > > > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski=
 <brgl@bgdev.pl> wrote:
> > > > > > > > >
> > > > > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org=
>
> > > > > > > > >
> > > > > > > > > Hi Marcel, Luiz,
> > > > > > > > >
> > > > > > > > > Please pull the following power sequencing changes into t=
he Bluetooth tree
> > > > > > > > > before applying the hci_qca patches I sent separately.
> > > > > > > > >
> > > > > > > > > Link: https://lore.kernel.org/linux-kernel/20240605174713=
.GA767261@bhelgaas/T/
> > > > > > > > >
> > > > > > > > > The following changes since commit 83a7eefedc9b56fe7bfeff=
13b6c7356688ffa670:
> > > > > > > > >
> > > > > > > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > > > > > > >
> > > > > > > > > are available in the Git repository at:
> > > > > > > > >
> > > > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linu=
x.git tags/pwrseq-initial-for-v6.11
> > > > > > > > >
> > > > > > > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e=
836f42869128dd:
> > > > > > > > >
> > > > > > > > >   power: pwrseq: add a driver for the PMU module on the Q=
Com WCN chipsets (2024-06-12 09:20:13 +0200)
> > > > > > > > >
> > > > > > > > > ---------------------------------------------------------=
-------
> > > > > > > > > Initial implementation of the power sequencing subsystem =
for linux v6.11
> > > > > > > > >
> > > > > > > > > ---------------------------------------------------------=
-------
> > > > > > > > > Bartosz Golaszewski (2):
> > > > > > > > >       power: sequencing: implement the pwrseq core
> > > > > > > > >       power: pwrseq: add a driver for the PMU module on t=
he QCom WCN chipsets
> > > > > > > >
> > > > > > > > Is this intended to go via bluetooth-next or it is just bec=
ause it is
> > > > > > > > a dependency of another set? You could perhaps send another=
 set
> > > > > > > > including these changes to avoid having CI failing to compi=
le.
> > > > > > > >
> > > > > > >
> > > > > > > No, the pwrseq stuff is intended to go through its own pwrseq=
 tree
> > > > > > > hence the PR. We cannot have these commits in next twice.
> > > > > >
> > > > > > Not following you here, why can't we have these commits on diff=
erent
> > > > > > next trees? If that is the case how can we apply the bluetooth
> > > > > > specific ones without causing build regressions?
> > > > > >
> > > > >
> > > > > We can't have the same commits twice with different hashes in nex=
t
> > > > > because Stephen Rothwell will yell at us both.
> > > > >
> > > > > Just pull the tag I provided and then apply the Bluetooth specifi=
c
> > > > > changes I sent on top of it. When sending to Linus Torvalds/David
> > > > > Miller (not sure how your tree gets upstream) mention that you pu=
lled
> > > > > in the pwrseq changes in your PR cover letter.
> > >
> > > By pull the tag you mean using merge commits to merge the trees and
> > > not rebase, doesn't that lock us down to only doing merge commits
> > > rather than rebases later on? I have never used merge commits before.
> > > There is some documentation around it that suggests not to use merges=
:
> > >
> > > 'While merges from downstream are common and unremarkable, merges fro=
m
> > > other trees tend to be a red flag when it comes time to push a branch
> > > upstream. Such merges need to be carefully thought about and well
> > > justified, or there=E2=80=99s a good chance that a subsequent pull re=
quest
> > > will be rejected.'
> > > https://docs.kernel.org/maintainer/rebasing-and-merging.html#merging-=
from-sibling-or-upstream-trees
> > >
> > > But then looking forward in that documentation it says:
> > >
> > > 'Another reason for doing merges of upstream or another subsystem tre=
e
> > > is to resolve dependencies. These dependency issues do happen at
> > > times, and sometimes a cross-merge with another tree is the best way
> > > to resolve them; as always, in such situations, the merge commit
> > > should explain why the merge has been done. Take a moment to do it
> > > right; people will read those changelogs.'
> > >
> > > So I guess that is the reason we want to merge the trees, but what I'=
m
> > > really looking forward to is for the 'proper' commands and commit
> > > message to use to make sure we don't have problems in the future.
> > >
> >
> > You shouldn't really need to rebase your branch very often anyway.
> > This is really for special cases. But even then you can always use:
> > `git rebase --rebase-merges` to keep the merge commits.
> >
> > The commands you want to run are:
> >
> > git pull git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> > tags/pwrseq-initial-for-v6.11
> > git am or b4 shazam on the patches targeting the Bluetooth subsystem
> > git push
>
> Not quite working for me:
>
> From git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
>  * tag                         pwrseq-initial-for-v6.11 -> FETCH_HEAD
> hint: You have divergent branches and need to specify how to reconcile th=
em.
> hint: You can do so by running one of the following commands sometime bef=
ore
> hint: your next pull:
> hint:
> hint:   git config pull.rebase false  # merge
> hint:   git config pull.rebase true   # rebase
> hint:   git config pull.ff only       # fast-forward only
> hint:
> hint: You can replace "git config" with "git config --global" to set a de=
fault
> hint: preference for all repositories. You can also pass --rebase, --no-r=
ebase,
> hint: or --ff-only on the command line to override the configured default=
 per
> hint: invocation.
> fatal: Need to specify how to reconcile divergent branches.
>
> Perhaps I need to configure pull.rebase to be false?

Looks like I just needed -no-ff, will be pushing it after it finishes compi=
ling.

> > That's really it, there's not much else to it.
> >
> > Bart
> >
> > > > > Bart
> > > >
> > > > Gentle ping.
> > > >
> > > > Bart
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

