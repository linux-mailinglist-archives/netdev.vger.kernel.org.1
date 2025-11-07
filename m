Return-Path: <netdev+bounces-236713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17937C3F45B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9F34E4DEA
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9132DE6E5;
	Fri,  7 Nov 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIF3Oqme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A82701C4
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509245; cv=none; b=sPVHHP+o9yJ2mLmY60dkBcGrH1o9Ot55sZKuY7a8fE+AUiAM3OBtPC2INT+kZLdJku+G8jALIx4K8sf2ucHln+uQmiY0+3Hjig/pkTfTggYdS/SnHRrqWRpzKPtr1Dprkjv7fH+t8XiOonHbZWpsQhjMzXb01Hl6VrxXG9mKrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509245; c=relaxed/simple;
	bh=LJJEk10POdcTsPhHa19ZeOv6WD/yQjLxyWkbC1toxzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6kK5dV0oI2IFLCfB27XDvzf9OtM7SHyzTm+MjInDiF5aypSwoD4tvZlTNZZXJ0k/reHB4PiF/i+4TJ9TlJwPXT+4OR6AwbF55hSpJwsE3X5nVzsyvbO8jE/nImUOePVvIQjqAQbw8JTJvdeUmCyBHZKN5STuN/3E7X+Qf6TDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIF3Oqme; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29470bc80ceso6088375ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 01:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762509242; x=1763114042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdFrpCMgzVY+qjVrXkUkn7fFQNGJUHKXO+rmqKz+1v0=;
        b=jIF3Oqmezwi0bkvjLvyK9FinpmRgMKMxmFSe6ydV8ke5dzJSqn2L6Imo796wsLbinB
         QA9ih+nvrDQmQvvFwO90moH8dSWlrGJVQi/OIZ4vR/+O/3p1CPRxf5tVb1TP+L7CM1m7
         /L+f3iq6Uc9fz2szO67I5+UZdhU69Q5mVk4mahhmdF9P6NoLq8bXCLPBo3CeJCBNroRV
         wgV351693syWR1QwuAje3Es9lA7mnFsVwi43UZi7NI+AElE9D225LA/mqmNYycl4mBtD
         dEDfS0OcxcmFzHGSQMzwmgezdF2K93fSekdOj20St1lLti78IcgNrm5SmcE8vssw1KjC
         rDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509242; x=1763114042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PdFrpCMgzVY+qjVrXkUkn7fFQNGJUHKXO+rmqKz+1v0=;
        b=oK5F/8oWZdV58NaRdrKqkziLWnPHjPwWMSv367v2GVFd8j6xM6zcwsivDMCvpOZBcU
         NRtNt9bOSoIR+gFv2dF2+M6J7wVO8dxEBrpceeEaR8Ja2YV3ae4Bg1h0d6DyQYHkuNZd
         MFoDvl5ey3IcsuWdOuHPGAoV0tbsaa97PbkYxxo1gUu2SDV747Hc60PvfqF19hwZ3oGH
         SObrrnmJtQeTIJoG+z3J9Pb8BPA7T6lCFzynJe1yZiDXSd1VRgunJhH9epddzBViwnDj
         Z4YxpMZqBn2Dcp21Po3dRD0+qMs0lJ9XE98x0tuIKo3lebS3PIRlUFOK6ovBtz3Qhkky
         GQTg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Lz/SM9LT9y4uoOMxZgPwGGLmgkmkydKHHRa1Zc3sEGzkwCnhFqR7mWLywoJ2bvBXEm0DNYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeZZZXnjuEAOhAYwnecyt7+a2QVM9ZmDpgmypAr+WqyRMehnb
	FFGL2v0pOQsfSbfr49RskD42EOjMjJZ6whdeQWM0Ws5/DBpmyRF7zV0kyA24EZpOgh9al72lXwv
	Ti+bgmzUicUnvVusqkR0ze69gFpLaZQs=
X-Gm-Gg: ASbGnct6jjyOLj8219hJZtvy8n2U6MuqBpTR1L9izh5NvDA3ygRNqw0LvfJJw3TWfHT
	GYRGrd5FZoD0kuum7J5h2JNAyJe2oGfdtYn1G00wjYIj+D4akCtn2l33eGCFpLuC31moRNXEYaO
	YVFIWEoLT16dqTiJCwsNWDZmPmKA8t/dLRkD68cm+xvBeB2jxX+C0IWobVmphY1R/FNuUfJ8Fj5
	azaFQb7IPtourt5Eo2AlHUf1X9f11Y4h7rNgdgowT8BHEm2wJTLEyelO/m0Ynwr1n9ZgXtA
X-Google-Smtp-Source: AGHT+IE11zhMAgi5cvIEZMVAHip/aU++LIjg8RLYkVfjpVQzr3BdfJWiu8X8UTY8why69UfvnlPjVZ1PmACNZK12Mhk=
X-Received: by 2002:a17:902:e847:b0:292:9ac7:2608 with SMTP id
 d9443c01a7336-297c94b32a9mr15262395ad.8.1762509242005; Fri, 07 Nov 2025
 01:54:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>
 <aQtubP3V6tUOaEl5@shredder> <CACueBy6LKYmusLjQPnQGCoSZQLEVAo5_X47B-gaH-2dSx6xDuw@mail.gmail.com>
In-Reply-To: <CACueBy6LKYmusLjQPnQGCoSZQLEVAo5_X47B-gaH-2dSx6xDuw@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Fri, 7 Nov 2025 17:53:51 +0800
X-Gm-Features: AWmQ_bnKgi56ZSPNSnKawG2OgOKGBH6FrWpo36dTSyLysdWpwJuxy5qm1OA073U
Message-ID: <CACueBy4EAuBoHDQPVSg_wdUYXYxQzToRx4Y+TSgcBwxEcODt_w@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
To: Ido Schimmel <idosch@idosch.org>
Cc: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Networking <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing the patch. I'm providing the detailed analysis
and debugging traces below to confirm the root cause and exact
location of the reference count leak.

1. Environment and Symptom

The issue was consistently reproduced when routing TCP traffic through
a Software IP Tunnel interface (sit0). The traffic flow  is:

  APP -> sit0 (IP tunnel) -> outside

This leads to a reference count leak that prevents the device from
being freed during unregistration, resulting in the kernel log
warning:

  unregister_netdevice: waiting for sit0 to become free. Usage count =3D N

2. Enable refcnt_tracer

Live-crash analysis identified a stale dst entry retaining a reference
to sit0. With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the allocation
stack for the leaked reference was identified:

[1279559.416854] leaked reference.
[1279559.416955]  dst_init+0x48/0x100
[1279559.416965]  dst_alloc+0x66/0xd0
[1279559.416966]  rt_dst_alloc+0x3c/0xd0
[1279559.416974]  ip_route_output_key_hash_rcu+0x1d7/0x940
[1279559.416978]  ip_route_output_key_hash+0x6d/0xa0
[1279559.416979]  ip_route_output_flow+0x1f/0x70
[1279559.416980]  __ip_queue_xmit+0x415/0x480
[1279559.416984]  ip_queue_xmit+0x15/0x20
[1279559.416986]  __tcp_transmit_skb+0xad4/0xc50

3. Pinpointing the Unmatched dst_hold()

To pinpoint the specific reference not released, we added tracepoints
to all dst_hold/put functions and used eBPF to record the full
lifecycle. The tracing identified a hold operation with the following
call stack:

do_trace_dst_entry_inc+0x45
rt_set_nexthop.constprop.0+0x376      /* <<<<<<<<<<<<<<<<<<<< HERE */
__mkroute_output+0x2B7
ip_route_output_key_hash_rcu+0xBD
ip_route_output_key_hash+0x6D
ip_route_output_flow+0x1F
inet_sk_rebuild_header+0x19C
__tcp_retransmit_skb+0x7E
tcp_retransmit_skb+0x19
tcp_retransmit_timer+0x3DF

The address rt_set_nexthop.constprop.0+0x376 corresponds to the
dst_hold() call inside rt_bind_exception().

4. Root Cause Analysis

The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
... -> update_or_create_fnhe(), which lead to fnhe_remove_oldest()
being called to delete entries exceeding the
FNHE_RECLAIM_DEPTH+random.

The race window is between fnhe_remove_oldest() selecting fnheX for
deletion and the subsequent kfree_rcu(). During this time, the
concurrent path's __mkroute_output() -> find_exception() can fetch the
soon-to-be-deleted fnheX, and rt_bind_exception() then binds it with a
new dst using a dst_hold(). When the original fnheX is freed via RCU,
the dst reference remains permanently leaked.

5. Fix Validation with eBPF

The patch mitigates this by zeroing fnhe_daddr before the
RCU-protected deletion steps. This prevents rt_bind_exception() from
attempting to reuse the entry.
The fix was validated by probing the rt_bind_exception path (which in
my environment is optimized to rt_set_nexthop.constprop.0) to catch
any zeroed but active FNHEs being processed:

bpftrace -e 'kprobe:rt_set_nexthop.constprop.0
{
    $rt =3D (struct rtable *)arg0;
    $fnhe =3D (struct fib_nh_exception *)arg3;
    $fi =3D (struct flowi *)arg4;

    /* Check for an FNHE that is marked for deletion (daddr =3D=3D 0)
     * but is still visible/valid (fnhe_expires !=3D 0 and not expired).
     */
    if ($fi !=3D 0 && $fnhe !=3D 0 && $fnhe->fnhe_daddr =3D=3D 0 &&
$fnhe->fnhe_expires !=3D 0 && $fnhe->fnhe_expires >=3D jiffies) {
        printf("rt: %llx, dev: %s, will leak before this patch\n",
$rt, $rt->dst.dev->name);
    }
}'



On Thu, Nov 6, 2025 at 8:31=E2=80=AFAM chuang <nashuiliang@gmail.com> wrote=
:
>
> Thanks, your analysis is excellent and makes perfect sense. I can
> briefly describe the issue.
>
> This problem took quite some time to analyze overall =E2=80=94 we enabled
> netdev refcnt, added dst tracepoints, and eventually captured a race
> condition between fnhe deletion and rt_bind_exception.
>
> In our environment, we use the sit driver(ip tunnel). During the xmit
> path, it records the PMTU for each destination, creating or updating
> fnhe entries (even when the MTU is already appropriate). Because there
> are many data flows, the sit driver updates PMTU very frequently,
> which leads to the race condition mentioned above.
>
> Sorry for the brief summary =E2=80=94 I=E2=80=99ll provide a more detaile=
d explanation
> later, along with the patch verification method.
>
> On Wed, Nov 5, 2025 at 23:34 Ido Schimmel <idosch@idosch.org> wrote:
> >
> > On Wed, Nov 05, 2025 at 06:26:22AM -0800, Eric Dumazet wrote:
> > > On Mon, Nov 3, 2025 at 7:09=E2=80=AFPM chuang <nashuiliang@gmail.com>=
 wrote:
> > > >
> > > > From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2=
001
> > > > From: Chuang Wang <nashuiliang@gmail.com>
> > > > Date: Tue, 4 Nov 2025 02:52:11 +0000
> > > > Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from =
rebinding
> > > >  stale fnhe
> > > >
> > > > A race condition exists between fnhe_remove_oldest() and
> > > > rt_bind_exception() where a fnhe that is scheduled for removal can =
be
> > > > rebound to a new dst.
> > > >
> > > > The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> > > > for deletion, but before it can be flushed and freed via RCU,
> > > > CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
> > > >
> > > > CPU 0                             CPU 1
> > > > __mkroute_output()
> > > >   find_exception() [fnheX]
> > > >                                   update_or_create_fnhe()
> > > >                                     fnhe_remove_oldest() [fnheX]
> > > >   rt_bind_exception() [bind dst]
> > > >                                   RCU callback [fnheX freed, dst le=
ak]
> > > >
> > > > If rt_bind_exception() successfully binds fnheX to a new dst, the
> > > > newly bound dst will never be properly freed because fnheX will
> > > > soon be released by the RCU callback, leading to a permanent
> > > > reference count leak on the old dst and the device.
> > > >
> > > > This issue manifests as a device reference count leak and a
> > > > warning in dmesg when unregistering the net device:
> > > >
> > > >   unregister_netdevice: waiting for ethX to become free. Usage coun=
t =3D N
> > > >
> > > > Fix this race by clearing 'oldest->fnhe_daddr' before calling
> > > > fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> > > > setting it to zero prevents the stale fnhe from being reused and
> > > > bound to a new dst just before it is freed.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> > >
> > > I do not see how this commit added the bug you are looking at ?
> >
> > Not the author, but my understanding is that the issue is that an
> > exception entry which is queued for deletion allows a dst entry to be
> > bound to it. As such, nobody will ever release the reference from the
> > dst entry and the associated net device.
> >
> > Before 67d6d681e15b, exception entries were only queued for deletion by
> > ip_del_fnhe() and it prevented dst entries from binding themselves to
> > the deleted exception entry by clearing 'fnhe->fnhe_daddr' which is
> > checked in rt_bind_exception(). See ee60ad219f5c7.
> >
> > 67d6d681e15b added another point in the code that queues exception
> > entries for deletion, but without clearing 'fnhe->fnhe_daddr' first.
> > Therefore, it added another instance of the bug that was fixed in
> > ee60ad219f5c7.
> >
> > >
> > > > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > > > ---
> > > >  net/ipv4/route.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > > > index 6d27d3610c1c..b549d6a57307 100644
> > > > --- a/net/ipv4/route.c
> > > > +++ b/net/ipv4/route.c
> > > > @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> > > > fnhe_hash_bucket *hash)
> > > >                         oldest_p =3D fnhe_p;
> > > >                 }
> > > >         }
> > > > +
> > > > +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> > > > +        * rebound with new dsts in rt_bind_exception().
> > > > +        */
> > > > +       oldest->fnhe_daddr =3D 0;
> > > >         fnhe_flush_routes(oldest);
> > > >         *oldest_p =3D oldest->fnhe_next;
> > > >         kfree_rcu(oldest, rcu);
> > > > --
> > >

