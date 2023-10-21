Return-Path: <netdev+bounces-43241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E07D1D3E
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180A02816D9
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E091C8F3;
	Sat, 21 Oct 2023 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce5Ydr3t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C73E20E6;
	Sat, 21 Oct 2023 13:31:18 +0000 (UTC)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEED68;
	Sat, 21 Oct 2023 06:31:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d797f349fso453280a91.1;
        Sat, 21 Oct 2023 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697895077; x=1698499877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IprCVf8i9noKPSQrYYwsBEYw17VE99dNgvYy7xKvTxM=;
        b=Ce5Ydr3t1J+S6P5WoSyXWYIlK8jgwptE7FoMU4V1Aehgr+KETN2brPfYtuW6xiX4cL
         oyHDt1epDTeoGvVgdV8P4s1IYWwAMq+p3MfMWfUXCWzGsx8DZ2aen9sllNj6hLlnwLVB
         FRLplnYYyO7eE8HRSo9EQco8AZpv78VE0IeZuKX0T7/pROJeI1tkgsjGHAKPsnTYqTFR
         PlkqYSefnk0yzrL51E6dlZ7a/09tsmcJsq/Tnt4nYwG+KMoXGmcW1FIM8oAIAovTDSZF
         V0qwoDtSer2x5603kgS0VBMx5296iX8ZtbIOkSzJWSUUxvZSkzxb0z0mEWyXxw3udTeg
         Gkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697895077; x=1698499877;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IprCVf8i9noKPSQrYYwsBEYw17VE99dNgvYy7xKvTxM=;
        b=KNbXwgfvmhovbO0ofFljxLit5f479eAGsEwVRn8ldHmEHTxRZM/FHFvlXDj1ezoN29
         oXAxi+DGQTsVdKVxogxcSJFFGOs0bj1Apyy7DMp2BLSZB0hGZjMUWLYHFrj9/Juk8MR8
         WHlWEcXqnYi29Znf/m07W598ka55IFLBktGktLvse3CwIEKSpw9JfDb3fES09csrHJ89
         ZEFzi+BBBj92L2mlPlhC0k3pX4vaNRVgl2cSU/SO21yDl8U1wDlrZRXFuuIhGUKL1keU
         D5C5DaoMs7EEE5PXhepKIIDnZ2Zu9VOkl1yxb6irZFq2AkGBCqXTg3e9EkuN0xaf74HO
         h2hw==
X-Gm-Message-State: AOJu0YyXUxLdCJnpgBEr70/Vaf4iryLlw24x6HUw99jsXPW9WLN5vuMV
	SzKdMS8t6+cVUeBjbbtOq4U=
X-Google-Smtp-Source: AGHT+IFZevUFwr+WANcXbDI2D2ODWCbzTtHWMZcF/3EWWIlSBXi3hBIlwFChPKOFNPHchmwGyfBVXA==
X-Received: by 2002:a17:90b:1d0e:b0:27d:1593:2b08 with SMTP id on14-20020a17090b1d0e00b0027d15932b08mr5498729pjb.0.1697895076544;
        Sat, 21 Oct 2023 06:31:16 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001c9d2360b2asm3197306plg.22.2023.10.21.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 06:31:16 -0700 (PDT)
Date: Sat, 21 Oct 2023 22:31:15 +0900 (JST)
Message-Id: <20231021.223115.1115424295905877996.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me>
References: <23348649-2ef2-4b2d-9745-86587a72ae5e@proton.me>
	<20231021.220012.2089903288409349337.fujita.tomonori@gmail.com>
	<fb45d4aa-2816-4457-93e9-aec72f8ec64e@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 13:05:59 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 21.10.23 15:00, FUJITA Tomonori wrote:
>> On Sat, 21 Oct 2023 12:50:10 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>> I think this is very weird, do you have any idea why this
>>>>>>> could happen?
>>>>>>
>>>>>> DriverVtable is created on kernel stack, I guess.
>>>>>
>>>>> But how does that invalidate the function pointers?
>>>>
>>>> Not only funciton pointers. You can't store something on stack for
>>>> later use.
>>>
>>> It is not stored on the stack, it is only created on the stack and
>>> moved to a global static later on. The `module!` macro creates a
>>> `static mut __MOD: Option<Module>` where the module data is stored in.
>> 
>> I know. The problem is that we call phy_drivers_register() with
>> DriverVTable on stack. Then it was moved.
> 
> I see, what exactly is the problem with that? In other words:
> why does PHYLIB need `phy_driver` to stay at the same address?

phy_driver_register stores addresses that you passed.

> This is an important requirement in Rust. Rust can ensure that
> types are not moved by means of pinning them. In this case, Wedson's
> patch below should fix the issue completely.
> 
> But we should also fix this in the abstractions, the `DriverVTable`
> type should only be constructible in a pinned state. For this purpose
> we have the `pin-init` API [2].

You can create DriverVTable freely. The restriction is what
phy_driver_register takes. Currently, it needs &'static DriverVTable
array so it works.

The C side uses static allocation too. If someone asks for, we could
loosen the restriction with a complicated implentation. But I doubt
that someone would ask for such.


> Are there any other things in PHY that must not change address?

I don't think so.

