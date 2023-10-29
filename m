Return-Path: <netdev+bounces-45035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09C97DAAA4
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 05:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2775C1C20947
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 04:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834215A4;
	Sun, 29 Oct 2023 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdy1zEq6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004E137A;
	Sun, 29 Oct 2023 04:21:15 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171B3CF;
	Sat, 28 Oct 2023 21:21:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cacbd54b05so5119445ad.0;
        Sat, 28 Oct 2023 21:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698553273; x=1699158073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVxbFwome+ksxz8e5B9+RqlDTcXB31sSq2RQuNFgOp4=;
        b=hdy1zEq6YDjeAZ963sancF3TODk24ZT0bYxB325TcKXMagVLYKteSi87jWkXBS+zav
         FTYNuwzwTEgcrjYYR7xey08hTzoTrXkIGcZ0SfH5ZHmeVFkLjyibGvqfB+hI0JzoP0on
         LE2rxFuFbGBwL3SeF6gN6q2JKEH4yOWMb75KgLG/kCwa74RRk8KlDpuw3w/iTY+EvYex
         xFu/Z5N3IPP0K7RQGN2WScKt0D6GHJyayma9YYdEX5OigRClaLuoUqUNrg3jcnQdsIsK
         ijTj3I77F3WdNTFwuZi2PhtkRorFTg0IcTQEvVHY6JKNe4y9ouvyRQJCCFOOxg+HQqmz
         8Ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698553273; x=1699158073;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zVxbFwome+ksxz8e5B9+RqlDTcXB31sSq2RQuNFgOp4=;
        b=qXm1SmRV2cVpJR+a02LZQIOgsKaWLSJN9aJ04LZix3dGOOdp4nW/cHNkKQS/8f3UFp
         K8Atv+E1XvkRfTR3axOqkCzOkjdB152tK83tIAaBoKIuoBlo1ZJJhpHE0K2RHaroHJw2
         +GbOQIIEi2hNwE1RfCJv8KN6ddFKMlZiEImOSgEVFf2e3TAkXuZqXT8kg2qWMpLLjom2
         6RK3Q3luXvqkhu+H+r6riavTe4Aq56a1GO44aw//gzepX7kr2RS+1wEobDuZ0S7pvlgi
         ygAMLVD9MkYUBHq8KKBFxtTxQx7zhaxo2kicWkDnQ7TYQMS5R8igcgMS4ZFdfMturOyL
         F0uQ==
X-Gm-Message-State: AOJu0YyInLikCXsIUq1rKTQA7CSUJTo6pR09P500gWEkUfc2YCbGtHg8
	mA7BkUC5xmvNfp8t5b/2C8I=
X-Google-Smtp-Source: AGHT+IHqMxOIoiutN/cITbDgO8V35soEtOHkNdQkY9gTgWqywSZ1hCbKyn9qLCFeYNWx2I3x/oouZg==
X-Received: by 2002:a05:6a20:5483:b0:17a:d292:25d1 with SMTP id i3-20020a056a20548300b0017ad29225d1mr9941675pzk.6.1698553273431;
        Sat, 28 Oct 2023 21:21:13 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id f16-20020a635550000000b005b96b42f7ccsm1224843pgm.82.2023.10.28.21.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 21:21:13 -0700 (PDT)
Date: Sun, 29 Oct 2023 13:21:12 +0900 (JST)
Message-Id: <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, boqun.feng@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
	<b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
	<0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 28 Oct 2023 18:45:40 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 28.10.23 20:23, Andrew Lunn wrote:
>> On Sat, Oct 28, 2023 at 04:37:53PM +0000, Benno Lossin wrote:
>>> On 28.10.23 11:27, FUJITA Tomonori wrote:
>>>> On Fri, 27 Oct 2023 21:19:38 +0000
>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>> I did not notice this before, but this means we cannot use the `link`
>>>>> function from bindgen, since that takes `&self`. We would need a
>>>>> function that takes `*const Self` instead.
>>>>
>>>> Implementing functions to access to a bitfield looks tricky so we need
>>>> to add such feature to bindgen or we add getters to the C side?
>>>
>>> Indeed, I just opened an issue [1] on the bindgen repo.
>>>
>>> [1]: https://github.com/rust-lang/rust-bindgen/issues/2674
>> 
>> Please could you help me understand the consequences here. Are you
>> saying the rust toolchain is fatally broken here, it cannot generate
>> valid code at the moment? As a result we need to wait for a new
>> version of bindgen?
> This only affects bitfields, since they require special accessor functions
> generated by bindgen, so I would not say that the toolchain is fatally broken.
> It also is theoretically possible to manually access the bitfields in a correct
> manner, but that is error prone (which is why we use the accessor functions
> provided by bindgen).
> 
> In this particular case we have three options:
> 1. wait until bindgen provides a raw accessor function that allows to use
>     only raw pointers.
> 2. create some C helper functions for the bitfield access that will be replaced
>     by the bindgen functions once bindgen has updated.
> 3. Since for the `phy_device` bindings, we only ever call functions while holding
>     the `phy_device.lock` lock (at least I think that this is correct) we might be
>     able to get away with creating a reference to the object and use the current
>     accessor functions anyway.
> 
> But for point 3 I will have to consult the others.

The current code is fine from Rust perspective because the current
code copies phy_driver on stack and makes a reference to the copy, if
I undertand correctly.

It's not nice to create an 500-bytes object on stack. It turned out
that it's not so simple to avoid it.

