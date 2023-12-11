Return-Path: <netdev+bounces-56151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F880DFBD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4D1C214B7
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEF35677C;
	Mon, 11 Dec 2023 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFwNu06I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B413C9B;
	Mon, 11 Dec 2023 15:55:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c67fdbe7d4so607038a12.0;
        Mon, 11 Dec 2023 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702338906; x=1702943706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZa1jZhkTj3nLpFTgkwat89lG/Dx1pV15EE6TkzJq+o=;
        b=kFwNu06IDAVHZTjYB6OmSZpP7mEe4C5ABJJ03bdYabgoo2Wgd41Xqrpt/0KJjRSgSC
         cTsZviYGr/AC2beYS5K4lnvLFNRwZcRj49WjD3L+kjJrunImLSVIgEulXGN1MGcGC61a
         rpvBwT+f0BRXOvu0Th7MQNIxpyrSqGr/SZEQMRJt2vAvh0JI7co58tSHyUMcKE9y9TzL
         +WiFaXOE3XkYnNFqy1q7FhQ97h4wVj87m1ZbyGX9aC8zQR1bh43zjv9GNzo94jAmHleO
         J+JbpyG+YB/Uvg2KDd5C2jl3qvhtxYa5R2ZZEnJORStG5lVu8y9jjkCpv5WE2AS3ojOe
         xa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338906; x=1702943706;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SZa1jZhkTj3nLpFTgkwat89lG/Dx1pV15EE6TkzJq+o=;
        b=PnGq0vwhijB/IiBK4lsMtxdfwFfUH6Kvh8k2ottMyfhv4mwLS2zlxKPRrDfqCWZklW
         kU5oXv3Ae+sS6Nv3t2Gol7VkHOx6QKDgHmo5cAbbTFCQcXsOkMMTORxU12gwLKu24i4w
         q9hx3FOxav/ZsVLyBWw/6uvSGilcagNPZcxvWORoqSkw+IDxX5Nhae9L4umJ3V851bWD
         QOrCE/+yHJpFT+1EOPRnCS7qmGe+D4OKvgmpj7dpUWHS+khcy+MB9v/fKsUtXdpe6QYb
         2DT1HxouKrRMQ/zCROnhCweOz/avqz97ed4AchGeRZilT1P7YKLsja9N+MUPJuXug9+G
         /d6w==
X-Gm-Message-State: AOJu0YxzlyeDFQOtc7d62m5gLqYfqD/X72rQpFSxM0srEbg7X0dI6LXY
	4g0F0UJug4CXxN6OA+0SvZQ=
X-Google-Smtp-Source: AGHT+IFulglH0Q5FcnSQHGjk2EB71C8FfjufKHZjjFZZpVyfqTfbeiRqITmAVxTA/ZC66Wd94qYXuw==
X-Received: by 2002:a05:6a00:1143:b0:6ce:7b6f:8c82 with SMTP id b3-20020a056a00114300b006ce7b6f8c82mr11116991pfm.0.1702338905981;
        Mon, 11 Dec 2023 15:55:05 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a000bc300b006cea17d08ebsm6871321pfu.120.2023.12.11.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:55:05 -0800 (PST)
Date: Tue, 12 Dec 2023 08:55:05 +0900 (JST)
Message-Id: <20231212.085505.1804120029445582408.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
 benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com,
 fujita.tomonori@gmail.com
Subject: Re: [net-next PATCH] rust: net: phy: Correct the safety comment
 for impl Sync
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZXeZzvMszYo6ow-q@boqun-archlinux>
References: <20231211194909.588574-1-boqun.feng@gmail.com>
	<c833e8c5-0787-45e6-a069-2874104fa8a7@ryhl.io>
	<ZXeZzvMszYo6ow-q@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 15:22:54 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Mon, Dec 11, 2023 at 10:50:02PM +0100, Alice Ryhl wrote:
>> On 12/11/23 20:49, Boqun Feng wrote:
>> > The current safety comment for impl Sync for DriverVTable has two
>> > problem:
>> > 
>> > * the correctness is unclear, since all types impl Any[1], therefore all
>> >    types have a `&self` method (Any::type_id).
>> > 
>> > * it doesn't explain why useless of immutable references can ensure the
>> >    safety.
>> > 
>> > Fix this by rewritting the comment.
>> > 
>> > [1]: https://doc.rust-lang.org/std/any/trait.Any.html
>> > 
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> 
>> It's fine if you want to change it,
> 
> Does it mean you are OK with the new version in this patch? If so...
> 
>> but I think the current safety comment is good enough.
> 
> ... let's change it since the current version doesn't look good enough
> to me as I explained above (it's not wrong, but less straight-forward to
> me).

I'll leave this alone and wait for opinions from other reviewers since
you guys have different options. It's improvement so I don't need to
hurry.




