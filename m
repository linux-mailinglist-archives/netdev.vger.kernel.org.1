Return-Path: <netdev+bounces-53754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AB8047F4
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31D41C20EA6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C478C03;
	Tue,  5 Dec 2023 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1hxTj+o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B0C6;
	Mon,  4 Dec 2023 19:44:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so955637a12.0;
        Mon, 04 Dec 2023 19:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701747849; x=1702352649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Az/MEhginE8clAewmiyXlWp3qTLEVSutPuGO90KOHmc=;
        b=J1hxTj+oZOloF3oRs4/CPFfCkTplKFoV8sUALcaQVIBKmQ70vl0sBc+FVYJxryhoUF
         A4u6576WVQRcdonf5qzN5CUKNh5mOSHu974+PragR34RA6OipRuWc9n6M6A717uotXRn
         s2D+9SJG/AiSCXvdnkyCQEFEEg+KEVwfZ4MIwDcoFhCam3QsrkOxU1h//rDKfGp51UaZ
         c3KkEKpqZgqx3HwAxL2jD2t6GoOivrG8YAd/e8Q05QqwrfUbCVvEOZqcE4R1UuRZ8aRK
         jIQ8BWW2RzwSfa9Z/5RVxBYyfT7ss1cJtfBAQPtXxjxgpteYTOz2IzJ1XJtB7QNDEnau
         xGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701747849; x=1702352649;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Az/MEhginE8clAewmiyXlWp3qTLEVSutPuGO90KOHmc=;
        b=aosacCdy/0Fr4k43rvBmk97E+yFSpaAb0oMjBTtSR+HbPhQSW8xE0DtqDP+PYipBQc
         usabcNemFjk7l9dM+W7C3cRW7aUKH/Vv9quphiMt5YaLetGoZpBEyqqXjXIH+DsECZAP
         9dwntt2FnYUmjWmdyw4/fVrsRcmNj+WtAHt4TMlEJh8PSkyqj/Oy5uJmGiFuubt/lVoO
         ExHGpMrxE9lj2G13lEoPBG9MUvqY3qZy1ZzbbIIlOO3TJeA0C65q3vAahs0jb5JArDWl
         qL+dydQL8NcRK7JfLBa8XrRQgbmR1538dpz0UeRrFgsapATSGJMcdYMVOEHVy2zlcsuM
         5LTQ==
X-Gm-Message-State: AOJu0YybKPzdOIkbD5TmuLAhg9XlQT/z4BPbe1mRNX88bNc7yfRi1AVR
	7AK62CxUYAFKon0xoQjpe7s=
X-Google-Smtp-Source: AGHT+IEoKlYHBxE7H8imelFI07uP5rPQkVC5Pc36zxofSLrimJj+iY32SEKYRbCfhN/70Z8Wwv9DnA==
X-Received: by 2002:a17:902:8d8f:b0:1cf:b192:fab8 with SMTP id v15-20020a1709028d8f00b001cfb192fab8mr15982917plo.1.1701747848773;
        Mon, 04 Dec 2023 19:44:08 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902b20900b001cf5d0e7e05sm4246257plr.109.2023.12.04.19.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:44:08 -0800 (PST)
Date: Tue, 05 Dec 2023 12:44:07 +0900 (JST)
Message-Id: <20231205.124407.1028275511920165940.fujita.tomonori@gmail.com>
To: jarkko@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 2/4] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CXG0T2MKC8H4.2WAVL6YCX9XC7@kernel.org>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
	<20231205011420.1246000-3-fujita.tomonori@gmail.com>
	<CXG0T2MKC8H4.2WAVL6YCX9XC7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 03:48:32 +0200
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
>> This macro creates an array of kernel's `struct phy_driver` and
>> registers it. This also corresponds to the kernel's
>> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
>> loading into the module binary file.
>>
>> A PHY driver should use this macro.
>>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>  rust/kernel/net/phy.rs | 146 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 146 insertions(+)
>>
>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> index 5d220187eec9..d9cec139324a 100644
>> --- a/rust/kernel/net/phy.rs
>> +++ b/rust/kernel/net/phy.rs
>> @@ -752,3 +752,149 @@ const fn as_int(&self) -> u32 {
>>          }
>>      }
>>  }
>> +
>> +/// Declares a kernel module for PHYs drivers.
>> +///
>> +/// This creates a static array of kernel's `struct phy_driver` and registers it.
> 
> s/This creates a static array/Creates a static array/
> 
> Suggestion for better formulation:
> 
> "Creates a static array of `struct phy driver` instances, and registers them.""

I follow Rust comment style here. Maybe I should do:

s/This creates/This macro creates/

>> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
>> +/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
> 
> s/This/`kernel::module_phy_driver`/
> 
> Or at least I did not see it introduced earlier in the text.

s/This/This macro/ works for you?

Likely `kernel::` part would be changed in the future.

