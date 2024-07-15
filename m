Return-Path: <netdev+bounces-111511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778AA931683
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211F01F2218C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F418E749;
	Mon, 15 Jul 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTOEz8rH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321418C354
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053062; cv=none; b=NeKNnOaztU5d+EMD/HM3Krio3Z6Z02Uf/km6samM6s/j6zQCFHpMnGb1DDxI/lJNpIPsMZEP8cyw9jkpX22k/ktklGiXDJDofbs5tm/+UeA4oWuS2MxGBhF8j8rzMUH3zyJOg9Y4tSEPSYCyM1usnLYoeqUnh/R+dXQKQpv5YTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053062; c=relaxed/simple;
	bh=p5vkjpUIAN1q0SFRTKNGtBTqWKxR2HbI2p0SsZxwJ3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwz2Jb52Dm1h16mlH6QrUaxbMmudo/w9uERO7twUJwvPWgCdolWOwHidwjcxBQ0sw8NpVpHup8nb7O+R6sO92XfvJuf8jj+Vsw5er5/xRbVBg24nkrYKm6LItfPGwKQIbYOgXdrRjr6YN2NFR9C6+Pxq60bQGYrxCzrYg5vsWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTOEz8rH; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso4050119276.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721053059; x=1721657859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OoWtEhbY53+o6LnI0FNJBNw/+pJBxn2lMjzj+KsmgQ=;
        b=tTOEz8rHmSlb1m23dMEt9xqxp+8wBD+Z4JQXbH2YRPN0PlFlMAi9TNhDUei8u79S1p
         tk5xIPYPwV3VBRmZ0s7vtUzl/kWVKtC/t7tXpDJ0Dp2KbCqNeDr+FsAnytQtoeLpz5oV
         fHC4ydlPfXWe/SLVWH/7iF4MnDyjGEPiVuufo3bZttcSNtpQzaczqc7Sg0/jmjEt3MeR
         v1ysUGw6DuozCFbFYnQzBXYFRQMEvQY/sC+7ifRK9Q+wliKtrrgvWri6PmpMibDjqxoC
         n3YFSnBrytZJku2+LD5ElZJSEQSdH5616O89ZimFp+hWQjt7Fmz6hp5QEhl8RSFfPJV7
         BawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053059; x=1721657859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OoWtEhbY53+o6LnI0FNJBNw/+pJBxn2lMjzj+KsmgQ=;
        b=de+IRVCwduXSHKZnJJ6J50fSA+1L4x3gSg7yUTffsQs6wXYqgwJDq1o5fyVE77vIpf
         A25DeuvkscNUx5/pMgQqChBdzhFgXkJxJyrjGu6HCVZscufPtVH6csQ9z2tMekg9FRjQ
         R4DL8yLHw1A0qId7eMhKjTMcRliqDK7idz17DEPYjRyo7MyGvDAFJaSnQCXsyTBYgn3r
         U6lTnPNb4V/ZJyElbvpZeTiO8jxMOZwQT2v9m+uqPzSCST5VNeavrIg8TVe5MENygfye
         D5NNUXPGLfAotwQgWllLLuVhiUW9ZBBIYHbTLFtaxihE7YMVhAtnrlEMqPVbi67gGTv9
         N4YA==
X-Forwarded-Encrypted: i=1; AJvYcCWhSnXF6uWoUJ1KX29JCbjQzzQKyg/uWRt2SN2q9YB5B0epnzaPPfz2xnahA6/fuzR9f1FUISbM7BZRXldHUiUuH/5yTlni
X-Gm-Message-State: AOJu0Yy3LD7Iwd9KU5lItqQgYfxfd1ki1rxUCHRbgXuKt1sNV+vy8sQk
	lcVrlPNie8+f8SdQ2A0PePfT30CM3IM+8vnqgiSrmBs1lwHdjyiqe0xg8arF/4TDwgLeY9iKYWj
	t09LXJ3v0VXMIvXiB4xG97wujmuzcO5fl2G/jNg==
X-Google-Smtp-Source: AGHT+IHf09w1i22vg1fXed0YLn+7wm0ckmYmmD97kcyFXDIFeQRbyjfwZjVRPHxaxhZ8gPCDXVfoT1vtvO4SbKtPRNI=
X-Received: by 2002:a25:adc1:0:b0:e02:8f64:5010 with SMTP id
 3f1490d57ef6-e041b063931mr22988844276.14.1721053059505; Mon, 15 Jul 2024
 07:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com> <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
In-Reply-To: <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 16:17:28 +0200
Message-ID: <CACMJSesSpm=C67LE9Nn+fBS_JLZgzA_h-ocnPGy_wqzy8vH70Q@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024 at 16:00, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Mon, Jul 15, 2024 at 9:56=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > > >  - qca: use the power sequencer for QCA6390
> > >
> > > Something suspicious here, I thought Bartosz sent a PR but the commit=
s
> > > appear with Luiz as committer (and lack Luiz's SoB):
> > >
> > > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module =
on the QCom WCN chipsets") committer Signed-off-by missing
> > >         author email:    bartosz.golaszewski@linaro.org
> > >         committer email: luiz.von.dentz@intel.com
> > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linar=
o.org>
> > >
> > > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
> > >         committer Signed-off-by missing
> > >         author email:    bartosz.golaszewski@linaro.org
> > >         committer email: luiz.von.dentz@intel.com
> > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linar=
o.org>
> > >
> > > Is this expected? Any conflicts due to this we need to tell Linus abo=
ut?
> >
> > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > is based) but I no longer see the Merge commit in the bluetooth-next
> > tree[1]. Most likely a bad rebase.
> >
> > Luiz: please make sure to let Linus (or whomever your upstream is)
> > know about this. I'm afraid there's not much we can do now, the
> > commits will appear twice in mainline. :(
>
> My bad, didn't you send a separate pull request though? I assumed it
> is already in net-next, but apparently it is not, doesn't git skip if
> already applied?
>

My PR went directly to Torvalds. It was never meant to go into
net-next. You should keep the merge commit in your tree and mention it
to Linus in your PR.

Bart

> > Bart
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
-next.git/log/
>
>
>
> --
> Luiz Augusto von Dentz

