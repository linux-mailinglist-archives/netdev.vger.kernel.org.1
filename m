Return-Path: <netdev+bounces-131187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CCB98D214
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2073B283F8A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208551E1A34;
	Wed,  2 Oct 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivUHkv0u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE41C2DB7;
	Wed,  2 Oct 2024 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867836; cv=none; b=fRUSnMVIVe1mTEOdRZqBbBfkPTPsnvOGPw+7ZFb+cnWpg9q+T0qolLIKt90IpqSBeuq1aMQ9SIg47nGEaLhBQ88GruzreTjR/I5wod+T9kxUr0cN2DQWZ3c4mT9ca5ygKw2o3fA4YmOscu/w21MbXTMXspcDv1F3r5XJngaJeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867836; c=relaxed/simple;
	bh=KgxlJUxhg4wMQWHFWeWc9O2ESvbZTuyllzlf9ERqE1o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ahWtXUwe5a/WktFxDfrwMaLfmo83wXeOPI4FcG1IGGs7CCtwfOTUmIhGQzku2y62HNAexv4rHp8tp4KjTFBDXfE1vegxTeUu92hTtSwFG9+gpRs6mSRLzglip7ZypYSdFOx6GAcXYGBDT988BRsb9f1V6HDcXZztc89vvB12Txo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivUHkv0u; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e188185365so585792a91.1;
        Wed, 02 Oct 2024 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727867834; x=1728472634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXQE6Qxm699m+DgNqVTVB1zDnB0NWKSsHxBZR6yWGEc=;
        b=ivUHkv0u8KDbdLOFh/543ol1pRl+aDNZLDugpoLAO6r1OV76MA/rTM9PoJedW7/rua
         nxeBw9OaYZbhpj0K0STYnFkY+X4cXwOch7KuamZT71qDMB9EfnD7zNbW2ZNSk560OWtH
         0yTIVzoa9qaBmqbfv8YWgsfc9s827FyeHReJdPYJXOEYsdcGVqn0zdq4+rluT0RiA8J1
         LNF0BfGaJjAX2TiAYvjqNGttoM+TP1lfyQkAOJxJ5dMCqx2RAyjewhdfuiUiWgJ65H0O
         pn02KiinRYOT4To+K8j+FIlx6AdXd0a+/fdJo91xPhZsSdB7+TsGLSNv32ZpbrR5lM+d
         f3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727867834; x=1728472634;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXQE6Qxm699m+DgNqVTVB1zDnB0NWKSsHxBZR6yWGEc=;
        b=ndEXRPXDSuKc45IowY5+dc7YMqzw+hib4M7TPpA00t4F3MjP+p6zhtccLvLNibiA1L
         8072bAqCe+1/qurMYn2TtrtS8tX4XjsLbmQ7XSi1drwScZV0Xt+Qzngl5wlD/wBdHCcM
         Kc1Rm2/DXHSHMe0kCDWVYdpyQJ45aYNnIo7W8+cagfwREyaZePbYRBDEO1EKWAT8fmHq
         j0nuuQxAjGrcOOxn/l1t8+ASFAjTMehS1CCG+3eqZ8inqXkVo8YcLurAV8UWPA/uh6nn
         BSG99E3d5dfVchVv53tLzjzvhfqTvioe5q0XAFP2pViRI7ZN0vufh8CKawLrfHWoiflz
         9JAA==
X-Forwarded-Encrypted: i=1; AJvYcCX5OWyU19+mngE3tcggVSCrE/g3QVeUz2KdOghYQJAWtOk72OBVFHGeNXVc/7gpXRdne5zJ58U=@vger.kernel.org, AJvYcCXxJE0AmtnDtbWuPU2lUFIZEbW3TZZGQir3XAVHMSy1HI1acmFUpHnUK49KPlJt7u1syRZpSu8GlepEx1IOSYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTzJZ3K3YWZcwGK6EJV+4nMFUUp+OIHgEIJZM+9am5juDWbyP
	29z0A2vUwmqXVyQpidE1X6v55ntrsmxXoayFbHThxCDFydTvS6yE
X-Google-Smtp-Source: AGHT+IEJvL0kWT0oQpd0M/gd7xbw3pe6Llj++Grkef2gs2aaXPfzPVsLH5zu/xhVOC3+8LdMh166Sg==
X-Received: by 2002:a17:90b:3c6:b0:2db:2939:d9c0 with SMTP id 98e67ed59e1d1-2e184526f7cmr3730499a91.2.1727867833835;
        Wed, 02 Oct 2024 04:17:13 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f94ce20sm1291130a91.57.2024.10.02.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:17:13 -0700 (PDT)
Date: Wed, 02 Oct 2024 11:17:04 +0000 (UTC)
Message-Id: <20241002.111704.654457386762955005.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 2/2] net: phy: qt2025: wait until PHY
 becomes ready
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
	<20241001112512.4861-3-fujita.tomonori@gmail.com>
	<CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 13:36:41 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>> index 28d8981f410b..3a8ef9f73642 100644
>> --- a/drivers/net/phy/qt2025.rs
>> +++ b/drivers/net/phy/qt2025.rs
>> @@ -93,8 +93,15 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
>>          // The micro-controller will start running from SRAM.
>>          dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
>>
>> -        // TODO: sleep here until the hw becomes ready.
>> -        Ok(())
>> +        // sleep here until the hw becomes ready.
>> +        for _ in 0..60 {
>> +            kernel::delay::sleep(core::time::Duration::from_millis(50));
>> +            let val = dev.read(C45::new(Mmd::PCS, 0xd7fd))?;
>> +            if val != 0x00 && val != 0x10 {
>> +                return Ok(());
>> +            }
> 
> Why not place the sleep after this check? That way, we don't need to
> sleep if the check succeeds immediately.

Yeah, that's better. I copied the logic in the vendor driver without
thinking.

As Andrew pointed out, the code like this in C drivers isn't
recommended; iopoll.h should be used. So I'll try to implement such.


>> +        }
>> +        Err(code::ENODEV)
> 
> This sleeps for up to 3 seconds. Is that the right amount to sleep?

That's what the vendor driver does.

