Return-Path: <netdev+bounces-37548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4307B5E42
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 02:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A6000B20920
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD1E365;
	Tue,  3 Oct 2023 00:33:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF4362;
	Tue,  3 Oct 2023 00:33:42 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B1A9;
	Mon,  2 Oct 2023 17:33:40 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd2e4f744dso67217fac.0;
        Mon, 02 Oct 2023 17:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696293219; x=1696898019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjPps4IJ0xAV70lz5VbzxRHGgH9nB+2XLESToe1Zof0=;
        b=Cnja5Mba/obN944K1yd7ZxJX+ld5/6OBxA4BDPaOhu8Ys5DZSvAxgbRHO0BQA66Vmg
         Ew2JbJeVeP/T4q9YjN5dxOLJv2uIa7KdREEOgX4POkuxhU/37xZd+tPi+gZXJTNFn8Xi
         E90HxXAgyFijU7c2rnX9XEZyFh+2Bu43k8IOBvSipFzZ8LVxT+PoExMSIgrwWivDCBZz
         7E1clvqCYTRKfL+iqB7RDqHmoivtOHwLq4KMsW0OLXDlDZaI8Itg1eu1FcJB0rik83bn
         r2tokyVfD8+5KfMwy4hSvv7yw7ZJCkGX4+gFY25u3N425N0EP0ayuEHp6gURisVWLdYG
         xeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293219; x=1696898019;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjPps4IJ0xAV70lz5VbzxRHGgH9nB+2XLESToe1Zof0=;
        b=giTtbdJZamfxhd37HTsN3IltvXx0XKsqphD8/74L/hu+HdIT/9n+ZjqkEdNjNqcxWD
         abewisDc9Z8H9r7kcDF534EJ6+QYVv9ZogIxZe1P9VwlJuC7LpK6TuSMta5NTA+h0K+v
         H8MNeOlvngMRCTamCxIJacwhMSkr+QjfMKen7Bv8Sjg4ZYQKL+xNeM8ka9osIloTuVpl
         fW9yxzHt7X9mK+Z6/i82XYS5RCjwj9TCxjwndwQHI1ktPCoyXmYwvHPXyr+B+SGlD+Sw
         nMxNVOlY4CMqJlFObYxtPhNy8VOCaxUgX0kJO/X1R3x//zPMkc/7mPqQM9c+Arkkmmzn
         oGOg==
X-Gm-Message-State: AOJu0YydBKqpY34My0J4Lg+cJ/KebWI0+OsUAlBLfq+LKo6GlGAb2W+H
	UOUkn33+TnCn0dHqhJdcO9zFStkUijE5Tq/9
X-Google-Smtp-Source: AGHT+IHPLpBGRMYGI2mY040LGMmA73TypqTVd3TUtcB7a38NxpLVqcLXfmHTPyJhLOdUczfa31fOyw==
X-Received: by 2002:a05:6870:230e:b0:1dd:7f3a:b898 with SMTP id w14-20020a056870230e00b001dd7f3ab898mr13438925oao.5.1696293219172;
        Mon, 02 Oct 2023 17:33:39 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id v11-20020a63b64b000000b00528db73ed70sm53036pgt.3.2023.10.02.17.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:33:38 -0700 (PDT)
Date: Tue, 03 Oct 2023 09:33:38 +0900 (JST)
Message-Id: <20231003.093338.913889246531201639.fujita.tomonori@gmail.com>
To: andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ec65611a-d52a-459a-af60-6a0b441b0999@lunn.ch>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
	<20231002085302.2274260-2-fujita.tomonori@gmail.com>
	<ec65611a-d52a-459a-af60-6a0b441b0999@lunn.ch>
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

On Mon, 2 Oct 2023 16:52:45 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> +//! Networking.
>> +
>> +#[cfg(CONFIG_PHYLIB)]
> 
> I brought this up on the rust for linux list, but did not get a answer
> which convinced me.

Sorry, I overlooked that discussion.


> Have you tried building this with PHYLIB as a kernel module? 

I've just tried and failed to build due to linker errors.


> My understanding is that at the moment, this binding code is always
> built in. So you somehow need to force phylib core to also be builtin.

Right. It means if you add Rust bindings for a subsystem, the
subsystem must be builtin, cannot be a module. I'm not sure if it's
acceptable.


> Or you don't build the binding, and also don't allow a module to use
> the binding.

I made PHY bindings available only if PHYLIB is builtin like the
following. However, we want modularity for Rust support, fully or
partially (e.g., per subsystem), I think.

Miguel, I suppose that you have worked on a new build system. It can
handle this problem?


diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index e4d941f0ebe4..a4776fdd9b6c 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -110,6 +110,7 @@ config AX88796B_PHY
 config AX88796B_RUST_PHY
 	bool "Rust reference driver"
 	depends on RUST && AX88796B_PHY
+	depends on PHYLIB=y
 	default n
 	help
 	  Uses the Rust version driver for Asix PHYs.
diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
index b49b052969e5..da988d59b69d 100644
--- a/rust/kernel/net.rs
+++ b/rust/kernel/net.rs
@@ -2,5 +2,5 @@
 
 //! Networking.
 
-#[cfg(CONFIG_PHYLIB)]
+#[cfg(CONFIG_PHYLIB = "y")]
 pub mod phy;


