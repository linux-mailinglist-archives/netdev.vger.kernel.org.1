Return-Path: <netdev+bounces-153592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1C9F8C30
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17B518966F5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 05:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F114A60F;
	Fri, 20 Dec 2024 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMWEB/RR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4805813D8A4;
	Fri, 20 Dec 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674238; cv=none; b=bT9Tv4KuK1HAkS7XAhwK5xNNMYfx+fcZcDrky/j/890sQvmWfwF4142QSbOF27ZAAgfgMAgpU0eqq7wHvqziwX0Bv8HalMsnqP8gYorIf3kJD71us6q90iqk/KC6zd7wQOHOMGk4IQl+vjP+n60oG7o2bsxkV4NPKMOpMXCiM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674238; c=relaxed/simple;
	bh=gXlarVOh+qY1emcuAzfM3FppugH2HkuDIb6YPvK2cz0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q6DNUkfpoX+yjxEPLyEceyRfXRQQZe1U2JVEVrd5A2EVv7ViVIidelE2E94Ac0tnn+EybkKLHt1J8vPI2esygGOBsaPcuGFv0+q1YpJAmEneDkHmGkjLLnTC1bnjNm0cZus4bQHssDGdgKQaOOobS5YQjJmR906Kmu1uXCz44Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMWEB/RR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166f1e589cso16927605ad.3;
        Thu, 19 Dec 2024 21:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734674236; x=1735279036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md2W1B6/s3M5UT0pVdsVPdpyzReDtMh6e+SMjGFU8lg=;
        b=YMWEB/RR6yEhVXcm/3AXCVsyMdFhTs1Y+tnFY1wfw6w8U6WrEq9UUO9gB4X1oExSO4
         1bjk7oLhmx4WKr9XopBBdHAl72W6/VLDI4msEawCK7L+3HEwoS99oL1KrCOPD2/AGu06
         xYG+wofdvQDHUQRLGNcpgmcUh1zFluT/6ghJPaIDxAAnOOZa+Fv63Dn774q9ZH8cA/aQ
         i0R6YyboGHidxHyeFso/aA3DqN48TEsjHbUNst13ZQznV9aNIHcHbR0dMWvsgbX8cAy7
         l2eHmZnBdc8PhISdB2555/T8zwgeCCS3DQ6gIQU+FAIU/2XzlRq7dz5h245/3TBMvAOR
         uXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734674236; x=1735279036;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Md2W1B6/s3M5UT0pVdsVPdpyzReDtMh6e+SMjGFU8lg=;
        b=ZeQ0DZsvkrCpHMu6OpXvoHRvIRass+xVcnAYneG880DuAhm6c5yVywlOhTpcBwl0VO
         gwe0BN2W+uAuwSotJ/hA9V25dlg5A7d6+BSZqvm928a/9JhxVSte+HZWZngeoXUP+AKR
         EjED+scWcDJ4FJDkjUwEbHJpP3XRDbnEDJoQDwVIun2YpV072DAxSnhFDDj/kCR+GC8s
         jd/ern/iwgmqGpqtwP0DFvaCKwN5Y0N2wQRZ+L8AcqfXc8R522BLqMd17ectjdc8h1H7
         u4vnSJ7ueh/wSUbm/fTwtZDSBguPfZErX1yJp8rVnqg2JG3fehpAW+63sTVaEaEhSbfE
         u9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ywl+7XAuN4obpZNXQbHEtrDsb0Udz6VXGc4pj5xZRgIWsCdwlqkD2YulUNwgRSyTYmnhdDWe@vger.kernel.org, AJvYcCWAhBG309hcmXyMxRELuJ1nEIsdiCFCg/nRSY96hhXsvodyQvrG0xtvRqoWlCifsVBOhRNLgFEE9SSTNms6j4c=@vger.kernel.org, AJvYcCWIWymkp+ClIKOmARLOFNzC9L2Vx2skWqcO0SfU/FwCJjonwmkEh9Pwn2+G4lQwfuYWzGn1CMl+nkXXql0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZqwMLc9nN4KRqZ6e8dgsuM53KMvEUbrxGtmWmqN3FhpUuL3J
	nOMQNeE2jH0Q8R7I1l74DIM917nM9JDIUVg5yo+Ha7xWrgjJK2yz
X-Gm-Gg: ASbGnctBdkCGZjk5e3j/DTVE4jsf5jGc/6PhysoAdlk4XA0Ac+w9NGdFwuVHIe3+SVR
	4LHR0X40X/eVf7RmCUdsD+Z4N8W959q7XL3Fb4vULekQGHFCdLfanCqNVvC0/2WIISC4qBKY2/u
	1Gw3naA+oDLI0wEXcbFuCbEEJimRnZvdgUfS7qCLjlBjvDvtzlJpCVbnsW0ImLLIHzJlTdstWhI
	s/8DEjxW0HCo/d593Nc9SRSludRrYJ4fNcxuzMItoO8HpWn5b9uSg//pueZKdDAGRMQl2Gl5pAZ
	FktoZ0JmzR8z+0+OqA==
X-Google-Smtp-Source: AGHT+IEsOZ9akS2NOszVFhPNYzcl4RRRRMcZb+KePdGiUe1koj7se6vCi3HXMqPvpCf8c41kHAZz8g==
X-Received: by 2002:a17:90b:50c3:b0:2ea:77d9:6345 with SMTP id 98e67ed59e1d1-2f452e4cfb2mr2296738a91.22.1734674236543;
        Thu, 19 Dec 2024 21:57:16 -0800 (PST)
Received: from localhost (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882af6sm2668160a91.36.2024.12.19.21.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 21:57:15 -0800 (PST)
Date: Fri, 20 Dec 2024 14:57:12 +0900 (JST)
Message-Id: <20241220.145712.1633600178791862342.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v6 7/7] net: phy: qt2025: Wait until PHY becomes ready
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2d70826b-6d6c-43f6-b6ba-542d25e6e0c0@lunn.ch>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
	<20241114070234.116329-8-fujita.tomonori@gmail.com>
	<2d70826b-6d6c-43f6-b6ba-542d25e6e0c0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 15:08:01 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Nov 14, 2024 at 04:02:34PM +0900, FUJITA Tomonori wrote:
>> Wait until a PHY becomes ready in the probe callback by
>> using read_poll_timeout function.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  drivers/net/phy/qt2025.rs | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
>> index 28d8981f410b..c042f2f82bb9 100644
>> --- a/drivers/net/phy/qt2025.rs
>> +++ b/drivers/net/phy/qt2025.rs
>> @@ -12,6 +12,7 @@
>>  use kernel::c_str;
>>  use kernel::error::code;
>>  use kernel::firmware::Firmware;
>> +use kernel::io::poll::read_poll_timeout;
>>  use kernel::net::phy::{
>>      self,
>>      reg::{Mmd, C45},
>> @@ -19,6 +20,7 @@
>>  };
>>  use kernel::prelude::*;
>>  use kernel::sizes::{SZ_16K, SZ_8K};
>> +use kernel::time::Delta;
>>  
>>  kernel::module_phy_driver! {
>>      drivers: [PhyQT2025],
>> @@ -93,7 +95,13 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
>>          // The micro-controller will start running from SRAM.
>>          dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
>>  
>> -        // TODO: sleep here until the hw becomes ready.
>> +        read_poll_timeout(
>> +            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
>> +            |val| val != 0x00 && val != 0x10,
> 
> Do we have any idea what these magic numbers mean? Can we replace the
> numbers with names?

I can't find any hints.

> Apart from that, this patch looks O.K.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks!

