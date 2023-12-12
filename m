Return-Path: <netdev+bounces-56636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3066280FAE7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21AC281C18
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B305277D;
	Tue, 12 Dec 2023 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjgguGeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630C98;
	Tue, 12 Dec 2023 15:01:34 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d072f50a44so14098515ad.0;
        Tue, 12 Dec 2023 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702422093; x=1703026893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqA4Na7Dl2KuJVAZQzvlzyq1LGTzs46iWg9Uwg7KP60=;
        b=hjgguGeHAiOfDKNJUQ3mPKqwN8kjZdVVbmhHaPkqRbrWRft7BQiEdQPzR4EfYABczl
         +420miG8H7X1uw5KkmtDake0OBVjRAdFCW6ELr9fKlo1oTjN9fwLCP/YjImXwX1KwlUT
         rrYLLf1x6pY1kPT8lZYPQElHWS/ZTPwoLa8YIJPvPd8Dyih+PxbRGf3XyRaU4fMoKJqY
         tw0WwJocb3LeB9z+RK0anr5FIIeVt7uanqKHrlk4FhaerKorDV07njJHhUa8wuoikVfk
         ewgXvYw5L6t80lw4DjqeSzOsu1zeC1rfuWKq17zyhTxFufWBfIY2eKxnUpRuUkxFy2OG
         V4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702422093; x=1703026893;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqA4Na7Dl2KuJVAZQzvlzyq1LGTzs46iWg9Uwg7KP60=;
        b=DNwiC961GcEYKSCfIZf/OLr3IWedASijDbyXBRlIXPgUs06yVjmgOxW2fD8K60WZa9
         8oP3QARzgYiBL8P4cXQnM1TsD6C/l43mW0cC9rSxFEcyu4uFoOWbhc/2FkjhWttSUNVZ
         v+d8YnyKzqyZs+ujqr8NW9xGrowmhEdN+7c8j/Og6Y35kGrmuwtLTWXJ0ru4lBYejjYJ
         41IlvwSvSrIJn10qbEcNmjUrpc5XYKhb1KMjwt5UZo9Bzy7NTboh6zGy7PdrIZuyWT/v
         BmiKfsw52eotl1hTNFgqCo01eDnWC5HSNIylkm7CcGJ7NwLc51FT8T7OvAJf5VPyR4Mx
         oqtQ==
X-Gm-Message-State: AOJu0Yy4rzgNym3vo4HjXvjabePJzYWg+1yUTA+GmfEqaO8hhNI5Sdvy
	AMH7nnjcjA6h0rGddKCX/sWuOo5n6INjk9vv
X-Google-Smtp-Source: AGHT+IFsr0tdS38Ft6ci8Ofp30LU4ORdrGzRpHu5ObtTxUnA9CBFRqq51VticOhXORNh/FKpAYOC8g==
X-Received: by 2002:a17:902:ea0d:b0:1d0:b693:ae30 with SMTP id s13-20020a170902ea0d00b001d0b693ae30mr13605463plg.6.1702422093359;
        Tue, 12 Dec 2023 15:01:33 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001d1d27259cesm9125273plg.180.2023.12.12.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:01:32 -0800 (PST)
Date: Wed, 13 Dec 2023 08:01:32 +0900 (JST)
Message-Id: <20231213.080132.1176561831114639778.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, alice@ryhl.io,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>
References: <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
	<20231212.220216.1253919664184581703.fujita.tomonori@gmail.com>
	<544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 17:35:34 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 12/12/23 14:02, FUJITA Tomonori wrote:
>> On Mon, 11 Dec 2023 22:11:15 -0800
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>>>>> // SAFETY: `phydev` points to valid object per the type invariant of
>>>>> // `Self`, also the following just minics what `phy_read()` does in C
>>>>> // side, which should be safe as long as `phydev` is valid.
>>>>>
>>>>> ?
>>>>
>>>> Looks ok to me but after a quick look at in-tree Rust code, I can't
>>>> find a comment like X is valid for the first argument in this C
>>>> function. What I found are comments like X points to valid memory.
>>>
>>> Hmm.. maybe "is valid" could be a confusing term, so the point is: if
>>> `phydev` is pointing to a properly maintained struct phy_device, then an
>>> open code of phy_read() should be safe. Maybe "..., which should be safe
>>> as long as `phydev` points to a valid struct phy_device" ?
>> 
>> As Alice suggested, I updated the comment. The current comment is:
>> 
>> // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> // So it's just an FFI call.
>> let ret = unsafe {
>>     bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
>> };
> 
> I still think you need to justify why `mdio.bus` is a pointer that you
> can give to `midobus_read`. After looking at the C code, it seems like
> that the pointer needs to point to a valid `struct mii_bus`.
> This *could* just be an invariant of `struct phy_device` [1], but where
> do we document that?

If phy_device points to a valid object, phy_device.mdio is valid.

A mii_bus must exist before a phy device. A bus is scanned and then a
phy device is found (so phy_device object is crated).

https://elixir.bootlin.com/linux/v6.6.5/source/drivers/net/phy/phy_device.c#L634


