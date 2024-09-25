Return-Path: <netdev+bounces-129860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FA98684B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 23:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FEF1F21399
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67C154BF5;
	Wed, 25 Sep 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEH15f+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021BD147C79
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727299620; cv=none; b=K72LEkwzSHjzU6o8n6J2t8aj1SYcNsCV9vUSc6qEfZXlwI/JpcNiaySOAyQo2p5odDmUaFdSk8hu4Z5g2kdRqRxd6tWdhq5sKI9/WUsZV9AXSsOFUrj0Xt/qvampW7kMf2FG18pblX+O6Ye84jfcjbQUfGscB8CPF8Co+9waxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727299620; c=relaxed/simple;
	bh=vD15nBp0+CcM7E3xmVCpUdKHcD4NR10BrbHyd9Hnojs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E8d8cDJr6peRFxTOJIHWQcUcnrkxAy7evFIRBG02/F5rsU2poEcK3pXqdaGBXW/BDvH1EuvrVF0reXTX9ixof0gnBYGAKwEAWvMyZ+BEiRnowEVV53cpxENPUH55QQzrXY4I2nXBmmvA5Qq1rvYLYDRnVAkadQDfgvRwT/WlFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEH15f+W; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53653682246so417234e87.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727299617; x=1727904417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vD15nBp0+CcM7E3xmVCpUdKHcD4NR10BrbHyd9Hnojs=;
        b=NEH15f+WbFOXP8gkt2b6y9G2XKBEMI8T3r5KX4QUc3AFpR+WeecFZP6YPS4mg41DXo
         H019j5Ji2X5qDRSj1mieBD4xrqiuGyJDyZ6EsDNfA8tj1avLhn3RrtKnZr+EvGOEK30u
         DK8+Il03N4cIWwx+bAhS+t5SuhEULO+IxaFY71A/28oBWdB0Qco+WbM8del7O+ymapUQ
         NE1tbR9vSmpefvttid+4aOHrqCoqSoy9qxU4EiCPAHEtLABE2XXsw+utGuGy6pdwMlQ5
         U2idFAB+WttlElXop/KNDLJ6/xz7ejyKQVlzrwviLnrz4T4lC9lg5qx1xexOlxDSPTJT
         3jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727299617; x=1727904417;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vD15nBp0+CcM7E3xmVCpUdKHcD4NR10BrbHyd9Hnojs=;
        b=hHh2yoXSyaf3krVY/2ZjiQvaVfjnbSAMAGQjOdjLTNhhV6QA5HK4DbW8ZzxmKVZdHT
         Gs0FHrYnQI4OEefL/jt82xM+rBSWIOeEABhO5czM3+lOdsv4o0ddmsz9dp3KoaSAjYfY
         TnFkYXE0DBg3PhVN357ByrQBDu4eIsYPAS7hAZZkmBP8N0rNFDdXsGaru3Fol6raRtTA
         cxxf7h6M6dxOd48j7Ew1txXb4EbfiB1m+WsGhGS+ZeGmBzszjQEqL9rgtnq/vgitnR8y
         QDo/QSDpp+CP9CFRGw9LvYRlPIEFursD4xxammuK3DDSOj/c/jclnGIAoIoYQlb0GsMd
         3gpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmK6KtQ8EkRe4hBdnhi4fVTNrZkUJx+Sa2agRiP2oVp2DxlY7pRVEBM3yEL/i3Mw5brYfbCBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU2+lEVw9RJvLYoHD2Q9v+A6y7fgitW2njcypK319CroZzQ8w
	/LugwqWNQTzQ314hLrtWr+QYP2Jxid7Ftpc0ApxrKLdU3mYNGovR
X-Google-Smtp-Source: AGHT+IG5fIFAQxZTmIQCZsUr7ZUrDdAyu12GX8KHFbwx9i7nUDEK3Sraw1KRj6OmOyq7j6ebfSFZ3Q==
X-Received: by 2002:a05:6512:220d:b0:533:4722:ebb0 with SMTP id 2adb3069b0e04-53873455ef1mr2878247e87.6.1727299616717;
        Wed, 25 Sep 2024 14:26:56 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f0b23sm267607466b.144.2024.09.25.14.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 14:26:56 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <d1f402df-f4cc-4c31-b590-d13de9cea028@orange.com>
Date: Wed, 25 Sep 2024 23:26:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: Massive hash collisions on FIB
To: Eric Dumazet <edumazet@google.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
 <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
 <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com>
 <d1d6fd2c-c631-44a0-9962-c482540b3847@orange.com>
 <CANn89iL0Cy0sEiYZnFbHFAJpj1dUD-Z93wLyHJyr=f-xuLzZtQ@mail.gmail.com>
 <8e3fcb81-0b3f-4871-b613-0f1d2ed321a3@orange.com>
 <CANn89iL5XEZ0S6c-amu_Q_k8fXYqDKLVh1bPv8kPhc4eKR6UYw@mail.gmail.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CANn89iL5XEZ0S6c-amu_Q_k8fXYqDKLVh1bPv8kPhc4eKR6UYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/09/2024 22:12, Eric Dumazet wrote:
> On Wed, Sep 25, 2024 at 9:46=E2=80=AFPM Alexandre Ferrieux
>>
>>
>> [...] I was not wondering about the history behind net_hash_mix(), but=
 more
>> generally why there are two parallel implementations of FIB insertion.=

>=20
> ipv6 has been done after ipv4, and by different contributors.

Okay :}

> BTW, inet6_addr_hash() does not really need the net_hash_mix() because =
ipv6 uses
> a per-netns hashtable (net->ipv6.inet6_addr_lst[]), with pros and cons
> (vs IPv4 resizable hashtable)

Interesting. I somehow felt that the system-wide IPv4 resizable table was=
 a good
idea in terms of scaling, as it amortizes the necessary overheads in the =
case of
many-netns (though it is monotonic: grows but never shrinks !)... But now=
 I
wonder: why is it a good idea for v4 and not for v6 ?

