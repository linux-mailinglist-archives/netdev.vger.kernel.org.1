Return-Path: <netdev+bounces-143503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224159C2A48
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 06:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB3D2833E1
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 05:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E413B2B6;
	Sat,  9 Nov 2024 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtDf7yUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707198836;
	Sat,  9 Nov 2024 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731129340; cv=none; b=EhsZMLymRgcPkHp1jVQg34GOJ64B2TpkXTsc6tdcqUJ6M5iAY2hgR8nyIUe5foESLi1Ww+FCJzsm1vYOfnkiWd7plu3m2afDFQ/TXMr5yIzAQMHgILTl1l/lBwhBZVrQZa31Nm1L0mrdK03TY3TQjJxou4ELUdKJUBSDJHcDSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731129340; c=relaxed/simple;
	bh=srDFTsNAwuMLwHBgKmjyNApD14mJpB3efD2+Gkm8Cis=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RY0PN0eP3WMCGqUr4fZwHDkxnAYxjZyJASUblm/RWWVwdfMYJD5o9eAA2sT3i5BuAwJ81MJAaV5xnMlNeutKN+y6arjdDwr3xqfGCXMOOE2csV7jgoFDB7ZwHi7z9FjunqrFE1o6XPn2nVGY7haLMiNnKgl7bpVTaSlG6lT4lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtDf7yUp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb47387ceso31758305ad.1;
        Fri, 08 Nov 2024 21:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731129337; x=1731734137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jfnBisue6Ja6w9UlHzoj6XV7CgJYJ+QYjUAoUurtcw=;
        b=HtDf7yUp8O1eWJCbdiMr2S0D/3PXmvdevQvyKTWW+c6bZwUV/iB5F9PNP9zHkrACYL
         GMQYF5Q4ySQlNF5ct1kWnSOCDTnONPq7pw7U9h78LZ+xaR7AYw5tXFClD+5S7HLnizrQ
         FYoA069XpoNM0Hh2m5KC2ab5zzUv/T3nqLvDLm8E5IpsgMCEYxNuJQCbCxKH12VEXQwx
         Yr4MiJCNWE0gLuxVUsALLlinGQ9iuCo6o6TVZLxZS4+zZTeDEUmxoPQMVjPN6VXh/sSq
         jYvkke5uVEeFCDlWVZAJCIc2QHXJlSTbzVhT764C3gvsHzNL7m+Hrp3MMPLg1sN7Ftxn
         Vc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731129337; x=1731734137;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jfnBisue6Ja6w9UlHzoj6XV7CgJYJ+QYjUAoUurtcw=;
        b=rbsB8lKlaHOU3nqI4UdfOIWo6eG1J9e+awwqL6CfMRR1VeJcmWAT4haYGdR0Ty+dzI
         tH/T1ZGSLOrspvcxt/MBoesG5joisV2Zu0YQS7Gx872R4eMGfHYgPdwjyrE2sponDZ59
         llAet6W/MB1qjyKNCsrbkptzeC/t4Rd2yB2GNebX9KmMDwyb7t5ChngpQ4P9KPeAOy5E
         SO1lgi8tqUdQbcTp0pfUviYT0cZ8lUV6DFXjQuZ/vP5cU4RpI1tPvzUXUsQDlV+i0MUe
         kupMlY8cGWvcK5+OheXErEFWyMtYDyLYAzUcvcTkjGmGh5jBWq0Kne6aAytIWJ9bcThZ
         BHbg==
X-Forwarded-Encrypted: i=1; AJvYcCUjBkclh75HEmdf2JKvAcQrcSLAdAXIus8YYNXNUMMt0CyBBXIZQA1+0MgTtbou4iGIi92IjcyoLxxIrDhaAAI=@vger.kernel.org, AJvYcCWF5RcAtTNNTvxwv8dRGtO0hBnpM/jy5FHcQ4JwyTUMwXvM/6vNZ4hOJmK2egNCrzZ/W66kjj+v@vger.kernel.org, AJvYcCWwO34uiXo934uwyHqiHTuyHqSD9AveIqH7Mm9+exAjj96GnJqbkOFpsYSLGGcld1mrPRkLCP8fZdoobvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwb9R+jCBCamKkOlA9DCnN4FyXx1lvouItxAms9UbPL9ikd/DJ
	WvCSrYIkxAqgVZFYjz5WcxwCR+npMGCs9KAD4hBdB8YgGJj2e+1N
X-Google-Smtp-Source: AGHT+IG6vNIHXnZhYkkO0JMdGpVleHKOAwiCz9Uit7eCDcaw1dQ2hz6+QHxw3bblemdwa6m/gqOhkA==
X-Received: by 2002:a17:902:d4cb:b0:20c:8f98:5dbe with SMTP id d9443c01a7336-2118354bfe9mr75976185ad.33.1731129336685;
        Fri, 08 Nov 2024 21:15:36 -0800 (PST)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41985sm39264925ad.168.2024.11.08.21.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:15:36 -0800 (PST)
Date: Sat, 09 Nov 2024 14:15:20 +0900 (JST)
Message-Id: <20241109.141520.1319530714927998446.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zyuy25viG51DDRk7@Boquns-Mac-mini.local>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
	<20241101010121.69221-7-fujita.tomonori@gmail.com>
	<Zyuy25viG51DDRk7@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 10:18:03 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Fri, Nov 01, 2024 at 10:01:20AM +0900, FUJITA Tomonori wrote:
> [...]
>> @@ -44,6 +45,7 @@
>>  pub mod page;
>>  pub mod prelude;
>>  pub mod print;
>> +pub mod processor;
>>  pub mod sizes;
>>  pub mod rbtree;
>>  mod static_assert;
>> diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
>> new file mode 100644
>> index 000000000000..eeeff4be84fa
>> --- /dev/null
>> +++ b/rust/kernel/processor.rs
> 
> What else would we put into this file? `smp_processor_id()` and IPI
> functionality?

Yeah, we would need smp_processor_id() but not sure about the other
functions. There aren't many processor-related functions that Rust
drivers directly need to call, I guess.

> If so, I would probably want to rename this to cpu.rs.

Fine by me, I'll go with cpu.rs in the next version.

I chose processor.rs just because the C side uses processor.h for
cpu_relax() but cpu.rs also looks good.

