Return-Path: <netdev+bounces-156064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6DA04CD0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BCD1887563
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48641A83E1;
	Tue,  7 Jan 2025 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRueFeYB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD441E0E0A
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290843; cv=none; b=fV3evnnbQEU0C4h83Ko3FWRFlsbs9ojLakL587GIUsdgcVu05X+oR1oNUOsPe4+7lhhm++LgBXk915aNO8LGDtQPG9K0g9uY/wL5Oga8g1i2+J6pGFn1B2Sh5yCWO+QUDSpEAWYoDpRvJrD/5T/mtNnGwVZtzZKlkZmMYxdVSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290843; c=relaxed/simple;
	bh=PN9q8/QFFe7rAupCJzxHMDDqHS9CzE5M/PB7fuFY2d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnhFzklO1/1Pq8hUBt3vg6MqwqihkG++5Dno2/WziwP0i1tbJGDjJq46NS8LpFQ6IZNmg8KHu6dJsyHZmRJNzCE+M4tM9KUhMK22jQb4L9RkvFZCYSEijhbt2C6UWdWtDIU2+moettAimocIj9Qcla7ovhwFyhdluFTriaBXbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRueFeYB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467abce2ef9so79481cf.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 15:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736290841; x=1736895641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvf2yE9qCcUzem5NhQ442PG3Oo6H/uh6oXpDzPKmhMM=;
        b=rRueFeYBKkE+RpmQd6gFCoJIn2SOacQ05/MNEt8FMCdQt1hSKEY/oyhEdDvmeUgFxM
         4MQphn9G+TkryRBvgB0EScmOuWBp9huNO4fE+bPBxcX3dFdv/IOtjrqYlsjVw3BqkURv
         1TUcOTtVZSXAwta4jdFHJK/R4gf5LFGuPz+6WtUrCIIn4d78mqAEM81WTUAciP5sOn/h
         fm3ZKpafDle2q6Rm/487q3iHPrT3ULTOHRX27q6y9OimdAa2vMeWwowbf39huWFzA+DK
         M0pP8pIp8rGSyT4qcYTbIa2S/6uVHzkN7OFoa63akHylEy3OFOPTYm6PYNB3FBCwKp9V
         O4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736290841; x=1736895641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvf2yE9qCcUzem5NhQ442PG3Oo6H/uh6oXpDzPKmhMM=;
        b=eHMLZvTMERfg7We8Te6CDjpjQB6am0mq/XODXv05YyTq6J0yccSrqcEFVNnJ8Ze1lV
         co7ESOGcYiTbn6JS82dEKhlvT0MNgq07lF83oBQAxIcrDrzM7vIs7d8RxjCYVBbJ8PMl
         Zc8E37H17AQMz7f8tA3E+riLInJb66/OIgOHTSXhcpl42xr4cHNGuNOGvuncgbrAtI2l
         WYA3qOc6vdNohqlFZFVJUEPdOlda+ZLDik6R/2Jprob+rwuDUZMDP6/UY5wqWLq2lmf4
         BIyE7XiA2q6Pxu1Rjx4AUVWgs2v3OHf+BygUaXcE31/4eCk7U91C6w6dVhX3XMbvOvE4
         6kVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwuiMwNTvBDVYJQ7Ezq42FJm5TH/vbhsh4TIxhWnytfrtYebjI9ngxo/DzxZUvCJb8atyDbxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNu+kPR+xBikb3DG5y/HwM7ILKwcxwvrHfLIDt4EDqM/5ak5ay
	ATqBFpm7pV5Fj4WehwvKzIuIrKXRoGBW6ZYnOQOHZ1kdb0XuqS66iI7a85262a4biRuRX3xY0UE
	Vo2d1ZqVplj3hn1Y2WpsC/S0IKHgh/xRbaZnY
X-Gm-Gg: ASbGncuGNLdlCALoA6+uc+1bXcLZqws5GmVd9VrFEHQ/mZDc5RPhLIXXX5ADS66gPta
	aBIepFRaNp919RjcivegYlZxLGudAKLg+EyRGsdgDwiunAXyLF8h+ubeJjkoMesINFII=
X-Google-Smtp-Source: AGHT+IH4afN7v46/A2tcKRwx7cC1h+F868DVWtD5tRSBf7L8cJR+88podFIdbldxvcIdVDcDO9G+vfzsDDc0Ss8DA64=
X-Received: by 2002:a05:622a:7616:b0:46c:721e:d914 with SMTP id
 d75a77b69052e-46c721eda28mr175401cf.24.1736290840843; Tue, 07 Jan 2025
 15:00:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107160846.2223263-1-kuba@kernel.org> <20250107160846.2223263-8-kuba@kernel.org>
In-Reply-To: <20250107160846.2223263-8-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Jan 2025 15:00:29 -0800
X-Gm-Features: AbW1kvYvUQhNWJNleqpvY6DlN8UmNyhLRKjI1gj8qtM8vqf_mX2RUPTGddofjxA
Message-ID: <CAHS8izNM-fMV-FZabhJGq6aAdExVGyT3GwUm3rfhnoFpKULiKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/8] netdevsim: add debugfs-triggered queue reset
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com, sdf@fomichev.me, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 8:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Support triggering queue reset via debugfs for an upcoming test.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
> v2:
>  - change mode to 0200
>  - reorder removal to be inverse of add
>  - fix the spaces vs tabs
> ---
>  drivers/net/netdevsim/netdev.c    | 55 +++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index cfb079a34532..d013b6498539 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -20,6 +20,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/netlink.h>
>  #include <net/net_shaper.h>
> @@ -29,6 +30,8 @@
>
>  #include "netdevsim.h"
>
> +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> +
>  #define NSIM_RING_SIZE         256
>
>  static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
> @@ -722,6 +725,54 @@ static const struct netdev_queue_mgmt_ops nsim_queue=
_mgmt_ops =3D {
>         .ndo_queue_stop         =3D nsim_queue_stop,
>  };
>
> +static ssize_t
> +nsim_qreset_write(struct file *file, const char __user *data,
> +                 size_t count, loff_t *ppos)
> +{
> +       struct netdevsim *ns =3D file->private_data;
> +       unsigned int queue, mode;
> +       char buf[32];
> +       ssize_t ret;
> +
> +       if (count >=3D sizeof(buf))
> +               return -EINVAL;
> +       if (copy_from_user(buf, data, count))
> +               return -EFAULT;
> +       buf[count] =3D '\0';
> +
> +       ret =3D sscanf(buf, "%u %u", &queue, &mode);
> +       if (ret !=3D 2)
> +               return -EINVAL;
> +
> +       rtnl_lock();
> +       if (!netif_running(ns->netdev)) {
> +               ret =3D -ENETDOWN;
> +               goto exit_unlock;
> +       }
> +
> +       if (queue >=3D ns->netdev->real_num_rx_queues) {
> +               ret =3D -EINVAL;
> +               goto exit_unlock;
> +       }

Is it correct that both these above checks are not inside of
netdev_rx_queue_restart() itself? Or should we fix that?

--=20
Thanks,
Mina

