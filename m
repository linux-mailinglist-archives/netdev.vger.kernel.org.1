Return-Path: <netdev+bounces-53729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7F804472
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BB6B20AFA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F72116;
	Tue,  5 Dec 2023 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biVQbuux"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF521113;
	Mon,  4 Dec 2023 18:06:19 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c67fdbe7d4so160360a12.0;
        Mon, 04 Dec 2023 18:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701741979; x=1702346779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChmfbSugFn889RdRrkH1XSmiWQdKTGW4FRyLW5Kecos=;
        b=biVQbuuxSdqZBVykvPoYNSbEfqu95JAIYzoJMBppJzSnY8A3cn4GlMz2Ayc4LuBA7H
         GoN0vUplSS5TJ4RmkOV0qj4hgCkLz5iK7g43inR+gJ1biRtu/VsbS6o6MHPA9y5r7ys8
         QXRdCyF6NjOAgKG4eObB+4QSa55hMQmkmePWyTExMXMGNyqwFKmGHW8u6Do/XeBKfEaj
         Q7dA7TCsLKYyd1SvgVOUKawuBAypW32rPJl23srsE+uzCEFT7mDJKkaDE2RAwB/0oCHm
         5c5KzhoozyebymMC2pX3HN5whAycLgebgsB9QYLN60/lggTBwHglaZaeDAU6fYOORCXV
         sRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701741979; x=1702346779;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ChmfbSugFn889RdRrkH1XSmiWQdKTGW4FRyLW5Kecos=;
        b=blvhhhE8GWgLWi7yCv0fXbJG8LTpGYDcK29MyMaxT6PiMpCQ6v4Fj4+B/pyBJqpEua
         P2YXm5XaSyMyhuQtp2/OIh7YT89MQHLybASMceao2fNCgx2yQao8uBwFC750YwtUPx+M
         IzlS9ngG3dETk8/78VimsBzJQbdAKJBFF4xntgUmM5kkOEC7ikGCakk0MyFk368G3eOR
         /6bgegnRIISWFL9uS40mg+pb/9u1501KQJpr7eObIW8QBUoGbkxXRgwYKgwGoWVS1U/c
         n3jyLyU4rYA/gnp1P4OvAV/t3lefMCjISH8plkUpdpI4RdpivoBqelIQlO1JvT8KxHXk
         hppQ==
X-Gm-Message-State: AOJu0YxQV2htfDdkWKuWlGEhY9Fen9qvOoDkKM4SAjMdJSY9a3SatuTE
	OgeWtxURdcb181hRgg+NHIg=
X-Google-Smtp-Source: AGHT+IEY/P1zptoBX7n6TwT4m9BLTAHgNOJGimX7i9JUw27uhzsk1BetNrfcFlbuUM3L8Z+5fEVbhA==
X-Received: by 2002:a05:6a20:da89:b0:18c:18d4:d932 with SMTP id iy9-20020a056a20da8900b0018c18d4d932mr42136881pzb.6.1701741979298;
        Mon, 04 Dec 2023 18:06:19 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id it4-20020a056a00458400b006cbb58301basm8574150pfb.19.2023.12.04.18.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:06:18 -0800 (PST)
Date: Tue, 05 Dec 2023 11:06:18 +0900 (JST)
Message-Id: <20231205.110618.1499275558053658998.fujita.tomonori@gmail.com>
To: jarkko@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CXG0PHF8SB5K.1LNX7D7LCN0W0@kernel.org>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
	<20231205011420.1246000-2-fujita.tomonori@gmail.com>
	<CXG0PHF8SB5K.1LNX7D7LCN0W0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 03:43:50 +0200
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
>> This patch adds abstractions to implement network PHY drivers; the
>> driver registration and bindings for some of callback functions in
>> struct phy_driver and many genphy_ functions.
>>
>> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.
> 
> Just a question: is `_ABSTRACTIONS` a convention or just for this
> config flag?

It's a convention.

https://docs.kernel.org/rust/general-information.html#abstractions-vs-bindings


> That would read anyway that this rust absraction of phy absraction
> layer or similar.
> 
> Why not e.g.
> 
> - `CONFIG_RUST_PHYLIB_BINDINGS`
> - `CONFIG_RUST_PHYLIB_API`
> - Or even just `CONFIG_RUST_PHYLIB`?

I guess that CONFIG_RUST_PHYLIB_API or CONFIG_RUST_PHYLIB could be
used. CONFIG_RUST_PHYLIB_ABSTRACTIONS was preferred during the past
reviewing.

