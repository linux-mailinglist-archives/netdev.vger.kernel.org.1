Return-Path: <netdev+bounces-38712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097197BC323
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9561C2094D
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C047356;
	Fri,  6 Oct 2023 23:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPEKTiCd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9745F49;
	Fri,  6 Oct 2023 23:54:04 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B4BF;
	Fri,  6 Oct 2023 16:54:02 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bc57401cb9so571867a34.0;
        Fri, 06 Oct 2023 16:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696636442; x=1697241242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpeFgirA9CAmdAoOjFBO59NuXFHrFxJjbPS/j6n9erE=;
        b=iPEKTiCdh9im4Uv2LrLUivVeimTEF3cK3e6yQ9Cl5pa77/eDy1iPE4d3Iwf+JVG/Qm
         psCitAbmbi/Kj9ZFVfL4TiKUgaNh503KzMmLAtQYSHeSCzJ+DOOzlGEUfQ2yqBVvvn50
         o7wSOMvdVVeOnDmwlYA24CnoMFiI1Y5d5BjbmTOwR2Z/hFRciYZ5p6gBPwMf5ffr8pzU
         bXI6YEv5eXuU+ACesuldv6WEuC1WIGjUYyHsmS9vIBN+gMLvQgh9Q2k6NkUjO5/bgSB+
         MOMnfQHvKAqdU1EnUvW9ZNkJo2c0t+JGXVio31MvfAEuNzp8DAoVPtrLaUxexjUpdwIl
         DSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696636442; x=1697241242;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpeFgirA9CAmdAoOjFBO59NuXFHrFxJjbPS/j6n9erE=;
        b=NrtxVj3SZrTnbgAsSw89Bz9wAKVQF8LKm95gAFoPXVq5P4kOCdDo9DTc6/gJ7dq8rR
         G/AZpNyOOrvZ/df/eAF1LU2sj7VmP1jnlMP0236NBILa82CDVP/n+uGrbbaztRfzMM6R
         0IKx50PwToGERmvsFnv6bRMx0FyhMBWw1/3nHOF6aKH3z3OS+biC4G6ffGxf0PXj+udv
         BFDhWaerDOdkG8AX2NnFNN3WU35EMdOIibwwad9RWSXwDbEPMXOK/cJmeH64plNBwRnt
         YYnLkBOZTHjOW55OeatPaDd3Y4Q+/9TEt0xnGmJ6IOuKQy6LR6/9PJSdPJpSspmi7uV/
         vQfA==
X-Gm-Message-State: AOJu0YzuuPbQPbIMmSH2ju4cFtbUWRzBtkDGFBAXVp8Yw0axwSfmDbQj
	VWqNq5oCIFa82/DOzXgUC/I=
X-Google-Smtp-Source: AGHT+IERv5CBqsCrZsSeIVD3UgEVn3ZyOALMXIqtYf4E8XP/yWOns8MrGG/ytOvhhGyEq0R6iyTLnQ==
X-Received: by 2002:a05:6358:e91c:b0:143:6813:bffa with SMTP id gk28-20020a056358e91c00b001436813bffamr8356182rwb.0.1696636442068;
        Fri, 06 Oct 2023 16:54:02 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id t5-20020a63b705000000b005776aeea638sm3457073pgf.21.2023.10.06.16.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 16:54:01 -0700 (PDT)
Date: Sat, 07 Oct 2023 08:54:00 +0900 (JST)
Message-Id: <20231007.085400.1040380280563980814.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <a8625fd5-6083-4a4d-872a-c755c214b891@lunn.ch>
References: <3db1ad51-a2a0-4648-8bc5-7ed089a4e5dd@lunn.ch>
	<20231007.012100.297660999016269225.fujita.tomonori@gmail.com>
	<a8625fd5-6083-4a4d-872a-c755c214b891@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 6 Oct 2023 18:55:23 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> How about adding CONFIG_RUST_PHYLIB to the first patch. Not
>> selectable, it's just a flag for Rust PHYLIB support.
> 
> We have to be careful with names. To some extent, CONFIG_PHYLIB means
> the core of phylib. So it could be that CONFIG_RUST_PHYLIB means the
> core of phylib written in rust? I doubt that will ever happen, but we
> are setting a naming scheme here which i expect others will blindly
> cut/paste. What we actually want is a symbol which represents the Rust
> binding onto the phylib core. So i think it should have BINDING, or
> WRAPPER or something like that in the name.

Good point. Let's save CONFIG_PHYLIB for someday.


>> diff --git a/init/Kconfig b/init/Kconfig
>> index 4b4e3df1658d..2b6627aeb98c 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1889,7 +1889,7 @@ config RUST
>>  	depends on !GCC_PLUGINS
>>  	depends on !RANDSTRUCT
>>  	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
>> 	depends on PHYLIB=y
>> +	select RUST_PHYLIB
> 
> I know the rust build system is rather limited at the moment, but is
> this required? Is it possible to build the rust code without the
> phylib binding? Can your `RUST_PHYLIB` add phylib.rs to a Makefile
> target only if it is enabled?

A short-term solution could work, I think.

config RUST
	bool "Rust support"
	depends on HAVE_RUST
	depends on RUST_IS_AVAILABLE
	depends on !MODVERSIONS
	depends on !GCC_PLUGINS
	depends on !RANDSTRUCT
	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
	select CONSTRUCTORS
	help
	  Enables Rust support in the kernel.

	  This allows other Rust-related options, like drivers written in Rust,
	  to be selected.

	  It is also required to be able to load external kernel modules
	  written in Rust.

	  See Documentation/rust/ for more information.

	  If unsure, say N.

config RUST_PHYLIB_BINDING
	bool "PHYLIB bindings support"
	depends on RUST
	depends on PHYLIB=y
	help
          Adds support needed for PHY drivers written in Rust. It provides
          a wrapper around the C phlib core.


Then we can conditionally build build the PHYLIB bindings.

diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index fbb6d9683012..33fc1531a6c0 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -2,4 +2,5 @@

 //! Networking.

+#[cfg(CONFIG_RUST_BINDINGS_PHYLIB)]
 pub mod phy;


A long-term solution is under discussion.

https://lore.kernel.org/rust-for-linux/20231006155739.246381-1-yakoyoku@gmail.com/

