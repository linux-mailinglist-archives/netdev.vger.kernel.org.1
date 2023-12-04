Return-Path: <netdev+bounces-53678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF3E80415C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7051F212A9
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0A39FFE;
	Mon,  4 Dec 2023 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkEtwoAj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B6FF
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 14:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701727862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByMP2bESxZ3CqMK+J+SZZoIbcIxRH2MhetgkMxSeNbY=;
	b=QkEtwoAjhGsBhYKRDr607hEWe+pxYr5rhn0esWCqCUm1n9OiC4Wrcdqv2xta/sN8q8gmP0
	rqokjo7GwVpij+RDdYeTHUB9Tn0VkynhZw9ptwcKdrzVWEfyxxzvEQkdkm4lPes+4VNFWD
	cDKb3iE+45aH4DYtb7RqYyDoGmxoWq4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-tHmjQRjMPeaQV7b1HI79fQ-1; Mon, 04 Dec 2023 17:11:00 -0500
X-MC-Unique: tHmjQRjMPeaQV7b1HI79fQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54554ea191bso3395840a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 14:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727859; x=1702332659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByMP2bESxZ3CqMK+J+SZZoIbcIxRH2MhetgkMxSeNbY=;
        b=aaEmo2VFaYos58xMqC3B2g+HI2MAXzBGv9ICgmA9VEwj+uddEw7Fm+43Gvv14HetTS
         idGoswZr9C3YrWekS3e+3JMfum0y5X3vuTqWpGDC7N3gqK+qUa9oVhp+GVzVgHuylo5l
         wPhXgej4+W1UZH/mKDPfRn07Om9FW9ZxUAbVJbtpSRJsjFo0NPgTuIWrpDjeD33OpXhJ
         3Wvucw63cinC6Bfl47MnZFiEq5j2xZ6urPUNgZV5HigOF4WOmwWD1lu6qQEt7hr6Ifbr
         9RMaAL8NiN+HiexIzJIZeilKD91U2JDsrLbgSetgVnVs2/oVW0oRzZS4GyllKrCPUy8f
         J71g==
X-Gm-Message-State: AOJu0YyxwaNDLOunb3T8Vr5ECc64oXBmxal0Q9xZeR6rL+yo1q8NAZzv
	TkIK1dwPx1xsMWNrS01i77Xy13D6TFbLIEHz19H7xbJA2uga//bYtJ4knAWlTCsGjuqHCqGwDW4
	XNl8JmbhrhmbHXUePPNNf3jzDveAC9tOV
X-Received: by 2002:a50:9b50:0:b0:54c:4837:9a9b with SMTP id a16-20020a509b50000000b0054c48379a9bmr3196295edj.66.1701727859417;
        Mon, 04 Dec 2023 14:10:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM83t2E2F5MEvtLCeFKdyCdGinuyTdBMq99IevqF0/lsod/1pMqyIMLZhiL2fY6fb1yfa70gAJ6m2xRNaJbb0=
X-Received: by 2002:a50:9b50:0:b0:54c:4837:9a9b with SMTP id
 a16-20020a509b50000000b0054c48379a9bmr3196280edj.66.1701727859077; Mon, 04
 Dec 2023 14:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202150807.2571103-1-srasheed@marvell.com>
In-Reply-To: <20231202150807.2571103-1-srasheed@marvell.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 4 Dec 2023 23:10:47 +0100
Message-ID: <CADEbmW12OWS6et2wp3skicUM=V81x8dS4_aySYP1Ok0kEc2M9Q@mail.gmail.com>
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

On Sat, Dec 2, 2023 at 4:08=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
> Do INIT_WORK for the various workqueue tasks before the first
> invocation of any control net APIs. Since octep_ctrl_net_get_info
> was called before the control net receive work task was even
> initialised, the function call wasn't returning actual firmware
> info queried from Octeon.

It might be more accurate to say that octep_ctrl_net_get_info depends
on the processing of OEI events. This happens in intr_poll_task.
That's why intr_poll_task needs to be queued earlier.
Did octep_send_mbox_req previously always fail with EAGAIN after
running into the 500 ms timeout in octep_send_mbox_req?

Apropos octep_send_mbox_req... I think it has a race. "d" is put on
the ctrl_req_wait_list after sending the request to the hardware. If
the response arrives quickly, "d" might not yet be on the list when
process_mbox_resp looks for it.
Also, what protects ctrl_req_wait_list from concurrent access?

Michal

> Fixes: 8d6198a14e2b ("octeon_ep: support to fetch firmware info")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../net/ethernet/marvell/octeon_ep/octep_main.c    | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/driver=
s/net/ethernet/marvell/octeon_ep/octep_main.c
> index 552970c7dec0..3e7bfd3e0f56 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -1193,6 +1193,13 @@ int octep_device_setup(struct octep_device *oct)
>         if (ret)
>                 return ret;
>
> +       INIT_WORK(&oct->tx_timeout_task, octep_tx_timeout_task);
> +       INIT_WORK(&oct->ctrl_mbox_task, octep_ctrl_mbox_task);
> +       INIT_DELAYED_WORK(&oct->intr_poll_task, octep_intr_poll_task);
> +       oct->poll_non_ioq_intr =3D true;
> +       queue_delayed_work(octep_wq, &oct->intr_poll_task,
> +                          msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
> +
>         atomic_set(&oct->hb_miss_cnt, 0);
>         INIT_DELAYED_WORK(&oct->hb_task, octep_hb_timeout_task);
>
> @@ -1333,13 +1340,6 @@ static int octep_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         queue_delayed_work(octep_wq, &octep_dev->hb_task,
>                            msecs_to_jiffies(octep_dev->conf->fw_info.hb_i=
nterval));
>
> -       INIT_WORK(&octep_dev->tx_timeout_task, octep_tx_timeout_task);
> -       INIT_WORK(&octep_dev->ctrl_mbox_task, octep_ctrl_mbox_task);
> -       INIT_DELAYED_WORK(&octep_dev->intr_poll_task, octep_intr_poll_tas=
k);
> -       octep_dev->poll_non_ioq_intr =3D true;
> -       queue_delayed_work(octep_wq, &octep_dev->intr_poll_task,
> -                          msecs_to_jiffies(OCTEP_INTR_POLL_TIME_MSECS));
> -
>         netdev->netdev_ops =3D &octep_netdev_ops;
>         octep_set_ethtool_ops(netdev);
>         netif_carrier_off(netdev);
> --
> 2.25.1
>


