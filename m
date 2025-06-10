Return-Path: <netdev+bounces-196063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCEAD3601
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C409A3B75B2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86D290BCB;
	Tue, 10 Jun 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Hl+c7KWr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F1290BBA
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558093; cv=none; b=JVKBLCgxJTVhAgHo8gtrf5Eq2xKQJCilCkbTMk1Zx/JfbnsAm9cyPtM6Q4vw2EfGWIprkpeNPzm0Nf9BimDCDgWVTLKJLBS4o9H0UnSOeMxvYXuOy96tYOkzw3Bgvt817eYW1W994T0IusN1kQON567MVWVl8VjqGatW2qK13SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558093; c=relaxed/simple;
	bh=j+kjI1Cr46kXYcnCOLIGfPEopv/e5BdzQZE6/Lie3LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTIVSCvYZHrQnG1KgtIN/Ysy9MUCRqumT0IM6JJPdzMncyhdUZsyDY+Cn9XbHl9+61tkZR+RD0fissh2Gl6SOIWh/aONk7KlnZt5exY2rS9KMrCnyLnlV+5hwjqhr4JQQFIRX7uM3jz+2vTd0V5oBBw7MWAPu7TSXz+D4DGzLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Hl+c7KWr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54b10594812so5934101e87.1
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558090; x=1750162890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90hBZk4CDyR14IAw9VNCcUh9JhW2CycBOFXCvhBzbfs=;
        b=Hl+c7KWrfPzjuh1M88aZXNzqkFNEe+SSIJAcwQ8i4J9NdpYV7JzOfswVMhc1VoTJRe
         BW34LLttfiVP/q8wJcKxsnlGQRWXvsNrrtfig1kJd/zDG1mXMXuUlPaldZha/SI/KbAC
         Nb+A92HFAHlERbRNWd/7Hf8buwmsNoaXzhQmCE2kX56xZlC/cCtmCpue2mXJUXPKVFJX
         dYlaUe3nQbAz0YjVCC0VoHGZeMgy4t+cTVLH5N9XMd/ImZF/nmEVR7b5gy1mB1ztD8RT
         aan+ZRP2WDgWJCL0halbCVyaHFoA9sIxMJU4CvQHiBPvmHjExvYrzYZD24z8x35gtVgt
         +5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558090; x=1750162890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90hBZk4CDyR14IAw9VNCcUh9JhW2CycBOFXCvhBzbfs=;
        b=n8T9hGdgasWzKxTIhkwnqmhEI1CQfYo47gb8iy0kQnCICNNP+leEsJEe8nsxGcGVvk
         NqpNBTDgBuCI9LreeERUa39VErK7aTBkCY0lXxogbqtpz4Wj/zj/MyEKhogWvaR7Z9ig
         qdvYuPvX+Xcozd3PTKo5uVezGpJmSZ8CAMohykG/25fG3zrXryHqNOu5gf1AidyzDLTO
         n0CpllEhYqRgTND/OlFFvmggbKQnpp+X8RVEAzQ5fLMTpmXwoISuSHlhCmal1Ew+DffO
         369YRs1NjeVD9CCUnB0B66pADtwpn0iRVpn7F6HIQfOrhM6KZP/E+t9smC0c6JB7ziji
         A71g==
X-Forwarded-Encrypted: i=1; AJvYcCUMAN5gOd3k5VTo+M9UPI0VW7sPlyBgPIHOyl9RqOhS71h+l2pvWE9Gbx5MV9xAENYi8kYk7r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yFlGJ0Qn3RozvAOeaMJWsonVlrJPADmyH5OEHkl6Um0tWOW/
	Qc0xKqsCsioh1WWWVK5UdXAcVg7nNa7Xp1IzICtqhy2GTJ7+yFP6oQOLEF+QZP2sldw=
X-Gm-Gg: ASbGncv0lubHys0rxS7vkPZwEQIL4Liv3ttKitRzY/vGXCMJcgP3f0QdEFqwV/RzMEE
	AJDtGXxAcjgNqZ9jjs/AFF+v4IQiVkPupnacYOmZC+wjx+DX+RSTREioavi1kspTYDCXF6+SlEY
	xlMJ2Slw48toap2hYqqXdku1I68uvjkfaVvJPfFi/sNnUQHdI+LtXULiLua3OfdAFKdYiYFEEQ3
	DkpaLXdxA2aZEaiiq5Qj/v7xcBTwHasXGE8bisDFKUNLUrBKxsL5b5xpjw9+Asc6InuRo6cRt4I
	aQEOXsx/iwXbfenTnmS7X3fk1lHOnht5eTA4aBr0BXxKxGK+pqReG2FRZF+RytfR4O923wfmYWL
	lfc/BP/nBlD3d72GAlvC8FIrbNhpvF9c=
X-Google-Smtp-Source: AGHT+IHmGTena6fqAcYhevTo/MniFuCsCwAJhSNtQSdZdrt8rUXODpILzrQfAf1qsCiMYoGHYp/zgQ==
X-Received: by 2002:a05:6512:e88:b0:553:2f78:d7f4 with SMTP id 2adb3069b0e04-55366bd23a5mr4565732e87.7.1749558090387;
        Tue, 10 Jun 2025 05:21:30 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722181sm1557175e87.132.2025.06.10.05.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:21:29 -0700 (PDT)
Message-ID: <552e0ea4-f8b0-431a-9382-95adad7f2b9f@blackwall.org>
Date: Tue, 10 Jun 2025 15:21:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 3/4] lib: bridge: Add a module for
 bridge-related helpers
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> `ip stats' displays a range of bridge_slave-related statistics, but not
> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
> code to libutil so that it can be reused between the bridge and ip stats
> tools.
> 
> Rename them reasonably so as not to litter the global namespace.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      - Add MAINTAINERS entry for the module
> 
>   MAINTAINERS      |  2 ++
>   bridge/vlan.c    | 50 +++++-------------------------------------------
>   include/bridge.h | 11 +++++++++++
>   lib/Makefile     |  3 ++-
>   lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 67 insertions(+), 46 deletions(-)
>   create mode 100644 include/bridge.h
>   create mode 100644 lib/bridge.c
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

