Return-Path: <netdev+bounces-119511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCF956026
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EAD1F2112F
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 23:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C188C450E2;
	Sun, 18 Aug 2024 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InZi1ytl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637221A270;
	Sun, 18 Aug 2024 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024312; cv=none; b=npmYTLY5gzY4iELlSR0I40Zgf8C8xzGQQxPo/2kS10RWvlSz8W1VpSuh+5nO3rm4XF3wDg+RtxU8E5PJVbwZ7G3YDDkCB7grzr89VP2aXxEF9rNKvBXN8/p0iVkn8jF29lqI5M645YPe6yU0jgk/jNTypyf/6dEkOUO+00Eeyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024312; c=relaxed/simple;
	bh=Aw2YXgPqlzQ1wcGLDZ4rKOCOh2zClAVbuUVQMaPcye0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nW4CDSYNPD0mWN5lZFlD8Nb0FWgZAd6E58MLSEEcSsdpsnGx1SDaxNKjkTWeDJxkHOX/JKLRSUbXxTZrGaGbWr7jO1q7YFLgfygdSE6vGF5svLE235WAIKh+f4ZtlcIabxkP4oHqdvAYrbrXeeh3fIqiTe0XZ2VxjiVrMjSm4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InZi1ytl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3d4862712so600057a91.2;
        Sun, 18 Aug 2024 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724024311; x=1724629111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6VgqVvxk7VK7HY1HsAaE5udkholJjW1tlWASTNlMKw=;
        b=InZi1ytly79NhDxGFKqaQ2/iKBnZxyaAY0opD0m4qjln630jo3qSZIu26KudPv9jIQ
         eHCjF50WbQXy3BpaBtVyCQ2O0xzg7SjBFarlsziilI8Gn5hgQ5r1ZsCim3HM+DVHqEoc
         IpR0ye8yvMDVLkwrFIj2jRttXMBqBdBiZ3o1acTzqEMeeYvK7OS8clgcHppSWtStyTgI
         BpQzKxUcNj99oGKVDkgZzRExTgVzadqEjx4sippUvdbjcNDND8Jsp5HUGEhGOxgu+HlD
         GbRMkv5NBupfNKGlnRd7GPKCS+yc1hYJOSIBzYjgnbYHlS4sQ5MLgxTr8Hh5FGGeIFfZ
         rvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724024311; x=1724629111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U6VgqVvxk7VK7HY1HsAaE5udkholJjW1tlWASTNlMKw=;
        b=KMaLMH99zUC7HJanerM30YgDB6eInadr54+N8p1nNmqpuK5sR9ISXgzqw6TxSyb3z1
         H/48R3+M2aa9WYCSdHaDxkBMvUg0ZKlpgezI7PDSuuArA01FTlg5cGrd3J3EH4rSXXvD
         bhy9vUkvpXC604bWVUxi5vlL6SSmJT6Y5VyYfwI2WxFirhpjxw7GocBicyuqk1T3RzwU
         T4lwSkjNwVq/2iQGX3ToTPjfNY/xu45RPj3OknB5T4aiXP84zBUZvKDVGtFbBix+cPBc
         oA05pAhzVlINVu38sso82Acz1kTNt1utbC77k4ssJPJQUIo8XBjb27ilZVZqAEwYvGCO
         /qHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfcpgOWzz337sXtA3UWvKBJLJt4ju1RMRJUN02fdEkj0B7XC3FlQ93z3nUAfC0Y0xLy4BjdQZqdoe/sJfEIbBRtfQwxW7k6veQ2Xzim5fp9zfmfhEAH8jobHyH04ulJU6MGprlJ4w=
X-Gm-Message-State: AOJu0Yx6VIPr99fMOCJ7JP1QDqOBnY2WaOdvlyxcwEtDY0kSuwxIP8mB
	Xcuq7kBp//XDciOOcWssxfPVfqtK/WjaPcMSgpCQfPzZXzXVtnRv
X-Google-Smtp-Source: AGHT+IFiDE+RADuhXRQG2NIt2m1Mk+U2Coi2L/ne4sMXzKIyjbNab46mpJ4buHJe0g5SjNaMwRLyRQ==
X-Received: by 2002:a05:6a20:a10f:b0:1c4:ccef:cd6e with SMTP id adf61e73a8af0-1c9a2a86ab0mr8695662637.8.1724024310331;
        Sun, 18 Aug 2024 16:38:30 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aefa113sm5821906b3a.99.2024.08.18.16.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 16:38:30 -0700 (PDT)
Date: Sun, 18 Aug 2024 23:38:25 +0000 (UTC)
Message-Id: <20240818.233825.850938536134184993.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aa02b004-7281-45d0-87b1-668545bb3493@proton.me>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
	<20240817051939.77735-7-fujita.tomonori@gmail.com>
	<aa02b004-7281-45d0-87b1-668545bb3493@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 16:10:25 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 17.08.24 07:19, FUJITA Tomonori wrote:
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 7fddc8306d82..e0ff386d90cd 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -109,6 +109,12 @@ config ADIN1100_PHY
>>  	  Currently supports the:
>>  	  - ADIN1100 - Robust,Industrial, Low Power 10BASE-T1L Ethernet PHY
>> 
>> +config AMCC_QT2025_PHY
>> +	tristate "AMCC QT2025 PHY"
>> +	depends on RUST_PHYLIB_ABSTRACTIONS
> 
> This is missing a depends on RUST_FW_LOADER_ABSTRACTIONS.

Oops, added. Thanks!

