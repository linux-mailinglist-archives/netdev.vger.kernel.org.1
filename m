Return-Path: <netdev+bounces-150620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487469EAF91
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE36116AE15
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB94521577F;
	Tue, 10 Dec 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLKQoIae"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A522E9EC
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829085; cv=none; b=nqrxIJdopg47hl+kKGC5AVBjfayyKhM9bjSZQYq0OxUAebuDxM/WG0f+e7CUO2kRgw2+HLoEIzngCf+khkpEaCb3K/m76NB7d6lQdEPi8aZcQAFLAdAciwtBuwkKlMJWXhPJwaS+3zGszJxF7YVaa/BB3ZyUMuMDGpMg9plvnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829085; c=relaxed/simple;
	bh=duOg5aZSaMhxVM7GBgcvBVHTwXykQZg9BKZ9NZCkqKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVqv6W4LZ9Nzjb1ppBB9n3C9Cu7ORLWpPLnjKtF2QAaYNxZMx4/oUbD1LrlvexcNoEnLoyBHzZwGxohUfCTv60fXRDDzyfm00tbNi8FdeVqygXvffiG86uFCImOPAS3Y9fVryyjKk29wE4u6ExMrFi2O4UVaGkyvR+Qq2UmjUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLKQoIae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xqlm4HyfhQR5Y2x/B1nZc065c90eXSUmuJIsBWFFIDA=;
	b=eLKQoIaeYHchgwB12ctiVinBPPVFteCyrYVOEpH7Yazu9mCqbLIL6PuwodKd2Sq+xOMoil
	gM3vTrCxAU1iSNNDV4obdMND63zDZGR56a8qCXkZdYFVHvFHSLTxYzO+rqJpNqo2kiMvZi
	KxIDZZkBKXU8d58NG4xFKGQXgYcbrrM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-3lOAbEMsNZeMViCBtWmSvA-1; Tue, 10 Dec 2024 06:11:21 -0500
X-MC-Unique: 3lOAbEMsNZeMViCBtWmSvA-1
X-Mimecast-MFC-AGG-ID: 3lOAbEMsNZeMViCBtWmSvA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dcae001fso2012968f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829080; x=1734433880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqlm4HyfhQR5Y2x/B1nZc065c90eXSUmuJIsBWFFIDA=;
        b=Fv6xMohUuunW/LhXEl2c7yhSUf7ucyObwrCzwkzZtKR5cGntaz+9RzIbETZ9yJGdgu
         bdIx9AOBQJvRJ7cZi6WKK4OqYAtjScefnMQPL9Xm0V+F8aaGIIcUJEEvTINvEETnHkRa
         OPCE4/kQ2VrRq/c1uwnUwgWSZTSnFE/OEg/svegc3U/Lenpc7gqtBAOUxsKh2LFXD62x
         AsTXH7ZOewlT/55I7JR4b895MR57KV3G3nsNRXYqYm2SXUnYrlL2/Mrkj+RaL2E71Zc9
         KRCVgXezSy/Dv3VCbONkW0GBk6sQCT8tprpx+heK44CjXE+5BhkJJpc0nvbUBun5bFQj
         ObRA==
X-Forwarded-Encrypted: i=1; AJvYcCWLRXJPxrOLczHVtS6CpGQNWvEbXeYPBsQdet/vcSB3mvSI5pBJ2fLnNryYYX7ogod0fqV0BA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklAm68S+KzLSXLXB5hg9KURIX0VsFDCyyoP3HumVrxrvRdMul
	7z6Izf4paTZI9uDnAZIsfV1xnUPu5OJx5t5nWgBGcyDooKYRDbtnHk6TJX5xVOQk4R4JE4AcCER
	K6/YhJJQgP7ffNLoUc1egwMXMo5SCobwTCBJNzW/08HyzoJa93ilNlw==
X-Gm-Gg: ASbGncu0E0kkYpYSWzOVWEvFwCMt6gtJojdyLVrzbTPyfWBP78M469T1qIYkhBLrKq6
	xLLepuV64KQqALZKgmfaQ3tdCAeirhYfRSRZeaMvp3iGSx4oWC3V/zUrhuagOQt12ex20lXLPiD
	0e8rh9tjU232jNCf5ZXmGpqvvQ2BQTD4KCXITigpZkzlVR268g//FsqPPcw3Z7g0tGZ2ScJz6Df
	41LbQE/RKU8aRWTghfG3Z7ti/3/H2m1pNQ/7BcXwLAoPs1T2L+qpS7BkRbta/q/JUND8r75fJTW
	vLCgC0alrsiV1U9JmreABxhr0Q==
X-Received: by 2002:a05:6000:1448:b0:385:f892:c8fe with SMTP id ffacd0b85a97d-3862b36af96mr11492599f8f.21.1733829079753;
        Tue, 10 Dec 2024 03:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2oYABIxVBWc0sRGGU3utHrZFlWLl3V24ghJvcAguYjtvNeao1uCnFtjBoTKC+UvX/ONMpdQ==
X-Received: by 2002:a05:6000:1448:b0:385:f892:c8fe with SMTP id ffacd0b85a97d-3862b36af96mr11492576f8f.21.1733829079384;
        Tue, 10 Dec 2024 03:11:19 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf3efasm15493726f8f.17.2024.12.10.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:11:18 -0800 (PST)
Message-ID: <ddb27716-f1cc-4b65-9cba-b8f502f747ce@redhat.com>
Date: Tue, 10 Dec 2024 12:11:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 07/15] af_unix: Call unix_autobind() only when
 msg_namelen is specified in unix_dgram_sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241206052607.1197-1-kuniyu@amazon.com>
 <20241206052607.1197-8-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206052607.1197-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 06:25, Kuniyuki Iwashima wrote:
> If unix_peer_get() returns non-NULL in unix_dgram_sendmsg(), the socket
> have been already bound in unix_dgram_connect() or unix_bind().
> 
> Let's not call unix_autobind() in such a case in unix_dgram_sendmsg().

AFACS, socketpair() will create unbound sockets with peer != NULL. It
looks like it break the above assumption?!?

Thanks,

Paolo


