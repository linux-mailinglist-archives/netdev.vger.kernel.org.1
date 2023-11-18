Return-Path: <netdev+bounces-48929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097147F00C6
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46942810F5
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370818AED;
	Sat, 18 Nov 2023 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZhQ/XhE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD44C20;
	Sat, 18 Nov 2023 07:54:54 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cc56255e3so18180011cf.3;
        Sat, 18 Nov 2023 07:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322881; x=1700927681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKCGSdgqZ2cORCdlQTI4dB2j/p1mvG1qhqOXmdoWxkU=;
        b=NZhQ/XhExACQ5i/KMVTcc/t84lBpNCRAGn3nQeuINmevHd0rboHu/piODzHGqyMD/v
         GB1I2PeNiHNL3tNytZN5LI5PykRYlCC8STKZ8fbeEFs/wVl2h6irc77eClPMLt/h35nH
         t2skuSA9/odBRAdWhgJSsiSNjm6S2bKBuEXyB8+dKcmx9sgt4KSXcui3MEER0L52NDxm
         Y2H2xHOGrVdX6lXrODgeZbqV3Xo2f5hhUYbbck7xll3XCQgcNjR0E+RliBp5LNwGP7+O
         eiSFKPgMYRAVCxm3ohW6ca/NVhIVCAp64piwF5wS6NoyPW+9D5vxrblVIyZ+ws5Y82DI
         s5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322881; x=1700927681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKCGSdgqZ2cORCdlQTI4dB2j/p1mvG1qhqOXmdoWxkU=;
        b=qUjcNfUHdh9gpY91qhKDddcoMjqQf6IFpQRhi+gdTgJ2LRwxeQCXvfOw8jnNhoOTpA
         MXOIz1Ov6pSixitvKb8FqTUgtsJgyjk1s0ZK1tY+y4+Pi3tZf2vXwTktYqinHg3ufTiG
         X1OrMQ84NoV5VF9ojz4NE9eDYbkofD3d2cnn2YAcc4hkKrH5LdHIpmONDvKhPBYId46G
         egRPZ3so0LvBj9/p4lXzy7vt7zZJ5GOQhuZ5q+gwQiqe2pDTFKxEq5U1iDY7nkQKqlHc
         ssy626DySW/FnXoq0giwyuAn6GQxLm0XeND/e1N44OHtOCjYM1LqvJQKLMkPg1/zENpU
         eDTA==
X-Gm-Message-State: AOJu0YxD6/WDQKfZI5ulQ760ouw1NFHDxo8bRUPeHlWE1P8xK9DlgE1/
	RLci67aL2Mg/Z/V3VSWlpHE=
X-Google-Smtp-Source: AGHT+IGJueayGbpRPw3Sm+/6gn/77QadkDfZzN+vqSw7rwkXC2d/G6/jM5U2POxIJQilxx2HP8OCxg==
X-Received: by 2002:a05:622a:307:b0:41c:d487:7d43 with SMTP id q7-20020a05622a030700b0041cd4877d43mr3120703qtw.54.1700322881714;
        Sat, 18 Nov 2023 07:54:41 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a24-20020ac87218000000b004180fb5c6adsm1358049qtp.25.2023.11.18.07.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:54:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id BE84A27C0054;
	Sat, 18 Nov 2023 10:54:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 18 Nov 2023 10:54:40 -0500
X-ME-Sender: <xms:QN5YZRL_Oh7whLykCx3-rD3LZHzHoV30SLbbz2F2RpeDiQZrUwroFA>
    <xme:QN5YZdLi1uj5HQstjQiR95t1Wn5nCt17Xh-slP_KF5dzkhxXY6DhxEcp8XS9uuOj-
    ON4IpYK15Opob51mw>
X-ME-Received: <xmr:QN5YZZuXP2CtPHfpdnZqG2CY6-jj4BhztYvxwgdVv7JqEBRDuDGw6bQQdM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegvddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:QN5YZSY7EI_FT15Oy0keWxPGwMvTiYxDUeHJ5X1H3eER9jH8S8rlgA>
    <xmx:QN5YZYYXWTaahQpICZEIIMLab-OWc71MWV0wZi4zCTgzI4uJjerIjA>
    <xmx:QN5YZWAEgJOj1cpyUdWddtj4hT-xEzX_l1p9JOV5MEUI9vgCJ8OT0w>
    <xmx:QN5YZWlx4p3fiSTven8Jv4OvitR2_Aeqnv5ml2JzkNJuygJoK4E95NsBcuc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Nov 2023 10:54:40 -0500 (EST)
Date: Sat, 18 Nov 2023 07:54:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Alice Ryhl <aliceryhl@google.com>,
	fujita.tomonori@gmail.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZVjePqyic7pvcb24@Boquns-Mac-mini.home>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com>
 <b69b2ac0-752b-42ea-a729-9efdee503602@lunn.ch>
 <2023111709-amiable-everybody-befb@gregkh>
 <ZVf3LvoZ7npy3WxI@boqun-archlinux>
 <e7d0226a-9a38-4ce9-a9b5-7bb80a19bff6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d0226a-9a38-4ce9-a9b5-7bb80a19bff6@lunn.ch>

On Sat, Nov 18, 2023 at 04:32:26PM +0100, Andrew Lunn wrote:
> > One example of not `Send` type (or `!Send`) is spinlock guard:
> > 
> > 	let guard: Guard<..> = some_lock.lock();
> > 
> > creating a Guard means "spin_lock()" and dropping a Guard means
> > "spin_unlock()", since we cannot acquire a spinlock in one context and
> > release it in another context in kernel, so `Guard<..>` is `!Send`.
> 
> Thanks for the explanation. Kernel people might have a different

Surely *we* do, and looks like I created more confusion ;-) Maybe I
should say "execution context" as in include/linux/preempt.h: NMI, hard
IRQ, softirq, task.

> meaning for context, especially in this example. We have process
> context and atomic context. Process context you are allowed to sleep,
> atomic context you cannot sleep. If you are in process context and
> take a spinlock, you change into atomic context. And when you release
> the spinlock you go back to process context. So with this meaning of
> context, you do acquire the spinlock in one context, and release it in
> another.
> 

Also as I tried to explain previously, the type of contexts doesn't
matter. Yes, once you hold a spinlock, you enter atomic context, but you
are still in the same task execution context, so acquiring and releasing
in the same task execution doesn't count as "Sending". But if after
acquired one somehow passes the guard to another task, or an interrupt
handler, that's "Sending".

> So we are going to have to think about the context the word context is
> used in, and expect kernel and Rust people to maybe think of it
> differently.
> 

In Rust doc [1], `Send` means:

	Types that can be transferred across thread boundaries.

but of course, we have more "thread-like" things in kernel, so I think
"execution context" may be a better term?

[1]: https://doc.rust-lang.org/core/marker/trait.Send.html

Regards,
Boqun

> 	Andrew

