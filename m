Return-Path: <netdev+bounces-53753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E798047AA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8681D280A1C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ABA8C05;
	Tue,  5 Dec 2023 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnSfD7zH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE6D5;
	Mon,  4 Dec 2023 19:40:57 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a8fb9d112so16852516d6.3;
        Mon, 04 Dec 2023 19:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701747656; x=1702352456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8D0kuebZPpR0JHy+0+65gGKqimRlrOIpzq4kI9dRzU=;
        b=AnSfD7zHToXw91w45kW2/QMjaKsepE+ti8nNlmFnpat/j+etLJkidyeRfQin4SvWXn
         zuq5sOZKC7410aS6vZRFO08ic/ILK6iQfobBtKi2HHdR2+z5gjEndXCKfcs4QKDLqwpt
         95heKGpPUuE59Zl/KVS8BU0FvYA54CLib2Z/ug6DP6/XCCddwc8g/a5aPgS2G7OjNlhM
         VD1ebvDsvBbw4u513B2fle9FhJbxP4+Vgq0ajoXJU1urqgG9pWFzdaVckOEHDInqvmUM
         nSqU6iTN1AJ6CaTQSDBgcsRNKAp7vE0pSfDqjriklqvJ0Jk4elBZxOzp4BOO64Ul5Vaw
         3fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701747656; x=1702352456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8D0kuebZPpR0JHy+0+65gGKqimRlrOIpzq4kI9dRzU=;
        b=H3eFccQt4shB6E682Eqz+W7CZDUo0ltHjsBFvSZZ0WaRjrb9ZzYsT3ArpQFx5yHlAS
         4/Ni3xLYq6VbRkF1t+FwXcVoe9Kpbxm3HS3nkwqFzhnblTrSuYySGNvm3hdvzb4/SI1V
         OrQq8yVfMCmfSwiHJci7jUnbWe1Munk3HKS83YQ4Lhqn4Nx1TxFK2N7NRVpfEH3OycR1
         HB3n+7A/2k0e2kSfZw/YmIM3O+c/anwhsUnw+IV68CtrX49Rlq5+PBT5Mypcr6Vefr2/
         ijjQ7I3sUUtR8cgzV5n3P/rDneabyWIi17pIjIk/KMoz+37Wi5tH7N4deWvEr2WFKwdv
         ko5w==
X-Gm-Message-State: AOJu0YzLKT7C+d1wSuRsuIuyXjannIArJoQeD++/OFq86vNRhVsSxQOS
	E3PuMJjN2+bVD3PsNC2byQ/vOZ9vIXQ=
X-Google-Smtp-Source: AGHT+IEFGlaceuewN/xvta1Dh259QQG7R5/YHiB3ycKECA2jYedcjp0qwlJMLNOrpb2z62SpyaIN5Q==
X-Received: by 2002:a05:6214:584a:b0:67a:a721:ec06 with SMTP id ml10-20020a056214584a00b0067aa721ec06mr538529qvb.74.1701747656424;
        Mon, 04 Dec 2023 19:40:56 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p8-20020a0cf548000000b0067abb99b73bsm2096523qvm.131.2023.12.04.19.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:40:56 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id AABB527C005B;
	Mon,  4 Dec 2023 22:40:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Dec 2023 22:40:55 -0500
X-ME-Sender: <xms:x5tuZTq047IuWnTQPG5nRuzQdGWMlh0yFS9OsfJSlyj8-H-aJjbx0g>
    <xme:x5tuZdr0TXghzlt3q01qTT8neEc30FNRsBLzB1x-i7RyoXelG_kqHiS_--oQZcN2q
    KjVjiTJtDIRx2qGiA>
X-ME-Received: <xmr:x5tuZQN1hf91mMz5l_CEQ4YAHj_3LOtRG8ZMa7TFabvi5B5mzGeoKKbvEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejjedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:x5tuZW7wmnBvWKn1WloIDPLBNqni9yvNQpFjwfpDQslVHhOBPlmnZQ>
    <xmx:x5tuZS73pmtSuf98-IMHkZbMCUl5mNXd19_kLzMwytNSPhU3JMyfag>
    <xmx:x5tuZegueRsGGA2Z_son_-DYTE2bcQHdpyI4sJfwzEDtsiIZzr1Z0Q>
    <xmx:x5tuZUuk10i6HfGPwK8xN2Tuw7YtSgFXeNtbZ0BcmT07XW-OtHJh4w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 22:40:55 -0500 (EST)
Date: Mon, 4 Dec 2023 19:40:53 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZW6bxfB-iuD9cjm_@Boquns-Mac-mini.home>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-2-fujita.tomonori@gmail.com>
 <ZW6EL-4XaoY3n4J9@Boquns-Mac-mini.home>
 <20231205.122320.1887043941025150953.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205.122320.1887043941025150953.fujita.tomonori@gmail.com>

On Tue, Dec 05, 2023 at 12:23:20PM +0900, FUJITA Tomonori wrote:
> On Mon, 4 Dec 2023 18:00:15 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Tue, Dec 05, 2023 at 10:14:17AM +0900, FUJITA Tomonori wrote:
> > [...]
> >> +    /// Gets the current link state.
> >> +    ///
> >> +    /// It returns true if the link is up.
> >> +    pub fn is_link_up(&self) -> bool {
> >> +        const LINK_IS_UP: u64 = 1;
> >> +        // TODO: the code to access to the bit field will be replaced with automatically
> >> +        // generated code by bindgen when it becomes possible.
> >> +        // SAFETY: The struct invariant ensures that we may access
> >> +        // this field without additional synchronization.
> >> +        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> >> +        bit_field.get(14, 1) == LINK_IS_UP
> > 
> > I made a mistake here [1], this should be:
> > 
> >     let bit_field = unsafe { &*(core::ptr::addr_of!((*self.0.get())._bitfield_1)) };
> >     bit_field.get(14, 1) == LINK_IS_UP
> > 
> > without `core::ptr::add_of!`, `*(self.0.get())` would still create a
> > temporary `&` to the underlying object I believe. `addr_of!` is the way
> > to avoid create the temporary reference. Same for the other functions.
> 
> If so, how about functions to access to non bit field like phy_id()?
> 
> pub fn phy_id(&self) -> u32 {
>     let phydev = self.0.get();
>     unsafe { (*phydev).phy_id }
> }

Good point, so cancel the above comment. I had a misunderstanding that a
place expression would create temporary references, but I was wrong.

Regards,
Boqun

