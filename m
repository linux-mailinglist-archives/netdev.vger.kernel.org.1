Return-Path: <netdev+bounces-233661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B06DC171AB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629BD4E2A99
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44AE2FFF8F;
	Tue, 28 Oct 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="PaO5IVF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79828152A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688749; cv=none; b=h0ahWprzU7IzNB+1/YUAhLzIOIt3pa+6ghwEQR+lEtomMU833YDxZ6iceHa9QpP6sGYfHGXs51HAArYPcVa3ZxnvUntFSF5+jECy8wpVooiVEPPKlvoz+EVKInyCqFyWWaaxm30QEjrKKh2kKsl9xnnUm1ilDbu7FNnY9TpE+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688749; c=relaxed/simple;
	bh=C6g0A0cOE4AkGdUOdxz1HhnC5GCH/e/DvvgbquG05wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tccgwl73lRo19N37kBobCnUiuavDNJaf8cSPxw/gEGoV34y9yGubNnioBpF/5Jde4CAHzaJGtjBBKjJfGxDM/Ck1qWOBixRn3a3Vqy5eUVixV23cUFyDXXnxsBYpX/kOYTpOyeJHah3TkYmY8uV0x3gybWBr8MRabCIrAMTBwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=PaO5IVF6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26e68904f0eso69976005ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761688747; x=1762293547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tij0vdBARhZU7Q7nZ9g6692s1qvrdH+ldHofNw13hX0=;
        b=PaO5IVF6MdVaCkJfbjB51J6cBTJxeU2ymdevJnTSN75mFzRSpxPptftTXVlugJJdz7
         juax61q9+HlD17loWXC7hKNHGNVxOSVOuoAxnkTv12rmOscDLaPNLctcv1f3TxBEBKuB
         iw1zPtGvy16Lliy0Lm7lb6c4gVs0de6YS06lV2DvAkkKaejpoOsDjG+mfngje7a4x7Op
         x1OnyVKer8EfQVaLuaW95EJ4aQSwplCzjKzw4p9zJIQ4GD0gmDyf4CeVC+Bccic1t/xI
         XgZAZ3G/Uo4eyal1kc4kZrOi41snUNH/iGkIbJIj6ZwryAA861YbUGtzdxT/xBLV85va
         7oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688747; x=1762293547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tij0vdBARhZU7Q7nZ9g6692s1qvrdH+ldHofNw13hX0=;
        b=OAuRb2bamPILsQH59cGKby948vuIQ/qH4MvqXih5wHjevP6KMIZMq55tCMzMgrqaZQ
         3JgXVZboX+2HYsnLeTbOptIUtoK03RO+jTcqdkMVHEzy4rufFbG9nBjl4HwFg1OLxlpF
         TBaZ8jzINsJSJFO58HIvTV/dx7UFV83UPp+xkvtv7mVo5x8ZN6gcIVlVKfvR/GaPMJ7W
         Zn4aCMwqcExh/7TCw6KsgPtrtyDuCDPDMrSqExDGTfYuJvbKYLEJkUin0XfkxMvpBvO7
         Bpsa2LNA71zvca49aBIZXzHx2Xf/GfWCuOawSD6PGJJ9b+mkMyTPEgjOT/KG4NyLBcHI
         UtGA==
X-Forwarded-Encrypted: i=1; AJvYcCWUfeBZY5nmE5AGhapBcW5Ryz9sgQUQ+9iHk+WlD5xrSpN8nazKUEufo9n+/841P3wkr89A29s=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgfHlhNgRLZeS2W/ZB1XmRdIEVYtpX9Xt9rCOg6OOiXJ2Bp5q
	Z7X1FPh6Z7xrXlW37tssy+6SMJKyG1E+4l2/jxxo50X9bZz0Plp1wxHNZqE4BI9lcmKsP0rNuDD
	1Xn3mv0c=
X-Gm-Gg: ASbGncuKtL2mcImpFW9i/zCApRRDduglvJDa/jWYb1SB6ZIHcGKfJzgYYGbgLcBSegW
	jiwFRP2J0RkHNs26+9BU9WQN32OUgeXVbBbaKDrg2x0X8hzI7Hfefn05JY7V23Bm0qFpL80TQuM
	DbdKbUhNJtUcBQUEBIxniOBSBo+strVlaSoDL6C654L/FfikyR3ZJ1yDiGroeHX03jxcsibec5F
	D273210cxmFApTwccZIA6JesYxyTa1Oh6M2YN+0/ZiK6pbyvmje9tEtDVeeRPJbbslxIuR5BJYQ
	qjMZXyQFIU/hkoe0z1C9Kh57Lrdoiqiuu5fE+NVnWN0j9jiRCXM7Uy9HBqftPNFvXcG+hoLlrHE
	ToWyIhFwWPJDCp5rpkzUzPsltEg0uz8IXtyJM0gfma9PWGF64/cWFkUzJYv56b3YhB9BNkA6+W0
	oeksmt5De2qM8uYOz+wooIAWpqKugp9IfWAnvcVUyxfMG6t0/w+ZP0unhYMidFEA/lNw7oQQPzB
	P+MUQk=
X-Google-Smtp-Source: AGHT+IFm9U3smQa6+NdE28V6JGiqAx7ls0qtePHR+YPiXlASo8b2JGls0Au4/g3Ffd+thu3U7V938w==
X-Received: by 2002:a17:902:ea0f:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294dedd214fmr7872585ad.7.1761688747430;
        Tue, 28 Oct 2025 14:59:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e45a4csm126965515ad.108.2025.10.28.14.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 14:59:06 -0700 (PDT)
Message-ID: <77a3eb52-b0e0-440e-80a0-6e89322e33e9@davidwei.uk>
Date: Tue, 28 Oct 2025 14:59:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
 <412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
 <34c1e9d1-bfc1-48f9-a0ce-78762574fa10@iogearbox.net>
 <20251023190851.435e2afa@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251023190851.435e2afa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-23 19:08, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 14:48:15 +0200 Daniel Borkmann wrote:
>> On 10/23/25 12:27 PM, Paolo Abeni wrote:
>>> On 10/20/25 6:23 PM, Daniel Borkmann wrote:
>>>> +	if (!src_dev->dev.parent) {
>>>> +		err = -EOPNOTSUPP;
>>>> +		NL_SET_ERR_MSG(info->extack,
>>>> +			       "Source device is a virtual device");
>>>> +		goto err_unlock_src_dev;
>>>> +	}
>>>
>>> Is this check strictly needed? I think that if we relax it, it could be
>>> simpler to create all-virtual selftests.
>> It is needed given we need to always ensure lock ordering for the two devices,
>> that is, the order is always from the virtual to the physical device.
> 
> You do seem to be taking the lock before you check if the device was
> the type you expected tho.

I believe this is okay. Let's say we have two netdevs, A that is real
and B that is virtual. User calls netdev_nl_bind_queue_doit() twice in
two different contexts, 1 with the correct order (A as src, B as dst)
and 2 with the incorrect order (B as src, A as dst). We always try to
lock dst first, then src.

         1                 2
lock(dst == B)
                   lock(dst == A)
                   is not virtual...
                   unlock(A)
lock(src == A)


         1                 2
                   lock(dst == A)
lock(dst == B)
                   is not virtual...
                   unlock(A)
lock(src == A)

The check will prevent ABBA by never taking that final lock to complete
the cycle. Please check and lmk if I'm off, stuff like this makes my
brain hurt.

