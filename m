Return-Path: <netdev+bounces-161748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37060A23A3C
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 08:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB503A7345
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A23156F4A;
	Fri, 31 Jan 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiaEiC98"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3C4C9F
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738309080; cv=none; b=L1Yc1NufHwMmemtLK+t+fcV4nBqa+lmahbrLLNfkDSJT8q4ZsUQhovr1jxghhQKlZQmweRET7QoTjXxwdDA8Q2XFbXlipV4YmVj32IdbZUSyN4UVkv+9gbK5kU+rGgLRwm2Q1+n9Z9+uY7hKPA/PkI0K9Egyr3v9fCOqC/Tf1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738309080; c=relaxed/simple;
	bh=/MZJWtbCRnvd4SVu1PoVqiooH8kR+4jJrfANEvje6B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOA7+q7huvg5Hx38XG038YZZtYQ5Y9y7iSf+PHDhy63nh6gTSp/GNJr0v3Murv6061hL63AGNzyId8gWw9uyZxaoglhLwtDtHrSGhqDUNS3gU3eeMAB5UBRQ3cBDEiQfSN8/84PiTcdZrvtl5W6HRqkm5WTqRgsu4xifCOMsVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiaEiC98; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738309076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMgVsW+/QlemsW/uhwFT/jOfeJ04/HD2RbivobMxxLo=;
	b=fiaEiC98BbQ40hRgUPOfRTLC6uae+MEOi8i5o1FBLp0abBiUJxlf9DQ89aspwFe2Dt2DhC
	RvplHisgeUWiOmjl6KImdgoiJM74o3vvYzrq+AMsIDTVHcJUhTmP2nrFUD2G2maOH20p8S
	bbxsnbVjm+sj1n7lldLAEZTIWY5ZxAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-K_x6StIdPeONTb_gBQp4kQ-1; Fri, 31 Jan 2025 02:37:54 -0500
X-MC-Unique: K_x6StIdPeONTb_gBQp4kQ-1
X-Mimecast-MFC-AGG-ID: K_x6StIdPeONTb_gBQp4kQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436289a570eso13920205e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 23:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738309073; x=1738913873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMgVsW+/QlemsW/uhwFT/jOfeJ04/HD2RbivobMxxLo=;
        b=kJY8tZLUWAtcAxK2tIxfWmjRaL8wKR8yNB9kNuPE1s6NBRSyMLmEaW1/7RFd9wwsi2
         yo4+dGNVFrtoSQfASDjzTgz4HmaQLXF6FYnZZ2kRK/B7djxBJ2o4o2oIXswb1rksTEhO
         Plq6ja39P5rdN6C83c2MenzjnckEQaosUc6QRhLDiSqLONdCw/X8NrWqSZC1WwUB02DK
         BfNplLJGnFnkroLvGMPSm4zHLUNgyomb/uUoojlAfdJUot9/TMDpBlt37A1V7QWImAvF
         JHEZiHgTl9XrTVrOMBJAqY2QLGbxaICp0qynsQf/FF/fxg1HcaQ97z36SLJurPxazIj4
         ujHA==
X-Forwarded-Encrypted: i=1; AJvYcCUAetYZsv2kpvOSG6eyCqn+3I/6wwOy/mmz1MG2p0aAZJUfznoUQYxdDfJrdjQu3jZz5tE97qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywHb5+5phHt/N+SAfrqVmgWeJvr4Yk0bLibzsHgm3ybGbIy85
	kH4dQ4ImPfMRDKfo9HunDrLK9/ZMlRHUlltr8AStyUlc+lP2cdIw9quPVSo6OkExu/yo2TRqBg1
	l4sC8C+qXO7vUV/0g9ch6ZSUVEkaKfFhCe1KIjpg7UlQLQpBe2ZldKQ==
X-Gm-Gg: ASbGnctS/Gb5lLEVe5/4buSABC199hzGlB3GNIfoUbwOiPRV1A1E1mkMmc/F5Quxv+h
	WLHsXGiJQ8PtdRKLCqYG7TUa/CirhMRD0v+hav1vhXRKgFlMefTTaEez7iBx6dwkvjhhqtJds+g
	MN3dNSHVfeYDFfZkMBoFeqaJYCfmGKhA1uI1sdppxhylWm7mJM2QLX/pEd5WB3kXfeXJz/fr68L
	ru3SmMelW5/M8MHmPEEsj83GQXtMdUmALwL6ZKAIgGNM++VFO1mBupoRJYFDAKHps53RzHdgcZN
	BmydCxs5vkWqpzBQmxdD1RgGdtSHQO9NY5M=
X-Received: by 2002:a5d:64ed:0:b0:385:f6f4:f8e with SMTP id ffacd0b85a97d-38c520a35d1mr10073224f8f.50.1738309072894;
        Thu, 30 Jan 2025 23:37:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK2cuszovQGZ9RC6KZy1jrb8405UV8PkMW7ZStTaXydaZa8IIuT14GQux33jt09JDJA6SJXw==
X-Received: by 2002:a5d:64ed:0:b0:385:f6f4:f8e with SMTP id ffacd0b85a97d-38c520a35d1mr10073198f8f.50.1738309072527;
        Thu, 30 Jan 2025 23:37:52 -0800 (PST)
Received: from [192.168.88.253] (146-241-12-107.dyn.eolo.it. [146.241.12.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23de772sm46266235e9.13.2025.01.30.23.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 23:37:52 -0800 (PST)
Message-ID: <ac8a097e-a110-433b-99ae-1419d6444261@redhat.com>
Date: Fri, 31 Jan 2025 08:37:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the bluetooth tree
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, David Miller <davem@davemloft.net>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20250131131633.75083adc@canb.auug.org.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250131131633.75083adc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/31/25 3:16 AM, Stephen Rothwell wrote:
> The following commits are also in the net tree as different commits
> (but the same patches):
> 
>   07b6216dfc34 ("Bluetooth: Add ABI doc for sysfs reset")
>   52f17be9931e ("Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming")
>   56cec66d6163 ("Bluetooth: L2CAP: accept zero as a special value for MTU auto-selection")
>   9e2714de7384 ("Bluetooth: Fix possible infinite recursion of btusb_reset")
>   ec5570088c6a ("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()")

I pulled from:

git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
tags/for-net-2025-01-29

AFAICS net hashes match the above tag. @Luiz: did you by chance rebased
your tree before tagging it and sending the PR? Just to understand the
root cause of the above difference.

Thanks,

Paolo






