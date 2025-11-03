Return-Path: <netdev+bounces-235206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA7DC2D6B4
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0238118812EE
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249A31A579;
	Mon,  3 Nov 2025 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvSfT8sc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060926F293
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190171; cv=none; b=sFuVWS3aAX2ml++NTJ5JQgRTO35e7uu/c6eRFoFcbTWAA2AGIonv8LV356//NP1oKyijNgV9go9ix0TTypKJvkETRficYrN9tKKL/XMxqsxrpN0/QbWoXfPNdrtph3wPlDffkHo2I1XQxGXvitf4wabL7ZuyDXhxXVKmxfptey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190171; c=relaxed/simple;
	bh=CZhRW1OtncLOKi77Ip0eUDc07arJUEfivIBjA8Kpxqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLeMMykdjfafxB8+yWLpIlG27YMOHl0FrDXSNOsH0BZqvdVCf0jhDOu2DDR95Pz4I4L4BT8gs7RPAhOoz3BoZc++DLcgQoNGARijwCB/iFpb3seoeNVjOIWc4rhmvsOHJ29DitbhttGW4+dVE50zZK/vtXaWqWa9TQR60oOa8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvSfT8sc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340564186e0so3977441a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190169; x=1762794969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5w8/5aXJBu3c8RZQSRI5iG88GN8IHwSdkSWP29JLkM=;
        b=KvSfT8scs9b41mXpQIPh5Q+7QLeyoD8tuoGq/VnMHmWNjHjWpkvOKcyfR+purc0ZeQ
         /N9M2hKeGDVwsvaN+8MdP4gpOY/CzleTz/jzTlKd7dO42bmbdUx8JDNg/ZvIQDYX2Qqa
         TmSisOTxDnjCyQ9Qal4OsPCBUSP06AC8PkPbK/ZeFpy5PT9M7ICCUvCR1rFGjMU7mS09
         SzRJY6VaoMCT+PkG9xM6ao+yFWBDHqjVoFp3YBJzMt9bw88/CKnA2AE9H+KBpufoT+pB
         vVL3Dls7zS6gnnMl0TlQE6boM8XM33dOK5x1IVq30Au/eZSKJt/VrFnaS/0B6t9N2Owi
         ZP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190169; x=1762794969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5w8/5aXJBu3c8RZQSRI5iG88GN8IHwSdkSWP29JLkM=;
        b=dVy2Xf1qSPF+kahwoZD974QaQVTjFnb5n4cAjAaYoGOm+AA+ipwmsU9q+Ut3ZH+0rS
         dUbsCIutp1Ags3fBKAZfE1rati3NtfKodWabUaWfU+O8J7UXEG6iuHZ0H3dE5bDqj6J+
         J3xQq7wcoDaJ+bP16zl7c0tsR8zKRF5enoupqvHkzYF37lyibFfiQkpNN+9vvaULtbU+
         ChJqqjBEMXt4BBI7xk19HVW6W+OC8MSYp9VokkPHpRi4p/ogyg+DCS6I0+2DCUbcLc4i
         +drvJaSs2Vgv+9620XTuueCcj+etPxHVA1KYyMdj8a1xmgyLZb6FsiD0V7lkyHUUFD8W
         5RzA==
X-Forwarded-Encrypted: i=1; AJvYcCWf/uKe8IJ/j/tZU6sHmolWXGEJ6SxqvOunZrM8RFCtrmJwRiXN/AML1NvLxoB9HxntbpcEMB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIZ83EFo6zSpo2B8P8QXcpZGldUoE1KjkiefEPIAQ+bJYOjyb
	7L1cBo0x4rslzutpmzbk/3YNyiFALkdmP5L8HUK07e+EMvUy5UOir7o=
X-Gm-Gg: ASbGncuBKwUc0L8R2G04vI35b5045fVnsMW6GdLA93kpLEmoabJ8mQNDWCVWq3LucrD
	SEC0mjKUNj5PBsyj0WLbmpC13IzPGUcyaQbOHTiMDpiTqURllAInyPJh2YlyZkSWItqT/PrR0GH
	kgPxhlYHSbJ1Q/Pk54BHY4jlufYbkMbH0FRznJ97e5NCjJAk2bqUP9v1oPasdE6k7Veyzj8Ka+h
	Cyt6HzWwXPZiG/A6XhyEe+3J11WIGlo/jwMB/6Ym+a/QVA/APlMPltADTkbJjjGPmX1CVIt9Ef4
	Oyzhuy0piX1Fjq5wZsO68p8ZsD4B4MNNNch42/1ewxvN6/VwI15u9cG4zbWhgkDRCCBrSSjJ6hc
	l7FGcE0r9nxW3365evrER8Ywi3AsqepqiXvDW3SwGna+OvfmEiRcmx1gdB1eefGCwEgyLUakRA0
	phokFyRCVPTSEn8DZ9kUW2qP+nZrc3EtkT/MDkotquPScYd1VMzaNhN5mK8bL5ianQr+67KDyY+
	yWBon8ws/S2mqRV0bpLBp+SQgi+LnsujeglYz6WU02ZMGvuByQYv6H+
X-Google-Smtp-Source: AGHT+IHY7TcOt9oDyCDH7yJ86R5xdknkCp9ed+4VPxM95DjgwFbWMaQFjAeRQk1RbwJdO4XHu24eew==
X-Received: by 2002:a17:90b:3d91:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-340d578f668mr9318338a91.6.1762190168784;
        Mon, 03 Nov 2025 09:16:08 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c7a21a3sm1584495a91.17.2025.11.03.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:16:08 -0800 (PST)
Date: Mon, 3 Nov 2025 09:16:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: Remove unused declaration
 net_devmem_bind_tx_release()
Message-ID: <aQjjV38DLcaLw4tj@mini-arch>
References: <20251103072046.1670574-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103072046.1670574-1-yuehaibing@huawei.com>

On 11/03, Yue Haibing wrote:
> Commit bd61848900bf ("net: devmem: Implement TX path") declared this
> but never implemented it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Looks good, net_devmem_bind_tx_release was never used/implemented.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

