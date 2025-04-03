Return-Path: <netdev+bounces-178934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD2A79976
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6047A4FF2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16733F7;
	Thu,  3 Apr 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6qD8tWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DB2907
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743640852; cv=none; b=R56j7Q75FQZdLedBPvgPBYG19NoYjc8MpVxDgPLcYJSEwwiuZDzR/KFQDQQuw6ZYofRYxa5LwJIKE/gzYArWMnD+F78XYBRHsZfPUSmIsmKOcfv8hwhWKBtQ3fSo+S+0TOjLG8URQatZTbCwS5dR5ThClC44GA2EViH5zkmlSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743640852; c=relaxed/simple;
	bh=inj0GsYGBkEHb7kM9hh/st59ntfuHFD3V70zuK+run0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utI4Gnd//+aKVGuTIPNPemmLUP7l8B+hmF8BMXSzI4Yzrp11XaVXHZFP9BQL/tI9F3ZGh1NLBCzUS4e1NXWsXzijFyAUh0RAuKEV+CTXihB8sQh+abc4tscB31YS/9COPhoff/VJTJBPDHI3qEzqa/NXzj0/9L/c/I/KkXZh2rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6qD8tWE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d42f08135so205522241.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 17:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743640850; x=1744245650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inj0GsYGBkEHb7kM9hh/st59ntfuHFD3V70zuK+run0=;
        b=O6qD8tWEghZHjA0V2P76YYlk/et3wJjmSsJBgO7ouLBmMohCSaBm25whsAD5y0vu4m
         Di8l3SiabYu0/+fX3G2w7fowfho4bJfsIbL8J1SJ76lba+jKmrnb0y0dtUqCp3N35RCh
         NOMjBVMW1PSUBLFJp2VFpBR/rg9+TL8ZXK/sabFAc/5gJQmZpnjNX0ODFa1s3Y0fFC7d
         6Eppv9zK9c9Q0IdBYCcd7cRwTnPBqaV8mEU2VWcO7bCEsFF06N44WXv9K4qyX58s/ory
         P2F38aSMckcOzPkqOBzXHvW569K6GmXjvWnwRGtRgvqg9rU/+q+E3UxZlfdSeQy/KU7Z
         czBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743640850; x=1744245650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inj0GsYGBkEHb7kM9hh/st59ntfuHFD3V70zuK+run0=;
        b=ew/mUH7vRB5bb9d/EBg+g4qTmvH0De9FrgbIxgOoCEnr8AMJSx/I4yb9+qw33K7Zqf
         Z2HzVPtVF9ISenYODFQgInNj0sj8VH/UH20PPaTvU4L1Gse6iq0S1Z8yito5DHr1ooqv
         4150lTeYYzKETI8NRBeyS/RzC7hg9ur9FKQXGFLroHIK2o6BgRRCcxr0wI1hUsOfL0+N
         AydE2DzCOtii/SoJ918QJpNiOdX6etLZODZr1dBoMR5aGCFAd7NTGTG1sRLkL7EhpQwk
         16IUG0Z5epx2rgdTTtq4SP4ZT7JU5UwFt/8/WcIVCvB6tN7QQHraOXrzDqA71Uc7u3co
         WLKQ==
X-Gm-Message-State: AOJu0YwHmZbU80jxkZmGaDo/luAPqgEvQ0m1ZPe+oAsfdUjvK1aRVilr
	HehwvBGHS0VX3kw7ZSFLIxWse1eAsnOeyhLQ7dkxivrlQ6SDkcWiU1lNtOpcwKi26X2f/bhaNYM
	MTvHm/jraQw/A/N/7zq/v/DLpwUKeVDzO
X-Gm-Gg: ASbGncv5qwoNHT/MGLR0iIw820Rn9QcHj8BPjJEzB5D4zxMm5nAw/WyhsfUzmEcmF/s
	wLKUDqxq3+ySBTVvavOBUHjKD3OUaPI3dAHQTHYbQ7YitcOKS0VBC6BzSVYg2L1bTzU3wn3itGW
	x+4XvU9jBppuz9u7JZQZg3y3Tx4gyL
X-Google-Smtp-Source: AGHT+IFVLZJijWLlBkz/rk369NZjjxnjGglSEHEx1HkYRHM1J98xiffBFb5UyFYSQ0yWh4ZuGQPoJ/qAs+AQLNWby9Q=
X-Received: by 2002:a05:6102:54a0:b0:4c1:86a7:74e9 with SMTP id
 ada2fe7eead31-4c839e1625bmr4499752137.10.1743640849792; Wed, 02 Apr 2025
 17:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com> <20250320232539.486091-8-xiyou.wangcong@gmail.com>
 <3a60ae0c-0b5f-44e9-8063-29d0d290699c@mojatatu.com> <Z+cIB3YrShvCtQry@pop-os.localdomain>
 <9a1b0c60-57d2-4e6d-baa2-38c3e4b7d3d5@mojatatu.com> <Z+nUiSlKoARY0Lj/@pop-os.localdomain>
In-Reply-To: <Z+nUiSlKoARY0Lj/@pop-os.localdomain>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 2 Apr 2025 17:40:38 -0700
X-Gm-Features: ATxdqUH4h_O74KCTrcTnE9codDjgs7yEWAEgfAygerQ87e0ef3Jo0vpL8if7mD8
Message-ID: <CAM_iQpW7f5QJRXBpEMAmMVNvF5aGk_2YNLVF=bcnoZhMhjDU4A@mail.gmail.com>
Subject: Re: [Patch net 08/12] selftests/tc-testing: Add a test case for CODEL
 with HTB parent
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	edumazet@google.com, gerrard.tai@starlabs.sg, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 4:32=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Sun, Mar 30, 2025 at 06:05:06PM -0300, Victor Nogueira wrote:
> > On 28/03/2025 17:35, Cong Wang wrote:
> > > On Sun, Mar 23, 2025 at 07:48:39PM -0300, Victor Nogueira wrote:
> > > > On 20/03/2025 20:25, Cong Wang wrote:
> > > > > Add a test case for CODEL with HTB parent to verify packet drop
> > > > > behavior when the queue becomes empty. This helps ensure proper
> > > > > notification mechanisms between qdiscs.
> > > > >
> > > > > Note this is best-effort, it is hard to play with those parameter=
s
> > > > > perfectly to always trigger ->qlen_notify().
> > > > >
> > > > > Cc: Pedro Tammela <pctammela@mojatatu.com>
> > > > > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > > >
> > > > Cong, can you double check this test?
> > > > I ran all of your other tests and they all succeeded, however
> > > > this one specifically is always failing:
> > >
> > > Interesting, I thought I completely fixed this before posting after s=
everal
> > > rounds of playing with the parameters. I will double check it, maybe =
it
> > > just becomes less reproducible.
> >
> > I see.
> > I experimented with it a bit today and found out that changing the ping
> > command to:
> >
> > ping -c 2 -i 0 -s 1500 -I $DUMMY 10.10.10.1 > /dev/null || true
> >
> > makes the test pass consistently (at least in my environment).
> > So essentially just changing the "-s" option to 1500.
> >
> > If you could, please try it out as well.
> > Maybe I just got lucky.
>
> Sure, I will change it to 1500.

Hmm, it failed on my side:

Test a4bd: Test CODEL with HTB parent - force packet drop with empty queue

-----> prepare stage *** Could not execute: "ping -c 2 -i 0 -s 1500 -I
$DUMMY 10.10.10.1 > /dev/null || true"

-----> prepare stage *** Error message: "Command "/sbin/ip netns exec
tcut-3264298917 ping -c 2 -i 0 -s 1500 -I dummy1ida4bd 10.10.10.1 >
/dev/null || true" timed out
"
returncode 255; expected [0]

