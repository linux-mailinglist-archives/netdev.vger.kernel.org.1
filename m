Return-Path: <netdev+bounces-49254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3717F14FD
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948242824E0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A551BDC0;
	Mon, 20 Nov 2023 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBz8k5T3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC14EE;
	Mon, 20 Nov 2023 05:54:55 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc2b8deb23so9439305ad.1;
        Mon, 20 Nov 2023 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488495; x=1701093295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ahqi9jhkLeH3EV/3d2jU0ljmcsV+zQqtGCjIsAM9qMs=;
        b=CBz8k5T3RFTgs5BmoDJIPM32DP4FWB6u+UQZez87Q+GFMix44I9JAQYeo5dqArmhMX
         ciNz5PKGUQIt2MmQg/7QhyTUNPgIUvwcwD5EpHJBo1pUYZ7QH3GOyUKXhhOwKlVwZSP9
         QaX+V1NiKJb3uRge+ys0+Jyv7twzCu6XBIY3rXVi1Hdrot1fPC6YXd3/iynaMSweiMqw
         B6YrFP0gEswUKQfxHbZEccgKmsDzZMlxCA3N+b08nUnhB15jXK46+lRez+a8frNxtIeT
         wv9ckHi9jQ2EYJVXvLJwzbIzZYc4QVKY9GxPNz0Rj9w0rQ7NGq/MI+42w/tstPuCJjbz
         aPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488495; x=1701093295;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ahqi9jhkLeH3EV/3d2jU0ljmcsV+zQqtGCjIsAM9qMs=;
        b=t3qCxuShECByB3p56t7vmds8YSvp4HaO6a5S7LwbDp9eX8Jl9lGy7tBwZO9BNhCgXU
         133eFAX03Z9CAEmzLbq32qI5HBYSTq0ZFL9oRMFuhbRt1EACWaKyc9AqKpHfxGrWMOdc
         ljYLlKExRwEK/IzuskNgC/tfFzG9Or22T55hghZukmhImLCAQknTAlJfjU4gMeyYQXiZ
         X3YWtfbOsL7mZtYy2M9HOH//9RDme8EMfs4htw8ejOS4SeEdxq2tprf/6JlOze0iCi16
         XfUcN5R3YClfs/I3LgxOU6h6VkQsBxQFbn/Xrc96Kyme/exZZZNYLCoXiYZpcuUV/jyY
         WS8A==
X-Gm-Message-State: AOJu0YyQXhfP7WTr6DlOtmhIQP2rrwHLDpPPjQJ2XNYBZ54UYsvKJ4G+
	LkMM/ygQRtpu+fTtCTL3428=
X-Google-Smtp-Source: AGHT+IEf9sZ1Ik9U8t6+ThzErfuZ8p/UJ47B0Rt/LQOrl4zcYCDpZ0SCPe27pvfuPo7zd8WP60pLNA==
X-Received: by 2002:a17:903:41c6:b0:1ce:6273:ff6e with SMTP id u6-20020a17090341c600b001ce6273ff6emr9774253ple.2.1700488494852;
        Mon, 20 Nov 2023 05:54:54 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902eec600b001bb1f0605b2sm6107175plb.214.2023.11.20.05.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:54:54 -0800 (PST)
Date: Mon, 20 Nov 2023 22:54:53 +0900 (JST)
Message-Id: <20231120.225453.845045342929370231.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, benno.lossin@proton.me,
 boqun.feng@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <8f7a7fe0-bfd3-4062-9b55-c1e18de2818a@lunn.ch>
References: <7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
	<20231119.182544.2069714044528296795.fujita.tomonori@gmail.com>
	<8f7a7fe0-bfd3-4062-9b55-c1e18de2818a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 19 Nov 2023 16:50:34 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Nov 19, 2023 at 06:25:44PM +0900, FUJITA Tomonori wrote:
>> On Fri, 17 Nov 2023 23:01:58 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>> > On 11/17/23 23:54, Andrew Lunn wrote:
>> >> Each kernel module should be in its own symbol name space. The only
>> >> symbols which are visible outside of the module are those exported
>> >> using EXPORT_SYMBOL_GPL() or EXPORT_SYMBOL(). A PHY driver does not
>> >> export anything, in general.
>> >> 
>> >> Being built in also does not change this.
>> >> 
>> >> Neither drivers/net/phy/ax88796b_rust.o nor
>> >> rust/doctests_kernel_generated.o should have exported this symbol.
>> >> 
>> >> I've no idea how this actually works, i guess there are multiple
>> >> passes through the linker? Maybe once to resolve symbols across object
>> >> files within a module. Normal global symbols are then made local,
>> >> leaving only those exported with EXPORT_SYMBOL_GPL() or
>> >> EXPORT_SYMBOL()? A second pass through linker then links all the
>> >> exported symbols thorough the kernel?
>> > 
>> > I brought this issue up in [1], but I was a bit confused by your last
>> > reply there, as I have no idea how the `EXPORT_SYMBOL` macros work.
>> > 
>> > IIRC on the Rust side all public items are automatically GPL exported.
>> 
>> Hmm, they are public but doesn't look like exported by EXPORT_SYMBOL()
>> or EXPORT_SYMBOL_GPL().
> 
> Do they need to be public? Generally, a PHY driver does not export
> anything. So you can probably make them private. We just however need
> to ensure the compiler/linker does not think they are unused, so
> throws them away.

The Rust ax88796b driver doesn't export anything. The Rust and C
drivers handle the device_table in the same way when they are built as
a module.

$ grep __mod_mdio /proc/kallsyms
ffffffffa0358058 r __mod_mdio__phydev_device_table [ax88796b_rust]

$ grep __mod_mdio /proc/kallsyms
ffffffffa0288010 d __mod_mdio__asix_tbl_device_table	[ax88796b]

Note that when the Rust ax88796b driver is built-in,
__mod_mdio__phydev_device_table is not defined.

Sorry about my explanation, which leads to the confusion, I think.


> I would however like to get an understanding how EXPORT_SYMBOL* is
> supposed to work in rust. Can it really be hidden away? Or should
> methods be explicitly marked like C code? What is the Rust equivalent
> of the three levels of symbol scope we have in C?

If I understand correctly, there is no official way to export symbols
in Rust kernel modules; No equivalent to EXPORT_SYMBOL* for Rust code
built as a module yet.

Note that all core Rust functions are GPL exported so they are
available to Rust kernel modules.

`static` has a different meaning in Rust but I think that you can use
file scope and kernel-module scope in Rust.

