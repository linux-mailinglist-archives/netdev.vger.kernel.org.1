Return-Path: <netdev+bounces-238327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6E1C574EC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282AC3A69D6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148634A790;
	Thu, 13 Nov 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7y3z4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F134A763
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035201; cv=none; b=X0ateQReWTL9bYJfw/yZHIHMBbp84SsHqKjDI5rekh/DM2OHn1ZEFRB9rBNL6GpEMlQLJ6gQIRVbsywDsgRHuLGf/QRTKZ4LccGWdyUCNL6JOOYfn3+N5EXYpYYNsnUYM4BUk1K41+ohIzVEpy0dVJPbgCFiFY85LNinQYf6lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035201; c=relaxed/simple;
	bh=Lp9i0ZSl2rq//bWjr5frYukKfai0PGoswOl3P98erLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3G6ttjqHrsYmNm4mutf7Uz2e3RkX6fHqBJOUEj/gFdzzSIw31b6ZNr4lJJ+NqUxKkeP/kUuIP+r5dRfKRhDlccVHhKKtGh3cMvXlqgqqWvLVcNaI+fqXCExWZ44UEh0syy6+dtE6ADnPmgsOgfrXMp68XeNuOveuz/SoGhstq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My7y3z4l; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so660237f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763035198; x=1763639998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpknJZsSeY+Fpx5863cfCLEDKFKcvKrKKe9v03tcfVw=;
        b=My7y3z4lmX1t/4fYlCvh3MCHoJSK+PoXdg7YuwO3g4/h59jpZx67n/9BVFcwTJVwj8
         IemnbpsXzoZQKtis/oskGevMEj21seKiPjdPWmkc2BnxF5Ig5kj0TrMQ1ZodKWmdutUO
         81GrJfp+d6p/V5NRy8VrKoasylRyJQDlMB3IkDZT0GKQiibfjLPXB++FyoVza7LD48uD
         rdp/+XPrjaIIde7sEog8H6311/7rZ/CohsvjD4Zo/XiDAuPhifND18g8idDxLXs6izWP
         mJeSB7EkL4ijrKyLs5ZcWhg5ylD0hMtglHgV3OHvyozUvSRKXyHFs+W/XtoM+/Y4dQOU
         82jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035198; x=1763639998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpknJZsSeY+Fpx5863cfCLEDKFKcvKrKKe9v03tcfVw=;
        b=TNLbQK3bYD17PpkDNcFlIIjgD1B+d537YyiE3Ae4wMKJ3Gy6BqLmvYJZVydUQUxzS4
         96//AoMc52b/8K58qIfBaJkyo4PiVtLrA4xMho223KbRCLFEUqncl2LB0RNs17gbPlwn
         QCaea1JzWGZH2xcmEOQLDk23FNDy8WlR1cntvi5O6KIs3Al6M2TClLCgt7zCwMavkjvH
         sg621BlzejMEaXZqPfHvs1mExAv5klLhfXNh1V/FwAi+iZPyglb4XMinU3whUOl4FfQN
         zdxuc6PyPOGJaMMN6NOIElU3OKFSXBYFzGuyASRioMoHwl87Xwo2RdTPPH/4IPljY3sg
         xSxg==
X-Gm-Message-State: AOJu0Yzm9ty5zxEYQNjcgSy9dE4JewPjWhYEQK68hh60ffqSz6AI+7JO
	WqGFvtSzGNeQ1gzGhJ0XFKZN2i+kmVq+ZZc3xSZe9ABAS1R2EUTomDfzxItyif20t2mS6wGC6Ob
	5+ZteK092vi9NCS11Y62mKo/aunQrOgI=
X-Gm-Gg: ASbGncsBW5BjkbxiOOuztDAVpwAArk3mXM6S00/emAmwDsrFApAoDypKIpQdlGLYC3c
	4O3pPsxScndr28yaLe0lVs7BBAmQA+4iNj3jRa9kUfzRIyWW/evPZwu/KWePJTHo4ywDuI/f017
	3xa14a84LYplgVVU+Z0f0edVlt/k2wHKY/W5xphS6OQA0aBkZ/wxAU4BGYkRTwuHAVrzLwE54Fa
	vy1IpXj9RZUuHslldNsZVc9fsicy/j5aP/jaTM1Fwz5ADoVQ9q5sv6bzAjd
X-Google-Smtp-Source: AGHT+IFxQrJQ9IuJ9yg6IVshbHibjQAWSGo3WtkheGypyx0UGUde3thApZnh/tqPtoq6SWlxMOBeOjun016CMrcICiE=
X-Received: by 2002:a05:6000:4024:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-42b4bb90c87mr6400351f8f.14.1763035197425; Thu, 13 Nov 2025
 03:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
In-Reply-To: <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
From: Susheela Doddagoudar <susheelavin@gmail.com>
Date: Thu, 13 Nov 2025 17:29:44 +0530
X-Gm-Features: AWmQ_bmAK_GPA06I1inoIzLpcIcmOAr87DqR-UvcwtHT9Lvb71yFDRs9WomOa-k
Message-ID: <CAOdo=cOUA3vJ3BE5eb6DZECrSg6-q6y7cmufQiYnX6=-1Y4RMg@mail.gmail.com>
Subject: Re: Ethtool: advance phy debug support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, 
	Hariprasad Kelam <hkelam@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Lee Trager <lee@trager.us>, 
	Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

I sincerely appreciate the time and effort you invested in offering me
advice, and
I look forward to hearing from others as well.

thanks,
Susheela

On Thu, Nov 13, 2025 at 4:41=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On 13/11/2025 06:12, Susheela Doddagoudar wrote:
> > Hi All/ Michal Kubecek,
> >
> > To support Advanced PHY Debug operations like
> > PRBS pattern tests,  EHM tests, TX_EQ settings, Various PHY loopback et=
c.....
>
> Added a bunch of people in CC:
>
> I don't have feedback on your current proposition, however people have
> showed interest in what you mention, it may be a good idea to get everyon=
e
> in the loop.
>
> For the Loopback you're mentionning, there's this effort here [1] that
> Hariprasad is working on, it may be a good idea to sync the effort :)
>
> [1] : https://lore.kernel.org/netdev/20251024044849.1098222-1-hkelam@marv=
ell.com/
>
> As for the PRBS, there was a discussion on this at the last Netdevconf,
> see the slides and talk here [2], I've added Lee in CC but I don't
> really know what's the state of that work.
>
> [2] : https://netdevconf.info/0x19/sessions/talk/open-source-tooling-for-=
phy-management-and-testing.html
>
> Maxime
>
>
> > proposing a solution by custom ethtool extension implementation.
> >
> > By enhancing below ethtool options
> > 1.ethtool --phy-statistics
> > 2.ethtool --set-phy-tunable
> > 3.ethtool --get-phy-tunable
> >
> > Currently standard ethtool supports 3 parameters configuration with phy=
-tunables
> > that are defined in "include/uapi/linux/ethtool.h".
> > --------
> > enum phy_tunable_id {
> >         ETHTOOL_PHY_ID_UNSPEC,
> >         ETHTOOL_PHY_DOWNSHIFT,
> >         ETHTOOL_PHY_FAST_LINK_DOWN,
> >         ETHTOOL_PHY_EDPD,
> >         /*
> >          * Add your fresh new phy tunable attribute above and remember =
to update
> >          * phy_tunable_strings[] in net/ethtool/common.c
> >          */
> >         __ETHTOOL_PHY_TUNABLE_COUNT,
> > };
> >
> >
> > Command example:
> > # Enable PRBS31 transmit pattern
> > ethtool --set-phy-tunable eth0 prbs on pattern 31
> >
> > # Disable PRBS test
> > ethtool --set-phy-tunable eth0 prbs off
> >
> >
> > Let me know if the proposal is a feasible solution or any best
> > alternative options available.
> >
> > Thanks,
> > Susheela
> >
>

