Return-Path: <netdev+bounces-66491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A283F870
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B911F21929
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F928E03;
	Sun, 28 Jan 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9gf2NWS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22128E0B
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461757; cv=none; b=d+Ga+B2HjIfavZZlNbfLS1oBOVDHtnzGvB8autVfCRh4rblt5KfD6knub8ij5KpvJQjKdF09q/rZvtusHOgljIyPDz6EP8GlzG1ZdmbMYW4jSQGOaPB7AXUPi1HWaSEAPGr0rehMHW3WCHKiYTTRFNOMnoSW5G5xBeDkGQdIOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461757; c=relaxed/simple;
	bh=lGb8ma4UXhSYbVflgV5nPpiswG6w9IEgN4snEERZH54=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UufBh2zRWULaB1D6Np3VLvhLPMFyh2GSTYAHNNQvOnFqFaCDdgE36KqnsecyTK/e9DhWBmfvbuky8BIt7JrOF9w6PEBqXuwew9J9eaSZwLGjBq7gbTgrTTX2uToZsqcV4t9bhPdf+y+ZG8OCsVcTemuJ9oRG+T8LLfevZ9YlHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9gf2NWS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e490c2115so18512305e9.0
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 09:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706461754; x=1707066554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nyWRuEvI2c3RbHDpNaMAkwPr+g7/oDfkDJZ1JdPIJJc=;
        b=g9gf2NWS3J6zhWCqCx7CuGVuY4T71oH7JJyneZDXw5jouGjJiCxgjR5MGFuHmsQa5/
         irXAeWa2tHrtZrSA/gJmc6ITuLhWOJAK9JMjCfeYnsyPolIOCc73q7/IqpAhLGowT99u
         Eyu1Hw2JX09TPEv6cIi4jxzgSLUKmkDPzPB89VFDBeabeU0VI/8rXHQ6xLUbp5BVLRQZ
         BOXAQwB3rQGCB5Oh9kyfSiaaAULugvZYDNNGHYfniSC6HUcVNccguQxrS/3r0+ulEFjE
         6uDR6u93bBzAfebf4avMygnMzWHVN42aF4o1hg3/TVTHDvmR652irPkc4wTQk5ZDOo9/
         TeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706461754; x=1707066554;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyWRuEvI2c3RbHDpNaMAkwPr+g7/oDfkDJZ1JdPIJJc=;
        b=M3x5LkJrRN3ty6jb0WI8ig48a98eZRSKdLtgaRG+Aquz06NqSFvm/r9DbApL6dJot9
         iyLfg/cWw1maxEA9tOm26aRnsAta+25aXIBgSemntvcFRs6Fq9x+0upcWzj3tG3s/KCh
         8J9YZiGIL3aIeW0V8y4naIDr1ErDR7jWuOlWCOsSPmy0WLVzwwNWj0mTaVmcQ5LoUFeY
         jwQqwBC8jsrbamuLIuyyuAhnZqtpCUfUa/7hLZP1ontho1oMo3iycEJZitCR/6TM3+7l
         l5vaD0NW9M88v+EJ3WZu6NxwDoS0rrx1IDW35fEMOacWLBsVoMR9EM9O0jjinD+MICPe
         YbMg==
X-Gm-Message-State: AOJu0Yw8hGsorPAN+uHIuTIgGuETlGXX4cYoqcwv2QbD2yDrTwbklShc
	c4Bwbbb2vFMUdRZXB5Vo0OJXeYyT45XgQJD0aXvEdj4LimP6qPMT
X-Google-Smtp-Source: AGHT+IHhZ/sVHrNdTZgTS4ruadp/1hsU5YRnylscbiFl2ugf1XJ5S7vgIeGj/Z4z8b5WxIYDlkqRaA==
X-Received: by 2002:a5d:5f8f:0:b0:33a:e390:63c4 with SMTP id dr15-20020a5d5f8f000000b0033ae39063c4mr2813040wrb.17.1706461753856;
        Sun, 28 Jan 2024 09:09:13 -0800 (PST)
Received: from ?IPV6:2a01:c22:7abd:9b00:204a:9436:1489:6133? (dynamic-2a01-0c22-7abd-9b00-204a-9436-1489-6133.c22.pool.telefonica.de. [2a01:c22:7abd:9b00:204a:9436:1489:6133])
        by smtp.googlemail.com with ESMTPSA id u18-20020a5d4352000000b003392b1ebf5csm6007915wrr.59.2024.01.28.09.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 09:09:13 -0800 (PST)
Message-ID: <ac3c2981-2386-446b-9b8a-4d0bd7e3cd05@gmail.com>
Date: Sun, 28 Jan 2024 18:09:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: simplify EEE handling
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <227c1053-d960-4e90-b6f3-c42a2b4e16db@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <227c1053-d960-4e90-b6f3-c42a2b4e16db@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.01.2024 16:19, Heiner Kallweit wrote:
> We don't have to store the EEE modes to be advertised in the driver,
> phylib does this for us and stores it in phydev->advertising_eee.
> phylib also takes care of properly handling the EEE advertisement.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Ah, forget that this patch depends on the submitted, but not yet
applied, earlier EEE series. So I'll resubmit it later.


