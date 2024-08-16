Return-Path: <netdev+bounces-119119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78095419D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5AF288151
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE884D13;
	Fri, 16 Aug 2024 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxo6Eu7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D783CA3;
	Fri, 16 Aug 2024 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789047; cv=none; b=hskL4dedXnAZLyMDy1iBA0PeAIxnpOlVb2Bz1l3rGOU1NhjHKoY4qJMns/OGRLjSnGH8z1RLag56IjXKGfHv/wI+OelAoz8lxORVFiHLKN5GcYOaCIN9QDAw0LM8heDZFc9jFfcYcpSwbJk0/LKpeBXzWeLFohjx1jT97xfHJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789047; c=relaxed/simple;
	bh=tyJK7y8uMKXCuKehWOc9nHHYvcb4OTJ0FXDG0NaBifY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=blL6BiLarA3Eiv03R97af29rl5sW0POkiKftM0e1x80e4u7IjEVTmd3vlMg0H49Q96cNSasTxraUIN2ExPAEVGaXXr6JHeJ5vIajQXBJMK4zUysJrZXBvS0myCMq/fVYPljVZDuF8cRLzhuvFPaVlI/4MczCzbXyPzcTKgSTonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxo6Eu7I; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3ba497224so183272a91.0;
        Thu, 15 Aug 2024 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723789045; x=1724393845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+YUZBcKxIHRaGYQAwe6ZYpUSlLlmYz3fbM7ym2SvwU=;
        b=dxo6Eu7In7wQMw9YkMFb0CKNLn2DER7aWwbRRSyh85C1YmUBYr1EV8pAiUAm4001lX
         Nig4ymkA9Gbc5MSyK9nEnorGZUtO6QosjXcysMW8DM+sE3FgrqPlspvzl9j4n4X9f/1+
         98CTPKbtkdVqSQ3QFda6Rnl4PWdDYrrU8hDhH6GQFTTTZiUO/meKZGvoWlHHTS4WTqBM
         96ikBGEWxJ1KxYwUoKfbqvUCsUGOA7DMmBEgTsUwU4UDIRSCfYdASSRFwCO4KPc2kXcy
         PJampsg+HdW4/H2yIhwT43OGuUNLVsyC4KpB3hkLT4U/0ODiQmMLTDT3BFhlQl+DOyl8
         Ncqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789045; x=1724393845;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+YUZBcKxIHRaGYQAwe6ZYpUSlLlmYz3fbM7ym2SvwU=;
        b=cLER5JeNci9T386sy8VE3Qkhnwm/MrRCRXVyGscplrTQdLR6El+R+y4dUP5iuEdiQE
         xqab0NS1LSjxkNfeJD9eqBCtGK3969x1YDz72MJmsuYS37S89GiAwu4LatKeiu76FrC0
         Q8zhA59j5SJIlhE5F8rjyoI/0P9ong3civ0GRRWnDE1ldHl9MWtkDJ9qx9VORQybC2gN
         EEjnb5b+VtmXgyJM72F9sJUhd9tamPRznzzfnMZwH4SvtrRNU6UzTi793r4U3iuqCU6v
         rTXMyCi6s5H+S9xgW4Lqer17TPY9BB9w/RbXuKDVVZqy98Dc9wWP/THv7YmXmoN6oHJm
         E+2A==
X-Forwarded-Encrypted: i=1; AJvYcCUmOXQEEoDTZAO1FLEyNmP7CAk+7eBWZZVLJdwt3H+i+9SaT93T/LKzEG/qDJQrrli2rnvISM4=@vger.kernel.org, AJvYcCW7Rf2p54xsJvJSz3AqfSrYAiTcjGkC8z++NlG37t0rdhOx1QOiTcEtslxCcHXXeAwwEZPximZJssS5JjTUTU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybNsShCW31u+ozgrf02uIohsKyrzkYmqpEE/CsQL66qUYWjeBa
	irMkqC4Vg0f/IRc9bPUjKV+ooKYkAtSbvOG3VQ6Th04bozDViJBg
X-Google-Smtp-Source: AGHT+IEGMkJ4zlz2pi4WxfQ0Ryj+/b+d0DV1ty2PLuW/ssY++mjXbMDDAZoC4v0G7scq/PHGbWb0iQ==
X-Received: by 2002:a17:902:f212:b0:201:eb55:f40c with SMTP id d9443c01a7336-20203e60ac0mr13334165ad.2.1723789045085;
        Thu, 15 Aug 2024 23:17:25 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03798f8sm19139945ad.121.2024.08.15.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:17:24 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:17:10 +0000 (UTC)
Message-Id: <20240816.061710.793938744815241582.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <0675cff9-5502-43e4-87ee-97d2e35d72da@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
	<20240804233835.223460-7-fujita.tomonori@gmail.com>
	<0675cff9-5502-43e4-87ee-97d2e35d72da@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 03:45:09 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +#[vtable]
>> +impl Driver for PhyQT2025 {
>> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
>> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
>> +
>> +    fn probe(dev: &mut phy::Device) -> Result<()> {
>> +        // The hardware is configurable?
>> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>> +        if (hw_id >> 8) & 0xff != 0xb3 {
>> +            return Ok(());
>> +        }
> 
> I don't understand this bit of code. At a guess, if the upper bytes of
> that register is not 0xb3, the firmware has already been loaded into
> the device?

I've just added debug code and found that the upper bytes of the
register is 0xb3 even after loading the firmware.

I checked the original code again and found that if the bytes isn't
0xb3, the driver initialization fails. I guess that the probe should
return an error here (ENODEV?). 

>> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
>> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
> 
> 802.3 says:
> 
> 3.38 through 3.4110/25GBASE-R PCS test pattern seed B ????

Yeah, strange. But I can't find any hints on them in the datasheet or
the original code.

>> +        let fw = Firmware::request(c_str!("qt2025-2.0.3.3.fw"), dev.as_ref())?;
>> +        if fw.data().len() > SZ_16K + SZ_8K {
>> +            return Err(code::EFBIG);
>> +        }
>> +
>> +        // The 24kB of program memory space is accessible by MDIO.
>> +        // The first 16kB of memory is located in the address range 3.8000h - 3.BFFFh.
>> +        // The next 8kB of memory is located at 4.8000h - 4.9FFFh.
>> +        let mut j = SZ_32K;
>> +        for (i, val) in fw.data().iter().enumerate() {
>> +            if i == SZ_16K {
>> +                j = SZ_32K;
>> +            }
>> +
>> +            let mmd = if i < SZ_16K { Mmd::PCS } else { Mmd::PHYXS };
>> +            dev.write(
>> +                C45::new(mmd, j as u16),
>> +                <u8 as Into<u16>>::into(*val).to_le(),
> 
> This is well past my level of Rust. I assume fw.data is a collection
> of bytes, and you enumerate it as bytes. A byte has no endiannes, so
> why do you need to convert it to little endian?

I messed up here. No need. I'll remove the conversion in the next version.

Thanks!

