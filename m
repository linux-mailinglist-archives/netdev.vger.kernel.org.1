Return-Path: <netdev+bounces-49550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B47F25B2
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DF2281611
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF81BDFB;
	Tue, 21 Nov 2023 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef3YhIGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4964797;
	Mon, 20 Nov 2023 22:19:41 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so1149775a91.1;
        Mon, 20 Nov 2023 22:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700547581; x=1701152381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWOiLbKGqCq+xWn1zmNhxuIAfXKxVirff8sSyPojC7s=;
        b=ef3YhIGP2LkU+G++nzL2RkaxU0Na1j+tdA7vtO9JOZ+oFRr3hpwlPa7cb9iahuzCfQ
         XVjng46Ow5ZDOBqo6C+g5v/LG4bZ2ejX5513Fm4uZBM5HMirTfGGHO92HvKhn74yavvp
         QF4V9XaGLhMK0fvBnI0RSV/xSE7pp8Xx5ZZ4yJaz1+0Pdnjv9OXh9VeF0SPPG2dqRruJ
         2+0jMsMwklOnhvTa6hNrWBmDaHbF2AqVW4RQkomu8zI2rK6bqXF/DOco3Yoc6YB9SWyu
         ORIh90fEEByhruAJxkVeQA6l319FrutHZY6eKAICyEvFlvcISsJpSRyfx7aZgczPD3Mu
         X9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700547581; x=1701152381;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWOiLbKGqCq+xWn1zmNhxuIAfXKxVirff8sSyPojC7s=;
        b=TMpU7Aqwf6CP98IlXGKyYTrW7UWvRTbMiwXElcP+6LD1NtOCLuGE/3I/ZFRq7RcJOs
         C2B5xFHT1GcQsLpJCEajpKxa8U3Gt7MJjz8tn8Uqt3vR8Nyu0rBotrCoZ2gXnd9rwfyx
         FYoSleoR8L368ZKUaQDVFI9G3Wgrz11sHXiRNx8CHMU05gByjdnVD+NjqrgIfqzWzvZw
         IB9yymnNlEnF3Kswa2Ds53M0nDK6NtOcujZo9hGwdlVUC0JGrZ9xDhU7yU8Z/HR375qu
         eZqFXnZ5sC8fYLmbwsK/U3w1hWZRobh7lHgXM2iZfN9HrDh7uzczuN10gjmZ3i9eMLgf
         ynjQ==
X-Gm-Message-State: AOJu0YzaQQnnzU0G492lpTMvBDxhxNAhOEyQ765Vb3FRyEU5iFVYx+TI
	GryervjbUMcVdxJMLCnv77w=
X-Google-Smtp-Source: AGHT+IFg9gtOkc2jytx/JTvJ0EeKvG0NshozRolV4AvAm5fAE0dbUPNLyfmE5JyZeimrGckV5Km9IA==
X-Received: by 2002:a17:902:d4ca:b0:1cf:56fa:898d with SMTP id o10-20020a170902d4ca00b001cf56fa898dmr9728856plg.3.1700547580597;
        Mon, 20 Nov 2023 22:19:40 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001cf64c60d20sm2260808plg.37.2023.11.20.22.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 22:19:40 -0800 (PST)
Date: Tue, 21 Nov 2023 15:19:39 +0900 (JST)
Message-Id: <20231121.151939.1903605088782465261.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com,
 benno.lossin@proton.me, miguel.ojeda.sandonis@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 5/5] net: phy: add Rust Asix PHY driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <363b810d-7d6c-48bd-879b-f97acffa70b6@lunn.ch>
References: <20231117093915.2515418-1-aliceryhl@google.com>
	<20231119.185736.1872000177070369059.fujita.tomonori@gmail.com>
	<363b810d-7d6c-48bd-879b-f97acffa70b6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 19 Nov 2023 17:03:30 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> >> +            let _ = dev.init_hw();
>> >> +            let _ = dev.start_aneg();
>> > 
>> > Just to confirm: You want to call `start_aneg` even if `init_hw` returns
>> > failure? And you want to ignore both errors?
>> 
>> Yeah, I tried to implement the exact same behavior in the original C driver.
> 
> You probably could check the return values, and it would not make a
> difference. Also, link_change_notify() is a void function, so you
> cannot return the error anyway.
> 
> These low level functions basically only fail if the hardware is
> `dead`. You get an -EIO or maybe -TIMEDOUT back. And there is no real
> recovery. You tend to get such errors during probe and fail the
> probe. Or maybe if power management is wrong and it has turned a
> critical clock off. But that is unlikely in this case, we are calling
> link_change_notify because the PHY has told us something changed
> recently, so it probably is alive.
> 
> I would say part of not checking the return code is also that C does
> not have the nice feature that Rust has of making very simple to check
> the return code. That combined with it being mostly pointless for PHY
> drivers.

Understood. I'll check the first return value if you prefer. I might
add WARN_ON_ONCE after Rust supports it.

diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_rust.rs
index ce6640ff523f..7522070a6acd 100644
--- a/drivers/net/phy/ax88796b_rust.rs
+++ b/drivers/net/phy/ax88796b_rust.rs
@@ -95,7 +95,9 @@ fn link_change_notify(dev: &mut phy::Device) {
         // Reset PHY, otherwise MII_LPA will provide outdated information.
         // This issue is reproducible only with some link partner PHYs.
         if dev.state() == phy::DeviceState::NoLink {
-            let _ = dev.init_hw();
+            if let Err(_) = dev.init_hw() {
+                return;
+            }
             let _ = dev.start_aneg();
         }
     }

