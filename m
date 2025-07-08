Return-Path: <netdev+bounces-205108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C5AAFD6AD
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D843A8106
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C32DAFAE;
	Tue,  8 Jul 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kIr10rIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF552BE042
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000560; cv=none; b=YIsxYdKIUnbNrAYMG0sW5QIsYsmJY3A+1PtlHv9UWqdmZqt3f+9KHQSPq6eueMW+djh9hnlJRYnC0hoFCCXVmi60477tiACqTX7IY+zCMXyPoKsNQzHktpbCa2CS1BL8W9b7tyl5AlpKoCb1HAJANXRUZcyHx7f2TS98WcfbqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000560; c=relaxed/simple;
	bh=6/88khiRTnlD+ovwd/33DZA5oXLHri0226vbFIHkPLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgJpYWjNuZUjNxcTfTs11oX3BNYwXhSk15zEQM4tANzKaZ3hox5DJEXjcUuW++A8wRdKMdrY0P0J5tERiEaLSJxs1I0FJXZKmRX12lOPUCVszBeVo8Dw+VAwHxhevzdWOMXZ188wI2Pfdz/X6rJF5WXaaQWwFBmBygT++/pA5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=kIr10rIw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235d6de331fso61814275ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1752000557; x=1752605357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ9LIfhHht6H1tT57Mgqq/KVccjzkSxSjOGpsIFmJAQ=;
        b=kIr10rIwkzkqrYQccX1VnYl7OCHuwte9zlo7AjWMoKvYJjfTmkm0UdQnnwE3+KHhE2
         8Q1HD8nIma/x/gKmTivRyFX8k0v8EuRUE0nY64RolQUSDlTqWBYa9tl943/lgY7VWyv9
         3azDJhOSnM4D0ImV9tQIAtwDGJNU/xI60rfxfHTq3WoKlywWpRK78qb3h/luMkDO/D7r
         17oImBNq9N3VjxwuWAVT7yrbU4PELTh6GfpunrYOsiNWlQZqRKaqyO1S2VXH2V9PdcgH
         4vyvl9wJSWHS3g5rzF6u4HPsYjPz9JQHOjjTERqS0grl0ZkNowI+VuFaXoquxqu0m7uD
         rKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000557; x=1752605357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ9LIfhHht6H1tT57Mgqq/KVccjzkSxSjOGpsIFmJAQ=;
        b=VwXYbqRU+Pa8NmFq5jcN13nh3AO8rYMU11/lK0QKdz7HsXxewvShkJeFE7GI4y6vru
         ZnwAs3aiQjKVpYJOd3oQjGvOjIqbnQD2DJYStTo+lVWdkGmFPBTr9G0M+dwZcgYu2Ncn
         sNrQ70NpAbJO5tN1IB2D+X9NHVcUizH2T+2wIZ2/csSwzD1eJ1l7iQ3/3TJiLIBlcIzf
         p4PAJ7xjqTQFCKzfGgAIOzwykJk+bGpiNVz2b+vQYMLXXrXcGLNQw65gU4XNmmVlZmYq
         wLS5E3PR6uGQ7FzdmxAYl2jgDIwVA9UhYnqQ2sc1QyWkM/f5nM0vn7v7TuDnZHYcDKYG
         tLJg==
X-Forwarded-Encrypted: i=1; AJvYcCVUOgKCvKem+Oj7v3Gp/EyyKNUfPKswSO0dARV4WoWNbzAUa2TVl1kvMtWtjlQHE9GnkHK6kyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlT281OTtAH1dSg9kC8Dkvtzm1vgezkb4vPqVuaFIbVKFcDJ4
	p2uW9B5Rg0oPnclXbWpPaosz6KCnQnze0itptZ43p+wrm+s42TWSNX5ZoK36m+tZsEOqFHyz+WR
	QQ604CnM=
X-Gm-Gg: ASbGncupgJXykmMn1+Cn1Qdekhn7/wOxmUBg4gQTGEdh9F2PFvg+KJtTciARQZ/rnSU
	pBYLoRQJdYwpNjLBmrm+H7gm+o1g3wkEmtpDR/w0NvyjczoiOCBiSUABFDEtfWEUH9S2v8GQS7O
	32sMDjtUGgxzJEUSD1hY1Gk8WxwnQXMqZo7Y+IlWflAfzW2z1tWe35SVj1+KjWNOAShGOW3Ct0n
	5Td0ohwgQ3LqrxKPaorv52toSyOssxDno6Baq3ZHpqC9TBj0+8KBBXJibRjXlNMh8t6tDCtm2rr
	5yIiOb7EnTe0LPYZDNdZyJlIEyI8cOdU2dmNKbzAT9nwJ+H0Ct8hV5wBPxHFXic20Ffb4lLoFeR
	NNeIKgJe5UlwBbjnLrV27K11K6tquXLbS2vU=
X-Google-Smtp-Source: AGHT+IElerbgV4E7bAWnn/FXpBfbzVbW3y4Yn+NthwGnxC0JaFok3uYEQvcgITGUFkqORd0IGvgmOA==
X-Received: by 2002:a17:902:c408:b0:235:f70:fd39 with SMTP id d9443c01a7336-23c85d9df6bmr310008805ad.10.1752000556882;
        Tue, 08 Jul 2025 11:49:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:14f8:5a41:7998:a806? ([2620:10d:c090:500::7:14ad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d0b4sm116905655ad.125.2025.07.08.11.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:49:16 -0700 (PDT)
Message-ID: <00448c06-1009-4248-8796-1a1308b850ec@davidwei.uk>
Date: Tue, 8 Jul 2025 11:49:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: hw: modify ZCRX testing support
To: Vishwanath Seshagiri <vishs@meta.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <jdamato@fastly.com>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 netdev@vger.kernel.org
References: <20250707232223.190242-1-vishs@meta.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250707232223.190242-1-vishs@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-07 16:22, Vishwanath Seshagiri wrote:
> From: Vishwanath Seshagiri <vishs@fb.com>
> 
> Changed the test cases such that the endpoints of sender
> and receiver are flipped based on the typical conventions of netdev
> selftests.

In v2 please change the subject to be: 1) more specific on what the
patch does, and 2) add which tree the patch is intended for (net-next).

There's a 24h cooldown so please resend it after that.

> 
> Test plan: ran selftests between 2 vms

This isn't what you did right? Zero copy receive doesn't work in VMs.

> 
> Signed-off-by: Vishwanath Seshagiri <vishs@fb.com>
> ---
>   .../selftests/drivers/net/hw/iou-zcrx.py      | 98 +++++++++----------
>   1 file changed, 49 insertions(+), 49 deletions(-)
> 

