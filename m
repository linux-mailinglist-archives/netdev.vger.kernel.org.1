Return-Path: <netdev+bounces-57132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4F68123A5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794FD28262C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42679E28;
	Wed, 13 Dec 2023 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQKnLAme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C6895;
	Wed, 13 Dec 2023 15:59:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-425959f36b0so52403141cf.3;
        Wed, 13 Dec 2023 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702511968; x=1703116768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYra5w/r/a388chl9HuhR0ezkbtfhy2mUNlzedAqBok=;
        b=QQKnLAmer8JMmgJw+HU6vCDfBLgHQeQg1fz/JflbwaZWQkpMG/GhRbdSaUWdOL4CDe
         u65/nK10aqyrcIGGs+FGncFJvWkYpLeFPzODdqAdBjUGdAkmPtjyWY2806WtBapkGImI
         pYQOk2O1LQD/TgwCCdGFIaEPX8pxZt+o6Y0HEYDr7Lt4yMGDogipv3Df/ZU2X7+aVMdW
         9bhlozzryLlLwpZp5g1tHsyi+cAgKGQS5QxYD0Vg35ekea8yn2YKICa30dtBnxAVXN8G
         8qZ4EVX18djlSziA3kK0evPGNftRWE1tEBn7juF6uAH/9lX1ig0ZWp+UvLqHC2wJj8CJ
         Wjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702511968; x=1703116768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYra5w/r/a388chl9HuhR0ezkbtfhy2mUNlzedAqBok=;
        b=BYbkjA6oHQHuaptlg3djY4IftvoSyfTrbDi/R18IDbvSb+5XxpOQtrFYzPD5/IMsI5
         KmGA4Ek8rLT8dChyYg6hs2bFvK8jMciHQK9bBqpWtNpumHMMDnxdmkYr1tZqaA90Z5K3
         tD5XCYXBEsbL337Uc0/Fl3y5ZqwcixIeoJD/BhUvJpLB0Z6/ZY0hVv8OLNyuD28q6ai4
         1nBLGXG2nkRPCECpQ1oiBqP5z7uRPzsffClzS9xxFPBFnQIKL4xSFYtA+lGAPZgr66zd
         cneHLBPdG5zU0huohevfKIaZDkjWcLS2je2YjQOazhybXQ1coGE72rnkp0X2cwEp5LCv
         RtoA==
X-Gm-Message-State: AOJu0YyNviZEzQomRAuv8DjQ5lxcdiKT7KjqpkqMCpxiO5Y0ul+UTnoX
	mwhQAoaC6vmL3sYqqclH6hk=
X-Google-Smtp-Source: AGHT+IG7XTgIqX2a9++FlWH4qXBA64ASLTnm678lka+ktY7d1r0Y9rb/ZmNrUuFP9n9vOHRB12XKdw==
X-Received: by 2002:a05:622a:206:b0:423:93aa:1426 with SMTP id b6-20020a05622a020600b0042393aa1426mr12871641qtx.48.1702511967902;
        Wed, 13 Dec 2023 15:59:27 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j10-20020ac8550a000000b00424059fe96esm5288287qtq.89.2023.12.13.15.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:59:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 396B927C0054;
	Wed, 13 Dec 2023 18:59:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 Dec 2023 18:59:27 -0500
X-ME-Sender: <xms:X0V6ZcULb6kRZlnvnCiUmuduwfM7UqikkT5k4CyKXhViEILLKutjVg>
    <xme:X0V6ZQkdbeBm1XJzuSDt-7pNMrlqJ6M44TyCF5JcW8eIqGSOQZyouXYAXMKlJHfXw
    RMh46avD8ID828XUQ>
X-ME-Received: <xmr:X0V6ZQbLNyC-k9fII6TkwUp9BCTFSRaY9cpyeKmsWF9T6EHRdG7Gbs9EnO0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:X0V6ZbVBlHossFEaXQ-9uw5RKFjs0nIqqmnTSCqJ4ov9CELlOK5XYA>
    <xmx:X0V6ZWlcSClFsbAZmay-c4i3fKtoOhU6Kk1QSY4KDJh-JBqtGrubDA>
    <xmx:X0V6ZQdLiFYN-RzpdXHpTKr1DlSa7BxINVU33Y6MzXP4GfuxkUz3Uw>
    <xmx:X0V6Zbg5QQucyBjEWBrl6bAI6870-vmZ2QEE7NBllMczlAvrYFUuHQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 18:59:26 -0500 (EST)
Date: Wed, 13 Dec 2023 15:59:24 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXpFXMn7trT0cm6R@boqun-archlinux>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>
 <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>
 <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch>

On Wed, Dec 13, 2023 at 10:48:39PM +0100, Andrew Lunn wrote:
> > Well, a safety comment is a basic part of Rust, which identifies the
> > safe/unsafe boundary (i.e. where the code could go wrong in memory
> > safety) and without that, the code will be just using Rust syntax and
> > grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
> > boundaries, why do they try to use Rust? Unsafe Rust is harder to write
> > than C, and safe Rust is pointless without a clear safe/unsafe boundary.
> > Plus the syntax is not liked by anyone last time I heard ;-)
> 
> Maybe comments are the wrong format for this? Maybe it should be a

Maybe, but they are what we have right now. I do believe the unsafe <->
safe boundary in Rust needs better tooling: using comments may be a
little bit abitrary. However, let's stick to what we have right now.
Benno is actually working our Rust safety standard (feel free to correct
me if I get the name wrong), hopefully that helps.

> formal language? It could then be compiled into an executable form and
> tested? It won't show it is complete, but it would at least show it is
> correct/incorrect description of the assumptions. For normal builds it
> would not be included in the final binary, but maybe debug or formal
> verification builds it would be included?
> 

Good idea, we actually want something similar when we were talking about
Benno's safety standard, but as you may know a complete one would take
years, or maybe impossbile. Also, kernel's safety requirement sometimes
is weird and non-trivial, it's going to be a learning process ;-) A tool
is certainly what we would like to look into if we have more experience
in Rust abstraction and more time.

> > Having a correct safety comment is really the bottom line. Without that,
> > it's just bad Rust code, which I don't think netdev doesn't want either?
> > Am I missing something here?
> 
> It seems much easier to agree actual code is correct, maybe because it
> is a formal language, with a compiler, and a method to test it. Is
> that code really bad without the comments? It would be interesting to

Note that most of the comment reviews are on *safety* comments (type
invariants are related to safety comments). To me, in the review
process, safety comments are similar to commit logs. In kernel patch
reviews, we sometimes say "thanks for the explanation but please put
that in the commit log", that is, even we know the code is correct and
the patchset has been explained, we still want to see the explanation
written down somewhere. Commit logs are ways to explain "why do I want
to do this", and safety comments are ways to explain "why can I do the
following safely". They are both ways to communicate during the review
and for the future readers.

So is a patchset really bad without commit logs? ;-)

> look back and see how much the actual code has changed because of
> these comments? I _think_ most of the review comments have resulted in

I was trying to figure out the answer, but the patchset just has too
many versions.. and discussions were splitted between versions...

> changes to the comments, not the executable code itself. Does that
> mean it is much harder to write correct comments than correct code?
> 

If one can explain their code to others and make sure others understand
the correctness of the code, then the code is very likely correct. So
I think yes, writing correct comments is harder than correct code.

I admit the review process took a bit long because it's a learning
process for both developers and reviewers: being the first in-tree Rust
driver may not be that easy, please understand the high standard
expectation.

Regards,
Boqun

>        Andrew

