Return-Path: <netdev+bounces-138054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D5F9ABB3D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EC71F245EA
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B13CF73;
	Wed, 23 Oct 2024 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCZdedoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68867EAC5;
	Wed, 23 Oct 2024 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648745; cv=none; b=mxeeyOhQpIi/7h9bl5YmSK98AJtomwOy+O32U+4bJRL7wt1DBSH0O1+3x0fSPMkpt82dUtA0gHWZXmegVgBCeWfuRSvgf0ZN+BkV/n/RQE7NYwrrkFTnusOifR9R5//ZPgHmfeL8aGuGeXutqdu/Cxa98/d0/SN2A3p9WLnjWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648745; c=relaxed/simple;
	bh=xV5uo3j+DCMuw9m/bkOEroNUQp5mGUIsVBycCzCBgWU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=llTrv/XesiTpVpNQ+VmRHJLxE6WO3Ym7f2R9yhpV5VmCw2ENeP8Odx+HywwMA+WnhQJNU+tVVxcCS2Qlqt0UfeYN2Ndjz0/jn98oTRj4yCdtll42kU7XN1BeHkjtN+Eetw9FpMhEOngxVDsxCywHh0NMo/H98Ye/EA1yIKqKUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCZdedoD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-208cf673b8dso61379185ad.3;
        Tue, 22 Oct 2024 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729648744; x=1730253544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DP8kBMWbDvYjwhvSIEx+g+xP6R3QphH2HAC+pYinyw=;
        b=nCZdedoDZDc0YSHVmahm2h9AeUocruwtjRVrLF5i3YgMPEMeEnvGtEbCgOv4JH815y
         I9iMKSRbNdcddX9OOg+69AZlfxucZV71uzDGyawtGHxpUhU25JlACb3m0QPn6+y5rUm0
         NIgrjVjJmh94R6HOCm9w20skx80VYK3HnG2+Rm8cLHFnNB41EDi689JtJn14S7Mki7qw
         6EBVqOIVsAO0mesR0sUXg0wwBh3n4bnxN3M8MBl0UjTAUZfODQmwJFOAKCh27W3iAPjz
         uLFOS6VKVGUWaMZ/nTA6/T+mLCx4jQa2WhdFZfl8Vbd3ezceWCVAvpWqbuExY0P9mVyh
         O2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729648744; x=1730253544;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7DP8kBMWbDvYjwhvSIEx+g+xP6R3QphH2HAC+pYinyw=;
        b=huXvBfndoigfptZBlRdIipLVXuWMF7Gqor7uhqely3a2Xpvm270fWmsxCyWau4ZQXW
         xU2Ddj14B61LKYTDkHQgTj4SOeybu11cUJ5srTCulKyoVp7bjMdQ4+Y0trDwH4vxDyaV
         p5qbN5NUO5lmFeUZUi0/0xCpCFXRuSLMlGZKdmph00hO/FGH9sNpd/nIgiEveVs08g1a
         VwGQfm5CrTA9uOghzSal3DJB2/w3MJGOhmolN07tKHrbhnRr/6//AJeAqIj4DRW3z+X+
         lpk3tjSHxmjGym5vObd+fzVwem3leSW/l0UGqEZD4uwcyglNaQkoPrLs3wPHfDDyRZXg
         OHJw==
X-Forwarded-Encrypted: i=1; AJvYcCVdJdw7uHD2eaGdhOGWKjvwEs364NS9cnxIygLhMEXJtqcinWbpesfF0RVdh0vVxH2PTgvWNFyp@vger.kernel.org, AJvYcCVqeTwx7e7ILU/gIpt/e/HfnOI+sOuY80NEQmVn7hP24306pz7IbN9jDpt8xljjaOweko8KpWHma9Ok9i0=@vger.kernel.org, AJvYcCWQc2pdyj/tiWGZ+O6dFsA2jeznssANuKigtfuGN0dMB9T6FxCy2jIkQQlWxCbHUZRT9T3vJsY1OiQKCi1JZn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qToMW+huo2A2nIVR82UBlU6L6CaM4ehvAIz/BH+TO+saqlg9
	GEB9atQ/Yue9/D2BY8um9ah3MrYiiv+yz1vZrPoGknix8Km2z0st
X-Google-Smtp-Source: AGHT+IHWh2jsK6iB0vS/ZeQw7gXNj6J/AlmnsvI9xbeNALA6Gv6lXTJNluaKBvbizD+lGoQvdK3BxA==
X-Received: by 2002:a17:903:40c8:b0:20c:c9db:7c45 with SMTP id d9443c01a7336-20fa9e584edmr15543235ad.20.1729648743650;
        Tue, 22 Oct 2024 18:59:03 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db9d5sm48726425ad.194.2024.10.22.18.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 18:59:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:58:55 +0900 (JST)
Message-Id: <20241023.105855.1516501489443596246.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, aliceryhl@google.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's
 sub operation to Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nGoT9DxLwDbg8gZVxk0ba=KqvXLAVz=hRNFMqtCeGNvg@mail.gmail.com>
References: <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
	<20241017.161050.543382913045883751.fujita.tomonori@gmail.com>
	<CANiq72nGoT9DxLwDbg8gZVxk0ba=KqvXLAVz=hRNFMqtCeGNvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 18:45:13 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> Surely, we could create both Delta and Instant. What is Ktime used
>> for? Both can simply use bindings::ktime_t like the followings?
> 
> I think it may help having 2 (public) types, rather than reusing the
> `Ktime` name for one of them, because people may associate several
> concepts to `ktime_t` which is what they know already, but I would
> suggest mentioning in the docs clearly that these maps to usecase
> subsets of `ktime_t` (whether we mention or not that they are
> supposed to be `ktime_t`s is another thing, even if they are).

Sounds good. I'll create both `Delta` and `Instant`.

> Whether we have a third private type internally for `Ktime` or not
> does not matter much, so whatever is best for implementation purposes.
> And if we do have a private `Ktime`, I would avoid making it public
> unless there is a good reason for doing so.

I don't think implementing `Delta` and `Instant` types on the top of a
private Ktime makes sense. I'll just rename the current `Ktime` type to
`Instant` type.

