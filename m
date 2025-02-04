Return-Path: <netdev+bounces-162621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0209A27666
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BD91884E82
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB152144D5;
	Tue,  4 Feb 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXMK+lMW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2C1D7985
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684092; cv=none; b=Z3oTsjrwMmKxv1hfZMz740/j5zcdnwQjGCjW2nmemQjfPB3LLwu681IifBQQT6xMtvQr8TWwcK0Q7Q5zJfREgsAmQ5VUOPQeQthvoSEfsozTzr+EiVY71ayF8AQ9UR8r1kTkqQkREKF4Z0j78XXgmJrDsjCWTdeotBpj5L02ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684092; c=relaxed/simple;
	bh=l5UpGSk0PncT3wUvfexG3N64B/AGWb+EB2VeOyFb3Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X576ap8R95sggmB+Ad24f+2zSJBJRKGZh2R5UOxEFIRLXXto7HPGzcVp7AkN2vvE7FEsDjmqJ44y4bIUSbUQVI6IF5AIpqSQtng/iyK+tkxWiJ4VaYWWelvgZsMuOJylFfQJ7cFA8rYKTsfbAgNWOrsMKrvhZCjUMzsmv93jq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXMK+lMW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738684089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhEwMtTJZmwbLWz5lbGdgRchfAWadiHGqAUa1uhiTQc=;
	b=gXMK+lMWY4ZgnySLhC8p2AdBHC7/KJWEQPpGiLVvTJRWA4+LKwnw0nDRWT30yKYdi46zTA
	fPhZ+Xoo7+hBohFWrDlOQrmbDTyXKdkptgzwm5USqVCA4qZlKg8jwINijelEXHDBhkLVsq
	mwGs5H195ITIDPMAQDooiRKKERINcj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-6Cvc9_VKNQygsBIi381ULQ-1; Tue, 04 Feb 2025 10:48:08 -0500
X-MC-Unique: 6Cvc9_VKNQygsBIi381ULQ-1
X-Mimecast-MFC-AGG-ID: 6Cvc9_VKNQygsBIi381ULQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso29082595e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 07:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684087; x=1739288887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhEwMtTJZmwbLWz5lbGdgRchfAWadiHGqAUa1uhiTQc=;
        b=h8TaWvpL6zwLiPinv2SXt1lFGwSNMwSXXx9t2dt5fMM41CpvfnUekrOzEasBKEOXa9
         0rz3VvZ0+TQNT4GoulQR18EGm6YHmRaurQ0TROYTHu9jEg2J4v6UQWKvLm5sBuvU+jOX
         yYj8Q4KHPpZwJCXpQBkB9JBOnrtpUj3LfWNx/NPyZTYDiWIGL/uwMbeCpAZ+Tzaeo8km
         SwNTrGV9+5a5vUj1Ky6K99IZNer2Ly3J6elW5zapxbtZIqQMcLuBp3EYom5k7i2zqwii
         +9NmYjShMpEoITksYMYPw1b8cv7sKCTS59FtCoA9tww8Ds9DURlTUKyL9Geb+I+dssCp
         RoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF8X/jqiF2dAo5u36kiiiSIXeU483i83GK16chGG8Y7Xpj/4cDNEabcUq/QmM9jVXy5/De0ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpXmCHYBUXAudQkb/6HOg/Sg4o1/IXaAnGEj9TgyVPx2lVqoh
	ejLsd4ZG9fV9n/rpiKJgab9WT3j1pDFAZC4S/Lgn+kyY6jsp/TEs1D68B5VvYu86TLACDC6/nY8
	lZh21zJSuFOfXIYrf7/n/Y6JadCi4JCAwGhoj0hnwXVVP63AoMq+kVg==
X-Gm-Gg: ASbGncsmBUPNk80mQCb8pl80an6vD/jcv7LE2PJaQfP/yDwXnJCXOeIq7l7WaKeefV/
	KQNUJar8Gq1qHB3b64xnGnu7IbHb7z1UbwD9MKHfVpneaOHVWWU+FN28rHQ2dzFjIuaHiB+ixan
	TqlueFgXOY7qElyUVUhTrtPAT1txUU4Bxp69uFBsiiUJx0zVlRXFI9aYFKYrrQuHlqeqDVwCI/v
	G0W+kF7r+L614NSYfdpSNf0CP5Dwb2djLmG+nld+e+zz9x/YeKfCsoP+2+M4Badb2t7fgbvoB0y
	CgTPd0AJR8OZhCqqfZnR3xa69HCT2zgDwdk=
X-Received: by 2002:a05:600c:5250:b0:438:ad4d:cf01 with SMTP id 5b1f17b1804b1-438dc3c2393mr248924405e9.7.1738684087020;
        Tue, 04 Feb 2025 07:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES1CojhwxGJ5X/gNODfndtMKujAhLqwIQegIm6kWQkj5jnLeKjbuWFYX7dO3y1PF7nyQ/5Iw==
X-Received: by 2002:a05:600c:5250:b0:438:ad4d:cf01 with SMTP id 5b1f17b1804b1-438dc3c2393mr248924185e9.7.1738684086686;
        Tue, 04 Feb 2025 07:48:06 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439069290c7sm20693315e9.0.2025.02.04.07.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 07:48:06 -0800 (PST)
Message-ID: <1d20d912-3c9a-4718-b4c9-6f5e83d2da70@redhat.com>
Date: Tue, 4 Feb 2025 16:48:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250202021155.1019222-1-kuba@kernel.org>
 <20250202021155.1019222-2-kuba@kernel.org>
 <8ef9275a-b5f9-45e2-a99c-096fb3213ed8@redhat.com>
 <20250204073759.536531d3@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250204073759.536531d3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 4:37 PM, Jakub Kicinski wrote:
> On Tue, 4 Feb 2025 10:26:40 +0100 Paolo Abeni wrote:
>> What about tying the creation of the entry to some specific contribution?
> 
> Sure. I'm adding this so that we have a commit to point people at 
> as an example when they contribute what should be a new section.
> Maybe I don't understand the question..

I meant that this section could be added together with a new associated
name when a suitable person will pop-up.

Or course that would not help as an example, and I initially did see
there was such a goal. I'm fine with adding new entry even now.

/P


