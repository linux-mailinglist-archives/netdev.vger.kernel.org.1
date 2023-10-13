Return-Path: <netdev+bounces-40651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C87C8287
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D9D1C20F42
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD0111AE;
	Fri, 13 Oct 2023 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8qBmhax"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CC111AA;
	Fri, 13 Oct 2023 09:53:51 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53210A9;
	Fri, 13 Oct 2023 02:53:50 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692af7b641cso508265b3a.1;
        Fri, 13 Oct 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697190829; x=1697795629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTH5dNfAMto9mxdSa5VOyhTbrVnpEF0/eblaOixpmaI=;
        b=G8qBmhaxvgFwNuROSin/1BKcb2S8NuX7E5XDh8VPiQAyiADWew4sswb+jB4ionuQ+J
         AfqULJHfiQBSlcDTtpC4ztGMEOD6HiMW2BZskN0uvzEPE8ASwDYuDajntuTx+KytmyzV
         RdZVwr/bJwDXkcM2bpXMPKCGj7ix72EuPtLg8f6RC/ddFkGUpnv+zdWZFcmEQDHmMc6x
         niUVSW+hznHSf+GRKyv6ZgkU5DW20Z/FDniX3ebXGuqbun+g8lBgRFTHzciOg69z2oSQ
         o1virD6enoxW6OJ76aXyy4daTZN4VC26bOPhbOMvGNZ9hRXoOEaxJpP1JYSHgdDOMOWs
         toXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190829; x=1697795629;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTH5dNfAMto9mxdSa5VOyhTbrVnpEF0/eblaOixpmaI=;
        b=DZRw0VtZelIAIwQXe/lkV6Th+iNUH9s5q1JLPWiSTAU4DzkkWCziILfjNqHpWRBvhK
         LmEDFOV5r8mwUnvotV6dt6jwh7rQ1pKf7F9lzbniaNRq19HuQiK+b39T9yxgmfPbh9bz
         BmRYN8mJU8pYMZjgqGd9mEK+VhpltHHy3EEn+6tRk5P22NKZc3vbiE9b79j/NNxUG8i5
         vTDIYx/XUBxS2nkUTdGP26aZHseF5eXfz0LQoqdhN/O2GNC+LC/dzCvSXgUTyU+0uxub
         VF5OsQA6ceZbl0SAvp6twICl6HzRBKTZ7uWXVvbyOD3hq5ZR/dHu1CL96ajV9MixPr5d
         Py3A==
X-Gm-Message-State: AOJu0Ywi+YnS55eTrC5LJAt4q/uqKUy3tWN+kYY99FNjdZ6uuQ4+yvif
	3My+1XUyvYgZiwbal00bkiA=
X-Google-Smtp-Source: AGHT+IHnT3Jhqm823IZGOp+NErp+XGi/wq+EV+TWg8ku2BM6pgaASy4l93sD1U7x25pKl24DB+X36w==
X-Received: by 2002:a05:6a20:8f01:b0:15a:2c0b:6c81 with SMTP id b1-20020a056a208f0100b0015a2c0b6c81mr31018796pzk.3.1697190829432;
        Fri, 13 Oct 2023 02:53:49 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ji20-20020a170903325400b001c9b8f76a89sm3495962plb.82.2023.10.13.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:53:49 -0700 (PDT)
Date: Fri, 13 Oct 2023 18:53:48 +0900 (JST)
Message-Id: <20231013.185348.94552909652217598.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
References: <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home>
	<20231013.144503.60824065586983673.fujita.tomonori@gmail.com>
	<1da8acc8-ca48-49ae-8293-5e2a7ed86653@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 07:56:07 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> btw, what's the purpose of using Rust in linux kernel? Creating sound
>> Rust abstractions? Making linux kernel more reliable, or something
>> else?  For me, making linux kernel more reliable is the whole
>> point. Thus I still can't understand the slogan that Rust abstractions
>> can't trust subsystems.
> 
> For me it is making the Linux kernel more reliable. The Rust abstractions
> are just a tool for that goal: we offload the difficult task of handling
> the C <-> Rust interactions and other `unsafe` features into those
> abstractions. Then driver authors do not need to concern themselves with
> that and can freely write drivers in safe Rust. Since there will be a lot
> more drivers than abstractions, this will pay off in the end, since we will
> have a lot less `unsafe` code than safe code.
> 
> Concentrating the difficult/`unsafe` code in the abstractions make it
> easier to review (compared to `unsafe` code in every driver) and easier to
> maintain, if we find a soundness issue, we only have to fix it in the
> abstractions.

Agreed.


>> Rust abstractions always must check the validity of values that
>> subsysmtes give because subsysmtes might give an invalid value. Like
>> the enum state issue, if PHYLIB has a bug then give a random value, so
>> the abstraction have to prevent the invalid value in Rust with
>> validity checking. But with such critical bug, likely the system
>> cannot continue to run anyway. Preventing the invalid state in Rust
>> aren't useful much for system reliability.
> 
> It's not that we do not trust the subsystems, for example when we register
> a callback `foo` and the C side documents that it is ok to sleep within
> `foo`, then we will assume so. If we would not trust the C side, then we
> would have to disallow sleeping there, since sleeping while holding a
> spinlock is UB (and the C side could accidentally be holding a spinlock).
> 
> But there are certain things where we do not trust the subsystems, these
> are mainly things where we can afford it from a performance and usability
> perspective (in the example above we could not afford it from a usability
> perspective).

You need maintenance cost too here. That's exactly the discussion
point during reviewing the enum code, the kinda cut-and-paste from C
code and match code that Andrew and Grek want to avoid.


> In the enum case it would also be incredibly simple for the C side to just
> make a slight mistake and set the integer to a value outside of the
> specified range. This strengthens the case for checking validity here.
> When an invalid value is given to Rust we have immediate UB. In Rust UB
> always means that anything can happen so we must avoid it at all costs.

I'm not sure the general rules in Rust can be applied to linux kernel.

If the C side (PHYLIB) to set in an invalid value to the state,
probably the network doesn't work; already anything can happen in the
system at this point. Then the Rust abstractions get the invalid value
from the C side and detect an error with a check. The abstractions
return an error to a Rust PHY driver. Next what can the Rust PHY
driver do? Stop working? Calling dev_err() to print something and then
selects the state randomly and continue?

What's the practical benefit from the check?


> In this case having a check would not really hurt performance and in terms
> of usability it also seems reasonable. If it would be bad for performance,
> let us know.

Bad for maintenance cost. Please read the discussion in the review on rfc v1.


