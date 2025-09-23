Return-Path: <netdev+bounces-225481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A66B94251
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 05:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2F83B7E32
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481001B040B;
	Tue, 23 Sep 2025 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ebwQJumU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE5AD24
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599275; cv=none; b=OKouKViV4/CUeP6nXgpXSowqrbf/ugSiUPRUUOyMZJ3YbJDc451cJverrzku3bSiFMxkLzpFd+dOrkUNvwYeV+yCuJocaqzKFnSp1H2PxcDjXaj06C5bqiEwCFAjJg5BtbuuI7BSc1prN2RBKVFXM/F/giJrc4MciSSyzriP/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599275; c=relaxed/simple;
	bh=bQGdg7yM0G379KQ+yE73tGM4Xi88anrThiadA+CtQKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lnsrnzt7SdGXZsNuYpO5clrADVfCdE10LXum81FGIo7MjXWyb02ngu9ytxPLeP7ePXSXMt57sQI7cRY+NBEwu4O8GUvYIfcwRB/kmBOVFs/gFseQwE///NuY9GxRBnKeSQuneTSPoto87QEVfn9hcOZk+jUOTlNs6uZsxB2IbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ebwQJumU; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2698e4795ebso51338985ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 20:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599273; x=1759204073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkWmI9pm0Q+PEDKmfvpOccyiT6zs20dN0vwDFm3sBOs=;
        b=ZRKuGa3zFPsUfv/30IiLn9fPNaaHBpiXHWjmT/ypp4f1vPSoNFITOe/XtUs4OmFvXm
         WAAVvdyyhJPwqRtJCTLGfFNwzsIQ4xFvyWqPFb/pE5VdpO74BBQ1m8UWJkLreC6Mq5+k
         qyjfptyBhe2mtunI/O4Q4fqLWgsYAI3VjrXvXs67IU/F4bGyNJK3hjeP6taIA0aKuv4I
         yHO9mteCVXIHkQmq59J20HRS1Lp0RHomltIUi3IQWzHbAm1GkmtvJtFzli5gj0CcYaJE
         nfXnSEBGobAwTk72txOWW3GqfPvPMUoB/KQ9ej5G2ULHiKcMc/KlODPAslqdATNBWmCj
         NfPA==
X-Forwarded-Encrypted: i=1; AJvYcCVjTv3NlTKitubeKcH8VToAytK191pBi9fJgtdublCFJxxQVW/7ypOONYLGb7H8uY+2W7HVhro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+rWI5/H5pt5TBB6RdwufxdFtcRFCziJoqsXClm8rBmqvflIC
	HWFGviAk/8uAROmdC9pmJKe/5lbdGHQpkaOFjStSRAenmaAs2ScCynB5ehBA5whOLodyy/+gssA
	qAdq2lKBMJfUclB09D3IOa3Gc1U38TLmn7dFYpxNGxol/yMTv4SVyhCsMA+vq1hxEZJD2JsjIiH
	kPNRAvFvtPduE5+Tye7HuCHgbG1zIG6I6qyQu/BpULWq7LmjZlkolzfA9bAcU3NIo6JCz/D3l2u
	HpPJbBR/MM=
X-Gm-Gg: ASbGncsNSz+DXRf1euSQ7ghOcMG9B/JnbbNINEnyhVqq9x+ZI7PRFUiI5HBA6D4IjjP
	qhQ4Zh2aoT738MCCG+Px3MGGIxQOCBW1hqXHd1znE9ANj6fvFijOwLi6cHfF0mWhTAVrqM3utJf
	XEK3dH+TKAwvCcxtnt7U5jFHLaNbqdpjAJMgAUvhTU6vwExH2ROkJrJYpskMbNcxv5HZIc9y4KN
	rBZb7rhemQtosN98xrp7B3Z5eOc2xa7qMRtpr1hmdBIA4eFkq63JaYiikkAq7JUAWAjKqe4kZCy
	VCN8ILYa4H4e52rhnf7i7qqWZi1dXaNx7AeJLwOLvrJh/kzE5hehZp9mOw0psGaVke2LXEq1JWb
	326YAqxg3OLstxg/+x3J5mXtWAqdcbn+KG/6gtoFrfIx7PE2MYvuo9S4zCmXOv4yHns3DFCVG2s
	0SsA==
X-Google-Smtp-Source: AGHT+IE5oJWSVEWwBD3UbfcuRJDGj3qhizUr+/eQAm+xI6mnCwh97hpBQl4VtiFw0bRHqiExYfd2PYnMwNbv
X-Received: by 2002:a17:902:cf0f:b0:275:8110:7a48 with SMTP id d9443c01a7336-27cc54318a3mr15058815ad.39.1758599272916;
        Mon, 22 Sep 2025 20:47:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-270c5837c10sm4968075ad.18.2025.09.22.20.47.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 20:47:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-324e41e946eso8693491a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758599264; x=1759204064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkWmI9pm0Q+PEDKmfvpOccyiT6zs20dN0vwDFm3sBOs=;
        b=ebwQJumUp/OXtTzpXZBVv27bqUnEokUTaEKW14BZbzWmr9ciY3KdTdnJ+2im+Kga2v
         GkRxAHc3LFSaI/xooELSORCIM9lt62KRO3LGtUsEUTpLpYQ2pQC+zzb+6ZMeMrn/iG6T
         aXsgMmYJjJ2GA12GbFTlYInW8+YFuYt1snCn0=
X-Forwarded-Encrypted: i=1; AJvYcCXqy4+dqBuPIdb94UjH7jN8dQX0gM+sFj1JjJzi4P+FS41vRxNvfdx07SaN7pd/mzX9ztfQVbE=@vger.kernel.org
X-Received: by 2002:a17:90b:5109:b0:329:ed5b:ecd5 with SMTP id 98e67ed59e1d1-332a95b8b8fmr1337307a91.19.1758599264118;
        Mon, 22 Sep 2025 20:47:44 -0700 (PDT)
X-Received: by 2002:a17:90b:5109:b0:329:ed5b:ecd5 with SMTP id
 98e67ed59e1d1-332a95b8b8fmr1336921a91.19.1758599253171; Mon, 22 Sep 2025
 20:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev> <20250922165118.10057-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-2-vadim.fedorenko@linux.dev>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Sep 2025 09:17:21 +0530
X-Gm-Features: AS18NWDegvdaY83xtLHBitmIWLHay50k0_cn5OEjXImxFaSwiTrloD7KWxNv6Jk
Message-ID: <CALs4sv0e8Km3nbABTzNg+y1HTKdbAX3V2rBb4F_vVJ1zF=MpGw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 22, 2025 at 10:30=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> Convert tg3 driver to new timestamping configuration API.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 66 +++++++++++++----------------
>  1 file changed, 29 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index b4dc93a48718..7f00ec7fd7b9 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -13929,22 +13929,20 @@ static void tg3_self_test(struct net_device *de=
v, struct ethtool_test *etest,
>
>  }

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

