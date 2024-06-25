Return-Path: <netdev+bounces-106382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC79160C0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A231C22043
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D051474AE;
	Tue, 25 Jun 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMtOsr/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CF1465A5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303221; cv=none; b=X6GX5J1et74PeVQ0oG4HEhryvAE3a9wuCdei3qnKbwjDaTR3XP/VcGptupv6J4K6GuYyP2n52ar3k5HtyCwCTyRw75EJTkgw/056y+pdso+6S/hfJbMFrvTy6m69iyL3/WXYdKl1CqpIbJNQnEgGUWRY+yNuvkKcVrhmyZQw51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303221; c=relaxed/simple;
	bh=9SAmHOa8woEJd6bqs522/etuBIdKY9+ff5OOOKpu8MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmYcnz6fTiNKRO/f5jJ9Wz/ogeq5N02R8ysI6ouX9BZldHUH+Gd0TUiNtOemmWtREYWpiHg/3+jwvhHSh58UFikwHBBUz97MqWKT6yvYZljBqcl2OEOvt2NR9rQI7hVtiTi12onVM+JptdMsrIUdXSyhAam9dJ16Zn8/DkONmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMtOsr/h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso7632a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719303218; x=1719908018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgl3I6j8ycb51DN1ZgmUcsw+f0o5GR0xCy3Wc2F1UOc=;
        b=XMtOsr/h3TP4zTs7beumD/ufoCdZ6NaoT2XI3hFafrFgaNnpL/rkY531Q3uro/iA9i
         9VKF9dbfd8JD9iVtHR0xCoPxxk43UjYKaq2ckk9B8cRAK42/DM566U+o7+/GRFxvezDl
         P6xKMQLLMJeXEqk72zRspj2X9VFTvSNJhDwliYQVQF+XuYfuV8aIhhNBApVv7wPvOtlK
         BGFNLsRugV002E9K63pnIahRmW9hqZea0hLP3ZWjyEmmg1mgOAV2+iBEPRBYXf/tl4Ni
         Gp8mPio89xX/L3440U+uMaXWkNouZ+mX/YF4qcXNLvBZx59JakAmbwERH0WFWQmyRMc+
         Axsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303218; x=1719908018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgl3I6j8ycb51DN1ZgmUcsw+f0o5GR0xCy3Wc2F1UOc=;
        b=q+Whn0Wo+m56k6s7BL6yb3EcIesLQa4KzcEBLwcC0wIOA0Xr3EdHTAifdPua19zuxF
         iAWqN+YsRyAmY2fA78HuqfyISKJB1E6O/46E/EATh26AxO+wCu5FKVNntPNZJ5dJNqh3
         /OxX8GoIxnrtSa0iWaf8i1ovNl7drjp5ERL1qEg378BrBKcfnEIHpPkVuPjbsQI39nNp
         KqqOLcXxIztBbu6zrF8+0KflCw9UzdPe/O2XpHV/tVA9EjvnkOtHhdSC0dWEHjkpnFzy
         q+Q+uaptvU+WH3niHhsLMhaFhrLWKxhWKzxzAW0+Lfk+QLz/T1pe8IPTCWICamUtwNt8
         Gyfg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Z6CtYPJf7Y5joYIT9n9kLAjAo7RVVPc2PHfu+VRDftkbmZ8JMMXfptepUqY9JI5Yf5+IOTYkjRluSuVwEW3OdNhnaQun
X-Gm-Message-State: AOJu0Ywm9uhVUqCo4sfvB1PMKtRRUP/5sl01TJvZshSWHGVW0Nwit71Z
	+CkbzqV4Iu3OW3/03JuAImgNLTAKAa17WqSZjwbB56Ta3ahn8xnSAjjR50tVS0/W5RwL3MpTc15
	In8JJd/f/QA4BFk+NcH+CAdStnqulCqKKrcNG
X-Google-Smtp-Source: AGHT+IEkgrSzs5pEjpbU3XNhuj+CaLrt3Bh8A38qKaFpT4fJ0le4SSmJ0KHHI0P+QX1n1lLVDdVfOcMnd3jNUizszYw=
X-Received: by 2002:a05:6402:524b:b0:57d:3d3b:f62f with SMTP id
 4fb4d7f45d1cf-57e97d18cecmr105989a12.1.1719303218017; Tue, 25 Jun 2024
 01:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625075214.462363-1-qq810974084@gmail.com>
In-Reply-To: <20240625075214.462363-1-qq810974084@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Jun 2024 10:13:24 +0200
Message-ID: <CANn89iJPFY3Mv4tHbaoqjLGqHQ01t-3ZYwfgzu7x72i92QvrHQ@mail.gmail.com>
Subject: Re: [PATCH] hippi: fix possible buffer overflow caused by bad DMA
 value in rr_start_xmit()
To: Huai-Yuan Liu <qq810974084@gmail.com>
Cc: jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-hippi@sunsite.dk, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:52=E2=80=AFAM Huai-Yuan Liu <qq810974084@gmail.co=
m> wrote:
>
> The value rrpriv->info->tx_ctrl is stored in DMA memory, and assigned to
> txctrl. However, txctrl->pi can be modified by malicious hardware at any
> time. Because txctrl->pi is assigned to index, buffer overflow may
> occur when the code "rrpriv->tx_skbuff[index]" is executed.

How txctrl->pi can be modified by malicious hardware ? This is host
memory, not mapped to the device.


>
> To address this issue, ensure index is checked.
>
> Fixes: f33a7251c825 ("hippi: switch from 'pci_' to 'dma_' API")

Is it just me or this Fixes: tag is not relevant ?

> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
> ---
> V2:
> * In patch V2, we remove the first condition in if statement and use
>   netdev_err() instead of printk().
>   Thanks Paolo Abeni for helpful advice.
> V3:
> * In patch V3, we stop the queue before return BUSY.
>   Thanks to Jakub Kicinski for his advice.
> V4:
> * In patch V4, we revise the wording in the description.
>   Thanks to Markus Elfring for pointing this out.
> ---
>  drivers/net/hippi/rrunner.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
> index aa8f828a0ae7..f4da342dd5cc 100644
> --- a/drivers/net/hippi/rrunner.c
> +++ b/drivers/net/hippi/rrunner.c
> @@ -1440,6 +1440,12 @@ static netdev_tx_t rr_start_xmit(struct sk_buff *s=
kb,
>         txctrl =3D &rrpriv->info->tx_ctrl;
>
>         index =3D txctrl->pi;
> +       if (index >=3D TX_RING_ENTRIES) {
> +               netdev_err(dev, "invalid index value %02x\n", index);
> +               netif_stop_queue(dev);
> +               spin_unlock_irqrestore(&rrpriv->lock, flags);
> +               return NETDEV_TX_BUSY;
> +       }

When seeing this patch, my initial reaction was : array_index_nospec()
is missing.

But then :

If a malicious hardware can control txctl->pi, then it will cause
multiple UAF or skb leaks if txctrl->pi
is kept below TX_RING_ENTRIES.

This driver should keep a trusted copy of txctrl->pi field, only seen by it=
self,
and not read it from the untrusted device.

Otherwise, this patch is only adding a lot of confusion.

