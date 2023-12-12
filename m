Return-Path: <netdev+bounces-56224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A1C80E327
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A8B217F0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CDBC143;
	Tue, 12 Dec 2023 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6QwT5OL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A09A;
	Mon, 11 Dec 2023 20:04:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d072f50a44so11715635ad.0;
        Mon, 11 Dec 2023 20:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702353851; x=1702958651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvNUqn69REGXDd1jiBC5j3yaPlbQpogLnkhVvz1Ja4s=;
        b=Y6QwT5OL5DySWDlKJX06LSl1dE1POVeFcqIhAhARM2+SZ1+5s/jcnbF7e0y6eaBB1g
         Y4UXgmLa8DmLOs+pacTkTI3B8k+GIfw4IVUma3E5kb3RPOkDjINDiNSKxGJ8aJs03yUo
         jPfjn8t/13oyD+apEPbKfOao14GdZ/ibAZSroD1X/b2C9+ftJ+QvF5Jf59lvA0H4Tvdz
         OlhU4tu4J5nR1nGVljCUDzQEq0xs5b61IwXd8pSqstBfhAIRiDKwVCiiUMPgIxj9QXCm
         VzoFrQsk67onQOcXklZgoGcLOdT8dU2jUb4WyDuqcXw78G2l8KLOt5orJNUcs8Wq3DVZ
         aGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702353851; x=1702958651;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvNUqn69REGXDd1jiBC5j3yaPlbQpogLnkhVvz1Ja4s=;
        b=Kpe7YCQ9P64RkkVry+6t0rsnEzyDo7dS8rj81fkC7BHZULo86lZallegPIEfGC1ePa
         R9umIAhLXNEHNlj7R6inHKLGKRbppF+Dp7qJtiAi6ZEOxTfVr8Fp5kPsPc6ZrDLmYBrP
         r1mYqGAf8s5o0L0n3HRkXkC2Dv6YxWhUZ9SLNH+BtLYVKXKFJr3TXpSd2nprsJla12pz
         um3gmJi7N0OrHAMhEEb421YHuIGlAwQNfdBnG4oagcsAIzp+DqdNpUUdg89BDF8BcpDg
         lRWdmGq3Zl4zX7m05zhqTXFCEpkHxfQ6kQfLNEioPzk4IYnEq7iYjvpPAv948PfxlTtE
         +3Mw==
X-Gm-Message-State: AOJu0Yw5M5AfB5IaD2bd1SmO17FK0T2r7aRV5cH1f3YmUWuIQ7rtNFRX
	My3KYOj1zjHuYCkmkB3+i4Q=
X-Google-Smtp-Source: AGHT+IFvDw5joADI5wmrDw/hIUAhB+TW7uMDfDiBzko7IaP51D5l1kL3i5L/BOMlWzp5Ny4AyXmTyQ==
X-Received: by 2002:a05:6a20:3d29:b0:18b:c9cf:4521 with SMTP id y41-20020a056a203d2900b0018bc9cf4521mr12881246pzi.2.1702353851114;
        Mon, 11 Dec 2023 20:04:11 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id du6-20020a056a002b4600b006ce97bd5d04sm7362985pfb.140.2023.12.11.20.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:04:10 -0800 (PST)
Date: Tue, 12 Dec 2023 13:04:10 +0900 (JST)
Message-Id: <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, alice@ryhl.io, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZXfFzKYMxBt7OhrM@boqun-archlinux>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
	<20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
	<ZXfFzKYMxBt7OhrM@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 18:30:36 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Dec 12, 2023 at 10:46:50AM +0900, FUJITA Tomonori wrote:
>> On Mon, 11 Dec 2023 16:49:39 -0800
>> Boqun Feng <boqun.feng@gmail.com> wrote:
>> 
>> >> touch it (doesn't need to know anything about it). What safety comment
>> >> should be written here?
>> > 
>> > Basically, here Rust just does the same as C does in phy_read(), right?
>> > So why phy_read() is implemented correctly, because C side maintains the
>> > `(*phydev).mdio.addr` in that way. We ususally don't call it out in C
>> > code, since it's obvious(TM), and there is no safe/unsafe boundary in C
>> > side. But in Rust code, that matters. Yes, Rust doesn't control the
>> > value of `(*phydev).mdio.addr`, but Rust chooses to trust C, in other
>> > words, as long as C side holds the invariants, calling mdiobus_read() is
>> > safe here. How about 
>> > 
>> > // SAFETY: `phydev` points to valid object per the type invariant of
>> > // `Self`, also `(*phydev).mdio` is totally maintained by C in a way
>> > // that `(*phydev).mdio.bus` is a pointer to a valid `mii_bus` and
>> > // `(*phydev).mdio.addr` is less than PHY_MAX_ADDR, so it's safe to call
>> > // `mdiobus_read`.
>> 
>> I thought that "`phydev` is pointing to a valid object by the type
>> invariant of `Self`." comment implies that "C side holds the invariants"
>> 
> 
> By the type invariant of `Self`, you mean:
> 
> /// # Invariants
> ///
> /// Referencing a `phy_device` using this struct asserts that you are in
> /// a context where all methods defined on this struct are safe to call.
> 
> my read on that only tells me the context is guaranteed to be in a
> driver callback, nothing has been said about all other invariants C side
> should hold.

I meant that phydev points to a valid object, thus mdio and mdio.addr
do too. But after reading you phy_read() comment, I suspect that you
aren't talking about if mdio.addr points to valid memory or not. Your
point is about the validity of calling mdiobus_read() with mdio.addr?


>> Do we need a comment about the C implementation details like
>> PHY_MAX_ADDR? It becomes harder to keep the comment sync with the C
>> side because the C code is changed any time.
> 
> Well, exactly, "the C code is changed any time", I thought having more
> information in Rust helps people who is going to change the C side to
> see whether they may break Rust side. Plus it's the safety comment, you

The C side people read the Rust code before changing the C code? Let's
see. 


> need to prove that it's safe to call the function, the function is
> unsafe for a reason: there are inputs that may cause issues, and writing
> the safety comment is a process to think and double check.
> 
> Maybe we can simplify this a little bit, since IIUC, you just want to
> call phy_read() here, but due to that Rust cannot call inline C
> functions directly, hence the open-code. How about:

Yeah, I hope that the discussion about inline C functions would end
with a solution.


> // SAFETY: `phydev` points to valid object per the type invariant of
> // `Self`, also the following just minics what `phy_read()` does in C
> // side, which should be safe as long as `phydev` is valid.
> 
> ?

Looks ok to me but after a quick look at in-tree Rust code, I can't
find a comment like X is valid for the first argument in this C
function. What I found are comments like X points to valid memory.

