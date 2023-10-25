Return-Path: <netdev+bounces-44120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFC7D666B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC77E2819A4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18E9208CA;
	Wed, 25 Oct 2023 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiSLMs+u"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF920B00;
	Wed, 25 Oct 2023 09:14:00 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805A185;
	Wed, 25 Oct 2023 02:13:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so1195863b3a.0;
        Wed, 25 Oct 2023 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698225238; x=1698830038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RyqDut8pN6zzcaoMCQkUEiW6cTOrJm1rttsonkL2zF0=;
        b=FiSLMs+u3XIX/2SmbOMo+OweNqUg+KvAgpNmL4Sv18wuJLGWKuPyYq6L2ImDw94Gid
         NVpAyMKnmIM05ut7qrt4TzGFlwa+Me1R9oYi5vKZllcVDElmdQRAzzGFPO5YJ0Ceteww
         rWxjTVoURSxtRcNn3adIc9N1q60vCbwmWxHt2q7m0ZkLM8yKpxiMrMrL3/vFY5/iOe76
         SyQK/yBmARZoOmd4VqaMDzhgvmBRHB4z4DIcp5ID40l1x5e/GwEWKN9q54UgSaTvCMSJ
         Qs9s13RCqPKWYrRHIzGkjsq0dTlXnCpUFDiEnBNabMVMKq0/S6I2nNB+Xcbc4iMkIOfQ
         fXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225238; x=1698830038;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RyqDut8pN6zzcaoMCQkUEiW6cTOrJm1rttsonkL2zF0=;
        b=OfUmQ3b7s3jKp2hsJODbsR3HHlBWqqGQI+FsF9ZznOcQtMSH5IRda1U7aRIlnst1tt
         XmBlgcZCxF78pHwSWoEtgmic4kurek2DN6bPNPrB4iTGdOrxEp96KINqAq1SrDVHNoP/
         Ufd8IdciXP+/9bYHwoRNtgG1kmeSSW7cMZtr9ed4m8nEyjN9aNUUUq9iXsoauSOjV6JR
         XXJmqKQTxqJnbIZcugjTQiTl3YWHEDqXdozND/O8w6Hst/bZE1H1JSytLV3GLpU5fr1U
         xyiAkoxWs/I1DZwxnsKUmB+0Zjlcj/WWCfU6PwqGUU77H7i6p2jIPsMzywjqNDZKKof4
         AhJw==
X-Gm-Message-State: AOJu0YyJtOsA03v3+kNTcZXx6SvML/8SDxBUZAFyt+MIlB2D03pwBZDt
	FYYC5O7hrK2YmNKtDVabiZ8=
X-Google-Smtp-Source: AGHT+IFpFH/gvZciQu9JqbOAT0OqurdTHWD7qgWXyUDsZvV0vlPconVc3dmKw+y7JrsvBB+bmBrZoQ==
X-Received: by 2002:a05:6a21:7881:b0:16e:26fd:7c02 with SMTP id bf1-20020a056a21788100b0016e26fd7c02mr19716577pzc.2.1698225237971;
        Wed, 25 Oct 2023 02:13:57 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm8675366plh.186.2023.10.25.02.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:13:57 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:13:57 +0900 (JST)
Message-Id: <20231025.181357.1412247050293754016.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <04c4c645-d70c-41b2-9ff6-e5784dc84785@proton.me>
References: <42eeb38d-6d24-4c56-8ffd-27c48405cae9@proton.me>
	<20231025.165710.1134967889825495180.fujita.tomonori@gmail.com>
	<04c4c645-d70c-41b2-9ff6-e5784dc84785@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 08:08:53 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>>>>>> +/// Declares a kernel module for PHYs drivers.
>>>>>> +///
>>>>>> +/// This creates a static array of kernel's `struct phy_driver` and registers it.
>>>>>> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
>>>>>> +/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
>>>>>> +///
>>>>>> +/// # Examples
>>>>>> +///
>>>>>> +/// ```ignore
>>>>>
>>>>> Is this example ignored, because it does not compile?
>>>>
>>>> The old version can't be compiled but the current version can so I'll
>>>> drop ignore.
>>>>
>>>>
>>>>> I think Wedson was wrapping his example with `module!` inside
>>>>> of a module, so maybe try that?
>>>>
>>>> I'm not sure what you mean.
>>>
>>> Wedson did this [1], note the `# mod module_fs_sample`:
>>>
>>> /// # Examples
>>> ///
>>> /// ```
>>> /// # mod module_fs_sample {
>>> /// use kernel::prelude::*;
>>> /// use kernel::{c_str, fs};
>>> ///
>>> /// kernel::module_fs! {
>>> ///     type: MyFs,
>>> ///     name: "myfs",
>>> ///     author: "Rust for Linux Contributors",
>>> ///     description: "My Rust fs",
>>> ///     license: "GPL",
>>> /// }
>>> ///
>>> /// struct MyFs;
>>> /// impl fs::FileSystem for MyFs {
>>> ///     const NAME: &'static CStr = c_str!("myfs");
>>> /// }
>>> /// # }
>>> /// ```
>>>
>>> [1]: https://github.com/wedsonaf/linux/commit/e909f439481cf6a3df00c7064b0d64cee8630fe9#diff-9b893393ed2a537222d79f6e2fceffb7e9d8967791c2016962be3171c446210fR104-R124
>> 
>> You are suggesting like the following?
>> 
>> /// # Examples
>> ///
>> /// ```
>> /// # mod module_phy_driver_sample {
>> ...
>> /// # }
>> /// ```
>> 
>> What benefits?
> 
> IIRC Wedson mentioned that without that it did not compile. So
> if it compiles for you without it, I would not add it.

Ah, it's necessary.

