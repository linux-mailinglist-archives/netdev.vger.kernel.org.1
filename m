Return-Path: <netdev+bounces-121359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1A95CE10
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6372FB20DF6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B118660D;
	Fri, 23 Aug 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKwtBtxz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25321586D3;
	Fri, 23 Aug 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420233; cv=none; b=luAIjtR7F5fxbejhohjpdd/PBXXdHvAlrzv0OVZ+oJsmxJK3Ru5+StjG3oHk5BPQ4jW0ZDPD3IfolkldMC/OwpucgBjSA+Fpry0D5b+IS0BCRAGKEBxTtL7PwdELWuJ6kfhAVQRo6TVCy/uNK4L3M9hvO5XaRao4hWuNkPD7Vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420233; c=relaxed/simple;
	bh=rzXXMRsErWVxfzN+j5PzQAtXSoeDahhRFhgcyTrD8HY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ojdDfCqb1vABimbMnqIkE6aQicYJ5BjKPg5m52V9pgJt0faloKfNTub+8ERa7briR9+AGXKUmlE5HuQQgro98ti/prhIqq/AFr8vsCRY72jQRSnwJH7ni5RT9t47AZay7l7sMyuTdT9Nv3wXKx6OKq/rsIxKkq7CabdMyEmfk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKwtBtxz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7141285db14so1807498b3a.1;
        Fri, 23 Aug 2024 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724420231; x=1725025031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNe4ZAbU5AS+FCm6doJQ9rVkaiu45RM9gTfhZkxaWBc=;
        b=mKwtBtxzlztYy/wNkmv2mKf28fGxDyI8j7oFCm2Su6L36c+l2BA8Tu81SlDjwCAYkj
         qAWCw60tfrptizCTHdl7NFzl5+FVnMs+x5zIrYygSQYeGiAkgJX+T88BlZxep7Eeo51t
         Xn633YbA6LhuCfUvoAmooBSyOfo0dI8pXP6FRlu3EvnE31FlAqX8E3nzLJKEBRe6MjI0
         fG/97ORvFMJ2p56R6Msx2qs1RwjblDahmjiaM+EOorQknxFpO3Jb6dNfWakS/AASCWXl
         vYS8vjoWzgk2rFF5/3u2ulGDgl4m3MniQ7UbmFMFKalTUxbtcfDt3C/SG4slvM2J8Y7P
         r0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420231; x=1725025031;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNe4ZAbU5AS+FCm6doJQ9rVkaiu45RM9gTfhZkxaWBc=;
        b=o2lGVme0PWFIMAi6/vH2my0Op7DJaLmqFr6rnErZ4Ooff6GTWJ09wNZnv+QTsx11X/
         jCqdXYZxdHxgVsdxgZRbpUrB65Sofn1oomw9s2K4pY5G9lspgiGFbXg3FgArNe1YwSGE
         vqtzQHq5s+KL8D4Aod+cU0sZtzWYiyWVu3OoVxotk+TeC5Mb7COHF1Wddl32yVLojvrS
         882dx3Jpof8Y0DnqLCBFj1f1schXw9pp16cSsokTswa2x6GJxnJ6+9LZEzSWdGMbO0H/
         d13fR2TQt40SrAtvI+zuuMrqdDaJ0FwJBrhbQnFa6u6Ar44BYmna816itVtx6Tmi+gIC
         o6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUGF8OYhHWi1xilWZqwyViL/vSHCS19gd+IDGNkmPq4ZcRj9+jtrgO9hTIo4YMlbp9WtWYXF13Mq75hLz0jxK8=@vger.kernel.org, AJvYcCUUjEY4oiG0XK4uYJE4/HzCUiklaNFQW4MRHzXlyMJul9qe508vzSK1PUE59mc2VDbBIalTp9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqx7lHQQg+98EAST/ukVWaqZUPMkGPieIxY5trmPkgS7nMD/HK
	NqTJ/N4N96rH8qywanLiu3WLY592iFmW8WiKNt7NBPwBPoRiD0g8
X-Google-Smtp-Source: AGHT+IGVb2Go8aR/xvpd2/e6b2oG3nInDgOtynbCZMxtHjMoX/2+/L3C8fFV3KS/lglxQoCBG0eszA==
X-Received: by 2002:a05:6a21:670d:b0:1c4:c449:41e6 with SMTP id adf61e73a8af0-1cc8b51f3ddmr2349411637.31.1724420230436;
        Fri, 23 Aug 2024 06:37:10 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a03sm3018065b3a.118.2024.08.23.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:37:10 -0700 (PDT)
Date: Fri, 23 Aug 2024 13:36:56 +0000 (UTC)
Message-Id: <20240823.133656.1425422314833390920.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v6 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47uvG_yjzX7Ewszb6M__jMZFtPu1rtw8DqvL5CceqCw4Zg@mail.gmail.com>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
	<20240820225719.91410-7-fujita.tomonori@gmail.com>
	<CALNs47uvG_yjzX7Ewszb6M__jMZFtPu1rtw8DqvL5CceqCw4Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 00:25:23 -0500
Trevor Gross <tmgross@umich.edu> wrote:

>> +//! Applied Micro Circuits Corporation QT2025 PHY driver
>> +//!
>> +//! This driver is based on the vendor driver `QT2025_phy.c`. This source
>> +//! and firmware can be downloaded on the EN-9320SFP+ support site.
>> +use kernel::c_str;
> 
> Nit: line between module docs and the first import.

Oops, will fix.

> Could you add another note to the doc comment that the phy contains an
> embedded Intel 8051 microcontroller? I was getting confused by the
> below comments mentioning the 8051 until I realized this.

Sure, will add.

>> +#[vtable]
>> +impl Driver for PhyQT2025 {
>> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
>> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
>> +
>> +    fn probe(dev: &mut phy::Device) -> Result<()> {
>> +        // The vendor driver does the following checking but we have no idea why.
>> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>> +        if (hw_id >> 8) & 0xff != 0xb3 {
>> +            return Err(code::ENODEV);
>> +        }
> 
> I actually found this described in the datasheet for the QT2022:
> 1.D000h is a two-byte "product code", "1.D001h" is a one byte revision
> code followed by one byte reserved. So 0xb3 is presumably something
> like the major silicon revision number.

Thanks! I've not checked the QT2022 datasheet. Looks like both
registers are compatible with QT2025.

> Based on how the vendor code is written, it seems like they are
> expecting different phy revs to need different firmware. It might be
> worth making a note that our firmware only works with 0xb3, whatever
> exactly that means.

I'll update the comment.

> The `& 0xff` shouldn't be needed since `dev.read` returns an unsigned number.

Yeah, looks like unnecessary. We need the upper 8 bits of u16
here. I'll drop it.

> I went through the datasheet and found some register names, listed
> them below. Maybe it is worth putting the names in the comments if
> they exist? Just to make things a bit more searchable if somebody
> pulls up a datasheet.

Sure, I'll add them. 

>> +        // The Intel 8051 will remain in the reset state.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0000)?;
> 
> This sets `MICRO_RESETN` to hold the embedded micro in reset while configuring.
> 
>> +        // Configure the 8051 clock frequency.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC302), 0x0004)?;
> 
> This one is `SREFCLK_FREQ`, embedded micro clock frequency. I couldn't
> figure out what the meaning of the value is.
> 
>> +        // Non loopback mode.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC319), 0x0038)?;
>> +        // Global control bit to select between LAN and WAN (WIS) mode.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC31A), 0x0098)?;
> 
> This LAN/WAN select is called  `CUS_LAN_WAN_CONFIG`
> 
>> +        // The following writes use standardized registers (3.38 through
>> +        // 3.41 5/10/25GBASE-R PCS test pattern seed B) for something else.
>> +        // We don't know what.
>> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
>> +        // Configure transmit and recovered clock.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC30A), 0x06E1)?;
>> +        // The 8051 will finish the reset state.
>> +        dev.write(C45::new(Mmd::PMAPMD, 0xC300), 0x0002)?;
> 
> `MICRO_RESETN` again, this time to start the embedded micro.
> 
>> +        // The 8051 will start running from the boot ROM.
>> +        dev.write(C45::new(Mmd::PCS, 0xE854), 0x00C0)?;
>> +
>> +        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
>> +        if fw.data().len() > SZ_16K + SZ_8K {
>> +            return Err(code::EFBIG);
>> +        }
>> +
>> +        // The 24kB of program memory space is accessible by MDIO.
>> +        // The first 16kB of memory is located in the address range 3.8000h - 3.BFFFh.
>> +        // The next 8kB of memory is located at 4.8000h - 4.9FFFh.
>> +        let mut dst_offset = 0;
>> +        let mut dst_mmd = Mmd::PCS;
>> +        for (src_idx, val) in fw.data().iter().enumerate() {
>> +            if src_idx == SZ_16K {
>> +                // Start writing to the next register with no offset
>> +                dst_offset = 0;
>> +                dst_mmd = Mmd::PHYXS;
>> +            }
>> +
>> +            dev.write(C45::new(dst_mmd, 0x8000 + dst_offset), (*val).into())?;
>> +
>> +            dst_offset += 1;
>> +        }
>> +        // The Intel 8051 will start running from SRAM.
>> +        dev.write(C45::new(Mmd::PCS, 0xE854), 0x0040)?;
> 
> 
> At this point the vendor driver looks like it does some verification:
> it attempts to read 3.d7fd until it returns something other than 0x10
> or 0, or times out. Could that be done here?

Yeah, we better to wait here until the hw becomes ready (since the
8051 has just started) and check if it works correctly. A new Rust
abstraction for msleep() is necessary.

Even without the logic, the driver starts to work eventually (if the
hw isn't broken) so I didn't include it in the patchset. I'll work on
the abstraction and update the driver after this is merged.

>> +
>> +        Ok(())
>> +    }
>> +
>> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
>> +        dev.genphy_read_status::<C45>()
>> +    }
>> +}
>> --
>> 2.34.1
>>
> 
> Consistency nit: this file uses a mix of upper and lowercase hex
> (mostly uppercase here) - we should probably be consistent. A quick
> regex search looks like lowercase hex is about twice as common in the
> kernel as uppercase so I think this may as well be updated.

Ah, I'll use lowercase for all the hex in the driver.

It will be a new coding rule for rust code in kernel? If so, can a
checker tool warn this?

> Overall this looks pretty good to me, checking against both the
> datasheet and the vendor driver we have. Mostly small suggestions
> here, I'm happy to add a RB with my verification question addressed
> and some rewording of the 0xd001 (phy revision) comment.

Thanks a lot! I'll send v7 soon.

