Return-Path: <netdev+bounces-235225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC5C2DD00
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD53ABCAB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6C280017;
	Mon,  3 Nov 2025 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ASdMn6Zf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F5347C3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197193; cv=none; b=gK2+es8hWx4OL0o6ruvvBCviP8CRupIE8hZzfbX6rXZ68TUyAwIx0lVyDEws2MBbw2q3H/YMSOqY3Mc6hbg/+zQRnX9tHF5fbdsuS4CuXdqvTAIyauX6l9bE1qJBB9i26Klk1IkN8i5GIUOwRdOXQf+MhYNMaHkuARC5f8UvFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197193; c=relaxed/simple;
	bh=3ZtYHtCAihPxQ1JWS/Addd0djROHkcheIbjC0Ioz5EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2nIRc/IkSKVslrgS6g9In1D5OQ2kPeSzbXav/bNJuvExQml03es+e9DO9ThDeDsYJAHxA1XssZ0FnuoUkNvX12TG/PhZ8GdU75mzdkFaahVgfGkKWW2LTtp1cucLh6FT/rikmZNIEE2io6dXlDdLPPf3Awsuz3l9E+mu6EBbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ASdMn6Zf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed3d00c359so33884161cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762197187; x=1762801987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NI3drFTaeHe8ZSmMttUrOTtIfWgohaM87lOKGhYRASE=;
        b=ASdMn6ZfLaMienom1oc91e4OF4aFsl8shJxnIBVDQOZeKRiuNRCi9uBaYVUqtZqTQj
         N2gtQzLJmMi4E6DvgZmWAEZROhij1m+X7dBynRgmq5AC3Wglm4b5I86HsUL3U7c31c2x
         Vh8w7YAnMRpXLIbhTmhPp9zNe1Lu3m0EjMml2pq/qDQCiQHn9Du+XDNbQSpcn8pD8LW0
         UdAQ74KHpM2kwKnf9xG6ALw9/sqW6KYjKCv5uRQzMXdIDuNExYOtRC8BuGb/P0koZnLw
         db7A7XesxJ00vMUjMHgVmWNdIGNze6m3Bn2IZ6HY65w6Fzplz2fmLPkliJSC15/VU63j
         GREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197187; x=1762801987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NI3drFTaeHe8ZSmMttUrOTtIfWgohaM87lOKGhYRASE=;
        b=owPP3EOeKZ2NQAmFPQcXfSXTSOtO6Utu9OK/0tSMEIMwdaI8MDTWWyNfelbDDRHWZf
         RXnV1+diWzAuL+4QRdgtsGiLcHgGe51GqfsD/1RTnn2TfecQNaSh6PmzsAEP9CYJ9pGH
         r0Sab0iy+BLXjujuiivfg8yZmPRLwXCE1NPUZ8cl7O7OcOCUlWtZ5j6gE3LRJQT2sTEq
         ATDrQExmpl7lwBHlPZ0GWQzyw9nHx4KNZ8gdN6nM7Qp7uCdoTSzZhcxpko5aVwkLQOh8
         SmMfml903YRZgqrpWdTKA8RcAqHcx+WdZQQWzfjdthzc2Ga2QR0EG3GPjWI+/mZAd8iz
         GtJg==
X-Gm-Message-State: AOJu0YyKkR9XVKOV6AwMXXi2aTQgXZ2aJhmNCk5ywBBwnSZjK9IvmIHd
	MsQpo+xUkbqh201OTWY+tP+dcsqfBNyMpSMK5XMv+BpyrVXlAB9fl2ZxXP79Vk6IvyM=
X-Gm-Gg: ASbGncvP2XwsvDsXzYcWScNrEAkvFpp4lI5A45jOriOzz865gqP8HiZiJTmAfv5vryj
	PIVoG8VAEZ5NH78TTvdjocwUidqiwmqLaM0D66+k+NSXGDmhyGwVHoJs1Ca0NoG6h62fJ+PPXvV
	2f8VLv6ysy/gp/6LI+ywWNSVu2kHNO5dWDadw0l3bjjlMVGY7c/gtoxbdVvm0bEHRBMtmb2opAl
	soS4G+x7B0hVYZo7p6TLUpv9qIqbFMm1UnnB7hahWZpBaNsR7XJL7uIQF8zCUfdimkDQLx88TEC
	EiHEaonr3xWdBrMDxS43fvozLZEDKuvr+VIq9lgReVUoS06vKqXU5VWjAWYTYqRnXiG5hpgn1UV
	qCFEekjpkG/772Yd2nEZsbJt/vZGc0/8BpkhoiFLRV9QREprb/Svx9J7qtTB2AOLBjJcCwILC2R
	dJ3ixASjrPDGrRjF3+jr5Z4Mitqyfc8XNxZw==
X-Google-Smtp-Source: AGHT+IF2nyLarSsIifrXOkYX7bOWXN1AGHlVMsXNv1/jxbKObEmYEq+u79FK/g3f0n7sNVojbQYiXQ==
X-Received: by 2002:ac8:5742:0:b0:4b7:ad20:9393 with SMTP id d75a77b69052e-4ed60c6a67dmr8668351cf.4.1762197187180;
        Mon, 03 Nov 2025 11:13:07 -0800 (PST)
Received: from [10.200.176.43] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fc396a4sm3675991cf.33.2025.11.03.11.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 11:13:06 -0800 (PST)
Message-ID: <474c1f71-3a5c-4fe5-a01e-80f2ba95fd7e@bytedance.com>
Date: Mon, 3 Nov 2025 11:13:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com,
 parav@nvidia.com, tariqt@nvidia.com, hkelam@marvell.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Salil Mehta <salil.mehta@huawei.com>
References: <20251031231038.1092673-1-zijianzhang@bytedance.com>
 <44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com>
 <CAKgT0UdJX3T6UcmtbeYLRCNLtnF_=1Dx3RGwHSc_-Awk+cHwow@mail.gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <CAKgT0UdJX3T6UcmtbeYLRCNLtnF_=1Dx3RGwHSc_-Awk+cHwow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the info and explanation, that makes a lot of sense :)
Modulo here is too costly.

On 11/2/25 4:13 PM, Alexander Duyck wrote:
> On Sun, Nov 2, 2025 at 5:02 AM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>> On 01/11/2025 1:10, Zijian Zhang wrote:
> 
> ...
> 
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> index 5d51600935a6..6225734b256a 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> @@ -855,13 +855,10 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>>>        if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>>>                return -EINVAL;
>>>
>>> -     sq_num = smp_processor_id();
>>> -
>>> -     if (unlikely(sq_num >= priv->channels.num))
>>> -             return -ENXIO;
>>> -
>>> +     sq_num = smp_processor_id() % priv->channels.num;
>>
>> Modulo is a costly operation.
>> A while loop with subtraction would likely converge faster.
> 
> I agree. The modulo is optimizing for the worst exception case, and
> heavily penalizing the case where it does nothing. A while loop in
> most cases will likely just be a test and short jump which would be
> two or three cycles whereas this would cost you somewhere in the 10s
> of cycles for most processors as I recall.


