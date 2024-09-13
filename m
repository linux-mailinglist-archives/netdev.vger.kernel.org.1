Return-Path: <netdev+bounces-127991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1169776F3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D20286022
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80B1AD261;
	Fri, 13 Sep 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwKjNqPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155E1A08AF;
	Fri, 13 Sep 2024 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194980; cv=none; b=k/arpFiy+UYFsAcZaR16cz3rwoWYiC7xAiDa5CKdMLuthNfx0lPFAYqGIg1dtZ27XWrjNeQFVLOXibTWfcqGLVnGbbKegLnE/LF+dHAxXxT1CLEJfcjRftCddJq5r0lefAQLEt7FQxzxZHn1tdEKDJnrsuoKjvHAyT2OCEbIXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194980; c=relaxed/simple;
	bh=UJ4halBqLeahXAKe7jj1N0wNu3uOCW51Ndg589XE+Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiNKIKymzoMOTfN/q1i1Z9yc/G47ZzjQGuAxG1K7lFy9L9+KIxDL7L+XvDB0yydSWUdeUD9/WQLhPsBo3Nh+Wl1Bk+NG5OuSSIuHloE6lrvjfUKExDEqnfjzJuUKTQ2bCbX68QfnO+eft8LOIY59K3PnQrW2j6+oUy4baaH08Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwKjNqPM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b47ff8a59aso3780367b3.2;
        Thu, 12 Sep 2024 19:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726194978; x=1726799778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR8OlrtEVAckklbppGR2MTY9nvy6Nn5gypXETkHfWkA=;
        b=iwKjNqPMCZp9q/Uz4RRvO35IzcjKUblHgc3/EeSpAaN7mvK06zL4pKKRiUYhGlJ6R9
         XT+3Xyp7wGGYPrzog7s0axe8ZP/qkJE4mLUcrXDm8mldHwcmXpnYf1IH/eX7hyoDoy7Z
         KFY+wcpoN3OYKle1qi9MLlGODY0IIjuDnA9+cDkpkiTTEACizX5IsWyPos9EsvgNCZpn
         qDPDwU0EkBSojDJ5MXNVaekX257NSnNeaPr5mwCF8QSVZdlr++IVFpSjhfjxPPBLrNnD
         BhAnBwJy44StQrfgZExXL8AwlTXqyx7Adf9veN81lob7w8pe69Yg6URw1lPrr42Vp62D
         4rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726194978; x=1726799778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aR8OlrtEVAckklbppGR2MTY9nvy6Nn5gypXETkHfWkA=;
        b=NeZstttOUz4+GVKD1N14/QzTZakcjxMCccCr8yok8iV/73+kTKEloUN8/55D7GnZOS
         4y9wqW4KD06mNI7YRrDqzdigZ946FMJZDtsIVv9JNbuXBwg6KtMsVu0/v0+oEiU/BxkY
         xPUQrmjNjXfsZeyonfQI9E/Ww6lLfAYOyxCZaHbXeFn1FzNOw4bjewd5Yc30uiK/FlKA
         pL2kBOF9KodkOZBtza4GCUgrqn8xbHqB3xlOlUu8NQVnTIcrp46z0Lne2DXvtADIi4nq
         Qy1Xh+POsagV9ovuNm2gE72L1OX3SqLj7WCcD1k/oh4/CXxuCzDatSirnVkh+z1Uu4p9
         67Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVBoYOoMkvBGOH4A9H7Fq8R6aDGwTay6NP3mqCgBOC9P82XxQXef36W4BPoecWwublk9ZSBtpIU@vger.kernel.org, AJvYcCXhaGrmEKzELpcI++M3IqKTF0CzxlHWkd5j8olglyK7cRK1kwu8qp7633+sk8NGJA64W/B4/owlHnZIHY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bmMtzvfy9XR2xsRQPr/VdaRfBgDBrtOdD/s3p4iDBW70n+gL
	+aAUkroda6Zm91V4OQ2j+rdhQJjyweawdw/KFDCXz9YGgEY5DbRQg2B3ofDI11pyybNkjTMDvYL
	ZgmqGl12mujnWL48ybMd+iekT6qE=
X-Google-Smtp-Source: AGHT+IHgenMOWl5KC6OZc+0SqjGUEEDC1Lj7J9oksQ1NtQfn9+fTZ6q9QH71gl2GEm09OPZnTOd8YHRyzAXWs6aqK1w=
X-Received: by 2002:a05:690c:f0e:b0:65f:a0e5:8324 with SMTP id
 00721157ae682-6dbcc22fdb7mr14925627b3.4.1726194977837; Thu, 12 Sep 2024
 19:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912064043.36956-1-suresh2514@gmail.com> <397121.1726186016@famine>
In-Reply-To: <397121.1726186016@famine>
From: suresh ks <suresh2514@gmail.com>
Date: Fri, 13 Sep 2024 08:06:06 +0530
Message-ID: <CABAyFk4dzN_Oprod1LM_X1x+-bHg8HxnJ1OzhLRD092mY4ON3w@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: do not set force_primary if reselect is set
 to failure
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks  a lot for reviewing.

I was working for a customer issue where they removed a primary NIC for swi=
tch
maintenance and when added back, it caused iscsi storage outage because the=
y
did not expect the bod to do a failover.

So bonding is behaving as default. But then I thought maybe we can do
something to cater for such scenarios and came up with this idea.  But
I agree my
testing was not a failure as I see ""Link Failure Count: 0" there.  I
used the below
command from my kvm host to simulate a link down and up.

     virsh  detach-interface testvm1  --type network --mac 52:54:00:d7:a7:2=
a

and attached it back with:

    virsh  attach-interface testvm1 --type network --source default
--mac 52:54:00:d7:a7:2a
     --model e1000e --config --live

So what would be the best solution here if I want to take out a
primary NIC for maintenance,
and then add it back ?.  I was also  trying with 'ifenslave'  to first
make secondary NIC active
and then remove primary NIC.

   ifenslave -d bond0 enp1s0

The interface changed to 'down', but immediately it came back up and
became active again.
I don't know why. The journal logs suggest my NetworkManager is
autoactivating it again :)

Thanks a lot for your time again.

- Suresh

On Fri, Sep 13, 2024 at 5:36=E2=80=AFAM Jay Vosburgh <jv@jvosburgh.net> wro=
te:
>
> Suresh Kumar <suresh2514@gmail.com> wrote:
>
> >when bond_enslave() is called, it sets bond->force_primary to true
> >without checking if primary_reselect is set to 'failure' or 'better'.
> >This can result in primary becoming active again when link is back which
> >is not what we want when primary_reselect is set to 'failure'
>
>         The current behavior is by design, and is documented in
> Documentation/networking/bonding.rst:
>
>
>         The primary_reselect setting is ignored in two cases:
>
>                 If no slaves are active, the first slave to recover is
>                 made the active slave.
>
>                 When initially enslaved, the primary slave is always made
>                 the active slave.
>
>
>         Your proposed change would cause the primary to never be made
> the active interface when added to the bond for the primary_reselect
> "better" and "failure" settings, unless the primary interface is added
> to the bond first or all other interfaces are down.
>
>         Also, your description above and the test example below use the
> phrases "link is back" and "primary link failure" but the patch and test
> context suggest that the primary interface is being removed from the
> bond and then later added back to the bond, which is not the same thing
> as a link failure.
>
>         -J
>
> >Test
> >=3D=3D=3D=3D
> >Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
> >
> >Bonding Mode: fault-tolerance (active-backup)
> >Primary Slave: enp1s0 (primary_reselect failure)
> >Currently Active Slave: enp1s0
> >MII Status: up
> >MII Polling Interval (ms): 100
> >Up Delay (ms): 0
> >Down Delay (ms): 0
> >Peer Notification Delay (ms): 0
> >
> >Slave Interface: enp1s0
> >MII Status: up
> >Speed: 1000 Mbps
> >Duplex: full
> >Link Failure Count: 0
> >Permanent HW addr: 52:54:00:d7:a7:2a
> >Slave queue ID: 0
> >
> >Slave Interface: enp9s0
> >MII Status: up
> >Speed: 1000 Mbps
> >Duplex: full
> >Link Failure Count: 0
> >Permanent HW addr: 52:54:00:da:9a:f9
> >Slave queue ID: 0
> >
> >
> >After primary link failure:
> >
> >Bonding Mode: fault-tolerance (active-backup)
> >Primary Slave: None
> >Currently Active Slave: enp9s0 <---- secondary is active now
> >MII Status: up
> >MII Polling Interval (ms): 100
> >Up Delay (ms): 0
> >Down Delay (ms): 0
> >Peer Notification Delay (ms): 0
> >
> >Slave Interface: enp9s0
> >MII Status: up
> >Speed: 1000 Mbps
> >Duplex: full
> >Link Failure Count: 0
> >Permanent HW addr: 52:54:00:da:9a:f9
> >Slave queue ID: 0
> >
> >
> >Now add primary link back and check bond status:
> >
> >Bonding Mode: fault-tolerance (active-backup)
> >Primary Slave: enp1s0 (primary_reselect failure)
> >Currently Active Slave: enp1s0  <------------- primary is active again
> >MII Status: up
> >MII Polling Interval (ms): 100
> >Up Delay (ms): 0
> >Down Delay (ms): 0
> >Peer Notification Delay (ms): 0
> >
> >Slave Interface: enp9s0
> >MII Status: up
> >Speed: 1000 Mbps
> >Duplex: full
> >Link Failure Count: 0
> >Permanent HW addr: 52:54:00:da:9a:f9
> >Slave queue ID: 0
> >
> >Slave Interface: enp1s0
> >MII Status: up
> >Speed: 1000 Mbps
> >Duplex: full
> >Link Failure Count: 0
> >Permanent HW addr: 52:54:00:d7:a7:2a
> >Slave queue ID: 0
> >
> >Signed-off-by: Suresh Kumar <suresh2514@gmail.com>
> >---
> > drivers/net/bonding/bond_main.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_=
main.c
> >index bb9c3d6ef435..731256fbb996 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -2146,7 +2146,9 @@ int bond_enslave(struct net_device *bond_dev, stru=
ct net_device *slave_dev,
> >               /* if there is a primary slave, remember it */
> >               if (strcmp(bond->params.primary, new_slave->dev->name) =
=3D=3D 0) {
> >                       rcu_assign_pointer(bond->primary_slave, new_slave=
);
> >-                      bond->force_primary =3D true;
> >+            if (bond->params.primary_reselect !=3D BOND_PRI_RESELECT_FA=
ILURE  &&
> >+                bond->params.primary_reselect !=3D BOND_PRI_RESELECT_BE=
TTER)
> >+                          bond->force_primary =3D true;
> >               }
> >       }
> >
> >--
> >2.43.0
> >
>
> ---
>         -Jay Vosburgh, jv@jvosburgh.net

