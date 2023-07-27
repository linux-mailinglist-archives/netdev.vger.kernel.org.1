Return-Path: <netdev+bounces-21995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED909765964
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4CD1C2160A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C285D2713F;
	Thu, 27 Jul 2023 17:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78C327124
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:02:17 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B42D75
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:02:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40631c5b9e9so7171cf.1
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690477335; x=1691082135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekSMCJOc1QAe0cgfGGMRA4Cd96AynhuFzWq8EP4Y2aI=;
        b=lnGVnaUiv6rP0DDdR3BLaln+uM2kOSkvC+dd3we2ESOOOJ2USWuJ2h1fue+NqSxjcX
         27nid6iMyFle2aK4sLL4GVpMXWFPY3jSboAHax1ryyb9tzZV47GMgOe/rPmniowoXI5j
         DLbUqOjvlUhHRfWXPOAnjiPHl5lLalMg4FED32ix+XqWKjeuD7ocLWmpbrmmXlFmXCw7
         Tp/8UPEcTs60e/DAJL5D5N60YAAlhAwoMqTcPFqj/M99hpiIrvT5Xb8GFBDYtktv5Qkt
         EDQH6JwkSwa4BTZsTi4cxW/A9mBLqGPGLk/H2964s41g4UEuTPav/i8/5gJ956Es2c/N
         tXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690477335; x=1691082135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekSMCJOc1QAe0cgfGGMRA4Cd96AynhuFzWq8EP4Y2aI=;
        b=i7QoscGECa1zR6zvbh4MeoKvATjR4S/bj6hYGk1AmBYIYd0lw96bGcN5u5c5o8tVX7
         jZVk2WyTBk112ouulJR8UV/RYoFXvZHJo8HS38TB4XRA+vEJu101EoshSpXS5+JOaYby
         fQpE5wGj56IJ7lXdXg4iHlbToaCYzwSxKzPm6lsykd8UikIC2qyVtfSzvBlExqxIbQx6
         OyOOqbZ4MThiUbfyhm4ISMdNZ4H7EI/idzFJBl/AKnmeI2htI3GsEjJ8khaoyRwQD7gf
         es+DfEokqy2Z30yHaPwA/ehii/ek27LF5fPxtkIrmJhMhVr4dJg/+6yKTS/m0lDi+4QJ
         354A==
X-Gm-Message-State: ABy/qLaLK59b9UMuDioFExwMqJrgHvfPHc9p2lEi2QIWWn1Ih2xL4DGW
	HzPJs9vcFgrTwjGTpB3kAciC9IoGJXKCacTillLU6A==
X-Google-Smtp-Source: APBJJlFfXtC7yQKRkomeCanS4f3NU02fIa0yTIyJY4awuYkP2tDXRRbLzGeQuS+nYHC4C8X+kodC3LO1CKGM6xSIcw0=
X-Received: by 2002:a05:622a:18a9:b0:403:a6e5:9cdf with SMTP id
 v41-20020a05622a18a900b00403a6e59cdfmr10726qtc.8.1690477334773; Thu, 27 Jul
 2023 10:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1690471774.git.petrm@nvidia.com>
In-Reply-To: <cover.1690471774.git.petrm@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Jul 2023 19:02:03 +0200
Message-ID: <CANn89i+09tRSQWA85KR-3wTAPZk4_-nzrezYowcKA4anFoNCEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] mlxsw: Avoid non-tracker helpers when
 holding and putting netdevices
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 6:00=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
>
> Using the tracking helpers, netdev_hold() and netdev_put(), makes it easi=
er
> to debug netdevice refcount imbalances when CONFIG_NET_DEV_REFCNT_TRACKER
> is enabled. For example, the following traceback shows the callpath to th=
e
> point of an outstanding hold that was never put:
>
>     unregister_netdevice: waiting for swp3 to become free. Usage count =
=3D 6
>     ref_tracker: eth%d@ffff888123c9a580 has 1/5 users at
>         mlxsw_sp_switchdev_event+0x6bd/0xcc0 [mlxsw_spectrum]
>         notifier_call_chain+0xbf/0x3b0
>         atomic_notifier_call_chain+0x78/0x200
>         br_switchdev_fdb_notify+0x25f/0x2c0 [bridge]
>         fdb_notify+0x16a/0x1a0 [bridge]
>         [...]
>
> In this patchset, get rid of all non-ref-tracking helpers in mlxsw.

For the series :

Reviewed-by: Eric Dumazet <edumazet@google.com>

