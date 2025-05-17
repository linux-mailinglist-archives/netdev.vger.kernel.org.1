Return-Path: <netdev+bounces-191291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B94EABAA41
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B399E2DCC
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 13:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896842010EE;
	Sat, 17 May 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gljPi1sq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE267219EB;
	Sat, 17 May 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487604; cv=none; b=j7djchhZJrLwp8Erya5AOJyXU6KSumRsaB1kMh6Kxamjcc8Y3bujwWL6+5LHW0SQ7qJ67ck9jT5iZdO8RgHverDlLElI8A6ZUPaQfz/INyH9QrAzxXD1GuJ61H71PVDrf8CNWa/zcZShs2LTIHCYMmyJtjSU4ghDUFp31SAbYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487604; c=relaxed/simple;
	bh=DkyUX8xYGpeMcQDNAs8NEO7xgU8atxO82AkU2m/j7SA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fe4Tu4YstR8UED82xUUP2qPjfgFYt9VHFF/CbtDO0/zQ7H8MPG1R2AlH5L4/mfmbG4AvlbWaoh4VATEdSgO2A9nZFBXRE7OwcgxHg+6NYA2nQ7okU74pljZpaQNt935CEJDLj8IgGdu8/2SKBCxjtsvdEAdj2lqVH5DlWl848zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gljPi1sq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3982619b3a.2;
        Sat, 17 May 2025 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747487602; x=1748092402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06Le2eqgW5rnRXP+koCrOWKT5p6dh27NxlHabyyet/c=;
        b=gljPi1sqFtcvkQohNHYQQsDTn+5SXlbm97nmGf0OaG8uMekhgiMYmZ9iL76hoLUPSt
         +43J+H3kZOzJTGbFsZVnsTqHtYQ6VMeu4Pn1F2yBNFE8HqeP16aqM1C5T5BM18d0WhjS
         xDxxDqRRRNkl0GXw2vYjVfY4k4ZfT8QI56C4/83HTCyiNTvUfCXFlC47gj37Qym8B1er
         aIxRpSiDpqOkVd0kXH3SV3aBjwcneZUGbQe/DFaOERKi0zWYoGsnjC8vedMxkaLb6+gK
         qGyOXptHwHCJAh4HU5B/uomn3s926fldiQ59y163bqBxKjAoPLsIc63wFI0x3yhzkH7w
         lZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747487602; x=1748092402;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=06Le2eqgW5rnRXP+koCrOWKT5p6dh27NxlHabyyet/c=;
        b=gMO40xGiu4v5c9tIlCDVpXCIc3FP/9V9qvq7qHfF9A92QCuB/RRIlo3OUqijKAnAE/
         KrqQX4k7dnC7qfQ1A6iWcjgMBI3xemGZFQa0noZ8f8sqdhyteDANcqQY7uz3nLkNvtza
         x7IuQVRwEx8TVf+rl/pOWD7OPzdlk7bZ6mpF4GV1AbqnzNNhJ6DW5u5P/EQwjnX7DoS+
         RqKtr6rhBNhegIRZlMsL3xSBqLpirgX3abXuXcVOw2i2gNcGJEB5h4szfYDQgFvGmgj0
         1D5dRyFolw0x+e98mIzc7cT1e2JriSxwbtJW9W7RAC4UvhUvnKk8zujfElxweEm1w6tV
         GOCw==
X-Forwarded-Encrypted: i=1; AJvYcCU/bBMe7Gtw4HANoEipsk12BAfBtr2wt4ImZE1MRlrCNQNBNwUrOwk8wFWR0OuOJlIx2Q6+qva2@vger.kernel.org, AJvYcCV+797sLY8J6x30ZAWeRfbVVCv3+okWv2tQWNvnT2Gp16oETpYjv+R6nPIr1Ovrk2PPCs6tC0gpAgsjJ8ooMeI=@vger.kernel.org, AJvYcCX78ne6nIqPtTYW07MWxVNV+xzL/XDTLFtHL1xqvuhhFg2WH+cg9h7879iMzn/AUsdCsSGwdJjwM98CAy5H@vger.kernel.org, AJvYcCXjtwwO+Kh/x76mRExeQOwFhM8Us2lFpUeGw89Qxocjq3IYVbWukq4EBHTxqPKKX377EU7En4cDWMRw@vger.kernel.org
X-Gm-Message-State: AOJu0YwaT33WOOcKvB0+RaDHUcImHDgOmFQalKIxhnICMF8dp9TYODDB
	O4Ff06bKuFZ6v/HmFXfVp1SKbSYINxes+enf0Chewb5KQX31B9NomZ7Z
X-Gm-Gg: ASbGncth2SayU4ZLcsSD7kAQbLqN2A06aTs/KoMHGAoJqmiaaOZ+CBHfJIKb0La2IPp
	JtihRTFB9Tngjo858ZVvwGGOz6VIkYmxPnbfxP3lOTmC8RgYGhFGDJujuCb0cfn+MV12qzCpXp0
	l/QFcdpOWsw/KwHkl5JZgNPzEN/+iyB4Mstt//hSN59KLCA0xuRghO8qAExsjKRDWl8HrzBw+T6
	taLUFXBCBVF7Vh6cocXcHxDUFRt+kIHo6ZDMzo6/gDDai8FDvVncxqqgXfrpNkIN98MUzQw6rUi
	BDp3scYcBx+vPDrcyQDO5fbULS+zBVDXEoUQroejSp7cDxGlGCRJzy+gWAp75+smH2itKwrqLwc
	gmbh5aeQXWl50lBzF/5MoybHbdhsFYa4MOA==
X-Google-Smtp-Source: AGHT+IGB8Lu8PEAR1AfLv5MspLLjhJwE3STPC5XPoHEBJpNh8tTNa9vSO8B+hzP7Lbny12U5Rw/27g==
X-Received: by 2002:a05:6a20:3d1c:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-2170ce33ad3mr9574877637.38.1747487601980;
        Sat, 17 May 2025 06:13:21 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d4abd90sm3304627a91.28.2025.05.17.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:13:21 -0700 (PDT)
Date: Sat, 17 May 2025 22:13:13 +0900 (JST)
Message-Id: <20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>
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
In-Reply-To: <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
References: <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
	<20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>
	<D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 May 2025 10:06:13 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

>>> I looked at the `phy.rs` file again and now I'm pretty sure the above
>>> code is wrong. `Self` can be implemented on any type (even types like
>>> `Infallible` that do not have any valid bit patterns, since it's an
>>> empty enum). The abstraction for `bindings::phy_driver` is
>>> `DriverVTable` not an object of type `Self`, so you should cast to that
>>> pointer instead.
>>
>> Yeah.
>>
>> I don't want to delay this patchset due to Rust side changes so
>> casting a pointer to bindings::phy_driver to DriverVTable is ok but
>> the following signature doesn't look useful for Rust phy drivers:
>>
>> fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool
>>
>> struct DriverVTable is only used to create an array of
>> bindings::phy_driver for C side, and it doesn't provide any
>> information to the Rust driver.
> 
> Yeah, but we could add accessor functions that provide that information.

Yes. I thought that implementation was one of the options as well but
realized it makes sense because inside match_phy_device() callback, a
driver might call a helper function that takes a pointer to
bindings::phy_driver (please see below for details).


> Although that doesn't really make sense at the moment, see below.
>
>> In match_phy_device(), for example, a device driver accesses to
>> PHY_DEVICE_ID, which the Driver trait provides. I think we need to
>> create an instance of the device driver's own type that implements the
>> Driver trait and make it accessible.
> 
> I think that's wrong, nothing stops me from implementing `Driver` for an
> empty enum and that can't be instantiated. The reason that one wants to
> have this in C is because the same `match` function is used for
> different drivers (or maybe devices? I'm not too familiar with the
> terminology). In Rust, you must implement the match function for a
> single PHY_DEVICE_ID only, so maybe we don't need to change the
> signature at all?

I'm not sure I understand the last sentence. The Rust PHY abstraction
allows one module to support multiple drivers. So we can could the
similar trick that the second patch in this patchset does.

fn match_device_id(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
    // do comparison workking for three drivers
}

#[vtable]
impl Driver for PhyA {
    ...
    fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
        match_device_id(dev, drv)
    }
}

#[vtable]
impl Driver for PhyB {
    ...
    fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
        match_device_id(dev, drv)
    }
}

#[vtable]
impl Driver for PhyC {
    ...
    fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
        match_device_id(dev, drv)
    }
}


The other use case, as mentioned above, is when using the generic helper
function inside match_phy_device() callback. For example, the 4th
patch in this patchset adds genphy_match_phy_device():

int genphy_match_phy_device(struct phy_device *phydev,
                           const struct phy_driver *phydrv)

We could add a wrapper for this function as phy::Device's method like

impl Device {
    ...
    pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i32 

Then a driver could do something like 5th patch in the patchset:

#[vtable]
impl Driver for PhyD {
    ...
    fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -> bool {
       let val = dev.genphy_match_phy_device(drv);
       ...
    }
}

