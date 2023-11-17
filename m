Return-Path: <netdev+bounces-48604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD37EEED4
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9946A2812E1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840F156EE;
	Fri, 17 Nov 2023 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGVbgzrN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F4C4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:20 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-507ce973a03so1850936e87.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700213958; x=1700818758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRP/aW0x+wuYfu3h+kWAPAGUjA7Hx5HhVmNICZELS2A=;
        b=ZGVbgzrNoEiKIWT4SMGW56A1cWwFPjK5UZHn5v67/yy/xrAr31HINFavgMXN5i9gSM
         SeLRYWUpVXI+5X6rCmirbDDLKkXQvjmR40CLN8bXwkWF0mE4PekWBE5zuF3Z+104o7fp
         AQ5vBqpbc/OW7ziJhPzx+HNL1wWyf+0P9zMY4xUE3ueBtT3V8rT0aohnNldTki58ionL
         gEnJSyM+PQjswfuhmZYAZ8S6CSiu49sSrvLnOZcHoh63iiZZxgvP4hoPXDWH+G9jluW8
         xLjqZ16vyokJRKJMC2JEFVOdy1iEeURf6HgsM6/15OSLnIwHPLR0Pye7N6y4SAGNc5BQ
         3rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213958; x=1700818758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRP/aW0x+wuYfu3h+kWAPAGUjA7Hx5HhVmNICZELS2A=;
        b=NSDzXq0hcA+K3zv4jkt6wLpnYt4kwf4pmmiSmoJiF3/ghGWdajZoH47B9XDizN9UOV
         otM+C5rmWoQKIDxexou88JFzF8E1gq64nOdi1Z7+EajoQe4fujyuH3IUhU+ubKpZgJaR
         CnklXtVXlatqP+UM3+94JezOwaLPuFbQuptKiT2RwdEF8zv6qjrNccXzRnsN9V9rcvUA
         YTkGNcQAiweG5b+4ViNmnYE60uqYFO4ePhdpaGYxfuELuTOR20wiQzqcD1XY/AzH0OvT
         OcaOCND/phoYtU1e+fIflCRyIkEmFzDKeDarPJkng2vHpJrsFAi0EuaAQZPKou1T0jwd
         qI4g==
X-Gm-Message-State: AOJu0YxZmg9meqd7+XUwDABIJZdYWSwHHKhVDR1M1BmCFeXJXrzhcZdW
	hwyiSnGAXBUjWsOJRaMqzw6PSqyk1FOR210=
X-Google-Smtp-Source: AGHT+IH9p4D1RRU0dNE59yvw/KRBe9QqKBsY8rPqsWRGB5cgYzJqnqwfMKyX0F287MZsfIH74dfXzAAmvvU2rWg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:3006:0:b0:2c5:177d:60cd with SMTP id
 w6-20020a2e3006000000b002c5177d60cdmr171034ljw.9.1700213958182; Fri, 17 Nov
 2023 01:39:18 -0800 (PST)
Date: Fri, 17 Nov 2023 09:39:15 +0000
In-Reply-To: <20231026001050.1720612-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026001050.1720612-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117093915.2515418-1-aliceryhl@google.com>
Subject: Re: [PATCH net-next v7 5/5] net: phy: add Rust Asix PHY driver
From: Alice Ryhl <aliceryhl@google.com>
To: fujita.tomonori@gmail.com
Cc: andrew@lunn.ch, benno.lossin@proton.me, miguel.ojeda.sandonis@gmail.com, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> features are equivalent. You can choose C or Rust versionon kernel
> configuration.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Overall looks reasonable. I found various nits below:

There's a typo in your commit message: versionon.

> +use kernel::c_str;
> +use kernel::net::phy::{self, DeviceId, Driver};
> +use kernel::prelude::*;
> +use kernel::uapi;

You used the other import style in other patches.

> +        // If MII_LPA is 0, phy_resolve_aneg_linkmode() will fail to resolve
> +        // linkmode so use MII_BMCR as default values.
> +        let ret = dev.read(uapi::MII_BMCR as u16)?;
> +
> +        if ret as u32 & uapi::BMCR_SPEED100 != 0 {

The `ret as u32` and `uapi::MII_BMCR as u16` casts make me think that
these constants are defined as the wrong type?

It's probably difficult to get bindgen to change the type, but you could
do this at the top of the function or file:

	const MII_BMCR: u16 = uapi::MII_BMCR as u16;
	const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;

> +            let _ = dev.init_hw();
> +            let _ = dev.start_aneg();

Just to confirm: You want to call `start_aneg` even if `init_hw` returns
failure? And you want to ignore both errors?

Alice

