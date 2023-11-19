Return-Path: <netdev+bounces-48998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9F7F0512
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0330280D83
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5D63CD;
	Sun, 19 Nov 2023 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip79DZsS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E4CE;
	Sun, 19 Nov 2023 01:57:37 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cb79883b7fso128344b3a.1;
        Sun, 19 Nov 2023 01:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700387857; x=1700992657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJndILSdi4fKqQQ4KKt0PDR2akf5bNv/eaSkGzXfzIU=;
        b=Ip79DZsSgaOt56faduJxF8DVIJqWv3oLxsRf8dICsfYr8PYyRPlb/5K21Rnqf41BDy
         prVKQ0sJgurtGn8aSbBEHlZcQLH1K+Kyy8I/oTvUuIJdMLyiTetb9FiwPUWxVKoP9asn
         bX14dV/F25n8nvAK/CLplfVV3k7WXlh5NSEA8ZYf1/19ZiiEvheq4C6y3iF9+BdAJl+q
         /xc5OLWujCDdYtIOqJR3zGb/J1ANYp+4XuQk0sHU167OgBUen2bdm9MTqrfkEqYTypbn
         5+hyeP1WcfPh8blmaz6+3MoA8r1rbdc7JGGf1WW1Fy0Fg4OUV6DlNVfjRzgxlIsyNPbf
         0Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700387857; x=1700992657;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJndILSdi4fKqQQ4KKt0PDR2akf5bNv/eaSkGzXfzIU=;
        b=GHuLu0TqUAPowxknc7JmJmeMbFQU5UKN/OmYfI2pZnR7BoEDEJCdI6Bzysj7H0IjRJ
         i8Bj5DCDBeSvR+Zsm2Z+IluLljLVkmDkOPigVIpBgR/9wSPGloSZwYZWTttC4xz4hmDF
         OG0d5JrPPCFu6y/ZV/KFY94zAfb61gfy7E/V5u7/nvVBBdcGBcp0SEGwvy0WhtXRScgc
         HrHLyWblEuDx5GDOJlNeS2r6ZsfuyeF0paya1kuBddN9ufPtBn1ka3XUGvxhjv/WG8rk
         xPX6/vrZCYBLewTHpK/FQ0oRQfZhLeWi0oZKI0ZeW63Eew4b8oryOnM2HgcBqREN/XyK
         BSFA==
X-Gm-Message-State: AOJu0Yz+dmkYN2f5jYB0AC3+LSIvZsqaYXcwZ1LqHXeiX0OnPd0Iom6U
	5zCt4N88At4u2e7drX6sN08=
X-Google-Smtp-Source: AGHT+IH0gSRGJdhVPrq5Ma9vy/E8Prj9w1Z59nhMlPvuUNTp8Ne6UNdjsWR+DnBaYZHx28wGafUoqw==
X-Received: by 2002:a05:6a00:10c8:b0:6cb:9482:583f with SMTP id d8-20020a056a0010c800b006cb9482583fmr163003pfu.0.1700387857172;
        Sun, 19 Nov 2023 01:57:37 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b00690ca67d429sm4032482pfj.100.2023.11.19.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:57:36 -0800 (PST)
Date: Sun, 19 Nov 2023 18:57:36 +0900 (JST)
Message-Id: <20231119.185736.1872000177070369059.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, benno.lossin@proton.me,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 5/5] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231117093915.2515418-1-aliceryhl@google.com>
References: <20231026001050.1720612-6-fujita.tomonori@gmail.com>
	<20231117093915.2515418-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 09:39:15 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
>> features are equivalent. You can choose C or Rust versionon kernel
>> configuration.
>> 
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> Reviewed-by: Trevor Gross <tmgross@umich.edu>
>> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> Overall looks reasonable. I found various nits below:
> 
> There's a typo in your commit message: versionon.

Oops, will fix.

> 
>> +use kernel::c_str;
>> +use kernel::net::phy::{self, DeviceId, Driver};
>> +use kernel::prelude::*;
>> +use kernel::uapi;
> 
> You used the other import style in other patches.

use kernel::{
    c_str,
    net::phy::{self, DeviceId, Driver},
    prelude::*,
    uapi,
};

?

>> +        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
>> +        // linkmode so use MII_BMCR as default values.
>> +        let ret = dev.read(uapi::MII_BMCR as u16)?;
>> +
>> +        if ret as u32 & uapi::BMCR_SPEED100 != 0 {
> 
> The `ret as u32` and `uapi::MII_BMCR as u16` casts make me think that
> these constants are defined as the wrong type?
> 
> It's probably difficult to get bindgen to change the type, but you could
> do this at the top of the function or file:

Yes, if we could specfy a type with bindgen, it's easier.

> 	const MII_BMCR: u16 = uapi::MII_BMCR as u16;
> 	const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;

I'll.


>> +            let _ = dev.init_hw();
>> +            let _ = dev.start_aneg();
> 
> Just to confirm: You want to call `start_aneg` even if `init_hw` returns
> failure? And you want to ignore both errors?

Yeah, I tried to implement the exact same behavior in the original C driver.


Thanks!

