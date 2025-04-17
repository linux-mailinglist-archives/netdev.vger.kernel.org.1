Return-Path: <netdev+bounces-183845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D9A92368
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ED41893C78
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FA5254AEC;
	Thu, 17 Apr 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFfpIui8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656635973
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909645; cv=none; b=Lk4fhi/iToadOmxdXNv5lZZn1IevVqALWURyFHzkeUHHBrfLnzNtr6mqw6jtoFRVg+mHIBeOSz3/jWcRLjUfM71siJzrlx5yTsx8onGfxUcG9rJC0qo1x8qHc1BelO6NBJHiLTdG107Yn0lH2oL182EZZJBuDt8KuC5yk/NIwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909645; c=relaxed/simple;
	bh=0DDLMJPWqpyhL3M2KftDw73ZcDQzywRupPNXb/miP6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c063pLMP6CplVovEc4jC14Ih7oUA7xxAXSzqmVWiJcsXLxzK8f6dPFKIaP7LGpki5jsCulZ+k6swz0R43w43MkVIU5yqdtb/WtL5SJCPyTR8BmzuPW0BcXAm+DQb2GGdql6F5YmvdD9Ypy85RpzjOOXorwlTZQYFR7kYcZdGkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFfpIui8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1efc4577so681300f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744909642; x=1745514442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgvWzRP4Sf5RyzYeEsmO4zIZoF0DA1uT7vyYG4ONbZQ=;
        b=dFfpIui8dv656ZCRpx3njxsCk5O3yjtBZP7ZcrK6QiX8kncjMOGd4NVkocRST8mNHU
         GmukCLetn1Z95lRduKwuY1CPMi/pcWfTj69sIn0ITL54/ojgmbVi8IQQnP8R1/Ko4Lye
         kbvh5UjW5Vm/3l60k1F3mpoz3Rwjddez+zrC36DcI1tMqHvQoSeSNpZH1BK4vdSBQ+0r
         3uDS0PUexN2AUDeTuk7GameRCK+EN0S0H7D+ql6T9QclitRgzwfq5U9bnR8qwXJwJUht
         zCW1fSkwTbqOfAJ8hZo7QT4v3Y4fO+orXIYiCZHs+aA18fEEHyVWAnZrUuAON0ZwfdUk
         TM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909642; x=1745514442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgvWzRP4Sf5RyzYeEsmO4zIZoF0DA1uT7vyYG4ONbZQ=;
        b=KvGQtcqL4y65EoLvKvcZSt2XWsetfEoRmC1CKLgkCFLIg5tSPu/mTH5ZAXMdPaN59y
         kHgC0n8uwJ6BL5Ce6AShJ0eo/U63x+8wMHs07Ya0ipgEgSvOJoFHDposNOh1u9qDcDtz
         bksBlTHwgzX6t9keADwUC3oBUVSaFRQliXLa94dZtRYZoWd4rDuul5Fjs0c9TrpxWJmj
         KwG/bbdrKCbpYT/LnRu5saZ6sxOF9H91VUbIBc1snE4Ld5XBj5MN5gpbNVMZujXW/zxV
         4LZNA8KPKnMdYKQaY0x1T8/bUZPIxgfhgN35bVOPOPIESmVSEhNx8S3Ie49GCvE3G94q
         xucg==
X-Forwarded-Encrypted: i=1; AJvYcCU0dsMOJ3ZtJoMBlvFoKhyppNi06BqcbG/GijwRErmOq9w0wThKZwX852lVnc8qbr0Nm65SWo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOd2R/6wXWmCTkmqxrM6+U08xntLs3FqKkA9wHMvqTWEv8B88Z
	1KjFQqXEGhQzf+ZUd4ISTD5Nchk0ts2p+BLQFD+LeLLVVhIrwAwg6CYkPoezc8mPtDa0kUox8Nl
	6V4VSUy7hpyIF4V11rr0cege5uJU=
X-Gm-Gg: ASbGncvdN9ffMG2qXqpVa/vw0xMqgD+8+ZJVQ1/z9YiiWapvYQ+uk9y89x5hIDn+fuZ
	Lmx2QW2O8toXtlTLZAwd+skMPLhVMJaRG2N76g6dLQXi2YP2WS6aijBPL2dBAtqc1hjEZhFSPS8
	4FtbjDr20CNufd/s0Gn8qRMGaLo7OGExnW9rcurlpI6IsP73rKDQal4E0=
X-Google-Smtp-Source: AGHT+IFafFx93D0/kFMTWm6DujlZPuTZZmH54yj3AJAfZkbMh/VCM6MbE7fw5nC06761G81m5A4uSq20wwA0aUc4bsE=
X-Received: by 2002:a5d:5887:0:b0:391:2a9f:2fcb with SMTP id
 ffacd0b85a97d-39ef9ee079fmr369836f8f.36.1744909641779; Thu, 17 Apr 2025
 10:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z__URcfITnra19xy@shell.armlinux.org.uk> <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
 <9910f0885c4ee48878569d3e286072228088137a.camel@gmail.com>
 <aAERy1qnTyTGT-_w@shell.armlinux.org.uk> <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
In-Reply-To: <aAEc3HZbSZTiWB8s@shell.armlinux.org.uk>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 17 Apr 2025 10:06:45 -0700
X-Gm-Features: ATxdqUHFJLVYm-YwtDNj2p4gWmnI1Svkbv5rBHV1YITP56j1N1adZD_ICXAC4Hs
Message-ID: <CAKgT0Uf2a48D7O_OSFV8W7j3DJjn_patFbjRbvktazt9UTKoLQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled and
 link down
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 8:23=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Apr 17, 2025 at 03:35:56PM +0100, Russell King (Oracle) wrote:
> > On Thu, Apr 17, 2025 at 07:30:05AM -0700, Alexander H Duyck wrote:
> > > This is the only spot where we weren't setting netif_carrier_on/off a=
nd
> > > old_link_state together. I suspect you could just carry old_link_stat=
e
> > > without needing to add a new argument. Basically you would just need =
to
> > > drop the "else" portion of this statement.
> > >
> > > In the grand scheme of things with the exception of this one spot
> > > old_link_state is essentially the actual MAC/PCS link state whereas
> > > netif_carrier_off is the administrative state.
> >
> > Sorry to say, but you have that wrong. Neither are the administrative
> > state.
>
> To add to this (sorry, I rushed that reply), old_link_state is used when
> we aren't bound to a network device, otherwise the netif carrier state
> is used. Changes in the netif carrier state provoke netlink messages to
> userspace to inform userspace of changes to the link state.
>
> Moreover, it controls whether the network stack queues packets for
> transmission to the driver, and also whether the transmit watchdog is
> allowed to time out. It _probably_ also lets the packet schedulers
> know that the link state has changed.
>
> So, the netif carrier state is not "administrative".

I have always sort of assumed that netif_carrier_on/off was the
logical AND of the administrative state of the NIC and the state of
the actual MAC/PCS/PHY. That is why I refer to it as an administrative
state. You end up with ifconfig up/down toggling netif carrier even if
the underlying link state hasn't changed. This has been the case for
many of the high end NICs for a while now, especially for the
multi-host ones, as the firmware won't change the actual physical
state of the link. It leaves it in place while the NIC port on the
host is no longer active.

> It isn't strictly necessary for old_link_state to remain in sync with
> the netif carrier state, but it is desirable to avoid errors - but
> obviously the netif carrier state only exists when we're bound to a
> network device.

From what I can tell this is the only spot where the two diverge,
prior to this patch. The general thought I was having was to update
the netif_carrier state in the suspend, and then old_link_state in the
resume. I realize now the concern is that setting the
phylink_disable_state is essentially the same as setting the link
down. So really we have 3 states we are tracking,
netif_carrier_ok/old_link_state, phylink_disable_state, and if we want
the link state to change while disabled. So we do need one additional
piece of state in the event that there isn't a netdev in order to
handle the case where "pl->phylink_disable_state &&
!!pl->phylink_disable_state =3D=3D pl->old_link_state".

> > > > -         /* Call mac_link_down() so we keep the overall state bala=
nced.
> > > > -          * Do this under the state_mutex lock for consistency. Th=
is
> > > > -          * will cause a "Link Down" message to be printed during
> > > > -          * resume, which is harmless - the true link state will b=
e
> > > > -          * printed when we run a resolve.
> > > > -          */
> > > > -         mutex_lock(&pl->state_mutex);
> > > > -         phylink_link_down(pl);
> > > > -         mutex_unlock(&pl->state_mutex);
> > > > +         if (pl->suspend_link_up) {
> > > > +                 /* Call mac_link_down() so we keep the overall st=
ate
> > > > +                  * balanced. Do this under the state_mutex lock f=
or
> > > > +                  * consistency. This will cause a "Link Down" mes=
sage
> > > > +                  * to be printed during resume, which is harmless=
 -
> > > > +                  * the true link state will be printed when we ru=
n a
> > > > +                  * resolve.
> > > > +                  */
> > > > +                 mutex_lock(&pl->state_mutex);
> > > > +                 phylink_link_down(pl);
> > > > +                 mutex_unlock(&pl->state_mutex);
> > > > +         }
> > >
> > > You should be able to do all of this with just old_link_state. The on=
ly
> > > thing that would have to change is that you would need to set
> > > old_link_state to false after the if statement.
> >
> > Nope.
>
> And still nope - what we need to know here is what was the link state
> _before_ we called netif_carrier_off() or set old_link_state to false.
>
> I somehow suspect that you don't understand what all this code is trying
> to do, so let me explain it.
>
> In the suspend function, when WoL is enabled, and we're using MAC-based
> WoL, we need the link to the MAC to remain up, so it can receive packets
> to check whether they are the appropriate wake packet. However, we don't
> want packets to be queued for transmission either.

That is the same as what we are looking for. We aren't queueing any
packets for transmission ourselves. We just want to leave the MAC
enabled, however we also want to leave it enabled when we resume.

> So, we have the case where we want to avoid notifying the MAC that the
> link has gone down, but we also want to call netif_carrier_off() to stop
> the network stack queueing packets.
>
> To achieve this, several things work in unison:
>
> - we take the state mutex to prevent the resolver from running while we
>   fiddle with various state.
> - we disable the resolver (which, if that's the only thing that happens,
>   will provoke the resolver to take the link down.)
> - we lie to the resolver about the link state, by calling
>   netif_carrier_off() and/or setting old_link_state to false. This
>   means the resolver believes the link is _already_ down, and thus
>   because of the strict ordering I've previously mentioned, will *not*
>   call mac_link_down().
> - we release the lock.
>
> There is now no way that the resolver will call either mac_link_up() or
> mac_link_down() - which is what we want here.

The part that I think I missed here was that if we set
phylink_disable_state we then set link_state.link to false in
phylink_resolve. I wonder if we couldn't just have a flag that sets
cur_link_state to false in the "if(pl->phylink_disable_state)" case
and simplify this to indicate we won't force the link down"

> When we resume, we need to unwind this, but taking care that the network
> layers may need to be reprogrammed. That is done by "completing" the
> link-down that was done in the suspend function by calling
> mac_link_down() (which should only have been done if the link wasn't
> already down - hence depends on state _prior_ to the modifications that
> phylink_suspend() made.)
>
> It can then re-setup the MAC/PCS by calling the config functions, and
> then release the resolver to then make a decision about the state of
> the link.
>
> With the fix I posted, this guarantees that that the contract I talked
> about previously is maintained.
>
> I'm sorry that this doesn't "fit" your special case, but this is what
> all users so far expect from phylink.

I wasn't trying to "fit" it so much as understand it. So this worked
before because you were clearing either netif_carrier_off or
old_link_state and the resolve function followed the same logic. The
piece I missed is that setting the bit in phylink_disable_state is
forcing the link to resolve to false which in turn would call
mac_link_down if the old state is considered to be up and a netdev
isn't present.

> Now, how about explaining what's going on in fbnic_mac_link_up_asic()
> and fbnic_mac_link_down_asic(), and what in there triggers the BMC
> to press the panic stations do-not-press red buttin?

So fbnic_mac_link_up_asic doesn't trigger any issues. The issues are:

1. In fbnic_mac_link_down_asic we assume that if we are being told
that the link is down by phylink that it really means the link is down
and we need to shut off the MAC and flush any packets that are in the
Tx FIFO. The issue isn't so much the call itself, it is the fact that
we are being called in phylink_resume to rebalance the link that will
be going from UP->UP. The rebalancing is introducing an extra down
step. This could be resolved by adding an extra check to the line in
phylink_resume that is calling the mac_link_down so that it doesn't
get triggered and stall the link. In my test code I am now calling it
"pl->rolling_start".

2. In phylink_start/phylink_resume since we are coming at this from a
"rolling start" due to the BMC we have the MAC up and the
netif_carrier in the "off" state. As a result if we end up losing the
link between mac_prepare and pcs_get_state the MAC gets into a bad
state where netif_carrier is off, the MAC is stuck in the "up" state,
and we have stale packets clogging up the Tx FIFO.

As far as the BMC it isn't so much wanting to hit the big red button
as our platform team. Basically losing of packets is very problematic
for them, think about ssh sessions that suddenly lock up during boot,
and they can demonstrate that none of the other vendors that have the
MAC/PCS/PHY buried in their firmware have this issue. I was really
hoping to avoid going that route as the whole point of this was to
keep the code open source and visible.

> If you wish to have confirmation of what netif_carrier does, then I'm
> sure your co-maintainer and core Linux networking maintainer, Jakub,
> would be happy to help.

I'm well aware of what netif_carrier does, no need to be patronizing.
I have been doing this for over 16 years. The difference is for me the
1G stuff was 16 years ago, most of the stuff I deal with now is 25G or
higher and multi-host which is a different world with different
requirements. This is why we are having our communication issues in
understanding where each other is coming from.

