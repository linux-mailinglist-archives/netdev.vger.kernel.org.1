Return-Path: <netdev+bounces-38605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AE47BBA46
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C364280DBE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4078C15AF4;
	Fri,  6 Oct 2023 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kuj+4wnn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCEC26E0D;
	Fri,  6 Oct 2023 14:30:57 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DCD6;
	Fri,  6 Oct 2023 07:30:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69361132a60so439686b3a.1;
        Fri, 06 Oct 2023 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696602656; x=1697207456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0VsJJBDF3+U7XrumLQnlE/99arpPJYvGpzNWrljfp0=;
        b=Kuj+4wnnKESRZ6NpOlo7yFN4tAfLWrQldvXpG6OFtopzTpesr2fxhLImAbKxzisQWH
         2OGg8hxuA4MunBgj3LkiIFNsaH0rYH7bFYk8/glEkskXfvmnWL+mxs8g7cMSqYVO9LUq
         G5CxRdjuliYJKQBFcgNsLxeRszeqWUSHNOG4xhpfAMRIM5Zmia6px/hLfuEQBObx+Hnr
         Ak1aPWMZg8M6DN8RYtn4r+lzjULkyX4b7am6vMOCeUaEx9x4OYzG0YhkUpwgIelenbsn
         jZSQzyXZipw7YCa3awuvaMo8E82arcDRxfNdQOlDNiNq6jkMJSFYQ8UyTU9OG28kRqH1
         e1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696602656; x=1697207456;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I0VsJJBDF3+U7XrumLQnlE/99arpPJYvGpzNWrljfp0=;
        b=fUX5kqFYWIFwaWJUb+52fiFTZq5SoFKIuzLe4n8MA2+JIF9BI+CECCV1mFquIGt041
         j97CuJVYhScRbf02/jjrjHglzajPS6aGTS/UElLPhFTf+UXyoVtRNvXeiG/92fb+Q1Ru
         3v6gODKrXwDOFWSF6x0K2TbePPiBkN5gLWnNG4QyQii7AI7CsGOI2h2OHpxFQwaS1jc9
         yVM2l+UPVcsS1+czTqkmEBIy1fx7h80e0H3razFljW5BL1sq2NXCCjzg2GlwSX7+W33U
         eC1LhnAKpQLibKra2pv49+qpK0qcSNmIL1vPh3shWJlQBq1/64mp7B5d2/mQwkB2dgs2
         +twg==
X-Gm-Message-State: AOJu0Yz0d9fHPcOq7mJF4CVtImx8WyZjGLVQK+A1s5ogNKKvSL+w20tr
	whBzd6XT80MisAP51H15tJw5sXz4AFdHOFh9
X-Google-Smtp-Source: AGHT+IGOR2WMRn9sJtwNCxw6wfQ7Iw8lms8t11f8Aq4zg5lrAfgU0g6b6QR4wuFnSX0JFSbRAdBxVA==
X-Received: by 2002:a05:6a00:1d22:b0:693:38c5:4d6d with SMTP id a34-20020a056a001d2200b0069338c54d6dmr8841224pfx.2.1696602655583;
        Fri, 06 Oct 2023 07:30:55 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00578afd8e012sm2982624pgp.92.2023.10.06.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 07:30:55 -0700 (PDT)
Date: Fri, 06 Oct 2023 23:30:54 +0900 (JST)
Message-Id: <20231006.233054.318856023136859648.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2023100637-episode-espresso-7a5a@gregkh>
References: <2023100635-product-gills-3d7e@gregkh>
	<20231006.225325.1176505861124451190.fujita.tomonori@gmail.com>
	<2023100637-episode-espresso-7a5a@gregkh>
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

On Fri, 6 Oct 2023 16:12:24 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 06, 2023 at 10:53:25PM +0900, FUJITA Tomonori wrote:
>> On Fri, 6 Oct 2023 12:31:59 +0200
>> Greg KH <gregkh@linuxfoundation.org> wrote:
>> 
>> > On Fri, Oct 06, 2023 at 06:49:11PM +0900, FUJITA Tomonori wrote:
>> >> +config AX88796B_RUST_PHY
>> >> +	bool "Rust reference driver"
>> >> +	depends on RUST && AX88796B_PHY
>> >> +	default n
>> > 
>> > Nit, "n" is always the default, there is no need for this line.
>> 
>> Understood, I'll remove this line.
>> 
>> >> +	help
>> >> +	  Uses the Rust version driver for Asix PHYs.
>> > 
>> > You need more text here please.  Provide a better description of what
>> > hardware is supported and the name of the module if it is built aas a
>> > module.
>> > 
>> > Also that if you select this one, the C driver will not be built (which
>> > is not expressed in the Kconfig language, why not?
>> 
>> Because the way to load a PHY driver module can't handle multiple
>> modules with the same phy id (a NIC driver loads a PHY driver module).
>> There is no machinism to specify which PHY driver module should be
>> loaded when multiple PHY modules have the same phy id (as far as I know).
> 
> Sorry, I know that, I mean I am pretty sure you can express this "one or
> the other" type of restriction in Kconfig, no need to encode it in the
> Makefile logic.
> 
> Try doing "depens on AX88796B_PHY=n" as the dependency for the rust
> driver.

You meant the following?

config AX88796B_PHY
	tristate "Asix PHYs"
	help
	  Currently supports the Asix Electronics PHY found in the X-Surf 100
	  AX88796B package.

config AX88796B_RUST_PHY
	bool "Rust reference driver"
	depends on RUST && AX88796B_PHY
	default n
	help
	  Uses the Rust version driver for Asix PHYs.


The problem is that there are NIC drivers that `select
AX88796B_PHY`. the Kconfig language doesn't support something like
`select AX88796B_PHY or AX88796B_RUST_PHY`, I guess.

