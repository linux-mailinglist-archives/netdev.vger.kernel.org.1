Return-Path: <netdev+bounces-157010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C708A08AEA
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FC61688C1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084E209669;
	Fri, 10 Jan 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="W01zWdKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442C206F06
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500044; cv=none; b=gKoNKry/DKlwBD1bstFBks7w8etgb6yuRvI6GlUeGpRckzaGIJtSGqrRjw2IM5daImOBF2rdtB5pU+l32aiaznx6F3UsOX4hH1nvZrCY/rQKOd1wbqN91adVNIi1+2YWhIq21DsSRTwjyNLxOxbZMqoIyE3tOU4dA9hmaspe3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500044; c=relaxed/simple;
	bh=mJqgKsIX8JTRfqDD+I1SI8NjK4HyCThVNrcvwxMcg/M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=JQA2QKc+/JkU4f95dwuRapqa0Bs65+O8IEu3iH/27JeoHsI8O/MM1IXOEpj91bHr75Ge3HXQjUe9k1tkfv0tGSto94gm2MfL3L5Z5baZnQF5X9SRqKMX7tY34JFoQyEJIixq5P1a0bZciIBYnfhuDFwpuNwjkjtViOv2vtHhaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=W01zWdKk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeef97ff02so307864766b.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1736500039; x=1737104839; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bivfEXb0SUuBXZLG0UoLAS1vXjT9WbVPSPb5v7e/O4Q=;
        b=W01zWdKkw6bIyUFdez0BRxcFwc3a5eo4A9QP5dsJlWTUMe4Of2QCqYTYJgWYunxHSx
         iVl3KiAJB/jl/0tRwsqLFT2lmXAwLgxTFNV74YM1MQqWS9HhSBS+gK1U4qMG6pcaS5+/
         Fz9ZmajFuwWna/5rU6G6PexxVPbhzrbxAzGk3cuhI4wiRKbZvJWf9bEnhzuKZ++6PwBO
         4xOJum5YrzPIwXmOIWDutCLmnv7kkvtgMPuZAKgrHJFpXCPMogO8EccjDj9TyXVny/3O
         bp1pT6/hp9twzyHei3VFdEanluFTVTPzq2i2Qq1svsS+9icXJ6vT5b5lzkfFSKvPvlZT
         BrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500039; x=1737104839;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bivfEXb0SUuBXZLG0UoLAS1vXjT9WbVPSPb5v7e/O4Q=;
        b=Fc/4E/8A10S82onP3sWFetqmsbK5TBDB7Noxur9NxlKmOl5AMfZWoKSt4VFVuE4qoW
         8CkoktB/MT4PjxS5Zb214iqB2Nq1HMOvCpgFdipVaWTFl/yGeSqRQUc5TDIaINSFzcjz
         YL+HoWg2cWRlZoeStNtC8hM6UUiAXSZa9x9z8a3a+ZbJ0ZqWzC5boaiB03UgS0l/yPao
         swN9mxvT9s1zw8FOY6vb3EtU67bybIGykTiTT/c3zaX0ZRZjs4k3nsTfBpS3PTY7cbYc
         849BC9U4zi4gfI7leykztYwSQQrIdMQ508LmtM7thvE6xgs5SX4GGoEYQ++IDbVE8MWD
         C8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLu9WuWrDOQx9dBWBQRcXyT2Lv8Nms5Zdg/cp+HCXXNhe0YE0tU+Hql3znkc8I/rcL3Lf/lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6Ya2KHbLK+JQtnm4U4c+3F2Ep9OkotkiFphe43L60dfljUCI
	mLTgw2TV0SCmvg6HyHaz8D9GyjPSjDF7wvs7VjQN+bxvP0xPioKRKIASYjOobpQ=
X-Gm-Gg: ASbGnctcxzGJYXy3/ej9LVCp8jKc6pbDU/ZUzy+yAOGy/IZpefz4DLV4ddrPTzlo/Uj
	h6jM9dtASVkIKB06lV8D2G0BoqWMCnYUUhSvSfBJXOsiDpnc0PHxwGkQiRzMAwZyfSZ2RCb1hyC
	y4LsKoRy4Om/fubZmNRjaaPibjEkHH9PrP8nTZ7FaBnKDEktANvQ3aquenR+94tnDIB/LkJM8aK
	A3Z64KsiSrEK/sA+WcyZfBsOIkWUOfj+vK6RC5hlJe1wm1vBtuTknEsdOvNhGe7/acq0lCZr6Ns
	mv5/
X-Google-Smtp-Source: AGHT+IE10SlroKQ5y0Lz/L4dNL2RL1GX1Kf54btjmslD/qSypClq/YVxTwxwh4y/dCEbf7+FbpZqhg==
X-Received: by 2002:a17:907:94c2:b0:aa6:824c:4ae5 with SMTP id a640c23a62f3a-ab2abc9f6e0mr763522866b.56.1736500039098;
        Fri, 10 Jan 2025 01:07:19 -0800 (PST)
Received: from [10.26.3.151] (gumitek-2.superhosting.cz. [80.250.18.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d7432sm145924566b.49.2025.01.10.01.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 01:07:18 -0800 (PST)
Message-ID: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
Date: Fri, 10 Jan 2025 10:07:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
Subject: [Question] Generic way to retrieve IRQ number of Tx/Rx queue
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I am writing an affinity scheduler in the userspace for network cards's 
Tx/Rx queues. Is there a generic way to retrieve all IRQ numbers for 
those queues for each interface?

My goal is to get all Tx/Rx queues for a given interface, get the IRQ 
number of the individual queues, and set an affinity hint for each 
queue. I have tried to loop over /proc/interrupts to retrieve all queues 
for an interface in a hope that the last column would contain the 
interface name however this does not work since the naming is not 
unified across drivers. My second attempt was to retrieve all registered 
interrupts by network interface from 
/sys/class/net/{interface_name}/device/msi_irqs/, but this attempt was 
also without luck because some drivers request more IRQs than the number 
of queues (for example i40e driver).

Thank you for any help or advice

Daniel

