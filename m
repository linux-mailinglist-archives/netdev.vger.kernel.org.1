Return-Path: <netdev+bounces-183902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC1A92BF1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D077019E6C47
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F2155C82;
	Thu, 17 Apr 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKu+LjMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE72C8F0
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919389; cv=none; b=JRVFSgUGNK6dY4aQx7cjjlNXe8dKgQ+caIP3wbgzuPdwy1FzBvZQxhoGzLjGHaYSmBWMtasrMxCVDstidALBOb+S7jVaYjfCMuJqgnoqjr8ECPSle7GUI0im+m6ZnYi97918fyYfkmyNYKy8SAuLzvWCt0lSMwZNMyEB6R0E+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919389; c=relaxed/simple;
	bh=cAMXzv11HY3kGxt/DDTZfqtvX1cdTRHIS/5P3FZOwsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCQV9rT5xkpu5xSxxAe4HGeVV0YNsCd2STnYh5Fi8h4HHdqVxTHaXwMFzsIHKHsOdMJN72dCvkJ2QJkytA/bYrV0rUIJxL3+7LZwgBroh5/ZCTrmMQg6Xw5EQipTAT2B460bu0AMVpy+FSgOyGPH9nuox9FDcAUm7hcEqsv7ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKu+LjMH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so13909375e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744919384; x=1745524184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRGueA6d+L+F8bbvo5y1+E/L0Fjkht62PJu3iBFMMxo=;
        b=gKu+LjMHo5xCxsgzpLdbvzmtTmzBSB3h/wOSoOQi+W9Vfszxc7abXeTs4k+YHRSJXt
         nvl5sawkhyEmVk8xH7twL6b4Nebpcel7KY5Z83DZY4CgPc5wCcCFJD6tSxwnwKDQgCk8
         owXuzai5eXpnOK0B6123mQwFw6qsxLxNiRUKo8e93gmd9mwWjpv8Z4aXOWim/7HkpaLH
         jzjK3AxBHloySMoUCTUGwFSfwReObb3SNzdJHvq7FXMrJeHMpePNGWVUf1PgpmXtFQrg
         ZUSQLNB357T1gFJ+mky2Xw/kBPjXAY+wSa7nStKhamhUx5LzU4RMFysUDgj/1Rxtecx8
         2xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744919384; x=1745524184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRGueA6d+L+F8bbvo5y1+E/L0Fjkht62PJu3iBFMMxo=;
        b=YgDb/SAWAV4rCn9J9b5EoATXIrA38BjDBJb8j6LiGvYHzE58B1EO+aH9iPdT9CMAfc
         9vYJOKQXTj2FGOKoAB7rfDruyacC1x0YqEp4DCOkgEfbPpWK9INmuZsn6XzNG9qIUrX3
         MpGAZtbHLhr/+4uriuwBOsSmHYGmZy8ocjSnreR9LVm0ol+7gE1zqdB5C5BwrS8jYkXm
         ZQ0P8i+FRWWCE0ktwPW1YXQcwul0+xYeBw2dpRJS39nYjFJ09vIn1BuE2b0hAoNRfEu4
         MNc/AbuZsjt52wcUupD+WC/hlvGI9L/c39ugcaqxt/6w96/dUtrHO5p2IFR/6/mLvCNP
         jscA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zZEWAkOiRA+aYu53/eGmTTaN7AgC3Bvx4It8+WsNjBBa70l1tGcqyMIDEpJLtE8VVG4p+KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3uWF2kZYpeJJ51YvjaXBzB8WH0EW4aOuJKKVrs4zEcedrgY/
	6Ly7EhCpQn5eQX2AWC6BHd1TCH3+F0UK4fo7bcVaSmwXEZT3AOa5TcK9iFeP9b+ZDGfCaBwtFAe
	Bfxh0CI7mO8wBXyzkWSY9Fqz7hSE=
X-Gm-Gg: ASbGncuwN48EIdnRxomnALFWuXWWfYB4c6qyw6T/Aqcf2xmGt3Q1tgq85S8IgWQZjAG
	zIhNtW3sRWTPKBZ/kWOPdlOx2oGNj4jqY5DIJgDD+AG6dewoHiYrmBcXli4HbuILGw+4a029WBh
	+nVjMyhW/y1vPk7nnhyshTBc2c+vebKBRGJERNVwevVkakLkmz7eiWRdE=
X-Google-Smtp-Source: AGHT+IEiC5Fs19QfLWajWVOXwr1NbTHJ9KQ4gKVqXb4dKA3VEt5lLvq0hQdg+UgxksP6E3kP81lflnjKC9R66E7t/Gs=
X-Received: by 2002:a05:600c:3d96:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-4406aba6809mr2043475e9.17.1744919384097; Thu, 17 Apr 2025
 12:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z__URcfITnra19xy@shell.armlinux.org.uk> <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk> <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
 <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com> <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk>
In-Reply-To: <aAE59VOdtyOwv0Rv@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 17 Apr 2025 12:49:07 -0700
X-Gm-Features: ATxdqUGtmUs7rcuTomZbOwpkYQ2AmkbmYXPXJlFanNRPNS-_IPF5cLkfbgG2gRQ
Message-ID: <CAKgT0Uc_O_5wMQOG66PS2Dc2Bn3WZ_vtw2tZV8He=EU9m5LsjQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled and
 link down
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:27=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 17, 2025 at 10:06:45AM -0700, Alexander Duyck wrote:
> > On Thu, Apr 17, 2025 at 8:23=E2=80=AFAM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Apr 17, 2025 at 03:35:56PM +0100, Russell King (Oracle) wrote=
:

[...]

> > > So, we have the case where we want to avoid notifying the MAC that th=
e
> > > link has gone down, but we also want to call netif_carrier_off() to s=
top
> > > the network stack queueing packets.
> > >
> > > To achieve this, several things work in unison:
> > >
> > > - we take the state mutex to prevent the resolver from running while =
we
> > >   fiddle with various state.
> > > - we disable the resolver (which, if that's the only thing that happe=
ns,
> > >   will provoke the resolver to take the link down.)
> > > - we lie to the resolver about the link state, by calling
> > >   netif_carrier_off() and/or setting old_link_state to false. This
> > >   means the resolver believes the link is _already_ down, and thus
> > >   because of the strict ordering I've previously mentioned, will *not=
*
> > >   call mac_link_down().
> > > - we release the lock.
> > >
> > > There is now no way that the resolver will call either mac_link_up() =
or
> > > mac_link_down() - which is what we want here.
> >
> > The part that I think I missed here was that if we set
> > phylink_disable_state we then set link_state.link to false in
> > phylink_resolve. I wonder if we couldn't just have a flag that sets
> > cur_link_state to false in the "if(pl->phylink_disable_state)" case
> > and simplify this to indicate we won't force the link down"
>
> Then how does phylink_stop() end up calling .mac_link_down() ?

What I was saying is that we could add an additional state flag that
we set before you write to the phylink_disable_state. You would
essentially set the state to true if you want to preserve the current
state, and if it is true you would set cur_link_statte to false in
phylink_resolve ignoring the actual current link state.

So in phylink_stop you would set it to false, and in phylink_suspend
you would set it to true. With that change phylink_stop could force
the link down, whereas phylink_suspend would keep it up,
phylink_suspend could deal with netif_carrier_off, and phylink_resume
could deal with old_link_state.

Anyway it wasn't as if I was saying we need to make that change. I
have a bad habit of thinking out loud and it tends to carry over into
emails..

> > So fbnic_mac_link_up_asic doesn't trigger any issues. The issues are:
> >
> > 1. In fbnic_mac_link_down_asic we assume that if we are being told
> > that the link is down by phylink that it really means the link is down
> > and we need to shut off the MAC and flush any packets that are in the
> > Tx FIFO. The issue isn't so much the call itself, it is the fact that
> > we are being called in phylink_resume to rebalance the link that will
> > be going from UP->UP. The rebalancing is introducing an extra down
> > step. This could be resolved by adding an extra check to the line in
> > phylink_resume that is calling the mac_link_down so that it doesn't
> > get triggered and stall the link. In my test code I am now calling it
> > "pl->rolling_start".
>
> You're not addessing the issue I've already stated here.
>
> If the link was up, and we *don't* call mac_link_down(), we then *can*
> *not* call phylink_mac_initial_config(). It's as simple as that. The
> MAC must see link down before being configured.
>
> So, if the link was up, and we don't call mac_link_down() then we must
> also *not* call phylink_mac_initial_config(). I've no idea what will
> break with that change.

Sorry, mentioning it didn't occur to me as I have been dealing with
the "rolling start" since the beginning. In mac_prepare I deal with
this. Specifically the code in mac_prepare will check to see if the
link state is currently up with the desired configuration already or
not. If it is, it sets a flag that will keep us from doing any changes
that would be destructive to the link. If the link is down it
basically clears the way for a full reinitialization.

> > 2. In phylink_start/phylink_resume since we are coming at this from a
> > "rolling start" due to the BMC we have the MAC up and the
> > netif_carrier in the "off" state. As a result if we end up losing the
> > link between mac_prepare and pcs_get_state the MAC gets into a bad
> > state where netif_carrier is off, the MAC is stuck in the "up" state,
> > and we have stale packets clogging up the Tx FIFO.
> >
> > As far as the BMC it isn't so much wanting to hit the big red button
> > as our platform team. Basically losing of packets is very problematic
> > for them, think about ssh sessions that suddenly lock up during boot,
> > and they can demonstrate that none of the other vendors that have the
> > MAC/PCS/PHY buried in their firmware have this issue. I was really
> > hoping to avoid going that route as the whole point of this was to
> > keep the code open source and visible.
>
> The problem I have is not the idea, but the implementation. You want
> to change the phylink behaviour in a way that affects *all* existing
> users. I don't want that because of the guarantees of that contract
> I've previously stated that I've given to existing users.

That is why I mentioned "renegotiating the terms" in my other email. I
would be okay with adding a phylink_config variable for the
"rolling_start".

Essentially with "rolling_start" we would have:
1. phylink_resume would not call phylink_link_down to rebalance the state
2. phylink_resolve would have to call mac_link_up or mac_link_down
following the first call after phylink_start/resume.
3. mac_prepare would have to take on the responsibility of doing
mac_link_down prior to any destructive configuration change.
4. Calls to mac_link_up/mac_link_down would be idempotent essentially
meaning that calling up on a link that is already up has no effect
(other than maybe updating autoneg settings), and calling down on a
down link likewise would have no effect.

> As things currently stand, you have a currently unique new case, and
> you're trying to force your solution on all users potentially breaking
> them. I have no real issue with supporting the new case, but *not* at
> the expense of regressing existing phylink users.
>
> Yet, when I point out this, you seem to be dead against *not* affecting
> other users. This is where the problem is, and where we fundamentally
> disagree.

I am not sure where that impression came from. I realized after you
mentioned it that the change was too broad and I had mentioned
limiting it with a config option on the other thread.

