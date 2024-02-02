Return-Path: <netdev+bounces-68534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE29847237
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245ABB25BCF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED82B9A1;
	Fri,  2 Feb 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06dpG3rx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245B7F7D3
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885521; cv=none; b=h4WGDqSqppFlFp/2Acg7CqVZx4gFk6zr6zjElL0w5vlsa8BfQTQH2QRg3Ywr18eqXHRyZ9sshAQdmPaLXf0Gy88FxuInrmW7cSNd5I5vwq8eXRhuuPcIOsk/KpQ3UHW5MFFHymr21KJ8PWsuAS+6oy9/EGdc3Ygpb8QMBVXBfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885521; c=relaxed/simple;
	bh=70P5vrTsGzNAKrq3wBE/YqB4BwTzcc1xvVpm51oliks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kknm3D6a7Px/0QsICqijo+vYEmzpMx6GSU6vqslJMTB1dcjr1wEcE3vvFEQfEukJx6n1t0xF8y9gOIVhWf3YeMcYFcsedUqExhu3RVXdQBiIaPXAfE/qK4KiXcmufnOPTYHpNvQwUX/m0wsrJxrUB1BWU8cwE/wA0aJ+HTXHHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06dpG3rx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55fff7a874fso6257a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706885518; x=1707490318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8SUGcuT5iqtitOI1qPRqeM3GypUyzBfV2zoJ/JlD3o=;
        b=06dpG3rxB084v2ekVYvOmfMucwfTgmjsVraPyu8As98BJ4wg0eB6Jac7ZD70yMfd/R
         mSKc7HIzFDdOUSYWeh9FbTNbpjNjDUoajXOGN5WzGjtLqoO6LlDaz5N2sd6h1V4/Aekh
         wDoaKb2QAY31LzbcLhkV0HrSCf2YHXApG+xo6LK8uaxkUjF+icHhLKO5kjBL93WDg59/
         5y6AsqeSSUJ4Tj7ICGU1q5NnD8cs1K/JnwR+Vx2GnbpfoBEJxqbIjufO7VZA/5N9ySgb
         yzAcNDGrjfymSl36l+wPr125Vt0DU8q8C3v+dLvRi61XOTL6fRyG/aj32vpOZoLQxC74
         Friw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885518; x=1707490318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8SUGcuT5iqtitOI1qPRqeM3GypUyzBfV2zoJ/JlD3o=;
        b=WZpyoqzu1dgYtbVzA+xJkvytHQTOXUwZoAE3Gp7XmgAD/NfkjeeLP+FKe7nhoOPNqM
         awB/Tfl7LVXcYzRFa19hQqITG4XP+IcRlO+gaeQBZaEyyppcup/LnuCqjaX/vsw75U67
         dlsIhtn0iIeYfd76QQ+kEpez5GSHypstUpNlM9HEO7pGRugNcKoEnpVSuoI/rx8RCZYi
         MGRSRCAkMDj3ZE5BhKDnK/soVy3bdMw5KSIoRZtVakaB/93zN02F9GeX4SNuLGjxBpvH
         q5JP+CKNZ0ky2UmFZPboZhFOHuoA1H08AhwjiwOrtPQnd9MIH5L5DXxbqpGOSGPel1C6
         E8Wg==
X-Gm-Message-State: AOJu0YzpQKQA/+NjWOw7cG5yllBplbkINjRzv6nsAIlbcJyP/qzvwfA+
	x/1atnOE2Ip1ncSpXs3yOz6D5ShpwGCrPD9nl2Wjfw7cNE0It4w164UiM91wIgOHoiZAI4kLBi6
	hyERybm2tt4ficPOpdDf43MENiJkKV+ZqL/cE
X-Google-Smtp-Source: AGHT+IG6MptKIwPmQqM71pnnii9o3hteYZdAqf0Wq+SBzCe+wKTcwAJw4N1SebmD3RmRMWC+rcWJpyUyO4Rrtc6LEgQ=
X-Received: by 2002:a50:c318:0:b0:55f:a1af:bade with SMTP id
 a24-20020a50c318000000b0055fa1afbademr15416edb.4.1706885517772; Fri, 02 Feb
 2024 06:51:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com> <20240201170937.3549878-6-edumazet@google.com>
 <170688415193.5216.10499830272732622816@kwain>
In-Reply-To: <170688415193.5216.10499830272732622816@kwain>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 15:51:43 +0100
Message-ID: <CANn89i+300-irMM8gZwbq6+xn7Mxc7mdr_wKhoRoyxYstV8kvQ@mail.gmail.com>
Subject: Re: [PATCH net-next 05/16] bonding: use exit_batch_rtnl() method
To: Antoine Tenart <atenart@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:29=E2=80=AFPM Antoine Tenart <atenart@kernel.org> =
wrote:
>
> Hello,
>
> Quoting Eric Dumazet (2024-02-01 18:09:26)
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index 4e0600c7b050f21c82a8862e224bb055e95d5039..181da7ea389312d7c851ca5=
1c35b871c07144b6b 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -6419,34 +6419,34 @@ static void __net_exit bond_net_exit_batch(stru=
ct list_head *net_list)
> >  {
> >         struct bond_net *bn;
> >         struct net *net;
> > -       LIST_HEAD(list);
> >
> >         list_for_each_entry(net, net_list, exit_list) {
> >                 bn =3D net_generic(net, bond_net_id);
> >                 bond_destroy_sysfs(bn);
> > +               bond_destroy_proc_dir(bn);
> >         }
> > +}
> > +
> > +static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_=
list,
> > +                                               struct list_head *dev_k=
ill_list)
> > +{
> > +       struct bond_net *bn;
> > +       struct net *net;
> >
> >         /* Kill off any bonds created after unregistering bond rtnl ops=
 */
> > -       rtnl_lock();
> >         list_for_each_entry(net, net_list, exit_list) {
> >                 struct bonding *bond, *tmp_bond;
> >
> >                 bn =3D net_generic(net, bond_net_id);
> >                 list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list,=
 bond_list)
> > -                       unregister_netdevice_queue(bond->dev, &list);
> > -       }
> > -       unregister_netdevice_many(&list);
> > -       rtnl_unlock();
> > -
> > -       list_for_each_entry(net, net_list, exit_list) {
> > -               bn =3D net_generic(net, bond_net_id);
> > -               bond_destroy_proc_dir(bn);
> > +                       unregister_netdevice_queue(bond->dev, dev_kill_=
list);
> >         }
> >  }
>
> This changes the logic of how bond net & devices are destroyed. Before
> this patch the logic was:
>
> 1. bond_destroy_sysfs; called first so no new bond devices can be
>    registered later.
> 2. unregister_netdevice; cleans up any new bond device added before 1.
>
> This now is:
> 1. unregister_netdevice
> // Here new bond devices can still be registered.
> 2. bond_destroy_sysfs
>
> Looking briefly at the history, the above is done on purpose to avoid
> issues when unloading the bonding module. See 23fa5c2caae0 and
> especially 69b0216ac255.

Nice catch, thanks.

Hmmm, it seems we should perform the  bond_destroy_sysfs(bn) call earlier t=
hen,
from the pre_exit() method...

Order of calls is :
1) pre_exit()
2) exit_batch_rtnl()
3) exit(), exit_batch()

Something like the following (that I would squash on the current patch)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 181da7ea389312d7c851ca51c35b871c07144b6b..7edd3daa7e6d977e6b0220226b3=
cd4f8f67a7952
100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6415,6 +6415,13 @@ static int __net_init bond_net_init(struct net *net)
        return 0;
 }

+static void __net_exit bond_net_pre_exit(struct net *net)
+{
+       struct bond_net *bn =3D net_generic(net, bond_net_id);
+
+       bond_destroy_sysfs(bn);
+}
+
 static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 {
        struct bond_net *bn;
@@ -6422,7 +6429,6 @@ static void __net_exit
bond_net_exit_batch(struct list_head *net_list)

        list_for_each_entry(net, net_list, exit_list) {
                bn =3D net_generic(net, bond_net_id);
-               bond_destroy_sysfs(bn);
                bond_destroy_proc_dir(bn);
        }
 }
@@ -6445,8 +6451,9 @@ static void __net_exit
bond_net_exit_batch_rtnl(struct list_head *net_list,

 static struct pernet_operations bond_net_ops =3D {
        .init =3D bond_net_init,
-       .exit_batch =3D bond_net_exit_batch,
+       .pre_exit =3D bond_net_pre_exit,
        .exit_batch_rtnl =3D bond_net_exit_batch_rtnl,
+       .exit_batch =3D bond_net_exit_batch,
        .id   =3D &bond_net_id,
        .size =3D sizeof(struct bond_net),
 };

