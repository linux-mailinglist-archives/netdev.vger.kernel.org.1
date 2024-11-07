Return-Path: <netdev+bounces-142735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29F9C0266
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FCA282142
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CDC1EBFF4;
	Thu,  7 Nov 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsQmeBLw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEB126C01;
	Thu,  7 Nov 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975492; cv=none; b=lnPPAlVWHQ5mF3hNxT9T8p6Ppj1f82YuTLPgSQMTvn8CFpvcz9arXGcYimoV7hUzc23t3C/BG5p9gWmJK81QTe7BhkQY+ORZFBS0an+3CSQWjiPjaLKLAK6N4XUoq7OoenCyMddl0abbKvsm4ZUswWV8GdTF5PtKQ39Gc7M6LCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975492; c=relaxed/simple;
	bh=s01lhGxF6c+BY6hecobKUX5p0GXhI8o0kpCOdT8gEm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEQFqipLuvOz6bmvfvVKgMFHB7iH/nk+FtYX7b5xsEWU0rcj/bozoWFlZiKWcXlbNTVtdU+HrHia6L448jufGtPoZx/Cl1vpR+3BulrqXdYyc9gmSOMgJpx+35EDmeymY+bM/FV3c/mktptG3Zab5NuLgTM6vpRAycySiXz4mME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsQmeBLw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-720be27db74so631429b3a.1;
        Thu, 07 Nov 2024 02:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730975491; x=1731580291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkraiRUrks+s5pcHcVdDbNI0v0htZdI4Vc5A2KCgS+Q=;
        b=JsQmeBLwHEBVZ66qeR1s+AlGm4poFvCNduM00c+xKnwxiUd5drEMViG0//8Mo1jtAB
         XXM2ToIwa1XTJtJnDLr/XUV6LzGbS9bmBcZxhPGEVbYyFl8d5IitDCLGA4VHMZF4h5Ru
         Oyt2dRShhuJxhLzXKAEPNP6gzp5+sXieFbe8HbRHHWfYQOztHdx6AdJExq043dLLDpO/
         jelbxwDKXyh1ZX1U+fD4CF0ZM7/VnHZCu1OChUwE+8jwJzaV9NnRjeEp4Wj4/Qz6jgPF
         GuocvQiOqHFRFSoP+pb8GtbTloCa1CU6hvpxZiM8etdtlV0TqI9A6aO6gNnZRSbT/wyq
         kRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975491; x=1731580291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkraiRUrks+s5pcHcVdDbNI0v0htZdI4Vc5A2KCgS+Q=;
        b=UIzIMoLFz2lUC6g+k+C4GC2Ev4FuaKOhTuuvg+yUgJED1kYvU/dPfme57ydc67e7cL
         LB5gKWQKTIO0H7rxI4rBWJIYKCMQ3jb4Zm3ib+H9+9/DnDciDC4X8J8j2NoY3GGHb8bj
         vjT+pjvceI+jVpRRNy1KZJ686uJ0SlOlu6BC1JSm845k1zN5xI0eTi5WnRcoWzwA6U48
         8FUOdxAbLtV49xRkWf4wejcnxuNAgnabi5kof2maIIAFhPUEj61ZO/zhgxw6JTiRZuex
         EpTIm1b2SEOTy+4aXYZvXlMymgTD3bp/caz2v0+tJiybK+LFaDXPZ8ETMtMBuRK+bMs1
         KgOg==
X-Forwarded-Encrypted: i=1; AJvYcCU5QRRVRl5yVlxH+yeQ77VSZWOjSTozR7TSspYnH5N9eEZbWz6ok2o2SR6/iLu88x8DICz4F8c/@vger.kernel.org, AJvYcCV3zQXZE8Hr5fdXBnIehYjVoTFlZv2lsEvJmkaXG4bJHO4UoLpa5LeUN67DQOjmv3x3bS6CPP2CxEm9I/q9@vger.kernel.org, AJvYcCW8axgcyZap6UWKGt17fcjSotaiccm0xOp+BmhXmO6ee5KeNMwfZ3+jZ6w2nbUp/wCJJTPGOnqNi9S9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+RyQkuTK3fOLBmPlrDlNXNblFPeaBxa8RqUNZSuWNBfnas0OO
	+hhqDkeqJw62k6d7hqhmSJLybiBr/5FPCCk++SLzEM62rfL2R7xr
X-Google-Smtp-Source: AGHT+IGNwXAlJHaBXrnsGeXwGA4utGjnJr02l8IicuB7Vk/ooEjnqYAWwWmqFY6U2v0+nQynuABSkQ==
X-Received: by 2002:a05:6a00:3ccf:b0:71e:60d9:910d with SMTP id d2e1a72fcca58-7240c8b7bbemr916513b3a.6.1730975490635;
        Thu, 07 Nov 2024 02:31:30 -0800 (PST)
Received: from [192.168.0.104] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm1196578b3a.22.2024.11.07.02.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 02:31:30 -0800 (PST)
Message-ID: <21a00f02-7f2f-46da-a67f-be3e64019303@gmail.com>
Date: Thu, 7 Nov 2024 18:31:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <f3c6b67f-5c15-43e2-832e-28392fbe52ec@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <f3c6b67f-5c15-43e2-832e-28392fbe52ec@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andrew,

Thank you for your reply.

Andrew Lunn 於 11/7/2024 2:13 AM 寫道:
>> +  phy-mode:
>> +    enum:
>> +      - rmii
>> +      - rgmii-id
> The phy-mode deepened on the board design. All four rgmii values are
> valid.
I will add them.
>> +
>> +  tx_delay:
>> +    maxItems: 1
>> +    description:
>> +      Control transmit clock path delay in nanoseconds.
>> +
>> +  rx_delay:
>> +    maxItems: 1
>> +    description:
>> +      Control receive clock path delay in nanoseconds.
> If you absolutely really need these, keep them, but i suggest you drop
> them. They just cause confusion, when ideally we want the PHY to be
> adding RGMII delays, not the MAC.
>
> If you do need them, then they should be in pS.

I will fix it.

We have customers who use a fixed link instead of a PHY, so these 
properties may be necessary.

> 	Andrew

Thanks!

BR,

Joey


