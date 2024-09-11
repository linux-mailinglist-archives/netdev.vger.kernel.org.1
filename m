Return-Path: <netdev+bounces-127230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64137974AE3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886F61C23C2C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 07:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489913CFA1;
	Wed, 11 Sep 2024 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hxk5H/Gr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E915137772
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038122; cv=none; b=jM1G2KQ7siPtpvLQMQiKGtbv9dmV3wuchc4MGEVpLDl9AG/mPnV10O5ku34+3FhxInI+OJL2/U6uKU4M7WykEboQDuapTYV8XqMkZjUFVEsnra60I7v9DHzcFAlJW63MKo7Y/J2E+zqzIRZe/La2rybAIX5XhNnv/g2/djJenMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038122; c=relaxed/simple;
	bh=pz7krZ8wMSk7Ke0O+ezk2e0YvBH+msboaVIphWHVHpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI/CZLLi2jMGahL1CaHRExhm/PwyEI5YLO9kvrmfpGfRs3w3USurDHt80DTVXg5OIEl9kZqDvga4UZyv8VoBX5fI6D0UXNRBXxpwzJIPTTtxSwdtRdNOcCwyWPgxFw4Zw2X1mXrdVxGXpfTTPnbagY2LhPna9D2jijAgeoLyAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hxk5H/Gr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E3743F637
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726038117;
	bh=2MDAdU1s0LLARJ1hj7uSFye2HOBfsOuBYx1euCTHn94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hxk5H/Grb5UQvScJmXFLw6n6+6qeDjCBOufXH6auZrXK6eNC8ORzj9ah3b5xbD6jL
	 BA5tDFf5sxyFpXLB39cKLg3oDkbov1AvnDAiZ+pItiC/DI/IJ2NH/jAINAOI2H9fvV
	 sjb/dHavmkSWpGgKNCQDLK8o1ys1XOzb2ZuHqtLt98hTGdZYdTnpnmC4r4yX8LlJRh
	 xDA9pAmjnKEEk7zBgPUXSr0jv5Ylv1wHDt0CogK8meu1dBUO8WakaYQ7jCWwsKrsoj
	 nidltxk0qYBPskuaEUU4balYCspzc052wONdWNOGf9SYfWGaInHkhvozzIw5wc2P8m
	 kPhNuplC/6zPQ==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb33e6299so23316965e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726038116; x=1726642916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MDAdU1s0LLARJ1hj7uSFye2HOBfsOuBYx1euCTHn94=;
        b=t4EQuH4KVhu2kR3XFaoZitiEFQFdyD9FDcPOJ3vAGmKNtjtzjTM8/Rz7pqzWIt1uRO
         7l8V6LrpTPeRq+SQ2sanUefkXDxFbYWG5w9tOIYb54fXtAX49KUIFi/pBqZnkfrhapfG
         DyfWiFyh/+99cJT/y8/sk47sp/vFNBtWkWFimuStTZVlUQjoi8jQgMC1+Qrlby4Mclfc
         ldd9Jl0kRcSLkFfGL8XhLwTWkREGWhAuYHcypeQy4ZqaiThkdOHuLgtEpfT6hOl58UoX
         nWv5RXM2CgmIuvMHu+tb4GKESePZJYbqh8XxnWCIo1G9y7/g/6LJeBtTxJoTAYXwzHHY
         P2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ0/uy7IWHbpLP1SoUp25srlriG5nN7h8L4oY7v29ACrXIRN7R1UasNy+HlJyc1S2+fT4zJIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThY3eh34DqyoaSJloLb98oO+GHIYW3WvAGLcDDaqGYnpsCYgl
	AwKbRPobUIIMwYjnwTM0f9Pr7vG0aJRTbK2OrU8P+joGJ9JfuyJbm3VA10giLWiExRZhjifigxw
	1Vj4GP5pcSeDfv/I/ECSJnGdsxgebVq1P/aTkHMizRvjDtaW2qnTetYFPCGlZeSYNAIMlw9fMqh
	JkBb0VphTGBHYvxfuzmL2rl1JikU2WpxXVjGSvD1oRaQoJ
X-Received: by 2002:a05:600c:1c10:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42cbdb0c782mr44486435e9.13.1726038116492;
        Wed, 11 Sep 2024 00:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH12JTQ1rISeGOg4bZB9Lr9U/QDrVPYDIFdxnWBB8u5zG2QSONx1ZcSzOWwG1KCjkMNASPelQQrLxdZe4rpGBU=
X-Received: by 2002:a05:600c:1c10:b0:42c:bdb0:c61e with SMTP id
 5b1f17b1804b1-42cbdb0c782mr44486125e9.13.1726038115991; Wed, 11 Sep 2024
 00:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906083539.154019-1-en-wei.wu@canonical.com>
 <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com> <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
 <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com>
In-Reply-To: <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 11 Sep 2024 15:01:45 +0800
Message-ID: <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com, 
	kai.heng.feng@canonical.com, me@lagy.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> What is the link partner in your case?
My link partner is FS S3900-48T4S switch.

>  If you put a simple switch in between, does this help?
I just put a simple D-link switch in between with the original kernel,
the issue remains (re-plugging it after 3 seconds).

> It makes more the impression that after 3s of link-down the chip (PHY?)
> transitions to a mode where it doesn't wake up after re-plugging the cabl=
e.
I've done a ftrace on the r8169.ko and the phy driver (realtek.ko),
and I found that the phy did wake up:

   kworker/u40:4-267   [003]   297.026314: funcgraph_entry:
       |      phy_link_change() {
3533    kworker/u40:4-267   [003]   297.026315: funcgraph_entry:
 6.704 us   |        netif_carrier_on();
3534    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
            |        r8169_phylink_handler() {
3535    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
 0.257 us   |          rtl_link_chg_patch();
3536    kworker/u40:4-267   [003]   297.026324: funcgraph_entry:
 4.026 us   |          netif_tx_wake_queue();
3537    kworker/u40:4-267   [003]   297.026328: funcgraph_entry:
            |          phy_print_status() {
3538    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
 0.245 us   |            phy_duplex_to_str();
3539    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
 0.240 us   |            phy_speed_to_str();
3540    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
+ 12.798 us  |            netdev_info();
3541    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
+ 14.385 us  |          }
3542    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
+ 21.217 us  |        }
3543    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
+ 28.785 us  |      }

So I doubt that the issue isn't necessarily related to the ALDPS,
because the PHY seems to have woken up.

After looking at the reset function (plus the TX queue issue
previously reported by the user) , I'm wondering if the problem is
related to DMA:
static void rtl_reset_work(struct rtl8169_private *tp) {
    ....
    for (i =3D 0; i < NUM_RX_DESC; i++)
         rtl8169_mark_to_asic(tp->RxDescArray + i);
    ....
}

On Wed, 11 Sept 2024 at 01:06, Heiner Kallweit <hkallweit1@gmail.com> wrote=
:
>
> On 09.09.2024 07:25, En-Wei WU wrote:
> > Hi Heiner,
> >
> > Thank you for the quick response.
> >
> > On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wr=
ote:
> >>
> >> On 06.09.2024 10:35, En-Wei Wu wrote:
> >>> The commit 621735f59064 ("r8169: fix rare issue with broken rx after
> >>> link-down on RTL8125") set a reset work for RTL8125 in
> >>> r8169_phylink_handler() to avoid the MAC from locking up, this
> >>> makes the connection broken after unplugging then re-plugging the
> >>> Ethernet cable.
> >>>
> >>> This is because the commit mistakenly put the reset work in the
> >>> link-down path rather than the link-up path (The commit message says
> >>> it should be put in the link-up path).
> >>>
> >> That's not what the commit message is saying. It says vendor driver
> >> r8125 does it in the link-up path.
> >> I moved it intentionally to the link-down path, because traffic may
> >> be flowing already after link-up.
> >>
> >>> Moving the reset work from the link-down path to the link-up path fix=
es
> >>> the issue. Also, remove the unnecessary enum member.
> >>>
> >> The user who reported the issue at that time confirmed that the origin=
al
> >> change fixed the issue for him.
> >> Can you explain, from the NICs perspective, what exactly the differenc=
e
> >> is when doing the reset after link-up?
> >> Including an explanation how the original change suppresses the link-u=
p
> >> interrupt. And why that's not the case when doing the reset after link=
-up.
> >
> > The host-plug test under original change does have the link-up
> > interrupt and r8169_phylink_handler() called. There is not much clue
> > why calling reset in link-down path doesn't work but in link-up does.
> >
> > After several new tests, I found that with the original change, the
> > link won't break if I unplug and then plug the cable within about 3
> > seconds. On the other hand, the connections always break if I re-plug
> > the cable after a few seconds.
> >
> Interesting finding. 3 seconds sounds like it's unrelated to runtime pm,
> because this has a 10s delay before the chip is transitioned to D3hot.
> It makes more the impression that after 3s of link-down the chip (PHY?)
> transitions to a mode where it doesn't wake up after re-plugging the cabl=
e.
>
> Just a wild guess: It may be some feature like ALDPS (advanced link-down
> power saving). Depending on the link partner this may result in not wakin=
g
> up again, namely if the link partner uses ALDPS too.
> What is the link partner in your case? If you put a simple switch in betw=
een,
> does this help?
>
> In the RTL8211F datasheet I found the following:
>
> Link Down Power Saving Mode.
> 1: Reflects local device entered Link Down Power Saving Mode,
> i.e., cable not plugged in (reflected after 3 sec)
> 0: With cable plugged in
>
> This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism with th=
e
> integrated PHY of RTL8125. The 3s delay described there perfectly matches
> your finding.
>
> > With this new patch (reset in link-up path), both of the tests work
> > without any error.
> >
> >>
> >> I simply want to be convinced enough that your change doesn't break
> >> behavior for other users.
> >>
> >>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link=
-down on RTL8125")
> >>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> >>> ---
> >>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
> >>>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/=
ethernet/realtek/r8169_main.c
> >>> index 3507c2e28110..632e661fc74b 100644
> >>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
> >>>  enum rtl_flag {
> >>>       RTL_FLAG_TASK_ENABLED =3D 0,
> >>>       RTL_FLAG_TASK_RESET_PENDING,
> >>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
> >>>       RTL_FLAG_TASK_TX_TIMEOUT,
> >>>       RTL_FLAG_MAX
> >>>  };
> >>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
> >>>  reset:
> >>>               rtl_reset_work(tp);
> >>>               netif_wake_queue(tp->dev);
> >>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE=
, tp->wk.flags)) {
> >>> -             rtl_reset_work(tp);
> >>>       }
> >>>  out_unlock:
> >>>       rtnl_unlock();
> >>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_=
device *ndev)
> >>>       if (netif_carrier_ok(ndev)) {
> >>>               rtl_link_chg_patch(tp);
> >>>               pm_request_resume(d);
> >>> -             netif_wake_queue(tp->dev);
> >>> -     } else {
> >>> +
> >>>               /* In few cases rx is broken after link-down otherwise =
*/
> >>>               if (rtl_is_8125(tp))
> >>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QU=
EUE_WAKE);
> >>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDI=
NG);
> >>> +             else
> >>> +                     netif_wake_queue(tp->dev);
> >>
> >> This call to netif_wake_queue() isn't needed any longer, it was introd=
uced with
> >> the original change only.
> >>
> >>> +     } else {
> >>>               pm_runtime_idle(d);
> >>>       }
> >>>
> >>
> >
> > CC. Martin Kj=C3=A6r J=C3=B8rgensen  <me@lagy.org>, could you kindly te=
st if
> > this new patch works on your environment? Thanks!
> >
> > En-Wei,
> > Best regards.
>

