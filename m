Return-Path: <netdev+bounces-48992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04017F04F8
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710B7B2093F
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2A4400;
	Sun, 19 Nov 2023 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0CV3fvz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70931AF;
	Sun, 19 Nov 2023 01:25:46 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb79883b7fso124024b3a.1;
        Sun, 19 Nov 2023 01:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700385946; x=1700990746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo1Z79+3qRKmg4q8xtjyQbLZNRbKvXEDTJteX8t8dJ8=;
        b=b0CV3fvz2mtHdGKI/bvNMvVnaaidXPpuHyEvtT2ZQB0Dlh/lUsORTo0R8YfTcgRa8v
         J7w2EUtKFLZQXchCt4F62IjnpYD5oInamOyy+jj54vpuXX82d9gnfHKKmVqNurIBcfIq
         xzeJbO0p3biDpkU5LNV3TMM6BT7+ZUUvVR2xlCuB75wQaSruEjUlVUPyS+28EKPG2Ojt
         pESzGkQSo+JJ8pDYgPl5SsxtlKp35oulHJGDwschG32VD1Ti0Fcf4EqKoMUWT7KJmHGu
         0o+sbjlpq6Oj74rCxbru8XFdu7kJ9y8ftXlPU2jz8URq+VWVo0AMP8s3Kas9UA7H19Tk
         DXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700385946; x=1700990746;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eo1Z79+3qRKmg4q8xtjyQbLZNRbKvXEDTJteX8t8dJ8=;
        b=JoV86rH5oiNcOScUdEbYUFg8kv7Xg8aM1ofLupLxijgjS4AApvt+fvQH8KxC5eN+MX
         Iap5Op1MspmrnV3UN+a03L0sn+hIA1ZDrnttKlNGeKl8XiWfNnSG5OZ2uVOZJpDDjV2Q
         3cg4D7VJ9Jq/fwMmcatl9U4HiaLQxy5WrdMXL0PvifTxflxTEzaIY2YWVNLTdvegBHh0
         R8N+tqzOuRNUl4ALEwZA2O97MCjdsPotrJEnqeuFI10EUPAqsbZOAJ3dHz0MNugZ22ak
         94oyYrFQHVVlAEQnu9zIumQV2UETyYAU6W+r7wzi+ltM6mWsyDV4bKooBSYn4PGYgg2F
         bs/Q==
X-Gm-Message-State: AOJu0YwLvf4FYVC5ozuj8nALCLGhSypT8JixQ+PZZZK+qQkz5gLih50p
	vrMUuIoSp//jvSOk2QgSKGvtIm/KIsRBgQ==
X-Google-Smtp-Source: AGHT+IE4LPLwh+X2HZT7jOgOvkzT4bSLFtSZH6FcNrYV1ZWfa91q5VF1Q3XHFjM7ebAXDIfpxQ7YGw==
X-Received: by 2002:a17:90a:ab87:b0:283:5405:9e90 with SMTP id n7-20020a17090aab8700b0028354059e90mr4258043pjq.3.1700385945719;
        Sun, 19 Nov 2023 01:25:45 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090adb4500b0028524bf8e52sm54290pjx.37.2023.11.19.01.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:25:45 -0800 (PST)
Date: Sun, 19 Nov 2023 18:25:44 +0900 (JST)
Message-Id: <20231119.182544.2069714044528296795.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: andrew@lunn.ch, boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
References: <ZVfncj5R9-8aU7vB@boqun-archlinux>
	<66455d50-9a3c-4b5c-ba2c-5188dae247a9@lunn.ch>
	<7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 23:01:58 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 11/17/23 23:54, Andrew Lunn wrote:
>> Each kernel module should be in its own symbol name space. The only
>> symbols which are visible outside of the module are those exported
>> using EXPORT_SYMBOL_GPL() or EXPORT_SYMBOL(). A PHY driver does not
>> export anything, in general.
>> 
>> Being built in also does not change this.
>> 
>> Neither drivers/net/phy/ax88796b_rust.o nor
>> rust/doctests_kernel_generated.o should have exported this symbol.
>> 
>> I've no idea how this actually works, i guess there are multiple
>> passes through the linker? Maybe once to resolve symbols across object
>> files within a module. Normal global symbols are then made local,
>> leaving only those exported with EXPORT_SYMBOL_GPL() or
>> EXPORT_SYMBOL()? A second pass through linker then links all the
>> exported symbols thorough the kernel?
> 
> I brought this issue up in [1], but I was a bit confused by your last
> reply there, as I have no idea how the `EXPORT_SYMBOL` macros work.
> 
> IIRC on the Rust side all public items are automatically GPL exported.

Hmm, they are public but doesn't look like exported by EXPORT_SYMBOL()
or EXPORT_SYMBOL_GPL().


> But `#[no_mangle]` is probably a special case, since in userspace it
> is usually used to do interop with C (and therefore the symbol is always
> exported with the name not mangled).
> 
> One fix would be to make the name unique by using the type name supplied
> in the macro.
> 
> [1]: https://lore.kernel.org/rust-for-linux/1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me/

I fixed this in a different way; declaring
__mod_mdio__phydev_device_table only when built as a module.

(@device_table [$($dev:expr),+]) => {
 +        #[cfg(MODULE)]
          #[no_mangle]
          static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id;
              $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = [

This is used for dynamic loading so when a phy driver is built-in, we
don't need this.

When a driver is built as a module, the user-space tool converts this
into moduole alias information. This __mod_mdio__phydev_device_table
isn't loaded into kernel so no conflict even when multiple phy drivers
are loaded.

