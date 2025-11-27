Return-Path: <netdev+bounces-242244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02781C8E0FE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 793B9344AE9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF84329367;
	Thu, 27 Nov 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmFRSgd5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbK6lBvz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9A3242B7
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764243354; cv=none; b=izzZ53IGrF8TaIBv/qnSawWIEIatJS8C6t5jw7nwl183uehdvlXWHe17I7of1I5ZjISZK7Rd0c1D1tuzZFIXdu3ExxnXVspX8P0y6FYYYGmzzPVSyCT4LU2+fhlEGOvW0g8g2iRie842OnRp847Uon9OMh2J2SiyZAE6st34LJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764243354; c=relaxed/simple;
	bh=4WI7yCChHQXZkx37ypnImXEbQ0maLcssq2bhKZ7ODlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wuq5NZgJ+9v2ASJUXKJit5qtPMOUcYMDsGnnlDo8Qgr9IqwTDaHNzaBf9uekOUuOW20CNOY6ZWVnw5wLI7YnlMpW0EP4FRdbneeWV1ZhAYbooOO3xBQaTkJEIcnBj52Xr1XPQPvPVdmhHWS3YgmbygeU1P/RrK/JCcg2ASLJSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmFRSgd5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbK6lBvz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764243352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPLeXmZroMIKbU6mJWFaUG0Igc2fFk4vqnIUHWReN0w=;
	b=fmFRSgd5bCvoA5N7oip/xX4k+woCvJkX88igq8DbWiAON4Yhd4d3VeTIft3tPdIHHU30Q8
	mwcU6qJOyBpNJ2NPzD+cAPLQJTd9Maev/P+9A5EuvD3ykOJYyZQp8qz58lpzsATMCkCobN
	yssVgq0aBpZzIwOuJBZaMbSvZqK1w8Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-xLvD9U3rOziHIiQe2vGR8w-1; Thu, 27 Nov 2025 06:35:50 -0500
X-MC-Unique: xLvD9U3rOziHIiQe2vGR8w-1
X-Mimecast-MFC-AGG-ID: xLvD9U3rOziHIiQe2vGR8w_1764243349
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c521cf2aso620251f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764243349; x=1764848149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPLeXmZroMIKbU6mJWFaUG0Igc2fFk4vqnIUHWReN0w=;
        b=IbK6lBvzPLHYjX4sOV1T5CeN6qQIuhO4QcWkq2eO56yqJUzzgY5OvIRBKNniDKdUXA
         QAsrEu3DIWmg6Qteu2Gw79A0R3Z/jXWFtxYKv+7x4s09aPCCXS/GEeCkS9tedUxAN7E9
         8ZCxzhhhljGnZl5OtROhOT0zDNu6i2xwzVRTCw5wPv33n3UJcFE4Q6qgFVeBt4e1Uxtl
         1tPl8zlxCachsWYYgFcetUp79FkQ04BG8OJrV7DsvShjc4R5KwYc3CPOl2P+sBSkddXu
         TtjV3DL2t6LU9as93+LgPvMUn1XwkMMVk/F6CbvYPWZrdfTpAMavPc8UDO/0ylMrpbqq
         pnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764243349; x=1764848149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPLeXmZroMIKbU6mJWFaUG0Igc2fFk4vqnIUHWReN0w=;
        b=AeYoFU1RIvn5YRI9WWJ3h6mStH00tbQ4xStMCZ65ZXpnCkCXI+eACEZyQQrba8DvST
         8Wk3WzWMcb6UF6gPO7oh1sstKziK0ju+59EHS7bpDx74/WC/G0jB1CHUa6Jvf+PcIWoJ
         cdFpBaTRt9eos2+SqoWfOfF07fCWEVPh+k/7Y5pTfY8MzsFZ7d1s6CWX8tp0lhrGu5Zf
         RuXiG9suHOtdgDXwkEld+4kTr3RjJl7CVBB46lGRu+mNNOpm0xl1PmCiSctxbiPFy2Vz
         evo1Dvq0G/VVSxLgvVlhdqy9D7pvYJi1bLYNPNtLqok/1jtgUnyPl/pnwvZtxMnUDNWv
         i9zg==
X-Forwarded-Encrypted: i=1; AJvYcCUj0p9oDBFfAcffXf9WXrQDqzAQelChyQvH4seo5s7iP14bvYB76mW/aMvDh1NRFpePxIcQRZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7vgTFzrLjQE94pxqNZe6VmRARDubuiKBJOadwYKFBxy4P+dx
	qKAAbDs3eSgU5/H8ov8BTTASDzKGtvlQ5f/bdWcGj9AAaGffscDatqgJBtL8Xyx3lkJKejmehAZ
	/30LVIvPmwvaq7wM5KqhvIi9imFyl1s7THjRuxnWc/Gzu2qrzf4dcdNffaA==
X-Gm-Gg: ASbGncuk8zVtXfhsYgu6VYguTd1+exqLIPHECml1i13XtDIpv1glgI+2a0bzB60R5JR
	WGx883y8aGZWwtLTwqq1CgE7q+qyk4z66nQh+rVb39+S3Qjou+idt3EE5lgri4wYS8Vb/zRTS6s
	/3Ixx6PA+g4sNVlPhVDqnuLC+J913tV1A3LExP8Khm/tCJ8FFeg1gAVqEW9+1D0ap4bAWFaCeny
	+9DWntMHmRcwbQ9oDtZ9bWlErYJHo1+4RKts4Hr7yVtLRxV5QbbwqaRbDft/UNHgz3n3I1mziwV
	ebtc9o7a3GwMFo9jr1ZDoIDP0JWgL6/MyaceOzLAfu9fkfX98pBdvViomEtlpIwBj5MHdLxAVMJ
	M/dMv9JOWf9jldg==
X-Received: by 2002:a5d:5e01:0:b0:42b:3131:5435 with SMTP id ffacd0b85a97d-42cc1ac9de0mr24340547f8f.2.1764243349478;
        Thu, 27 Nov 2025 03:35:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw+losns/EbFf8Iuyd+Ic4CbDitf9tLRbOX3h2FYMV1qJKEuWEEDc8zOqFzENhs0ha+EaT5Q==
X-Received: by 2002:a5d:5e01:0:b0:42b:3131:5435 with SMTP id ffacd0b85a97d-42cc1ac9de0mr24340515f8f.2.1764243349101;
        Thu, 27 Nov 2025 03:35:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a2easm3317816f8f.23.2025.11.27.03.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 03:35:48 -0800 (PST)
Message-ID: <0bcdd667-1811-4bde-8313-1a7e3abe55ad@redhat.com>
Date: Thu, 27 Nov 2025 12:35:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251125085431.4039-1-kerneljasonxing@gmail.com>
 <20251125085431.4039-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251125085431.4039-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 9:54 AM, Jason Xing wrote:
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 44cc01555c0b..3a023791b273 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -402,13 +402,28 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
>  	q->cached_prod -= cnt;
>  }
>  
> -static inline int xskq_prod_reserve(struct xsk_queue *q)
> +static inline bool xsk_cq_cached_prod_nb_free(struct xsk_queue *q)
>  {
> -	if (xskq_prod_is_full(q))
> +	u32 cached_prod = atomic_read(&q->cached_prod_atomic);
> +	u32 free_entries = q->nentries - (cached_prod - q->cached_cons);
> +
> +	if (free_entries)
> +		return true;
> +
> +	/* Refresh the local tail pointer */
> +	q->cached_cons = READ_ONCE(q->ring->consumer);
> +	free_entries = q->nentries - (cached_prod - q->cached_cons);
> +
> +	return free_entries ? true : false;
> +}
_If_ different CPUs can call xsk_cq_cached_prod_reserve() simultaneously
(as the spinlock existence suggests) the above change introduce a race:

xsk_cq_cached_prod_nb_free() can return true when num_free == 1  on
CPU1, and xsk_cq_cached_prod_reserve increment cached_prod_atomic on
CPU2 before CPU1 completed xsk_cq_cached_prod_reserve().

/P


