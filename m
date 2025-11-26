Return-Path: <netdev+bounces-241861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 373DAC89787
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 148404E39F2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087DB29BD85;
	Wed, 26 Nov 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnEXt2xL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ma7Uy44M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201B26A0DB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155824; cv=none; b=VAf/m0+RNLLlnjXF8//kcutD9tEnQGKabUSeMqnLAIwkk9OPtc0jwjTNXz901suYk+8xfxQnl3ccf09gD0CIHTU45XsGhwCBbGCgdXELzoyb6uXd9Vx4dJqI/BY7r1HnMSZqDu+sr/bbgbOqTyL7mC1otNOsSWnMJIVSoUhzqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155824; c=relaxed/simple;
	bh=FXLxuWpTeNt/gfc34ZFouSRfw/ZzH7LBsVSlB2UyowU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwOXPf3a6oT2/azWnUTn2qHVtw5DneXo1sscJUU+PFhl4/kH1oH+SR6Qb0emfaAq2QYi7uXxkOTkEe9zGfEdAOYogwu/m8jYYaJMXRQemMsTyDAuTuEakfUUR3rRCbYnjLN1AifC9vV9mm9RBGlGQQvXImz+atZgTF6QAgbHULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnEXt2xL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ma7Uy44M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764155821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXUwg2yPl9Js7/5lQiVXWW6sjL6SYU5SIFbfaH9Um10=;
	b=NnEXt2xLSkZ0/EGroPkqa3WNdOs4SqskVhgNH0/JyZ1p4J08/FlR4GP6JsZubuA8wLiPs0
	ewePlQC1TmwgxcHJcUEy/1A0yr4F+Y4Z8tmPwHP6rBrsO3ymQOKo3nUE2U5bSFK7f1+RgR
	Az5VgceK3ySLk4wi20/rqA9MDOCCVGs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-xc-8zjFTP5SNEjePy_EE0w-1; Wed, 26 Nov 2025 06:16:59 -0500
X-MC-Unique: xc-8zjFTP5SNEjePy_EE0w-1
X-Mimecast-MFC-AGG-ID: xc-8zjFTP5SNEjePy_EE0w_1764155818
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso25313935e9.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764155818; x=1764760618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXUwg2yPl9Js7/5lQiVXWW6sjL6SYU5SIFbfaH9Um10=;
        b=ma7Uy44M4ewzjn3tXn+ARtSKTRpdeZ954SL3r2xwFBr5wNajaTzxxzqnsUSbA1oFtw
         ARjSS66L3P13jA7Kl6FQ3MPyLcCR8LOSmu2N9rAqXBhY2+UHn47wMUj3jxLeFZj326Lh
         DLnp2K4to4xyRFs1e7lzU9JFMdmsXW3uasL4bm2zlwTxxLrJ8Uj1bM0YPzmMyX+iT+vQ
         DyNas3yDy7a849i3bPu7j8CZ4Rk8Dqpl25esRME/UZkSzfwEzMFKWynnlW0V8oTeabrB
         cLsjKQDm2SQnMLIZwSzsy1+ErVj+9RxlTlcxVU60fhUIdiPkAvhIbE3tpIUYbSIobzSe
         cH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155818; x=1764760618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXUwg2yPl9Js7/5lQiVXWW6sjL6SYU5SIFbfaH9Um10=;
        b=vUJh1+q8QdIfDjfFlroFfLIrZMnJ8Biq4J7C+1YW63zURZfem2zGc0XnTpz4l9hHFF
         7fxew0zwMOCGY132hu43SobY57pFc4rp3DiyB1HoA5wERjrfwFIhl5e+fxU7ptR0i0Po
         JBLgJU0LIZVMG9K20/zRARPbP9P0mZU0FDFljdf/jY6IkBAqkaEZlNONpmpPoe6jOtbt
         JTvTe+6qacRGcOKWlelUSBNTd7QS8KrQzc7A6UhNyFf80dlEzxJxd4DgfroYUuTCv0jr
         9DH7aVTiVNVdBYNUT3C/dzbFKqlQKCcWXYlRPcQjMQDsdO/NxkPGwBqqtCK9yZdPKhjX
         6oCw==
X-Forwarded-Encrypted: i=1; AJvYcCV3BGcoyYZIOFB+7AuOEA9mcwowAmDbdCBQOQNnBi/GI8BGacEJKEqQ8uPCa/3XAVidqCTmMrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3M5dFO1woITXt5Y6F97u/Dh/QBkNobJeG8Y7D6mwqEC9DTkSW
	SU98AkBiC3fe4aPzBJS1cRTGJOg45z0sLkPys/UBkADFqcCOEX2rkfsiSedkRFJgWa8tU10D9z7
	aBDY54Thv9wSeWwFW1NkSXeA0+sxFaZNCGDHOc9mbfyJpKcKcbAqdrfnSJQ==
X-Gm-Gg: ASbGncvmuVL53wcY5fWJKtEPp0q/gtj64pCLC+XVg10FVZalO5yxUSMkjT2zOO8aUcO
	d65BiNyJ39CfMvIkdqetd06kePARVPUFjjetiHvSSemYZHCFZlsmVCtPmOSzmCanjRCRRdvImAu
	Llvp/LgW83QcSsg4ps7LDgAFFmw0s065Uw9Rj5j99jT64Rk2i/MXoFPDIskvagb97XSjmailLHZ
	u0/1mC1+ggebzj7GrAY/4x8W5H8asYVhob8tkCS18sO/vJUzJgfv+ZWKGh7AKrV/bdQ5nHlwid/
	9nbnWFGusJ2ocz8pUCQriVJCER0js6kDdYv/Bmw/XdbPYLgLnd3j0qTLb/xeM2RDGluaQWw+/2D
	jleuVbfkMM7MOlw==
X-Received: by 2002:a05:600c:1c8a:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47904acadd7mr67184745e9.7.1764155818323;
        Wed, 26 Nov 2025 03:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLz7TMJoiEY5ntWwLrjinKIkPuhGf7MTOYlP3j+7T2Z5i2/y+3piCR9uvk60DK9W3uKWuN6Q==
X-Received: by 2002:a05:600c:1c8a:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47904acadd7mr67184455e9.7.1764155817906;
        Wed, 26 Nov 2025 03:16:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ab8b21fsm39688885e9.0.2025.11.26.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 03:16:57 -0800 (PST)
Message-ID: <abb04d29-1cd8-4bff-879d-116798487263@redhat.com>
Date: Wed, 26 Nov 2025 12:16:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: avoid unnecessary checksum
 calculation on guest RX
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20251125175117.995179-1-jon@nutanix.com>
 <276828c5-72cb-4f5c-bc6f-7937aa6b6303@redhat.com>
 <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3ED1B031-7C20-45F9-AB47-8FCDB68B448E@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/25 9:00 PM, Jon Kohler wrote:
>> On Nov 25, 2025, at 12:57 PM, Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> CC netdev
> 
> Thats odd, I used git send-email --to-cmd='./scripts/get_maintainer.pl,
> but it looks like in MAINTAINERS, that only would have hit
> VIRTIO CORE AND NET DRIVERS, 

?!? not here:

./scripts/get_maintainer.pl drivers/net/virtio_net.c
"Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET
DRIVERS)
Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS)
Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET
DRIVERS)
"Eugenio Pérez" <eperezma@redhat.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)

The "NETWORKING DRIVER" entry should catch even virtio_net. Something
odd in your setup?!?

BTW, this is a bit too late, but you should wait at least 24h before
reposting on netdev:

https://elixir.bootlin.com/linux/v6.17.9/source/Documentation/process/maintainer-netdev.rst#L422

/P


