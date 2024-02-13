Return-Path: <netdev+bounces-71296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABBC852F4A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCB21F21F78
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A636AED;
	Tue, 13 Feb 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+o3Q9Qj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265E2572
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823680; cv=none; b=ALoDWPoFV44rxV+HchOfm09ivcs+kI+71+51UmtJfsyO7GTgVZGW4wEUjhEpEZeTpE3a2qYj5j4+ORIzYaRtUTD/0N6huLNlpeMUnJJd/6KArDJPwEhDzkH5hCeNdRvYpbgbwctSLSd9ZnuxPTjtqH7Ohk2nNxsMmbLPc7DDawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823680; c=relaxed/simple;
	bh=zGYAV8TMb7U/4BOKssvfZr03LgKPZ3iJtvQWXH1Mu3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9usysR5HeOIE4s96cImWRe/+LLXliGYAlITLxuclMHuNBy5BYL89xsFLxMqN3F3jYq8NmlfxUOP/cLhkmtZwS7dUC/UeKrzTYbypa8DXZYbmh2oKLI4cZGsq74kIyxIOq63DRjh0TnVU4zPbUljTFFJHsvtTmm4jQeYc/gC7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+o3Q9Qj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707823677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJeJfeWCgddSoPM/BvroT2ozOZ7GHNV7RJQ4RN80A6M=;
	b=A+o3Q9QjEkPi/0ohcAxnNvFl7LAen4foBTPEKZh05PDYRmSCIhRzNpl9nmwV0pUjVS1i4C
	MUF5Rv9B9uyo2lsTQJB2oJa2J5klYnfImqd1HtbuKM4gM55abGN/NqS6RrtlN4tt7UBBD9
	CLI69yOf85AaM171rDdeewby9nBUVS8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-xCfolLF2OBu2vvNMW01JSA-1; Tue, 13 Feb 2024 06:27:56 -0500
X-MC-Unique: xCfolLF2OBu2vvNMW01JSA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78315f4f5c2so187811885a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823675; x=1708428475;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJeJfeWCgddSoPM/BvroT2ozOZ7GHNV7RJQ4RN80A6M=;
        b=SdqtDCPJ4lKmM5QALNaEb06Xz6Wj/ps5ngb++pANcFj+jG5yabClQFldc5fqKtSjdX
         Pw7yZNbBSky4ruZHAIp3RPKdetXaFUjKkgLd3Pr4r81/wr/ltXj/1h2AWt0qEMhKye9j
         yhHhEQ4IUZi4vpZpDwbyas/aBnUprMmri6y/TgcDf89eC3S1fHpB0UWKHrBf/kwvGAhT
         0/9t7UBR7QTm+X/6Cl9tPCS8eeJe1Z4w02c/W+2sr1uDSXds0vEst2paScSmib47Bxgy
         Q4rOyXu6yScP+zo8E/ZJi0MoM3FrR3mxc3Sd2IbaPrvtMtlJnDPWdHTzq5Wp1Y6VVEOQ
         50ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXsPDbZVm6LSOP8RfafQBs19DZepr4Szk3VpTdNsLBcQT7NGxg4tMQ7ADps18rPUDpymTqn/3zjBHKo4/TrYBFb0RVdsNU9
X-Gm-Message-State: AOJu0Yx8usypyGziUEtnYFO8uEmO+ki9mVjLJrQ10B4lzpi+OX3oLk85
	6TpBnQRXxdOSehxdPYqMHm6RA9Hb/hFRSFKmT5lcz46Xdp5DLDvd0r9XmIzzC5vPCobEtLRdIu7
	ca08VBgs02Bngj+h77BjYrUiELKYDfZc0YO/BbjoIpKNejV524CRuUg==
X-Received: by 2002:ac8:7d01:0:b0:42d:a98a:649d with SMTP id g1-20020ac87d01000000b0042da98a649dmr2572951qtb.5.1707823675660;
        Tue, 13 Feb 2024 03:27:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6N2W9KgPg48Pg1bwKLhxPIfGtKQ1JnWOUB0BaPTLddrqElYJOdmWBuzvjUY8GCVB51xQnZA==
X-Received: by 2002:ac8:7d01:0:b0:42d:a98a:649d with SMTP id g1-20020ac87d01000000b0042da98a649dmr2572938qtb.5.1707823675383;
        Tue, 13 Feb 2024 03:27:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpH7PQG60mkti7+3FO+VkVDm/V4qzvtDMh/pjQeBJqGDIFJoafbZ0YhCh6XubG64rgu0Vz9vynAjUg0aUHowgMNV3IMJ5sFBZid6NmD0Sdg6efmj9eB3rU7cqlWqv5cm6JPx4gH9sIVyKJqSKXq3JiWObGir9YvLK9R8nOklmpQnWtW86mw9qPfo1TQua2D7Osjm9aKFY=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id z6-20020a05620a100600b00785d4d5768bsm1751630qkj.11.2024.02.13.03.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:27:55 -0800 (PST)
Message-ID: <9f254fa79f100133319f1ca824becc0cfac38cd3.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 7/9] ionic: Add XDP_REDIRECT support
From: Paolo Abeni <pabeni@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: brett.creeley@amd.com, drivers@pensando.io
Date: Tue, 13 Feb 2024 12:27:52 +0100
In-Reply-To: <20240210004827.53814-8-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
	 <20240210004827.53814-8-shannon.nelson@amd.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 16:48 -0800, Shannon Nelson wrote:
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/n=
et/ethernet/pensando/ionic/ionic_txrx.c
> index 6921fd3a1773..6a2067599bd8 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -413,7 +413,19 @@ static bool ionic_run_xdp(struct ionic_rx_stats *sta=
ts,
>  		break;
> =20
>  	case XDP_REDIRECT:
> -		goto out_xdp_abort;
> +		/* unmap the pages before handing them to a different device */
> +		dma_unmap_page(rxq->dev, buf_info->dma_addr,
> +			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
> +
> +		err =3D xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
> +		if (err) {
> +			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
> +			goto out_xdp_abort;
> +		}
> +		buf_info->page =3D NULL;
> +		rxq->xdp_flush =3D true;
> +		stats->xdp_redirect++;
> +		break;

After this patch, there is a single 'goto out_xdp_abort' statement.

If you re-order the case as:

	case XDP_TX:
	case XDP_REDIRECT:
	case XDP_REDIRECT:
	default:

in patch 4/9, then you will not need to add the mentioned label in the
previous patch and the code after this one will be cleaner.

Cheers,

Paolo


