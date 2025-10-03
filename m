Return-Path: <netdev+bounces-227799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B5BB780E
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F5874E5FF0
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B6928DB56;
	Fri,  3 Oct 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfsOhdde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A41C5F37
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508115; cv=none; b=u4/oGaRPVV4naswOrp/4SSJ0j0ur40EsRH77532ZLcCbxICfu4YPCNT49GT6191vKvLEHRn7iBnqw1CZN1leSwg8WbtxWirxvEZW/PH/pwaFBED1qaisVyFyHB4AY25Md0kVkP7j/wSLD2CJbhob+06tuQ6j1gy9BEPhqWOxg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508115; c=relaxed/simple;
	bh=7wuFMGs0dHFY4V1AjLX74sWwcF/NB+Jk1Zc5be1peEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvvATFnZrvw1Y1IP5J5GMms/VMYpTywg9hTPH2jb4BWD6SEIaQhEKlZerZrtMm19ptBIU1qbvwXtlrRlUzFjCNdZgWJEQZwUZGJJbGybOjOMzv7eDkWnIrODHKhlkA83JssmL4eqvUD+XWdikdyK+zeyhu3SnTUJ7apZkKGEmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfsOhdde; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4dffec0f15aso30224681cf.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759508112; x=1760112912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRT/iYpKxpou3nIU4G8aZA9jml41omx9hIjrGCgXioY=;
        b=SfsOhdde7T+jjBRwgvdZO4pqAshekPhkCM4BYg+935xeBWdsFT70GSpgqlwuZS1YsH
         sauWqezY5eXtwfpTEvFr9uvlc2YDYoPzqLXh97WsdwtzbtWi27D5+Ep8ARwmbghoFJ66
         EiwmTTfh5CVGUZGc25ow25iNXk6bwxKJxSlBq4EY+0UT0Li8V61DhAt+EsnuUzhyx49I
         Cbbzbvl6rZwUCr0eQWTp4NRe4n5Db6oo7X11J01B/Wh12jTyNg+c+GMtOZM0pn9t1Tzl
         x3QtZsgXaN09yCNPUas8lxPyEHyAsOAnYuf2z2XswptlQvdIgJkkSWjCm95NVqTlQxS1
         +gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508112; x=1760112912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRT/iYpKxpou3nIU4G8aZA9jml41omx9hIjrGCgXioY=;
        b=wP/Qt/+uGHf6ca0EZsrslLOgSTyUNL8rRhIXTu/XHSEAa6gjRnx4QXxaZoHtXEolmv
         Yqm2pqpwZw0Oqp9aCofgMx6TrvFAsRy9GSvxHiY3co1u00bWNWrJe1PuXvnob4FyOm49
         rs4J7fxx3H9EjzcobK9zWzekiIaj9+/od0sQjDoPzaJyf/qwIv38DDP0W/9vLa8SD10o
         FSZnI7aGhNYSIXcn3ClLaWUVbvpl9Mh6HRlOVAofHnwlpZ9SEj2sG/ctzQ8xbBiOnIvz
         i6z0ZjkNnRmS7ygNBG42kOzjBFCYBj4YLeSJkk/2waY4mrXLctxZbl3U9sDTEb0XtPJd
         fN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+HBoB4VI96kQ6q73TZKx27AxYbJVBApM7ICBajUuYGQN31v82VxFmfuJFsdNyLiCcfFQZHpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXjPwZ8S4WHT/kwY2zj93bPbAUl3zWKhTKHLIPVgvd3s8m8FR
	wbYhIjes2R3DUAI4KQZ46A9mdIZGlNnMFKOZKowtPEbpR/R7BT6/IbUx8u3slpundT3G873uuhe
	qte2hnQJz13Dh8ozbi2lCq2+V2tWQekLWPCFNwYEd
X-Gm-Gg: ASbGncs+QuZiFmSrN3yySfGrsfbtZrz/PNA47wXcbv9KQ7scn1xWdWoukkB58nt0UaC
	aZWE98IKk2xinH+rEb7FE+BE61slFWyFbuLdn+8CFwwe7MKlYyrYSYd1sC2CBYwne37Lhslyjtx
	sfT2mJjQdvU8ZWyYBNcETUzlJ2iVFsCnYkyhnioHZw1hp5Y1hPRndS7K7ddvJlaoMX2ebegDP76
	BYxBVOtOwJv2Qe5pe0xuKJsLjeLDLxjlyWPQqWGI2sHfS8R4+nQcUl3SZ5vtoY1z7TC26gN
X-Google-Smtp-Source: AGHT+IF7ePNKC/efflqXHwYHgjxSxDTK8C6+GyU9k0GrT7S6haFlI4McuaUxqH1svu1wQ3PG3W0WiRmSfLdQYtAxFzc=
X-Received: by 2002:a05:622a:5813:b0:4b7:b1cb:5bd8 with SMTP id
 d75a77b69052e-4e576ae6a76mr55687871cf.73.1759508111841; Fri, 03 Oct 2025
 09:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Oct 2025 09:15:00 -0700
X-Gm-Features: AS18NWBvRkA8XJUstYFSzhKHyU5fYwBegMPqLVfkMF5poIlBOyx5qh3MF6NBsnY
Message-ID: <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com, 
	ssengar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds this
> limit, the driver drops the skb. Add a check in mana_start_xmit() to
> detect such cases and linearize the SKB before transmission.
>
> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
> send other errors to free_sgl_ptr to free resources and record the tx
> drop.
>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++----
>  include/net/mana/gdma.h                       |  8 +++++-
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index f4fc86f20213..22605753ca84 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -20,6 +20,7 @@
>
>  #include <net/mana/mana.h>
>  #include <net/mana/mana_auxiliary.h>
> +#include <linux/skbuff.h>
>
>  static DEFINE_IDA(mana_adev_ida);
>
> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, str=
uct net_device *ndev)
>         cq =3D &apc->tx_qp[txq_idx].tx_cq;
>         tx_stats =3D &txq->stats;
>
> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D MANA_MAX_TX_WQE_SGL_ENTR=
IES);
> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> +               if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SGL_E=
NTRIES) {
> +                       netdev_info_once(ndev,
> +                                        "nr_frags %d exceeds max support=
ed sge limit. Attempting skb_linearize\n",
> +                                        skb_shinfo(skb)->nr_frags);
> +                       if (skb_linearize(skb)) {

This will fail in many cases.

This sort of check is better done in ndo_features_check()

Most probably this would occur for GSO packets, so can ask a software
segmentation
to avoid this big and risky kmalloc() by all means.

Look at idpf_features_check()  which has something similar.

