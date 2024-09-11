Return-Path: <netdev+bounces-127323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A23974FCA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF701F232DF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D741183CDC;
	Wed, 11 Sep 2024 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="crLQSR+R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058A39AEB
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051130; cv=none; b=MpNgFZ2VKrG27l5ROpk/cNtuMJbC980iLiNKxXwCB4obCoEuevoaAWLguumAnIEEQ2/I5+4FHVmPIB9HdKogkqU/pqWpdH1W747c3F9yt8bDlaqZAmh7oszYEUlJAt21WMBrRuIuK5y34B02/qm0LKTMnO/M6PmScwlWrrp1Pe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051130; c=relaxed/simple;
	bh=MDv+n+5JOFt/G2Z2qjiEGomhxVYycOt0ZBpuhZxVzBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMfECzxNsUOhOmBY46MphEHTSUQHSQI9lWhLxg9J4eBcbtm0Jyrum6BwTScbH7Kj7DhElnlblIopWui+56ox6jylQEFo3k7OnKiwAmo28fYmb8YYb96w2exNwEjtlZAnskk7Ufu16xuLvzTfOpJgpuSfGNxLmjSPL6hMHzeEb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=crLQSR+R; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1F8063F5BC
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726051125;
	bh=XZ3NpBRuI85Nx16fH1QRYUdTD1iasNHxgIiJlTjULR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=crLQSR+R/ri10FLJdsGSg1BRC4xD2d4+4zK71bvk0tw+sZh5dhE97lLUKOW0ey3Jo
	 8SsZRo/hbXONOnWjczmAYV5jL/HhX9V7yJ3kLlremGKYP35soNF1quCFpfsQ4Hme8m
	 q+5cVRRdxRw7RrJQ1mBmuVw1BXzddQgJ7XLF2dWAP6KjDJXcCQECMumYnbPhtJACzH
	 4kzWS9PPobGFuTcd8xg3Y/epoEQHL/jcclSpSAwY/72R3d9uPt5YkhZf8E+DXA6cfB
	 f7T+D/gB5H7X6nvbc4h8HU2KKJMJFR7CSxpBgxAH1e9Sucu+czvbXqKnpGZXSIcOLi
	 W+4accTNIgwcA==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c44e58a9so3392084f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051124; x=1726655924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ3NpBRuI85Nx16fH1QRYUdTD1iasNHxgIiJlTjULR4=;
        b=SVRQlr9h/dsfY31O6y9nxv2sKV4M2R3+3YSNxw0mT0/6r+YnI8Fq5aBY/5qcqW5Gbj
         MAV0AEtuhkllidCLHGF4YFvh7dgHo/q6LeCk+7qJXvAjk2iAbr3ImIQiGNkNO00v08SN
         t0gBoNAhY2krtuGi+kDUCngpiOnlIvvUKYdIU51Q2+RZMalI2FfnNJ+nfI+x/nGDoqbB
         zF0Cjfc15wlLjmblSzk2ufCcmhoel+600ovuogg3gzT6Q4YJpX5pTEH1SLzkwC4GAPHp
         IXVpQjE6vAEvXO2Wnj9jhI1oTGNUGVfq7SzYdPtBgXibzN/dwjlVM+0ZLNYpxAuiA9Ri
         SxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcKA+hxI/jnVWRKKbOPMNJJSzkPTbqQA881sVgG2G+gQRY9uCXnX2iBljxdPVesFjWvHmkRGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXHc6JNjQqdEa/4esGK5yOM66HrHRlO0tBQJgEw6ywMf1OdKO
	Gg11TE9GNIwalYJs8wsriJg2EqRTsnm+whAnoMkLeC/TkHSmUzP1zjLP8/cYXYtSFpvD8YaSp4T
	P9PuPuzZ/qRe97YY9MCKz+PVgnwiiNdZWmkKOA7sGWzcCG34M7vCNGQ2peYp/QPqybAGXEnz8Hb
	TJGdhc9kVtDP86g5nzcJnQuFnKBBU9PSBjZKapJy3kXJ9l
X-Received: by 2002:a5d:5d84:0:b0:374:c84d:1cfe with SMTP id ffacd0b85a97d-3789f86f674mr6210298f8f.21.1726051124232;
        Wed, 11 Sep 2024 03:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRSJj9yuS657ZVmDugU201ImM20XuALCk/aw2SV3c7fIUGHktt4avj8J3R3N4f1ZVQRj306wDMQk4AeUoW4+s=
X-Received: by 2002:a5d:5d84:0:b0:374:c84d:1cfe with SMTP id
 ffacd0b85a97d-3789f86f674mr6210273f8f.21.1726051123596; Wed, 11 Sep 2024
 03:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906083539.154019-1-en-wei.wu@canonical.com>
 <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com> <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
 <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com> <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
 <ed753ef5-3913-413a-ad46-2abe742489b2@gmail.com>
In-Reply-To: <ed753ef5-3913-413a-ad46-2abe742489b2@gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 11 Sep 2024 18:38:32 +0800
Message-ID: <CAMqyJG1Z13Xkw28jrKKhthJphjBBxmEpsKTVPmuU0auHHz-fxQ@mail.gmail.com>
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com, 
	kai.heng.feng@canonical.com, me@lagy.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Also wrt ALDPS: Do you have the firmware for the NIC loaded?
The firmware is rtl8125b-2_0.0.2 07/13/20

> Just to be sure. Can you test with the following?
Your patch works for our machine. Seems like the root cause is indeed the A=
LDPS.

On Wed, 11 Sept 2024 at 17:16, Heiner Kallweit <hkallweit1@gmail.com> wrote=
:
>
> On 11.09.2024 09:01, En-Wei WU wrote:
> >> What is the link partner in your case?
> > My link partner is FS S3900-48T4S switch.
> >
> >>  If you put a simple switch in between, does this help?
> > I just put a simple D-link switch in between with the original kernel,
> > the issue remains (re-plugging it after 3 seconds).
> >
> >> It makes more the impression that after 3s of link-down the chip (PHY?=
)
> >> transitions to a mode where it doesn't wake up after re-plugging the c=
able.
> > I've done a ftrace on the r8169.ko and the phy driver (realtek.ko),
> > and I found that the phy did wake up:
> >
> >    kworker/u40:4-267   [003]   297.026314: funcgraph_entry:
> >        |      phy_link_change() {
> > 3533    kworker/u40:4-267   [003]   297.026315: funcgraph_entry:
> >  6.704 us   |        netif_carrier_on();
> > 3534    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
> >             |        r8169_phylink_handler() {
> > 3535    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
> >  0.257 us   |          rtl_link_chg_patch();
> > 3536    kworker/u40:4-267   [003]   297.026324: funcgraph_entry:
> >  4.026 us   |          netif_tx_wake_queue();
> > 3537    kworker/u40:4-267   [003]   297.026328: funcgraph_entry:
> >             |          phy_print_status() {
> > 3538    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> >  0.245 us   |            phy_duplex_to_str();
> > 3539    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> >  0.240 us   |            phy_speed_to_str();
> > 3540    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> > + 12.798 us  |            netdev_info();
> > 3541    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> > + 14.385 us  |          }
> > 3542    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> > + 21.217 us  |        }
> > 3543    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> > + 28.785 us  |      }
> >
> > So I doubt that the issue isn't necessarily related to the ALDPS,
> > because the PHY seems to have woken up.
> >
> > After looking at the reset function (plus the TX queue issue
> > previously reported by the user) , I'm wondering if the problem is
> > related to DMA:
> > static void rtl_reset_work(struct rtl8169_private *tp) {
> >     ....
> >     for (i =3D 0; i < NUM_RX_DESC; i++)
> >          rtl8169_mark_to_asic(tp->RxDescArray + i);
> >     ....
> > }
> >
> > On Wed, 11 Sept 2024 at 01:06, Heiner Kallweit <hkallweit1@gmail.com> w=
rote:
> >>
> >> On 09.09.2024 07:25, En-Wei WU wrote:
> >>> Hi Heiner,
> >>>
> >>> Thank you for the quick response.
> >>>
> >>> On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> =
wrote:
> >>>>
> >>>> On 06.09.2024 10:35, En-Wei Wu wrote:
> >>>>> The commit 621735f59064 ("r8169: fix rare issue with broken rx afte=
r
> >>>>> link-down on RTL8125") set a reset work for RTL8125 in
> >>>>> r8169_phylink_handler() to avoid the MAC from locking up, this
> >>>>> makes the connection broken after unplugging then re-plugging the
> >>>>> Ethernet cable.
> >>>>>
> >>>>> This is because the commit mistakenly put the reset work in the
> >>>>> link-down path rather than the link-up path (The commit message say=
s
> >>>>> it should be put in the link-up path).
> >>>>>
> >>>> That's not what the commit message is saying. It says vendor driver
> >>>> r8125 does it in the link-up path.
> >>>> I moved it intentionally to the link-down path, because traffic may
> >>>> be flowing already after link-up.
> >>>>
> >>>>> Moving the reset work from the link-down path to the link-up path f=
ixes
> >>>>> the issue. Also, remove the unnecessary enum member.
> >>>>>
> >>>> The user who reported the issue at that time confirmed that the orig=
inal
> >>>> change fixed the issue for him.
> >>>> Can you explain, from the NICs perspective, what exactly the differe=
nce
> >>>> is when doing the reset after link-up?
> >>>> Including an explanation how the original change suppresses the link=
-up
> >>>> interrupt. And why that's not the case when doing the reset after li=
nk-up.
> >>>
> >>> The host-plug test under original change does have the link-up
> >>> interrupt and r8169_phylink_handler() called. There is not much clue
> >>> why calling reset in link-down path doesn't work but in link-up does.
> >>>
> >>> After several new tests, I found that with the original change, the
> >>> link won't break if I unplug and then plug the cable within about 3
> >>> seconds. On the other hand, the connections always break if I re-plug
> >>> the cable after a few seconds.
> >>>
> >> Interesting finding. 3 seconds sounds like it's unrelated to runtime p=
m,
> >> because this has a 10s delay before the chip is transitioned to D3hot.
> >> It makes more the impression that after 3s of link-down the chip (PHY?=
)
> >> transitions to a mode where it doesn't wake up after re-plugging the c=
able.
> >>
> >> Just a wild guess: It may be some feature like ALDPS (advanced link-do=
wn
> >> power saving). Depending on the link partner this may result in not wa=
king
> >> up again, namely if the link partner uses ALDPS too.
> >> What is the link partner in your case? If you put a simple switch in b=
etween,
> >> does this help?
> >>
> >> In the RTL8211F datasheet I found the following:
> >>
> >> Link Down Power Saving Mode.
> >> 1: Reflects local device entered Link Down Power Saving Mode,
> >> i.e., cable not plugged in (reflected after 3 sec)
> >> 0: With cable plugged in
> >>
> >> This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism with=
 the
> >> integrated PHY of RTL8125. The 3s delay described there perfectly matc=
hes
> >> your finding.
> >>
> >>> With this new patch (reset in link-up path), both of the tests work
> >>> without any error.
> >>>
> >>>>
> >>>> I simply want to be convinced enough that your change doesn't break
> >>>> behavior for other users.
> >>>>
> >>>>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after li=
nk-down on RTL8125")
> >>>>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> >>>>> ---
> >>>>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
> >>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/ne=
t/ethernet/realtek/r8169_main.c
> >>>>> index 3507c2e28110..632e661fc74b 100644
> >>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>>>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
> >>>>>  enum rtl_flag {
> >>>>>       RTL_FLAG_TASK_ENABLED =3D 0,
> >>>>>       RTL_FLAG_TASK_RESET_PENDING,
> >>>>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
> >>>>>       RTL_FLAG_TASK_TX_TIMEOUT,
> >>>>>       RTL_FLAG_MAX
> >>>>>  };
> >>>>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work=
)
> >>>>>  reset:
> >>>>>               rtl_reset_work(tp);
> >>>>>               netif_wake_queue(tp->dev);
> >>>>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WA=
KE, tp->wk.flags)) {
> >>>>> -             rtl_reset_work(tp);
> >>>>>       }
> >>>>>  out_unlock:
> >>>>>       rtnl_unlock();
> >>>>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct ne=
t_device *ndev)
> >>>>>       if (netif_carrier_ok(ndev)) {
> >>>>>               rtl_link_chg_patch(tp);
> >>>>>               pm_request_resume(d);
> >>>>> -             netif_wake_queue(tp->dev);
> >>>>> -     } else {
> >>>>> +
> >>>>>               /* In few cases rx is broken after link-down otherwis=
e */
> >>>>>               if (rtl_is_8125(tp))
> >>>>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_=
QUEUE_WAKE);
> >>>>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PEN=
DING);
> >>>>> +             else
> >>>>> +                     netif_wake_queue(tp->dev);
> >>>>
> >>>> This call to netif_wake_queue() isn't needed any longer, it was intr=
oduced with
> >>>> the original change only.
> >>>>
> >>>>> +     } else {
> >>>>>               pm_runtime_idle(d);
> >>>>>       }
> >>>>>
> >>>>
> >>>
> >>> CC. Martin Kj=C3=A6r J=C3=B8rgensen  <me@lagy.org>, could you kindly =
test if
> >>> this new patch works on your environment? Thanks!
> >>>
> >>> En-Wei,
> >>> Best regards.
> >>
>
> Just to be sure. Can you test with the following?
>
>
> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/ne=
t/ethernet/realtek/r8169_phy_config.c
> index 2c8845e08..cf29b1208 100644
> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> @@ -1060,6 +1060,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169=
_private *tp,
>         phy_modify_paged(phydev, 0xa86, 0x15, 0x0001, 0x0000);
>         rtl8168g_enable_gphy_10m(phydev);
>
> +       rtl8168g_disable_aldps(phydev);
>         rtl8125a_config_eee_phy(phydev);
>  }
>
> @@ -1099,6 +1100,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_p=
rivate *tp,
>         phy_modify_paged(phydev, 0xbf8, 0x12, 0xe000, 0xa000);
>
>         rtl8125_legacy_force_mode(phydev);
> +       rtl8168g_disable_aldps(phydev);
>         rtl8125b_config_eee_phy(phydev);
>  }
>
> --
> 2.46.0
>
>

