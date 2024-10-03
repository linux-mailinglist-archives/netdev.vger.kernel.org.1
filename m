Return-Path: <netdev+bounces-131618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736F98F0B5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698F71C219B4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63919C566;
	Thu,  3 Oct 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+EqG9Mn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EC199945;
	Thu,  3 Oct 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963125; cv=none; b=a+CLtVW4M8Qe9LWIyW9yoEAxFLRc8LrKrDJAQn4LGomyZ0sXAIW4Vr0bfqgVteIpTMcqz0KHaA8kJQfJk8OLo8AGzyQ9axfhnWN9yMl2zwHjwh3i3t/+OgNSLkpZGuBrF4TYDYyP+u6Gl8Gsb/XRjV/szYHsxsAmMH+tlj7T4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963125; c=relaxed/simple;
	bh=aATyvnZaYHbhr/zzTHInDy4dGJv4hzZqr1jPwGFb1r0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N+iFLfl643i4uwS7Jt2MbOZDHcMda7J/X7DOESmYfaVQ1kutSoStpQ6lFyKW5WshYAKLIg25RGgInex6fE1Aban0R0KlQDRqC7P7fLn0gea+o3HO1jlthgSJNMnU01pXf89jrYLeYSqI0IiY5JzOnmGaSq9xp9wsbMpBBw9pvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+EqG9Mn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b6458ee37so10104945ad.1;
        Thu, 03 Oct 2024 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727963123; x=1728567923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCRx01BFBxF6i5PASeqOr5aWcG8Y3+oQX45YJjoJlcU=;
        b=f+EqG9MncHqwl5Ljqjotlrt1dnVdcKZMUKp2TZUnFfPPD5dCXKBvHJynW+zqbHVPGq
         f+7c82OcrBU/AM6OklHLB8OE1hhYgMKOylV+mEMOUm7IIV5DnMWnAYcUcqmxtiSJ87IZ
         b2huE6PfDF7bPMhONJ/Mncc38ga5dgXLrYEKU7uNiEP0t+5zRFEZXiGVaBVLVd5pUDwP
         h/FqEjVwZoVseLKsRUhLZ/bnlpYJ5pHGLCGXsRhozh0XP6pyZvdrmAr5XJpvowRTFEIY
         u6vSVkPmatoWqXTk6MT09PRsOWeYGM1s4cVEHDIH+4ox9MiH9NBbLJB1dzNFRcwLRoGm
         llwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963123; x=1728567923;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HCRx01BFBxF6i5PASeqOr5aWcG8Y3+oQX45YJjoJlcU=;
        b=gZvsFyF1dNf5USFlJyDgXHIXGkCy3gpSKdl0oUYqy6j9GvSpNc7iGG96h7Ay8/hOol
         ImCNM1IfgKV70xllbTnp4Jl6Jel/dmV0yWkLUwvAe4qcwQumIV1rYNiNhaeKqMukk4He
         oUuDJ2OQ1zFMY42d9AmsFGka9FKVKUfN8v3fjoM5sKZBD/h6iPEimCyIAqXlMHP6I9xu
         1Z0veGYXawQVD7dt3jrcIwiYorJaxRYGYElupaUVrbgK1GIxvCLXFTKyBFV6iqDafiqI
         fTlbyaf8cVuXSn/4m2NIaa7l+yAeDQ/MheCFRHYV9WYMGuldPLEUVq0pVyiXKUO9wrp5
         t76Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR0AFp9tDTriD/ZRWE4lNbFZYDmBhcxOnFRDMBsBmfLbk9KBQRIjeO14Gh24WRYIxgbYwVD28=@vger.kernel.org, AJvYcCWpmrExH8aUhucp2LOVFTkLch7Qnpm9WAKRXjoA9+LK3qhXQFa2mqvEs5p1K95cv2wwx9u/rvOLIb42gzBFzkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNHyS5rc33f8A98qWsmOU3kcBk/36ADAPCMBBxmedZngW8Nnb
	me72DG3ygqD2WtVEOJ71ixhiaIPp7Qa8h9ox2M9IUwwutfcmY4AE
X-Google-Smtp-Source: AGHT+IHC7nrGtBcX/+ENz/LJca9tTMrSIq/dOim8lw5U+8imze3Bwe3tGHn3CEbG5sRG2kebBbYQXg==
X-Received: by 2002:a17:903:41cd:b0:20b:7be8:8eb9 with SMTP id d9443c01a7336-20bc5a791d3mr90172445ad.54.1727963123115;
        Thu, 03 Oct 2024 06:45:23 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8eaa9sm9082455ad.170.2024.10.03.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:45:22 -0700 (PDT)
Date: Thu, 03 Oct 2024 13:45:18 +0000 (UTC)
Message-Id: <20241003.134518.2205814402977569500.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, dirk.behme@de.bosch.com, andrew@lunn.ch,
 aliceryhl@google.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zv6FkGIMoh6PTdKY@boqun-archlinux>
References: <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
	<20241002.095636.680321517586867502.fujita.tomonori@gmail.com>
	<Zv6FkGIMoh6PTdKY@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 04:52:48 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> You could use closure as a parameter to avoid macro interface, something
> like:
> 
> 	fn read_poll_timeout<Op, Cond, T>(
> 	    op: Op,
> 	    cond: Cond,
> 	    sleep: Delta,
> 	    timeout: Delta,
> 	) -> Result<T> where
> 	    Op: Fn() -> T,
> 	    cond: Fn() -> bool {
> 
> 	    let __timeout = kernel::Ktime::ktime_get() + timeout;
> 
> 	    let val = loop {
> 		let val = op();
> 		if cond() {
> 		    break Some(val);
> 		}
> 		kernel::delay::sleep(sleep);
> 
> 		if __timeout.after(kernel::Ktime::ktime_get()) {
> 		    break None;
> 		}
> 	    };
> 
> 	    if cond() {
> 		val
> 	    } else {
> 		Err(kernel::error::code::ETIMEDOUT)
> 	    }
> 	}

Great! I changed couple of things.

1. Op typically reads a value from a register and could need mut objects. So I use FnMut.
2. reading from hardware could fail so Op had better to return an error [1].
3. Cond needs val; typically check the value from a register.

[1] https://lore.kernel.org/netdev/ec7267b5-ae77-4c4a-94f8-aa933c87a9a2@lunn.ch

Seems that the following works QT2025 driver. How does it look?

fn read_poll_timeout<Op, Cond, T: Copy>(
    mut op: Op,
    cond: Cond,
    sleep: Delta,
    timeout: Delta,
) -> Result<T>
where
    Op: FnMut() -> Result<T>,
    Cond: Fn(T) -> bool,
{
    let timeout = Ktime::ktime_get() + timeout;
    let ret = loop {
        let val = op()?;
        if cond(val) {
            break Ok(val);
        }
        kernel::delay::sleep(sleep);

        if Ktime::ktime_get() > timeout {
            break Err(code::ETIMEDOUT);
        }
    };

    ret
}

