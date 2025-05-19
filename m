Return-Path: <netdev+bounces-191541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA6ABBE2E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59725189F643
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E362750F8;
	Mon, 19 May 2025 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGjtTEsn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229331E9906;
	Mon, 19 May 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658709; cv=none; b=KUt5MPD10Luylmd2t6gYTU3yuthHuUKlxONuNXbM3gvgh8wFTf89N+d5vwswr2ym6rOwYGf2z+f2gRiXNQQXbj2PT1djeBEMttvIrDIaXLwA8dGM+mv0wx5LzUni8+J0ya648ajvWU8zU5nT7QhHLnpegfz2vsjjYQdod3pPko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658709; c=relaxed/simple;
	bh=c6WtNCs7bISL1PtUfbI/oyn2CNE29CrKejM6bQKUypE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LJ+q931k/LQ0QZXNaxCVOT3pp0P2A+rGZitALihELqwj8VsPwokIcy8lWcJzJlbK0AoHMdpGzxdskMpOixfEOA7Y2qY6rz10FybR9bL4MrMSo1tIXo4FPS2Yg0as56WCfLqLPuG1sLNi1aqT8UdHoKXBx5I4/rFIUIs0sm8u9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGjtTEsn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30e7bfef364so2841969a91.1;
        Mon, 19 May 2025 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747658707; x=1748263507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtVieZqLTwjTI2KqJvcsSJSVwM7dvAuU8x7ZZdSF9HY=;
        b=EGjtTEsn6mJnkTTxVrZDGKyRhjJxWjPg2Oel1HqsNLuc2+Tr7ejTSxiGbcweJfNzES
         1TNOCEoz7oZmwK612ESRW6piTm4SR5ZqhvumCSTUhJ5jg1MrR43KuusOaCdOTfHQGMEi
         LikCzvoTpSWAVV/l3c+Un+wgpaP4l/+KJje4yFmMd84D2+v98JesHLiH72FeBLxHpkMe
         ZQ8fPRoN9ZrFm9BDD0gQDPV34YRHslUgSx4JVR6DVEnAhjP5TypinV2JxK/N9HxXm/C0
         cqJmZVgeeeBeBesBtTENawy1VjTJLLZgqyPs3CK5iAqYohoab0UjEocIkLEz6WQPVF8W
         dXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747658707; x=1748263507;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HtVieZqLTwjTI2KqJvcsSJSVwM7dvAuU8x7ZZdSF9HY=;
        b=j0WmoqQNvPH2vLsVDsH2nB+yMMjNWKTFlLktqsHYZQhoMMnzIcbkc7xXNAUp2dTcpX
         C+DeMqIduIK+pIMa7TBHFjaOckvUVwlaZUYpDdEvVbcfyiR3iuh1odWAt994yKZalB5c
         ELdBqYAh0xHVczE/LwG1JqGSpcTGKkqRffPndiCIjmuxre4OSuUSygwmW06DhUXFlWOk
         yYjtiv7cr2HPGaCxeKkpXcjfLu4fLuQ2LSJi2cjICzdonhT47y585GLV6QtP0MkCs7Wb
         bC7Kurjc5CW02KatdPV659t1k6a8qwj/JzfECSSMF2vywxJaJ/mHoc7WuYvwGsIS9SSx
         uWPw==
X-Forwarded-Encrypted: i=1; AJvYcCUUtrULXCwHlu5d+j9ay2jKfIQzXpTLnZm7uKsoItrD6JzQvBKE1+XXjPlfMOaxqJkDqjfh8Z+wqlIKTpzq@vger.kernel.org, AJvYcCUVzAHpJ6eGu8sKcbIHwKPFpJ3QSod+smY8aIEfw3FiQEoZ3nh8gyhCKKqmG2sK0vxp5Jkrnzr6EG6/@vger.kernel.org, AJvYcCV5TiwrEIPCM7TsTErlVzZF3xnCg74kVoRkA15nnZYrdEoR4UI1VHDqmxW6R/X4tZbYC2Lmr2id@vger.kernel.org, AJvYcCVa6ugopN5RRScB6x+E5YJjiO4+QI5rCNOQaW+rvlKI205Pbtad4ZAElwR9FlYOMIako10ibpYjo2Pd9lwXt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClt1OCJf+EE+a4s/L1m6c09J3wdH9hHz8283pQLw/J20KqdaS
	72/LQVTlZf6tMqSi1FaqEpoFk0qb3dL7QRsxzNhDY1G0HsnkePkJFM0S
X-Gm-Gg: ASbGncumvE0C13hK6gJXlArS0/JxXx3tomG/tHpfWE6MYUHdKfkOKltH/sitBP3ICJC
	Av2Cl2nArNJ2rUXtoZnpQb1u6JBX9Xism9BCEMK3p5Ruh5Yq9S/zBkn0Jo7HlUkWtMmUpXF/dta
	gATPanqAdj4BuHZP9Gkhm0f8zCDM+q68knYAu6lbCi1z5cqj5fEc2acSHnG4sW7I/GWeJneAUH1
	SGtssWAdraYbtEe99L45pebhlcBM5Gkfo/47m+25oCyPKRMnGmRe/fFjMbk/gRW0ZqyagAqQV0K
	3KRsgTTpx0qrlUmYDmIVX0A+RqIOvxDH8Pi/3oJW6A8hxgkRWwfyngLEA2+Bfu+mdqdVCXqCyf9
	dhhhqV8ONYdDhCTbHx6repJ5rS6j+3T1d1Q==
X-Google-Smtp-Source: AGHT+IG34geKNE2GXFSaLHdvzfZLuz1suF6H3O6uV2prWgDL+Uv8RWD2tfRt1rTDdFmypZAM10jmvg==
X-Received: by 2002:a17:90b:48ce:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-30e7d53fedcmr23836584a91.17.1747658707153;
        Mon, 19 May 2025 05:45:07 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30eb1f09385sm4700624a91.47.2025.05.19.05.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:45:06 -0700 (PDT)
Date: Mon, 19 May 2025 21:44:49 +0900 (JST)
Message-Id: <20250519.214449.1761137544422192991.fujita.tomonori@gmail.com>
To: lossin@kernel.org
Cc: fujita.tomonori@gmail.com, ansuelsmth@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 kabel@kernel.org, andrei.botila@oss.nxp.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, dakr@kernel.org,
 sd@queasysnail.net, michael@fossekall.de, daniel@makrotopia.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DA051LGPX0NX.20CQCK4V3B6PF@kernel.org>
References: <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
	<20250519.210059.2097701450976383427.fujita.tomonori@gmail.com>
	<DA051LGPX0NX.20CQCK4V3B6PF@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 14:32:44 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

>>>> The other use case, as mentioned above, is when using the generic helper
>>>> function inside match_phy_device() callback. For example, the 4th
>>>> patch in this patchset adds genphy_match_phy_device():
>>>>
>>>> int genphy_match_phy_device(struct phy_device *phydev,
>>>>                            const struct phy_driver *phydrv)
>>>>
>>>> We could add a wrapper for this function as phy::Device's method like
>>>>
>>>> impl Device {
>>>>     ...
>>>>     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i32 
>>> 
>>> Not sure why this returns an `i32`, but we probably could have such a
>>
>> Maybe a bool would be more appropriate here because the C's comment
>> says:
>>
>> Return: 1 if the PHY device matches the driver, 0 otherwise.
>>
>>> function as well (though I wouldn't use the vtable for that).
>>
>> What would you use instead?
> 
> The concept that I sketched above:
> 
>     impl Device {
>         fn genphy_match_phy_device<T: Driver>(&self) -> bool {
>             self.phy_id() == T::PHY_DEVICE_ID.id
>         }
>     }

I think there might be a misunderstanding.

Rust's genphy_match_phy_device() is supposed to be a wrapper for C's
genphy_match_phy_device():

https://lore.kernel.org/rust-for-linux/20250517201353.5137-5-ansuelsmth@gmail.com/


