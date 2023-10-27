Return-Path: <netdev+bounces-44939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34EA7DA415
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2793B214EC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFACE3FE26;
	Fri, 27 Oct 2023 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7ODx2m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498653FB00;
	Fri, 27 Oct 2023 23:27:47 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46261C2;
	Fri, 27 Oct 2023 16:27:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6934202b8bdso2593207b3a.1;
        Fri, 27 Oct 2023 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698449265; x=1699054065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpAhr4zamMyGLCVpG4M5/2VF+niJFUPKlaEUgDB55GA=;
        b=SI7ODx2mH8LOXrJ4Bb6sgcEzvmqTG3W38zEllWCJfZMrPWEBuUgH9K3BXKXFvCHY1E
         wRO10csXAYOJua1rmiO1sWE6PnJRcLc8tnMUqQop0bjL4/zBVPagILk62dS4H8JMJCx3
         Ni75bA+Kl1xbGDvzAzIXt/3dJNyaiBdiUNEzoQziaaFRuARZVygok/Rfn3MF4H8mnRjj
         Qk6jpZACNuLPuLxBioa1PUNQDWYvfX4LqawgSWnAhN4XBppyXchrTsYENw+2K5AA4Z6L
         La53N+xuxXAHcOs1wKnh2fpwCSDhN/VW66oyAnJF8NZCvc4ELRTq7t4tZh9yTwLrH/8v
         g0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698449265; x=1699054065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpAhr4zamMyGLCVpG4M5/2VF+niJFUPKlaEUgDB55GA=;
        b=OjXqY9sXy+DGk7kEM3tGfzsGQlKBb2UPKS1Jihz5gpXDKXemUnLhSZ9zhDcrYrGzNU
         Vnx2S/6GPEs5Op3EXqIeuxZERwS3RNVdmqI0QuYOPchOOnI0t3dAruaF2rcmcdAL2VwW
         Ns1f8dnok1YBbKZg8YvmX9LSVFprQYdH3X4HJ5b4Aew+6lKia7tHN3QhZ60dcUJvovro
         su2p0pM898mqTmxIOPYXDBx9xRf7bPyjII8/3yWyfqPKCTQKO7OgndVjSuuUahWPYZsQ
         3MQd6O+PZsp7nuR8V+RzcuQpdZF3nmo4p62emHDqJUmsfugMslu0fXt5fg5DoP+6Qp28
         a5ow==
X-Gm-Message-State: AOJu0YwaCAqtoHrNkudz5A33Qx0mfI5tvbql7Hf2gYiLRVE19qIuET8b
	rJMzTtb3M4zxTWXvy55liOLIplAynMo=
X-Google-Smtp-Source: AGHT+IGoOkWNEkeA7tRVN1FPHHu4DaFgT/HO5w3DayVg4mr2MPgY2fmjLoQnapvRMiVimZZGn0Qk5g==
X-Received: by 2002:a05:620a:2890:b0:76d:93e1:99fd with SMTP id j16-20020a05620a289000b0076d93e199fdmr4295197qkp.11.1698449243911;
        Fri, 27 Oct 2023 16:27:23 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d10-20020a05620a158a00b00774292e636dsm994430qkk.63.2023.10.27.16.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 16:27:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2014927C0054;
	Fri, 27 Oct 2023 19:27:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 27 Oct 2023 19:27:23 -0400
X-ME-Sender: <xms:Wkc8ZXgdymcHCLJZ-wuIf8mvD1eJZJyD-WT7jlQCj8TV80y898IoPQ>
    <xme:Wkc8ZUB4Hkr9AXU3UjYcT5hUbweYi5eTKF3rCj8upiiQzSFD1p0eUl1K89e3Z-oQa
    8utwstijpIvmvyg-g>
X-ME-Received: <xmr:Wkc8ZXELY0EcOsX4eKEKLjQg-xwPLe5o98AHFQHZ1CFbdUNbOEDF4GUExbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeffheetffdvveevuefgfeejkefgledvvdevvdetteekffefffeffefgfeei
    hfdtnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhgohgusgholhhtrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgv
X-ME-Proxy: <xmx:Wkc8ZUTRgqIbrRE35hTCbCY1pyaCHZO-A9CSNihEU1pvSj61CxADHQ>
    <xmx:Wkc8ZUz2qdiFAdZ_hCHEjx5UTFzgqP5Ulkj3al2uV4dBzeLV_eM8Hg>
    <xmx:Wkc8Za7CnGoaPEQPS8REpuOjkPv12ou6g2QRXfISaK9-9tBLQ2Yt4A>
    <xmx:W0c8ZXySFn6xjUto3puSrZNUpLlEDqQcZKBm6q75XaUZCjcwY-nyIA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 19:27:22 -0400 (EDT)
Date: Fri, 27 Oct 2023 16:26:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZTxHKCWTAA7T-MJd@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <ZTw3_--yDkJ9ZwIP@boqun-archlinux>
 <77c78010-781e-4eb4-a7ba-3e9f9a07bf67@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c78010-781e-4eb4-a7ba-3e9f9a07bf67@proton.me>

On Fri, Oct 27, 2023 at 10:50:45PM +0000, Benno Lossin wrote:
[...]
> > 
> > Hmm... but does it mean even `set_speed()` has the similar issue?
> > 
> > 	let phydev: *mut phy_device = self.0.get();
> > 	unsafe { (*phydev).speed = ...; }
> 
> No that should be fine, take a look at the MIR output of the following 
> code [1]:
> 
>     struct Foo {
>         a: usize,
>         b: usize,
>     }
>     
>     fn foo(ptr: *mut Foo) {
>         unsafe { (*ptr).b = 0; }
>     }
>     
>     fn bar(ptr: *mut Foo) {
>         unsafe { (&mut *ptr).b = 0; }
>     }
> 
> Aside from some alignment checking, foo's MIR looks like this:
> 
>     bb1: {
>         ((*_1).1: usize) = const 0_usize;
>         return;
>     }
> 
> And bar's MIR like this:
> 
>     bb1: {
>         _2 = &mut (*_1);
>         ((*_2).1: usize) = const 0_usize;
>         return;
>     }
> 
> [1]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=f7c4d87bf29a64af0acc09ff75d3716d
> 
> So I think that is fine, but maybe Gary has something else to say about it.
> 

Well when `-C opt-level=2`, they are the same:

	https://godbolt.org/z/hxxo75YYh

Regards,
Boqun

