Return-Path: <netdev+bounces-44843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058327DA192
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267D21C21074
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E03DFF4;
	Fri, 27 Oct 2023 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo1spTKR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A06128;
	Fri, 27 Oct 2023 20:00:43 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17F1B6;
	Fri, 27 Oct 2023 13:00:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7788ebea620so180645985a.3;
        Fri, 27 Oct 2023 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698436839; x=1699041639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLT90tRb5HJaALohaE70MPpSJV6pYFxfWNdd1Rc8FiA=;
        b=Eo1spTKRDp4V32Lpb1ZduLbgjM8y9xJZK+zJV+daVLCGXs4cWrQPxb+fab4SbEfeDX
         X8T1NE/tfAVB8NNsO7QZ0AxaItyQ+XflZIAzvNItbbdQZmTrgCjN5N54aFnZNp8tr2uY
         /8rDJunZnP90PWulahTQKDj2DX4IMgjfIg/lqnGTb6RDh741826bQWl6gqbMIkOtLhCS
         s8gSs6H9yjHZHOTj9JQivvjnMpMXmtLhp7domnMQLqsyBgWqHa/OEuyvrK60X67qod4q
         wzGEJaXcT7aG/QftOAdnN+V4o43A7VK+380WUjsZsLBq6oEqfWbFo1xzFvBYPq0b4MB3
         VbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698436839; x=1699041639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLT90tRb5HJaALohaE70MPpSJV6pYFxfWNdd1Rc8FiA=;
        b=Fij/c8B0mNS8erRb/ZFLu9H7Ko7I12/sdJiXfqq96KSJpfLGWQQ779MFn2JkKO4yA+
         yTa1jlOLIKatPn/aPNdQYUF+s3u50kXRplaHmBy/zU3VDnxDWZMOTXDyRoCez7U0/9Vb
         nSfbgFxm8Bg0lxSBJuZF3xXfvI7v37KLIdj41fmCI9TRhlfO48ITLvLWvlHTwNs5quta
         35PWCgpatpR0BHw1huESy1s+iEDcVTi25Ywf07JH8zpthfjTl0vB7fntwIPcGWSURT7A
         lrVzsrWut84Z8VclphjaSu1NGdPY4REqNJPqnm8MsS/8tWHo8yKpc9kW7ZdRLaR+ktaT
         dQew==
X-Gm-Message-State: AOJu0YxxuS40qbdDgQKMKG218trqMxDusUu1xuTDjEuItbTDnAsidfy6
	uG2xmZh2B/iQCiLAdSHEq90=
X-Google-Smtp-Source: AGHT+IEQk0Pq5FzSYrvByDRJs5B+TpFsix7YoitI42mi24bqMX+nsqF7ZORheJ0Uyamr7b/wNGR7rQ==
X-Received: by 2002:a05:620a:40d2:b0:776:fad0:cc3b with SMTP id g18-20020a05620a40d200b00776fad0cc3bmr3954599qko.1.1698436838996;
        Fri, 27 Oct 2023 13:00:38 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a22d200b007671678e325sm835768qki.88.2023.10.27.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 13:00:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6DE3627C0054;
	Fri, 27 Oct 2023 16:00:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 16:00:35 -0400
X-ME-Sender: <xms:4hY8ZZUU77XBlTQF0_6PJBWBcXsusXfo9lkHlViVeARG5OBiIbNOtA>
    <xme:4hY8ZZm9m7rqojV24VhQAjknYS-II7Ue3823wMy4lYWv_bmKtBrymLTEAUb7YlNWW
    D9xGvec1Ormn7Rc7Q>
X-ME-Received: <xmr:4hY8ZVaIE89AUwuX1tBUTkUAKA_HgBRjKLGFlMXxTVJv-vG6jORUBU2R9vY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4xY8ZcW8-T83glCxnjZgl9SPrQYFD9q0TzYSNGl8ilQUWO5psK1coQ>
    <xmx:4xY8ZTkizrTqXJU7ab__p5OFSMAN_LvYoSrfihvttvYdp9SlJZPAqw>
    <xmx:4xY8ZZdk9qnqsIAkDCR3F1kvAk2xywCm0UCVIdfYwBc-wrwtgdNWhg>
    <xmx:4xY8ZRXgw9Ra4PouMbkWEwYry7ZfzSoiGqFrr5ALwBkMwJJEiaOHAQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 16:00:34 -0400 (EDT)
Date: Fri, 27 Oct 2023 12:59:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZTwWse0COE3w6_US@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026001050.1720612-2-fujita.tomonori@gmail.com>

On Thu, Oct 26, 2023 at 09:10:46AM +0900, FUJITA Tomonori wrote:
[...]
> +    /// Gets the current link state.
> +    ///
> +    /// It returns true if the link is up.
> +    pub fn is_link_up(&self) -> bool {
> +        const LINK_IS_UP: u32 = 1;
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        let phydev = unsafe { *self.0.get() };

Tomo, FWIW, the above line means *copying* the content pointed by
`self.0.get()` into `phydev`, i.e. `phydev` is the semantically a copy
of the `phy_device` instead of an alias. In C code, it means you did:

	struct phy_device phydev = *ptr;

Sure, both compilers can figure this out, therefore no extra copy is
done, but still it's better to avoid this copy semantics by doing:

	let phydev = unsafe { &*self.0.get() };

it's equal to C code:

	struct phy_device *phydev = ptr;

Ditto for is_autoneg_enabled() and is_autoneg_completed().

Regards,
Boqun

> +        phydev.link() == LINK_IS_UP
> +    }
> +
> +    /// Gets the current auto-negotiation configuration.
> +    ///
> +    /// It returns true if auto-negotiation is enabled.
> +    pub fn is_autoneg_enabled(&self) -> bool {
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        let phydev = unsafe { *self.0.get() };
> +        phydev.autoneg() == bindings::AUTONEG_ENABLE
> +    }
> +
> +    /// Gets the current auto-negotiation state.
> +    ///
> +    /// It returns true if auto-negotiation is completed.
> +    pub fn is_autoneg_completed(&self) -> bool {
> +        const AUTONEG_COMPLETED: u32 = 1;
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        let phydev = unsafe { *self.0.get() };
> +        phydev.autoneg_complete() == AUTONEG_COMPLETED
> +    }
[...]

