Return-Path: <netdev+bounces-43208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3588D7D1B84
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE21A282674
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E8D269;
	Sat, 21 Oct 2023 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+c75aET"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A31113;
	Sat, 21 Oct 2023 07:30:18 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FA1D63;
	Sat, 21 Oct 2023 00:30:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d1433c4ebso411684a91.0;
        Sat, 21 Oct 2023 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697873417; x=1698478217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWO6sOjSyZSEeBwlldkCbIRcfFSH2IkcdLXIikNG/88=;
        b=H+c75aETll+PZwl2q/tI8Z0FMl6MRhOWpM3CnQffT4lQVE3i5fJ/yUL1vs4FAOqSiF
         KN3+lwlTiqR7PumS/MmrkV0wNCihXiHZ9PtKs624Ifh14YSkoGE/m0WEJcXgs0pVShJ6
         6KNz+kIwrTQXV3Wl95+WtDvJBAkNQg/v3AQD2RaiQTAoNHGROHjM5W3xw7WjFmtNPpX5
         NY8MYSI8HKlyYN5qzoLtIRR5fFsroEHLfsdSFoJ8jU0LoU2rh+1dvzHIkEsua/4wQ3Hr
         3kguFSqI09pGZFQaapLZQFbzDO/Qbjp07Vqx/svalTByv7sHXnnFQpCKGLJYJHlUkcsa
         mW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697873417; x=1698478217;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWO6sOjSyZSEeBwlldkCbIRcfFSH2IkcdLXIikNG/88=;
        b=Fm2tkt/L4ZkjeyMi+qh8f1PUA3svuxK+7Nj0gm42t/Set//s3z2bHeGLyfWovHAq3J
         VIzGf5XChAVQkiP8TU/ARnhGglka+AcTCJrzbjOFYv2PdNAxllP7fAfOXR1j/WOgdmMk
         z1Y8PtzK4m+t4khHbecyJgl/dnYwaT+vPJwlGp6GeNAr/84ZTPCCsaLUErQ8dFohhy8t
         XY2ZQ7sxyDp2i1G07SLQPeoUZ4Iu+kSMSE+UvxghnrEmoZ9jI3oiZ5SGbSo+JysplE43
         Kk+3jVjGRam5ogI+ga4f+hVp9EzBSY05D6JL7tcURpLLsXCgDPDowU7ZNcvsWyW28eYW
         DbmA==
X-Gm-Message-State: AOJu0YxPylOb7y6yJXyIoFp1RULwqwEOxVQC9xkAYmkH84BmQqt2lzRS
	PKxRrRL0q/QI+TFFT9a68mRdpLJSUtNrht+G
X-Google-Smtp-Source: AGHT+IESBp4KKwe1rckIl08zQ/PtXc4KyZO5iN5fUQjIXXx2U8KzzlxVDxBhUfNdrRLRQfFjo58MQg==
X-Received: by 2002:a05:6a00:3a0a:b0:690:d0d4:6fb0 with SMTP id fj10-20020a056a003a0a00b00690d0d46fb0mr3933624pfb.3.1697873416539;
        Sat, 21 Oct 2023 00:30:16 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p17-20020aa79e91000000b00692aea7fb29sm2669500pfq.88.2023.10.21.00.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:30:16 -0700 (PDT)
Date: Sat, 21 Oct 2023 16:30:15 +0900 (JST)
Message-Id: <20231021.163015.27220410326177568.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <b218e543-d61c-4317-9b19-05ac6ce47d15@proton.me>
References: <20231020.093446.482864708938996774.fujita.tomonori@gmail.com>
	<20231020.215448.1421599168007259810.fujita.tomonori@gmail.com>
	<b218e543-d61c-4317-9b19-05ac6ce47d15@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 07:25:17 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 20.10.23 14:54, FUJITA Tomonori wrote:
>> On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>> 
>>> On Thu, 19 Oct 2023 15:20:51 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>
>>>> I would like to remove the mutable static variable and simplify
>>>> the macro.
>>>
>>> How about adding DriverVTable array to Registration?
>>>
>>> /// Registration structure for a PHY driver.
>>> ///
>>> /// # Invariants
>>> ///
>>> /// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
>>> pub struct Registration<const N: usize> {
>>>      drivers: [DriverVTable; N],
>>> }
>>>
>>> impl<const N: usize> Registration<{ N }> {
>>>      /// Registers a PHY driver.
>>>      pub fn register(
>>>          module: &'static crate::ThisModule,
>>>          drivers: [DriverVTable; N],
>>>      ) -> Result<Self> {
>>>          let mut reg = Registration { drivers };
>>>          let ptr = reg.drivers.as_mut_ptr().cast::<bindings::phy_driver>();
>>>          // SAFETY: The type invariants of [`DriverVTable`] ensure that all elements of the `drivers` slice
>>>          // are initialized properly. So an FFI call with a valid pointer.
>>>          to_result(unsafe {
>>>              bindings::phy_drivers_register(ptr, reg.drivers.len().try_into()?, module.0)
>>>          })?;
>>>          // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
>>>          Ok(reg)
>>>      }
>>> }
>> 
>> Scratch this.
>> 
>> This doesn't work. Also simply putting slice of DriverVTable into
>> Module strcut doesn't work.
> 
> Why does it not work? I tried it and it compiled fine for me.

You can compile but the kernel crashes. The addresses of the callback
functions are invalid.


>> We cannot move a slice of DriverVTable. Except for static allocation,
>> is there a simple way?
> 
> I do not know what you are referring to, you can certainly move an array
> of `DriverVTable`s.
> 
> -- 
> Cheers,
> Benno
> 
> 
> 

