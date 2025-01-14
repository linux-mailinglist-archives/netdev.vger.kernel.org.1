Return-Path: <netdev+bounces-158087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E4CA10705
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1779918822D8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F2236A9B;
	Tue, 14 Jan 2025 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFq3cSND"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B747236A8D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858650; cv=none; b=OBYG9mxdfgegr51lcSHU9llklSxDVYcg5ERBDfXlc9/xQId/VkvpZEfAfq3QKj+jU1ro4yZ8X+gWAzscbxnKBm2ohFqIHDBxl342N0Hif86SQSrbcdZTbPOIOMc3FCGWPOtrnpmP/lA8BAw1PWKAgx4q8+XtQM9ZtwYbkOsjArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858650; c=relaxed/simple;
	bh=OMKrfMlZN5TDVYArU+0YAZRjYiiWfczb/1GftAm3SMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bGo7ZqQTN5rfMtis24/rSKFCK24ZyqizzbZKMoeWAX85kwMMWyNwsgZT05YCNq1zwLfzmmFUF78enTurCspJz2Ra4nwFejY+0Tnk7lcklLBPWfssvPUzbwubCB18rSSkMYlyH7WIuNoeFT3KlP6PARita3T/lCmM6dA6waY99dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFq3cSND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736858647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ta39/7Gq7xX5aLwxAYnRlrTh0UUs0/WJpTt34X/Rrf0=;
	b=HFq3cSNDANQUZFPuMFx0rS+bi0VZQ+SyolWeWmFSxQyKiFERW9DZCUhRj88SmLl1I8OALv
	wQSggHhb4UinNrzxsB2ZPhs/Hb1w+Hx9+fpXUZPbIcUfPPO9O6d2WzrJ4DNUIewpoOs/Ue
	4dkDLsCjIjqKmGwA/jX5CRKRit0QqbY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-7xgJdHqzNnaUeabvFNh5fA-1; Tue, 14 Jan 2025 07:44:06 -0500
X-MC-Unique: 7xgJdHqzNnaUeabvFNh5fA-1
X-Mimecast-MFC-AGG-ID: 7xgJdHqzNnaUeabvFNh5fA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d6ee042eso3287389f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 04:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736858645; x=1737463445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta39/7Gq7xX5aLwxAYnRlrTh0UUs0/WJpTt34X/Rrf0=;
        b=fz4cU9h3hCBiwosCIUVsKxS09VBez+goa6TDqzhEJRHC809n5/QtIKLvlPNbQO+PnV
         a7LDXINn2EnVFYjwBYQtdBSQ1k7JsFpgZ3PoY/77YCRFgW0p133/frHjWcPLDRm1B+zQ
         a4WWTkA/qP2QSNx7+6LXbxP9g+ZzOpuXb0PyM5c0DXjHBrGZegG0Obr6210TRkCSXjmQ
         9z/6xOA216vA7CfYpVEVsgMyMbSapR3BNZ+13NjRMeXsyyFVkfs+chepCKRtPWsJW90c
         p0TNFq9X73/WIp3HXvXhpg9pEyXZAZccoIyM2zKM35eNVpmyobYUqcME9U0q3RSVEuCI
         kMzw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ubQr56+tX+MirwE751Sh1cQ/gk/3sDv28GuVBnWB8I5nKELb0cp98DJnpFFggiYZeD3LV+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRWX6QWai9DpbBUpgCek9XtcBBfjrrYL6IbIR7uyxbQilOrbX
	XDbQX/9QiJjxIbCYIveIh2LIQrzJe+sj3SkRDRnmzWaRFpnGlbQT8wOd1fUYP4ARnDdHIKD+Nis
	3J0pPdj3YbwQiVPeITT0UbjtdM7Y+V7vE+cJPDcDFZsmwmBE36ji3yw==
X-Gm-Gg: ASbGncsfUjc47Uae0quv8AOeA5pljvyKGqIEYzQUtZCm86pMP9u4e8bb9PRnRTgx9wp
	AX3vp8N+OBMSmRz/RvG16LooMnJnnjJza5WlEbWUu7SrKTTi1bg+pISJme7TQc5wkQScRg05Q98
	hiUvmT/kr6cfxwyI7toYr7fbo+RoyGmdVWqKHpmKYvWxTjAngaBjZpaLaCi5bI5oSU9Y1QMzurO
	g/IMriYl3qfKIhf9g1CDKxWN1wwTYqES8C7zDC8EnDFwcbc6Pp6xwlN5hcTvCAQuP/A40ctwYox
	QrQDCxQ2dCM=
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-38a87317e45mr20803708f8f.53.1736858645123;
        Tue, 14 Jan 2025 04:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8z2W6BEbpjKGLRHPJS/UY8AoBh/kFNQVVZ6bs77tXT63OqEK3gkw3n8/KgPqqOevuPHMV2w==
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id ffacd0b85a97d-38a87317e45mr20803688f8f.53.1736858644819;
        Tue, 14 Jan 2025 04:44:04 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37ce18sm15105147f8f.14.2025.01.14.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 04:44:04 -0800 (PST)
Message-ID: <2e4d11f6-843b-4e25-b4d1-727dc4edbefe@redhat.com>
Date: Tue, 14 Jan 2025 13:44:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 1/6] octeontx2-pf: Don't unmap page pool
 buffer used by XDP
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-2-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250110093807.2451954-2-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 10:38 AM, Suman Ghosh wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index e1dde93e8af8..8ba44164736a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -2701,11 +2701,15 @@ static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
>  	if (dma_mapping_error(pf->dev, dma_addr))
>  		return -ENOMEM;
>  
> -	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len, qidx);
> +	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len,
> +				     qidx, XDP_REDIRECT);
>  	if (!err) {
>  		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
>  		page = virt_to_page(xdpf->data);
> -		put_page(page);
> +		if (page->pp)
> +			page_pool_recycle_direct(page->pp, page);
> +		else
> +			put_page(page);

Side note for a possible follow-up: I guess that if you enable the page
pool usage for all the RX ring, regardless of XDP presence you could
avoid a bunch of conditionals in the fast-path and simplify the code a bit.

/P


