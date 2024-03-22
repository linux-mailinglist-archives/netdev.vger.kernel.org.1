Return-Path: <netdev+bounces-81156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F88864F6
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 03:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B99DB21BE5
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAE10F2;
	Fri, 22 Mar 2024 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGDH1qv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D465C
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072826; cv=none; b=j/iYh/cNGf67E0Vts3Pndr7tN9RSr3TG4hdwflyWgYZ/RvQ98iQZlglMjKwugym6EOihlNqE2UZihLGa1M947AcHROcEuYU1TiFKI0eYr1TBMYYlWfm7gvE3abvFh0k5A76vNKtlLoTiWvcvjNK2ZpRSbIFBSqDglCY/I4i3V0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072826; c=relaxed/simple;
	bh=dvcaXBhuwzprJVtCaxQ9VOXOIGBArgQglSm+W983mBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4kKoPpdWRINqm92QFrIDvi5c06FinkmlvOLmX+cdE3F9SUdCsh4koraZilknvGzBEzuOIcbV7F2MWk/CeFv3ZTP4PYhPpqbwmP9YIaRhCYGdZNhYOu5qiXOBk7Jgm9d9AYWFrhaWJ+V1n4Q8REnS6wvLpcPxKudoybkQBY6Bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGDH1qv+; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c380e99582so281686b6e.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 19:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711072823; x=1711677623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOaKxoqVg5vphIkjszL+pLQehEuCTI7rzNMI9MIIgCs=;
        b=FGDH1qv+EQi7/IwIM+kZ845lS2SQ3u1MytAgC26fzmHPHrXi9QWfVvfcNuKtsZ/OSb
         42ZKrT1VBJBDTo4kEWIj6aKXjWXhxRVRENNhEkemFrsGKQXC2GSFdv6bUz2wXQiXM5oz
         6G64sQoBN723AyDitAboZUxIXsDAK1BPOHKjag83V+eg16CC8sCKWJpGjbVHHRcHeA2F
         I9qurRV7OlEF6Am+Wl3v6U2Kq70Bsx906RzJU1CYSVoo8gKeYQYXihNmWs4DFI+I0WPZ
         Uo6l4DwerKHQncP2Vs4BYkDGQfKK97GmioZeA1cB3iyU7eZSG12M5vTtHAKoIWmuSYXV
         dBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711072823; x=1711677623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOaKxoqVg5vphIkjszL+pLQehEuCTI7rzNMI9MIIgCs=;
        b=oHtxngYf03UqCKCdOXC8weWqO5Wy4KE5CRsWIUsCLqr1mW9RdqOIgfKIaTcW0ykGoN
         su7hfftwRwiK8v3kUNsYCfup7gcrFUh1PySS3guqbtg2kdCIAQaUS3GDcGvJwK+x8QK+
         3MUUTOPKEEXuaiJ661JqVplZFOp0l6aNs741m0VmVsEN4KJ6WGYZwaAK7gHKehn+xJM7
         AtdzxeLenkCSwaOWaYe/dLxGKoPng8tr4RwR1FM+r1jvxxd9fOal0zCaI3Xs2FWh4ARZ
         4yu3cgHW0X4Nx5NChJoJ4yEJOXK20iIeICQQZT+WiTn3co3HR1piyytHTBGSngz1NRNJ
         9iCA==
X-Forwarded-Encrypted: i=1; AJvYcCVEqiKBZEvfjw3rgE7N1XD6owGZuuyPdEWW7TWd2Sq+Aoy8HLbUWkqwBXUIfu4CBQ5YrgiVZ222JXqUXzfcayCZ3E21EKQ5
X-Gm-Message-State: AOJu0Yx20GhJ3nUzSA7X6IwBskywzZLXf3TcqWqmeBOF6Mm9zS3Otiv0
	KFW0ve/7xhJuyeZgRGMfAXEwDB4qSNlkEEmGJkFeKaJNpWINKst6OQxuNGxPtu3rOmG2RhjWcU8
	HevC6WhAbH2kRnHFetEviUyAL+6U=
X-Google-Smtp-Source: AGHT+IHxEw1w1+e4e3uZWl+309gmO9NWLNKuaOLE+l76Ye5hAVoQ5gIFeohcFJvVrent8dE0fJIMm2cQaHgJD0lHJ6c=
X-Received: by 2002:a05:6871:b07:b0:222:9fd1:38af with SMTP id
 fq7-20020a0568710b0700b002229fd138afmr600363oab.2.1711072823206; Thu, 21 Mar
 2024 19:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321123611.380158-1-wenjian1@xiaomi.com> <ZfwvR81dq4WN0XOG@nanopsycho>
In-Reply-To: <ZfwvR81dq4WN0XOG@nanopsycho>
From: Jian Wen <wenjianhn@gmail.com>
Date: Fri, 22 Mar 2024 09:59:47 +0800
Message-ID: <CAMXzGWK8m1QvKgxYv9Gun0NkxoeHBiUR+tM9yrwF1Ef68K=QiA@mail.gmail.com>
Subject: Re: [PATCH net] devlink: use kvzalloc() to allocate devlink instance resources
To: Jiri Pirko <jiri@resnulli.us>
Cc: edumazet@google.com, davem@davemloft.net, Jian Wen <wenjian1@xiaomi.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 8:59=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Thu, Mar 21, 2024 at 01:36:11PM CET, wenjianhn@gmail.com wrote:
> >During live migration of a virtual machine, the SR-IOV VF need to be
> >re-registered. It may fail when the memory is badly fragmented.
> >
> >The related log is as follows.
> >
> >Mar  1 18:54:12  kernel: hv_netvsc 6045bdaa-c0d1-6045-bdaa-c0d16045bdaa =
eth0: VF slot 1 added
> >...
> >Mar  1 18:54:13  kernel: kworker/0:0: page allocation failure: order:7, =
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=3D(null),cpuset=3D=
/,mems_allowed=3D0
> >Mar  1 18:54:13  kernel: CPU: 0 PID: 24006 Comm: kworker/0:0 Tainted: G =
           E     5.4...x86_64 #1
> >Mar  1 18:54:13  kernel: Hardware name: Microsoft Corporation Virtual Ma=
chine/Virtual Machine, BIOS 090008  12/07/2018
> >Mar  1 18:54:13  kernel: Workqueue: events work_for_cpu_fn
> >Mar  1 18:54:13  kernel: Call Trace:
> >Mar  1 18:54:13  kernel: dump_stack+0x8b/0xc8
> >Mar  1 18:54:13  kernel: warn_alloc+0xff/0x170
> >Mar  1 18:54:13  kernel: __alloc_pages_slowpath+0x92c/0xb2b
> >Mar  1 18:54:13  kernel: ? get_page_from_freelist+0x1d4/0x1140
> >Mar  1 18:54:13  kernel: __alloc_pages_nodemask+0x2f9/0x320
> >Mar  1 18:54:13  kernel: alloc_pages_current+0x6a/0xb0
> >Mar  1 18:54:13  kernel: kmalloc_order+0x1e/0x70
> >Mar  1 18:54:13  kernel: kmalloc_order_trace+0x26/0xb0
> >Mar  1 18:54:13  kernel: ? __switch_to_asm+0x34/0x70
> >Mar  1 18:54:13  kernel: __kmalloc+0x276/0x280
> >Mar  1 18:54:13  kernel: ? _raw_spin_unlock_irqrestore+0x1e/0x40
> >Mar  1 18:54:13  kernel: devlink_alloc+0x29/0x110
> >Mar  1 18:54:13  kernel: mlx5_devlink_alloc+0x1a/0x20 [mlx5_core]
> >Mar  1 18:54:13  kernel: init_one+0x1d/0x650 [mlx5_core]
> >Mar  1 18:54:13  kernel: local_pci_probe+0x46/0x90
> >Mar  1 18:54:13  kernel: work_for_cpu_fn+0x1a/0x30
> >Mar  1 18:54:13  kernel: process_one_work+0x16d/0x390
> >Mar  1 18:54:13  kernel: worker_thread+0x1d3/0x3f0
> >Mar  1 18:54:13  kernel: kthread+0x105/0x140
> >Mar  1 18:54:13  kernel: ? max_active_store+0x80/0x80
> >Mar  1 18:54:13  kernel: ? kthread_bind+0x20/0x20
> >Mar  1 18:54:13  kernel: ret_from_fork+0x3a/0x50
> >
> >Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
>
> This is not fixing a bug introduced by specific commit, is it? Or is
> this a regression? In that case, you need to add "Fixes" tag.
> Idk, looks more like net-next material. The patch itself looks okay to
> me.
A patch against net-next has been sent. Please review.
Thanks.
>
>
> >---
> > net/devlink/core.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/devlink/core.c b/net/devlink/core.c
> >index 7f0b093208d7..ffbac42918d7 100644
> >--- a/net/devlink/core.c
> >+++ b/net/devlink/core.c
> >@@ -314,7 +314,7 @@ static void devlink_release(struct work_struct *work=
)
> >       mutex_destroy(&devlink->lock);
> >       lockdep_unregister_key(&devlink->lock_key);
> >       put_device(devlink->dev);
> >-      kfree(devlink);
> >+      kvfree(devlink);
> > }
> >
> > void devlink_put(struct devlink *devlink)
> >@@ -420,7 +420,7 @@ struct devlink *devlink_alloc_ns(const struct devlin=
k_ops *ops,
> >       if (!devlink_reload_actions_valid(ops))
> >               return NULL;
> >
> >-      devlink =3D kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> >+      devlink =3D kvzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
> >       if (!devlink)
> >               return NULL;
> >
> >@@ -455,7 +455,7 @@ struct devlink *devlink_alloc_ns(const struct devlin=
k_ops *ops,
> >       return devlink;
> >
> > err_xa_alloc:
> >-      kfree(devlink);
> >+      kvfree(devlink);
> >       return NULL;
> > }
> > EXPORT_SYMBOL_GPL(devlink_alloc_ns);
> >--
> >2.34.1
> >
> >

