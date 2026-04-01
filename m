Return-Path: <netdev+bounces-274113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCmgH3YezWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:32:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5637B48A
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0338A3008D6D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F42BE026;
	Wed,  1 Apr 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IYf90vKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477E29D294
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050340; cv=pass; b=FhYOvrtGD6JuPzYFaueX70VJ1IjnBlCJotzRjU+vZ0RHNXvQbUGRjN6loMd7ugxztZu+b2dzpL0jxDscMuf3LaBExv+ay0lSXTNHGANg6+OAhNZsydLHsGR2OpPEWbsaawVWbEAdYvx0sxxFtq3CD3IymcCnGTxBZFUJRQXJANs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050340; c=relaxed/simple;
	bh=ykQYpIr849OOIDjLXpVI4Ic/6DsLZ9LnNWTQxd0yrhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PccEKgbXAHKoNHFV9TgzwhUVge+tFGWrx6RN4bmIC5l1/TuiqAOOj6LnoMaFWDiMg6rbPL4bTTu3jt1pWiZwN5zyziK0r/OmSJenAd+O6QIClXIupSowmX4UJ5vJrmxNomOAsfy+h5NngIuVFYhTtAk/CdfPZ1E8yJJRM353nsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IYf90vKQ; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66c5b2e41c1so2992909a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050337; cv=none;
        d=google.com; s=arc-20240605;
        b=kONE3g4fgdHNjmPO019AfSMFF8csl0a47pF8CvISM8uycs+7bTZcT0Dy8Ils6Tj8PT
         NllYK4FOjb0qDgVryp9oKO/nXHO8pGt1eAddRRLpgjvWBGC8ogLTANga6Ak9yRnJwQG5
         fEU4SSA0d/+r2jqplA+yinJ6CRw7EGbvqT+5HUhUVTPCYVv7/0C5PxpGpqM/Y5qm3hMu
         5mtj/pBz6ErWXkctEedKdy3ahVT78SCQOadUmCo9GGffKXJjWZ/0hC7FRii30iD5Ojb+
         lRrWAllgzpZ3ivF67vB5pSrczsM2GFWAVGefVguiVWHyRbevWfWqB4Qjs/i/DHFp1SPB
         OaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIE8jQyRjrcrddwXuE5cIpyEHP3IztKvb+gkeBWSXM8=;
        fh=8i4BkJ7A2sbsgM1+Fe68SjLDkqmJfGNb+pxYd/lDi1E=;
        b=CCG0kj4Y3aBP//xFhOHs584n+K2fk/zGoCsYENtQWvRaZr0slfATTPbCmS5+i6DGnS
         7RKcBoqbOjlMCeMmRGWRcTwz43FagzFx5c9UBZgBRKVVzXrAa3rmXOEWb9XaYYzy6flS
         aUBXXjOJ4EEqa9PfTX9jhG+8on6hIlijKjjaB+Pg3CrE8HJOgt/yI7iRrgscts050QA2
         1MaS/oYl3GfXA/dVJYxKHWJvDsLWF7WRJVhlGRt1y2We56N8UJdp22kWn8xTeNBYuJmg
         Rhi/g7k8En63F23ZvOrZOosQL/JY3D2p1hh1pw0YRmDvzsKFhor/zTwmSFCeawbCrQ57
         52ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775050337; x=1775655137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIE8jQyRjrcrddwXuE5cIpyEHP3IztKvb+gkeBWSXM8=;
        b=IYf90vKQtboJxl2kHz7IYOlVXvEMSL0Ew01Xr3neycbuf4UIzsfjoZjbsyi5H+i2jF
         9wVbnTbI7mE8PsoG2CLcy7Ub+4uYW/v/MBI/0HAILSXfPHLPracRue+OrxAuQaizgu3t
         E2Mw8t0PYW0TT58aqgU7aoDhyUoAxEm4Zb6IUA1jWNPOyBnne8W9PLMoc4XpBdA8Bg8f
         dnaEgdO2UZdfqex+cgg6/JIQMhJ/0zJBygeLyk1oYDw6mNfpd3CFC3076jaI3eN3fuoq
         yPEehAqRvrA52nNBk8b1uS6KktSHgW/pPgpmkvV4WE4GTrtgnRvaK+fj8eBhZkFWRxNQ
         XITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050337; x=1775655137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gIE8jQyRjrcrddwXuE5cIpyEHP3IztKvb+gkeBWSXM8=;
        b=daar/oijTBrnFHhR0jBCCWN4EScMxPAWOv35WX59tpkWyNimGgPVrgbpWB78Yrrnp+
         fxTWGc2K9rTkziTYuRPnV+2vCQOxOF5JvWFZiJ8XWT5QG2mC6xxj2O1jeKpR5pRdkKLZ
         bxncQJINPpxiHsbwaOUZUUMtzKXrAauEwVY/BuVG84lzqmJd6LMKhKeLXtoIOKfJJ9ua
         6W+oIEaL5lU2g3+5pzQ+UCLAyxne4S9MOKF7PCDxOKsj85UX+/oP0+iUkogctqW5AF9O
         4b/ouK+zRYGj/RvvjofkmTmyduC1kU5g2M6H04MoAjITYNoiYXpOQQVnTVCShJKTG88S
         TLbQ==
X-Gm-Message-State: AOJu0YzmYMVhcSyyjfKwba6vBPMWrZhzITILV68emFQ+isXbm16HV4Xf
	3jMtxq7oHMJIdGLFkdR0Ouv0qnJiH1CPbqll0C1e0yo3zMCDb7teEi6F8Tf32OkwB14P9ZUL7vg
	Ei1iEWUKPi4lpIgyn7oXbOD8YvoEwvTSurYAMyyyCYw==
X-Gm-Gg: ATEYQzxRh89QR5KA1vAfB8HQ9ijBFeu5cs2/pOx4dCGNQKBzBNigqBySXGRbkEXeNCy
	8dcH3P/7fzH2eDJnK6z2hsulT+3LJfHmFbDDv2E/GtAQfoN6nUZZOMHXtf5bw/B5KQpELR+sLac
	wz8IjM0AqDEsN2Yd0CV0oTuxIN5yoqQBxSFjrL0b5kJANjDkUbjrzUK9RA7E8kE/c3K5WDYxiBh
	7Y5L+48u8eeULl/x9wCtzEfKm+5w2sNHXhkmnnuxPQZdth2x7tMdQcjv80Lb7n08EgzSwOrIMoQ
	PwVqhA==
X-Received: by 2002:a17:907:841:b0:b9b:f6c:a67e with SMTP id
 a640c23a62f3a-b9c133756e1mr251574866b.0.1775050336411; Wed, 01 Apr 2026
 06:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325134439.3048615-1-louis.scalbert@6wind.com>
 <20260325134439.3048615-2-louis.scalbert@6wind.com> <CAJ5u_OcpOGSPYK-EzYeW8LdpJrLd16fGn6zN6cvk+tCjCi+QxA@mail.gmail.com>
 <118159.1774630613@vermin>
In-Reply-To: <118159.1774630613@vermin>
From: Louis Scalbert <louis.scalbert@6wind.com>
Date: Wed, 1 Apr 2026 15:32:04 +0200
X-Gm-Features: AQROBzBArbK8fUuaC8SXxQzAN0IrdRnSUx5GcIyLsuASPRHVShVxJFJJnXFKsL8
Message-ID: <CAJ5u_OceyA2oXopDbB96sQ7UG7AMFm3KtjXiZNZicd2S7PK7QA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] bonding: 3ad: fix carrier when no valid slaves
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net, 
	shemminger@vyatta.com, maheshb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274113-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,6wind.com:dkim,6wind.com:email,jvosburgh.net:email]
X-Rspamd-Queue-Id: 30E5637B48A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Thank you to Mahesh and Jay for your helpful feedback.

I have reviewed the IEEE LACP standard on this specific topic and conducted
tests to provide as accurate a response as possible.

Le ven. 27 mars 2026 =C3=A0 17:56, Jay Vosburgh <jv@jvosburgh.net> a =C3=A9=
crit :
>
> Louis Scalbert <louis.scalbert@6wind.com> wrote:
>
> >Hi everyone,
> >
> >Le mer. 25 mars 2026 =C3=A0 14:44, Louis Scalbert
> ><louis.scalbert@6wind.com> a =C3=A9crit :
> >>
> >> When an 802.3ad (LACP) bonding interface has no slaves in the
> >> collecting/distributing state, the bonding master may still report
> >> carrier as up. In this situation, no slave is actually able to transmi=
t
> >> or receive traffic.
> >>
> >I=E2=80=99ve just realized that the issue description is not entirely ac=
curate.
> >
> >Bonding links that are not in LACP Collecting/Distributing state are
> >excluded from traffic
> >distribution in favor of those that are. However, if no links are in
> >Collecting/Distributing state,
> >the kernel considers all links as valid for distributing traffic.
> >
> >> As a result, upper-layer daemons consider the interface operational
> >> while traffic is effectively blackholed.
> >
> >There are situations where traffic is not blackholed.
> >
> >For example, a Linux machine A is connected to machine B using two
> >aggregated links.
> >On A, LACP is configured, but not on B. As a result, LACP will not
> >reach the Collecting/Distributing
> >state since B does not send LACP frames. However, the bonding
> >interface will still be up on both
> >sides, and traffic can be exchanged.
>
>         Bonding does this because, in the absense of a LACP partner, the
> interfaces in the bond will become Individual links, each of which will
> become its own aggregator, one of which will be chosen to be active.

Thank you for the detailed description of the current behavior. I
confirm that this matches
what I am observing: only one link is selected for both transmitting
and receiving traffic,
while traffic received on the other enslaved links is discarded.
>
>
>         This is in compliance with the standard, (802.1AX-2014, 6.1.1.j)
> and is intended to permit some communication between a system that is
> LACP-enabled and a system that is not.  The common example I'm familiar

The exact statement is:
"Backwards compatibility with aggregation-unaware devices - Links that
cannot take part in
Link Aggregation because of their inherent capabilities, management
configuration, or the
capabilities of the devices to which they attach operate as normal,
individual links."

This wording has remained unchanged from 802.3ad-2000 through 802.1AX-2020.

It implies that when the partner does not support aggregation (i.e.,
does not run LACP), all
bond slaves should fall back to operating as normal, individual links.

However, this is not how the kernel behaves today: it selects only a
single link for forwarding,
while traffic received on the other enslaved links is discarded.

As such, the current implementation does not comply with the standard.

>
> with is a host that PXE boots over a network, connected to a
> LACP-enabled switch.  During early boot, the PXE environment does not
> perform LACP, but still needs to communicate with the switch.

In this scenario, the switch is the Linux machine. The current
behavior is only effective
if the kernel happens, by chance, to select the port used by PXE.

On Cisco Catalyst switches, when LACP fails to negotiate on all links,
the PortChannel
interface is placed in a suspended state, resulting in carrier down.
To achieve the
IEEE-defined behavior, the user must explicitly configure "no
port-channel standalone-disable".
In that mode, all links operate independently, meaning the switch
forwarding table maintains
MAC entries per link rather than per PortChannel interface. This
allows PXE to function correctly
in such scenarios.

On Cisco routers, however, the only possible state in this situation
is a suspended PortChannel
(carrier down). There is no option to fall back to independent links.

As far as I know, this default behavior (disabling the aggregation
when LACP is not negotiated)
is also the default on other vendors such as Juniper, and is the
behavior I intend to implement
to address the traffic blackholing issue.

Implementing the IEEE-compliant behavior would only be relevant for
bonding interfaces
enslaved to bridge interfaces. My tests in this scenario, without any
LACP negotiation, show
that the bridge only learns forwarding database (FDB) entries behind
the bonding interface,
rather than per individual link. This capability could still be added
in the future if needed.

>
>
> >This behavior is, of course, not compliant with the LACP (802.3ad)
> >standard, but applying this fix
> >as-is could introduce regressions in some setups. Under normal
> >conditions, having no Collecting /
> >Distributing links means that no interfaces are operational for
> >handling traffic - that is precisely the
> >purpose of using LACP.
>
>         FWIW, generally speaking we've settled on IEEE 802.1AX-2014 as
> the version of the standard to which the bonding implementation should
> be conformant.  There is a more recent version, -2020, but it is a
> significant change from the prior versions.

Good to know - thanks for pointing that out.

>
>
> >I will publish a new version with a knob to enforce compliance with
> >the LACP standard. It will be
> >disabled by default for backward compatibility.
> >
> >What do you think of "lacp_strict" or "lacp_enforce" ?
>
>         I'm not convinced that we are in violation of the standard with
> the present behavior.  That said, if such a switch is necessary, I'd
> vote for "lacp_strict".

I suggest addressing the traffic blackholing issue by introducing the follo=
wing
configuration knob. lacp_fallback_mode:
- legacy or 0 (default) value: the current behavior
- strict or 1: set the carrier down
- A value of 2 could be added later to support the IEEE-compliant mode
with bridge
  interfaces, if needed.

Best regards,

Louis Scalbert



>
>
>         -J
>
> >>
> >> Fix this by asserting carrier only when at least 'min_links' slaves ar=
e
> >> in the collecting/distributing state (or collecting only if the
> >> coupled_control default behavior is disabled).
> >>
> >> Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
> >> Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
> >> ---
> >>  drivers/net/bonding/bond_3ad.c | 24 ++++++++++++++++++++++--
> >>  1 file changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond=
_3ad.c
> >> index af7f74cfdc08..6d3613755d45 100644
> >> --- a/drivers/net/bonding/bond_3ad.c
> >> +++ b/drivers/net/bonding/bond_3ad.c
> >> @@ -745,6 +745,22 @@ static void __set_agg_ports_ready(struct aggregat=
or *aggregator, int val)
> >>         }
> >>  }
> >>
> >> +static int __agg_valid_ports(struct aggregator *agg)
> >> +{
> >> +       struct port *port;
> >> +       int valid =3D 0;
> >> +
> >> +       for (port =3D agg->lag_ports; port;
> >> +            port =3D port->next_port_in_aggregator) {
> >> +               if (port->actor_oper_port_state & LACP_STATE_COLLECTIN=
G &&
> >> +                   (!port->slave->bond->params.coupled_control ||
> >> +                    port->actor_oper_port_state & LACP_STATE_DISTRIBU=
TING))
> >> +                       valid++;
> >> +       }
> >> +
> >> +       return valid;
> >> +}
> >> +
> >>  static int __agg_active_ports(struct aggregator *agg)
> >>  {
> >>         struct port *port;
> >> @@ -2120,6 +2136,7 @@ static void ad_enable_collecting_distributing(st=
ruct port *port,
> >>                           port->actor_port_number,
> >>                           port->aggregator->aggregator_identifier);
> >>                 __enable_port(port);
> >> +               bond_3ad_set_carrier(port->slave->bond);
> >>                 /* Slave array needs update */
> >>                 *update_slave_arr =3D true;
> >>                 /* Should notify peers if possible */
> >> @@ -2141,6 +2158,7 @@ static void ad_disable_collecting_distributing(s=
truct port *port,
> >>                           port->actor_port_number,
> >>                           port->aggregator->aggregator_identifier);
> >>                 __disable_port(port);
> >> +               bond_3ad_set_carrier(port->slave->bond);
> >>                 /* Slave array needs an update */
> >>                 *update_slave_arr =3D true;
> >>         }
> >> @@ -2819,8 +2837,10 @@ int bond_3ad_set_carrier(struct bonding *bond)
> >>         }
> >>         active =3D __get_active_agg(&(SLAVE_AD_INFO(first_slave)->aggr=
egator));
> >>         if (active) {
> >> -               /* are enough slaves available to consider link up? */
> >> -               if (__agg_active_ports(active) < bond->params.min_link=
s) {
> >> +               /* are enough slaves in collecting (and distributing) =
state to consider
> >> +                * link up?
> >> +                */
> >> +               if (__agg_valid_ports(active) < bond->params.min_links=
) {
> >>                         if (netif_carrier_ok(bond->dev)) {
> >>                                 netif_carrier_off(bond->dev);
> >>                                 goto out;
> >> --
> >> 2.39.2
> >>
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

