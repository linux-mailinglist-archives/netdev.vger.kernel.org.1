Return-Path: <netdev+bounces-56580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A0680F7D0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617821C20D76
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9563C0A;
	Tue, 12 Dec 2023 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axBLLxMs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B5BC;
	Tue, 12 Dec 2023 12:23:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f3c4914e5so327120585a.3;
        Tue, 12 Dec 2023 12:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702412592; x=1703017392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCVLdru56606T/bvfNBWEfIFy8x19c4eYR1JGDpQ2Q0=;
        b=axBLLxMsHPKkID13NYZkT+5KNQsk4tkoiT5pa2O+Ow5xR6tyjTuiplaKh+kNcKR4Pg
         t2He6Iwr+eQXAqjHOVM8/hVSirbnuc0sH4eokyJ8rcti4bX7U2tO+UBvP2RmtpLsQzNl
         fWyzhLEP9N0tisxwDuuqLR1cYgGQqRn/g+cO5NBmw/3Rw2RtRC9c438rEb5GO/NCAuBj
         t3leP1zTgvN4ytr0jQ/QW5EXWmQlfiLSyolWNOlju8+I8kD+FPnhxjPS4ikemZLGULxP
         TcM0K07i4syscgRF6Zxwqash3AK5xsMRCgHyFoc6g2SH6g2yy59Ik0IlleiSOw7f6ZIj
         XSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412592; x=1703017392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCVLdru56606T/bvfNBWEfIFy8x19c4eYR1JGDpQ2Q0=;
        b=jjPbJkSJvGIZwNWK9eXzt1w5vjalQO396d+NiSsJ7VAWhVYNI7cT5pBmDPx2YraFXW
         OO1I0v1817utBtj8QZxoqWNtHwFFqz2wVzOyty0nkBDuRZX2QD8o6bYUTMCU/zu/6632
         YInQWw8XT7k4zb0TzLTApKmlhQiAKqPubwO3xVAXEuDbBM5dim3wA2I8/t3erVqGTsH/
         Ks9iUmxAVVKghjjjpX6oEHXPT5DUEAiqlCBN3K1Wvnk/DQ4oGIh3COw+Gc9HJHHHrQty
         +IY/RVIbEE5YK+VRhjwG6J2aimg9Jd9V+ASCaCmabJ+D9BRpYmL2ipGvTr72+/cp+Rxl
         bt+g==
X-Gm-Message-State: AOJu0YzXJIaI7PP+cd+SfEH99nSm9N2V5oTlb6NPjJ0j3CwH+URKCTS1
	nLOHlgimmI9NT+zyXhPq0Ig=
X-Google-Smtp-Source: AGHT+IES5lw/tuyKPN4dpRMv68oRpZFq1IyKrLCrP6IkQVvdO7lnebrU+bIaIkbHwZxMZvfN/Sbv8A==
X-Received: by 2002:a05:620a:121b:b0:77f:3850:9d27 with SMTP id u27-20020a05620a121b00b0077f38509d27mr8170405qkj.46.1702412591957;
        Tue, 12 Dec 2023 12:23:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a04cb00b0077f529e7d23sm2526120qks.29.2023.12.12.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:23:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2D38027C0054;
	Tue, 12 Dec 2023 15:23:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 15:23:11 -0500
X-ME-Sender: <xms:LsF4ZeBfmyhmtMPpKJaV1XHOsgrPWwIqCzMLtxAaByb3vqdi-DMkWg>
    <xme:LsF4ZYguwcwjx6dAjZmvREwrRmuCLOzEUP8COWImef-tfiTDMNRfqCSJJYdX0x6J-
    knX2XJrDvBHXOtItg>
X-ME-Received: <xmr:LsF4ZRlYz4qHyQL3yQtpao6zAeFtVyikJW919URzHKTM1EYi7Hw12PVJ7IusRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:LsF4ZcxkXo2qevvu4HtmQ-hEN1OXXqXdOmt6TpZ3t5U25W_O3pYF_w>
    <xmx:LsF4ZTT3ExAdcXFGTBYSW-pAvvPZ-Ux-ki-U9ZcY5nL2pbxjX44vbw>
    <xmx:LsF4ZXaVb0W5RWt1Vzi4knVMZbS2SqCaBJ8zmnG7ilt_qZnEKxRVCg>
    <xmx:L8F4ZY9QRuuu8AELMGKv1zEVUWAMzhBBLoD9k8EtvTmsdeOtf3gARQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 15:23:10 -0500 (EST)
Date: Tue, 12 Dec 2023 12:23:04 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXjBKEBUrisSJ7Gx@boqun-archlinux>
References: <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com>
 <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>

On Tue, Dec 12, 2023 at 05:35:34PM +0000, Benno Lossin wrote:
> On 12/12/23 14:02, FUJITA Tomonori wrote:
> > On Mon, 11 Dec 2023 22:11:15 -0800
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> >>>> // SAFETY: `phydev` points to valid object per the type invariant of
> >>>> // `Self`, also the following just minics what `phy_read()` does in C
> >>>> // side, which should be safe as long as `phydev` is valid.
> >>>>
> >>>> ?
> >>>
> >>> Looks ok to me but after a quick look at in-tree Rust code, I can't
> >>> find a comment like X is valid for the first argument in this C
> >>> function. What I found are comments like X points to valid memory.
> >>
> >> Hmm.. maybe "is valid" could be a confusing term, so the point is: if
> >> `phydev` is pointing to a properly maintained struct phy_device, then an
> >> open code of phy_read() should be safe. Maybe "..., which should be safe
> >> as long as `phydev` points to a valid struct phy_device" ?
> > 
> > As Alice suggested, I updated the comment. The current comment is:
> > 
> > // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > // So it's just an FFI call.
> > let ret = unsafe {
> >     bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
> > };
> 
> I still think you need to justify why `mdio.bus` is a pointer that you
> can give to `midobus_read`. After looking at the C code, it seems like
> that the pointer needs to point to a valid `struct mii_bus`.
> This *could* just be an invariant of `struct phy_device` [1], but where
> do we document that?

Yeah, it's better if we call it out in the type invariant.

> 
> We could make an exception here and treat this differently until bindgen
> can handle the `static inline` functions, but I am not so sure if we
> want to have this as a general pattern. We need to discuss this more.
> 

Agreed, here my latest suggestion was definitely a workaround.

> 
> [1]: Technically it is a combination of the following invariants:
> - the `mdio` field of `struct phy_device` is a valid `struct mido_device`
> - the `bus` field of `struct mdio_device` is a valid pointer to a valid
>   `struct mii_bus`.
> 
> > If phy_read() is called here, I assume that you are happy about the
> > above comment. The way to call mdiobus_read() here is safe because it
> > just an open code of phy_read(). Simply adding it works for you?
> > 
> > // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > // So it's just an FFI call, open code of `phy_read()`.
> 
> This would be fine if we decide to go with the exception I detailed
> above. Although instead of "open code" I would write "see implementation
> of `phy_read()`".
> 

So the rationale here is the callsite of mdiobus_read() is just a
open-code version of phy_read(), so if we meet the same requirement of
phy_read(), we should be safe here. Maybe:

	"... open code of `phy_read()` with a valid phy_device pointer
	`phydev`"

?

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 

