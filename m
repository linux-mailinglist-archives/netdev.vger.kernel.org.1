Return-Path: <netdev+bounces-127416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B69754FA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DE5B25390
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B4D19AA75;
	Wed, 11 Sep 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SHcmv3DP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C818592F
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063662; cv=none; b=lFqn5iHQE2MRjitWbhIpAnsd4uxsJvRtHaEfKoSZY5xcajxVkhDwUbGUI/xVXXospZrNiuV2WPiWWUqGMSadIeuXHCFvT6GnDdmDC3bw9sN0xwrnoiiobCVq79cWVTLtegpNGPCXneyyhXM5mMoLYtJ24Xc4eUt5aHH+Rkvj+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063662; c=relaxed/simple;
	bh=+ftgcK4f2/to4uKrWv0xYCn5/Z7eucHBzJwmljvUKok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FND7QHUKo2Xb5aDhhT89x+SpMyM+n6PIdhezKymuYqx3JYhCSlcoirgXb+ePoDMYT0ag7WjVmwl7VTX3Qj62DP0lTCZ8F2CNLR4+8Rpq75OjgrWQ80Ru/1Oqk7FJJmOChMsXbsfAlu6DpGS1hzTXvNUr5dzzhVve3oyg9tWRF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SHcmv3DP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AC5E53F5B0
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726063656;
	bh=p9rxqlWWT14NUIS+09dJZ0yxmRTciNgyh/Jd1Ehnhvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=SHcmv3DPJWCWRFHSEPSQ6rYD9beXjT2PjcBB/c3yf/WcjTD2cl2s+Ubv0Lw/EfV8n
	 r3ufKfZDNHhwt4mqXSVAK6raTx0FoGWx948RUlOdb/phl2dvwJ/MBNA6ouM4ZsP6Li
	 hTwDSIi5SdY1XFX3kDWCcWqzn5PmvJQus+M6VVQBPeI1onKn6MRDwokeaq91oxt6H7
	 /o85+M6i42cD7HZjZmoyYOZ+D2qse+d7jnMXWr7csE3pHJuNGjkAchDNo4TC/6HnHk
	 s0+1t9YyVXjdpL+dhJ2pxnfFXgKOfKOFzu3xf25mq8gAbmhts/r7+X2vUUZKGPIC6S
	 +cEkFVO2QEGQQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c54e188dso518450f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 07:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063656; x=1726668456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9rxqlWWT14NUIS+09dJZ0yxmRTciNgyh/Jd1Ehnhvs=;
        b=q/Nzez8D3oW7Lm9T1O7kS0KtfNU/sJlUzcTPDsPi7ruQCjsod2TAt+xk617IkL1Uvl
         fS6YK8MKcDqeRdk7pZj3rcHcUTjBFx15c+YdrLqTvXu1lTNLZUJwH7ajeWKyG/uGdSxo
         Knv9+BPKAh9V5IS97k5kNN4AIF1UW0DWJDfuQ0eeHPbq+eRxmHJTTlSVlM6sncBpiul2
         TagpX1YAmnPH86aUzRqUFb44Ehq33qFhVeACFbMlzM0tt6hatkAic1Je+regeQCd5u89
         exxpXAsMjrfPsVlzXFK6Z3DLn+CJ5IJXl2G8LN45jU7WPAHNwCQO6UlkCxpuymrnjW3U
         jp6g==
X-Forwarded-Encrypted: i=1; AJvYcCVpr2jipjVy0edOEoZi0lXJ5RhdO9NM94sOUUro68VeEsZ7A2azFW1kKuEoLgwCLx61Ar3pvnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcCmTyncoS5y+t7M/2j9UxaZtMYXEc5CjSsNTIPkX1nKL4XcY
	prHoegkXOIxki3ErtXw6eNBj4mLYXzTc3WKN9Ku59LJkqhlTKZIq4251VuaGmuf/D+6NOzLrDBB
	Xk7OMJw5GgJTlIzIxou5pMZ4i/DnC1kQSMqcznZX+neSADnFqtvZhpPoByX8GQuuJ8mD9pV9+Qz
	9aQX47fQRocNz9e71fGeA0j47msDxMmABBfow+qoztDA4n
X-Received: by 2002:a05:6000:1961:b0:374:c878:4519 with SMTP id ffacd0b85a97d-378a89fd429mr4082080f8f.3.1726063656018;
        Wed, 11 Sep 2024 07:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk5ibF+cE3CpFPavweiRicJEmiK24xmMX0WQixiJHD123vmnWtqTTch4Cn0+inoB5F6wo7AYvMdxX2EMijBh8=
X-Received: by 2002:a05:6000:1961:b0:374:c878:4519 with SMTP id
 ffacd0b85a97d-378a89fd429mr4082055f8f.3.1726063655347; Wed, 11 Sep 2024
 07:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906083539.154019-1-en-wei.wu@canonical.com>
 <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com> <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
 <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com> <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
 <ed753ef5-3913-413a-ad46-2abe742489b2@gmail.com> <CAMqyJG1Z13Xkw28jrKKhthJphjBBxmEpsKTVPmuU0auHHz-fxQ@mail.gmail.com>
 <166d0df9-e06e-420e-a074-c33abd422add@gmail.com>
In-Reply-To: <166d0df9-e06e-420e-a074-c33abd422add@gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Wed, 11 Sep 2024 22:07:23 +0800
Message-ID: <CAMqyJG1YJjRKGVgWzp4MJRrCP__VUc_k7ORa=2RMdr4TU6N9mg@mail.gmail.com>
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com, 
	kai.heng.feng@canonical.com, me@lagy.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your great support!


On Wed, 11 Sept 2024 at 19:58, Heiner Kallweit <hkallweit1@gmail.com> wrote=
:
>
> On 11.09.2024 12:38, En-Wei WU wrote:
> >> Also wrt ALDPS: Do you have the firmware for the NIC loaded?
> > The firmware is rtl8125b-2_0.0.2 07/13/20
> >
> Thanks. Question was because I found an older statement from Realtek
> stating that ALDPS requires firmware to work correctly.
>
> >> Just to be sure. Can you test with the following?
> > Your patch works for our machine. Seems like the root cause is indeed t=
he ALDPS.
> >
> Great! Not sure what's going on, maybe a silicon bug. ALDPS may e.g. stop=
 some
> clock and hw misses to re-enable it on link-up. Then I will submit the ch=
ange
> to disable ALDPS. Later we maybe can remove the reset on link-down.
>
> Not having ALDPS shouldn't be too much of an issue. Runtime PM (if enable=
d)
> will put the NIC to D3hot after 10s anyway.
>
> > On Wed, 11 Sept 2024 at 17:16, Heiner Kallweit <hkallweit1@gmail.com> w=
rote:
> >>
> >> On 11.09.2024 09:01, En-Wei WU wrote:
> >>>> What is the link partner in your case?
> >>> My link partner is FS S3900-48T4S switch.
> >>>
> >>>>  If you put a simple switch in between, does this help?
> >>> I just put a simple D-link switch in between with the original kernel=
,
> >>> the issue remains (re-plugging it after 3 seconds).
> >>>
> >>>> It makes more the impression that after 3s of link-down the chip (PH=
Y?)
> >>>> transitions to a mode where it doesn't wake up after re-plugging the=
 cable.
> >>> I've done a ftrace on the r8169.ko and the phy driver (realtek.ko),
> >>> and I found that the phy did wake up:
> >>>
> >>>    kworker/u40:4-267   [003]   297.026314: funcgraph_entry:
> >>>        |      phy_link_change() {
> >>> 3533    kworker/u40:4-267   [003]   297.026315: funcgraph_entry:
> >>>  6.704 us   |        netif_carrier_on();
> >>> 3534    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
> >>>             |        r8169_phylink_handler() {
> >>> 3535    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
> >>>  0.257 us   |          rtl_link_chg_patch();
> >>> 3536    kworker/u40:4-267   [003]   297.026324: funcgraph_entry:
> >>>  4.026 us   |          netif_tx_wake_queue();
> >>> 3537    kworker/u40:4-267   [003]   297.026328: funcgraph_entry:
> >>>             |          phy_print_status() {
> >>> 3538    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> >>>  0.245 us   |            phy_duplex_to_str();
> >>> 3539    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> >>>  0.240 us   |            phy_speed_to_str();
> >>> 3540    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> >>> + 12.798 us  |            netdev_info();
> >>> 3541    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> >>> + 14.385 us  |          }
> >>> 3542    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> >>> + 21.217 us  |        }
> >>> 3543    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> >>> + 28.785 us  |      }
> >>>
> >>> So I doubt that the issue isn't necessarily related to the ALDPS,
> >>> because the PHY seems to have woken up.
> >>>
> >>> After looking at the reset function (plus the TX queue issue
> >>> previously reported by the user) , I'm wondering if the problem is
> >>> related to DMA:
> >>> static void rtl_reset_work(struct rtl8169_private *tp) {
> >>>     ....
> >>>     for (i =3D 0; i < NUM_RX_DESC; i++)
> >>>          rtl8169_mark_to_asic(tp->RxDescArray + i);
> >>>     ....
> >>> }
> >>>
> >>> On Wed, 11 Sept 2024 at 01:06, Heiner Kallweit <hkallweit1@gmail.com>=
 wrote:
> >>>>
> >>>> On 09.09.2024 07:25, En-Wei WU wrote:
> >>>>> Hi Heiner,
> >>>>>
> >>>>> Thank you for the quick response.
> >>>>>
> >>>>> On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com=
> wrote:
> >>>>>>
> >>>>>> On 06.09.2024 10:35, En-Wei Wu wrote:
> >>>>>>> The commit 621735f59064 ("r8169: fix rare issue with broken rx af=
ter
> >>>>>>> link-down on RTL8125") set a reset work for RTL8125 in
> >>>>>>> r8169_phylink_handler() to avoid the MAC from locking up, this
> >>>>>>> makes the connection broken after unplugging then re-plugging the
> >>>>>>> Ethernet cable.
> >>>>>>>
> >>>>>>> This is because the commit mistakenly put the reset work in the
> >>>>>>> link-down path rather than the link-up path (The commit message s=
ays
> >>>>>>> it should be put in the link-up path).
> >>>>>>>
> >>>>>> That's not what the commit message is saying. It says vendor drive=
r
> >>>>>> r8125 does it in the link-up path.
> >>>>>> I moved it intentionally to the link-down path, because traffic ma=
y
> >>>>>> be flowing already after link-up.
> >>>>>>
> >>>>>>> Moving the reset work from the link-down path to the link-up path=
 fixes
> >>>>>>> the issue. Also, remove the unnecessary enum member.
> >>>>>>>
> >>>>>> The user who reported the issue at that time confirmed that the or=
iginal
> >>>>>> change fixed the issue for him.
> >>>>>> Can you explain, from the NICs perspective, what exactly the diffe=
rence
> >>>>>> is when doing the reset after link-up?
> >>>>>> Including an explanation how the original change suppresses the li=
nk-up
> >>>>>> interrupt. And why that's not the case when doing the reset after =
link-up.
> >>>>>
> >>>>> The host-plug test under original change does have the link-up
> >>>>> interrupt and r8169_phylink_handler() called. There is not much clu=
e
> >>>>> why calling reset in link-down path doesn't work but in link-up doe=
s.
> >>>>>
> >>>>> After several new tests, I found that with the original change, the
> >>>>> link won't break if I unplug and then plug the cable within about 3
> >>>>> seconds. On the other hand, the connections always break if I re-pl=
ug
> >>>>> the cable after a few seconds.
> >>>>>
> >>>> Interesting finding. 3 seconds sounds like it's unrelated to runtime=
 pm,
> >>>> because this has a 10s delay before the chip is transitioned to D3ho=
t.
> >>>> It makes more the impression that after 3s of link-down the chip (PH=
Y?)
> >>>> transitions to a mode where it doesn't wake up after re-plugging the=
 cable.
> >>>>
> >>>> Just a wild guess: It may be some feature like ALDPS (advanced link-=
down
> >>>> power saving). Depending on the link partner this may result in not =
waking
> >>>> up again, namely if the link partner uses ALDPS too.
> >>>> What is the link partner in your case? If you put a simple switch in=
 between,
> >>>> does this help?
> >>>>
> >>>> In the RTL8211F datasheet I found the following:
> >>>>
> >>>> Link Down Power Saving Mode.
> >>>> 1: Reflects local device entered Link Down Power Saving Mode,
> >>>> i.e., cable not plugged in (reflected after 3 sec)
> >>>> 0: With cable plugged in
> >>>>
> >>>> This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism wi=
th the
> >>>> integrated PHY of RTL8125. The 3s delay described there perfectly ma=
tches
> >>>> your finding.
> >>>>
> >>>>> With this new patch (reset in link-up path), both of the tests work
> >>>>> without any error.
> >>>>>
> >>>>>>
> >>>>>> I simply want to be convinced enough that your change doesn't brea=
k
> >>>>>> behavior for other users.
> >>>>>>
> >>>>>>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after =
link-down on RTL8125")
> >>>>>>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> >>>>>>> ---
> >>>>>>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
> >>>>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/=
net/ethernet/realtek/r8169_main.c
> >>>>>>> index 3507c2e28110..632e661fc74b 100644
> >>>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>>>>>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
> >>>>>>>  enum rtl_flag {
> >>>>>>>       RTL_FLAG_TASK_ENABLED =3D 0,
> >>>>>>>       RTL_FLAG_TASK_RESET_PENDING,
> >>>>>>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
> >>>>>>>       RTL_FLAG_TASK_TX_TIMEOUT,
> >>>>>>>       RTL_FLAG_MAX
> >>>>>>>  };
> >>>>>>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *wo=
rk)
> >>>>>>>  reset:
> >>>>>>>               rtl_reset_work(tp);
> >>>>>>>               netif_wake_queue(tp->dev);
> >>>>>>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_=
WAKE, tp->wk.flags)) {
> >>>>>>> -             rtl_reset_work(tp);
> >>>>>>>       }
> >>>>>>>  out_unlock:
> >>>>>>>       rtnl_unlock();
> >>>>>>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct =
net_device *ndev)
> >>>>>>>       if (netif_carrier_ok(ndev)) {
> >>>>>>>               rtl_link_chg_patch(tp);
> >>>>>>>               pm_request_resume(d);
> >>>>>>> -             netif_wake_queue(tp->dev);
> >>>>>>> -     } else {
> >>>>>>> +
> >>>>>>>               /* In few cases rx is broken after link-down otherw=
ise */
> >>>>>>>               if (rtl_is_8125(tp))
> >>>>>>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_N=
O_QUEUE_WAKE);
> >>>>>>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_P=
ENDING);
> >>>>>>> +             else
> >>>>>>> +                     netif_wake_queue(tp->dev);
> >>>>>>
> >>>>>> This call to netif_wake_queue() isn't needed any longer, it was in=
troduced with
> >>>>>> the original change only.
> >>>>>>
> >>>>>>> +     } else {
> >>>>>>>               pm_runtime_idle(d);
> >>>>>>>       }
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>> CC. Martin Kj=C3=A6r J=C3=B8rgensen  <me@lagy.org>, could you kindl=
y test if
> >>>>> this new patch works on your environment? Thanks!
> >>>>>
> >>>>> En-Wei,
> >>>>> Best regards.
> >>>>
> >>
> >> Just to be sure. Can you test with the following?
> >>
> >>
> >> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers=
/net/ethernet/realtek/r8169_phy_config.c
> >> index 2c8845e08..cf29b1208 100644
> >> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
> >> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
> >> @@ -1060,6 +1060,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8=
169_private *tp,
> >>         phy_modify_paged(phydev, 0xa86, 0x15, 0x0001, 0x0000);
> >>         rtl8168g_enable_gphy_10m(phydev);
> >>
> >> +       rtl8168g_disable_aldps(phydev);
> >>         rtl8125a_config_eee_phy(phydev);
> >>  }
> >>
> >> @@ -1099,6 +1100,7 @@ static void rtl8125b_hw_phy_config(struct rtl816=
9_private *tp,
> >>         phy_modify_paged(phydev, 0xbf8, 0x12, 0xe000, 0xa000);
> >>
> >>         rtl8125_legacy_force_mode(phydev);
> >> +       rtl8168g_disable_aldps(phydev);
> >>         rtl8125b_config_eee_phy(phydev);
> >>  }
> >>
> >> --
> >> 2.46.0
> >>
> >>
>

