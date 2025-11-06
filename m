Return-Path: <netdev+bounces-236283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A6C3A8D7
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E23174FE267
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08C12F2918;
	Thu,  6 Nov 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6B9ndH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA330C600
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428065; cv=none; b=I1pVzbCoWeGXvJy4x9Chmph8iiC39zLl0qxkf4Gyb25bqsiWTHBcNQDMfvtdQJ9QMlWwV9Y8EdWurKeov+Ynv6x6hjf4ponh94TFFcU/yzzDI360n3pWQA60mB20b8Ghhkx7szdvxJtJB3COVOVqr34Iqi7tPojJ/O4C22wmGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428065; c=relaxed/simple;
	bh=MOfVxyEQ072NSg4BP2xgIsHDCPu9OW8wnY2VxStT1ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra4e1/4t1oxoe85/iUC1d2EdO3YiR1yjez3XuOT2ZQ/BiHzA/bNUEJmnlIao/FzBjPRGh/FEJ30FEHyhns9UcPNSajKJliRDiChAmXsGZBzdomkh2300QZcb3ws05vITZxuFk8S+dohxWVOBoMlYMu3R68yM8NiStLAcwy0iyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud6B9ndH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711810948aso5822225e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762428061; x=1763032861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3SRtvHsIYC0vIByUL+88tLoRIu/W5pJn6djXWnnRr8=;
        b=Ud6B9ndHmUMhhXV+N6GjPFXfqwXmzG8iLCUoqdBlFgPK38zmHflYowGKsy4Y5LHT4e
         /3o83xA/kGJaQ3Xi1ie1a3HbIW3t3xWpXs26K0HRJVj/G7XPFaLzI6reaLP7TZSZQJV7
         DAElS6WrpVRQYWSbLLnQYFt1D8P42890ZIgqqMFLhNqr6qERvqpe8u+NnUwqcfLWDVMZ
         AFs1Zqpbe0pFjgRNWg/Balv/K20n5XbN5LELJfNx2lET0su/kVY/JFm54hqToTKH0ckD
         +uikIJrtN4K4iAtp731RXmBBkAIDlnLwlsmBPuhNVa1RTQN4yJpg7pnpAREZu2f5L4Ey
         5EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428061; x=1763032861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3SRtvHsIYC0vIByUL+88tLoRIu/W5pJn6djXWnnRr8=;
        b=to99a9Iwwn9ErbW0kRZXCdyz5jcAHrx0cuaQGjUxrHw5rnHdVSkp2mLssHJjB7eIis
         /aauSVcb1Z5hXb5lkb3uUGgrt2jZTKlVxCjsqksg4ROqpry7D47Kkhv12WSrefkDavVz
         W5IYIwT/zo8MGoIqH4XW7PI7IxDF2Fd11LtHlVf2Gawy2hfSeM40cK3x3tvstziwzlV1
         I6enJe8Cyhjg6X508J8PkPkhJCu1ElTq8wlIg6PuARlfTll8aXWIkjT74EVxVXi1yM4W
         uoLlprWqshrrIFZzMQFspHiAxq5dxPGQKY8QFLSspuR6dHriCa0OXZ3gMe7xeZNIc+B8
         NFQg==
X-Forwarded-Encrypted: i=1; AJvYcCWpMVOHdP0QApH/YYAyQMqOxWXGHFhlRJfrZYzfT7thOnBsjETbOmVqKZAMvyZL3+m4fWWgW/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRe08VhXrdZSEkdPnHUAvsnbrMBop5VVcpq7n1/rfMdUhcK29
	8TA89+RA2snupbPB4Njuess3XCyYyT6cZ/xFkWvkOxNILck47GMdq7Zl
X-Gm-Gg: ASbGncs6CUJf2BELxksvcFJuoOor0/0N0FjUcHp30pYlarAkG2F/4hn/XABqLYDiv8a
	9/X7jy4LBdWeRgndgYU1HwDKEMZk8Fk3UFBoHLr8T3JEqjf9KJ974IVdaNmgEaBIkYuh4PSb/Pv
	80dB0wtj52YsW4wH6F8TxvyVixU++uwiTaCrqEj6Ci1YiSkGj22a8RLGYf5SkBb0O9JOlpsDm+p
	0hADMe8f9A1hB6TowMYsDHbZeKVXvW3ocUcrZL3NDJ4QDi+L5SzB8VitUvDu/zXuJCryhz/S1Lh
	uJ7MtYqSRuCpjt3SSxQRSOneIkaDrmav3ENZxN+fXV8HLLQz+tJ2uZP5wmxKuHnmVsVG+HEb8/l
	uLMH5mprqG7yuEDc4Xrbb6is0wOYevegon4UDf65MwBal74nqPqHpTEv0wBXL9EYQIR7wPc4v5I
	XjIcyh24X29oY2cFMK9ul4mmB9gE3OWEup+4DPe6brGDin+/IVkvc=
X-Google-Smtp-Source: AGHT+IFJmdgV5xNlzlC/wIdZlB2h+f1Q0+jRo/ficTf01tZOf9bAameVlnIquupx8Dy2fBB1WZnh1Q==
X-Received: by 2002:a05:600c:458d:b0:477:598c:6e1d with SMTP id 5b1f17b1804b1-4775cdcf05dmr57240105e9.17.1762428061321;
        Thu, 06 Nov 2025 03:21:01 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403800sm4307102f8f.7.2025.11.06.03.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:21:00 -0800 (PST)
Message-ID: <fb68c19d-d3dd-45c4-a460-589fd246db5f@gmail.com>
Date: Thu, 6 Nov 2025 11:20:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] io_uring/zcrx: reverse ifq refcount
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-8-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-8-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> Add a refcount to struct io_zcrx_ifq to reverse the refcounting
> relationship i.e. rings now reference ifqs instead. As a result of this,
> remove ctx->refs that an ifq holds on a ring via the page pool memory
> provider.
> 
> This ref ifq->refs is held by internal users of an ifq, namely rings and
> the page pool memory provider associated with an ifq. This is needed to
> keep the ifq around until the page pool is destroyed.
> 
> Since ifqs now no longer hold refs to ring ctx, there isn't a need to
> split the cleanup of ifqs into two: io_shutdown_zcrx_ifqs() in
> io_ring_exit_work() while waiting for ctx->refs to drop to 0, and
> io_unregister_zcrx_ifqs() after. Remove io_shutdown_zcrx_ifqs().

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


