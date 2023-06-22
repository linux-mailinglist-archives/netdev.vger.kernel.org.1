Return-Path: <netdev+bounces-12999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F9739A2B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710771C21148
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E93AAA7;
	Thu, 22 Jun 2023 08:39:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045A3AA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:39:58 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE53172C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:39:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40079620a83so172311cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687423192; x=1690015192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULolz8jorGPalTET8CohcMWQa7o4bio2Hm1JcsZglBA=;
        b=ESVKs+nO9FaEHi+RwHZ463KC6AIGkoJXgFnid96EJbyARGnVgZstkipz2PJbjJ6z5e
         yNgCEwp4gRgiv6hZ+VkqCYHDQdk4exlgh9DyEhURG0p4JIY+HPfhpqwKVivVJa5276Wh
         2p9AcMOxZAzC5waCKCILXfzAtTQxk2SHz3FMssxx/uOfuvT/eQ9Gae6Uwa0s12MLY/en
         +Yjqs5hRudb02g5OtcIUSdj2BnPe3oCwGjo1Cqu2opzV863BOEKr5FmL4wWyW7TvYdmF
         RQ97nhRv8fxMRzN3sHKsrpfkG1X36YZZKow6k1MLCz3VqSveAvASqWlO7kLz62JEAwx2
         GPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423192; x=1690015192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULolz8jorGPalTET8CohcMWQa7o4bio2Hm1JcsZglBA=;
        b=JYxJ3Jrk4l+tWB92VM+uGXZi87aNNhOnGgLG8tXnDjDZmQuc/e1DrI+sgCMY5hSU3A
         lvDGUsI2HEkHz5OUMg60oTDfnyDRw5npHh7/lD2JKsYFRlAqC1EL7qmuOBhS0MdTbdOX
         wsru/4tGtIzh9RZJ6lkWbo0gDAXGrE5iGFLRr1KKwArUX04nrWpfLgN52vW2UK6v9QgD
         hKezjYyL/y3Bs+/9WKoYFDlDQv6slcziSgXheBf6W0YArMkeWCwJqdFtoLssaQm4Kq5Y
         1JRNW3jgPmFl2Ur0GQ0bGyFqjfS3vWEriHjxyqGgD+RL8kiVgwH1k2B1HuU4LnZBVQij
         XD+A==
X-Gm-Message-State: AC+VfDwWQmdyb86nk1p9LB+bPNSw39HE48H9dCPicF3+/g4L9Wa5TQiy
	hqL5kGc2/F5sHh2RJpq4Qw2/n/TTd1nP3Nwk2eOucPPXncfgOFVgEio=
X-Google-Smtp-Source: ACHHUZ4pReT87QV1lE2MJfwL/qZ8jiTnx6dz6t374fVQAJOE94ZXHxzvjnUSKgeVv00lqsL7yILRh3o7HNaVUWNg2v8=
X-Received: by 2002:ac8:7f45:0:b0:3fc:7fb0:ad3a with SMTP id
 g5-20020ac87f45000000b003fc7fb0ad3amr678237qtk.24.1687423192252; Thu, 22 Jun
 2023 01:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621154337.1668594-1-edumazet@google.com> <ZJQAdLSkRi2s1FUv@nanopsycho>
 <CANn89iLeU+pBrcHZyQoSRa-X_3G-Y8cjF6FJy4XwkJc7ronqMA@mail.gmail.com> <ad471e9fe6a9b3812497c40456cba6e0c8a152ee.camel@sipsolutions.net>
In-Reply-To: <ad471e9fe6a9b3812497c40456cba6e0c8a152ee.camel@sipsolutions.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 10:39:41 +0200
Message-ID: <CANn89iJRWp9o1fcnGmC7GO0BKA-Rki+0k93Vt=Zo365OkdS=_Q@mail.gmail.com>
Subject: Re: [PATCH net] netlink: fix potential deadlock in netlink_set_err()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	"syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com" <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 10:26=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2023-06-22 at 08:14 +0000, Eric Dumazet wrote:
> > On Thu, Jun 22, 2023 at 10:04=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> =
wrote:
> > >
> > > Wed, Jun 21, 2023 at 05:43:37PM CEST, edumazet@google.com wrote:
> > > > syzbot reported a possible deadlock in netlink_set_err() [1]
> > > >
> > > > A similar issue was fixed in commit 1d482e666b8e ("netlink: disable=
 IRQs
> > > > for netlink_lock_table()") in netlink_lock_table()
> > > >
> > > > This patch adds IRQ safety to netlink_set_err() and __netlink_diag_=
dump()
> > > > which were not covered by cited commit.
> > > >
> > > > [1]
> > > >
> > > > WARNING: possible irq lock inversion dependency detected
> > > > 6.4.0-rc6-syzkaller-00240-g4e9f0ec38852 #0 Not tainted
> > > >
> > > > syz-executor.2/23011 just changed the state of lock:
> > > > ffffffff8e1a7a58 (nl_table_lock){.+.?}-{2:2}, at: netlink_set_err+0=
x2e/0x3a0 net/netlink/af_netlink.c:1612
> > > > but this lock was taken by another, SOFTIRQ-safe lock in the past:
> > > > (&local->queue_stop_reason_lock){..-.}-{2:2}
> > > >
> > > > and interrupts could create inverse lock ordering between them.
> > > >
> > > > other info that might help us debug this:
> > > > Possible interrupt unsafe locking scenario:
> > > >
> > > >       CPU0                    CPU1
> > > >       ----                    ----
> > > >  lock(nl_table_lock);
> > > >                               local_irq_disable();
> > > >                               lock(&local->queue_stop_reason_lock);
> > > >                               lock(nl_table_lock);
> > > >  <Interrupt>
> > > >    lock(&local->queue_stop_reason_lock);
> > > >
> > > > *** DEADLOCK ***
> > > >
> > > > Fixes: 1d482e666b8e ("netlink: disable IRQs for netlink_lock_table(=
)")
> > >
> > > I don't think that this "fixes" tag is correct. The referenced commit
> > > is a fix to the same issue on a different codepath, not the one who
> > > actually introduced the issue.
> > >
> > > The code itself looks fine to me.
> >
> > Note that the 1d482e666b8e had no Fixes: tag, otherwise I would have ta=
ken it.
> >
> > I presume that it would make no sense to backport my patch on stable br=
anches
> > if the cited commit was not backported yet.
>
> I'd tend to even say it doesn't make sense to backport this at all, it's
> very unlikely to happen in practice since that code path ...
>
> > Now, if you think we can be more precise, I will let Johannes do the
> > archeology in ieee80211 code.
>
> I first thought that'd be commit d4fa14cd62bd ("mac80211: use
> ieee80211_free_txskb in a few more places") then, but that didn't call
> to netlink yet ... so commit 8a2fbedcdc9b ("mac80211: combine
> status/drop reporting"), but that's almost as old (and really old too,
> kernel 3.8).
>
> But again, I'm not sure it's worth worrying about ... Actually I'm
> pretty sure it's _not_ worth worrying about :)

OK, should we revert your patch then ?

I am slightly confused, you are saying this bug is not worth fixing ?

This will prevent syzbot from discovering other bugs, this is your call.

