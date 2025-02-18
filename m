Return-Path: <netdev+bounces-167277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79271A39902
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375153A2040
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291723C8C2;
	Tue, 18 Feb 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJIlFz8f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DFF23957C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874391; cv=none; b=I+Gq8gxJMJN8T8bl/rKLejj57w9e3pqxgrBHwo+HApYCSEM1serM8y67FGMJR4SE3w42dMLGTX70rHJ6bGgTEEunJgx8dnmsMk836gGzTMuZVHpfTJfhSG0ECaGsZ/ENhLlvHZS7ZIwlWQ/OpFfTdt6iQy3TW5hZxEFr4uwhwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874391; c=relaxed/simple;
	bh=lTGVYVOIgtjNSuSseJT7KQGGiUReOwLr3tUic5SDfP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MrGoVi8L4xh0iClfRXbKB+Aorc7fGfT7wgNLkJ98tDww9Wdz1dPJLetllBJZDTqLM8kg5Y7LQfJ4krfaBYDMBuxVTQiO9ZuRtOSYH20L8DBlF/AsmeG6HqhMxqybdWpfSMCfcx4TU40i6xXVLJfaLktvrhtziLKOUrN390uBvZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJIlFz8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vj8aRneA036R40Z/93/r0n4BsJ0KrjIQQUbrcu4BIVM=;
	b=fJIlFz8fhKjMNuDYkNkYU4agBDaAtWnpkX0tMYFrxoYMx/cEKP/i5aIj8i5/rD+l8BkLuy
	I4m+RfwckfRlN/tgcYOp1hou1wHwZtQoecp/vMGK7Gtocm13248R46nL8j0p7JBt/EHwm9
	eAFdBmUzecKkTf5GCt7AlOFwlaEVMCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-pwRIPk18OB2pU9yL8oGm9w-1; Tue, 18 Feb 2025 05:26:25 -0500
X-MC-Unique: pwRIPk18OB2pU9yL8oGm9w-1
X-Mimecast-MFC-AGG-ID: pwRIPk18OB2pU9yL8oGm9w_1739874385
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso27051475e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874384; x=1740479184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj8aRneA036R40Z/93/r0n4BsJ0KrjIQQUbrcu4BIVM=;
        b=OiaK7NfrwByuGHqaG0M9Zq92zQWLI0ZdIq3ofmrgMd4piKzEOPvAq/uWxGuIbmysH5
         HyawbSnwwkgGRdgXD7Lxfh0TT9VJabBhAFIP4Obd/DxyaDu/kUf2nGPLjZ/llkHMaIBz
         K5W1s0xBKSC28UrryoGSelEsIsyEo3v9XjORa4E7Y7M5QPwkZN4MJNZXjEwiYoiUDF8T
         xi1zUnIF0C/H1fPDUZhWx2LXOpiY3lH+8DJ4VszwyOERdKhkFfEHVdI+fcq/jicjPcAf
         lGKk8f0S8Ij+S/xoTT08T0qJ76wnJdMJaP1YXk41Kd/ctnlSfubsyakb4M1dpnDmAvtT
         d8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXqhIjpoxO36TRF+Vntt/LeSHNqUN8bJpHM0Ez35lb01Ru2Rd+pXXvFkRdfXTbvd5YCONgxpe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26OhfBsIcgqRWiLALeIL3UNJDT0plgbXx6dklnEd7qD/SzHnL
	L9LrxBGNBOVH88ddK+CqFXONzwNoPfa7BYTPq4ykThSLxHXJg5T740cVetIm4jvBSA5cDbocetq
	xE+6iPOjE3S/85Ac1JufkKr4Qh0tqsuambNkCekTGmX62HkREtjaLLg==
X-Gm-Gg: ASbGncvXkEo8ZAgJuYp4ehEHgyLOkevxy+Bi6J6wq9pwDm1nCDWniyZMtDgRU28yUbj
	9MvVKvfwTysXRs2I7/4aahrjmsyBW0rNA+kNIoIti1zmItBTXw2R6BS3m034aZaFtQROP1Z16EM
	0eyxcvV242x8pHX6zN0WVrFznfLq4GlT8SYRXwmMpBndthC4v2bG3iN+Mn6CDaK+ute1ami3Njz
	s2HNJL646sglyrvMzA/CALAujKmDdAUEjlylvFJuyNdxSQE/r4hjprx2+sErukjpu1tqpS25+U3
	VjSH8FmvOgvJM1fKUOA3mymLybexzpbOvBU=
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr116417555e9.23.1739874384575;
        Tue, 18 Feb 2025 02:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkSU/VSnOl2Lx5jSHDnvFMf1SdmHIIFIgmwDPLjf61CIhWkI2u1PLCMfAvVZ5aFuhqVLRdZQ==
X-Received: by 2002:a05:600c:3ca3:b0:439:5f7a:e259 with SMTP id 5b1f17b1804b1-4396e739aa7mr116417345e9.23.1739874384260;
        Tue, 18 Feb 2025 02:26:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm58367795e9.16.2025.02.18.02.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:26:23 -0800 (PST)
Message-ID: <1ff73b64-2745-473d-a12d-87e1501262d5@redhat.com>
Date: Tue, 18 Feb 2025 11:26:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero copy transmit
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, larysa.zaremba@intel.com
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-7-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250213053141.2833254-7-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 6:31 AM, Suman Ghosh wrote:
> +void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
> +			  int queue, int budget)
> +{
> +	struct xdp_desc *xdp_desc = pool->tx_descs;
> +	int err, i, work_done = 0, batch;
> +
> +	budget = min(budget, otx2_read_free_sqe(pfvf, queue));
> +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> +	if (!batch)
> +		return;
> +
> +	for (i = 0; i < batch; i++) {
> +		dma_addr_t dma_addr;
> +
> +		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc[i].addr);
> +		err = otx2_xdp_sq_append_pkt(pfvf, NULL, dma_addr, xdp_desc[i].len,
> +					     queue, OTX2_AF_XDP_FRAME);
> +		if (!err) {
> +			netdev_err(pfvf->netdev, "AF_XDP: Unable to transfer packet err%d\n", err);

Here `err` is always 0, dumping it's value is quite confusing.

The root cause is that otx2_xdp_sq_append_pkt() returns a success
boolean value, the variable holding it should possibly be renamed
accordingly.

Since this is the only nit I could find, I think we are better without a
repost, but please follow-up on this chunk soon.

Thanks,

Paolo


