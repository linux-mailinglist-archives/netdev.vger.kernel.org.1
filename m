Return-Path: <netdev+bounces-148772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E59E3192
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B562852D2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9683940855;
	Wed,  4 Dec 2024 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM+jVT3b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3317BA9
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280347; cv=none; b=HdPuPAdqHkXD0vfA2LB5hEZ1+cshVaujtY1UnOPozZ9cA87/Z15mITz6hK6txuA4wrIYUU3J1vpyKZ9Dl9sbOIh5o7naGnItmOkG4OnmiwMfA/H0IYWByjFgw32lafVPUnCAesMcULp9CdFvXh7KcI23WWymdsGdGGRQvHyMX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280347; c=relaxed/simple;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+XeCUibexr/0/If0xqGbTHpvyrNy15A/v7aG9EkT0vDAa4RPZTXNLg2NDdy0KBOTV79JuXK726zrGGNsTo/LKVOFbLJ9acrlg9EsDeiwEPn76rU/nSxElBk6Yvr+Yc5t5Xx4OdDnRKrdKcCgAlspHahKyJDeKsjYtI6KwJdVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iM+jVT3b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	b=iM+jVT3baJLnfuEtxTLnmWsRlHQGzlYlsYA8Y6/Q5NnjVPUk+Dyvlwzxl2qvaG6KiifLl9
	Xdv18RtQtoFYEounDnIFPGjTDQ+3MyaG5u+VQugwI7yMfU1/N4aFHoBIBPCRuxUaddrM2r
	QJ30NGanOTFhReveTlOQCh1B5VJlFYo=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-TIHJqkq_Nl-RK5qCpoB9_w-1; Tue, 03 Dec 2024 21:45:42 -0500
X-MC-Unique: TIHJqkq_Nl-RK5qCpoB9_w-1
X-Mimecast-MFC-AGG-ID: TIHJqkq_Nl-RK5qCpoB9_w
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4af4c4f07aeso1746835137.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280342; x=1733885142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
        b=HCVRA4uMAh5tQrgZHCPya62fuR7E4v+/zO7RVWgigahVGGKMX28wK4/B1TeHkn0d0T
         tA8ca5BGht1VABTXYP1OJieTevS9tx94JVshKNwC0a7y1/VwCZll4S0v26zbbBJxBIOB
         AnEz1pNsgYSKeMw6xKudt93plWeAMTBBvZdGVugNlYG2tmJFXxfAwG4sirzxupUzmW/I
         3FYUNaNAyZgS4bI0/3/8RRazgHVLp+GyuT3E7PiGFEaesbhFdff8yaHD0MQEUb6O6mlX
         IttCUGKYb8RiF1kjdmlwcchFSufA8CDOc10Z4VL7aow3PzJdnhLxInM4HHxQAvzU5jci
         DwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdHSBiXqbZwNTZNh1QBkFyYNxsOLHLT7v7l7NrZfFjojZbT1nTj3hyze75fAgoC5YrajqflqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dt4bittT8snIiYMovasZ7S1jxFjKxXL5CFJAYHES9NOGQCuD
	lG/Uc8lPsIFGJSag494286P8g76MjJG6VLpWe6fi0km7UXUroqs2z5N0BwvmSVGMZgAO0cWIpIk
	LdKIPYwOHIxy7fTPF+0tN9RF1PbtoOV+AD4Kh+tOJuDtsMB6uOVVe/g3BUHyctpuVf6zQKGTiFf
	lVY+qaVT9b17Y8W3Bie8T8aFhJLuqv
X-Gm-Gg: ASbGncualwucvJeAjpAET9T3EhJNKtZbE2aPCJze0qkTBw2p/WgM4xkZEXi+2hoP+tq
	4oB60v+TNF8CfaeNqoogyna1UmsqQisOT
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id ada2fe7eead31-4af971b193emr6430662137.12.1733280342246;
        Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+v2rQ020MNSJM5uPbSBJm0D0/Db89xQqRoZNc5welU5BaKs9HJz5sd95RktgMEEi3m5Dwg3PuqbEbHeQzKSU=
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id
 ada2fe7eead31-4af971b193emr6430646137.12.1733280341977; Tue, 03 Dec 2024
 18:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-4-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:45:29 +0800
Message-ID: <CACGkMEsd_fVOFcFGmW0g7DbD_G5cAudWuxc9LD9PNPm=HvNHQw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] virtio_net: add missing
 netdev_tx_reset_queue() to virtnet_tx_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:32=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
> be reset.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


