Return-Path: <netdev+bounces-105331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08859107D2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9557828106E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4D1AD499;
	Thu, 20 Jun 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIcx3bzs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825C111A8;
	Thu, 20 Jun 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892998; cv=none; b=Kr9aGndOhOpO1J1d377siySFFfjw9gbSZJirZyOTnd6lCdD4H980zs3KcG6B4auCexyP1WNDYD4MBWfNg4nMdWKDTkEmd3ckMOfK8qPLJwbqeLAvK348KXUbeewqcF5lvLssNRMG2iHsoSNM+7R9ETCAQzqPdXWgvglWuqTwCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892998; c=relaxed/simple;
	bh=UWVhIhoqDIOXTpdyS/cZTlU/tmFsaIIoltVjln93Eq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZN7JbPbe5Oy6t8LEjo578xItfemYAvkUd+fbqv/eKRBvvCoxYQzeg5Mn79HorGP+UiLLrWrbcOlRHUVKJXF9wMWGPUTdGs0JjIU67PIV7H+XgQtmk/mEsnyJPXlkQfliYzibuHIGWxKbz1CBuD4I22Urm/DQH8R09aurgR+2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIcx3bzs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec4a35baa7so2874441fa.1;
        Thu, 20 Jun 2024 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718892994; x=1719497794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35oH6YR8OKAtqNpyzoBGg8iFCfpyiydSvln7EuKe75I=;
        b=GIcx3bzstndhbg/uEe1ywYH4XxGCoVw/zM7fmmgOizleta5xg22iM9w8XC+xzBACkM
         4Mkd6sJ5EZeyC94AOH/sR9Icv+VaVjq6EENe5cIwZuIvq413ypS6VNgAEYXzMjYOBEZI
         5zTXKHNSRtLpGIQcZeb/Fv9Gbkc8kvYJoQZRyxWyoGCcKw3zB1s1trWhEBrDvbc1iMN+
         KCyhAGbpybPFZ9yWFaMjwLmU8KWz/v2apJtgNcGsXANuHlDVjL/JGa6xbrw98kUdZd9J
         WmwMkUsJNWSILCLa9RgXHaSNERt+TZoc/E4P2qXS+ySSI9H81cgqCylsg54aAx0V7aVh
         yK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892994; x=1719497794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35oH6YR8OKAtqNpyzoBGg8iFCfpyiydSvln7EuKe75I=;
        b=POCZBHKMo1FOISPC9JIRTj3CkUMfSaXbHUVV7GNJdHNA+/ycrCqApRvBZcwWS5GaQB
         GbcN3m1DVhFVWfoNX40nD79aKWq4KkAQC4QiZILAA0iz3rKAcDLj4ZEVLWVp1INavMDa
         lmdgXu7VLVNgCcpo8qMkVuDMoTdoWDi6Gc/HK8OxCMcZZLuXrvBeqC5EX4tGhF45H1+G
         e3nSDT25xklv9bYLh7alV4C095KoSh2z1qTc0bWxX2agf0S7XPLhUqKjnMvRjikaPkbp
         thOL7QqR+GhKxyFKb1EWe74bzRAgmlnz/oesfLsiz11aTIOgJyu+qzVIUM3w6Fhuv/kz
         kx/w==
X-Forwarded-Encrypted: i=1; AJvYcCU5hVkyL9QkrMw9ME2VDkVGUVem7acIQBMHroaAZ1Ck/F8nbSEDV0nEdAAZ8NjGNPblxODIDiTQbR+lfA2u85AWcQ9HVej94w0Z9ZCxTdVa+JhuE4SgSHY+9cKzoQr4MFVAMektD5qPiqQgDA+Jn3djr56P1OhLVcYmFFw/MSWYdCQTqhQUGDbbokR/jd6E09B9RZbZzJtoVCqkE36aLxVisQ==
X-Gm-Message-State: AOJu0Yz3bMXc9mtwK7Y7s7/Y+ORTNB5C7WdPWVWJgM5mKJf2uYI7OHpa
	kmSbLfhjVMezwuldcyYi5fWYXncdU37vsZHvxyE9UHH2/v0Na5+fDa6W2lf3rDpupja8AR8yFCk
	hlpLJSzYVhx3nPZf1WgJxLdnapgfIf5LO
X-Google-Smtp-Source: AGHT+IGCPuZA5uwweZH5jys86SOV4jtAEj4VQ7neCTtWwbeMmr8sP2ZPqpeo8WauhZ1vclVK2GfpUPrHviqtF79rpyc=
X-Received: by 2002:a2e:8813:0:b0:2eb:f1be:1e77 with SMTP id
 38308e7fff4ca-2ec3463dfa8mr24898831fa.1.1718892994121; Thu, 20 Jun 2024
 07:16:34 -0700 (PDT)
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
 <CABBYNZ+7SrLSDeCLF0WDM01prRgAEHMD=9mhu5MfWOuGwoAkNQ@mail.gmail.com> <CAMRc=MdozeAzWJCSrDdxVBZ=fwP2yn_j-KZaTDT2Dp7YjKP8-g@mail.gmail.com>
In-Reply-To: <CAMRc=MdozeAzWJCSrDdxVBZ=fwP2yn_j-KZaTDT2Dp7YjKP8-g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 10:16:21 -0400
Message-ID: <CABBYNZKA7-PAODStTZO33KfHOrGmZHjbEQcP+DKq-CVNwEce4w@mail.gmail.com>
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

On Wed, Jun 19, 2024 at 3:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Jun 19, 2024 at 8:59=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Wed, Jun 19, 2024 at 3:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 5:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Bartosz,
> > > > >
> > > > > On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brg=
l@bgdev.pl> wrote:
> > > > > >
> > > > > > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Bartosz,
> > > > > > >
> > > > > > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <=
brgl@bgdev.pl> wrote:
> > > > > > > >
> > > > > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > > > > >
> > > > > > > > Hi Marcel, Luiz,
> > > > > > > >
> > > > > > > > Please pull the following power sequencing changes into the=
 Bluetooth tree
> > > > > > > > before applying the hci_qca patches I sent separately.
> > > > > > > >
> > > > > > > > Link: https://lore.kernel.org/linux-kernel/20240605174713.G=
A767261@bhelgaas/T/
> > > > > > > >
> > > > > > > > The following changes since commit 83a7eefedc9b56fe7bfeff13=
b6c7356688ffa670:
> > > > > > > >
> > > > > > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > > > > > >
> > > > > > > > are available in the Git repository at:
> > > > > > > >
> > > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.=
git tags/pwrseq-initial-for-v6.11
> > > > > > > >
> > > > > > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e83=
6f42869128dd:
> > > > > > > >
> > > > > > > >   power: pwrseq: add a driver for the PMU module on the QCo=
m WCN chipsets (2024-06-12 09:20:13 +0200)
> > > > > > > >
> > > > > > > > -----------------------------------------------------------=
-----
> > > > > > > > Initial implementation of the power sequencing subsystem fo=
r linux v6.11
> > > > > > > >
> > > > > > > > -----------------------------------------------------------=
-----
> > > > > > > > Bartosz Golaszewski (2):
> > > > > > > >       power: sequencing: implement the pwrseq core
> > > > > > > >       power: pwrseq: add a driver for the PMU module on the=
 QCom WCN chipsets
> > > > > > >
> > > > > > > Is this intended to go via bluetooth-next or it is just becau=
se it is
> > > > > > > a dependency of another set? You could perhaps send another s=
et
> > > > > > > including these changes to avoid having CI failing to compile=
.
> > > > > > >
> > > > > >
> > > > > > No, the pwrseq stuff is intended to go through its own pwrseq t=
ree
> > > > > > hence the PR. We cannot have these commits in next twice.
> > > > >
> > > > > Not following you here, why can't we have these commits on differ=
ent
> > > > > next trees? If that is the case how can we apply the bluetooth
> > > > > specific ones without causing build regressions?
> > > > >
> > > >
> > > > We can't have the same commits twice with different hashes in next
> > > > because Stephen Rothwell will yell at us both.
> > > >
> > > > Just pull the tag I provided and then apply the Bluetooth specific
> > > > changes I sent on top of it. When sending to Linus Torvalds/David
> > > > Miller (not sure how your tree gets upstream) mention that you pull=
ed
> > > > in the pwrseq changes in your PR cover letter.
> >
> > By pull the tag you mean using merge commits to merge the trees and
> > not rebase, doesn't that lock us down to only doing merge commits
> > rather than rebases later on? I have never used merge commits before.
> > There is some documentation around it that suggests not to use merges:
> >
> > 'While merges from downstream are common and unremarkable, merges from
> > other trees tend to be a red flag when it comes time to push a branch
> > upstream. Such merges need to be carefully thought about and well
> > justified, or there=E2=80=99s a good chance that a subsequent pull requ=
est
> > will be rejected.'
> > https://docs.kernel.org/maintainer/rebasing-and-merging.html#merging-fr=
om-sibling-or-upstream-trees
> >
> > But then looking forward in that documentation it says:
> >
> > 'Another reason for doing merges of upstream or another subsystem tree
> > is to resolve dependencies. These dependency issues do happen at
> > times, and sometimes a cross-merge with another tree is the best way
> > to resolve them; as always, in such situations, the merge commit
> > should explain why the merge has been done. Take a moment to do it
> > right; people will read those changelogs.'
> >
> > So I guess that is the reason we want to merge the trees, but what I'm
> > really looking forward to is for the 'proper' commands and commit
> > message to use to make sure we don't have problems in the future.
> >
>
> You shouldn't really need to rebase your branch very often anyway.
> This is really for special cases. But even then you can always use:
> `git rebase --rebase-merges` to keep the merge commits.
>
> The commands you want to run are:
>
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
> tags/pwrseq-initial-for-v6.11
> git am or b4 shazam on the patches targeting the Bluetooth subsystem
> git push

Not quite working for me:

From git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
 * tag                         pwrseq-initial-for-v6.11 -> FETCH_HEAD
hint: You have divergent branches and need to specify how to reconcile them=
.
hint: You can do so by running one of the following commands sometime befor=
e
hint: your next pull:
hint:
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint:
hint: You can replace "git config" with "git config --global" to set a defa=
ult
hint: preference for all repositories. You can also pass --rebase, --no-reb=
ase,
hint: or --ff-only on the command line to override the configured default p=
er
hint: invocation.
fatal: Need to specify how to reconcile divergent branches.

Perhaps I need to configure pull.rebase to be false?

> That's really it, there's not much else to it.
>
> Bart
>
> > > > Bart
> > >
> > > Gentle ping.
> > >
> > > Bart
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

