Return-Path: <netdev+bounces-119700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE1956AA0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD141C22C27
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1916132E;
	Mon, 19 Aug 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaZYjhcH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FDB1684B9;
	Mon, 19 Aug 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069994; cv=none; b=ZECUAe3jG3iNXLLSa8PtHkwbBn2IkMP3giDOVQmLqkzhpDuKgTCaox69XcXiTscqKAF3MIGQbHRkq+PrVFOesILeDAZCf1RxVm9VaXtI3mj0wu2Z3pzVeL4NOIBj8QvOFtWToKArT4+nNcEWlk4k2m0oe1nFl5wjIRc4ciHZFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069994; c=relaxed/simple;
	bh=eH3O3O77Hb/pQW8L3PAeTHI7TOOOAo+/B6ywv5h4zBE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XNcyy2RNkKNbiV+1WKOWiydVa4ApSVwEG1ssfZfzCNMWK15ZQYL6MEg6gxdHCO9rPJ9HQZLmnhrhV+fCPiAuDrb+3PJ2fokfb5lkKT3++jp5yDSBUFqQ24w1vfFgZVbHlEOtCeDDez4F625CO5IIjHR6ioGHVxJwItHUOIH7vFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaZYjhcH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3c99c5d69so747988a91.1;
        Mon, 19 Aug 2024 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069992; x=1724674792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrMmVYHWCFw1M23JY8o1TB9DqxOES7VdOt7u2KAKLE4=;
        b=PaZYjhcHQvyLweuTY+KAJNienqZVlOKAlLv8oTzjO7ZPQcjnV1E8xUijAw+TLTFYay
         iyA9sk2dEzM32B4Zwc6+t50chBTOCai6tKeFOl1GzlRQNxcT1mdrHoZDA7hQC/NePkCp
         IQaFRjVOS3s65QSbJWOTBcWHNrJ7QNlj6E5HmJUHCPpOG3GKcNtB+3cPC1E0NN9VCUPt
         dw5L3/XCjGJU1Mz8bpweqAIE6LG8gxjLdskNuNikURIR0yfQ1nwal9+0Mv2bP8Fn7Sxc
         VWAPQOZY7DqDziu7xwevBbXWIlFtH5+6I27j3Ak5t17Aw2J9H/u7r0g7yxHNB3vLhA/S
         aZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069992; x=1724674792;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WrMmVYHWCFw1M23JY8o1TB9DqxOES7VdOt7u2KAKLE4=;
        b=qoRTcr3AcnNbTWTbRqzxoidHK0UxbY6RoH9d1JQMYhHqLNbcUPl5REgOX/94EpuBFY
         F+r4Jln7dJjAVMv9XjZxuclnejc0LB9y/4KaNom9o9HHrYERxXKzdrs1zd4k5SJk6dod
         EDtZjlIyOn1tLeeESqwwqoi3+uPOD+gbtvGxKdAAYEpTqNjYMyZ7eV/+rlvwdUCUMuSQ
         z0QakaAG+6wB0IkN4jYBwZwyVy5VZxgbSjoHZC9bC+V+vrlQbZscP+BkPEAaXBMASq02
         mHQ+AAVLnmtvEGmrHwoxWIE2VxawNlzsS3Fbz+Q8uoRjgobG96SoWQPh5T/49YSe2BpX
         MuAg==
X-Forwarded-Encrypted: i=1; AJvYcCXH8a5wxEshICUG2oly8YVLnZi6Y006HaZCk7h9EazmmMGKZDYAwzYJu7w04+XXCg9A7PhNe/efQzwn33jaCadSuex45uNiCFl4poM0KzeFz3wBIPKmCBX/3YMbooHggfJ0gZBHj88=
X-Gm-Message-State: AOJu0YyG/pqSIYrPXe2gP8q3ASzpQViYblyaxEKG5wOfRhHtq5prg+3T
	ddcXkSoHs0Lp+kfIEQwGHg3RtVyNw7TFOqVBQlYDaf0ZxZo6ehfEDfcZ8vKg
X-Google-Smtp-Source: AGHT+IFTl/MQNixdr+7z3049P0CCzH3avPOyiJNm7anZ/GgehDJ6RH1BMebBSrqBMBvMCiurHLkb6Q==
X-Received: by 2002:a17:90a:fb0d:b0:2cd:b59d:70c1 with SMTP id 98e67ed59e1d1-2d3e1a6e25emr6878868a91.2.1724069991715;
        Mon, 19 Aug 2024 05:19:51 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b677e1sm7137273a91.12.2024.08.19.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:19:51 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:19:36 +0000 (UTC)
Message-Id: <20240819.121936.1897793847560374944.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v5 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47siFZQDE8_N2FyLhCMfszrcX7f5Q=rj8c9dzO9Q=hQsmQ@mail.gmail.com>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
	<20240819005345.84255-7-fujita.tomonori@gmail.com>
	<CALNs47siFZQDE8_N2FyLhCMfszrcX7f5Q=rj8c9dzO9Q=hQsmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 04:07:30 -0500
Trevor Gross <tmgross@umich.edu> wrote:

>> +#[vtable]
>> +impl Driver for PhyQT2025 {
>> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
>> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
>> +
>> +    fn probe(dev: &mut phy::Device) -> Result<()> {
>> +        // The vendor driver does the following checking but we have no idea why.
> 
> In the module doc comment, could you add a note about where the vendor
> driver came from? I am not sure how to find it.

For example, it's available at Edimax site:

https://www.edimax.com/edimax/download/download/data/edimax/global/download/smb_network_adapters_pci_card/en-9320sfp_plus

I could add it to the module comment but not sure if the URL will be
available for for long-term use. How about uploading the code to github
and adding the link?

>> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>> +        if (hw_id >> 8) & 0xff != 0xb3 {
>> +            return Err(code::ENODEV);
>> +        }
>> +
>> +        // The 8051 will remain in the reset state.
> 
> What is the 8051 here?

Intel 8051. I'll update the comment.

>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
>> +        // Configure the 8051 clock frequency.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
>> +        // Non loopback mode.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
>> +        // Global control bit to select between LAN and WAN (WIS) mode.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
> 
> The above four writes should probably get a comment based on the
> discussion at [1].

// The following for writes use standardized registers (3.38 through
// 3.41 5/10/25GBASE-R PCS test pattern seed B) for something else.
// We don't know what.

Looks good?

>> +        // Configure transmit and recovered clock.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1)?;
>> +        // The 8051 will finish the reset state.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0002)?;
>> +        // The 8051 will start running from the boot ROM.
>> +        dev.write(C45::new(Mmd::PCS, 0xE854), 0x00C0)?;
>> +
>> +        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
> 
> I don't know if this works, but can you put `qt2025-2.0.3.3.fw` in a
> const to use both here and in the `module_phy_driver!` macro?

It doesn't work. Variables can't be used in the `module_phy_driver!`
macro.

> 1. Hint the MMD name in the comments
> 2. Give i and j descriptive names (I used `src_idx` and `dst_offset`)
> 3. Set `mmd` once at the same time you reset the address offset
> 4. Tracking the offset from 0 rather than from SZ_32K seems more readable
> 
> E.g.:
> 
>     // The 24kB of program memory space is accessible by MDIO.
>     // The first 16kB of memory is located in the address range
> 3.8000h - 3.BFFFh (PCS).
>     // The next 8kB of memory is located at 4.8000h - 4.9FFFh (PHYXS).
>     let mut dst_offset = 0;
>     let mut dst_mmd = Mmd::PCS;
>     for (src_idx, val) in fw.data().iter().enumerate() {
>         if src_idx == SZ_16K {
>             // Start writing to the next register with no offset
>             dst_offset = 0;
>             dst_mmd = Mmd::PHYXS;
>         }
> 
>         dev.write(C45::new(dst_mmd, 0x8000 + dst_offset), (*val).into())?;
> 
>         dst_offset += 1;
>     }

Surely, more readable. I'll update the code (I need to add
#[derive(Copy, Clone)] to reg::Mmd with this change).

> Alternatively you could split the iterator with
> `.by_ref().take(SZ_16K)`, but that may not be more readable.
> 
>> +        // The 8051 will start running from SRAM.
>> +        dev.write(C45::new(Mmd::PCS, 0xE854), 0x0040)?;
>> +
>> +        Ok(())
>> +    }
>> +
>> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
>> +        dev.genphy_read_status::<C45>()
>> +    }
>> +}
> 
> Overall this looks pretty reasonable to me, I just don't know what to
> reference for the initialization sequence.

You can find the initialization sequence of the vendor driver at:

https://github.com/acooks/tn40xx-driver/blob/vendor-drop/v0.3.6.15/QT2025_phy.c

Thanks a lot!

