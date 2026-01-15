Return-Path: <netdev+bounces-250308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BAD2850D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B4C3301580C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8A320A1A;
	Thu, 15 Jan 2026 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ui25LDwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A12E718B
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507647; cv=none; b=emVboRC3/eONaRKaEYJzcZXNKWjkgqANxYR8+7dgnycraFQLzQEN6iz6ZSoUcjJrdkpl7I5FJ5KOUlDDjt4sFx55H8jle8T1Ek85ImJNoOupnHSBOhACq2Wj2K5w0vIcOs40LLL2Ov3wb+XYiwyADdpscI8LemSvHXXBQmuvOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507647; c=relaxed/simple;
	bh=h362ZLNQ/V5cylHTaii2Vq+S8eYkAHAP0sGwHCqEgJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjskHFDi1xBit+9xzv+PPtFMgmZTgq/IqDupk1Isqo4+qwFUc6TppV+gOSMnUbaAV4ER7uK/q1zJ6OUPNtJAgTNwQgLG0daGlzRmbingKuZu8thvSWyN7H1sAqNtEWEHNTsH6Gz6RQBJRjgzMCrQUlIjL4uBrZQi/hgVdbOw7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ui25LDwZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7939e7b648aso13759597b3.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768507644; x=1769112444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH1AMS4mgK+dyZF1tXid8a0is6o7PbaqjSCpA17U3aI=;
        b=ui25LDwZ1Za78CNHxFUqzoA8ByC2wSIdNpS7Bn534VwDm+EFG0Ur38DBZXCybSTfbL
         12tWdwppB2gVONpnkCkTN+BrPGWdwptQjYyh1nwFBaY907YQAyv5ocAVgWO//cs0vdAp
         V9NlboyL0hViXoNX9SE2z6gDFLNCzieCicJZE4N5x+R3KO/U64fFzpvbURWvv0gQ2kiu
         iNDzEMPnA8v5AzYnmwu8qsllrZfsVqoVEgqF1YvRV5NdCikzE1TbhJDg52PahWpcwyq1
         4Y5ESflXt0ui0NTqvd7gzC1BOXnmF3B+q77Yvxf7Gz9WxrxM9OJCm10yTW/tsVoAfd/1
         6vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768507644; x=1769112444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AH1AMS4mgK+dyZF1tXid8a0is6o7PbaqjSCpA17U3aI=;
        b=oHtkmKS2VJFmRp+Hi+Q6wReDUTEvjLJjF43LlFh8zHTbpIUhdVQVOzBVEHuMYAO5W/
         g1tdXED93lRZL3Gtvzx54O25F5kBkd7HZLYIRqgIcciAq0PIjkDtDxDiATZ75q3t7NV9
         3qupgAugipXLVfXON31cFNFL76ZO8oP1eoT/dMIcVn8mM+LI1CYbQgMLYfXJjtIYlMAf
         n+y1j6JEk9cbz8jvZkFxBsoyWBVS5KHg7tcwqRfbl3wThZB/Hu2wubiABI0/VZCMnC71
         2VFW0BIFF9F6qAN5vvBC8BOet8f4Fgc/zxgoXSiznofacPvI8U+eVrc7rvKbo162uz5m
         r6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPdgwGrBydG4Hv6ux/FkDJFKRVmMXBzBhPLZ3TZUHrzqotUeRLYp832063St+KX5jPwDPtTQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwTwyTpoX39U7QYpqJ9ryqKIsNKwfvJgNegbfesnaCJhka5xS
	1sjwHTdTBg8MgGnL7hgPVUXo/ZZhAWVAd8HIQpQ58gCXibcRmf8rA8hG82KdpHgPVn0DY75EJsq
	uIzqwxAg+wn2aEW++2YGSrgpZ+Zflouduvzqm3V3J
X-Gm-Gg: AY/fxX5VmHR3a7pYFhML8IZCHTvGV0BHosM9Wx0DcwOERCAN+qmf+UmX9QafKHvfIOE
	lpJtZziZ4b4YtHeD9rJntvq9tIKO7CrN321SV+9z3gjxNq3A4XoO6Nw+K/bGTiJAgvFolMpzYsK
	p83apGku4B8jx/Qt1v5+03uXyBPoX9iEtA9uDDa3UBfv8d9p9G5DbUrcVHjG+/1CZqv4Wy9fbgn
	HKyxz3H3wRGb4YjWL2KSJMTkwuCcvDVsdKeL+l3xLSs2XXL3FoIIXwRnurOHEWvROUb98V10CUR
	xKalpLhdC0op4EhOTj2Wd0k1
X-Received: by 2002:a05:690c:6b88:b0:78d:1132:dad3 with SMTP id
 00721157ae682-793c526e1e8mr7421227b3.20.1768507644288; Thu, 15 Jan 2026
 12:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112230944.3085309-1-boolli@google.com> <20260112230944.3085309-2-boolli@google.com>
 <164caca4-f57f-4363-a8f1-0e090a4eb192@molgen.mpg.de>
In-Reply-To: <164caca4-f57f-4363-a8f1-0e090a4eb192@molgen.mpg.de>
From: Li Li <boolli@google.com>
Date: Thu, 15 Jan 2026 12:07:12 -0800
X-Gm-Features: AZwV_Qi3-qSZFh24Z3X_f1hmLACqlT8waYll0ogUs48ORnOjL-Wwuabgffh4rfI
Message-ID: <CAODvEq6E-TLJ5Z0L3dfB3NgQrCRuQ9W=-g97hw+1yM+yJB_7iw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/2] idpf: skip deallocating bufq_sets
 from rx_qgrp if it is NULL.
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:31=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Li,
>
>
> Thank you for your patch.
>
> Am 13.01.26 um 00:09 schrieb Li Li via Intel-wired-lan:
> > In idpf_rxq_group_alloc(), if rx_qgrp->splitq.bufq_sets failed to get
> > allocated:
> >
> >       rx_qgrp->splitq.bufq_sets =3D kcalloc(vport->num_bufqs_per_qgrp,
> >                                           sizeof(struct idpf_bufq_set),
> >                                           GFP_KERNEL);
> >       if (!rx_qgrp->splitq.bufq_sets) {
> >               err =3D -ENOMEM;
> >               goto err_alloc;
> >       }
> >
> > idpf_rxq_group_rel() would attempt to deallocate it in
> > idpf_rxq_sw_queue_rel(), causing a kernel panic:
> >
> > ```
> > [    7.967242] early-network-sshd-n-rexd[3148]: knetbase: Info: [    8.=
127804] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > ...
> > [    8.129779] RIP: 0010:idpf_rxq_group_rel+0x101/0x170
> > ...
> > [    8.133854] Call Trace:
> > [    8.133980]  <TASK>
> > [    8.134092]  idpf_vport_queues_alloc+0x286/0x500
> > [    8.134313]  idpf_vport_open+0x4d/0x3f0
> > [    8.134498]  idpf_open+0x71/0xb0
> > [    8.134668]  __dev_open+0x142/0x260
> > [    8.134840]  netif_open+0x2f/0xe0
> > [    8.135004]  dev_open+0x3d/0x70
> > [    8.135166]  bond_enslave+0x5ed/0xf50
> > [    8.135345]  ? nla_put_ifalias+0x3d/0x90
> > [    8.135533]  ? kvfree_call_rcu+0xb5/0x3b0
> > [    8.135725]  ? kvfree_call_rcu+0xb5/0x3b0
> > [    8.135916]  do_set_master+0x114/0x160
> > [    8.136098]  do_setlink+0x412/0xfb0
> > [    8.136269]  ? security_sock_rcv_skb+0x2a/0x50
> > [    8.136509]  ? sk_filter_trim_cap+0x7c/0x320
> > [    8.136714]  ? skb_queue_tail+0x20/0x50
> > [    8.136899]  ? __nla_validate_parse+0x92/0xe50
> > [    8.137112]  ? security_capable+0x35/0x60
> > [    8.137304]  rtnl_newlink+0x95c/0xa00
> > [    8.137483]  ? __rtnl_unlock+0x37/0x70
> > [    8.137664]  ? netdev_run_todo+0x63/0x530
> > [    8.137855]  ? allocate_slab+0x280/0x870
> > [    8.138044]  ? security_capable+0x35/0x60
> > [    8.138235]  rtnetlink_rcv_msg+0x2e6/0x340
> > [    8.138431]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > [    8.138650]  netlink_rcv_skb+0x16a/0x1a0
> > [    8.138840]  netlink_unicast+0x20a/0x320
> > [    8.139028]  netlink_sendmsg+0x304/0x3b0
> > [    8.139217]  __sock_sendmsg+0x89/0xb0
> > [    8.139399]  ____sys_sendmsg+0x167/0x1c0
> > [    8.139588]  ? ____sys_recvmsg+0xed/0x150
> > [    8.139780]  ___sys_sendmsg+0xdd/0x120
> > [    8.139960]  ? ___sys_recvmsg+0x124/0x1e0
> > [    8.140152]  ? rcutree_enqueue+0x1f/0xb0
> > [    8.140341]  ? rcutree_enqueue+0x1f/0xb0
> > [    8.140528]  ? call_rcu+0xde/0x2a0
> > [    8.140695]  ? evict+0x286/0x2d0
> > [    8.140856]  ? rcutree_enqueue+0x1f/0xb0
> > [    8.141043]  ? kmem_cache_free+0x2c/0x350
> > [    8.141236]  __x64_sys_sendmsg+0x72/0xc0
> > [    8.141424]  do_syscall_64+0x6f/0x890
> > [    8.141603]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [    8.141841] RIP: 0033:0x7f2799d21bd0
> > ...
> > [    8.149905] Kernel panic - not syncing: Fatal exception
> > [    8.175940] Kernel Offset: 0xf800000 from 0xffffffff81000000 (reloca=
tion range: 0xffffffff80000000-0xffffffffbfffffff)
> > [    8.176425] Rebooting in 10 seconds..
> > ```
> >
> > Tested: With this patch, the kernel panic no longer appears.
>
> Is it easy to reproduce?

In our internal environments, we have the idpf driver running on
machines with small RAM, and it's not uncommon for
them to run out of memory and encounter kalloc issues, especially in
kcallocs where we allocate higher order memory.

To reliably reproduce the issue in my own testing, I simply set
rx_qgrp->splitq.bufq_sets to NULL:

    rx_qgrp->splitq.bufq_sets =3D kcalloc(vport->num_bufqs_per_qgrp,
                                           sizeof(struct idpf_bufq_set),
                                           GFP_KERNEL);
    rx_qgrp->splitq.bufq_sets =3D NULL;

If the error path works correctly, we should not see a kernel panic.


>
> > Fixes: 95af467d9a4e ("idpf: configure resources for RX queues")
> >
>
> (Just for the future, a blank in the =E2=80=9Ctag section=E2=80=9D is unc=
ommon.)

Thank you for the info!

>
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/=
ethernet/intel/idpf/idpf_txrx.c
> > index e7b131dba200c..b4dab4a8ee11b 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> > @@ -1337,6 +1337,8 @@ static void idpf_txq_group_rel(struct idpf_vport =
*vport)
> >   static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
> >   {
> >       int i, j;
> > +     if (!rx_qgrp->splitq.bufq_sets)
> > +             return;
> >
> >       for (i =3D 0; i < rx_qgrp->vport->num_bufqs_per_qgrp; i++) {
> >               struct idpf_bufq_set *bufq_set =3D &rx_qgrp->splitq.bufq_=
sets[i];
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

