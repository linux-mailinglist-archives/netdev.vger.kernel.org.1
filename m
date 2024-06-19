Return-Path: <netdev+bounces-104771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A5990E49D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B328174E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF89770E3;
	Wed, 19 Jun 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MxEF1spK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4D76413
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782548; cv=none; b=tayfsdPMrBy/Wy9aVnjgAwT28XRSv3693ns3ezBF0b78XrDr9374vXG7qCJpLLXob2/mxs9sTteKfJVnIyJInwbTz8BcvCOtDZ/jS7ZGM/n7POSGQP6FR6GCeJXmNmV4gj8XsPHCHdPjcKQnh0hdz2WDySu68lk+9kGtL7FHbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782548; c=relaxed/simple;
	bh=+S5Uv3HO+4mevHlHKh5Y+xeuc2VhQf6TXsTM9rXh0js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5kbP4CU3s57j4qL4nxyv6yiNUIWthgphhCC872Jh7cir8E4IgOATi3tkCWDOffEq4oqPJhx5qu+GpERbErA4ZABqVW/E2nRtiks45meBbsL9nrqoNoC1m/Tv1LZAXhIYv1XFIlBl9JKZ4QJVxULbIWi5fyz+YcBqwwLrFvGuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MxEF1spK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso509873e87.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718782545; x=1719387345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAirk0f0PKTwzOziyA/BSlPSIpqsEtALcS+cg2LXns8=;
        b=MxEF1spKn7wqLKraUNzIKIXdzjGCH44lcL/5kKGAm723HiZD45aIY43SFf+bi1WtDn
         TqnVv4YeVPBMM3mq2TMhK7p8J7Ci749uGax12nigJ1wjv9YTC065zxoFYC+Ql+zGJmxk
         xCYJISE7lBRSzrrwomhJRt7ghW9Kyjmp5O4N8kQAtoe1GQlQ3iShfYR1zRhw7eoFtpBP
         208OywI7jS1WdEU3Ttyd5Qvlm65djZTIX76XqRFezX3//r7ZyhpD6zIMeB0An4uvs1Al
         iuFj8lV75NgJQ564yEU6uuvlwtR1WDWdG4QqmexokdF3qShGfy7+4WeKL54d+KDKh298
         HFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782545; x=1719387345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAirk0f0PKTwzOziyA/BSlPSIpqsEtALcS+cg2LXns8=;
        b=i3TnuNwhlhzDklTkUoHDBnqA9tpnJJ/1kJx9T7UwVudpesiFsNHkaykHY3NhumsTHn
         K8tHaI+aCP4qOO9XCnVfSmZnNfZ4GaLi4y7+fpv62mrS74drjYSSZHkoprQRrhqotEmC
         zQvOEF6t1jk9eoTdGZaCcSenVbexP7JBv2txmy7eEPGAYglBIrgyR1RglBaeDlmlLEEW
         koCbem+/MjY7cmMrYmeVy6GRN8wPwg7C/+a6HGQGDhxvhyFiwBA37TELfda48NS33/OY
         c6TEBl5AP3+VT8/87NTz/tB0NNNvWwGwijCtgsivjzbJPq1u63FFYQj3TP3iveM03t6d
         PFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFL3aIMfyabukFCKcHwAI105U/xu0JfB1oHveby8zeRmQa4MgUOHiJrXIr/cpQbsl7ER2YE1YbuxTaHpHl+dQ2FYEjyB7l
X-Gm-Message-State: AOJu0YwbrznLy7AtOTPQbzdUOUXb/9+OV55RVyzVYuvTiXFkdpls8GkC
	FloTlIqI4gCaq7nkv5KN8NMWssA2UrGdUBaHeDG44JvOr9cZd2RMoCXPSeHiAkuZGB0Wm061O05
	BdmUTDTd/msq53jFEsXbARPDekkRf+hsaH8JovA==
X-Google-Smtp-Source: AGHT+IFSnKagBTz38/KAjI8t4GnDrMsPoKM/8j0e3wn2GQsI00XKi7Y1hebzFZ6x66wwp3aNl7M+IXmjhb/C18jBEp4=
X-Received: by 2002:a05:6512:3b89:b0:52c:80e6:60c7 with SMTP id
 2adb3069b0e04-52cca1bfa80mr623875e87.13.1718782544654; Wed, 19 Jun 2024
 00:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl> <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
 <CAMRc=Mdb31YGUUXRWACnx55JawayFaRjEPYSdjOCMrYr5xDYag@mail.gmail.com>
 <CABBYNZLPv3zk_UX67yPetQKWiQ-g+Dv9ZjZydhwG3jfaeV+48w@mail.gmail.com> <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
In-Reply-To: <CAMRc=Mdsw5c_BDwUwP2Ss4Bogz-d+waZVd8LLaZ5oyc9dWS2Qg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Jun 2024 09:35:33 +0200
Message-ID: <CAMRc=Mf2koxQH8Pw--6g5O3FTFn_qcyfwTVQjUqxwJ5qW1nzjw@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Jun 12, 2024 at 4:54=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Wed, Jun 12, 2024 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 4:43=E2=80=AFPM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Bartosz,
> > > >
> > > > On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> > > > >
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > Hi Marcel, Luiz,
> > > > >
> > > > > Please pull the following power sequencing changes into the Bluet=
ooth tree
> > > > > before applying the hci_qca patches I sent separately.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-kernel/20240605174713.GA76726=
1@bhelgaas/T/
> > > > >
> > > > > The following changes since commit 83a7eefedc9b56fe7bfeff13b6c735=
6688ffa670:
> > > > >
> > > > >   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git ta=
gs/pwrseq-initial-for-v6.11
> > > > >
> > > > > for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f4286=
9128dd:
> > > > >
> > > > >   power: pwrseq: add a driver for the PMU module on the QCom WCN =
chipsets (2024-06-12 09:20:13 +0200)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Initial implementation of the power sequencing subsystem for linu=
x v6.11
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Bartosz Golaszewski (2):
> > > > >       power: sequencing: implement the pwrseq core
> > > > >       power: pwrseq: add a driver for the PMU module on the QCom =
WCN chipsets
> > > >
> > > > Is this intended to go via bluetooth-next or it is just because it =
is
> > > > a dependency of another set? You could perhaps send another set
> > > > including these changes to avoid having CI failing to compile.
> > > >
> > >
> > > No, the pwrseq stuff is intended to go through its own pwrseq tree
> > > hence the PR. We cannot have these commits in next twice.
> >
> > Not following you here, why can't we have these commits on different
> > next trees? If that is the case how can we apply the bluetooth
> > specific ones without causing build regressions?
> >
>
> We can't have the same commits twice with different hashes in next
> because Stephen Rothwell will yell at us both.
>
> Just pull the tag I provided and then apply the Bluetooth specific
> changes I sent on top of it. When sending to Linus Torvalds/David
> Miller (not sure how your tree gets upstream) mention that you pulled
> in the pwrseq changes in your PR cover letter.
>
> Bart

Gentle ping.

Bart

