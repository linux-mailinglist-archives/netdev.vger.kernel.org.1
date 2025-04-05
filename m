Return-Path: <netdev+bounces-179418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56678A7C83A
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF3A1894A33
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30461C3C14;
	Sat,  5 Apr 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DP5dW5oz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E6224D6
	for <netdev@vger.kernel.org>; Sat,  5 Apr 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743840860; cv=none; b=sFRM6LNjWZaKWDdoZiQnR/T0WTD9sVafmRrAXL+r5fBEVQfYKjaJyyqBTD5awfqLPzXHT+Q8WHdCXOJrvgzG+M2KcEr8j3yaZ9DEKlSAH7AdgjkZif3KgossT14ZP9cPTktWGips9OsF/HPrXskEM3CX3hcOAmIA1vGlV/w87c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743840860; c=relaxed/simple;
	bh=0uHZxEe7XrTJDst89mB8hK8itnIDw021YoHtu7tQZ7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU2rd135kvY1hMAG8xGwNyixTajeo/d01Jfrvy6Y+fxsyjjPvgtmeP/lFvIkizWxq29cSM19DMOwiHy17GyltRfCrYiWYaz0slh6sLRHENMGKgmJLEzS2C87OuaD87HFVb7Rqmj2dKmK5IUQ3muFJ6DWASzKRvKPmLi8jza6Fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DP5dW5oz; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso13364295e9.3
        for <netdev@vger.kernel.org>; Sat, 05 Apr 2025 01:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743840856; x=1744445656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJMIvKqHoFlNjkAPG072V0/WXmbwCX45M2RN3605BFc=;
        b=DP5dW5ozhxwHgILo7835vtKdBGGvfi6HPifeLHofc86X26J9bq2YkJXJBNOVxlep0e
         CQ3VXdsI+l8wjZECVTFjE+5hGsKqE6Wi+sKdNcJ7r1gnqu9Oh80O5Dv00PnQ4IprlnJe
         fncG+v8ypInGcSNmTcT2Wf5ZRAJoGTVZH4GxT7PwyTt7cn5dlEevhldIZ5mZWBXV/58q
         ClsgzRnXMOh/8IN/PfdL1XzOKd67yfRKPKWKLkF6vS+rkhz+opRDMBWTjqfAxkdf1wt4
         uZwGkhdOTeKXMtxrh2QfbXWqhip9Fmys2oLxQbuCn8abTfYQe2hlB4HHPtSO7mXWGUD1
         fPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743840856; x=1744445656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJMIvKqHoFlNjkAPG072V0/WXmbwCX45M2RN3605BFc=;
        b=B0R5spi87AGKDBvI2OA5Y+s7fBv16X7uxjlKztv1Mb9O56ABKm1iYK6WixKhksPFh+
         Jt69/qYoctcA0n0FhbL9SaIfAcONo9InsHEz2GRp9Ojqb35yJlt1r4WqQnR4qEIzJhdE
         5rzoagfg1AKolberVrXB4JduKqkIoFZDOWdo0kFysa1ZKMoMpAoKjGQgONdT9Rm4YIC+
         OCsiemZ/6SPGEpV8ZxitGHXncNknGAnWYRqu0A1hgYnuGi6W2DR7ckIEtuweVkhK2n4y
         9H5BsSv2EKUj9mIgcCmlItp32KxR7w1O727x8ev3t2tuHN6L9Ti4Prhj/RJcBWHsj8bk
         au3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgrO92nhT6UHBsKR1v04fqU689SBT0EnrzdrEytKjIBzG1LwLS+vnp4XlNq7Q9UKOV8oUyi5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRM7tjIKWjDiluMeYxUnK6K/w5nHQsuTuqolfu7Oq3BtU9BW7w
	i4NRLf1odE7Y5TSP9eKgBvI9BpjzMbOQ2q2wDA25rONH6RYAXY7Nb2FzszFxQK7kLhwbLm6YP6H
	mRG1jwA==
X-Gm-Gg: ASbGncs4sTuUfb8R3pk+6VJlgM9cJBibpbNuE0xiOIPBW5NSzSzNpLxn+ff/KA1S4tW
	IoZcl16mRDU1dwqMjKC0N8hoQI383QsfeZIkHDqe0l813O0eP9fFIq6IhZtZMJAQy7N3V/ELeFd
	2oHE2Jb4jKR8Jq4HtlMAeexl6N0kFs2A4f9uFkTQtYJbiF422AwE57pbCTJCf+EJ3TSO5E9ll7h
	572THgbmu/y8KWMBL2Jdny1WQt5oJVzCQ14r/BpUy59bTu/uCgbGk87+8mMRUrO/gDQYtOEv2IN
	A4YHySvJQxKrkGP944pO1GG3OM4mLhN1Zrq41bdxqhuXTJla5xoETHPrPYq0PKyl6IDJTKbgWuV
	jmpSCqq234kc=
X-Google-Smtp-Source: AGHT+IEcuSu6lzaAzckCsCjmkxVQbCqAsMtgjYTxhj0B1iLZWt/aU3LfOwwmpGP04b31fI8GiD2lwg==
X-Received: by 2002:a5d:64e9:0:b0:39c:1257:c7a3 with SMTP id ffacd0b85a97d-39cba93d9eamr5505067f8f.59.1743840856218;
        Sat, 05 Apr 2025 01:14:16 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366a88csm64665095e9.37.2025.04.05.01.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:14:15 -0700 (PDT)
Message-ID: <8a758dd8-b423-4d03-8f33-88b81ae9c24f@blackwall.org>
Date: Sat, 5 Apr 2025 11:14:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 iproute2-next 0/2] Add mdb offload failure notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org,
 Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:53, Joseph Huang wrote:
> Add support to handle mdb offload failure notifications.
> 
> The link to kernel changes:
> https://lore.kernel.org/netdev/20250404212940.1837879-1-Joseph.Huang@garmin.com/
> 
> Joseph Huang (2):
>   bridge: mdb: Support offload failed flag
>   iplink_bridge: Add mdb_offload_fail_notification
> 
>  bridge/mdb.c          |  2 ++
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  7 +++++++
>  3 files changed, 28 insertions(+)
> 
> ---
> v1: https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
> v2: https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
>     Change multi-valued option mdb_notify_on_flag_change to bool option
>     mdb_offload_fail_notification
> v3: Patch 2/2 Use strcmp instead of matches
> 

Somehow you've CCed me only on patch 1. :)

