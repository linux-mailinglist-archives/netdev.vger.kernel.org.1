Return-Path: <netdev+bounces-233486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A82C143D3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6BA624A75
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6809B3093BF;
	Tue, 28 Oct 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoX60KGy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1023090EA
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649076; cv=none; b=qa9OswDXGxN8H+xbMwNj18m9fGnewU6lGA3BAy/CoIeF9mRYYx11K+nx15ZwWxHf/2zVdo6aFx6lKtSX7KaFSgcNQC6XAXmTGJAbYGk6NzuKQKwZ8ZxsHFDCEX/lTOIyyAIEjUzZJc2FrfjVRE0lKAtCs5+XJNakD4YPQG8hdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649076; c=relaxed/simple;
	bh=dhQt0bKJ9jTDhVK4Se77dIyzwulKfyFM8IP6do1bd2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4FzPYmJgyGrbCVOp7Z1C9s5rqH2VJtTd7Mhpt+aCo8Mcw1K2uhUOWkQRa4OhohaNA7FSwJpChUY9/2VlRiBB470Rqllbw3hrD5Am3lz5ljjFCdRTxC/3QTYJyCYiNGg7EK1vsaUSzSmrAYnGrtQDHtYv+DGtF7/WFhxFmtT92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoX60KGy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761649073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ss7g9OPGrAkY9kUcGCclPiLcw52MVKuR0CuNg2oTpdY=;
	b=GoX60KGyBU7TaI352OE0Ic9ZAlHFkRFOugnC/z/ujAlg5NvjtAiSj88+61XRw1nuXR+yGB
	T/68B741Q7uOr0fjluU/s+fmHlKCRgGl0S5Zhsx7lwvrDUjbOVy3jV2kFL16qHcBr03flA
	BylgLV1b4MzMPmzKFSs2jZx8sGOyO1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-rq8ACNe6ODy7rB4D81qtMA-1; Tue, 28 Oct 2025 06:57:52 -0400
X-MC-Unique: rq8ACNe6ODy7rB4D81qtMA-1
X-Mimecast-MFC-AGG-ID: rq8ACNe6ODy7rB4D81qtMA_1761649071
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4710d174c31so54460555e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649071; x=1762253871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss7g9OPGrAkY9kUcGCclPiLcw52MVKuR0CuNg2oTpdY=;
        b=ESYyL6X/8he20MXIkWhffsrTsmRXGEq/PL5v76nkYGjTKP3CoXvwSWu05WVS8QGRgP
         6lnVLzcG0IaBjmlJPROlS/ZJ8oimJp1g5wPKEUxqVvajWoLbhNfPxiO4Aq1VASMPnRbY
         pm5QaM35cgaIqd0N9+M9zTe15hT7Gb0uLXiKkC+Ua8Y+9kUrIYAJTr/pfZ7LFZ4N46ow
         6gLn5Kx1bN0ASFRA/ZehGGJg8N14mhCMicpnHhJBecA1ESkuBQmD+kG1cyqdjOWpZBDx
         EipKT5vCBrcpzfNK+565xj5BEWT2vaCtCjxAmpw6t+wjm2U8Z987vMZS4OzKyby11uYZ
         3rWg==
X-Forwarded-Encrypted: i=1; AJvYcCU9AIEv3fY5s0bzvj0TZB1pF/CjvCGfoxGNLPSHFmK8bcRMxG7EC4xXJF0T3L7K/3T84/1mdZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWE9JTFo0Pu4SrpkeXyIfkpW/C350nT6iGD/MEWk3lz0SIGwDL
	BkXtHebyZc+A0p77TdOyxgrjQRU9g1Kky219cOOYXkwDkpLqyztHmZ+XUN9iAttJyK1AZVmMJjq
	IaOY/wJrJeNEfK0RqyfJJWh91Inm2nf3KO4okO2J4QKXxz+Y9P5I0fb8kMg==
X-Gm-Gg: ASbGnctnsJAJczUbJvkJ2fymCjM8H5ZMnK62usWLv0cTEpSdkbyfDYc3d65NMs2pkAO
	Ray3pl7XdB+FaQiDxNtCYGFsE96l/D3Yw8zLjoey/cJHB6mdlMV/Jp/95uMCdd/ppXCKUgNjenu
	9Fkf5sjBJkrLA4InuYJrZE0gMzoqAzTzm8vXkeXgRaWe4TOyKOFQQzoQCMt88uTheVK6hMTTvqG
	rAmksGGGAfBO26G1rGTlN9iXFWn3SGcBVPgn1DePSN1ThQaGks1TO3dYozVgn03Q0IBtBi0/KKR
	Jrhf6kTfVjUV4FPnYhpd/EZOv2t7L7yRVdJ2SZY45g64AvYThO7U/jddDKDXELp9eTts+2dUKwH
	H8SmiemPeo4UzCE7wx7siIKRVmxUkhFimzqRZmYqQaBxTdNY=
X-Received: by 2002:a05:600c:34c7:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-47717e30340mr24822195e9.25.1761649071043;
        Tue, 28 Oct 2025 03:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErU20c2eSasDdwQZzdlRNWvVKDbbva3lmpIExHrHtMT8SPwj/9JiHFRH8lMSjet+8CB83SCA==
X-Received: by 2002:a05:600c:34c7:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-47717e30340mr24821915e9.25.1761649070539;
        Tue, 28 Oct 2025 03:57:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47853csm191118005e9.13.2025.10.28.03.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:57:50 -0700 (PDT)
Message-ID: <05efdc9a-8704-476e-8179-1a9fc0ada749@redhat.com>
Date: Tue, 28 Oct 2025 11:57:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] net: ti: icssg-prueth: Add XSK pool
 helpers
To: Meghana Malladi <m-malladi@ti.com>, horms@kernel.org,
 namcao@linutronix.de, vadim.fedorenko@linux.dev, jacob.e.keller@intel.com,
 christian.koenig@amd.com, sumit.semwal@linaro.org, sdf@fomichev.me,
 john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20251023093927.1878411-1-m-malladi@ti.com>
 <20251023093927.1878411-3-m-malladi@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023093927.1878411-3-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 11:39 AM, Meghana Malladi wrote:
> @@ -1200,6 +1218,109 @@ static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
>  	return 0;
>  }
>  
> +static int prueth_xsk_pool_enable(struct prueth_emac *emac,
> +				  struct xsk_buff_pool *pool, u16 queue_id)
> +{
> +	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
> +	u32 frame_size;
> +	int ret;
> +
> +	if (queue_id >= PRUETH_MAX_RX_FLOWS ||
> +	    queue_id >= emac->tx_ch_num) {
> +		netdev_err(emac->ndev, "Invalid XSK queue ID %d\n", queue_id);
> +		return -EINVAL;
> +	}
> +
> +	frame_size = xsk_pool_get_rx_frame_size(pool);
> +	if (frame_size < PRUETH_MAX_PKT_SIZE)
> +		return -EOPNOTSUPP;
> +
> +	ret = xsk_pool_dma_map(pool, rx_chn->dma_dev, PRUETH_RX_DMA_ATTR);
> +	if (ret) {
> +		netdev_err(emac->ndev, "Failed to map XSK pool: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (netif_running(emac->ndev)) {
> +		/* stop packets from wire for graceful teardown */
> +		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
> +		if (ret)
> +			return ret;
> +		prueth_destroy_rxq(emac);
> +	}
> +
> +	emac->xsk_qid = queue_id;
> +	prueth_set_xsk_pool(emac, queue_id);
> +
> +	if (netif_running(emac->ndev)) {
> +		ret = prueth_create_rxq(emac);

It looks like this falls short of Jakub's request on v2:

https://lore.kernel.org/netdev/20250903174847.5d8d1c9f@kernel.org/

about not freeing the rx queue for reconfig.

I think you should:
- stop the H/W from processing incoming packets,
- spool all the pending packets
- attach/detach the xsk_pool
- refill the ring
- re-enable the H/W

/P


