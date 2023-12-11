Return-Path: <netdev+bounces-56079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C1880DB8B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021DF280C9F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9753E0E;
	Mon, 11 Dec 2023 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk1spu1J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504DC4;
	Mon, 11 Dec 2023 12:23:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-42589694492so38594371cf.1;
        Mon, 11 Dec 2023 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702326223; x=1702931023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPO8q1BoUD7beNI5e00JNk8Wd2TUaPKn/aNL8u/igNE=;
        b=Rk1spu1Jt0CKu95ie2XkWaXHgXYH3N7BE+6fiyjsoa/B2zA8W+nnaew4J17nIVgoMo
         xFAt9YRFLbOj0yWV07CUJo7/YHaDptXegP8r7n9fqpqiOuOyxp8wHrWI+I+fKuXV745R
         AuGNNyOXxUKbHED5pUhMJnGMYFTg0zegkeXZXwqkwSk8s5ZT3j8FGIGjhbQSNTTEKjRp
         GWuD2NPDEYid56LroXsCdywIU21aTAq/lb7x6uvCE4P0Ps97l1Bv/ua/SqAy7NO8yXuH
         19nf6CPTZz1yfPyuuqGqLR0aoROk//bSAQBrWKwvgavAqHNd166SCStHkkAJNYjDe3tP
         scjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702326223; x=1702931023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPO8q1BoUD7beNI5e00JNk8Wd2TUaPKn/aNL8u/igNE=;
        b=irIGMXFSS4tXMIc8dQeKgH5LVKIP0iZOh26C3vjZnM2bMi/OnL0G8WxcWWMuuDJEnP
         BnohhFnaOqmU/mjTFwdnHzna7SlkY4hce20+UTUgRVIEHWrZMXxPmMw6N9HFgetpk4P/
         /AxmlSZlUDH20xnA7i3ssqFK13CsVpbvIxMI/4wKqd1a0coWSXCDMeGyUyXBMGubQmLI
         Ey7Qp3ws3j+HA7CPmXTIZ9GFyWdwACvh7RIrb9kj2mRFWoVGG1JVXHO7ts4LsMdPRPhH
         rtQ57nLlsnPTN7DkRkqgmEW/jT+4/ev/NlfITySFJmlZMyWgPEZheY9pnelgsH70TWiT
         9Gqg==
X-Gm-Message-State: AOJu0YxRljdPvSaxNTPUdhMxWp3QGJbZuaQqjBILv5T2ykvUy441JTsp
	kIdFOd26Z6caCzWvMX85HWY=
X-Google-Smtp-Source: AGHT+IEWAr+T2+PRfHNiBcNfvqg7qbWqm9B20iNs/KYvXoR0He+IWr3yNx4yQ7zFsEWWzl+FQZAThA==
X-Received: by 2002:ac8:5aca:0:b0:425:4043:5f2f with SMTP id d10-20020ac85aca000000b0042540435f2fmr7817094qtd.109.1702326223439;
        Mon, 11 Dec 2023 12:23:43 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x8-20020ac85388000000b00423e5a44857sm3464194qtp.23.2023.12.11.12.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:23:42 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 7E4E627C005B;
	Mon, 11 Dec 2023 15:23:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 15:23:42 -0500
X-ME-Sender: <xms:zm93ZWtRBOWd3s8yY_ffUQ9Il8hCUkXBv20tWHhDx3NxIm6agqH5ig>
    <xme:zm93ZbfoloTIvFx8SmsCFOzW1HfuzYW_AMqNOi2Bwt3mZDXCSCIuNLti7xRkv03Yf
    WXGW4Z04NpqFAc5vQ>
X-ME-Received: <xmr:zm93ZRzYaTt_YWpwvlNZCAtIhwqvjBDT0mgQyKbrl_0PBKz5sGCWaV4quICF_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvdejleeukeekudfhieegjeduteffkeevleeuieevffefieduuddtveet
    tdeugfdvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:zm93ZROY7SoqjQYjlqiAt4kbIXUnHqGyIlya1iwjPNmdSTvVacXeZg>
    <xmx:zm93ZW-WkqWuOjTEdq8TAI2Vy_eQfvp7ct7CP1DM39zSQstuYtOFxQ>
    <xmx:zm93ZZVjzKO1_oRKQi5dpUR9rMAAWaMwJ5OchFysXRhqwQBTIOcKDg>
    <xmx:zm93ZaT_7o3IdxNaCnmfwgg1o6lXInzKv9Am97Mp7TMcxZxHcqYDow>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:23:41 -0500 (EST)
Date: Mon, 11 Dec 2023 12:23:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
	wedsonaf@gmail.com, aliceryhl@google.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [net-next PATCH] rust: net: phy: Correct the safety comment for
 impl Sync
Message-ID: <ZXdvytghVcqgwzxa@boqun-archlinux>
References: <20231210234924.1453917-2-fujita.tomonori@gmail.com>
 <20231211194909.588574-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211194909.588574-1-boqun.feng@gmail.com>

+ Tomo

On Mon, Dec 11, 2023 at 11:49:09AM -0800, Boqun Feng wrote:
> The current safety comment for impl Sync for DriverVTable has two
> problem:
> 
> * the correctness is unclear, since all types impl Any[1], therefore all
>   types have a `&self` method (Any::type_id).
> 
> * it doesn't explain why useless of immutable references can ensure the
>   safety.
> 
> Fix this by rewritting the comment.
> 
> [1]: https://doc.rust-lang.org/std/any/trait.Any.html
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> This is a follow-up for my ignored feedback:
> 
> 	https://lore.kernel.org/rust-for-linux/ZV5FjEM1EWm6iTAm@boqun-archlinux/	
> 
> Honestly, I believe that people who are active in the review process all
> get it right, but I want to make sure who read the code later can also
> understand it and reuse the reasoning in their code. Hence this
> improvement.
> 
> Tomo, feel free to fold it in your patch if you and others think the
> wording is fine.
> 
>  rust/kernel/net/phy.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index d9cec139324a..e3377f8f36b7 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -489,8 +489,8 @@ impl<T: Driver> Adapter<T> {
>  #[repr(transparent)]
>  pub struct DriverVTable(Opaque<bindings::phy_driver>);
>  
> -// SAFETY: `DriverVTable` has no &self methods, so immutable references to it
> -// are useless.
> +// SAFETY: `DriverVTable` doesn't expose any &self method to access internal data, so it's safe to
> +// share `&DriverVTable` across execution context boundries.
>  unsafe impl Sync for DriverVTable {}
>  
>  /// Creates a [`DriverVTable`] instance from [`Driver`].
> -- 
> 2.43.0
> 

