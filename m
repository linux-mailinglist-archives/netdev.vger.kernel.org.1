Return-Path: <netdev+bounces-42829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62E7D0437
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CA4280E17
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75853FB19;
	Thu, 19 Oct 2023 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7hdeVC2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CBE3E012;
	Thu, 19 Oct 2023 21:51:07 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA6119;
	Thu, 19 Oct 2023 14:51:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cac20789e8so246155ad.1;
        Thu, 19 Oct 2023 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697752264; x=1698357064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccTU4JHdhW2PD84y3IU7rRANDzK4xE53lg6HT1PfjiQ=;
        b=C7hdeVC2Pk1+YRt8ogcjxDWiwh5P3EfrbU6xJgtCbEk3TpjBEp2yrLI7BURSXrK7Dg
         2aVmccPK8/Kwrpad07F6PbecltIfEcpd5Shymi1b1L/kLTBj9EHB3RZC2TdocrrLqFb6
         9KRewjydDQ2E/hRrIDHG3viXLBS/b1pWPV3lGtevDBp1r3Ai2srrtrCE5YhImlR72nL0
         O8SzRPZgjrL0vomYH5goVQ0E4TlNLOtcZLbn+BDw77rvjRzVuckMAXEFflvwv0+enuNs
         3xwcZWStqCKvLs1xZg6nGO8BhQcX2l0PRQ5HJ2IK8/bMBtfcB+UJD1ngOmlXfOvX1HyZ
         F/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752264; x=1698357064;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ccTU4JHdhW2PD84y3IU7rRANDzK4xE53lg6HT1PfjiQ=;
        b=iOu2xuSIyv0q9WzO39GmQnArfWmrDW6JAYwwEhV6GEHUEe1vZp9hJ0FVJ8uYPjyv9U
         c1SyP0NhWW1dVSLTmQO7j+bpm3N29v3i78bOGDSGCf6KiHz8x8Rvyfq4P22MGKMS8JEP
         Nmi83kv4Ew0RjryV/6qC+JLG6wArQRUB9ymBZZsXXiRbBB2rP5talIAlcLULZKQL1ZgZ
         ZiP+wuKLvEYReoNFYaWCoaPPDNELFGr8UA1N5lmv27pdgEFGni+64bGjXQlFv5VW1hyH
         tOi6LuRaXRr4f9FWpNW45rxLCRhF2s4lem6IF27y95wJPlqB7ILYzlfJizdLdBf9s7kQ
         MObg==
X-Gm-Message-State: AOJu0Yxr5LdmuoimHADACt0REvB+FWMVGz9XI73T23hN+hbQEPVjrDKw
	AmkZH6Prcs+9EH7Q0k3S1hg=
X-Google-Smtp-Source: AGHT+IEwNXoOInGQUhG6sOXN3imDQpxP2hAXkp+3zHC81bt0t+MiB/sYJWoNYHQoboBTHrEoRS5eIQ==
X-Received: by 2002:a17:902:f98f:b0:1c4:1e65:1e5e with SMTP id ky15-20020a170902f98f00b001c41e651e5emr177033plb.0.1697752264329;
        Thu, 19 Oct 2023 14:51:04 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001c465bedaccsm183965ple.83.2023.10.19.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:51:03 -0700 (PDT)
Date: Fri, 20 Oct 2023 06:51:03 +0900 (JST)
Message-Id: <20231020.065103.1042445600809743171.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <398ec812-3dce-40b1-b4eb-bfff7e3feb6a@proton.me>
References: <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
	<20231020.003219.1788909848908453261.fujita.tomonori@gmail.com>
	<398ec812-3dce-40b1-b4eb-bfff7e3feb6a@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 16:37:46 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 19.10.23 17:32, FUJITA Tomonori wrote:
>>> You can just do this (I omitted the `::kernel::` prefix for
>>> readability, if you add this in the macro, please include it):
>>>
>>>       // CAST: `DriverVTable` is `repr(transparent)` and wrapping `bindings::phy_driver`.
>>>       let ptr = drv.as_mut_ptr().cast::<bindings::phy_driver>();
>>>       let len = drv.len().try_into()?;
>>>       // SAFETY: ...
>>>       to_result(unsafe { bindings::phy_drivers_register(ptr, len, module.0) })?;
>>>
>>>>                   })?;
>> 
>> The above solves DriverVTable.0 but still the macro can't access to
>> kernel::ThisModule.0. I got the following error:
> 
> I think we could just provide an `as_ptr` getter function
> for `ThisModule`. But need to check with the others.
> 

ThisModule.0 is *mut bindings::module. Drivers should not use
bindings?


>>>>> I suppose that it would be ok to call the register function multiple
>>>>> times, since it only is on module startup/shutdown and it is not
>>>>> performance critical.
>>>>
>>>> I think that we can use the current implantation using Reservation
>>>> struct until someone requests manual creation. I doubt that we will
>>>> need to support such.
>>>
>>> I would like to remove the mutable static variable and simplify
>>> the macro.
>> 
>> It's worse than having public unsafe function (phy_drivers_unregister)?
> 
> Why would that function have to be public?

If we don't make ThisModule.0 public, phy_drivers_unregister has to be
public.

