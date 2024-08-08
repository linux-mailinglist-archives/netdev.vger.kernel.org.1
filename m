Return-Path: <netdev+bounces-116908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1294C0B6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B4FB26442
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0718FC73;
	Thu,  8 Aug 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Q6BTRF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406118FC6E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130053; cv=none; b=hm22sCYvAJD/wdEeEDVzZf9mYRCibf+5SIp7IQneHcQa+kfwoJLMURI0AryWtgvMWwgGNKUvMYfmZYMef9+QHypwf5awpTrhpl52eV/rsCFGKNCXT8erN7uRH2IhwrSIOJlUFwfISLShfoytjPCOBgO68STKEO1tdYqjTqB+qS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130053; c=relaxed/simple;
	bh=QY/3LBekhwERApgsXZ4yA2jMOOM5zV0uFSHZErKfdYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsxWY0Bi6igFbffrIKm0eIvsRJ1WE9gNn+S+VKyfNacqf1bXS+z/szzKZ30L5sYDYvCpUkI259J47+T47+rEIxgHohec1y0SByPDxuQ8lZhfmTE/H1BWwqwFomaCochBZrcb2uBDV0pnmGVXwTD7UHD6xyvHX8uETIQ4VujDahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Q6BTRF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso1125634a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723130050; x=1723734850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY/3LBekhwERApgsXZ4yA2jMOOM5zV0uFSHZErKfdYY=;
        b=R2Q6BTRFd+UQLtJumT84dkn8eXZKQFP5EoD87P1CeZyEnd4KPbu8WnkSm7UtB/pwPN
         LNBC42G1s6v4tDWH6lYLI8xV5BE3ENzGsemCAJm1ulDEGYfpD0TCTXkLs5ToSd8mWKgd
         PKSuL60pEZPZuvgeXxoG1jiCLYKELSWzCk2jFWTNEqVTXhSfPoiTJlr2r9TvfXswBIjz
         ecrS4i0nSyU6zLZTwIKWy4ZCViHlaenj30OAepSU5LlOKg/+R9s1763UhIriJbHC3kIY
         az+1RRoAq9L6QoeXNvPbkwwCvNtG/6yAvWWZxc3tkZjFvfKplSmvswQ+LjJn50YSCRSq
         STtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723130050; x=1723734850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QY/3LBekhwERApgsXZ4yA2jMOOM5zV0uFSHZErKfdYY=;
        b=kjraFIMQ/SOCTdKuXrqDTPCe3PM9lYJ3n4wN+InIHOMH/PfDHG1KNuBQtmQLuvWL/D
         OmN2WiBkaD0z/xJmJxQOZ367zGOK6SybC3CFsE1Z+x3QVwUmk0ulRMwx8Kh5K3AOwsCa
         ZgV5mFANdvwoVH5YB94Ewb9MgKqKih8GE+uULXR6BoenxKEIwqiWS8ZUDka2UCze1wXP
         BT5QBcjIDAg7QprT5zrhtPDBYnAEfYHswfZnGswyHtfv2F2k28OX90Nfk3ts5CiSnvir
         HtbubTO3WvLNEAy/VJ9AMy9wHlCqHyjg6oYXiDQ1QMnon1qbMDdaqcvZ67U6XFi5SlmQ
         fgAA==
X-Gm-Message-State: AOJu0YwyZOb+4VUpTc6iX2ymwmSXWla951G0WUyWqji5fxWHSLZqw2ek
	WTCfmRoWJKykqVqcbfA1f7iqQ2XqFWWe697EoiyImb2YsFJa0BM7CzUfgkRrIJUz69ObtEZe5Zj
	jO8fdWW6S+S4ia0CxF+uhZaqDEt8=
X-Google-Smtp-Source: AGHT+IEdpLQR3FAzNEOC/dQ4G9n/58bt3LItzFNZxoo5QdfV5loloVhKuntBTPkggGQIvtJqMM+p5TmJpo1Cwo1WZ8g=
X-Received: by 2002:a05:6402:d08:b0:57d:72e:5b3a with SMTP id
 4fb4d7f45d1cf-5bbb2341801mr1706396a12.33.1723130049468; Thu, 08 Aug 2024
 08:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808051518.3580248-1-dw@davidwei.uk> <20240808051518.3580248-7-dw@davidwei.uk>
In-Reply-To: <20240808051518.3580248-7-dw@davidwei.uk>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 9 Aug 2024 00:13:56 +0900
Message-ID: <CAMArcTX_BDeFQv4OkOk6FLdaoEaS6VQyv6wijUPoQNPCy456zg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/6] bnxt_en: only set dev->queue_mgmt_ops if
 supported by FW
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Michael Chan <michael.chan@broadcom.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
Hi David,
Thank you so much for this work!

> The queue API calls bnxt_hwrm_vnic_update() to stop/start the flow of
> packets, which can only properly flush the pipeline if FW indicates
> support.
>
> Add a macro BNXT_SUPPORTS_QUEUE_API that checks for the required flags
> and only set queue_mgmt_ops if true.
>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
> drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
> drivers/net/ethernet/broadcom/bnxt/bnxt.h | 3 +++
> 2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 7762fa3b646a..85d4fa8c73ae 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15717,7 +15717,6 @@ static int bnxt_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> dev->stat_ops =3D &bnxt_stat_ops;
> dev->watchdog_timeo =3D BNXT_TX_TIMEOUT;
> dev->ethtool_ops =3D &bnxt_ethtool_ops;
> - dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
> pci_set_drvdata(pdev, dev);
>
> rc =3D bnxt_alloc_hwrm_resources(bp);
> @@ -15898,6 +15897,8 @@ static int bnxt_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>
> if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
> bp->rss_cap |=3D BNXT_RSS_CAP_MULTI_RSS_CTX;
> + if (BNXT_SUPPORTS_QUEUE_API(bp))
> + dev->queue_mgmt_ops =3D &bnxt_queue_mgmt_ops;
>
> rc =3D register_netdev(dev);
> if (rc)
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index a2233b2d9329..62e637c5be31 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2451,6 +2451,9 @@ struct bnxt {
> #define BNXT_SUPPORTS_MULTI_RSS_CTX(bp) \
> (BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) && \
> ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
> +#define BNXT_SUPPORTS_QUEUE_API(bp) \
> + (BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) && \
> + ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
>
> u32 hwrm_spec_code;
> u16 hwrm_cmd_seq;
> --
> 2.43.5
>
>

What Broadcom NICs support BNXT_SUPPORTS_QUEUE_API?

I have been testing the device memory TCP feature with bnxt_en driver
and I'm using BCM57508, BCM57608, and BCM57412 NICs.
(BCM57508's firmware is too old, but BCM57608's firmware is the
latest, BCM57412 too).
Currently, I can't test the device memory TCP feature because my NICs
don't support BNXT_SUPPORTS_QUEUE_API.
The BCM57608 only supports the BNXT_SUPPORTS_NTUPLE_VNIC, but does not
support the BNXT_SUPPORTS_QUEUE_API.
The BCM57412 doesn't support both of them.
I think at least BCM57508 and BCM57608 should support this because
it's the same or newer product line as BCM57504 as far as I know.
Am I missing something?

Thanks a lot!
Taehee Yoo

