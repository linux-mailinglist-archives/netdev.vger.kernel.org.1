Return-Path: <netdev+bounces-136550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFC9A20D8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B31C2141D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1A1DB37F;
	Thu, 17 Oct 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npo8tZ2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCD1D9682;
	Thu, 17 Oct 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164301; cv=none; b=tle5SIVAI3c5uGhfLyQMZO2jUrwHbUWcbgmR40eHEJoSZHmQozsyr4ilWpspKryNQW4wuP09+u0Dj8KwIyDicORnEETJSXNSZBYgqp8jpyMbRAlDITizdrrJFjnuQV/VGmxCPtLxqtSGzo9+kd1O8Lc8MZTVnI6KPIg1bHVdLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164301; c=relaxed/simple;
	bh=Pl1y+fabejvAdwCW1Wo6WAmJxlXAhG7pAm9j7omYYyA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OJ/BiK7d6+7tTWXVi+Jc2xcPZziqmGu/WofovzgxG4er875Cc161B8b5P30EFgb8tjyyXdbsCDN0GwhgleaNOjOWR9Z4ssHljz0FIOHpp0CwIqFKLVQm+u8edB0ROLwAQXkS6NvHhRmf1ytRnSMEfGEJT8rUSx+0JWCPgNNar/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npo8tZ2a; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c70abba48so6869715ad.0;
        Thu, 17 Oct 2024 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729164298; x=1729769098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=788NdUPICTf2wfyo7RdgecA31qsl/VeyUH4AbOThLOo=;
        b=npo8tZ2atFwFQOE6US3lkjwDGDRSbwYxuVOT3UH6D9mQPD7pg0tsKo4NJE1osmFaaX
         U9/HgMIiX7s4gP21lqD8gSgluCmMvcSRe43vGl+jLbJlUhzcD5Ms6vmJZYFD979JRdqe
         vBNvfTjVmQ8AT37c82dA5WV1RlMCp1ekvfP87gaLoVnYtpYhSzhTztaRPQF78O5HNmUy
         +iyLf7WAREGYwItkcBZVhXaJKZcLnuYK6QM7M1za6CnEUYrBVsLC98eRfpZxDpmtR17J
         Bak8GDXfqvvnVtG/94djXZOl4aKtgIIybP8kBUNSdSF1De5hnhKfnBn4PezsM4kU6ix3
         cg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164298; x=1729769098;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=788NdUPICTf2wfyo7RdgecA31qsl/VeyUH4AbOThLOo=;
        b=uny7/oEL3rUVK1eNKA+3HtNYDZp1q9agcqBP2DpRX1+5LnuEg0MyjPfYNHvhjmjukm
         L6ZyGqvroDoQmU08vujuUHM9Ra7tvsfBrtLgWe6ztFN7fBEO8lC3Gtv5QIl4+Dh2rgwT
         oEk2QIfSdVmUbPCjSqp0CJlrZwU6eyEwh/35/NnVk+PjS6MhoqGyNFJ8Net4HVBgdlMZ
         ZNlROG8ihwGP5lczcGPO//MFlWEQmNrFhqs1M4zgyrqIziZUpE1SuHF6Q9A/RAdEIsbv
         UWMv3BUmaVsYx9XjN9dRLazuyWRJZgE8/HQ4RWmPcUWc6xGiPKiiRUBvcfxav/irQZD6
         C65w==
X-Forwarded-Encrypted: i=1; AJvYcCV/1GU03q9cFsVISvp3CtiLPnDh5IjH3ZU0F/3afnOrZMX87cHXI7dtdw0G8Y6WmOF51vAgFiMowOcQXdi70j8=@vger.kernel.org, AJvYcCXKy3gZ5cHsBLdyF4wHcQfLavHc7qpnK3fjpV87RZ/u8nTyEXL+s8wYTsq6tnnR0Z5PHOzOlinCUL48H/0=@vger.kernel.org, AJvYcCXLayxJ85Dm2ZDoGre4odMH0W+8eLsFS57vzBgM3M+XP+5yRKFGUAim7fCWMzff1EcW4zNqvcPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2AEg9dEjOzpNnJAFJlLH9KQBnSn+oKViQbConrXlUhC/2ayp
	JvM/3e9tOyMnfbQwwGU9rKwv1X1VjHbImqhCF5bxjbtyFgj23hAt
X-Google-Smtp-Source: AGHT+IFUlHh1izUKQNOidDglqkAzWkJLsCNYonncHxtKWheHEjmx/KpO7PmBgsY0lDiO7fhvKfLH9g==
X-Received: by 2002:a17:903:338e:b0:20c:a189:c006 with SMTP id d9443c01a7336-20cbb240c46mr218003845ad.45.1729164298150;
        Thu, 17 Oct 2024 04:24:58 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d513sm42596565ad.101.2024.10.17.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:24:57 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:24:52 +0900 (JST)
Message-Id: <20241017.202452.575883553994137336.fujita.tomonori@gmail.com>
To: me@kloenk.dev
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <89854EA9-63AC-447C-807C-964BB61FF0D6@kloenk.dev>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-3-fujita.tomonori@gmail.com>
	<89854EA9-63AC-447C-807C-964BB61FF0D6@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 12:17:18 +0200
Fiona Behrens <me@kloenk.dev> wrote:

>> +/// A span of time.
>> +#[derive(Copy, Clone)]
>
> Could we also derive PartialEq and Eq (maybe also PartialOrd and
> Ord)? Would need that to compare deltas in my LED driver.

Sure, I'll add.

>> +pub struct Delta {
>> +    nanos: i64,
>> +}
>> +
>
> I think all this functions could be const (need from_millis as const
> for LED, but when at it we could probably make all those const?)

I think that making all the from_* methods const fn make sense. I'll
do.

