Return-Path: <netdev+bounces-50525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D67F606A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EA0281CE1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B7250F1;
	Thu, 23 Nov 2023 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dRySmC2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F71810C4
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:37:25 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cc69df1b9aso8666487b3.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700746644; x=1701351444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAK5GGN5eM+sp8ywkRq2XmkyXFrZaGIsPaqGwv97nfE=;
        b=dRySmC2UzI1pLfBCaVa+rRvRSPY1zcffDWE/GePKI34X7tKz8DYhoD1CS63g/zYzaw
         WjyDLyAFCnpziMD78hsuyBFRFeWn9GRxkfRq72R+DxKK2hqumR/Zt64oUlg8QPLxSc2e
         Rti2vM0jg1oL0og/eAZyGqeWunhPg33nW07Vr/+vsAKBBCBjRGrU04jizqbSXP6e6npX
         qpyifselZhZIpYVlmeBBlyhQfWtLMAZyOy4HQKl/IaM+KJ9FmDWp4VYJE34Ebe0A08qD
         j/uJgUT8eZ4+hs+/TTQ/z4xvmz7GRqtCFypXiyxkn2b5+kqLVdVHZMvLOUYcviokhi0f
         JhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746644; x=1701351444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAK5GGN5eM+sp8ywkRq2XmkyXFrZaGIsPaqGwv97nfE=;
        b=gcGSGKcKAUDpNn7xXej2nHZzKcQAwa67TVfQUDsdXTIjOmBnCFzwF34+zII1fcOYpJ
         x8xirMwcMKtqSEW7vz2VgILsc8kdJZzNt8s0yTqP3dJM4dtMBqUQtDVq6ZDac23Tss+U
         jHmliygeFo5xhWmR4vMbNrnaUfVM/N2bulOqvFpHTgXmqqZagPQqdytX915X3NpeXCyT
         LO9/Pno5tgkpktOitAbslMZc/yWYEB77MbkaALOc2j+AdAAMwpBHKN05B3Tnl5FA4iyY
         NxTpsoouqbJmr3YQRrqWv+qQr3E6AJTQJuHF3wh6NQso1wbC9X9YV0KboiaOP7S8e+w7
         NXGg==
X-Gm-Message-State: AOJu0Yz1s0z5nJIwzwaiuNZalR+fQ8PbOktwFboAcVRGhs9dh2oTiXmV
	/tWGi6Q90jZM5K+vL02gibyKL56oo1A4mgNp0PmIsgt/Z0fWsgth
X-Google-Smtp-Source: AGHT+IGYoIthAmm/gK177zadmlaYCaPj+bGlDYDQecsvIb2e3DkcKWUFLSi/jJ7iBxy3VA/e8mzCB9BMV96iLTsLfcw=
X-Received: by 2002:a0d:fb47:0:b0:5b3:b17d:190f with SMTP id
 l68-20020a0dfb47000000b005b3b17d190fmr6075424ywf.29.1700746644734; Thu, 23
 Nov 2023 05:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110214618.1883611-1-victor@mojatatu.com> <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho>
In-Reply-To: <ZV8SnZPBV4if5umR@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 23 Nov 2023 08:37:13 -0500
Message-ID: <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 3:51=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
> >This action takes advantage of the presence of tc block ports set in the
> >datapath and multicasts a packet to ports on a block. By default, it wil=
l
> >broadcast the packet to a block, that is send to all members of the bloc=
k except
> >the port in which the packet arrived on. However, the user may specify
> >the option "tx_type all", which will send the packet to all members of t=
he
> >block indiscriminately.
> >
> >Example usage:
> >    $ tc qdisc add dev ens7 ingress_block 22
> >    $ tc qdisc add dev ens8 ingress_block 22
> >
> >Now we can add a filter to broadcast packets to ports on ingress block i=
d 22:
> >$ tc filter add block 22 protocol ip pref 25 \
> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>
> Name the arg "block" so it is consistent with "filter add block". Make
> sure this is aligned netlink-wise as well.
>
>
> >
> >Or if we wish to send to all ports in the block:
> >$ tc filter add block 22 protocol ip pref 25 \
> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>
> I read the discussion the the previous version again. I suggested this
> to be part of mirred. Why exactly that was not addressed?
>

I am the one who pushed back (in that discussion). Actions should be
small and specific. Like i had said in that earlier discussion it was
a mistake to make mirred do both mirror and redirect - they should
have been two actions. So i feel like adding a block to mirred is
adding more knobs. We are also going to add dev->group as a way to
select what devices to mirror to. Should that be in mirred as well?

cheers,
jamal

> Instead of:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
> You'd have:
> $ tc filter add block 22 protocol ip pref 25 \
>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>
> I don't see why we need special action for this.
>
> Regarding "tx_type all":
> Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
> to have this as "no_src_skip" or some other similar arg, without value
> acting as a bool (flag) on netlink level.
>
>

