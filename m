Return-Path: <netdev+bounces-171337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DF7A4C8F2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A44A179F18
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E093822CBF6;
	Mon,  3 Mar 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBZY2tHV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C725BAAB
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020589; cv=none; b=kP/CB21QYO3ER5yfKEmI6LGVWlwka6JB8oZyUm8klPhxJ97vnNvb5Ew4l+cVJaEvF30TFfKKpGo2k945GZ/NEPuGHWyYotC3Ojk9jRJeNVvIBP+rXPo18s3hVBwtT3SPxidhu/mYK5tqe2stx1aD/RntzTwxjZzaY4qB/c044sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020589; c=relaxed/simple;
	bh=Sj/9n5yaDww5LsxV++b4jRZ/RCn196tGutCKBqXJ5p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAEaxO3m+kLXg1YZA9mnyFGRUPjL7OC4OBa2wwGz2EvV4P+sU/cd5n4bJh5mj342z/5hB69t0861nzPw50De55HecZaR6n/dCRurbdAPje75M08Uh0cSqDBbn/yYwxn52CZok3HdUqdPasSzmHyjxlaeunYg7+uPjNxKEQtV9u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBZY2tHV; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d191bfeafbso18739675ab.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 08:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020587; x=1741625387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1JM3jch4378qUNKnoRBygByBvzeQq9d+/vev+wxynQ=;
        b=UBZY2tHVbLLzWukafq0O5Ao7AITZg69ZJD3QihKvWIAnSLqisgp7GgJlOEhpIlgoFU
         vNf9bzg0fQZJiT1ysRLJDX7LWnOJEFVaFoYZ2o3DMzXQxRhNT+6wDFgfR4DF+qivoTDx
         h/C2mHtarUqbsgPEs0ljvh2MYbKvtPUJ/F0CHA5l0Lk8Fcv1MVjI7TfySPuhkZoEjtzx
         REoJOOlp/LHRIwnmXvgZ4e3aSN0K3DNC157WpkNPoR5+CLnR3L0u4/mOQ+ZyMGIGpkaX
         dAirad7KpBVPWi1kJ+UsD8538AKdVMouF9NVOC4eQqzXwqv4TcYR1bp0KcMbPwWLgp8w
         myeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020587; x=1741625387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1JM3jch4378qUNKnoRBygByBvzeQq9d+/vev+wxynQ=;
        b=P4ChgtD1q7oplTH0U2mDwx2oxEbnqnOVZFGH9Bv3EOpGDkUMw11NOOmXH2aXESlffW
         LPhrGe/eOkbv+axOha4hfbPJCbJL1y2vdW+DF9NeDQswSveWwJ1KdLofAeeK2zIkpD0y
         LXOY8DKa/4jXhHoRx1I4Ssq4/I3sYcG0DnduHpJojXTwo2KIokMxx0PCuqA0fQiE4W9C
         lpzYluEdqNsft+OMybKSF6vpScfoapQHu57LTriIQzzMqZdMFfziYplOpNm4QVe3MHJt
         OxMxGN7weYi4w9GlzWg830ko8RPdEh3IUnp86tF9C5Se5tjDlFWPEKO2VR24TIeqgD4k
         mx+w==
X-Forwarded-Encrypted: i=1; AJvYcCWrEm5PjoWXBRkZSjttdUyDE2tuoWvcA/F0Xfv6hWHp+65sMmR4H8xv+nVp/G4DT5xhwL0YWGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzVEbTOYV97iBIYYNj5RY+dvr4ziQla7b5XwSVRmeK20WX8t9R
	XdiiH4CtN2wIRm01DVUnTVOJfQfy5sv/1HOwA5QfClgTIiK3FjXbTQhW+9uVgBphxpIFAKeOnKk
	klzwwC/9xSoo7P80l48knEHOidKQ=
X-Gm-Gg: ASbGnctR0ux1CHbpj0E7aiG8sM/1MJ2/R33F7RZ+ksVeiKjgReAmwrMnkq1BsG71sg+
	6Jq96BZGXdaaIohn3S9SNk0n/mVIlwS0yK9kRzJ9p3jbwmSHpEkmyUTzcTOx4oqqmpBsdEgbZmT
	HHq90tZMmz5oXI9sya1IUPICAU
X-Google-Smtp-Source: AGHT+IF+o+ma8+T3pJgOeA06yMJTxOH3F3z00RFIHs7rACJYU1Ye0+3nUJqcE3YljUBJ5TYk2oejUZ9xAlQFQL4cxaY=
X-Received: by 2002:a05:6e02:180d:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3d3e6e45cf7mr114601265ab.1.1741020587306; Mon, 03 Mar 2025
 08:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303080404.70042-1-kerneljasonxing@gmail.com>
 <20250303074105.0b562205@kernel.org> <CAL+tcoCV-SbnMuJetKVuMpAhf_zuD5_+eHC_HLhdq-Jfp3H_+w@mail.gmail.com>
In-Reply-To: <CAL+tcoCV-SbnMuJetKVuMpAhf_zuD5_+eHC_HLhdq-Jfp3H_+w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Mar 2025 00:49:10 +0800
X-Gm-Features: AQ5f1Joqjd9GSsN3A5AsOQSiBYCpkea53UuxKp0_OFBxQ9CYBfNch2XcH-QpwzY
Message-ID: <CAL+tcoBogEc-pn_Z050wCWreVA86HEpjZQhhzie7_tnNU=TKpA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: txtimestamp: ignore the old skb from ERRQUEUE
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Mar 3, 2025 at 11:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon,  3 Mar 2025 16:04:04 +0800 Jason Xing wrote:
> > > When I was playing with txtimestamp.c to see how kernel behaves,
> > > I saw the following error outputs if I adjusted the loopback mtu to
> > > 1500 and then ran './txtimestamp -4 -L 127.0.0.1 -l 30000 -t 100000':
> > >
> > > test SND
> > >     USR: 1740877371 s 488712 us (seq=3D0, len=3D0)
> > >     SND: 1740877371 s 489519 us (seq=3D29999, len=3D1106)  (USR +806 =
us)
> > >     USR: 1740877371 s 581251 us (seq=3D0, len=3D0)
> > >     SND: 1740877371 s 581970 us (seq=3D59999, len=3D8346)  (USR +719 =
us)
> > >     USR: 1740877371 s 673855 us (seq=3D0, len=3D0)
> > >     SND: 1740877371 s 674651 us (seq=3D89999, len=3D30000)  (USR +795=
 us)
> > >     USR: 1740877371 s 765715 us (seq=3D0, len=3D0)
> > > ERROR: key 89999, expected 119999
> > > ERROR: -12665 us expected between 0 and 100000
> > >     SND: 1740877371 s 753050 us (seq=3D89999, len=3D1106)  (USR +-126=
65 us)
> > >     SND: 1740877371 s 800783 us (seq=3D119999, len=3D30000)  (USR +35=
068 us)
> > >     USR-SND: count=3D5, avg=3D4945 us, min=3D-12665 us, max=3D35068 u=
s
> > >
> > > Actually, the kernel behaved correctly after I did the analysis. The
> > > second skb carrying 1106 payload was generated due to tail loss probe=
,
> > > leading to the wrong estimation of tskey in this C program.
> > >
> > > This patch does:
> > > - Neglect the old tskey skb received from ERRQUEUE.
> > > - Add a new test to count how many valid skbs received to compare wit=
h
> > > cfg_num_pkts.
> >
> > This appears to break some UDP test cases when running in the CI:
> >
> > https://netdev-3.bots.linux.dev/vmksft-net/results/16721/41-txtimestamp=
-sh/stdout
>
> Thanks for catching this. I did break this testcase: run_test_v4v6
> ${args} -u -o 42.
>

To handle this particular case, I broke more than that, so I'll drop
this patch. Sorry for the inconvenience :( I must be out of mind.

