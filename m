Return-Path: <netdev+bounces-242242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4440C8E0BF
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 143C434E349
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264532B9B8;
	Thu, 27 Nov 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P38vs2NH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBmxYoFL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370632825B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242969; cv=none; b=EASA5RTZHcHdn7CmjkRQoTg7JsqJpoLISHDjkDZmiOR+YcinZ5OhkW1XpPFITqXTOzMGsA9ZpZaVR4gc4uwVEQHmfLw7N8rjQSJYCjc6DVtrn1HFf/EIDJEj7Wfpy+Vi4ITekjWj4XNnweyKAsEDqEaDFUuS53W0CdpSIgcu0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242969; c=relaxed/simple;
	bh=Xbjo83qVcjekxim+HDA0ZQ+uPHFdYUuQhXzoPjb23RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnbFo3TjMjicTb72xw9eR2ce9pfBfvWVQ14mQopPDJfUAdvJtueM07rLuXQA/CcQX6Zg5e418d/h3fz0ekMkssyrYQahJZGF1dsRKst5x+Cy4rHlHbPLtNVMB4AZPMSko8Uuj6SzORbyFvtpcOOjvUYDmzDGIqHe1bN5R9+1t+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P38vs2NH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBmxYoFL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764242967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q226UxpZ2lcekLX30EL32R6ZYbE5y2RkR278GNgRSlg=;
	b=P38vs2NHewBTXfb7fmcCyPFAkIw6I/ehFrg+SWplkn/QOsOkztgOLDVTsrBpFviQVEIjcR
	axicaxE9svEenkITOYYqTzcV1hWwwHumU68unFgSTWw7IFhMP6Jv/0XGsk7g+kSGWu8BWG
	QtZPOzaLdlCAPpZnDmSq/gTLMxme3k4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-cDS7YXLDOcWfkBKiAoDPew-1; Thu, 27 Nov 2025 06:29:23 -0500
X-MC-Unique: cDS7YXLDOcWfkBKiAoDPew-1
X-Mimecast-MFC-AGG-ID: cDS7YXLDOcWfkBKiAoDPew_1764242963
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47106720618so7619525e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764242962; x=1764847762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q226UxpZ2lcekLX30EL32R6ZYbE5y2RkR278GNgRSlg=;
        b=mBmxYoFLYhOoR+NqyMEfbz0XjpEWLPHQAGyNcXETr8LxEezDGaIiL5jdQCMFcT6doE
         oLZT8/VqmX3UBfDAiBcQiSLQ53T3dXjV0VVdbOm+J8W9K0QqBwc8+jxLtQ5rma3W31vc
         Fr/d36zbjcOlMU8Mxysul5EDfLikxD602Hdw7s9LyZyZ1bvNGdG+gNasm1kaCycNhYI4
         LtqSR+IyQ2adS/0URXKDuDAetuyZWNXTWniuRp7boGunavdlntNtD/KCfi0tlF0dUvRw
         gjH2TAL5eNpXatyo+nr0MTIQ5iIaBR0pkkPx9+lD2Jq9FtKKeokWoiATpIrxS0pR0j1X
         wxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764242962; x=1764847762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q226UxpZ2lcekLX30EL32R6ZYbE5y2RkR278GNgRSlg=;
        b=AMqe8uNikyP0rUDgKItC4usL3bpVHeXtnOxRrjrB/g6CWSghfHxl3cYbrOWJK5B4Hs
         eIzDM+udD36a/x1AVfRvkwH0gaSDfgOLsZ6FG7r71EQ9TUIM0ot3cK1p/L7E3WFYXuHq
         z/9x1vUCIATuMOieI0hnfpU+T8Ss/yEK5VaBrdHVSHrRoV0v9JEcjoU5+GHg79B5pgHc
         QudJ+L4ykIQ2hsbX2oBK0v7hREEiaUVWV0ViqKeKeX5S/d7hAE3EcPwh+uw8S4RtN34D
         HKA09DVe4zYSRm292i8SC58JkdZdZ6aywb7dKUlB94Orbej1v5gOv84oeeOunvvnXxbA
         aEzA==
X-Forwarded-Encrypted: i=1; AJvYcCXdVD/+Nyp1XPvkTP9+3hgkjMvo8EIrv477oqEG7NT/R4oxIXuWCSOQLVfa0mVKO/0fnWbxoBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3s4UcorQRZFNf38Iv/1kzbM9m3epohG7XdQba1qxOb1abd47
	r5j0QuCclhZnOGdTFGXR2+wJVmwDNNCa/DskyL/0BSPq2arLmNghv4S/2fG84Lnpl5V+FfYUf1C
	KlZBiLH2ab2TyNTTt4BvtsN4N0XR22e3s0G6C026V0cp/2vfihn2DSDLLEg==
X-Gm-Gg: ASbGnctfctyA/lWoUa7Fb73yf/sxjSL6i3on8J22H8jar6vtVYsP/bzpUt+bDat4Wg2
	PpYq0/FGYPlhvEwlNDuPb2buardZtBwDwzGA+NboFUoFnmtur6prG2I+Rf5/kwUoblOxEbLOgC2
	YhZ0gFpfCXj+eaL3SAOifJSKuER0wGOMXIoxCy7JtMRYQgA8N0f2lSLnImLDXAJl9F/Hqu44ESL
	rNPWnkiU3fJtbdfbCKT1TLOO3ZGHrGdGLC3E3RUisv7k+aDPg6rqY4jSW6QWz9ul4pceGYhFfG6
	BtuTlrG3T6AYex9GZJaxFlLi2iKJuSzxa3TgFCy8Qdym6eT48+xd00X9jNoqHX9eGhfSxinrMDp
	AMkmKfgVITWqFkA==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-477c0185bebmr247680655e9.14.1764242962435;
        Thu, 27 Nov 2025 03:29:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV57wjUglDLQE7qqkiRaOB2mEMR0gTX1X1M1loqMP9QSzYd01vth1pFvUgzo1XoOBJ3gazqg==
X-Received: by 2002:a05:600c:3110:b0:477:b734:8c52 with SMTP id 5b1f17b1804b1-477c0185bebmr247680065e9.14.1764242961747;
        Thu, 27 Nov 2025 03:29:21 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add60e2sm92649475e9.6.2025.11.27.03.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 03:29:21 -0800 (PST)
Message-ID: <4c645223-8c52-40d3-889b-f3cf7fa09f89@redhat.com>
Date: Thu, 27 Nov 2025 12:29:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] xsk: remove spin lock protection of
 cached_prod
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-4-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125085431.4039-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 9:54 AM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Remove the spin lock protection along with some functions adjusted.
> 
> Now cached_prod is fully converted to atomic, which improves the
> performance by around 5% over different platforms.

I must admit that I'm surprised of the above delta; AFAIK replacing 1to1
spinlock with atomic should not impact performances measurably, as the
thread should still see the same contention, and will use the same
number of atomic operation on the bus.


> @@ -585,11 +574,9 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
>  }
>  
> -static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> +static void xsk_cq_cached_prod_cancel(struct xsk_buff_pool *pool, u32 n)
>  {
> -	spin_lock(&pool->cq_cached_prod_lock);
>  	atomic_sub(n, &pool->cq->cached_prod_atomic);

It looks like that the spinlock and the protected data are on different
structs.

I wild guess/suspect the real gain comes from avoiding touching an
additional cacheline.
`struct xsk_queue` size is 48 bytes and such struct is allocated via
kmalloc. Adding up to 16 bytes there will not change the slub used and
thus the actual memory usage.

I think that moving the cq_cached* spinlock(s) in xsk_queue should give
the same gain, with much less code churn. Could you please have a look
at such option?

/P


