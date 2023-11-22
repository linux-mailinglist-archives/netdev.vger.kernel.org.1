Return-Path: <netdev+bounces-50218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E77F4F21
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845061C2099D
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A84F5EE;
	Wed, 22 Nov 2023 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQmEifow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2DB2;
	Wed, 22 Nov 2023 10:17:10 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6cd0963c61cso57871a34.0;
        Wed, 22 Nov 2023 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677029; x=1701281829; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SN/KMQ2vvLENAwtg5lCFJ/mKximo2fIUOtSV5k1GHOg=;
        b=MQmEifowAVL8uqYrWrcgZ2Fi/Px9PmqK+aO8wnmAORa2AVQtexhmE2EO3WIkRWz8u+
         yzlB7g4aI5+lzdhPc6oFFFq7o5vARLuu/4Y1bJpjphtNIHW1ENUPKI3UqHGXD0AhmRzV
         oE3qE4S4/RzrNygajxNCvZbsj9O8OqCMa5odWzto04CWAFQBGxDH3L3jyoO8qFC7lr2E
         FNxxa/Zv38u1Mi2vddEGOn6bxJH0aLonGPV1f1+semOHRHSgCp9Gvc1eiLw7yl0BtlWm
         FFKAkLQTeMEPUIWNIYZXKC2DMzDJX84Zq3AZQAvnx0sYxzdn685leC2bUO/6oMkvq/HA
         sMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677029; x=1701281829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SN/KMQ2vvLENAwtg5lCFJ/mKximo2fIUOtSV5k1GHOg=;
        b=U61e5cM5M8qllKQcRwewbbX+65sP7iBkuy0FgLUuk+hWxU5Ua30RBfljUOCVtjwUg7
         J2fgmXKNZhXDbYfqI/S/41SVxoBtVjJ7dQ1Rr+abCCTCDR2ohUqgmhcBUExjloq1nHtM
         0aoY1hSZh9w0LvIgm3CiGff5Yf9ompxGhNhaHsq8OxcnfphcijouIktwhwrkDZ5H0h8q
         NTZErKTnSYK/hSHfUL2GdVwrJJxp3y9tvvUlFmk59wHvQYZEGLZSXD/TPjvoU0QW+2kQ
         V9y5GWHQWV28rfyHM4eWEJAjC2+Z7MlnsD6O5h9nzMpXSwdvD1oAPh7YmZ5D6pdJ7oLs
         V0JQ==
X-Gm-Message-State: AOJu0Ywz6TINR1p+6FOwBvB72/3jdw87WAzGIve8KKk48Wi/QaWiiT0P
	M6hIbrhfd27EMqltbeNg3i4=
X-Google-Smtp-Source: AGHT+IF8zmQTzVazpP6jAoIXPI8DnQUqH6w+O5LIhEUZ4HGR/tZ7jrbHgzQ38SbON6pOINgCjFUFWg==
X-Received: by 2002:a05:6830:1057:b0:6d7:f639:27e5 with SMTP id b23-20020a056830105700b006d7f63927e5mr580282otp.25.1700677029502;
        Wed, 22 Nov 2023 10:17:09 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ez18-20020ad45912000000b00678013cc898sm4141354qvb.36.2023.11.22.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:17:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id C299827C0054;
	Wed, 22 Nov 2023 13:17:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 Nov 2023 13:17:08 -0500
X-ME-Sender: <xms:pEVeZbfbxheYpgft4ojzpfgrT2X8-7aLDFqOma1zAza3UXutIgovpg>
    <xme:pEVeZRMTvE8zqgZ5X0l5UQjY37gTzccZLoAIrFsNqIAR0ey2Uoc-aDDDUwM7QTPpq
    R3M4zfvFjGBHOXnAg>
X-ME-Received: <xmr:pEVeZUiJG_Pn1Oo7Iq2y295bOCrUrpYkFlTtvGGdaC8X8LeI191uWqPL2yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeiheefkefgvdefteejjedukefhieevleeffeevheehfeffhfekhfet
    veffvefhgfenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pEVeZc-PU4PlP_rBJnv0rO-Xf2qML1-loNeDnAt1X1oO81NblTvkRg>
    <xmx:pEVeZXv5307KS04xkG763zctq_6HRfqy-34YJL-NovAsx9Nby_Xw-Q>
    <xmx:pEVeZbFXzPc0TjdINSe2yzfLwEUVwzfzwgONXf2DE9wVbN_wrAYbWg>
    <xmx:pEVeZVJCOOZj0p-NAUgD775DcwKfwg3TlcQkEHi0Q40C9KZZCFdC_wkxZ9I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:17:08 -0500 (EST)
Date: Wed, 22 Nov 2023 10:16:44 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tmgross@umich.edu, andrew@lunn.ch, gregkh@linuxfoundation.org,
	aliceryhl@google.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZV5FjEM1EWm6iTAm@boqun-archlinux>
References: <e7d0226a-9a38-4ce9-a9b5-7bb80a19bff6@lunn.ch>
 <ZVjePqyic7pvcb24@Boquns-Mac-mini.home>
 <CALNs47tt94DBPvz47rssBTZ86jbHwaa7XaNnT3UbdxwY6nLg1g@mail.gmail.com>
 <20231121.111306.119472527722905184.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121.111306.119472527722905184.fujita.tomonori@gmail.com>

On Tue, Nov 21, 2023 at 11:13:06AM +0900, FUJITA Tomonori wrote:
[...]
> 
> I'm not sure we discussed but making DriverVTable Sync works.
> 
> #[repr(transparent)]
> pub struct DriverVTable(Opaque<bindings::phy_driver>);
> 
> // SAFETY: DriverVTable has no &self methods, so immutable references to it are useless.

Minor nitpicking, I would add one more sentense in the safety comment:

	therefore it's safe to share immutable references between
	threads.

or 
	therefore it's safe to share immutable references between
	execution contexts.

once we decide the term here ;-)

The reason is to match Sync definition [1]:

"""
Types for which it is safe to share references between threads.

This trait is automatically implemented when the compiler determines
it’s appropriate.

The precise definition is: a type T is Sync if and only if &T is Send.
In other words, if there is no possibility of undefined behavior
(including data races) when passing &T references between threads.
"""

[1]: https://doc.rust-lang.org/std/marker/trait.Sync.html

Regards,
Boqun

> unsafe impl Sync for DriverVTable {}
> 
> 
> looks correct?
> 

