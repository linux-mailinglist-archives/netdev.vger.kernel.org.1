Return-Path: <netdev+bounces-187127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81525AA51DC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504699E2A50
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9BA262807;
	Wed, 30 Apr 2025 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngCLDqwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE02DC768
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031417; cv=none; b=EVqFoO4a2DgONoWYExV0ncDcnf1aUNwhKYyQq9bykYQDUjyLmDehiPMqlJT3i785Z185Gsl27a4E8t+cZBx5QW7o+dPQZJ7qtTfhcD6A94zorVeSF8BkvK/6iY/rfgS59FYgcBQYzmqAWkjttqcsMqVL1WdwAL9lGD0Ta62klo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031417; c=relaxed/simple;
	bh=ZBh2VESxaLLntgoJekpMTMD8yD2rIXjjJTcYA5scM5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGQZ+MDj6yuNu5PP8zDPHydBnMakCf9HN4SQn4BQzCorKNe+CKVLh0uiBQjbUTVrDeyfXGUVmOaWes77lXasRQZLf6HnG/YEGz4v2TT7bkfyMiemV6Xy03IW7auWzJQ8Xh9RhnhF/j+Q83K42CYRHUA9ni0+utQGGJYOqjh/2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngCLDqwe; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f63ac6ef0fso183035a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746031414; x=1746636214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZFAik5wqt1zul2OkH6Ta6EmRD3BIbSU+zezqBavcnE=;
        b=ngCLDqwem+2wxJB/AP3UwbsyjvI4NBcnuKucJS0DxllhkO7husMpDVKZIObuDyxjLh
         ByJSLutLzh1ssIkhQM0iH71thYObpBB68/Ae9jRxEnD/SunfO1Izz3uQ1oCpPL+xSuWW
         BgDkWoOFu4mHOoCcxkVxyg4ZMCleMkjSboLNjKVNBPaLxCeKGSimf2KgzkWg25JA0jXw
         Bz3A1Td1EXkURRQi9ecYGUboqnSBNZMTfjOHhVNVsevwOKudRlXBnHOq/DRWYf/+B/mf
         rn12PZP15h3jgJIGimR6L2M1ygL5HSF/3UgOhYJV/CQYhShQcwX63JtyIS8DV5+6Y2Vo
         oBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031414; x=1746636214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZFAik5wqt1zul2OkH6Ta6EmRD3BIbSU+zezqBavcnE=;
        b=J8z2V09Oi/NAmC0OAtA1pFRlSInJFlHC/Sp3X9IWWIIB4xLsMRVt1kMgFPIF5dUuk0
         4lpa4v3LHcI2eZbx/0yLXZbpOhkv1QQoNemfbObBNTmBTAYt32wy5Wr/zAG9AAFlsTsy
         CqSEDw+Xc1FliKEiixWEO11RFNrVJZJ4HM2vnumgjj8ISVNu9hV0D1zZuseZpL0dVWt8
         P59ikmalQcOaibMJqZcoIXZ/74yLUfaCZZqHJlNY01KibAwfhrka0SM4mb3xaHiRfwbS
         WWUeNgq+gwmI/nFEGLx2osGdtQDwTgsTMphNxTNrnKJBEq3QagdE54SKBZYrVaykqiWs
         bMMg==
X-Forwarded-Encrypted: i=1; AJvYcCVMZJNKylfWWu5vohwyna+i6giBsvuAwlUKXBweHn3R/2OoDse+yJXKHA+WSmbENv8Uz72ZOc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRajbkuJMT9911DqJy0VdKh39d5HTTAYMgqp7/ch1QaPt5SI4
	tPezJ5tLUMQifZOmSGB2bprJ4ALaiP7KFMhPe7ovF3OWWyXHNLwPiGYoKIntYWEPPs4EA8lbuZl
	0DO+3H5MQS7fzXkF75++WBwj8M9k=
X-Gm-Gg: ASbGnctfphG25ry+NSlJ8btphb7UQPZkOKbhSagNqvyzQj14Fp3k7sD8KCaCTvRvQVi
	RKwgZQW8jdEsWhG9SOKXFl4yUuDyniBbmaDmyljQaYAXYKvhNq22IM+Glk0xeL0CXAYpZJpwB7W
	4QaB9g3a7RsTODkv3d2OvX6zaRhHIk+05VPg==
X-Google-Smtp-Source: AGHT+IGAyFP4IPNzVnZW7TeKcU8epJtNgwQZ97IIp0WgoPHwWmFn8e7fXM1putXt8yIFGUVGCGbSerjpH5BmNkmnxEY=
X-Received: by 2002:a05:6402:4404:b0:5ed:17d9:91d4 with SMTP id
 4fb4d7f45d1cf-5f90a590edemr189911a12.8.1746031413472; Wed, 30 Apr 2025
 09:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424125547.460632-1-vadfed@meta.com> <CAMArcTWDe2cd41=ub=zzvYifaYcYv-N-csxfqxUvejy_L0D6UQ@mail.gmail.com>
 <c9119edd-69d3-4b0e-a7b3-03417db5fed8@linux.dev>
In-Reply-To: <c9119edd-69d3-4b0e-a7b3-03417db5fed8@linux.dev>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 1 May 2025 01:43:21 +0900
X-Gm-Features: ATxdqUGER_tieqNtYmdIG05j_0hA8gCq6rhJqP2n1GjgWMajZgWpNMNhzRRJmPk
Message-ID: <CAMArcTXnZ-T6nsSyEtBLj+_SzMJhEz8R4g5HnR-ToFx8JPLngw@mail.gmail.com>
Subject: Re: [PATCH net v4] bnxt_en: improve TX timestamping FIFO configuration
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:55=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 30/04/2025 13:59, Taehee Yoo wrote:
> > On Thu, Apr 24, 2025 at 10:11=E2=80=AFPM Vadim Fedorenko <vadfed@meta.c=
om> wrote:
> >>
> >
> > Hi Vadim,
> > Thanks for this work!
> >
> >> Reconfiguration of netdev may trigger close/open procedure which can
> >> break FIFO status by adjusting the amount of empty slots for TX
> >> timestamps. But it is not really needed because timestamps for the
> >> packets sent over the wire still can be retrieved. On the other side,
> >> during netdev close procedure any skbs waiting for TX timestamps can b=
e
> >> leaked because there is no cleaning procedure called. Free skbs waitin=
g
> >> for TX timestamps when closing netdev.
> >>
> >> Fixes: 8aa2a79e9b95 ("bnxt_en: Increase the max total outstanding PTP =
TX packets to 4")
> >> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> >> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >> ---
> >> v3 -> v4:
> >> * actually remove leftover unused variable in bnxt_ptp_clear()
> >> (v3 was not committed before preparing unfortunately)
> >> v2 -> v3:
> >> * remove leftover unused variable in bnxt_ptp_clear()
> >> v1 -> v2:
> >> * move clearing of TS skbs to bnxt_free_tx_skbs
> >> * remove spinlock as no TX is possible after bnxt_tx_disable()
> >> * remove extra FIFO clearing in bnxt_ptp_clear()
> >> ---
> >>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++--
> >>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++++---=
--
> >>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  1 +
> >>   3 files changed, 25 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.c
> >> index c8e3468eee61..2c8e2c19d854 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >> @@ -3414,6 +3414,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
> >>
> >>                  bnxt_free_one_tx_ring_skbs(bp, txr, i);
> >>          }
> >> +
> >> +       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> >> +               bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
> >>   }
> >>
> >>   static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ri=
ng_info *rxr)
> >> @@ -12797,8 +12800,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bo=
ol irq_re_init, bool link_re_init)
> >>          /* VF-reps may need to be re-opened after the PF is re-opened=
 */
> >>          if (BNXT_PF(bp))
> >>                  bnxt_vf_reps_open(bp);
> >> -       if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
> >> -               WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
> >>          bnxt_ptp_init_rtc(bp, true);
> >>          bnxt_ptp_cfg_tstamp_filters(bp);
> >>          if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/n=
et/ethernet/broadcom/bnxt/bnxt_ptp.c
> >> index 2d4e19b96ee7..0669d43472f5 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
> >> @@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock=
_info *ptp_info)
> >>          return HZ;
> >>   }
> >>
> >> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
> >> +{
> >> +       struct bnxt_ptp_tx_req *txts_req;
> >> +       u16 cons =3D ptp->txts_cons;
> >> +
> >> +       /* make sure ptp aux worker finished with
> >> +        * possible BNXT_STATE_OPEN set
> >> +        */
> >> +       ptp_cancel_worker_sync(ptp->ptp_clock);
> >> +
> >> +       ptp->tx_avail =3D BNXT_MAX_TX_TS;
> >> +       while (cons !=3D ptp->txts_prod) {
> >> +               txts_req =3D &ptp->txts_req[cons];
> >> +               if (!IS_ERR_OR_NULL(txts_req->tx_skb))
> >> +                       dev_kfree_skb_any(txts_req->tx_skb);
> >> +               cons =3D NEXT_TXTS(cons);
> >> +       }
> >> +       ptp->txts_cons =3D cons;
> >> +       ptp_schedule_worker(ptp->ptp_clock, 0);
> >> +}
> >> +
> >>   int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
> >>   {
> >>          spin_lock_bh(&ptp->ptp_tx_lock);
> >> @@ -1105,7 +1126,6 @@ int bnxt_ptp_init(struct bnxt *bp)
> >>   void bnxt_ptp_clear(struct bnxt *bp)
> >>   {
> >>          struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
> >> -       int i;
> >>
> >>          if (!ptp)
> >>                  return;
> >> @@ -1117,12 +1137,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
> >>          kfree(ptp->ptp_info.pin_config);
> >>          ptp->ptp_info.pin_config =3D NULL;
> >>
> >> -       for (i =3D 0; i < BNXT_MAX_TX_TS; i++) {
> >> -               if (ptp->txts_req[i].tx_skb) {
> >> -                       dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
> >> -                       ptp->txts_req[i].tx_skb =3D NULL;
> >> -               }
> >> -       }
> >> -
> >>          bnxt_unmap_ptp_regs(bp);
> >>   }
> >> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/n=
et/ethernet/broadcom/bnxt/bnxt_ptp.h
> >> index a95f05e9c579..0481161d26ef 100644
> >> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> >> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
> >> @@ -162,6 +162,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
> >>   void bnxt_ptp_reapply_pps(struct bnxt *bp);
> >>   int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
> >>   int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
> >> +void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
> >>   int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
> >>   void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 pro=
d);
> >>   int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
> >> --
> >> 2.47.1
> >>
> >>
> >
> > I=E2=80=99ve encountered a kernel panic that I think is related to this=
 patch.
> > Could you please investigate it?
> >
> > Reproducer:
> >      ip link set $interface up
> >      modprobe -rv bnxt_en
> >
>
> Hi Taehee!
>
> Yeah, looks like there are some issues on the remove path.
> Could you please test the diff which may fix the problem:
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 78e496b0ec26..86a5de44b6f3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16006,8 +16006,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
>
>          bnxt_rdma_aux_device_del(bp);
>
> -       bnxt_ptp_clear(bp);
>          unregister_netdev(dev);
> +       bnxt_ptp_clear(bp);
>
>          bnxt_rdma_aux_device_uninit(bp);
>

Thanks! It seems to fix the issue.
The above reproducer can't reproduce a kernel panic.

