Return-Path: <netdev+bounces-194322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBABAC8866
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E983B0570
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C41F1302;
	Fri, 30 May 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zdx7EfSf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D9156F28
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587735; cv=none; b=i4ye3SjyYQNKwEOh2DiDRioR0+3qFr5tGkdGjso7Jvrc6/oTi1AZQNA+f4cOrER+3EPSs4gS11dTPU/a44Hc0DdAvHtmX8vMwUrXHZja6h1WRdGt/MLC4trzLiXfly8jTMfVJw7O6B1mU1sWPEByZ8yVydO9IabktHxZhBNGE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587735; c=relaxed/simple;
	bh=gc8la3SaXvppdABj6Q2cqjk+XZ9br/GNoKxW8tSaZu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSsNUMdlVeL8ksRgo+R00L7fKOJ5IESyGPK2Edjgk9QukxlcFxMj6O+qGz1f4arCRXt6SU0oeV4AsV3TypRYks0Fsb0SKF7WnLcHS09yADvTbwYAN5gbAw0af6DROYOkUg+7cfzqn8gehOdFZcK+2D1SV7qh1UHI/tfzvj52law=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zdx7EfSf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748587732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1vDHrajTzrjrnoCpcom2NIqdxhv65ZnMxldhkNVop0=;
	b=Zdx7EfSfrqvAt431hqzhJYZijLY756xPUoxrejolW/JGVEZCovskYiheZzcT7ZKTqf7Yr9
	j+btVr4OZBkhZq/CwKgz4hY6/FcSYOW1oYqGIiobZWN/J9loC0EZDDgY43BRkHnDMNP7Uw
	hbTHrXEEVgG1ZKL7TRmoEqQyWAQ2OYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-J-Xg27kAOTq3pcL6ooOt6g-1; Fri, 30 May 2025 02:48:50 -0400
X-MC-Unique: J-Xg27kAOTq3pcL6ooOt6g-1
X-Mimecast-MFC-AGG-ID: J-Xg27kAOTq3pcL6ooOt6g_1748587729
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so10885285e9.3
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 23:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748587729; x=1749192529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1vDHrajTzrjrnoCpcom2NIqdxhv65ZnMxldhkNVop0=;
        b=i1blZYhtmPYUiCLUV9bxi8N1XqI5GNtgxJgDS5v1I2IUOgt+YGZTDJL1MiVm5pM02c
         1boKj/TwPFTP2YHZgmCvZ38EdgzHETMSYC9VdRKrCAZzlDIlTKNFWqHSVSO9/pgVEM1R
         w/PNUBJO5OG4MFKHoVsCfUJ7BbJhuICQu9oihcbNtsKzgTmH5EkhiIHM9aVMt4mXBbzQ
         +rGS73jHSTrr15ZBtwjhL/4zqp4Us3ZxxpYp8s6V9DimLU+1p+AT2B0HPusNSMQ1L4AO
         /D2jvUjja4heyLr+Y3xrgFYKAetcypZjZhepr9rkUKNBLBHas5Bw7i/wcEfSG6Gun6+s
         N+2A==
X-Forwarded-Encrypted: i=1; AJvYcCWayUvuQ+Bjar4zEX5y/ybtQHr9pNY3t46c1OAy+35D6QbwZfnFGq4Fp86N/4Esaf7VveIC6Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgzU9HQXzwB1YWrup5sqY+JdNkE4+uJZW+Z1WUxknmWzck3BC
	0fQTbMQf8DJ/OUDIsyVkiEAJk8vyA1Ncf3Ax+0bYKe7VSrxQMMdE7rxpehzOMMQ59gUTgmJP3gz
	tPvVWd3vogPhm2/AZvOV373z6y/mgJfCEmRxMtSiHsIVCaViVsgY2PD3YTA==
X-Gm-Gg: ASbGncsx77KPQ6pPE4qrJq44nZi3u1vvje39d11zwDLT8Q5C6uCipUC7IL77YSX9Fwr
	A69umNJzLllR+5aw43lCB+KlA7f1TnKwtzo3HZnkcAnVfPzZ7QeUXQFMkhzSgVGIRePGsfZra/O
	2retp5qgR7Gq2y1WVXxAvAYv5+oQcNsBbOw8+PTQQF/fZCeG/otusIqLVAOCW/lgfJNroowjsLW
	FiwsW2wiEFb+1iHuDtt0LQgK2jSMKI05nT4v+sF/Fernum1mCoJRWzUYXm+/wq6nWGKhb4i1jPs
	PSwCXLhFJ0jnv82Uwis=
X-Received: by 2002:a05:600c:3b8e:b0:450:c210:a01b with SMTP id 5b1f17b1804b1-450d6504a0cmr21910675e9.17.1748587729398;
        Thu, 29 May 2025 23:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+uj3ywn94+9+d7ZLHV48pI1EdN47hIPoDHpX3RQ6Yg97pi6vjSTFQNaSq39/FhMnL+1/6Ow==
X-Received: by 2002:a05:600c:3b8e:b0:450:c210:a01b with SMTP id 5b1f17b1804b1-450d6504a0cmr21910405e9.17.1748587728993;
        Thu, 29 May 2025 23:48:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2442:a310::f39? ([2a0d:3344:2442:a310::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8012af3sm8915245e9.35.2025.05.29.23.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 23:48:48 -0700 (PDT)
Message-ID: <9faa4d04-e370-42f9-81e1-0759ca236000@redhat.com>
Date: Fri, 30 May 2025 08:48:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] vmxnet3: correctly report gso type for UDP tunnels
To: Ronak Doshi <ronak.doshi@broadcom.com>, netdev@vger.kernel.org
Cc: Guolin Yang <guolin.yang@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250530004631.68288-1-ronak.doshi@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250530004631.68288-1-ronak.doshi@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 2:46 AM, Ronak Doshi wrote:
> Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
> in a tunnel") added checks in linux stack to not accept non-tunnel
> GRO packets landing in a tunnel. This exposed an issue in vmxnet3
> which was not correctly reporting GRO packets for tunnel packets.
> 
> This patch fixes this issue by setting correct GSO type for the
> tunnel packets.
> 
> Currently, vmxnet3 does not support reporting inner fields for LRO
> tunnel packets. This is fine for now as workaround is to enable
> tnl-segmentation offload on the relevant interfaces. This problem
> pre-exists this patch fix and can be addressed as a separate future
> patch.

I think it would be better if you rephrase the above paragraph, as is a
bit misleading. The workaround is available only in some scenarios: when
the egress device supports tunnel TSO and only if the relevant egress
driver does not use the skb inner fields (many NICs actually use/need them).

Note that there is no guarantee that the egress device will be vmxnet, too.

/P


