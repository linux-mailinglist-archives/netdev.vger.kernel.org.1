Return-Path: <netdev+bounces-236281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876BC3A8BF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 017874EBCBA
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E572737FC;
	Thu,  6 Nov 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DroiepU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505A38DE1
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427966; cv=none; b=n72JVz0Na1kiXSxkg+Nalw+UWwVNiRADpDYQBh5SnuENrAEmdx+eASYyv4M8hubdHQHlR+Jq5qPgjpSWUxJ3CT+qHAqu1sn22ktvZAbCy3+Nwi0kz1Nq+mLvybvVQk4Qf5ZGyS7zWPNGoMoJ3Ilztdf4w4EignDzcCf6dVS+NUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427966; c=relaxed/simple;
	bh=9gv2efB64R/hKg6M4ouFf/mpx43OnsogQ5ESP1uCG2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXgUtQihlz/pVvRJglbzS81gRLkGxf91z/gm0v4msmAw0xsevQPmncefsuNZMgdKSHrWikn4u0awq+wL2/aoAIBjrI+6QikdT3CW3zhHWKPh3hnTKxCkb+PODjPA9k91VVhVvYHyo+4Fm2DN35ZnFSsqW4brtipahsazQfoIpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DroiepU2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563bcbbcso4134725e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427963; x=1763032763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkYdRZyE3uYViGFztfTL+nwDGiwwOYnS7mcrZoTTLns=;
        b=DroiepU2CRbB+AaXUrS+vc58IMYcG9z1aQUXBbEBksN6hzYjE80qb8v3k3JjW6anVN
         EedgvJq+WGjjXioYceupkWJK1WzFEgnuDNbfFiyomj1aDaJlmGwodpj4vinX1Vj81FqA
         OOvrfMU6kqgif2bNd9AFdCbJiv5Hp1GnPacmLiy1Qh/EYZ/r7vNkpn37b0zFYoDC/rg/
         7htctL7aRxACU65ZFYtmWArzjoeaY11u884a7Mtznnbf78z+auTAjvNmPjvtDmVqOAlR
         r2CkpE7jmfLFC9ve7EvvCG7IvFtzDM3ml7MDHTgFDtxsKqAyNm1OX2dPwvZrE0gn5/e+
         3e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427963; x=1763032763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkYdRZyE3uYViGFztfTL+nwDGiwwOYnS7mcrZoTTLns=;
        b=ODdd3ujvK09IB6tZ55HXvF52sUxfo0G8LfVn+uQVuYct4sdGzK4GZX6L5nUIY7gaYf
         CnBxCqHqExFfVd8IaW8mN6T6nHre1zhSg9DlIL/1G/oZtb6aQHwgBuHaEy8d+jaEirfo
         zPoKK7JHaLEzLhaZo/M1EzS4n23QZSlWHxK6gYBZ7FBRhF4fLqbwitJ32M3mnfb7tfmd
         ESlA+H2vlNpY9j6KehPdZh+Nj7s7AnPK2LGHPNeOtGFAgFiOAweGGxF7GYzMsHAuKry3
         WuYUPj0citHAnFFNg+JXXbW38UE7nflyH+A9Xmg98NxzKHnhmi0HIYV24+Zz3QKbtXok
         IiKw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSz169kyPdiIN1CCpvF8NRKNrTpSwTlA9xZAl419gWcdvMG9nKKAXpu3gzefLbrh/O8mzcgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tBLSDMPHLZ1VJqvYKxfqfyE3fiEliozYyPhUeO3ZSlIdFyp/
	1fyL0vu7nV1IGG9QUznOQ9YQH1KyLS9jtHxHojF5MSMFEAL9JpX66KzqFtM4ww==
X-Gm-Gg: ASbGnctFwNX4uNJf0LEIU06/aLqzbb9PRakkgd8PwoSizr5d3gqhn4H1sYc/JsOjufJ
	VaH8z6AAAiogBtKJfVVB553xPBb0xYNSq5eID7mWRDB2NY8WRtKLTjiMT9hmxoiXi8IVpAq0zhs
	UoPm0Ymw1RE47OLK/cshY+j50WEpF/jHAOOkMzvln2oUiyMK/YNuSDxaaH1IWtJfSuT470mnLyX
	8j2te5L8Umc1Jz0Xsbtf/J3g4qxp8JoKT2xCjsL8VzZTRx5XfSK90oiR0gjYeMpRnWDMJUft+EW
	m7R0JTVmdvC93l6rwmpGKLg/N2kTGyKLJwUakDSWfLDP7IE6t9pMJ4HxFD6eRBBLo2wBQVsj0si
	mIUhgBoI2mGQHs1MaDenpyFes4Xb5eb5WLZuqxlw8eniaP6N9wthsjTXTH4g2gqsNgYbxi7AXzS
	aYma8gl/bga7s/YkArYTTEcDQIJXSD68Y0kZXyXyAUk/c2Kp3sQ5c=
X-Google-Smtp-Source: AGHT+IEBjjHYEgqJ0x72G1+TXmkTAD+vfQLBoUcN3g17VbpVVOHP4P+CuAsM9y3g9IF7xSzsggdQBA==
X-Received: by 2002:a05:600c:a0d:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-4775ce24859mr62466505e9.40.1762427962931;
        Thu, 06 Nov 2025 03:19:22 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2f4fsm43720565e9.11.2025.11.06.03.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:19:21 -0800 (PST)
Message-ID: <26635d1e-8c4f-4f79-927e-811a0105fe75@gmail.com>
Date: Thu, 6 Nov 2025 11:19:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/7] io_uring/zcrx: add user_struct and mm_struct to
 io_zcrx_ifq
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-6-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-6-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> In preparation for removing ifq->ctx and making ifq lifetime independent
> of ring ctx, add user_struct and mm_struct to io_zcrx_ifq.
> 
> In the ifq cleanup path, these are the only fields used from the main
> ring ctx to do accounting. Taking a copy in the ifq allows ifq->ctx to
> be removed later, including the ctx->refs held by the ifq.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


