Return-Path: <netdev+bounces-54381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE17806D4C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D94B20CEE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC5130F8A;
	Wed,  6 Dec 2023 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFDksTkf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB101730
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701860662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDYjHVhXPeH2V5TWh6ZarRnt5FVTLVs/MBnz4QtQI0A=;
	b=fFDksTkfDDRz8rvaFaJe94vs3zmW+o1MT8Fw+Jyp5CVZuHoR6CFFCQr692Z3hv2affGRxT
	VYZotyJkmLxTVWFaia4HvclS1UpQgwifm5FmPsnRCzTKmUgxtIaU6xADsRY1W+B2y6l4k6
	+3+tPjs+eMhehenoX7l4Ik/JdgFQuAM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-VfL18SXtPLOKAaSZK2kTQA-1; Wed, 06 Dec 2023 06:04:21 -0500
X-MC-Unique: VfL18SXtPLOKAaSZK2kTQA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a19a974cccfso87637266b.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 03:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860660; x=1702465460;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDYjHVhXPeH2V5TWh6ZarRnt5FVTLVs/MBnz4QtQI0A=;
        b=SHBrdh3M335oVOIzZFKA5jwvbXuGc8xd1WEWfgQomQtyEBF7luRZhOZ6YZUOgE3p9E
         ARJGFI1mZZfZIgTyt31+QXv6Ys9KKG3LLmS1yDjrolFLpyj+1o8ecxniuaORDpGO0yp4
         OSDCQ1wh+i9FQ4537KBG6jnRkIwjToEUW9a4L4kavGaTuDPhRs7OmcxbSRtNR6i5zpbI
         E+09h9TLyO+J12+e/M/+c2A2rhKt8s+M4ZAZInVC88uorvESWrYBO1J3xfOqQiRnP7rc
         j1fUo9lT1gTULE6uLxgw1eJ+lcjjd+YHCyqOK/BZyl8D5gIOFMtn1JHOorFkEUNy2H2M
         w/SA==
X-Gm-Message-State: AOJu0YzNObM3FBGWmCNDec7uXx5lS0Qh1EvYfxNQAPlg8qDW0AqlvPCv
	pblJ3XpYmMSoPuKRxn8427uQCIgjzZAypqWF7pSJac1M5LbsbBOvB3Wg/Z91XwGQsEj++SCes00
	qLPSC6YDZ68kyM+eAxYCNyC+O
X-Received: by 2002:a05:6402:2787:b0:54c:6431:6910 with SMTP id b7-20020a056402278700b0054c64316910mr1046392ede.0.1701860659802;
        Wed, 06 Dec 2023 03:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH14UbzRAuRthyw2lhyFrFxnxISkCJuNT0eIh+fzK2oEkp8jZYs7id0JDM5xfetQYoce8FyEA==
X-Received: by 2002:a05:6402:2787:b0:54c:6431:6910 with SMTP id b7-20020a056402278700b0054c64316910mr1046373ede.0.1701860659511;
        Wed, 06 Dec 2023 03:04:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id f15-20020a05640214cf00b0054c9177d18esm2263549edx.2.2023.12.06.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:04:19 -0800 (PST)
Message-ID: <b33f982180788cd6b68fa1cd4af40ad6f65cb905.camel@redhat.com>
Subject: Re: [PATCH net] dpaa2-switch: fix size of the dma_unmap
From: Paolo Abeni <pabeni@redhat.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Date: Wed, 06 Dec 2023 12:04:17 +0100
In-Reply-To: <20231204142156.1631060-1-ioana.ciornei@nxp.com>
References: <20231204142156.1631060-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,
On Mon, 2023-12-04 at 16:21 +0200, Ioana Ciornei wrote:
> The size of the DMA unmap was wrongly put as a sizeof of a pointer.
> Change the value of the DMA unmap to be the actual macro used for the
> allocation and the DMA map.
>=20
> Fixes: 1110318d83e8 ("dpaa2-switch: add tc flower hardware offload on ing=
ress traffic")
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b=
/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
> index 4798fb7fe35d..609dfde0a64a 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
> @@ -139,7 +139,8 @@ int dpaa2_switch_acl_entry_add(struct dpaa2_switch_fi=
lter_block *filter_block,
>  	err =3D dpsw_acl_add_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
>  				 filter_block->acl_id, acl_entry_cfg);
> =20
> -	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
> +	dma_unmap_single(dev, acl_entry_cfg->key_iova,
> +			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE,
>  			 DMA_TO_DEVICE);

I see a similar unmap in dpaa2_switch_acl_entry_remove() that looks
like being affect by the same issue. Why a similar change is not needed
there?

Thanks,

Paolo


