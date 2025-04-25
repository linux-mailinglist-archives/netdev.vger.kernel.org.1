Return-Path: <netdev+bounces-186083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C913FA9D07E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D60B3B0680
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE691F9EC0;
	Fri, 25 Apr 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tB/QzClQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DB188733
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605706; cv=none; b=WWLyQ2FQFgK7eePqqXDsLU9elLXOZYDhS/Tq8dsgFLIr3RdZXBJhqks1c3v7jGAlEsIPLWVS5XGYtMHyljBubxNJzCmkmQeqKtilk4R+V7t53odqiw5lt7oJjk0H1c0rHV3j9Zu78heCbbKwMThUMpLtJ5JBuyQNbh27ya2GlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605706; c=relaxed/simple;
	bh=2CRZi0Bgttu13h261W/4c3UfQqezXfeUlwk1ysujNHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XXGSrn1vciOIMbyLHL8QSfdeF+OlMcurqvRX82AezpCGq35WDIViMdXQ/Pmn/vL3Tdpmssg97OYIjZWGgK0jYXdEOm5JzYoqKXVLiR86OKARpMD3QSzLAm7UWPwMHbFdj67DhpuDMma76yyi46EWZNFKhmck8y8onVRLa3ifYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tB/QzClQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso18885ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745605704; x=1746210504; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOFhtCLVk8E6lFpkD1xx4I6juNA6D/qPGAI8Ymjo9bA=;
        b=tB/QzClQnnpmQAHoUu/n2JVpttiaRKGJZBqktsnODz8kxwOhxDEp89//+DhN9jwekW
         vuLW1ChLwW8T9ZYfWI62lf1D0ibftMybVd+vp9NiI+ZAgDoqDNWQiOHQU9d6nrru06G/
         Ryp9XxtMdufOOGFOPrT+n5RwCpiRh5m7zbkqY+C5OJhRnTfzdYLQDwrAG8t2VIGii6xG
         9XzxhlduILTQtkqEd1XPiSjDHeZnuX1/BijV6uUe8dPsFjHfsPf3akUgelqdiPdAmEXp
         Uev2Y7ieooki1Zyy2hcucSDbR4B3U1+qqlRqk/a7B8K1Vukubw0isYAsDEhDnoQK8Ocg
         839w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745605704; x=1746210504;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOFhtCLVk8E6lFpkD1xx4I6juNA6D/qPGAI8Ymjo9bA=;
        b=stB/MZ4uv/i11Mb9aiHOQrtgmEqKUAZ8mimErwaknuyaIlSouGZIXtJFrNstLkiO/K
         gNhyRBNxOSmIXUR90JfJqAFBWvgOygPfB2nesolWGnjM0lLcVht3Zl2kQbQz7gjBUTzc
         P11Sy9P4WjVtCmPhW7ufHPIjTSyN4spurNfmXyeQhkdE3SKyYxjzKplGCj3yKfx5dsyH
         gX2lCY4jqt/fkhQ51Dx2O6NkzHfatz7pu53quUD+6+jwufLGRmCcjlzFOo+u8bTEShog
         vRNVzLTdzYClQcYN4M7NYeFXwoL0rKtx2b9n6NW5Yuhb/FTh3n0u/dSGL++EcRGS8EUw
         gBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkCmEDKFhR9CoZf//Ydv9KH5+Djj6MWfmoy+scYSfv20WSTmCRas/B7g5GMlT0nglsJ5ZqpB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYzC2XkXkETX7IRlxjXuWfoqyqeUcHdKU06cmuP+lIPlcuwdU
	x5RfVhu1dnvuRvN0i0bBKrjZUVOqbOSo6ShF1xYw5+hd84xJwfFtZl/0bd8KyIKKmjBaMnj0aGu
	p9E+vuHG7A/I+VMtVHf/635h8cdcXQhAHZw58
X-Gm-Gg: ASbGnctOYqUHZf+elNQnldkSKQopJa79eOL/r+hkMcV0+174tRF7HfUgyzdOr6KTjjK
	gHDSy4cjBZX4vc20QpBPBKTr0gdV5cJ9Zj9vYId4j1afwnnX+BGyHEJlDLZ6vNdfEGMM5OBSy8Q
	Ak9tsEgOT53n+tkW+WmCFgo1SmB/gxkICQLoRvFU9wlr59Dm9TlXc5aRQG7TPHKrdOYw==
X-Google-Smtp-Source: AGHT+IF2O0e5HW8qluUcu4u1ASMgXarIV2mgyGeISQkLf0qGhsElYb9oEmrsfwBmTAzy9o9GxUyLSEVDZGJcd8PJWqg=
X-Received: by 2002:a17:903:194b:b0:21f:465d:c588 with SMTP id
 d9443c01a7336-22dc7591695mr179185ad.14.1745605703573; Fri, 25 Apr 2025
 11:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423201413.1564527-1-skhawaja@google.com> <aArFm-TS3Ac0FOic@LQ3V64L9R2>
In-Reply-To: <aArFm-TS3Ac0FOic@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 25 Apr 2025 11:28:11 -0700
X-Gm-Features: ATxdqUGChKC_WkZdMPXU1X91_gF0nOzgBll2fnXmGkNFkI9az3rP8bGQibabNGg
Message-ID: <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:13=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Wed, Apr 23, 2025 at 08:14:13PM +0000, Samiullah Khawaja wrote:
> > A net device has a threaded sysctl that can be used to enable threaded
> > napi polling on all of the NAPI contexts under that device. Allow
> > enabling threaded napi polling at individual napi level using netlink.
> >
> > Extend the netlink operation `napi-set` and allow setting the threaded
> > attribute of a NAPI. This will enable the threaded polling on a napi
> > context.
> >
> > Add a test in `nl_netdev.py` that verifies various cases of threaded
> > napi being set at napi and at device level.
> >
> > Tested
> >  ./tools/testing/selftests/net/nl_netdev.py
> >  TAP version 13
> >  1..6
> >  ok 1 nl_netdev.empty_check
> >  ok 2 nl_netdev.lo_check
> >  ok 3 nl_netdev.page_pool_check
> >  ok 4 nl_netdev.napi_list_check
> >  ok 5 nl_netdev.napi_set_threaded
> >  ok 6 nl_netdev.nsim_rxq_reset_down
> >  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > v5:
> >  - This patch was part of:
> >  https://lore.kernel.org/netdev/Z92e2kCYXQ_RsrJh@LQ3V64L9R2/T/
> >  It is being sent separately for the first time.
>
> Thanks; I think this is a good change on its own separate from the
> rest of the series and, IMO, I think it makes it easier to get
> reviewed and merged.
Thanks for the review and suggestion to split this out.
>
> Probably a matter of personal preference, which you can feel free to
> ignore, but IMO I think splitting this into 3 patches might make it
> easier to get Reviewed-bys and make changes ?
>
>   - core infrastructure changes
>   - netlink related changes (and docs)
>   - selftest
>
> Then if feedback comes in for some parts, but not others, it makes
> it easier for reviewers in the future to know what was already
> reviewed and what was changed ?
>
> Just my 2 cents.
>
> The above said, my high level feedback is that I don't think this
> addresses the concerns we discussed in the v4 about device-wide
> setting vs per-NAPI settings.
>
> See below.
>
> [...]
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index d0563ddff6ca..ea3c8a30bb97 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6888,6 +6888,27 @@ static enum hrtimer_restart napi_watchdog(struct=
 hrtimer *timer)
> >       return HRTIMER_NORESTART;
> >  }
> >
> > +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> > +{
> > +     if (threaded) {
> > +             if (!napi->thread) {
> > +                     int err =3D napi_kthread_create(napi);
> > +
> > +                     if (err)
> > +                             return err;
> > +             }
> > +     }
> > +
> > +     if (napi->config)
> > +             napi->config->threaded =3D threaded;
> > +
> > +     /* Make sure kthread is created before THREADED bit is set. */
> > +     smp_mb__before_atomic();
> > +     assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> > +
> > +     return 0;
> > +}
>
> Hm, I wonder if dev_set_threaded can be cleaned up to use this
> instead of repeating similar code in two places?
>
> > +
> >  int dev_set_threaded(struct net_device *dev, bool threaded)
> >  {
> >       struct napi_struct *napi;
> > @@ -7144,6 +7165,8 @@ static void napi_restore_config(struct napi_struc=
t *n)
> >               napi_hash_add(n);
> >               n->config->napi_id =3D n->napi_id;
> >       }
> > +
> > +     napi_set_threaded(n, n->config->threaded);
>
> It makes sense to me that when restoring the config, the kthread is
> kicked off again (assuming config->thread > 0), but does the
> napi_save_config path need to stop the thread?

>
> Not sure if kthread_stop is hit via some other path when
> napi_disable is called? Can you clarify?
NAPI kthread are not stopped when napi is disabled. When napis are
disabled, the NAPI_STATE_DISABLED state is set on them and the
associated thread goes to sleep after unsetting the STATE_SCHED. The
kthread_stop is only called on them when NAPI is deleted. This is the
existing behaviour. Please see napi_disable implementation for
reference. Also napi_enable doesn't create a new kthread and just sets
the napi STATE appropriately and once the NAPI is scheduled again the
thread is woken up. Please seem implementation of napi_schedule for
reference.
>
> From my testing, it seems like setting threaded: 0 using the CLI
> leaves the thread running. Should it work that way? From a high
> level that behavior seems somewhat unexpected, don't you think?
Please see the comment above. The thread goes to sleep and is woken up
when NAPI is enabled and scheduled again.
>
> [...]
>
> >  static void napi_save_config(struct napi_struct *n)
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index b64c614a00c4..f7d000a600cf 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -184,6 +184,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struc=
t napi_struct *napi,
> >       if (napi->irq >=3D 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi-=
>irq))
> >               goto nla_put_failure;
> >
> > +     if (nla_put_uint(rsp, NETDEV_A_NAPI_THREADED,
> > +                      napi_get_threaded(napi)))
> > +             goto nla_put_failure;
> > +
> >       if (napi->thread) {
> >               pid =3D task_pid_nr(napi->thread);
> >               if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
> > @@ -322,8 +326,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi=
, struct genl_info *info)
> >  {
> >       u64 irq_suspend_timeout =3D 0;
> >       u64 gro_flush_timeout =3D 0;
> > +     uint threaded =3D 0;
>
> I think I'd probably make this a u8 or something? uint is not a
> commonly used type, AFAICT, and seems out of place here.
Agreed. Will change
>
> > diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/s=
elftests/net/nl_netdev.py
> > index beaee5e4e2aa..505564818fa8 100755
> > --- a/tools/testing/selftests/net/nl_netdev.py
> > +++ b/tools/testing/selftests/net/nl_netdev.py
> > @@ -2,6 +2,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  import time
> > +from os import system
> >  from lib.py import ksft_run, ksft_exit, ksft_pr
> >  from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
> >  from lib.py import NetdevFamily, NetdevSimDev, ip
> > @@ -34,6 +35,70 @@ def napi_list_check(nf) -> None:
> >                  ksft_eq(len(napis), 100,
> >                          comment=3Df"queue count after reset queue {q} =
mode {i}")
> >
> > +def napi_set_threaded(nf) -> None:
> > +    """
> > +    Test that verifies various cases of napi threaded
> > +    set and unset at napi and device level.
> > +    """
> > +    with NetdevSimDev(queue_count=3D2) as nsimdev:
> > +        nsim =3D nsimdev.nsims[0]
> > +
> > +        ip(f"link set dev {nsim.ifname} up")
> > +
> > +        napis =3D nf.napi_get({'ifindex': nsim.ifindex}, dump=3DTrue)
> > +        ksft_eq(len(napis), 2)
> > +
> > +        napi0_id =3D napis[0]['id']
> > +        napi1_id =3D napis[1]['id']
> > +
> > +        # set napi threaded and verify
> > +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 1)
> > +
> > +        ip(f"link set dev {nsim.ifname} down")
> > +        ip(f"link set dev {nsim.ifname} up")
> > +
> > +        # verify if napi threaded is still set
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 1)
>
> I feel like the test needs to be expanded?
>
> It's not just the attribute that matters (although that bit is
> important), but I think it probably is important that the kthread is
> still running and that should be checked ?
>
> > +        # unset napi threaded and verify
> > +        nf.napi_set({'id': napi0_id, 'threaded': 0})
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 0)
> > +
> > +        # set napi threaded for napi0
> > +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 1)
> > +
> > +        # check it is not set for napi1
> > +        napi1 =3D nf.napi_get({'id': napi1_id})
> > +        ksft_eq(napi1['threaded'], 0)
> > +
> > +        # set threaded at device level
> > +        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
> > +
> > +        # check napi threaded is set for both napis
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 1)
> > +        napi1 =3D nf.napi_get({'id': napi1_id})
> > +        ksft_eq(napi1['threaded'], 1)
> > +
> > +        # set napi threaded for napi0
> > +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 1)
>
> If napi0 is already set to threaded in the previous block for the
> device level, why set it explicitly again ?
Will remove
>
> > +
> > +        # unset threaded at device level
> > +        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
> > +
> > +        # check napi threaded is unset for both napis
> > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > +        ksft_eq(napi0['threaded'], 0)
> > +        napi1 =3D nf.napi_get({'id': napi1_id})
> > +        ksft_eq(napi1['threaded'], 0)
>
> I ran the test and it passes for me.
>
> That said, the test is incomplete or buggy because I've manually
> identified 1 case that is incorrect which we discussed in the v4 and
> a second case that seems buggy from a user perspective.
>
> Case 1 (we discussed this in the v4, but seems like it was missed
> here?):
>
> Threaded set to 1 and then to 0 at the device level
>
>   echo 1 > /sys/class/net/eni28160np1/threaded
>   echo 0 > /sys/class/net/eni28160np1/threaded
>
> Check the setting:
>
>   cat /sys/class/net/eni28160np1/threaded
>   0
>
> Dump the settings for netdevsim, noting that threaded is 0, but pid
> is set (again, should it be?):
>
>   ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump napi-get --json=3D'{"ifindex": 20}'
>
>   [{'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 612,
>     'ifindex': 20,
>     'irq-suspend-timeout': 0,
>     'pid': 15728,
>     'threaded': 0},
>    {'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 611,
>     'ifindex': 20,
>     'irq-suspend-timeout': 0,
>     'pid': 15729,
>     'threaded': 0}]
As explained in the comment earlier, since the kthread is still valid
and associated with the napi, the PID is valid. I just verified that
this is the existing behaviour. Not sure whether the pid should be
hidden if the threaded state is not enabled? Do you think we should
change this behaviour?
>
> Now set NAPI 612 to threaded 1:
>
>   ./tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/netdev.yaml \
>       --do napi-set --json=3D'{"id": 612, "threaded": 1}'
>
> Dump the settings:
>
>   ./tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/netdev.yaml \
>       --dump napi-get --json=3D'{"ifindex": 20}'
>
>   [{'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 612,
>     'ifindex': 20,
>     'irq-suspend-timeout': 0,
>     'pid': 15728,
>     'threaded': 1},
>    {'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 611,
>     'ifindex': 20,
>     'irq-suspend-timeout': 0,
>     'pid': 15729,
>     'threaded': 0}]
>
> So far, so good.
>
> Now set device-wide threaded to 0, which should set NAPI 612 to threaded =
0:
>
>    echo 0 > /sys/class/net/eni28160np1/threaded
>
> Dump settings:
>
>   ./tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/netdev.yaml \
>      --dump napi-get --json=3D'{"ifindex": 20}'
>
>   [{'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 612,
>     'ifindex': 20,
>     'irq-suspend-timeout': 0,
>     'pid': 15728,
>     'threaded': 1},
>    {'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 611,
>     'ifindex': 20,
>     'irq-suspend-timeout': 0,
>     'pid': 15729,
>     'threaded': 0}]
>
> Note that NAPI 612 is still set to threaded 1, but we set the
> device-wide setting to 0.
>
> Shouldn't NAPI 612 be threaded =3D 0 ?
Yes it should be. I will add a test for this and also remove the
initial check in dev_set_threaded to fix this behaviour.
>
> Second case:
>   - netdevsim is brought up with 2 queues and 2 napis
>   - Threaded NAPI is enabled for napi1
>   - The queue count on the device is reduced from 2 to 1 (therefore
>     napi1 is disabled) via ethtool -L
>
> Then:
>
>   - Is the thread still active? Should it be?
>
> IMO: if the napi is disabled the thread should stop because there is
> no NAPI for it to poll. When the napi is enabled, the thread can
> start back up.
Please see the comment above for the explanation of this., but to
reiterate the thread is there but not actively being scheduled and
sleeps until napi is enabled again and scheduled.
>
> It does not seem that this is currently the case from manual
> testing.

