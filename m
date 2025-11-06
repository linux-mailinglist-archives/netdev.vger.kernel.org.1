Return-Path: <netdev+bounces-236271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC3C3A811
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1774D3B789C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDC230CD82;
	Thu,  6 Nov 2025 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciaHEo2m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0B2F39C5
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427728; cv=none; b=L03QWpSAzLGaPufTCRKHq5pNcF/5tvsQHlokuT3K9iX669OL6lFaYLu4JPifeu/tvKwzAtz1l9Bludflv9tlJpQsKiYpgKxtZqkyZqnkBBtgHv5QgTzSBo1eahu/wuEDB6/q7/pwIKTTxA1ymMx5bCTskWtp4VfyNaOp/aGQ/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427728; c=relaxed/simple;
	bh=usdOJTkWaf+iTY0kMRtBh88Fp3x7MBRGg9VKG1CN5wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3e9/sJdzgb628s3rtAQFCxeFDgozW906559VgR5/x84C0mApSf966YvTBKLkqyuEKzpY1EiiRFu10tmSfMgjK8yPIEhhPYQbrOOeJ/0aGF+c5inhGTPds91Cz/cacRB/Hkpk2gHerY7K5tPYLe6n8wNbxjp7Nf7l1C0E5kshyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciaHEo2m; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632d9326so5039815e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427725; x=1763032525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOTpMadguFj2Y/FLVtLbnTeNY134l04T53zoMxu74oA=;
        b=ciaHEo2mxWmFCvhLki9wwLupamaFaqFdunvyxvVdjb2sJsTOhFpcYBu788cQ6x7Y7o
         UYanrNrT9XubdxPOXcnWWpZhPdwcudQYa/GwikEUHRDy2NpqpO9vw5a8PSyGKBe+DHTF
         PDxEY1OQDGL49wsYsKiOACJjRk22ynYtxO3mA50sekqXHBO6OAY4gr0yOx0mB//sMcrT
         yoJJT51lHX0C9p+nkzHml0rsUZeB8oAJSsmVg0c9BydkizH4nAXeRRD36/rWAqHrNmiG
         Q2V0wtIivVvIp9Qm1vvhF6+VuNhuCUvgzzGV367rf1CAABzZsutOZspq+OfDF1QeATxz
         TMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427725; x=1763032525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOTpMadguFj2Y/FLVtLbnTeNY134l04T53zoMxu74oA=;
        b=v6u4DY96yejqe1VlxuUBDV/oi1JQzw3vcf2k9wboSYDd5j1o7bQlLVso2k29jo7Q/h
         k0g8mXLWx2T1hLei2lF03ldrj+Gq5H86Au24FKdQJGv195oZZdZFJi8+vpOO+pk7iEEt
         m1JDHCrymVpoys5utVA89dLhEIT/53vQokW3XNT5+8Y2fqocAjOYyUm4vsYNJA2+E2tY
         wCnxOpus9bLD0azJFkLykxbyh/du0KEojIrN24/WGriXBnG2S3tZHZXdKSf/U/bPNfm7
         jIxDRMwgfhFwsHML+IwQ5VZM3/ZXpySHD0RJF1LZ6Dz2MBgZBrnYFR6sT+HT2AXRAnCS
         8tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbIbQHB0BRe8SDwjXiTiqswix5gSkFIjNOkz7IF4SmPKkv/DOvFo2vkOxvjARXaRBrPndlmuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSt/5m1+HDp0+FNcR+FGJAlAEbQuf1x5gTeHJZIVPXvuc9Cts2
	kTGRONBuOjJ0t+8Gdqmt93sd/jm2ZU8TvySwO2WfubMohgr5Bp8GY5ko+KoaHw==
X-Gm-Gg: ASbGnctkHjaCKzl71OjmlPp1IFGjfVwvDeHHpwFycB2IhyYoEcpc7lAWVpYuhdru0B7
	9R0UR4f3UWV8Ce8dSbTjTHI2nVICWkyA6Kfr3sZN8NNIbmAv3qRBZPAvNUMj4ooH07sUmSpxNvv
	1/B/NJ0SqGWmbXGhb/XjfAjveMePRfK/j8r8y3pssl8/no830Sun0MMpG2qDLs8hDfgFFFNXVZX
	ML+fC8nCXDSgnSAOP+PCNzeBPoPHuIrVCBXP/LEIprV7SVxKWvoPv9XIhsgIR1hh2tdWxYJEJyP
	CzpZkJZ74u5sgj0bewF87Y0t6y5H7FqCDyiI1ETpzVn1D7al9zEr/DzGjcFRRXzAW3KbkmpG817
	AnG49oDHnLOgj+FTjvITSRFcZMVUhoYJ+HJoXXf6ZBZj97zDw0FRyOk6UdtEzEjnqq2+bxabbJl
	K5qks5O7u9fjHd/pJ6MpWoV4AcQTP4RIXw3JJrtbiIuvKr0HJIlIk=
X-Google-Smtp-Source: AGHT+IH7csHg9e2iXXdTBjcOpBCH//jMuxN8iBwlKTB+z7/Dgxz9Ynes+X14otLTGDAb8ZYdHjmmmA==
X-Received: by 2002:a05:600c:5291:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-4775cdf76d3mr64956335e9.19.1762427725033;
        Thu, 06 Nov 2025 03:15:25 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625c2fb8sm41038665e9.10.2025.11.06.03.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:15:24 -0800 (PST)
Message-ID: <60d48025-bc2f-48c7-9b01-f1462c2b5056@gmail.com>
Date: Thu, 6 Nov 2025 11:15:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] io_uring/memmap: remove unneeded io_ring_ctx arg
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
 <20251104224458.1683606-2-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-2-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> Remove io_ring_ctx arg from io_region_pin_pages() and
> io_region_allocate_pages() that isn't used.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


