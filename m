Return-Path: <netdev+bounces-56643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A4380FB60
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DF0281FDC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B864CE2;
	Tue, 12 Dec 2023 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR5WV4Av"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB040BE;
	Tue, 12 Dec 2023 15:27:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d349aa5cdcso1021545ad.1;
        Tue, 12 Dec 2023 15:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702423670; x=1703028470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeyEONZJzSgNbd5fQANo0NB45nTPYSW9ivWPQRNwots=;
        b=hR5WV4Av1fL54KXcQfnJ5a219fIa97uxNwBG0jDIQf7SMIgpLJN/U5h0fsMPws2+Cm
         5ml8eGaYQ1OsJ0qhf7guJRaReJ+hVSMKSKi0/NOatou1vxrISzZm9A/txmrSO6RKzHu1
         LX6I3+wx8rFGpyi34LzG5iZOfx/2h6/w9vy8jpulcD0ApmPy/mwrtvSDy0tXCslcVn9I
         /g7+J8YcDH+PTAjvs8v44cUbigwZCjcIIZqluJhghArkxP62iHVRTLeAU2T/R3V6vd+U
         EgEPLukahjs0NzT9fWMckNt5CLASn5cwYrBGc17cZvm4VALZObeGpA4IoEyz4gWjZfrw
         i7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423670; x=1703028470;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZeyEONZJzSgNbd5fQANo0NB45nTPYSW9ivWPQRNwots=;
        b=YcfjM8oImtSzexpNeTxjPw8EDgTp0nXfgq2lQzhlSnRreUV8YsjcGJ9bSH8NiPGgMl
         YQnLPqUt5KJMsnWzrEVPkhIYzB6txVDIzQ4rQI0RewK3THbzcw98cfKpMAzMxqMf6PMB
         pee2YkIGKk6jqIGdXsuaTbjKoB+rpH3sfPxD9GqWKV7ckhH5+aIKefxW/AbDgD/xxfRr
         o+WaaSs3WJndZGs7Gd0GWlNu7Ia1u1Xlt7eQbT3bkOCAuRXxd24yBav637L2M6pu9s8D
         YvGrMcU5NvB+m2YSCfYa0igMNvd+/CSdkI4b+zxxU6etub/gsw+dxk2vYb0gzJkgfC7t
         jAGw==
X-Gm-Message-State: AOJu0Yyv5se/BkdEj00YruTcxJKzVA+SmJGEtLc575X4zH2h3rxFuAGl
	kbmWQBLHBMDEX0FttMrPk8Y=
X-Google-Smtp-Source: AGHT+IF4APxZ6PSeaK27tjU1dnruwj6r17lr26QajlLa+AkcNV4cYPh20tevdQkeo5BtPV+Qv52vbQ==
X-Received: by 2002:a17:902:e852:b0:1d3:4d39:2773 with SMTP id t18-20020a170902e85200b001d34d392773mr461259plg.5.1702423670328;
        Tue, 12 Dec 2023 15:27:50 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b001a98f844e60sm96642plj.263.2023.12.12.15.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 15:27:50 -0800 (PST)
Date: Wed, 13 Dec 2023 08:27:49 +0900 (JST)
Message-Id: <20231213.082749.16210309490355798.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com, alice@ryhl.io,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <e9997f99-7261-4e9e-b465-e3869b6f4a6f@proton.me>
References: <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>
	<ZXjBKEBUrisSJ7Gx@boqun-archlinux>
	<e9997f99-7261-4e9e-b465-e3869b6f4a6f@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 22:40:01 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 12/12/23 21:23, Boqun Feng wrote:
>> On Tue, Dec 12, 2023 at 05:35:34PM +0000, Benno Lossin wrote:
>>> [1]: Technically it is a combination of the following invariants:
>>> - the `mdio` field of `struct phy_device` is a valid `struct mido_device`
>>> - the `bus` field of `struct mdio_device` is a valid pointer to a valid
>>>   `struct mii_bus`.
>>>
>>>> If phy_read() is called here, I assume that you are happy about the
>>>> above comment. The way to call mdiobus_read() here is safe because it
>>>> just an open code of phy_read(). Simply adding it works for you?
>>>>
>>>> // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>>>> // So it's just an FFI call, open code of `phy_read()`.
>>>
>>> This would be fine if we decide to go with the exception I detailed
>>> above. Although instead of "open code" I would write "see implementation
>>> of `phy_read()`".
>>>
>> 
>> So the rationale here is the callsite of mdiobus_read() is just a
>> open-code version of phy_read(), so if we meet the same requirement of
>> phy_read(), we should be safe here. Maybe:
>> 
>> 	"... open code of `phy_read()` with a valid phy_device pointer
>> 	`phydev`"
>> 
>> ?
> 
> Hmm that might be OK if we add "TODO: replace this with `phy_read` once
> bindgen can handle static inline functions.".

That's the conclusion? I suppose that a way to handle static inline
functions is still under discussion.


> Actually, why can't we just use the normal `rust_helper_*` approach? So
> just create a `rust_helper_phy_read` that calls `phy_read`. Then call
> that from the rust side. Doing this means that we can just keep the
> invariants of `struct phy_device` opaque to the Rust side.
> That would probably be preferable to adding the `TODO`, since when
> bindgen has this feature available, we will automatically handle this
> and not forget it. Also we have no issue with diverging code.

I wasn't sure that `rust_helper_*` approach is the way to go.


