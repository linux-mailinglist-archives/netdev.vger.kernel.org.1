Return-Path: <netdev+bounces-233691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82215C176C8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9500C188C38F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2D307494;
	Tue, 28 Oct 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXDaDgDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9C2D877D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695787; cv=none; b=aAEYp9Kal5NGVDs0+DDjGBsu3C324CoO88rXKvwsnzXuzKIlX9PyB91Z1Or7sbwSLnSl4NmxI66XYxyD34kQpNjBVge05oCgNX0NANU8ffeTCN+zAv/4t/12VYvuN7L59IoVVwaSjg4uTeuFAYewyJDqu+zFyhy6Uwx3e3XdTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695787; c=relaxed/simple;
	bh=/0N9ORma9yyQz483I8PiFsWtj258v9pM/8bShwWPf8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIMkjr/3AubZnJjeeCkhydHI/H0W4edgYiwFckO53QVYxhnEAenQ/FaTbHUGmguDOAKNjTgn9D+GCLVIpg6l1ZGFNxq1RxXzrkRkmfm6bOU2752ZsO6KXcN9BVxnguZzLvaWexkzyjAwmBXSkaMTOU9JJcgT4U3rv3M6LOMkM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXDaDgDc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29292eca5dbso86399045ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761695785; x=1762300585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0N9ORma9yyQz483I8PiFsWtj258v9pM/8bShwWPf8E=;
        b=zXDaDgDcNs9/G07Umlokhtb0jQcHU8suvrh6g7yhS4HmDB2NhynErBQpbdTYqfi4xu
         VZMM9Q7Oe4W5jOFpaaTuIeUbAi5Nxfd4bZ92hKTJ9TquixmLdyl5LZ5n2uZpP1xS7YN+
         b5YUp13cQIYpwVGANsa6fzEqAfYkTKKOLlC6BjAhQn3V/mAHvfkN7jtRG4ZEvz93eqXX
         AZtwd+Fgd2PAQobu8wGBMqlWJ+I1g9QejjLX2n2noN3CNCJU+f4sz0CpxWWHMdvnbcAg
         JDKCr5zDcCBkYVyleT+0rKqdALKxukxCQkNJIOIPIfnekQRXSDmxwxYpzlHrSN+gKju3
         ZTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695785; x=1762300585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0N9ORma9yyQz483I8PiFsWtj258v9pM/8bShwWPf8E=;
        b=Ftki4cEJse7b7mKKMKkW2DCg2zZb+2+TY/ZvKbPMQ2Czr6Ye1C6ZlneOeeKPFTezbb
         uqAJw4jC62FnvJ3KZ/AmO9XuZTI6DcyXw06Bvox8BBu/3jaqXCT5ZFtuOahGDanb5LQ4
         SdrfuILtPylz1KAmI1Kp7H/RRvyEsiUnQ5KXZwuzyKJW4a90PUIA4iXy7uOrJutQnlxl
         GGp+RQg52XNlflMD+88lTLjd3lrrVXx4prmMQqemQ+GGb+5hQKrFztmi8fHn3JT7NdfS
         Gknce0UfOfqqloDrXWPr1DGJYs2R0W9foAogiCfXpL+EDN2CocNRbL425mKw/ofAA8dU
         jqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPW76Z4Vwcp5t88p/HEzgyg4sOtKEq01EtbsU6oUeMkVKzB92Blj5/xLY7EHfLBAZuRxMpijY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxg98GGN1vRi+VbcuCF5JVuUoKIBjnMMqbno3ryjdrDZ2w+st
	wvrS2ELxGrkNZ61dq2WBJjV5NCIW9GwHNqJ8SsNhWajsGtkjeSJvKc5fyJYvuzxy2xNk+Hpv0LI
	o/DWahS3xQQ5kYRiWarDelTetM5+y4orkyr/MmPIk
X-Gm-Gg: ASbGnctS7cim4Xi3lXICP4gljx80b7sC3zcUt4PLpGWrO+Y/uF1FYvlotecnQYhIyeF
	zwOK/EtMOI0wrc0TKbxdTTv29+fNeFuLY2iOPImkiusowC51hgiGRyhFTvOcttsBwj9WdyXForH
	8nvWRrYTIb69N+778OAgF2PAa2hTOBW3YKY8rdpCb3mJPF+yxWzfVSjpNYQsK15GPUt6rgdm+7I
	0IKlR2gkWSDLGNjIc7uPGoP9B09eVIQYyzDfrm+qC4J2p33fYOXCpwMPluTLU5JLAMGaVRKsLap
	Qypbo5vUFVCusxU=
X-Google-Smtp-Source: AGHT+IFatLYbHgumwd6jQygPW3FigVQRptY1GN8W7MZvNB10udE7xpMJ0tvoBxr9tzO+iQklpZ2J3exztSNO7TP/YHU=
X-Received: by 2002:a17:903:1ca:b0:290:d0fb:55c0 with SMTP id
 d9443c01a7336-294deee2019mr10424485ad.43.1761695784834; Tue, 28 Oct 2025
 16:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org> <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org> <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
 <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
In-Reply-To: <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 16:56:13 -0700
X-Gm-Features: AWmQ_bkzayhokme2D3DiD1Ejdr_9Y9DyGrBM9QjBOQ-SDBS1bm6E5J5PPfZPDSI
Message-ID: <CAAVpQUABk5vw=Re4WqhoL0qZ3cDZ98Hg0dsN2OEWF89DzTC_EA@mail.gmail.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, junjie.cao@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, thostet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Oct 28, 2025 at 4:45=E2=80=AFPM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
> >
> > On 28.10.2025 23:13, Jakub Kicinski wrote:
> > > On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
> > >> From: Richard Cochran <richardcochran@gmail.com>
> > >> Date: Tue, 28 Oct 2025 07:09:41 -0700
> > >>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> > >>>> Syzbot reports a NULL function pointer call on arm64 when
> > >>>> ptp_clock_gettime() falls back to ->gettime64() and the driver pro=
vides
> > >>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in=
 the
> > >>>> posix clock gettime path.
> > >>>
> > >>> Drivers must provide a gettime method.
> > >>>
> > >>> If they do not, then that is a bug in the driver.
> > >>
> > >> AFAICT, only GVE does not have gettime() and settime(), and
> > >> Tim (CCed) was preparing a fix and mostly ready to post it.
> > >
> > > cc: Vadim who promised me a PTP driver test :) Let's make sure we
> > > tickle gettime/setting in that test..
> >
> > Heh, call gettime/settime is easy. But in case of absence of these call=
backs
> > the kernel will crash - not sure we can gather good signal in such case=
?
>
> At least we could catch it on NIPA.
>
> but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
> !info-> getimex64) in ptp_clock_register() so that a developer can
> notice that even while loading a buggy module.

Of course this needs to check settime too.

