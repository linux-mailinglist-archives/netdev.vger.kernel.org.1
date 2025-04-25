Return-Path: <netdev+bounces-186178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3EEA9D603
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4BA4E08E5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24675296D04;
	Fri, 25 Apr 2025 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wiQ4POvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E64227BAD
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622403; cv=none; b=H4+Pqg5gGTnCG7BUpkEiePK3uyWwCj9KK5KhpXZ9ndEnjFQESE8bxS82VqTk0O0L3R3I4HMPnrgssKRRA514DkKiT8fTk8hhWrKgFW5W9+yddaHwN9Si7tkTCwDsiUTGDffYSs1XvFs5JR7ZuIx5ftIvLvjRodAngLR3LIh1+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622403; c=relaxed/simple;
	bh=ZUKkLKCXhXfgDna82a+57JSTo2CVthNmlqQBnfyBOoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IiE4YqIJOW/dGDsPoFkGHRriGGZD4063aiL0W6MVRI55RwqtA67LkbBaCK8bcCtjHP4LQ0fYBIVN6gBaacWK+Hv3FMr/c3JHO+oV4PMQdn371gzRJyD/LUz4w2cVnxlR+3ncpVlc7WvP/HK5gN82o0p9Mr2bbZ/2rGg2YJaN7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wiQ4POvH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2263428c8baso30005ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745622400; x=1746227200; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9gipAAfs9GY7Tv4uQfRu/7FOB2yG/UOWXBubUtQDmI=;
        b=wiQ4POvHnprBEpfDwsDeLZe7v3t2/OkcZXoaEGsEqEjEm+BFLMEazEdqSEyAbWLHuu
         V9bVwB/CVI60tUWcpYZDWoyBcSjQcxkTYPQ6IIl3PRHXqQkB1c0Saw4l7upblyypilDA
         RVHs/DZNjHmMOXLAPDjAyrTbVNMevV/uzlH9yASDcYZnLL6zeAxQwzWA8SFYgqB+ktCx
         0yA+THOHp66NCwcHBDyQe+SaOOM9xPbPk8mmrVsZUbbfLAwow7/tOxqmNPITfx9ZZOWZ
         Pv1Hq6+Ied8QyoW9txnmNflbdH/Owyi9lIvuXCpMXl5qz/U0j2U5t0IIKEb05xMVPc0P
         IeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745622400; x=1746227200;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/9gipAAfs9GY7Tv4uQfRu/7FOB2yG/UOWXBubUtQDmI=;
        b=hUILxwLKg2y97aC+zT/TtQ2rz6jGus3AnZOg97/XXBc5LPn385mvGDUIA+q3SU0wzc
         crJiDU3fD8g9WF1FQ3LyXuVYzed3+UkJWJGX6jmeiLS8tshklCVcL80VFZ9t2FV74K3G
         f0Y9zhg1L/BQC1ROEmBYNwyqRT7u6hmxcklkNcr2r2eDZic71lYWN+uzfd3ZRY+qEcHD
         Lil+qZRHcTudbX21v7WJGQ614obt6YRIPqA5E4turSt2AAis2Nk+tOtA2IXwpZXBaozO
         oIQl402IZ5PXCOcO1nWApHlI9AXnX7dYxSnw8l1hpZ78WHt4CCashSe8QnkW2X68tpEx
         3z6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIRHdUHymxtjcka137fHrMDfqOkZxrXxS6aoZwIe2KvKczgbAaa2UPxoNx1zOHM9OSpvFiFws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjqhzP5WeEsyO/p7W+Q26AAfXaIwJZ7+84ObupcOujRJ1dg1Y
	0inCdQLVQ+M+OgsqOfIuDzvjonwSxA/f38tQbMsZJsuuFporDxyfT35FgErB0NAXM5fxIlvQSn6
	HyQXTTKJGMnTV4vWJgY0fGYewDKyrSscYLLf/
X-Gm-Gg: ASbGncuAHV7q38Jlvl/Zn77QFGqdRKk+apDreHbOTw77B5XlD7oryZt2hol0Gu2o58m
	s09EnqnEqFQyFlEuS2ZN35lRNe4V/XuOTC/iGxu7PaVEtz1aQLHH7GLb1qZqLlWEFsehpNNOMs+
	4GTnRcJnu/e7gwpPUiD+gcMlphw3X6rW95L2jxpmYG2JgjRz62DZcT/Fo=
X-Google-Smtp-Source: AGHT+IHtLVbK1BbM78sk1sIeTYL7fDTDJLLo7K8hycADfZ8N7TuTDhDVPGwpa9KONl84HTHiTp4C2PlIgXQrec+RWWs=
X-Received: by 2002:a17:902:f545:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-22dc903f562mr447135ad.3.1745622399871; Fri, 25 Apr 2025
 16:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423201413.1564527-1-skhawaja@google.com> <aArFm-TS3Ac0FOic@LQ3V64L9R2>
 <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
In-Reply-To: <CAAywjhQhH5ctp_PSgDuw4aTQNKY8V5vbzk9pYd1UBXtDV4LFMA@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 25 Apr 2025 16:06:27 -0700
X-Gm-Features: ATxdqUFrSGmk8RQoq3JqBXeCpAtxQ88LPLZNHS9_ixq9rKPzn-8Wf5w1o10Zbv8
Message-ID: <CAAywjhT7R9F+i7ANVy5n=4iTBYWOpS8VtUUgQdW1xEeS+8afyw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:28=E2=80=AFAM Samiullah Khawaja <skhawaja@google=
.com> wrote:
>
> On Thu, Apr 24, 2025 at 4:13=E2=80=AFPM Joe Damato <jdamato@fastly.com> w=
rote:
> >
> > On Wed, Apr 23, 2025 at 08:14:13PM +0000, Samiullah Khawaja wrote:
> > > A net device has a threaded sysctl that can be used to enable threade=
d
> > > napi polling on all of the NAPI contexts under that device. Allow
> > > enabling threaded napi polling at individual napi level using netlink=
.
> > >
> > > Extend the netlink operation `napi-set` and allow setting the threade=
d
> > > attribute of a NAPI. This will enable the threaded polling on a napi
> > > context.
> > >
> > > Add a test in `nl_netdev.py` that verifies various cases of threaded
> > > napi being set at napi and at device level.
> > >
> > > Tested
> > >  ./tools/testing/selftests/net/nl_netdev.py
> > >  TAP version 13
> > >  1..6
> > >  ok 1 nl_netdev.empty_check
> > >  ok 2 nl_netdev.lo_check
> > >  ok 3 nl_netdev.page_pool_check
> > >  ok 4 nl_netdev.napi_list_check
> > >  ok 5 nl_netdev.napi_set_threaded
> > >  ok 6 nl_netdev.nsim_rxq_reset_down
> > >  # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> > >
> > > v5:
> > >  - This patch was part of:
> > >  https://lore.kernel.org/netdev/Z92e2kCYXQ_RsrJh@LQ3V64L9R2/T/
> > >  It is being sent separately for the first time.
> >
> > Thanks; I think this is a good change on its own separate from the
> > rest of the series and, IMO, I think it makes it easier to get
> > reviewed and merged.
> Thanks for the review and suggestion to split this out.
> >
> > Probably a matter of personal preference, which you can feel free to
> > ignore, but IMO I think splitting this into 3 patches might make it
> > easier to get Reviewed-bys and make changes ?
> >
> >   - core infrastructure changes
> >   - netlink related changes (and docs)
> >   - selftest
> >
> > Then if feedback comes in for some parts, but not others, it makes
> > it easier for reviewers in the future to know what was already
> > reviewed and what was changed ?
> >
> > Just my 2 cents.
> >
> > The above said, my high level feedback is that I don't think this
> > addresses the concerns we discussed in the v4 about device-wide
> > setting vs per-NAPI settings.
> >
> > See below.
> >
> > [...]
> >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index d0563ddff6ca..ea3c8a30bb97 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6888,6 +6888,27 @@ static enum hrtimer_restart napi_watchdog(stru=
ct hrtimer *timer)
> > >       return HRTIMER_NORESTART;
> > >  }
> > >
> > > +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> > > +{
> > > +     if (threaded) {
> > > +             if (!napi->thread) {
> > > +                     int err =3D napi_kthread_create(napi);
> > > +
> > > +                     if (err)
> > > +                             return err;
> > > +             }
> > > +     }
> > > +
> > > +     if (napi->config)
> > > +             napi->config->threaded =3D threaded;
> > > +
> > > +     /* Make sure kthread is created before THREADED bit is set. */
> > > +     smp_mb__before_atomic();
> > > +     assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
> > > +
> > > +     return 0;
> > > +}
> >
> > Hm, I wonder if dev_set_threaded can be cleaned up to use this
> > instead of repeating similar code in two places?
I wanted to add something about this part and forgot. The reason
dev_set_thread handling is a little different from individual NAPIs is
because the dev->threaded state on a device needs to be set only if
all underlying NAPIs are guaranteed to have the same state. So that is
why the dev_set_threaded does this in 3 steps,

1- Create kthread for each NAPI. This can fail and if it fails the
threaded state is set to disable/0 since at least one NAPI kthread
failed to create.
2- Set the threaded state on dev->threaded.
3- Set the threaded state flag on each NAPI, this cannot fail.

If we use the napi_set_threaded in dev_set_threaded implementation
then we will be doing something like following,

1- Do napi_set_threaded for each NAPI.
2- If a NAPI fails then revert to disable state and reset NAPI state
to disable for all NAPIs in dev
3- set threaded state on dev->threaded (or maybe set in the start and
set here again on failure).

I think this will complicate the logic and also not preserve the
current behaviour and order of operations. So keeping the
dev_set_threaded implementation separate.
> >
> > > +
> > >  int dev_set_threaded(struct net_device *dev, bool threaded)
> > >  {
> > >       struct napi_struct *napi;
> > > @@ -7144,6 +7165,8 @@ static void napi_restore_config(struct napi_str=
uct *n)
> > >               napi_hash_add(n);
> > >               n->config->napi_id =3D n->napi_id;
> > >       }
> > > +
> > > +     napi_set_threaded(n, n->config->threaded);
> >
> > It makes sense to me that when restoring the config, the kthread is
> > kicked off again (assuming config->thread > 0), but does the
> > napi_save_config path need to stop the thread?
>
> >
> > Not sure if kthread_stop is hit via some other path when
> > napi_disable is called? Can you clarify?
> NAPI kthread are not stopped when napi is disabled. When napis are
> disabled, the NAPI_STATE_DISABLED state is set on them and the
> associated thread goes to sleep after unsetting the STATE_SCHED. The
> kthread_stop is only called on them when NAPI is deleted. This is the
> existing behaviour. Please see napi_disable implementation for
> reference. Also napi_enable doesn't create a new kthread and just sets
> the napi STATE appropriately and once the NAPI is scheduled again the
> thread is woken up. Please seem implementation of napi_schedule for
> reference.
> >
> > From my testing, it seems like setting threaded: 0 using the CLI
> > leaves the thread running. Should it work that way? From a high
> > level that behavior seems somewhat unexpected, don't you think?
> Please see the comment above. The thread goes to sleep and is woken up
> when NAPI is enabled and scheduled again.
> >
> > [...]
> >
> > >  static void napi_save_config(struct napi_struct *n)
> > > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > > index b64c614a00c4..f7d000a600cf 100644
> > > --- a/net/core/netdev-genl.c
> > > +++ b/net/core/netdev-genl.c
> > > @@ -184,6 +184,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, str=
uct napi_struct *napi,
> > >       if (napi->irq >=3D 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, nap=
i->irq))
> > >               goto nla_put_failure;
> > >
> > > +     if (nla_put_uint(rsp, NETDEV_A_NAPI_THREADED,
> > > +                      napi_get_threaded(napi)))
> > > +             goto nla_put_failure;
> > > +
> > >       if (napi->thread) {
> > >               pid =3D task_pid_nr(napi->thread);
> > >               if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
> > > @@ -322,8 +326,14 @@ netdev_nl_napi_set_config(struct napi_struct *na=
pi, struct genl_info *info)
> > >  {
> > >       u64 irq_suspend_timeout =3D 0;
> > >       u64 gro_flush_timeout =3D 0;
> > > +     uint threaded =3D 0;
> >
> > I think I'd probably make this a u8 or something? uint is not a
> > commonly used type, AFAICT, and seems out of place here.
> Agreed. Will change
> >
> > > diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing=
/selftests/net/nl_netdev.py
> > > index beaee5e4e2aa..505564818fa8 100755
> > > --- a/tools/testing/selftests/net/nl_netdev.py
> > > +++ b/tools/testing/selftests/net/nl_netdev.py
> > > @@ -2,6 +2,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >
> > >  import time
> > > +from os import system
> > >  from lib.py import ksft_run, ksft_exit, ksft_pr
> > >  from lib.py import ksft_eq, ksft_ge, ksft_busy_wait
> > >  from lib.py import NetdevFamily, NetdevSimDev, ip
> > > @@ -34,6 +35,70 @@ def napi_list_check(nf) -> None:
> > >                  ksft_eq(len(napis), 100,
> > >                          comment=3Df"queue count after reset queue {q=
} mode {i}")
> > >
> > > +def napi_set_threaded(nf) -> None:
> > > +    """
> > > +    Test that verifies various cases of napi threaded
> > > +    set and unset at napi and device level.
> > > +    """
> > > +    with NetdevSimDev(queue_count=3D2) as nsimdev:
> > > +        nsim =3D nsimdev.nsims[0]
> > > +
> > > +        ip(f"link set dev {nsim.ifname} up")
> > > +
> > > +        napis =3D nf.napi_get({'ifindex': nsim.ifindex}, dump=3DTrue=
)
> > > +        ksft_eq(len(napis), 2)
> > > +
> > > +        napi0_id =3D napis[0]['id']
> > > +        napi1_id =3D napis[1]['id']
> > > +
> > > +        # set napi threaded and verify
> > > +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 1)
> > > +
> > > +        ip(f"link set dev {nsim.ifname} down")
> > > +        ip(f"link set dev {nsim.ifname} up")
> > > +
> > > +        # verify if napi threaded is still set
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 1)
> >
> > I feel like the test needs to be expanded?
> >
> > It's not just the attribute that matters (although that bit is
> > important), but I think it probably is important that the kthread is
> > still running and that should be checked ?
> >
> > > +        # unset napi threaded and verify
> > > +        nf.napi_set({'id': napi0_id, 'threaded': 0})
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 0)
> > > +
> > > +        # set napi threaded for napi0
> > > +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 1)
> > > +
> > > +        # check it is not set for napi1
> > > +        napi1 =3D nf.napi_get({'id': napi1_id})
> > > +        ksft_eq(napi1['threaded'], 0)
> > > +
> > > +        # set threaded at device level
> > > +        system(f"echo 1 > /sys/class/net/{nsim.ifname}/threaded")
> > > +
> > > +        # check napi threaded is set for both napis
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 1)
> > > +        napi1 =3D nf.napi_get({'id': napi1_id})
> > > +        ksft_eq(napi1['threaded'], 1)
> > > +
> > > +        # set napi threaded for napi0
> > > +        nf.napi_set({'id': napi0_id, 'threaded': 1})
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 1)
> >
> > If napi0 is already set to threaded in the previous block for the
> > device level, why set it explicitly again ?
> Will remove
> >
> > > +
> > > +        # unset threaded at device level
> > > +        system(f"echo 0 > /sys/class/net/{nsim.ifname}/threaded")
> > > +
> > > +        # check napi threaded is unset for both napis
> > > +        napi0 =3D nf.napi_get({'id': napi0_id})
> > > +        ksft_eq(napi0['threaded'], 0)
> > > +        napi1 =3D nf.napi_get({'id': napi1_id})
> > > +        ksft_eq(napi1['threaded'], 0)
> >
> > I ran the test and it passes for me.
> >
> > That said, the test is incomplete or buggy because I've manually
> > identified 1 case that is incorrect which we discussed in the v4 and
> > a second case that seems buggy from a user perspective.
> >
> > Case 1 (we discussed this in the v4, but seems like it was missed
> > here?):
> >
> > Threaded set to 1 and then to 0 at the device level
> >
> >   echo 1 > /sys/class/net/eni28160np1/threaded
> >   echo 0 > /sys/class/net/eni28160np1/threaded
> >
> > Check the setting:
> >
> >   cat /sys/class/net/eni28160np1/threaded
> >   0
> >
> > Dump the settings for netdevsim, noting that threaded is 0, but pid
> > is set (again, should it be?):
> >
> >   ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump napi-get --json=3D'{"ifindex": 20}'
> >
> >   [{'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 612,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15728,
> >     'threaded': 0},
> >    {'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 611,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15729,
> >     'threaded': 0}]
> As explained in the comment earlier, since the kthread is still valid
> and associated with the napi, the PID is valid. I just verified that
> this is the existing behaviour. Not sure whether the pid should be
> hidden if the threaded state is not enabled? Do you think we should
> change this behaviour?
> >
> > Now set NAPI 612 to threaded 1:
> >
> >   ./tools/net/ynl/pyynl/cli.py \
> >       --spec Documentation/netlink/specs/netdev.yaml \
> >       --do napi-set --json=3D'{"id": 612, "threaded": 1}'
> >
> > Dump the settings:
> >
> >   ./tools/net/ynl/pyynl/cli.py \
> >       --spec Documentation/netlink/specs/netdev.yaml \
> >       --dump napi-get --json=3D'{"ifindex": 20}'
> >
> >   [{'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 612,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15728,
> >     'threaded': 1},
> >    {'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 611,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15729,
> >     'threaded': 0}]
> >
> > So far, so good.
> >
> > Now set device-wide threaded to 0, which should set NAPI 612 to threade=
d 0:
> >
> >    echo 0 > /sys/class/net/eni28160np1/threaded
> >
> > Dump settings:
> >
> >   ./tools/net/ynl/pyynl/cli.py \
> >      --spec Documentation/netlink/specs/netdev.yaml \
> >      --dump napi-get --json=3D'{"ifindex": 20}'
> >
> >   [{'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 612,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15728,
> >     'threaded': 1},
> >    {'defer-hard-irqs': 0,
> >     'gro-flush-timeout': 0,
> >     'id': 611,
> >     'ifindex': 20,
> >     'irq-suspend-timeout': 0,
> >     'pid': 15729,
> >     'threaded': 0}]
> >
> > Note that NAPI 612 is still set to threaded 1, but we set the
> > device-wide setting to 0.
> >
> > Shouldn't NAPI 612 be threaded =3D 0 ?
> Yes it should be. I will add a test for this and also remove the
> initial check in dev_set_threaded to fix this behaviour.
> >
> > Second case:
> >   - netdevsim is brought up with 2 queues and 2 napis
> >   - Threaded NAPI is enabled for napi1
> >   - The queue count on the device is reduced from 2 to 1 (therefore
> >     napi1 is disabled) via ethtool -L
> >
> > Then:
> >
> >   - Is the thread still active? Should it be?
> >
> > IMO: if the napi is disabled the thread should stop because there is
> > no NAPI for it to poll. When the napi is enabled, the thread can
> > start back up.
> Please see the comment above for the explanation of this., but to
> reiterate the thread is there but not actively being scheduled and
> sleeps until napi is enabled again and scheduled.
> >
> > It does not seem that this is currently the case from manual
> > testing.

