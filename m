Return-Path: <netdev+bounces-119371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF9955572
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F51286749
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A210548F7;
	Sat, 17 Aug 2024 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anT80uSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AF43178;
	Sat, 17 Aug 2024 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723870217; cv=none; b=VyQlzN6pX9oy3CoeEncoY/6qXI6iy2FTbKRlhpNNOQMDLkZG7ocrnhKXqgtHn5qNkk7qcxOOygUw7nwJS6ytFXNYiCAh90Vao0Ik4P3dJy933fmN36Buxml8F6cUAAjxYq4C0Qkd66QLuUFfQJ+PWDCLLQJyRyfiTsSpiO9185A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723870217; c=relaxed/simple;
	bh=G5hlTm0XbJANDGPbaqllgxjbgbMj0PDpNIiybwLbYLo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jOned3oWDn8wecT0KX078IIeAFZXGr953vrm4CzP+Go6li3foHT4IhuqjPcl4yuPk7GxbyHIL4aDR6UEfaaUccPUR0TwCydWNmv5Qs3K9S0iLzQU9CcnaEcoSiRvhMl9wEympz0cldZadVNH//5lzfs4cYLJX+/shpZmEv7+sEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anT80uSl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3e6fd744fso224094a91.3;
        Fri, 16 Aug 2024 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723870215; x=1724475015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oN+FHL48ppH7HSghFhiItefq/YdgKnk/njXUEPMSGpg=;
        b=anT80uSl00aR+1MrFPlTxLhASI2x32bhFbv3VpjQAes2Fh26Ul/no7cQ4u0DLNHIK8
         bdRyVlQIVuJekRGKhyYdYYw/q4LnVi0OQTOgKP47xv6+Q13g/bL7BNJhcnz4sB46Cbs1
         RSFt/x7Le3jSZ/glOcM/ie5Y9+9qLzzBJnB3lar5K0/cJAb/FPn+cP/NZmXG/D8/rp/O
         7y/WJ2QH+5HBcJZDMf+ujqoOUtq5GRnfP3zOvrsBy8ErxAosQBOsJLewHPCeF/jNtwmM
         oRG7R5G+bqcRezyKZjpYTWNuAhUQtLkfwowI9zi2Y0y6GtUTDzYrAWBc8CxpWYzCzO/p
         Lkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723870215; x=1724475015;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oN+FHL48ppH7HSghFhiItefq/YdgKnk/njXUEPMSGpg=;
        b=p4ohc61sN+DhOSXqhkUnUki/BVqT4UA/WZmmju34JdGEoWQjlrjyuKryQ5C3ABp9Vl
         Lff4X4PgPY+Ud8GLDw6vv2mWXT6xlxl43d3Jw/yWjXbbbPAVf8d3X2mN3WkwkEbdZcEk
         W5LbaWpygjNnpi78mXt4SdsP/V+JW7G8crQTnXQWjNeE1OpYeNCU5A7WS4uunpwve5jY
         /A3HhWSKvUvh0iAhDQpGsiXc6axOlHyhjZEixYA5t9oA0s3JrQZf7vlISvmSUzrExuk/
         wwkBU55xfG5NFDmtwBFDMrQVWDH6SVVrY6+YFpUYaEgWh3TTyyYszNH2SQHEw4HTBsow
         S7QA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwkWMxlPD+FWDGqNefKFvv+w1h/Om7sAsyWae1fJqwSn+Gx96/Dxj1n2+HDdPb6LcBe0aGDXPGl5+WEZODEzP60OZ/CxG0bmxZQPTXR01aiF6KaURF4IPF9ubq6bGpXn6yD2XVtg=
X-Gm-Message-State: AOJu0YwdUybJCWevMfQ6lzJfaRrwN9SeZmigN4UJJUWb9VYyF5nZRPIQ
	Mnm6eom4zASYW3aK+iNQCLnsdMyKUYrODxRhRo1j+Dcw0mIhX9gP
X-Google-Smtp-Source: AGHT+IErTdJdG1OfO+fSrlTgFdFW2L+rUdS51SLJpeBhX6j2Q+kojz1j5DsVkMAnbjKCItsMsBuKQA==
X-Received: by 2002:a05:6a00:9446:b0:710:5d44:5fe6 with SMTP id d2e1a72fcca58-713c557a36amr3496919b3a.1.1723870214624;
        Fri, 16 Aug 2024 21:50:14 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb2esm3389619b3a.64.2024.08.16.21.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 21:50:14 -0700 (PDT)
Date: Sat, 17 Aug 2024 04:50:10 +0000 (UTC)
Message-Id: <20240817.045010.1342766151118215404.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ec02de97-2521-4897-9076-cabb8f057c8b@lunn.ch>
References: <0675cff9-5502-43e4-87ee-97d2e35d72da@lunn.ch>
	<20240816.061710.793938744815241582.fujita.tomonori@gmail.com>
	<ec02de97-2521-4897-9076-cabb8f057c8b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 22:47:04 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> >> +    fn probe(dev: &mut phy::Device) -> Result<()> {
>> >> +        // The hardware is configurable?
>> >> +        let hw_id = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>> >> +        if (hw_id >> 8) & 0xff != 0xb3 {
>> >> +            return Ok(());
>> >> +        }
>> > 
>> > I don't understand this bit of code. At a guess, if the upper bytes of
>> > that register is not 0xb3, the firmware has already been loaded into
>> > the device?
>> 
>> I've just added debug code and found that the upper bytes of the
>> register is 0xb3 even after loading the firmware.
>> 
>> I checked the original code again and found that if the bytes isn't
>> 0xb3, the driver initialization fails. I guess that the probe should
>> return an error here (ENODEV?). 
> 
> O.K. Maybe add a comment that the vendor driver does this, but we have
> no idea why.

Yes, added the comment.

>> >> +        dev.write(C45::new(Mmd::PCS, 0x0026), 0x0E00)?;
>> >> +        dev.write(C45::new(Mmd::PCS, 0x0027), 0x0893)?;
>> >> +        dev.write(C45::new(Mmd::PCS, 0x0028), 0xA528)?;
>> >> +        dev.write(C45::new(Mmd::PCS, 0x0029), 0x0003)?;
>> > 
>> > 802.3 says:
>> > 
>> > 3.38 through 3.4110/25GBASE-R PCS test pattern seed B ????
>> 
>> Yeah, strange. But I can't find any hints on them in the datasheet or
>> the original code.
> 
> Seems unlikely it is seeding anything. So i guess they have reused the
> registers for something else. This is actually a bit odd, because all
> the other registers are in the ranges reserved for vendor usage.
> 
> If these were legitimate register usage, i would of suggested adding
> #define to include/uapi/linux/mdio.h for them.

I see.

