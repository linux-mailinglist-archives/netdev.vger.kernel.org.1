Return-Path: <netdev+bounces-166064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF2A343EC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C691895841
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E9266187;
	Thu, 13 Feb 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH3PZC0G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A64266185
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458099; cv=none; b=QtvlKFiumsBRVBlI7n/GjQ0scZdHdV5R2vnFlAhY2abQFHuTvs9TJp3mAHNx89JCqsKHLXKGbt4Qc2JQjLMDfzVIPFgbHIrQwwzrvV3E5Yz1BWIY4M0nWjAdtdqt+KeUevq7Oxo+ecQ00aiKPvr4FbsBPJEpvbzo/hiyob2M50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458099; c=relaxed/simple;
	bh=B0fd/s2O/wUtRdvSH2bFZMbbXSBmWcpm0my5P5GnbNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjaZcxJ0IuG1hxfkMdo30n9jaZxsxsEHwDGRk8AEGR969ELsTQJWe+K5jHkPJOZQCMj4ZkMwO3er2gkUJ0JH3TR6cJiXBIFnejoYn8QvIv0vGMk94R0BwvKIbrzCV9zuqGaJGa5QiHPe4QQWS/uFmlAcDz3P/LAn06zx5RQfnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH3PZC0G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739458096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZhYln+IOkL5cS4NaJfb1NklqQL2NrBbXvHDBFiZdU0=;
	b=HH3PZC0GP+9OmwMZid3rOLy9gjYHk0G/WxWZMygne63xhwQ9fq4CAOaiI3wHaXeaDhqV13
	c71+VFkAX7HFiS1lkNVzab/UoDQKtW7FNCDwD1cglH+u42k9hay/s1tu9oIokUEYxrZ/Xe
	UZJ1QwSB1Mjzw3gQL+C2QNjYclncrqQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-HGk1FzrtNxem3SB3ZB9Pog-1; Thu, 13 Feb 2025 09:48:15 -0500
X-MC-Unique: HGk1FzrtNxem3SB3ZB9Pog-1
X-Mimecast-MFC-AGG-ID: HGk1FzrtNxem3SB3ZB9Pog
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e180821aso5207905e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458094; x=1740062894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZhYln+IOkL5cS4NaJfb1NklqQL2NrBbXvHDBFiZdU0=;
        b=cQ9I+L/jsJmvxaqhDSwTU5W4YMASSJvziDsZVBabi9RZHHC3Fd3FMBzNeKd6EhrGXl
         EM0lUhwH2qP8dWNTnav43tw+dq4wmzBuoiY69/s26+un4tSGEc+n2SFtgujRRAx0lyi2
         VK6Ab5ZEaVBRqhITTc2yRQylSBAolETxDv+rtbBg4Hsi0g0cmAdDDwgUkv2dUlcofx2Y
         +wy2Dua6lDVCaMN1hGqnKsABbloUOjXPpScyyQdWKzo97R46u4rcTJF9xKnUwUm2yPEu
         4PeqMlmf1uXwl2zKR8YMnTlam2vqNZXZQVdpMo2GiRCwguPaiDKqTgdP0rcFUm1RVDfU
         tudA==
X-Forwarded-Encrypted: i=1; AJvYcCWf6Jg8JURpqaQ8xo7bBvVMFohOQp2rwY4dpqfZjlLv+HVOLJEGuQT0BQIJbJ2eED+eGkeQ3JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8RVoupPEnN0R0Wou40jSSOnFm5PtUNKghRB4XZbw74zAkgV8
	t92mcc/fkYBq692sIj+2YSEd8SDyWAWbxyNZ563OozNxFttCHJBzvGaVtELpb2LXvF40UPa1nUc
	mMx73sh3Ok5RQtPDWvzUlPZ+eLG9FibYQtLBUAhW8pCAXYAzS0mEGIA==
X-Gm-Gg: ASbGncuHux5iLclhVr9YGCsaOL6NHpbzN3T55qgYf3BrmQcPai3g+jdxZKe/XoRCc2u
	0RD5oNp2l9WnD1o62HTC+6B/x9L+GdJldKvISYU+1vO5+891LxxMzY3tBCTu4wQNWAZx1oIkmIy
	yssrSX0LQwfWuCFOASRRonvD+VbNmcEQ9AV2qPsC1DMb6YqfMzYQdhFBVsU6X4BtNjbSqhBgMpl
	pujYdW3AUKkzoHtBjo8t8UGXAA3jJi7ElK+OsS9bIpYFUiHmnrBinrFW7XVLTiFlUQ54vX5KSem
	yGHLNJT7/ovy0gu9JsIzgkXJmSyAd+Ji9QM=
X-Received: by 2002:a05:600c:548e:b0:439:5aa1:1efa with SMTP id 5b1f17b1804b1-439601a119bmr43340905e9.22.1739458093923;
        Thu, 13 Feb 2025 06:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUMlIvNPCt/14p6aQyY4nkcAEWaM63dfLSbXm2qXeCMt8hELCm1gxs9nBtjEjdrhxWGK7pTw==
X-Received: by 2002:a05:600c:548e:b0:439:5aa1:1efa with SMTP id 5b1f17b1804b1-439601a119bmr43340525e9.22.1739458093470;
        Thu, 13 Feb 2025 06:48:13 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7d2sm51512245e9.25.2025.02.13.06.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:48:12 -0800 (PST)
Message-ID: <d5ff9165-a221-4ab2-ad9a-3f5b025f09a3@redhat.com>
Date: Thu, 13 Feb 2025 15:48:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: initialize mark in sockcm_init
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, horms@kernel.org, Willem de Bruijn <willemb@google.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-3-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250212021142.1497449-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 3:09 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Avoid open coding initialization of sockcm fields.
> Avoid reading the sk_priority field twice.
> 
> This ensures all callers, existing and future, will correctly try a
> cmsg passed mark before sk_mark.
> 
> This patch extends support for cmsg mark to:
> packet_spkt and packet_tpacket and net/can/raw.c.
> 
> This patch extends support for cmsg priority to:
> packet_spkt and packet_tpacket.

I admit I'm a little bit concerned vs possibly impacting existing
applications doing weird thing like passing the relevant cmsg and
expecting it to be ignored.

Too paranoid on my side?

/P


