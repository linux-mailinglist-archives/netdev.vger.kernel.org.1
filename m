Return-Path: <netdev+bounces-44996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D552D7DA651
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 12:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7590EB2138D
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E3D295;
	Sat, 28 Oct 2023 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC7VDZsa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE89455;
	Sat, 28 Oct 2023 10:00:46 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52602ED;
	Sat, 28 Oct 2023 03:00:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2800db61af7so365951a91.0;
        Sat, 28 Oct 2023 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698487244; x=1699092044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DWbIOMuitDLWcBSAKIsk+GuESLuvVn20N0ekiF+O9I=;
        b=SC7VDZsaDVKPUvcSDEPFF7x1CAD6C8nSxBMvPCg3vd+fGSeJ1Y0ByxgQmow4xaitz7
         /LUqm5tBid5g8eiER/lmmD/udznCABcRvIaK29c5+E4iszCl7bIxV26qk/js45orAbLO
         KuvkxkQw1baFrWC/hXA/vWSkqeLyAZTOgjBpMRBJ2QEeEH+2/oI3quBx+pkZR52WYa8l
         /0Kjwui0misagYmW66Px5LsCeLii4BT2dSaat1VzGeau5qybTosanTRQKxv4NFL2+Nm6
         TlHStgYy3Pt7JFGBs2ojzHbdnOhLdWXAtK9wWgW2nk5h3zaWU4/2C0aPbXNGF+s80D0g
         2FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698487244; x=1699092044;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5DWbIOMuitDLWcBSAKIsk+GuESLuvVn20N0ekiF+O9I=;
        b=EO9mNUw4gAlmSgvD6wxeoBOmc3z8PIUVubeRoUEZPTrprtXDC9ydllvw8fkb5WJBgn
         yQeXYBgQj70msn4KsNqhYixHNy0wYo7PdGed4VVuSOMhpNZrMzDCpIZ5mAg6LxycWR0c
         63yzMTK/t2h333c2Cs1sYgO6OKJF6sMRsW6QjjbLoUHvmJY5BIWgiRwoqj24+Mmvwu3a
         6CuWwNHuCdrOL+4J1/6eY1cfrFQpdJkWduQ5JarrKwDcbvGQfAzWRYDkqVoa52Jzhc/Z
         x2hHK6yl0m6nN6LuSA4GD0+ZzVudrmEvFBwvN6CL1LeZNHKDOXZXSR/SkgZntjKdD3Lt
         6vGw==
X-Gm-Message-State: AOJu0YwIFd2JmLWs10EQjwM/Co8oCLU98CI/XiZ54C9SwK7Una3ixTKW
	8ySmCHq7lV94ImiH0M0bB/Q=
X-Google-Smtp-Source: AGHT+IGcyxSi3SW3Ov9CHNShIuIkXBPXIb+djdKKkqT399frnzTvDyoMHPsxjMfHaG1fCZTx6G+dAA==
X-Received: by 2002:a17:903:2784:b0:1cc:2b68:40ec with SMTP id jw4-20020a170903278400b001cc2b6840ecmr3317031plb.4.1698487243702;
        Sat, 28 Oct 2023 03:00:43 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b001bc5dc0cd75sm2992975plk.180.2023.10.28.03.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 03:00:43 -0700 (PDT)
Date: Sat, 28 Oct 2023 19:00:42 +0900 (JST)
Message-Id: <20231028.190042.1851879535543927717.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZTwK9c0sf8sxNgdr@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
	<20231026001050.1720612-2-fujita.tomonori@gmail.com>
	<ZTwK9c0sf8sxNgdr@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 12:09:41 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Thu, Oct 26, 2023 at 09:10:46AM +0900, FUJITA Tomonori wrote:
> [...]
>> +config RUST_PHYLIB_ABSTRACTIONS
>> +        bool "PHYLIB abstractions support"
> 
> bool "Rust PHYLIB abstractions support"
> 
> maybe? Make it easier for menuconfig users to know this is the option
> to enable Rust support.

Surely, updated.

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 11b18370a05b..1fa84a188bcc 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -61,7 +61,7 @@ config FIXED_PHY
 	  Currently tested with mpc866ads and mpc8349e-mitx.
 
 config RUST_PHYLIB_ABSTRACTIONS
-        bool "PHYLIB abstractions support"
+        bool "Rust PHYLIB abstractions support"
         depends on RUST
         depends on PHYLIB=y
         help

