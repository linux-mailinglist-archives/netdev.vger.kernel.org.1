Return-Path: <netdev+bounces-102902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA41905615
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4511C23DE0
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D917F4FE;
	Wed, 12 Jun 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oz43gLUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3F17F4EF
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204425; cv=none; b=K15P4rqc4wqGp6eRhgTmOwL5Yd48sFY7n2JRXzCCcQNNuaEMhchLjkdXuwyDdUVh5QCIBPeJPMLDYOs/wU4v79Km3TEOYSargbiNNoknQcNVC2gAA/olksjanLv0mtXwgwaeC0bIzeMFcC+93sQJq+HaqWw6XjZaoy/Czybz9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204425; c=relaxed/simple;
	bh=C4UELV9HUoTObjhE2z/Y+N/eSyCnSY+vNYVC8euckgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te9rC1yioYSdPoXp/e8in0uz/4q5M9RmqqviYVel09wAY5hkMt9g4kAQ3+AiB7BeDxOMgpME+PK6aK69debSMf7aH+ZO8MTOSAw+gdiMznxKyrXR6KDrlxxc39IKmizajOEowl/jnSQ1hccp7vkGmZvUzTsxBlSOqzGLEJFsNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oz43gLUA; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso3265083e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718204422; x=1718809222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6rL/BDIQftoREsF4MukuWgtFD7Xz/O/PdkqT1JwzBs=;
        b=oz43gLUA7clGp8IShwOmyPkd2VsJBMVuCFpBNLAkbZCXpNoEeHepsatlnrrCx249Lu
         vku0O+xdOEbUuJGgyy82WGi5DG/O8MhhyqllcfxvgKgzFKOwHJQs/DCYXRElNIaoCiIU
         RaaOpGyaH2O+qPcAhLBbZT4RdVJohrhhw50VktNZOn3h96cm9Bat9Bhve67p435ZKe6k
         74VmPxJWSPVW5KzoUi5HRm9ecHvBvIJne9f3nl4z+8izhNMqDr32O8KpGBoJ4/kLOCnL
         B7gQb1G8cKTNZ00vDdHGxbP21Zy7Br8BTTSldmaMuSuZODzmAskFqG1Eid9GGN2oKIwv
         phAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204422; x=1718809222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6rL/BDIQftoREsF4MukuWgtFD7Xz/O/PdkqT1JwzBs=;
        b=unNyl6NOAEe+AuAbGUoa3LnaBLG/ClDVHxJC6rZp928W52f6V9vwxGVlzFyQemGRDg
         0zqaj5LHWcIPFREJgP4WatuGoHhtKk7zwBFLmN9Og3M0/TD1/vx80EzEyDAvojb2pLkc
         n3XLBnXPOVkPzOiKpdS736tFd2s8mHb+0UfjVpUGBaArrBSa9t5boMfLoxbfl3HnfEkW
         AClJaWuop5ox+Or9jNTrg+e/0HugAo7LoiXnKG1jWp1eDQ9Jn7zRtLGmg76yrkOacXH9
         DEhWkX+g26huYjbGzBsghT5yDn+0pJo/FRPbvglhgp5CZ/CFlyw8B2szG1y3ZMqBtfsM
         j5HA==
X-Forwarded-Encrypted: i=1; AJvYcCUzJ8uUv1rh577sASOPNicjGRF0r1NHkPYmkE0liN0Hcq8XlIkFSDR9/Z1drbilroqwGXN9/5dY9HJUFC1qz+dj6UNTfwp6
X-Gm-Message-State: AOJu0YxtsAw2dUT7+5MXrvNcvMvcHSWtGpKKFvcN2nRh/mKzmF290uUM
	cAZ1laB+hD14aMioBGis4XfaVk156t2ciF4VazdNIec1ZFsWYceW6V67dLEz2q3ln2xKTbBjK8r
	ydfXuIvpOOqXXLoIBay9NYngW15rSrvK/s3az3w==
X-Google-Smtp-Source: AGHT+IGTgh1dIQ9+D2m/9bJRIpMZfry0OF0lmud8oD8sCLp6CWzI5quV6C91M4FXuD+64Vh450FwuHsfhkL2cCm4O1s=
X-Received: by 2002:ac2:4e0d:0:b0:52c:9725:b334 with SMTP id
 2adb3069b0e04-52c9a3fcc59mr1743084e87.54.1718204422361; Wed, 12 Jun 2024
 08:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com> <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com>
In-Reply-To: <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Jun 2024 17:00:11 +0200
Message-ID: <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Bartosz,
> > >
> > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Hi Marcel, Luiz,
> > > >
> > > > Please pull the following power sequencing changes into the Bluetoo=
th tree
> > > > before applying the hci_qca patches I sent separately.
> > > >
> > > > Link: https://lore.kernel.org/linux-kernel/20240605174713.GA767261@=
bhelgaas/T/
> > > >
> > > > The following changes since commit 83a7eefedc9b56fe7bfeff13b6c73566=
88ffa670:
> > > >
> > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags=
/pwrseq-initial-for-v6.11
> > > >
> > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f428691=
28dd:
> > > >
> > > >   power: pwrseq: add a driver for the PMU module on the QCom WCN ch=
ipsets (2024-06-12 09:20:13 +0200)
> > > >
> > > > ----------------------------------------------------------------
> > > > Initial implementation of the power sequencing subsystem for linux =
v6.11
> > > >
> > > > ----------------------------------------------------------------
> > > > Bartosz Golaszewski (2):
> > > >       power: sequencing: implement the pwrseq core
> > > >       power: pwrseq: add a driver for the PMU module on the QCom WC=
N chipsets
> > >
> > > Is this intended to go via bluetooth-next or it is just because it is
> > > a dependency of another set? You could perhaps send another set
> > > including these changes to avoid having CI failing to compile.
> > >
> >
> > No, the pwrseq stuff is intended to go through its own pwrseq tree
> > hence the PR. We cannot have these commits in next twice.
>
> Not following you here, why can't we have these commits on different
> next trees? If that is the case how can we apply the bluetooth
> specific ones without causing build regressions?
>

We can't have the same commits twice with different hashes in next
because Stephen Rothwell will yell at us both.

Just pull the tag I provided and then apply the Bluetooth specific
changes I sent on top of it. When sending to Linus Torvalds/David
Miller (not sure how your tree gets upstream) mention that you pulled
in the pwrseq changes in your PR cover letter.

Bart

