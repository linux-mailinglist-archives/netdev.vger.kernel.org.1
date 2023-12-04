Return-Path: <netdev+bounces-53679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F297C804163
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB7B1C20B36
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE8C3A28B;
	Mon,  4 Dec 2023 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBZdqTNv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E79CD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701728019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArZo5LGYTBaOx/Vwapx48n76DlSMubqakK9kENEDfug=;
	b=KBZdqTNvs6DEFlZicCzKa7UfMpTAup4yldI5tmzxBi99yyMHYhfrGx4isLmMiLS4Zi1XQ8
	6vOIJ/XX4FMDRHiKr2+/PIfgWLdxB72a073luy+slD4p6/QEoX5W6CgHv12EOdDn8hhpoj
	glfQG0GqSQlqADpICzh/eW00D6y9Iv8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ze7XcJaYMzyChYYMxj-UJw-1; Mon, 04 Dec 2023 17:13:37 -0500
X-MC-Unique: ze7XcJaYMzyChYYMxj-UJw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-543f45ab457so3395266a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 14:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728015; x=1702332815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArZo5LGYTBaOx/Vwapx48n76DlSMubqakK9kENEDfug=;
        b=SLrYVWWGKDadklGUxckHoE/dLZRb1KlSoCZxQuyqZqhb+PdNgATNQo5h8iOT7gGFfY
         vbmXnb7iPG3KyzHCF4QIypchd3VIlH5ZcQOMgFjme+SgLoH2n12Xk+jxXpcuOuszGonW
         cCWYFBjKEjQ9CwW7dC5duBf31yc7JPyXPDSBJyBdGbqCSPVGpczcGCjpfKFAKawPRG90
         Fnd9PlGrGi1cdTTF/yh2e4Tuuumtm9x4NDF21nZQJakHDt2SqKzZfgWBzTsf7DRLUM/i
         6rwXclRX1VTG2V3ryM/s//LGbKZwB6MjoEvK2o/ZLkn1Sd085zRgqk8sUkjXphiX/oN0
         MxTg==
X-Gm-Message-State: AOJu0Yy8/JycAftqgfeuVLfLY17iI/LR+TNsgzrz1k3akGyO9f3BWHfq
	YPkeIl/uWIW+49S/DOy11POyJlcywSIyG9GXUlV/rlY2NU/eAV7TOzDiV4nLu6Vz2D46gYZkC46
	GC9Tbks0JZoRr1ccjHif34TCi1RL49vrg
X-Received: by 2002:a05:6402:516b:b0:54c:5257:f3 with SMTP id d11-20020a056402516b00b0054c525700f3mr3015331ede.83.1701728015709;
        Mon, 04 Dec 2023 14:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqe51V0RtPfHz1FkjZCGSt46EpCWYnCgrnNtV50FNxDk0c5+hbeha8jwaf4Di4h6vle9HklM0dcqkIlazgQvk=
X-Received: by 2002:a05:6402:516b:b0:54c:5257:f3 with SMTP id
 d11-20020a056402516b00b0054c525700f3mr3015327ede.83.1701728015401; Mon, 04
 Dec 2023 14:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202150807.2571103-1-srasheed@marvell.com> <CADEbmW12OWS6et2wp3skicUM=V81x8dS4_aySYP1Ok0kEc2M9Q@mail.gmail.com>
In-Reply-To: <CADEbmW12OWS6et2wp3skicUM=V81x8dS4_aySYP1Ok0kEc2M9Q@mail.gmail.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 4 Dec 2023 23:13:24 +0100
Message-ID: <CADEbmW3K7QkfniBtmMt=SZtwZWez30F+sM=656wqmZR8=ig1jQ@mail.gmail.com>
Subject: Re: [PATCH net v1] octeon_ep: initialise control mbox tasks before
 using APIs
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com, 
	vimleshk@marvell.com, egallen@redhat.com, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com, konguyen@redhat.com, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 11:10=E2=80=AFPM Michal Schmidt <mschmidt@redhat.com=
> wrote:
>
> On Sat, Dec 2, 2023 at 4:08=E2=80=AFPM Shinas Rasheed <srasheed@marvell.c=
om> wrote:
> > Do INIT_WORK for the various workqueue tasks before the first
> > invocation of any control net APIs. Since octep_ctrl_net_get_info
> > was called before the control net receive work task was even
> > initialised, the function call wasn't returning actual firmware
> > info queried from Octeon.
>
> It might be more accurate to say that octep_ctrl_net_get_info depends
> on the processing of OEI events. This happens in intr_poll_task.
> That's why intr_poll_task needs to be queued earlier.
> Did octep_send_mbox_req previously always fail with EAGAIN after
          ^^^^^^^^^^^^^^^^^^^^^
I meant octep_ctrl_net_get_info here.

> running into the 500 ms timeout in octep_send_mbox_req?
>
> Apropos octep_send_mbox_req... I think it has a race. "d" is put on
> the ctrl_req_wait_list after sending the request to the hardware. If
> the response arrives quickly, "d" might not yet be on the list when
> process_mbox_resp looks for it.
> Also, what protects ctrl_req_wait_list from concurrent access?
>
> Michal
>
> > Fixes: 8d6198a14e2b ("octeon_ep: support to fetch firmware info")
> > Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> > ---
> >  .../net/ethernet/marvell/octeon_ep/octep_main.c    | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driv=
ers/net/ethernet/marvell/octeon_ep/octep_main.c
> > index 552970c7dec0..3e7bfd3e0f56 100644
> > --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> > @@ -1193,6 +1193,13 @@ int octep_device_setup(struct octep_device *oct)
> >         if (ret)
> >                 return ret;
> >
> > +       INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
> > +       INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);
> > +       INIT_DELAYED_WORK(&oct->intr_poll_task, octep_intr_poll_task);
> > +       oct->poll_non_ioq_intr =3D true;
> > +       queue_delayed_work(octep_wq, &oct->intr_poll_task,
> > +                          msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS)=
);
> > +
> >         atomic_set(&oct->hb_miss_cnt, 0);
> >         INIT_DELAYED_WORK(&oct->hb_task, octep_hb_timeout_task);
> >
> > @@ -1333,13 +1340,6 @@ static int octep_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
> >         queue_delayed_work(octep_wq, &octep_dev->hb_task,
> >                            msecs_to_jiffies(octep_dev->conf->fw_info.hb=
_interval));
> >
> > -       INIT_WORK(&octep_dev->tx_timeout_task, octep_tx_timeout_task);
> > -       INIT_WORK(&octep_dev->ctrl_mbox_task, octep_ctrl_mbox_task);
> > -       INIT_DELAYED_WORK(&octep_dev->intr_poll_task, octep_intr_poll_t=
ask);
> > -       octep_dev->poll_non_ioq_intr =3D true;
> > -       queue_delayed_work(octep_wq, &octep_dev->intr_poll_task,
> > -                          msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS)=
);
> > -
> >         netdev->netdev_ops =3D &octep_netdev_ops;
> >         octep_set_ethtool_ops(netdev);
> >         netif_carrier_off(netdev);
> > --
> > 2.25.1
> >


