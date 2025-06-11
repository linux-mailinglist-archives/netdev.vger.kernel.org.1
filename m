Return-Path: <netdev+bounces-196560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3BAD54DA
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796873A4192
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58827781E;
	Wed, 11 Jun 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIpBbe5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5772777FE
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643269; cv=none; b=eSA3yP6qg2fVOiujgpkSuawyu7z24GLS8rVcSQunYWdFnUU1EDUhKmlDR8HWSxJ+3EekRfRzAlGv1n9Q9TJ0qFKDjHG/qzalS41u/l/vb0C82kgpaoCwBIenlPpS0GWfOoxFQtSCQaaSWE5gSctWGfhpbikcTE8aJLYH/x9N7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643269; c=relaxed/simple;
	bh=k9LZXCcByngexuUBR+002Omz8kpIR5IANbWpIZuRsbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwWLXTER3ov4XL98QvI7/2GHd6ZfVIONXPiDmeS8AY8nQlwHdVRPD/h60GKTQNdtUn0rQY3ewNxMUtza6vhyK7HlFD0/cMWiEhWpBFfKu0Daa1G7iv7w1/L9/a7rDHtYB5kShjlWbNCg85tBL541DCm0w4GsE81w5SH3H+hCLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YIpBbe5l; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-407a6c6a6d4so1953631b6e.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 05:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749643267; x=1750248067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LEd6M4oc80xWbomrA3LCDl0vmSlrad/9yOHJfjYI+4=;
        b=YIpBbe5l4CF00Iy1hFmLbbv0wfqe49cZ/2tYL+6KfZK+Gkyc/xa0bSzcs1piCKFmcT
         NoxQOaG7vaZvtPUbNz8HRwOq1esdebfycBp1rz1WBA0fEDDrEPqcz3sEV8jlImdrD5F5
         5bbkpyqGXD95ZOT/YHqhNf/PIlOgvL8DEDQlsJPqU7cq/wtFD7KTh1YRdxHPymLkLyh/
         s9+J6APDKhnTV3THQOsHAF0t2wS6Yu6SXYACeyMnF4cLuPKjrCvdlgDoVhHYEPuys4qR
         xeF4ZYbuCGVKm3l7Pmp9FIrPthyuhLNpg7ONzDk3zaEr0kMfYya0gzenRskfDYsMsAp8
         jYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643267; x=1750248067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LEd6M4oc80xWbomrA3LCDl0vmSlrad/9yOHJfjYI+4=;
        b=QfBVCIYu6pN0QH/z2BfWOd/rcWr76e2mRKfZ4CoXguk+KX8FCwBjtIQv7uOgIB85I2
         v14/YF8nREjsVvAi7k44tdw+aOCjGkGJJWVF0hkk71LuXTWdWFDKiXcrhtOZf4oQXBP+
         58fZqpA+AhrAO2mJN9FAhLYAsPofllWv2nnPQtoqKV9h0tYMAa0v6XybMcEgmzd0Qxx6
         HLuTQyS23gy5LjBoK5vxhNCjNT0blg172itvzOk9Zu5jm3DVoBpw46MxGE8WUhQS6TAK
         xW2VdAMlBaVjHDHc/GDzx7Ql+GlyrY9PBpgw7M7rOUJuVw5ff+Mc/u/FtQeEWqh4mOSQ
         HBoA==
X-Forwarded-Encrypted: i=1; AJvYcCVoVfyCrQlcTaGlc5MiQNthS2GxAbPQmxKQNty9pFwm5u5GFrmeDKu3oMU4QXSmvemuF5DcLTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXiqjpBQEZk+GJDv1RjM007VPQaCGErf5xieU6LpM8yFYv/qa
	zcFUR1hMoEgF3qoCsh7neKhyLmT55g8/CLzwqHb56hhvBimJ5klDbynPuy/DPKI3ubil4+e0GJx
	sdnwkgkvvEgkzYtywEdqGX5U8wlrxPrFJzkz0vMe6
X-Gm-Gg: ASbGnctYBO+7dAZLjRyj/yEaTRM3SYx6BvAlZXt+GqlI08nKbCU6ZLuTDUwqwJCPFHz
	sh8tUqkizq00IkT88uAdM5Tiak1BUUIGaB8x6iQWNAkgDes7AEGMRun39vz5L4eJB9cz/oqp08x
	4o95rV4ySofkdVXShVA6f0ZdwqHFbwjlyq8YnGKzKl25PY
X-Google-Smtp-Source: AGHT+IEvzOOOsphtzPRNc1DLlGyGxPTlICxcofsNuQV3w+egJQ0855UWQsI6P8d2M6mnQnRamFHlC0kkiGsKZ5cqA1M=
X-Received: by 2002:a05:6808:2287:b0:404:764:f7b6 with SMTP id
 5614622812f47-40a5d080784mr2255448b6e.9.1749643266640; Wed, 11 Jun 2025
 05:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX> <CANn89iJiLKn8Nb8mnTHowBM3UumJQrwKHPam0JYGfo482DoE-w@mail.gmail.com>
 <aElna+n07/Jrfxlh@v4bel-B760M-AORUS-ELITE-AX> <CANn89i+Lp5n-+TQHLg1=1FauDt45w0P3mneZaiWD7gRnFesVpg@mail.gmail.com>
 <aElqlbPP+9UcInJa@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <aElqlbPP+9UcInJa@v4bel-B760M-AORUS-ELITE-AX>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Jun 2025 05:00:55 -0700
X-Gm-Features: AX0GCFtFVHXjDQNJjy1pNEqjtT2DgxkNXYy5ooie7XgAJAuGnxopZu9ZUYYIQHQ
Message-ID: <CANn89iL+YJsz-PCe-suCCnKVkuxUVMy9R0mJFGW9o=3Vi8A1gQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: fix use-after-free in taprio_dev_notifier
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, vinicius.gomes@intel.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	v4bel@theori.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:38=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> On Wed, Jun 11, 2025 at 04:28:44AM -0700, Eric Dumazet wrote:
> > On Wed, Jun 11, 2025 at 4:24=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com>=
 wrote:
> > >
> > > On Wed, Jun 11, 2025 at 04:01:50AM -0700, Eric Dumazet wrote:
> > > > On Wed, Jun 11, 2025 at 3:03=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.=
com> wrote:
> > > > >
> > > > > Since taprio=E2=80=99s taprio_dev_notifier() isn=E2=80=99t protec=
ted by an
> > > > > RCU read-side critical section, a race with advance_sched()
> > > > > can lead to a use-after-free.
> > > > >
> > > > > Adding rcu_read_lock() inside taprio_dev_notifier() prevents this=
.
> > > > >
> > > > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > >
> > > > Looks good to me, but we need a Fixes: tag and/or a CC: stable@ o m=
ake
> > > > sure this patch reaches appropriate stable trees.
> > >
> > > Understood. I will submit the v2 patch after adding the tags.
> >
> > Thanks, please wait ~24 hours (as described in
> > Documentation/process/maintainer-netdev.rst )
>
> Okay, I will submit the v2 patch tomorrow. Thank you for reviewing it!
>
> >
> > >
> > > >
> > > > Also please CC the author of the  patch.
> > >
> > > Does =E2=80=9CCC=E2=80=9D here refer to a patch tag, or to the email=
=E2=80=99s cc? And by
> > > =E2=80=9Cpatch author=E2=80=9D you mean the author of the patch
> > > fed87cc6718ad5f80aa739fee3c5979a8b09d3a6, right?
> >
> > Exactly. Blamed patch author.
>
> To avoid confusion: when you say =E2=80=9CCC the patch author,=E2=80=9D d=
o you mean
> adding the author to the CC tag in the v2 patch, or simply including
> them in the email=E2=80=99s CC field?

Whatever works for you. We only prefer to let them review the fix,
maybe they know
something we do not know ;)

