Return-Path: <netdev+bounces-236272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9EC3A826
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C61644FCDDF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169B30CD82;
	Thu,  6 Nov 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR1RSx/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8D2737FC
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427786; cv=none; b=LyTC2oAVymddM4ydit1BG3718bk/ideoPsRZ6iEfkDOjQwfx2PkklJBl0EXHcVUKNgoY6JgA0bhjnBCSvrbaMNHrY4mQLwLTIxlVWYg0jpJTdzehUywA0yyd0pMToajJB4/M5Mo3/JmM/JVsWcr4fUulvH/RvI0Bm+DaC5cp83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427786; c=relaxed/simple;
	bh=7Y6mjwgDwYWYIudo7Oke6+8/zuz7V82C1eF8ZHCBf7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaADNUevCg4Jh/fm5mGDFDuOzaIoVom92kba/K7HbBWGsi9CrFMO2aNrANgSyVPoJh/fm0yUPH3isLq1DqUYObctS/vmB4XGzPYRLTLuX9oelfJVs+TCLAxLI2SUi52Fux9SC8Yw6wO6Xq3hGNlGM8Aciwl/Ts5tK66+Q+bWoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR1RSx/E; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so4731695e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427784; x=1763032584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZPs2xyBJxwp32jA5Pjexh3hPunWL3Vc+aqMJ7ALlyc=;
        b=NR1RSx/EzigZYHkO3eoe/1oFxB6capCI/NdN3+tQl7tqtQTxXiO8XAgFOtbm/kLq9x
         iAo/8R6czY/E8+VwysENazG3Kzb5CyDrDbAE+8W+a2BI/hHOyvvBrdRrqfsmDtDNbR5z
         nhbMxtzjEchE8mDCXKbYBJ9EAqfou8Eoe0jeZpZakbLO0+pvGD6fV6ZFBxuppzSq89hM
         YTdX7vxJIAd0SrRYYrdTjh+xGK0PBIyZWqToeed9EWjE2AOWNJ8XAfmlPAXwGR8fqaPG
         MbiDBhWMuo8E2aVbet0Y0ejjUP8L5hHWjnu5tdfqeAzhiOHuON30GUbCABcUqVKTFgH8
         3HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427784; x=1763032584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZPs2xyBJxwp32jA5Pjexh3hPunWL3Vc+aqMJ7ALlyc=;
        b=DcqkQWhPZdxdiNOSymTfELLKYpoderiCh7tSf8aZ7jK7PW7R9Mv+BnmM5397dhQWQU
         Twoq43brDBMtAY+22a0zXbB0AC2HdGnQNiEUHShYob2SAt5iE4FMOq0u8sDh/qeHyoG7
         JrxgrFqquCS6qj2MnTWTFfpNLehOhPOE0OEqWP9EuY92UKB/WUMp5bNEhH5lC40iRnEU
         Pbna7Ju6WdaONcBPoK1iJ1lJj9TOW7dRU7mj0twbPJbavR0GmF2N6xjaX/UXtXpKH+k7
         351ZlbHAroRaRP/9Nrxo4+i8YTlP9GJD9X7zkssAAS1hJgDd+wD44YglFHrdyPgILjW8
         +QjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqS0y1fOAAsnX8/hh8xPN9nPts07Ax+kJxdYVgrLVm39VDMsi0p6tn+lzRbZxTHWCmXAPuF+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgSx2wuEMy7863I0lQ7D3JJ2fxy/FJg8eoFodO4tu62W9Gje3a
	UvHz8CnNB2BJulfl76NffRey2vgLCFS/qZLVUPGBY7jSZii3El4q9IU/RHkRxg==
X-Gm-Gg: ASbGncsQBzViEEfN1XwmCRRbaVI/kN3mbZl7sHF9f2Yrpi0YRb9NhGYMjLmsXPQCEnp
	FLOfMtdJBPrMJ69h/dbjRkZxFfFtsGK5RW4Qm3t6Ce85CxhFbvrQDyiysUShF4bsyuXoEhxSLwW
	/nlWMRru7UHQENQNYOD2CR3GP+uEjuwG6oJrRFUFoFHJXcuUCL2OKMHs5V3WOilKkIw1ol2QrYl
	csWSg8W871FRWBWzlUsDPTx2vOt+GJrtImG14I0/MUuDGwYGvOt5q/MVPl/QaAf+f8yyecj1z0T
	EWDnsWs85zxchn0/2d224vLc2FXmLNI5VUdcWqTazo5q40jqcaqvTBimX3PLgKhAETqV0dj00Qg
	GdHSVOXSynXbdKHdRWBvtoPakdhN5+ckgY1Y2cq8tSus0cEOxJmYrNdSnEBrCdBFMixE5uZ8U7D
	h1uXViJJH2m+kRbqqqkBoUznDAplwVHNPoGiBnpydIZbEiBU0LkUI=
X-Google-Smtp-Source: AGHT+IEkWmARqtO7B1TtCYr48JE/pXPxmwu44dsbPF7TajlOF47f8GwH+/YHT3ggQMIjKGLEkTgj6w==
X-Received: by 2002:a05:600c:1e1e:b0:477:f1f:5c65 with SMTP id 5b1f17b1804b1-4775cdf2719mr42995665e9.23.1762427783555;
        Thu, 06 Nov 2025 03:16:23 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e15481sm13500995e9.3.2025.11.06.03.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:16:23 -0800 (PST)
Message-ID: <e30fc02e-7fe3-4ba7-a964-91a0b082813e@gmail.com>
Date: Thu, 6 Nov 2025 11:16:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] io_uring/memmap: refactor io_free_region() to take
 user_struct param
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-3-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-3-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> Refactor io_free_region() to take user_struct directly, instead of
> accessing it from the ring ctx.

Fwiw, it might be nicer to wrap accounting into a structure in the future.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


