Return-Path: <netdev+bounces-45122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977067DAF68
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574A6281254
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13313AE9;
	Sun, 29 Oct 2023 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei4YI7nj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87814275;
	Sun, 29 Oct 2023 22:59:21 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122EC270A;
	Sun, 29 Oct 2023 15:58:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd20c30831so947509b3a.1;
        Sun, 29 Oct 2023 15:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698620333; x=1699225133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQGjgT37GKHA0tENQ8IkVyb0DDSxOsxq2xov++jmiok=;
        b=ei4YI7njzRx3fJ1gs8fAs/HxTMhLJNUmbVmO9QkJE/aCRlcGtKRAJUBEXJ142PS3Gx
         8q6asR9OJ/ARhWtKBcJUDi5oN1sqxr3aV0fTFvh+5qBgayQD5ucJsO4Cj29Vs6lHBuky
         9Hat1wFm6lMXoqHuF31I1u24oB6/YVvEssk9kFlRSEjBB9JCUlke2A3SQBF5Cnhrzq7I
         ivRoeUf+1szphL1uvelKWpbj6/YO6kn84+ktwlFLrxBcKJ43VyqiiMe3gtfm6vmzEqio
         iaFOi88lSNRM37SSd93l7cFD+xLA08v91IzY2fxF3qAVmZ85zCKS/zSu2zoCfG9IOLBV
         g9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698620333; x=1699225133;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YQGjgT37GKHA0tENQ8IkVyb0DDSxOsxq2xov++jmiok=;
        b=t5wYwOSlsTV+tNt3UAGd/02lQXeK4J44toegm7rz39bGgY/bojR03k3dcSEKqyFXqX
         FCc+XbBSOD4g9kUjyWeKb9YZhpsEH2mlFcolAAaJGCCYvYzKYvxOlCBjdSaM2PIN81vV
         Rbda8YQ+Io+tyawQFDyiwZ92fcIRAF0g0v2BsGZ2RPla4+CIemd97wj+f0ksNGrmPbfP
         wKu9CUat6JhAeCJJF95gnmsV5jFcMy7bIpewgV1osNcGA8OObbi31SNwJvLzsycAwTzH
         MeBCmtjAjZBjlI57bhvNRZzHKjpHNy3229O0eP69grQFfmJxI/Epgmbzq6I7Pl7PQLtA
         ikFg==
X-Gm-Message-State: AOJu0YwaomOumv2WfqXdnp8GFTVgZ1VoAtINcSDO7utkuQS4RuahX/Ge
	Xb/L/ekyDBXOZLlsEWa2RcJkT8XUZCSV/flV
X-Google-Smtp-Source: AGHT+IFD56bf5ZWwrpPOUnz9nBp7O27WIsRLsAXLSq4mfaxG5McbT2SYe0XJpdtfubheDbRLkq9j1w==
X-Received: by 2002:a05:6a21:7899:b0:14e:2c56:7b02 with SMTP id bf25-20020a056a21789900b0014e2c567b02mr12006444pzc.0.1698620333480;
        Sun, 29 Oct 2023 15:58:53 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id so3-20020a17090b1f8300b0027d0a60b9c9sm6477214pjb.28.2023.10.29.15.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 15:58:53 -0700 (PDT)
Date: Mon, 30 Oct 2023 07:58:52 +0900 (JST)
Message-Id: <20231030.075852.213658405543618455.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me, boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
References: <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
	<20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
	<ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 29 Oct 2023 09:48:41 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sun, Oct 29, 2023 at 01:21:12PM +0900, FUJITA Tomonori wrote:
> [...]
>> 
>> The current code is fine from Rust perspective because the current
>> code copies phy_driver on stack and makes a reference to the copy, if
>> I undertand correctly.
>> 
> 
> I had the same thought Benno brought the issue on `&`, but unfortunately
> it's not true ;-) In the following code:
> 
> 	let phydev = unsafe { *self.0.get() };
> 
> , semantically the *whole* `bindings::phy_device` is being read, so if
> there is any modification (i.e. write) that may happen in the meanwhile,
> it's data race, and data races are UB (even in C).

Benno said so? I'm not sure about the logic (whole v.s. partial). Even
if you read partially, the part might be modified by the C side during
reading.

For me, the issue is that creating &T for an object that might be
modified.

