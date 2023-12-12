Return-Path: <netdev+bounces-56260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971880E42C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 07:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE873B218A8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB34156F4;
	Tue, 12 Dec 2023 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUgi2kVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8523BE;
	Mon, 11 Dec 2023 22:11:18 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4b2ee35bff8so1703024e0c.2;
        Mon, 11 Dec 2023 22:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702361478; x=1702966278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T24Yb7b9RFLYqAjPC99dl6OEjq5ZcK2rXVrE7oCD7cA=;
        b=RUgi2kVS37fXo+P8/Rcf8YouSRcPfZgsPYJaquOCHzz4SIDpHX9dbjXCSn3UbrhW02
         Aaju9ZtBYpCZ56eTPiRDtye7xF8IvOjP4WHarvjNQBNGeuEPcBy4g4vANobPPjU+wBA6
         98bAaNdG4cGaKGgx031qEMELp7UllL412BShV8pjH7WSFVx4dAC+Ozzd7T//AfyCyhhd
         z8nryDaokW0Op2QK8EZinnMjAGSHTdW5Pdwh6ysy5iovrJbuB8ibv93BC6UpOJElDFza
         ybpw+klkTCPHIhibxrxba4JaeT0AMYr8Cz5NxK3aQGJC9x2X21lwNpdGcFJfymCu6QSC
         MClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702361478; x=1702966278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T24Yb7b9RFLYqAjPC99dl6OEjq5ZcK2rXVrE7oCD7cA=;
        b=odM6kM+sKXDYNoMffy6E5Tiitt2VbeiKjkfcQo6B/3nywIcE6XJZ0zkZ0H7VzsMkG2
         CJ0waZ4NWwtUcDlAzG3Q46doz4GWu0B8owAELvQOgrzhZLOcJvyIU/1/jPBalPcrZ789
         PMi6eapPdtixQIC96fwjzBXw59ualGsS4i25T0n3T9qLMzwAZMT+pnHRLO0emku/s0iC
         +DzREA1e9Ftv3qZ+XA4nWJLMbHZjVFWFcMmPKmJaBzgA0Ws/NY4zAHXD/C1XYOMW93Be
         PNBO8uDpxrTTj6Yy4D14qxumDgR5tAvnoOCrocIJueteEf/wx9GH+Pzu9zZgyQYSP5UQ
         E6CQ==
X-Gm-Message-State: AOJu0YxAnm3LxKzlnR/3k1lmDSP942Zgn6721C3D6cesDiVaERjXc3VG
	R1RY6vW3mkRlEY5FbcRJuCE=
X-Google-Smtp-Source: AGHT+IFOR7WVJrVOexLqvlVW1W9mk0AD9X2cVIfBT45PwiODyltCYVexORY2Yf8AVEq3fVPrrtjJqg==
X-Received: by 2002:a05:6122:3b8c:b0:4b2:c554:dfc4 with SMTP id fs12-20020a0561223b8c00b004b2c554dfc4mr4636122vkb.19.1702361477917;
        Mon, 11 Dec 2023 22:11:17 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v2-20020a0cdd82000000b0067ac8bedcd4sm3714176qvk.88.2023.12.11.22.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:11:17 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 01F2927C0054;
	Tue, 12 Dec 2023 01:11:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Dec 2023 01:11:17 -0500
X-ME-Sender: <xms:hPl3ZQxOeFHCQ7l9RhyyQbThq0j0GId47X-0Yxf46HLIaM0VhAPh8w>
    <xme:hPl3ZUQfXmk00-VrGunNuma2AEwabtt0MWgrZg20CxBIXL-lhIqACDZb45ImrCfyS
    27BWL65ROgFRfQjVQ>
X-ME-Received: <xmr:hPl3ZSXAOi9ha3V3LJAV3tqJ_p2xDhKofv44M9Wayh-2AQDs9L7wtZZzyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hPl3Zeh5pGFKmdBL0A1sxtSyVO3yhV6GBb1kHOKKiqB1Qq8ci2DHSg>
    <xmx:hPl3ZSAcsiYLM5FFzWbroJ_9DnWF1_93jdINnznMdLj8XbG91Uhm_w>
    <xmx:hPl3ZfJVga1oaeoXi-sDJQJx180kRMX1q0JKXUuAU8-6hy9DszGYzg>
    <xmx:hPl3Zavk623xXpC0AGncvZerennuydOcCJlE_kG4sQx4Hwq928_A5g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 01:11:16 -0500 (EST)
Date: Mon, 11 Dec 2023 22:11:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>

On Tue, Dec 12, 2023 at 01:04:10PM +0900, FUJITA Tomonori wrote:
> On Mon, 11 Dec 2023 18:30:36 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Tue, Dec 12, 2023 at 10:46:50AM +0900, FUJITA Tomonori wrote:
> >> On Mon, 11 Dec 2023 16:49:39 -0800
> >> Boqun Feng <boqun.feng@gmail.com> wrote:
> >> 
> >> >> touch it (doesn't need to know anything about it). What safety comment
> >> >> should be written here?
> >> > 
> >> > Basically, here Rust just does the same as C does in phy_read(), right?
> >> > So why phy_read() is implemented correctly, because C side maintains the
> >> > `(*phydev).mdio.addr` in that way. We ususally don't call it out in C
> >> > code, since it's obvious(TM), and there is no safe/unsafe boundary in C
> >> > side. But in Rust code, that matters. Yes, Rust doesn't control the
> >> > value of `(*phydev).mdio.addr`, but Rust chooses to trust C, in other
> >> > words, as long as C side holds the invariants, calling mdiobus_read() is
> >> > safe here. How about 
> >> > 
> >> > // SAFETY: `phydev` points to valid object per the type invariant of
> >> > // `Self`, also `(*phydev).mdio` is totally maintained by C in a way
> >> > // that `(*phydev).mdio.bus` is a pointer to a valid `mii_bus` and
> >> > // `(*phydev).mdio.addr` is less than PHY_MAX_ADDR, so it's safe to call
> >> > // `mdiobus_read`.
> >> 
> >> I thought that "`phydev` is pointing to a valid object by the type
> >> invariant of `Self`." comment implies that "C side holds the invariants"
> >> 
> > 
> > By the type invariant of `Self`, you mean:
> > 
> > /// # Invariants
> > ///
> > /// Referencing a `phy_device` using this struct asserts that you are in
> > /// a context where all methods defined on this struct are safe to call.
> > 
> > my read on that only tells me the context is guaranteed to be in a
> > driver callback, nothing has been said about all other invariants C side
> > should hold.
> 
> I meant that phydev points to a valid object, thus mdio and mdio.addr
> do too. But after reading you phy_read() comment, I suspect that you
> aren't talking about if mdio.addr points to valid memory or not. Your
> point is about the validity of calling mdiobus_read() with mdio.addr?
> 

Yes, I was talking about the safety comment for calling mdiobus_read().

> 
> >> Do we need a comment about the C implementation details like
> >> PHY_MAX_ADDR? It becomes harder to keep the comment sync with the C
> >> side because the C code is changed any time.
> > 
> > Well, exactly, "the C code is changed any time", I thought having more
> > information in Rust helps people who is going to change the C side to
> > see whether they may break Rust side. Plus it's the safety comment, you
> 
> The C side people read the Rust code before changing the C code? Let's
> see. 
> 

Hmm... I usually won't call someone "C side people". I mean, the project
has C part and Rust part, but the community is one.

In case of myself, I write both C and Rust, if I'm going to change some
C side function, I may want to see the usage at Rust side, especially
whether my changes could break the safety, and safety comments may be
important.

> 
> > need to prove that it's safe to call the function, the function is
> > unsafe for a reason: there are inputs that may cause issues, and writing
> > the safety comment is a process to think and double check.
> > 
> > Maybe we can simplify this a little bit, since IIUC, you just want to
> > call phy_read() here, but due to that Rust cannot call inline C
> > functions directly, hence the open-code. How about:
> 
> Yeah, I hope that the discussion about inline C functions would end
> with a solution.
> 
> 
> > // SAFETY: `phydev` points to valid object per the type invariant of
> > // `Self`, also the following just minics what `phy_read()` does in C
> > // side, which should be safe as long as `phydev` is valid.
> > 
> > ?
> 
> Looks ok to me but after a quick look at in-tree Rust code, I can't
> find a comment like X is valid for the first argument in this C
> function. What I found are comments like X points to valid memory.

Hmm.. maybe "is valid" could be a confusing term, so the point is: if
`phydev` is pointing to a properly maintained struct phy_device, then an
open code of phy_read() should be safe. Maybe "..., which should be safe
as long as `phydev` points to a valid struct phy_device" ?

Regards,
Boqun

