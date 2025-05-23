Return-Path: <netdev+bounces-192903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E8CAC18D3
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E459E36E8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FAD7E9;
	Fri, 23 May 2025 00:03:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4E19A
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958602; cv=none; b=A3BrD4g39pZ26U1dL5EecCsbjn8knexPqN00VCHbgNKuR8PkPwnFwvIQJ4HGw7pGmvd63KTSSc+A2GpVMc8fC5CoKBqI8bim3errDNcVQLI/RpvXNrJM+KsYUCxf+1R13QdUHc5cdxhaWDqIqoFCyMrFpll6KsggL/b5IYuiENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958602; c=relaxed/simple;
	bh=8ERv8eIZriPifEYJaP9W66EgolZ+p1Y7/W3SnNvlIjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgFHJpc8gelf05MUINoz2XFP4ug3k0x3QA92g70sMckTqu57ZV07/uRM43q3fYv/jHpY6byJXduPU1wv8Zi9zkrc6UIZO0vnqj/OFjRDlk+NgwPDGUSwVoR72mqwomqmvJFqqIxj8Sm+kD08VrakvHD+sd30BZe3lo3kGr3AKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e1d8c2dc2so447527b3.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 17:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958598; x=1748563398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RovqL75gpFe6dJbFP30Co6J+Apxxbbk2Mgn3/R8hvAA=;
        b=G4lNxGw4HOMiGfSb+zmiI4C2T2h0Q5MRabhiMre4uFP4yiOqM5SgJtzCWuhvhqm7xJ
         TojIiU3UYrg11l651dPRfkYJ/tz0FqOI2c5lP6jDrX01egt+bq/57UCcB/Z0BoTu0nix
         FAMwXHKhQen69DD9LWrzF/Xf1oJH4jixxSdv/0lVsFv1pPFJvY+xtwfAyh5gQEPJTQ8m
         jUyzinfaYdrwTSzN2ejrWR0veXzOi3pCX0QySDrb6A57a4QP0uZkgfM/F8hdatM62XKO
         Znodub5+1F7bQpqPQAzgvG6kCSSItuPm09vfdLRa4gddE+Jc2IOO2cSv00UmRe8/Abdp
         Ph8g==
X-Forwarded-Encrypted: i=1; AJvYcCVijoS/863qdxEhiFA9LjAJ01Y2SEzWjhnhW8exgSMVnRW+G4WGVRUsvj8igb7aD2WQMh0+FmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZVBruQFb+vlXzWU+E9WlGVuITDPyExdynMMTGKb/sC4OkWpT
	BLb+QswYywtiPmrcfmcsay1k10BaSOMuXODMs/sFpE/DsgG6wOr/cbQEi6/6Gbcr
X-Gm-Gg: ASbGncsH9LlMCSeE9kmg+cj5kPKWCSBmX/DV1fLmOaNnfmzBwsjfX16HRR6x1xyY7Ul
	1CSjVemxjCFmUrzpBCDooMdnQYL8w+W822u84UdoqJo6QahbHMJy9LBip5Nlb/OTxydh6YGlLjB
	0B8uwpGw2bqhQtafFmBDSyMoxPyWBC9KCi5lBtDW0QswF19I2jbTDgzA3tCtecYDxrH/1WVP03q
	VZKtodRpfUGoGDVCJ71V3z5lAFPywh5fZP3TKy6GVY8NFSqQhHo5Pyhxi0aYjJOZlg2y3cPcdvI
	sIDGzF+c04uFBWHgvnCCBHbMMwK0utGiQnfH69bzIbhXUleUGJ/sAQWvnfWl3/HyJTVHfjC6YhR
	rSFXSIjNhmVMM
X-Google-Smtp-Source: AGHT+IFI5euRN4ZwnOj/8TrWY9BzrNyMw0rcVKY87XZWLXPUwzh8JMhv2tVXZTY0riw30PijEuoXeA==
X-Received: by 2002:a05:690c:88f:b0:6ff:1fac:c4fc with SMTP id 00721157ae682-70e198fe377mr13839627b3.37.1747958597669;
        Thu, 22 May 2025 17:03:17 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca8357526sm32877437b3.61.2025.05.22.17.03.16
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 17:03:17 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-708b31650ffso74857377b3.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 17:03:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrT8Jxd6tleuaEGl7Qrqi2vQQ9NCpRbJROR93/vaMH1oU6pGDZ4yOVY6YsMTiDYvlYtIo7ep8=@vger.kernel.org
X-Received: by 2002:a05:690c:6d07:b0:702:627c:94ec with SMTP id
 00721157ae682-70e198fcb2bmr15180967b3.35.1747958596698; Thu, 22 May 2025
 17:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com> <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org>
In-Reply-To: <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org>
From: Luca Boccassi <bluca@debian.org>
Date: Fri, 23 May 2025 01:03:05 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
X-Gm-Features: AX0GCFuHoHpqndyK7LAwcQsuM3wULycAW2ho3EGGnAneoQi6uWkmk1xalCvUuRM
Message-ID: <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Yuyang Huang <yuyanghuang@google.com>, 
	1106321@bugs.debian.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 01:00, David Ahern <dsahern@kernel.org> wrote:
>
> On 5/22/25 4:55 PM, Luca Boccassi wrote:
> > On Thu, 22 May 2025 at 20:41, Adel Belhouane <bugs.a.b@free.fr> wrote:
> >>
> >> Package: iproute2
> >> Version: 6.14.0-3
> >> Severity: normal
> >> X-Debbugs-Cc: bugs.a.b@free.fr
> >>
> >> Dear Maintainer,
> >>
> >> Having iproute2 >= 6.14 while running a linux kernel < 6.14
> >> triggers this bug (tested using debian-13-nocloud-amd64-daily-20250520-2118.qcow2)
> >>
> >>     root@localhost:~# ip monitor
> >>     Failed to add ipv4 mcaddr group to list
> >>
> >> More specifically this subcommand, which didn't exist in iproute2 6.13
> >> is affected:
> >>
> >>     root@localhost:~# ip mon maddr
> >>     Failed to add ipv4 mcaddr group to list
> >>     root@localhost:~# ip -6 mon maddr
> >>     Failed to add ipv6 mcaddr group to list
> >>
> >> causing the generic "ip monitor" command to fail.
> >>
> >> As trixie will use a 6.12.x kernel, trixie is affected.
> >>
> >> bookworm's iproute2/bookworm-backports is also affected since currently
> >> bookworm's backport kernel is also 6.12.x
> >>
> >> Workarounds:
> >> * upgrade the kernel to experimental's (currently) 6.14.6-1~exp1
> >> * downgrade iproute2 to 6.13.0-1 (using snapshot.d.o)
> >> * on bookworm downgrade (using snapshot.d.o)
> >>   iproute2 backport to 6.13.0-1~bpo12+1
> >>
> >> Details I could gather:
> >>
> >> This appears to come from this iproute2 6.14's commit:
> >>
> >> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?h=v6.14.0&id=7240e0e40f8332dd9f11348700c0c96b8df4ca5b
> >>
> >> which appears to depend on new kernel 6.14 rtnetlink features as described
> >> in Kernelnewbies ( https://kernelnewbies.org/Linux_6.14#Networking ):
> >>
> >> Add ipv6 anycast join/leave notifications
> >>
> >> with this (kernel 6.14) commit:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33d97a07b3ae6fa713919de4e1864ca04fff8f80
> >
> > Hi Stephen and David,
> >
> > It looks like there's a regression in iproute2 6.14, and 'ip monitor'
> > no longer works with kernels < 6.14. Could you please have a look when
> > you have a moment? Thanks!
>
> were not a lot of changes, so most likely the multiaddress or anycast
> address changes from Yuyang Huang. Please take a look.

The original reporter suggested it was this commit that introduced the
regression:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?h=v6.14.0&id=7240e0e40f8332dd9f11348700c0c96b8df4ca5b

