Return-Path: <netdev+bounces-57025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E10F8119DC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4841C211D3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7427487A0;
	Wed, 13 Dec 2023 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqZvaRQy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202998;
	Wed, 13 Dec 2023 08:43:13 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4259cd18f85so42328541cf.3;
        Wed, 13 Dec 2023 08:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485792; x=1703090592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+CD/kguWQ817FNyYosTaBk3Aw8NhD3Oq30X+GXsXkU=;
        b=HqZvaRQynR4C+6fZFGpTeXTFk4lzcgYcO6Gy/aQkWXbNpT1PpkePRaotguE3tlWEmG
         yfapocUCdezwXjsdD4dUPaEVMvlEr1/xlc7R/de61jTVKZbzhfOHTd4eMVFFM+E1nI5e
         2hL+WvRXSTY3BJ+CKjHbxV9q1f6LWARdwwq5JxSDekIYEI6Rrc5ueCpDYEIBLMFpRRuV
         vkjBvX4u9jYmhyiiLnZSq2D5x4xhnWN0Lt7OuYp2nVqycWd7RzfIF+O/sLySh0FxYvo6
         aDk4V+iMisACw0D5u9gzUbS29xkTNnO7wY4k0D8Wi3l3ME4fUYMpY/DB8zZ8+gS3lvFB
         VeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485792; x=1703090592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+CD/kguWQ817FNyYosTaBk3Aw8NhD3Oq30X+GXsXkU=;
        b=nxRiaSVuJpRDIHDZhX82XTWArLSMkHhjIqowzSWeVfmaIbbzDBd3hDXyOEEMYB1azX
         POzf/vVft12njwMh+k5te+5JfBFvUHtPE4hY0jJL3iW8lWlB+Tccta0tpkPzoQvxgk6c
         d96aNp76HH0lVLbHyC73Zwni2wTHKapbBsfb4d1e00co9hcX0vZvnIwHktil1KunA5vP
         Kdcoj1JRjMIHt/9DtgzDt2lx0G6hGRExlGD5h6yAZ0p2iZG0K9h8zYgIiu34oUVB0v3I
         cUfoq6flZweVTWeIVC2dQ4xQgKrilJ/0f5VmUNlEXDxsLr2GPR298LytqbYXhd1VuKIA
         MDTA==
X-Gm-Message-State: AOJu0YzQ88Lvz5mulvSvhziJYbJRBCcgfGeEhAkMcGXagbO2gr1POQWq
	sx7jqGUOo87Ili1HGSiBKnQ=
X-Google-Smtp-Source: AGHT+IEb20jy/qauW9Z9KLVYyunmp5cl0D5QQgpMLScyE07OtNfcWwlYDsTJftls0G345X4qQxErrw==
X-Received: by 2002:ac8:5f89:0:b0:425:4043:7631 with SMTP id j9-20020ac85f89000000b0042540437631mr11272563qta.89.1702485792371;
        Wed, 13 Dec 2023 08:43:12 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c2-20020ac853c2000000b004258641a372sm5050157qtq.45.2023.12.13.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:43:12 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 94F2427C0060;
	Wed, 13 Dec 2023 11:43:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Dec 2023 11:43:11 -0500
X-ME-Sender: <xms:H995ZQvEmTj_heJxaZm7P1JIP0t0vImB8aIErr1dcHaQLziSzPCTog>
    <xme:H995Zdd2tMvxEx7LgBBDiUDEYPKsjPmTGn1zvOWdgQ5r7qR6Pro7TmdqqvmsVMlm5
    tjxfWE66bxLkPkMRg>
X-ME-Received: <xmr:H995ZbwbMNaIqmwfk9x79FBd7WBmawF3lJrZSRY2TLxrBG7dF0ZpUL8s5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:H995ZTMjmknG7qhfS2rtWEaDwfY76E9wYemQvvK8rcPRqSr5aQYQHg>
    <xmx:H995ZQ-TiLsfAo-ssKkjeAgyCLWUcqPsNznIeSovuwwSX_IdJYwzgA>
    <xmx:H995ZbWzAKLEJVHvPbNtIOIeiai8iBvqiHZU4REKvt1sS2vdZ8k6yA>
    <xmx:H995ZbZ2mhQSSUwkAjYA2F-cDkrW-0R7nvBVujElOkEB45xu0KrXnA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 11:43:10 -0500 (EST)
Date: Wed, 13 Dec 2023 08:43:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>

On Wed, Dec 13, 2023 at 11:24:03AM +0100, Andrew Lunn wrote:
> > > The C side people read the Rust code before changing the C code? Let's
> > > see. 
> > > 
> > 
> > Hmm... I usually won't call someone "C side people". I mean, the project
> > has C part and Rust part, but the community is one.
> > 
> > In case of myself, I write both C and Rust, if I'm going to change some
> > C side function, I may want to see the usage at Rust side, especially
> > whether my changes could break the safety, and safety comments may be
> > important.
> 
> While i agree with your sentiment, ideally we want bilingual
> developers, in reality that is not going to happen for a long time. I
> could be wrong, but i expect developers to be either C developers, or
> Rust developers. They are existing kernel developers who know C, or
> Rust developers who are new to the kernel, and may not know much C. So

Sorry, I cannot agree with you. Why do we try to divide the community in
two parts? In fact, I keep telling people who want to contribute
Rust-for-Linux that one way to contribute is trying to do some C code
changes first to get familiar with the subsystem and kernel development.

The sentence from Tomo really read like: I don't want to put this
information here, since I don't think anyone would use it. Why do we
want to shutdown the door for more people to collaborate, really, why?
The only downside here is that Tomo needs to maintain a few more lines
of comments. Also the comment is not a random comment, it's the safety
comment, please see below..

> we should try to keep that in mind.
> 
> I personally don't think i have enough Rust knowledge to of even
> reached the dangerous stage. But at least the hard part with Rust
> seems to be the comments, not the actual code :-(
> 

Well, a safety comment is a basic part of Rust, which identifies the
safe/unsafe boundary (i.e. where the code could go wrong in memory
safety) and without that, the code will be just using Rust syntax and
grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
boundaries, why do they try to use Rust? Unsafe Rust is harder to write
than C, and safe Rust is pointless without a clear safe/unsafe boundary.
Plus the syntax is not liked by anyone last time I heard ;-)

Having a correct safety comment is really the bottom line. Without that,
it's just bad Rust code, which I don't think netdev doesn't want either?
Am I missing something here?

Regards,
Boqun

> 	Andrew
> 

