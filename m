Return-Path: <netdev+bounces-71284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC0852ED7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B951C21330
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4302C69A;
	Tue, 13 Feb 2024 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EM43pn/F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92936AE3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822748; cv=none; b=fImR9PsnIZBW7CuqJq6bEqjsOudeZK6NHosLqcGB0rsLKtGRn1jLhzpdIhta+IXpqkyipMB1repBBJBfwu1W2NNM8KpYVgymft1ctl7AXWgGEHCF19vxn3S9LOprZ4LVUWcNnnsAd0n6/jhkrNuGOGN1X6hLj5ls841QdPG4msA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822748; c=relaxed/simple;
	bh=uNR0ECv1rdN8pDphdyQnu3aGXWwqjx0igX5YYKRXEvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJBA7USMlE6qO0yMubt+sxtjReOL1Z5PaNnSQ8jEYl+SbmY54WU5o4FUum4/XN7MtTMRaJiLRXgHdeegm9q78FJq0bx6gDbnt6hrPmq3kX4Weeh4YnduxKtTDG/2/GMUVE6yWD0Vrst+xng9L5sQf31YjOH0wwVi8K920VY73W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EM43pn/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707822746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZnYJAnFO10tHgYEI0f3DuM22xU1tmqGc2WHh/z/ef9s=;
	b=EM43pn/FRCjrnVtPPweSdkOlzumzfNWZ8//1cnB2EwqILPhzwqEvEWlecT4dNE8ruBfsqa
	Nbie+mS9leiSmk4pZn0U1jX8yoVlqyjjzeGL6cCxG+O3tLJRmEo3WcQZZ4oHsusMdKwSuv
	acWMZcZE0E00U1lXEYLg4UmEUhKWnXY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-r1K5u1mCMPm44zWdEHhBOQ-1; Tue, 13 Feb 2024 06:12:24 -0500
X-MC-Unique: r1K5u1mCMPm44zWdEHhBOQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78313358d3bso246212785a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707822744; x=1708427544;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnYJAnFO10tHgYEI0f3DuM22xU1tmqGc2WHh/z/ef9s=;
        b=XvhK6Q6smp4E2BMlOIoY5dxK7MlUpVwSfZqwpyjYsbJrBns5Y0Kl8AqddUtQmAwm1V
         eRT+feR5K2Do6AiPjiXu7rTd240QA79oYhMZYf8600J6CoaSYALEEtXSga2e0Bogy5rs
         CLRZWTqehNL6PvTQh3Zdw/1VevP1BYv4p/YaLWwRwMlBsBp6tAwmfdDYrig91HBEJ+RD
         Om0EhKT4wGX66ba4PGLuAYco7LdfzUv7lOxMFN/xwya+0YI/2qJSVEGTdvP4t+RJ2IQc
         AjtYVhdhHKbr8pIjk2TPq5EH7x+MZ0OkXy2cGwRnNEVeIIih4B4YbCPffYbfYBrtgPTa
         Ql7w==
X-Gm-Message-State: AOJu0YzBfy6mji4wF9TVbaxZGXpt6c/EP/Ub5w+gh/9BELYE2UCDpqka
	Q9M6ac0V+RtaZOwl7yZdcyF4NXd3XQ3+zLf1gWbLX2gq/ELXrl1v97omG9RTjhmNVUD9btobnZB
	t/t9zt2fQS2Bx+ImhdcaPDwzaUlmO7i8Md9Y07i0n0SpfP1N9VWF2Kg==
X-Received: by 2002:ac8:7d96:0:b0:42c:1ab3:bfd3 with SMTP id c22-20020ac87d96000000b0042c1ab3bfd3mr11665874qtd.0.1707822743866;
        Tue, 13 Feb 2024 03:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQGAOoi3aqbm3bqIyaOw4DGIFA7r72UULy5tZcF81Auq0cO7JY30n6o53F7Gkuan0dfzLxjA==
X-Received: by 2002:ac8:7d96:0:b0:42c:1ab3:bfd3 with SMTP id c22-20020ac87d96000000b0042c1ab3bfd3mr11665862qtd.0.1707822743508;
        Tue, 13 Feb 2024 03:12:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsKuoSUaafs7Cu7wObRbc23jxtSGJ433GnvvoqyF/Q24y1+5V43Mf961JJ3q6P3VXZjDygB1A4bU5oNoiSO2uX1FF8lNLZGDIWi5uAmZnOwCKFVG7Kn3c2LzmplaDwIjUE9U0jODQoh4K1JX3TxnfvHhD4RURPb6By5iLKqC+x8Xqh1SLj1enjaGgczO8u6KY7V7CznX4=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a035b00b00785367e5a93sm2865193qkm.77.2024.02.13.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:12:23 -0800 (PST)
Message-ID: <0a0655c04c98c56eceb8ca6bfe4a74507978a4e4.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 2/9] ionic: add helpers for accessing buffer
 info
From: Paolo Abeni <pabeni@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: brett.creeley@amd.com, drivers@pensando.io
Date: Tue, 13 Feb 2024 12:12:20 +0100
In-Reply-To: <20240210004827.53814-3-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
	 <20240210004827.53814-3-shannon.nelson@amd.com>
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
> These helpers clean up some of the code around DMA mapping
> and other buffer references, and will be used in the next
> few patches for the XDP support.
>=20
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
>  .../net/ethernet/pensando/ionic/ionic_txrx.c  | 37 ++++++++++++-------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/n=
et/ethernet/pensando/ionic/ionic_txrx.c
> index 54cd96b035d6..19a7a8a8e1b3 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -88,6 +88,21 @@ static inline struct netdev_queue *q_to_ndq(struct ion=
ic_queue *q)
>  	return netdev_get_tx_queue(q->lif->netdev, q->index);
>  }
> =20
> +static inline void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
> +{
> +	return page_address(buf_info->page) + buf_info->page_offset;
> +}
> +
> +static inline dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info=
)
> +{
> +	return buf_info->dma_addr + buf_info->page_offset;
> +}
> +
> +static inline unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_=
info)
> +{
> +	return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->page_o=
ffset);
> +}
> +

Plase, no inline functions in c files. This are trivial helpers, you
can keep the inline keyword moving their definition to a local header.

Cheers,

Paolo


