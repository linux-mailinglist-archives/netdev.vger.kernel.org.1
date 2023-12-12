Return-Path: <netdev+bounces-56189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2380E1EC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0C628276E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E42104;
	Tue, 12 Dec 2023 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRBw4LdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6256B1FF6;
	Mon, 11 Dec 2023 18:31:12 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9e993d94dso2882642a34.0;
        Mon, 11 Dec 2023 18:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348242; x=1702953042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJp89xqcodbFL+p1/5vESVp+Bf+v1SAb0fmxcfoL7N0=;
        b=dRBw4LdC60GBEat7OV3VBdsmHt6Pf8HkEqahirTPUG9GAIZQVr0m29JQRf4ZFnYvS5
         UAMTs6GNCuy4UG3BZ6XMFzSdE50zljZtmlV2Ospbd6EWgehneovwChvzY2Tt47biO7ok
         GIIIvVvMbZhrVMVpra4e71YMczkoaSQb1n5YMxkPgQcLcXUpLdHfjpawWpovArmLa44q
         aBzYlTrQztKxBrEwK1F2w7R2BygqYA7Pmpx1xCF0LesqfZkTnwohRF52PO5FOw3wb3Qq
         wD58SOO+79J3EsZTfPkitD1L6ccPfzL3mmA41dOS4B3QkTi5YENQ0S7SWg3Nq3BmG8iB
         yd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348242; x=1702953042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJp89xqcodbFL+p1/5vESVp+Bf+v1SAb0fmxcfoL7N0=;
        b=H7c8ngoBXzALQwZp8nP+6AT1AST65OoSepuy9UBLttaQJHAx07LqBRkCAO/rvmkRcT
         58714E3GWy8/A/QPEq8lLGlLNt2o/BeGyFfx5pqbnEUSebqBEsGQQzjj0VGt9lwS12E5
         XdLuB6KkSzG1TaM0HRVgv/LKh0y28gvpu7xhZ/OyRgWNHZWb8hf62wlPMUz3MHcssda4
         GjOulMrS4MlCnjjJEKc7gSCrlmuQohrcTeEvZvNrniwAJzjFrkLiufcwBkThp4mcL9tf
         fiHYJge+f4VqglTJdjFTzkH/bqaFFntEgYOkcfabfRG8J7oMEwlz4Uadm810WuGcN+Sz
         KimQ==
X-Gm-Message-State: AOJu0Yy5NyXbYi0Tv3Z7ZQMk6xkYXjmefouD0Q24WBOVovEeLKuNdcaM
	/SfMNlgE+MKiY34sYP3Z64U=
X-Google-Smtp-Source: AGHT+IEZVU4UigyEaBBf5rBnDL9eolzDGV7t9snP951hcbhlrziA35x5XLuOvFvnYCLl1nSNwYwStQ==
X-Received: by 2002:a05:6808:2184:b0:3b9:e5f3:9ebf with SMTP id be4-20020a056808218400b003b9e5f39ebfmr6417741oib.21.1702348241912;
        Mon, 11 Dec 2023 18:30:41 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dk10-20020a056214092a00b0067ee87c495esm118806qvb.121.2023.12.11.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:30:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0D40B27C0054;
	Mon, 11 Dec 2023 21:30:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 21:30:41 -0500
X-ME-Sender: <xms:0MV3ZZYJMsxTRFVYW3cAVDHD5AyCJVLJC4WEJp1__d3PmJ-We-_-Ig>
    <xme:0MV3ZQb1KBhklWLO0M98yZuXCnqOkRLIkMBABj0sN4c3wFD5iWdi70kBF5S_cxfq3
    e91FkwDQTTufxVw_w>
X-ME-Received: <xmr:0MV3Zb8PfCI1yekK1NfksZdUM31Tb2ENwwAwNezK9EFjlJSntePXnpUuMBSZnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0MV3ZXq6748yieTw0_wENi2xErrQx-jwtslNY_cN34d8LUba3M6c9w>
    <xmx:0MV3ZUrGV5spqC143wA5kzeCIKfxJX0GduIiV0KpZDeaHplriUgT6Q>
    <xmx:0MV3ZdSFpHmMCcaKGPe47ZZa2NF4Y1OEzlmP2_h34q5iAYld_mOOtg>
    <xmx:0cV3Zb1tsMe-dW6edUdKJJ7KOk2OLDp4DugpME1scurWFSgSsnPOkA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 21:30:40 -0500 (EST)
Date: Mon, 11 Dec 2023 18:30:36 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXfFzKYMxBt7OhrM@boqun-archlinux>
References: <ZXed8cQLJhDSTuXG@boqun-archlinux>
 <20231212.084753.1364639100103922268.fujita.tomonori@gmail.com>
 <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>

On Tue, Dec 12, 2023 at 10:46:50AM +0900, FUJITA Tomonori wrote:
> On Mon, 11 Dec 2023 16:49:39 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> >> touch it (doesn't need to know anything about it). What safety comment
> >> should be written here?
> > 
> > Basically, here Rust just does the same as C does in phy_read(), right?
> > So why phy_read() is implemented correctly, because C side maintains the
> > `(*phydev).mdio.addr` in that way. We ususally don't call it out in C
> > code, since it's obvious(TM), and there is no safe/unsafe boundary in C
> > side. But in Rust code, that matters. Yes, Rust doesn't control the
> > value of `(*phydev).mdio.addr`, but Rust chooses to trust C, in other
> > words, as long as C side holds the invariants, calling mdiobus_read() is
> > safe here. How about 
> > 
> > // SAFETY: `phydev` points to valid object per the type invariant of
> > // `Self`, also `(*phydev).mdio` is totally maintained by C in a way
> > // that `(*phydev).mdio.bus` is a pointer to a valid `mii_bus` and
> > // `(*phydev).mdio.addr` is less than PHY_MAX_ADDR, so it's safe to call
> > // `mdiobus_read`.
> 
> I thought that "`phydev` is pointing to a valid object by the type
> invariant of `Self`." comment implies that "C side holds the invariants"
> 

By the type invariant of `Self`, you mean:

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts that you are in
/// a context where all methods defined on this struct are safe to call.

my read on that only tells me the context is guaranteed to be in a
driver callback, nothing has been said about all other invariants C side
should hold.

> Do we need a comment about the C implementation details like
> PHY_MAX_ADDR? It becomes harder to keep the comment sync with the C
> side because the C code is changed any time.

Well, exactly, "the C code is changed any time", I thought having more
information in Rust helps people who is going to change the C side to
see whether they may break Rust side. Plus it's the safety comment, you
need to prove that it's safe to call the function, the function is
unsafe for a reason: there are inputs that may cause issues, and writing
the safety comment is a process to think and double check.

Maybe we can simplify this a little bit, since IIUC, you just want to
call phy_read() here, but due to that Rust cannot call inline C
functions directly, hence the open-code. How about:


// SAFETY: `phydev` points to valid object per the type invariant of
// `Self`, also the following just minics what `phy_read()` does in C
// side, which should be safe as long as `phydev` is valid.

?

Regards,
Boqun

