Return-Path: <netdev+bounces-45087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE29A7DADAC
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF5B281487
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38BA934;
	Sun, 29 Oct 2023 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaFQv5As"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10323CD;
	Sun, 29 Oct 2023 18:27:36 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811EBA;
	Sun, 29 Oct 2023 11:27:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d122e0c85so26203226d6.3;
        Sun, 29 Oct 2023 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698604054; x=1699208854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0w29tLzcU3o7houNr1+ekNf1N/WqfhYRmS5EqU9mfA=;
        b=jaFQv5As6kR7A9TPq7xpRD/kWQxHsxPGFKbNORnGenjBFDB2C2W11rIlwY+DihdhsC
         B9viTf20d2RKaUWwMt5GghEFrsyr+UNrbCZLcjqs+XqVE4o7PzaJxGufz5/9DxXTZCyW
         6Hs42Baw+w48pVvpAfkvGKcZPHBWtRQqr30KQp6rznVLdgCRSbRY36vSuXv1HCDvdold
         1p4A11hGIwuK5bH70BG7OuziQTvYYEiVytzevDX65Utew7W/ialCUxcEfnOLpI7WBwGg
         oMUiT2JGEI6lpua3wkrNeytpAwz0zcXT/fsjj2RzgcTLY+hfsfuqmsrICbggV/WeQQ1x
         qJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698604054; x=1699208854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0w29tLzcU3o7houNr1+ekNf1N/WqfhYRmS5EqU9mfA=;
        b=Lj76C3M8HdD3/g1gwI9jtTJc7mjRKg1ctGTj8bj5eYFw2qK5kKUExG+IPo7iwQgNtJ
         isKsIfk1Wf2k2rKvshkx/5jfCgDQEkpbs1bwzZF2AreAXU59X7xLGjalAsX6cYddmSTl
         xAdXJ3Hw94ClIfaWComU5/i6GC/cw3GFF4q7Fbl2OLfcrNBCq+ouf+pECyT3jI5E8o1T
         HUubjC9gOwE/AziVAW7IFNKmC0WMrPGONfI9vY/3McNdy7uSHcqmeW12tikjfbYvUj1O
         0dJ0BzMiATcFxwLI7enFE8I1mfpbh5DBG6o2glDfMNF9QKBmyBnxhnZTFH94/XuVRQyl
         cDtQ==
X-Gm-Message-State: AOJu0Yy8/4m8STnv2IYumB6+JmjvAPmdlTd+m0rFW9MtktsP4SYLuGmE
	Ly+5pfkfbPXUiOG9EObKxAA=
X-Google-Smtp-Source: AGHT+IE/oqd+XfDhPDurloyUSL7NUL85GR8swN9tH4VtXa6hJWJsdGPAbNHZ2VwwkhAwU/64dhDGCw==
X-Received: by 2002:ad4:5765:0:b0:66d:9d15:6876 with SMTP id r5-20020ad45765000000b0066d9d156876mr9858287qvx.65.1698604053806;
        Sun, 29 Oct 2023 11:27:33 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r29-20020a05620a03dd00b00767da9b6ae9sm2654529qkm.11.2023.10.29.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 11:27:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4169A27C0054;
	Sun, 29 Oct 2023 14:27:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 29 Oct 2023 14:27:33 -0400
X-ME-Sender: <xms:FKQ-ZaCnUXPGmSmSWc_Twotlk8h4VpDUpSzlBqtHiBKouCECmuq47A>
    <xme:FKQ-ZUg71AVYk7vFx9tp-NKHoOxYKmg4ZJp1gHAXDwL6V1HcHafX3mbeo1-NFyVBh
    WwPk8rX6ek8P8wk1Q>
X-ME-Received: <xmr:FKQ-ZdlFYDa2KyV7WRq8ZPAwKVAKCcH0SSaEbgiNsyuGo9ydgiwsGBgT3Uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:FKQ-ZYwfrnyUsWtoKiL_bTmQ4XbYUBiL2mkpvgEKvLVRziz0V70jpA>
    <xmx:FKQ-ZfT6zj9L8dIJBdoyABqxCbx7c6Vay33NEqY3Xtoblss_Z7H7bQ>
    <xmx:FKQ-ZTaubpIJCtcA1cMvnQiruLsD0rzgu_fQwkjz5J6MlqQtay_bzg>
    <xmx:FaQ-ZYQnY_KLrMjfqTbd9iXKk8jCQvqCJsMGru7zEcqcSQslC7y7Iw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 14:27:32 -0400 (EDT)
Date: Sun, 29 Oct 2023 11:26:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, andrew@lunn.ch, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZT6j3VVytki5SIh3@boqun-archlinux>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
 <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
 <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
 <ZT6fzfV9GUQOZnlx@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT6fzfV9GUQOZnlx@boqun-archlinux>

On Sun, Oct 29, 2023 at 11:09:17AM -0700, Boqun Feng wrote:
[...]
> Of course, it's not maintainable in longer term since it relies on
> hard-coding the bit offset of these bit fields. But I think it's best we
> can do from Linux kernel side.

Hmm.. I guess I should have added "other than creating EXPORTed C
accessors for these bit fields".

Regards,
Boqun

