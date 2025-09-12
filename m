Return-Path: <netdev+bounces-222630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5FB551DB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0D71896C49
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D8B30E84B;
	Fri, 12 Sep 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="auXB7vrt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551E13BC0C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687478; cv=none; b=JNlKWYYXt5nAil8pRQ4kRwaclTBsKQmklP9VJkyv3tT0agv1ZoFkluCTmM3hq+ax7MfZeaWWVrvBbvaNVU2r6KnnaDWuwtd8pcE3BRygJiMeCdxhvehVr7ZiNe5cto3nJ4GFoD6ZjNaFSZ0JtaNvzErgbEUkuuio6jdVCMoIaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687478; c=relaxed/simple;
	bh=gR40+yv5BWAm9m99zpH/dybVEm+38OUMRErLrB4+G3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ/uTHfAyGsLwxHalQTm0zsc4ovPFPvt+/0osWiY3BSHrcEtpK5MlxabBtkegx6HXjofGtPMwII3RlcNhvZQO5ayYLlNOQU3kp3s4/evw/PWOSK3oaiDL+3nPIghRne7Jo5mzg/WUGrGZRO4oTb9pzFVNcGpAoLqLng0YfPq93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=auXB7vrt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1962336b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1757687475; x=1758292275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmzyGR3UO+vTnHSahpvjv5m2UCx489FjqpBnPUP8w/o=;
        b=auXB7vrt6zzBgh7sWXj7AWsLa/LR/wjC9gQpuUziNJmv9ciYJE+Q+xNHn+AwCHVU5K
         niybF5EAyCc9Jh0ibnbu6sN+y+Gt8yg5yP0cQJmaSAftZ4ocGwLjJ5B6eZgrTNz1YxxI
         b5Oiy6UR9VJahQT5vpxLfw/2bQ+ghmBY93XBTFoAhVTlWSG9JJeDpNcjbReO0GtBZCHo
         prlqho80hH9nq/birSP3YQ1d/j4Bc282eHjASP3TpTsOEgLyS4NtEV8IR3GOUFW+PwoR
         hR0w+DQl8SBAKItsWBB1+bhR+UgE606tWPAzRLtvVryyRwpZXUtz71HJCKLscSrmOSdm
         bJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687475; x=1758292275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmzyGR3UO+vTnHSahpvjv5m2UCx489FjqpBnPUP8w/o=;
        b=S41wIafO8dDuuXxfDlbfSkoLIxi8G/YgW/ROaTI9nPWvorLgK24bhQZIZqiC89YLm7
         KsycEXi69ZngNhgyswpQugXCQ65HWMIJDk3V5BBOlovbKw6C/+wFJQ8S7pxXGAO8BrPe
         s2YdBEBQHPGqXWMiMG14pPgyzvpOJ2zXJb15WQVPhrXbkinipGBJXqh+COdclamoJLjb
         anz43qFiOjReSgiZXlfqs+HZS6q7ovNCs2SZa2xfv05575mEHwgVE2wazlKFpWqObhmS
         8JKQTKlPDk6phKzPmmfWTWZOnhaeWEmkK7DE4BTK4BS00JX/3AkeM+ShnoID3P286i21
         THIA==
X-Forwarded-Encrypted: i=1; AJvYcCW4WzDa4QGH6x7HoZYb0rXVDsEU2m0V1iAJ+IpN1WyQpqk+8BxKBOY/bbBs0jGNXx3JhX8IQRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/4wT5ZyzwjbtqsEMyD/LUuRETyB6SkEXuKAWCQQ3i11OR2Bz
	DTA3IHw5w5P6PiiEn9kx1eOsdt6ot+LsIwmvTs/9EiPcT9cRot4MHnemeKl2tehosZV2WsAIhRx
	HvWRwMZ2fdvIUii6ELGxKhsm3sdYrb5MDI3l67b3AvWS+Tunm5sc=
X-Gm-Gg: ASbGncsI/BRz7trsAB5NuCGW+lOr4sn8UQrlGEUH54RftvgzcfPs2EzHZhyY6GH4FN0
	wfHM97NxkIa3io/VpWeVWGYQDwcL17EzF4bNf9ssG0oKg6PreydxQdAj86/EE7TNwOs4o0PrnFY
	TZ3MCdmbDSaiXAVdhGF1Pn7OG/w+zVp7D8QEz0ItTCTgbYap4hxwoYv1u1ag4oE9z8Cgovj0ylJ
	nAFGyx1znnGErk5Y9BrCX3c6CDc5HJb5NvWGgayaj7VsCvgwmBIric+giqIiPlnhHxTKw==
X-Google-Smtp-Source: AGHT+IFBUJt3Csm6eE5RXFliSaTZkxqWhnj+Q9O8wEbJrmZbmSox7+yAwdItlnTcqf+8LA6GyIjn1yKxFF4NoqWujYQ=
X-Received: by 2002:a05:6a20:6a10:b0:24e:c235:d7e6 with SMTP id
 adf61e73a8af0-26029ea90c7mr4091241637.5.1757687475439; Fri, 12 Sep 2025
 07:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907014216.2691844-1-jay.vosburgh@canonical.com>
 <CAM0EoMmJaC3OAncWnUOkz6mn7BVXudnG1YKUYZomUkbVu8Zb+g@mail.gmail.com>
 <d5b7afbf-318a-49c8-9e40-bcb4b452201b@gmail.com> <3090258.1757650744@famine>
In-Reply-To: <3090258.1757650744@famine>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Sep 2025 10:31:02 -0400
X-Gm-Features: Ac12FXwLcCe_jHERL4eT4fYASLugePwmNl8Yv_3TeoJwS2YdXKHwZYuOTzv3G0Y
Message-ID: <CAM0EoM=Q6ewcUbdM_GahUmubxvQeJWAwxPu+3hmC2U1KjPb5_Q@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc/police: Allow 64 bit burst size
To: Jay Vosburgh <jay.vosburgh@canonical.com>, Victor Nogueira <victor@mojatatu.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:19=E2=80=AFAM Jay Vosburgh
<jay.vosburgh@canonical.com> wrote:
>
> David Ahern <dsahern@gmail.com> wrote:
>
> >On 9/9/25 9:32 PM, Jamal Hadi Salim wrote:
> >>
> >> Please run tdc tests. David/Stephen - can we please make this a
> >> requirement for iproute2 tc related changes?
> >
> >I will try to remember to run tdc tests for tc patches. Without an
> >automated setup, there will be misses over time.
> >
> >>
> >> Jay, your patches fail at least one test because you changed the unit =
outputs.
> >> Either we fix the tdc test or you make your changes backward compatibl=
e.
> >> In the future also cc kernel tc maintainers (I only saw this because
> >> someone pointed it to me).
> >> Overall the changes look fine.
> >
> >Sent a patch to add a tc entry to iproute2 maintainers file.
> >
> >You say the change looks fine but at least one test fails meaning
> >changes are requested?
>
>         Yes, I ran the tests and saw one failure, in the following:
>
>         "cmdUnderTest": "$TC actions add action police pkts_rate 1000 pkt=
s_burst
>  200 index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions ls action police",
>         "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit burst=
 0b mtu 4096Mb pkts_rate 1000 pkts_burst 200",
>
>         Which is trying to match a returned mtu value of "4096Mb" but
> the new code prints "4Gb"; should be straightforward to change the test
> to accept either returned value.
>
>         Or I can take out the bit that prints sufficiently large values
> in units of Gb, if you've got a preference for leaving that part alone.
> Doing so would ease the lockstep problem between the tests in the kernel
> tree and the change in iproute2.  The numeric formatting isn't the
> important part of the patch set, so I'm ok either way.
>

For backward compat we need to support both. IOW, if someone was using
an older tc then a new kernel should work fine and not fail because of
different output expected. @Victor Nogueira wanna take a crack at
fixing the test? Then when the iproute side is merged as is - both
should work.

cheers,
jamal
>         -J
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com

