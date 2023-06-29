Return-Path: <netdev+bounces-14632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A597D742BF0
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60196280C55
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926BF9ED;
	Thu, 29 Jun 2023 18:34:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89113AD4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:34:53 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A61719;
	Thu, 29 Jun 2023 11:34:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69ed7d050so16189111fa.2;
        Thu, 29 Jun 2023 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688063687; x=1690655687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad4G5blKLDpsOnQFvBn9APXDoavlfkj0FLRAwkigTTc=;
        b=dnGMhhe4w2F/vWdTYzVNCYH4mWjFkbR3z0RO9qyiIX2fdTovD877uZJuAMwnnzGrqC
         iAvX4NFn13UuJylv5HlrPypdBvJyREA8mIy6ggBvOk18iQFLh0iwax+QenQsB0p0Bk6q
         DirpJZ/ZbeCDQKD7dI9zYL+etKzr28VkBW56fO0SX3dwdKUckGMSmtfI7XISanpAvZU3
         lHfeli6xNuDRhqqDD/r5mj2dsD3O+uc5Hcv1zLbXkrnVd/+3apQT+ralAzEQUuJcCQFu
         XGicCVIW2wY2nPiUgQnK5z/yRAYtEjvsSNIFbM1jRVPT61fpwt7xmfl9cvnAaIvneghC
         nUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688063687; x=1690655687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad4G5blKLDpsOnQFvBn9APXDoavlfkj0FLRAwkigTTc=;
        b=TA5OvHsmthiVs9xM/q7rsA4Rsa2U+IiR8kJ1btfPtsbJnxQwCYHc+na0V024mk25VP
         crgIFvqbCuzjbJsOICZVtONa0Vg2pUvVYRz91C1/ch20iQ0FcEwBQN3Os4EWRaf5EnAn
         vvNytw402Vob9642ANcZRC2WVXmyDxjpY4RAf2OlEelBurqSbVSeI7hakxE2arHqzlR4
         K+ILjNsXFtcAUWjI4GgagFXmKSv3Lwk9+IDK2SvMlMrVMX/1KLt3GD6sj5Jl5A7FffGe
         ITBoOiGjubmV8T7fjokfTWLU2RFZsjas+I0R1AmBRk9ClvOw2NHEvya78S5/lDL/rDVw
         xnAw==
X-Gm-Message-State: ABy/qLZa9mUYk6Tgyrp/L6kZ4iPdmqFA87ugAwjfVmkyWLRjg9UYO3oV
	CykrpELh3NK3g1s5h9pxHp3hMCDmdE7hNhonjf4=
X-Google-Smtp-Source: APBJJlGcryx1LzHvJlXYH/fskMS+YAxHAkWWFVWkiEk/8ArAMjb1VTtNjBIznNPa5zEiVASht5peZDU8KzzOc7UXpoQ=
X-Received: by 2002:a2e:800b:0:b0:2b6:bbb9:b560 with SMTP id
 j11-20020a2e800b000000b002b6bbb9b560mr452432ljg.0.1688063686820; Thu, 29 Jun
 2023 11:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627191004.2586540-1-luiz.dentz@gmail.com>
 <20230628193854.6fabbf6d@kernel.org> <CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
 <20230629082241.56eefe0b@kernel.org> <20230629105941.1f7fed9c@kernel.org>
In-Reply-To: <20230629105941.1f7fed9c@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Jun 2023 11:34:34 -0700
Message-ID: <CABBYNZ+mg1iB_N3-FnVCH8O6j=EAs1BTZjGcG_dwU2oOGk-T+w@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2023-06-27
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On Thu, Jun 29, 2023 at 10:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 29 Jun 2023 08:22:41 -0700 Jakub Kicinski wrote:
> > On Wed, 28 Jun 2023 22:01:05 -0700 Luiz Augusto von Dentz wrote:
> > > >  a8d0b0440b7f ("Bluetooth: btrtl: Add missing MODULE_FIRMWARE decla=
rations")
> > > >  349cae7e8d84 ("Bluetooth: btusb: Add device 6655:8771 to device ta=
bles")
> > > >  afdbe6303877 ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
> > > >  d1b10da77355 ("Bluetooth: L2CAP: Fix use-after-free")
> > > >  c1121a116d5f ("Bluetooth: fix invalid-bdaddr quirk for non-persist=
ent setup")
> > > >  2f8b38e5eba4 ("Bluetooth: fix use-bdaddr-property quirk")
> > > >  317af9ba6fff ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_=
ready_cb")
> > > >  a6cfe4261f5e ("Bluetooth: hci_bcm: do not mark valid bd_addr as in=
valid")
> > > >  20b3370a6bfb ("Bluetooth: ISO: use hci_sync for setting CIG parame=
ters")
> > > >  29a3b409a3f2 ("Bluetooth: hci_event: fix Set CIG Parameters error =
status handling")
> > > >  48d15256595b ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connec=
table")
> > > >  f145eeb779c3 ("Bluetooth: ISO: Rework sync_interval to be sync_fac=
tor")
> > > >  0d39e82e1a7b ("Bluetooth: hci_sysfs: make bt_class a static const =
structure")
> > > >  8649851b1945 ("Bluetooth: hci_event: Fix parsing of CIS Establishe=
d Event")
> > > >  5b611951e075 ("Bluetooth: btusb: Add MT7922 bluetooth ID for the A=
sus Ally")
> > > >  00b51ce9f603 ("Bluetooth: hci_conn: Use kmemdup() to replace kzall=
oc + memcpy")
> > > >
> > > > You can throw in a few more things you think are important and are
> > > > unlikely to cause regressions.
> > >
> > > Yeah, those seem to be the most important ones, do you want me to red=
o
> > > the pull-request or perhaps you can just cherry-pick them?
> >
> > Nothing to add to that list?
> > Let me see if I can cherry-pick them cleanly.
>
> I pushed these to net now, hopefully I didn't mess it up :)

Great, thanks. I guess I will change the frequency we do pull request
to net-next going forward, perhaps something doing it
bi-weekly/monthly would be better to avoid risking missing the merge
window if that happens to conflict with some event, etc.

--=20
Luiz Augusto von Dentz

