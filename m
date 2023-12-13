Return-Path: <netdev+bounces-57030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881BB811A87
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A0D1F21958
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8713A8FF;
	Wed, 13 Dec 2023 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN8IWX0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43052F4;
	Wed, 13 Dec 2023 09:13:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f2dc3a9bcso429062685a.3;
        Wed, 13 Dec 2023 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702487582; x=1703092382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNE502AZCwpSJ0AiA/qxYF3eR+QalXC16ipTAt0SyoE=;
        b=LN8IWX0VaWz8IcW9Y5Asy3YVIqjaiCNa2eZ19njTqZ2i/aHan/Luq7Kpf+MyJl+pKK
         kxarrdzWx/huwSo2fpZITHvTmk/pEVWMqEUxx04YGlX0fflrMEk0sw/FlEuZddNUUVNr
         69zKKD+Z8J7DkKE+8HgbcWA7zCGi0Eax+C8r1PGZ3lDR10SM8O9TpSAqtNVJKA4AEVh8
         KdAoHNurp6TobDkrseweT7I4P4b0zGJVdbbwR8zknJM03yZ7ypWspjCnVoNh49T1bibo
         BulY8Hd7JA9HsrmzeAf8wN4omB7Fc5N1ZZRrrXvVufTGxuq8s7oz2xIfG1eloYCyJE9A
         zEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487582; x=1703092382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNE502AZCwpSJ0AiA/qxYF3eR+QalXC16ipTAt0SyoE=;
        b=OoYkIGxTsh6iUTHYLTNH6iiILUWhAxopmfEAkn4wMImejPdXyAuvJSCtL4dDhB9wHD
         GEqFZPqMQS4otWEMrzb3OouHKHYoJuAnB+0szzyYcI0KEEwnu1q7BOjTgs+nMxoel8Wu
         ncWUEeUHSNHPmCjdqoWFQ5OcNGFBQhEmwkjXSwbu2DwMPMqkiB4qU5VTSUHvuI67DDl5
         KJWcFFB+E4KIeVyfbQh7CNIFtzsOgeFJX88migGv9Fy1e+5/O4gQDOQnDjzMKOLE3sNH
         VtF28SgCnYBcjWdV337bTaNMYz2oVuqSh0oPIw96uapEatH2P1FxzegF+xhwSrE0f7gc
         /qZA==
X-Gm-Message-State: AOJu0YxMaSFTccpE3gBkAmHfPwQIxElE7tFgqaj+tv64CknzRbTofn9J
	/LpzvJqOCJg5K+S8M8DN+2c=
X-Google-Smtp-Source: AGHT+IESCAseOZI3u4s68CMAFI8S+DYH5BPBl5wFTwQ9qoF3J5IWs3TDqEM9dHuWvQcN9R+ELpjdzg==
X-Received: by 2002:a05:620a:135a:b0:77d:99c3:a2da with SMTP id c26-20020a05620a135a00b0077d99c3a2damr9761186qkl.78.1702487581957;
        Wed, 13 Dec 2023 09:13:01 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bj12-20020a05620a190c00b0077f04cce6e5sm4639422qkb.14.2023.12.13.09.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:13:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4EEF727C005B;
	Wed, 13 Dec 2023 12:13:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Dec 2023 12:13:01 -0500
X-ME-Sender: <xms:HeZ5ZXLw9zgsOnePuno3dlDsgaYl4H6jOr_T8uoDiLV3PIKT4oQgqA>
    <xme:HeZ5ZbLopdD3h_-Z4EarWz19mi6XO-Z3zcSUJaQp2EQaSFarnr6xGCTMC9uLu6CB-
    PZ-xCwI4zoAHi4X_A>
X-ME-Received: <xmr:HeZ5ZftXLL3iPR31lm-Nye_CEHFDhDuK7OgY49IU-yE2HCRgJb2WCLOj3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HeZ5ZQZkNG1TDIm0VG2FYaWSwfUpBzUYd5M-kshOnsOM5IF89a92fg>
    <xmx:HeZ5Zea-9zZBI43JoGJJOL_mfjxrqaaXhgMvdAwoMf8p96TBDQQnjw>
    <xmx:HeZ5ZUCI7e3F9YvkjxY0W66AyThIgXs-8_0MWjY_-gbOCYqcUBXY7A>
    <xmx:HeZ5ZUmS4tLl-VhmV63n4zgEMoL_0ZXGdpzzvSlnvywj1Q0srBXwLg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 12:13:00 -0500 (EST)
Date: Wed, 13 Dec 2023 09:12:59 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXnmGzcdhDr0YQSa@Boquns-Mac-mini.home>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>
 <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>

On Wed, Dec 13, 2023 at 08:43:09AM -0800, Boqun Feng wrote:
> On Wed, Dec 13, 2023 at 11:24:03AM +0100, Andrew Lunn wrote:
> > > > The C side people read the Rust code before changing the C code? Let's
> > > > see. 
> > > > 
> > > 
> > > Hmm... I usually won't call someone "C side people". I mean, the project
> > > has C part and Rust part, but the community is one.
> > > 
> > > In case of myself, I write both C and Rust, if I'm going to change some
> > > C side function, I may want to see the usage at Rust side, especially
> > > whether my changes could break the safety, and safety comments may be
> > > important.
> > 
> > While i agree with your sentiment, ideally we want bilingual
> > developers, in reality that is not going to happen for a long time. I
> > could be wrong, but i expect developers to be either C developers, or
> > Rust developers. They are existing kernel developers who know C, or
> > Rust developers who are new to the kernel, and may not know much C. So
> 
> Sorry, I cannot agree with you. Why do we try to divide the community in
> two parts? In fact, I keep telling people who want to contribute
> Rust-for-Linux that one way to contribute is trying to do some C code
> changes first to get familiar with the subsystem and kernel development.
> 
> The sentence from Tomo really read like: I don't want to put this
> information here, since I don't think anyone would use it. Why do we
> want to shutdown the door for more people to collaborate, really, why?
> The only downside here is that Tomo needs to maintain a few more lines
> of comments. Also the comment is not a random comment, it's the safety
> comment, please see below..
> 
> > we should try to keep that in mind.
> > 
> > I personally don't think i have enough Rust knowledge to of even
> > reached the dangerous stage. But at least the hard part with Rust
> > seems to be the comments, not the actual code :-(
> > 
> 
> Well, a safety comment is a basic part of Rust, which identifies the
> safe/unsafe boundary (i.e. where the code could go wrong in memory
> safety) and without that, the code will be just using Rust syntax and
> grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
> boundaries, why do they try to use Rust? Unsafe Rust is harder to write
> than C, and safe Rust is pointless without a clear safe/unsafe boundary.
> Plus the syntax is not liked by anyone last time I heard ;-)
> 
> Having a correct safety comment is really the bottom line. Without that,
> it's just bad Rust code, which I don't think netdev doesn't want either?

s/doesn't//

> Am I missing something here?
> 
> Regards,
> Boqun
> 
> > 	Andrew
> > 

