Return-Path: <netdev+bounces-102899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A99055DD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BF7285862
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0117F392;
	Wed, 12 Jun 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqGE9Z35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BA17F374;
	Wed, 12 Jun 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204088; cv=none; b=p4uNGbL0WBB6fvrheG4bcnOOP7zY7f2rCGhFioCJEsjC7s3nhPyUyt6gGah98/0GIbBeGkMrh4afOUlgrFlz8KK1CqoTjU7KrdZJYAGxmKxYD638aCpvwyBgpHfYCoPLq+KKlBsmVvRNWUyBbdNpjuz0jbuz0Ai/S6Kg2LiaTJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204088; c=relaxed/simple;
	bh=OHIuj+cu4kdvIF7ubfsWz5g8ux/ANr5PX5Lbo01ZnRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phO3TYZkEGc7Te/qUHlGEiKDV03t4pbXBiXSBFPTL0Oz8+7oKDQlWKLbfI1n2OBflAw3QFuoFVgejHjbtEuHdpYZ5RITayov89dli6s76iMg0RELVUf8YR5TxCGsmaCgcyoYJQWM3goAHZLs4Uod4Wj6GZJvGDGXGZ39onQZmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqGE9Z35; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe785b234so33448241fa.1;
        Wed, 12 Jun 2024 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718204085; x=1718808885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFvoluEX8O1ZuVrZ4TkWpRmCK6s/5ISbLklS0xYIk/Q=;
        b=ZqGE9Z35hfWlSEBRa29VsoKWUEH0VxNtUmpWcb6+e+nMSEAa/qFDdTC6lTKVsm60QB
         e6/NWNHVOnUK+jcm2X5fHdnmgzAx7/wudfNyFjZ1cDgaYX9jRgrqzkDeGS69xm+klIJd
         EFsc0LcTntbZKmmBOIMeY34K6W7ELpn9efpqHfQP9NXwIlxsLaWvJ0aW6jMDlCogEcTE
         VPcDUGqavuZFW+Xix7PlzVhdinmuPR8/Sns0CWf7tkMd4aLZgqoS5edIekQa/i9Q+yFr
         Ck5FfN5Qp1YzZHcSj8MFrRfZnZnfmWN4NUIem/eZyfnPCyV9locpqSWnGJQSaMhxva1d
         WPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204085; x=1718808885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFvoluEX8O1ZuVrZ4TkWpRmCK6s/5ISbLklS0xYIk/Q=;
        b=hyZXht01v/sfLDwLr4yf5/nlZuRNtQpwbIGPFPJkQKh0VNDkCkCb4HrM2naOXOEk9Y
         3dS+6iv0MVL/g/R/98/vIJ2pJ8v/9SliTqFbmRkZ0lpVfYbb1CQSBDmn86KmpQqsWfWY
         /qYsVoJcNENzCoDPZHOk7/6x1xB5BC2hHZSQk6nAJGEtUMuDM2uI4Pv0wA2RMnVVIXwY
         4fN6owqrZn8Dofu+FeSbrrYBBjAPil03+Gnx7iTfejRspK/LWsSrGy4ruKzYJZV/FWRc
         o6SH8AOvpWwhbMbEI+/PtgnkE/O78Z5SegjQk0HMdJ+ZgWJwO4KAFf6VL+N3mg/ooF2/
         /HbA==
X-Forwarded-Encrypted: i=1; AJvYcCVWENKjSZXzw1UkqqHoCSgzO1rpi/bme6VTMutCNpy6BjL9aGlSj17te+OV4IhKxWvui7MOEcphSUowqMaqKY+ECU1vIXD0IWbKbMOJDFvxbpfl79u4HhBBgrTn+CPUTW1IxxPyOWBw1cEC8dUBjSC8oxYx/KckFUgHizVFbTzFDgR254BWJlptfntLz++Fr+6nTkfJYGImIjosz+NH4da8Tg==
X-Gm-Message-State: AOJu0YwWTqYwb4p1ZpgYng89rwKo4ngYMRbWxda8nEB3HXe/Cdn/Qc+U
	5t823Ay5IXiNi+dZZGHYgCEkPvvApGrCWDfd4LYEpjpi0gLPunL2XGxVllRYLSytDQeAUnTBB6/
	49dkxyMDf05vG8RZFvSQteH+uE41UNg==
X-Google-Smtp-Source: AGHT+IEdMHZiLDsGBMrK9SAia7MmzWrOkgMko6njHoqmapJDPT6oys75Nm5/b67yHbBOs+Nsqvk1c8udWrC6CRDgao0=
X-Received: by 2002:a2e:9290:0:b0:2ea:df2e:428c with SMTP id
 38308e7fff4ca-2ebfca5dd9amr13446111fa.49.1718204084938; Wed, 12 Jun 2024
 07:54:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
In-Reply-To: <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Jun 2024 10:54:32 -0400
Message-ID: <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com>
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

On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Hi Marcel, Luiz,
> > >
> > > Please pull the following power sequencing changes into the Bluetooth=
 tree
> > > before applying the hci_qca patches I sent separately.
> > >
> > > Link: https://lore.kernel.org/linux-kernel/20240605174713.GA767261@bh=
elgaas/T/
> > >
> > > The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688=
ffa670:
> > >
> > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/p=
wrseq-initial-for-v6.11
> > >
> > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f42869128=
dd:
> > >
> > >   power: pwrseq: add a driver for the PMU module on the QCom WCN chip=
sets (2024-06-12 09:20:13 +0200)
> > >
> > > ----------------------------------------------------------------
> > > Initial implementation of the power sequencing subsystem for linux v6=
.11
> > >
> > > ----------------------------------------------------------------
> > > Bartosz Golaszewski (2):
> > >       power: sequencing: implement the pwrseq core
> > >       power: pwrseq: add a driver for the PMU module on the QCom WCN =
chipsets
> >
> > Is this intended to go via bluetooth-next or it is just because it is
> > a dependency of another set? You could perhaps send another set
> > including these changes to avoid having CI failing to compile.
> >
>
> No, the pwrseq stuff is intended to go through its own pwrseq tree
> hence the PR. We cannot have these commits in next twice.

Not following you here, why can't we have these commits on different
next trees? If that is the case how can we apply the bluetooth
specific ones without causing build regressions?

--=20
Luiz Augusto von Dentz

