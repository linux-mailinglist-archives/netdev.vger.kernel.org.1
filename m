Return-Path: <netdev+bounces-166840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696CAA37817
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 23:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537E33AF776
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715A919CC0C;
	Sun, 16 Feb 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfZgYw00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE035748F;
	Sun, 16 Feb 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739746242; cv=none; b=iYFrPXBLEiFtX8h+LM85xjunJC4sj85gKSgmHg8ncZODIApAc4aUzaFKarcer/i+fzgCBVPU/pHjsr6Eq3XprZc01JoqvXuBInx9iFrmzcR89XczqDDjJg0/te19dlXK2FHHDPTHZmF+UDHF1Yw1kiuXIoM3PCo40V5aUx9MP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739746242; c=relaxed/simple;
	bh=MVPYUEfqQP7SYtryyiFnYb+MCB/nRuUktfoW6AhsSsE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CB1wJ8S3qP9XVNAfCrWmpmMmug4nCPxcxLmle82AHef4xbGC8Qw+7O71hQLbloGhXugL08LyC7sBRgws+qvFMQkhET6HX8Ey0g6V8b6CzPyzR1VgsnztMJeq7fseY/8PBSRyVagHO28is7iOOtIBITmPsj4yLSwuvie66wX/sMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfZgYw00; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d601886fso48224415ad.1;
        Sun, 16 Feb 2025 14:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739746240; x=1740351040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwRpTiFhkazH7eZCnzFo4dfJTeXkjVTocPymKPEhdxo=;
        b=BfZgYw00LiTNTk+K0EWlPpbX4GkcUorSqwXbpFtvWHVoqwJd2R04XvLO7pKjDyg8BI
         +P8M3xK56K6zjzVq9Bzvp0LeHyuuA7NUX+G+xDrqyrjJ3yzg/oGJy5Phdi1r72IxYUFT
         snJqqwSbx3GVh55xgKYtOl2/CJy12U9eI8q0wVIop6HV30ccqrwuGW+eSe+bpMmZ9f9Y
         5PIhVisYOY7d7QPLjdDo5t1C0eO7RsDff4KFdic3Yx6b6eAdCrjnAeHwPd4YtTJyA1gq
         CmZ7eVscVy0SJiwk5F1mx0SOLYEb+lM9TDIVS0QFC/oOtw3Wh7zTMyMY8Sp9TPfDhTiQ
         hGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739746240; x=1740351040;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwRpTiFhkazH7eZCnzFo4dfJTeXkjVTocPymKPEhdxo=;
        b=v+cjbNQpIAG0t7d7KhavjRSvFZp3yjbULsfudE7YpkxkI4MTPv+3mF51wJjkOlcE7n
         77OauOrG8KO04DlN23l7K5v3k5wRXeQE1/fyCTcFncC5YDa0Ylup9oDMC96GZ/KtlRUP
         BcruDKXHjLNnS1nT1JZJnWmEqn1W5MbA3jaPbyVpUrMyRBDl/96n0FjHLowW5KYcPjoJ
         J3EkMvnUOLmUEiMUyaY6Et10BteMM/MUTDqf+ocvB4242jGtz64hsqnjvDExYO7H/5cJ
         jWpJGgQinEAH+mMMOj1EvlfmglOuKbKLwtZS3gmoXojTScLyIWPuZQ6RqLmQ037n4eNm
         GbUA==
X-Forwarded-Encrypted: i=1; AJvYcCUph41B+DMA9yuboNms8DGnV6S2mu/wfV1lApzLtd4QwrK/MRIi95onvV3YTBVQFT/u/LP4hwel@vger.kernel.org, AJvYcCW1lMXeM8lCs37Rb+NpgnZQjcOp0pZtU6T9+Bo9f0HP/pt5ZDur1NGXeTxdmdvq7//FiE6VYquOANkHKPM=@vger.kernel.org, AJvYcCWwnuWSGhYx9AUXl4MOQedOKOgNSeKDz3twzMBQnxmvNLCnbVh4j850+pdy4HtA33c3T9/V9/kwX+oWdyfm5Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ByqjWu2yAMm06jFiIRaSg+IRkfmsEml1tIOf9esvbcH7OUAI
	ZoQS8d1nC8bweaH8+xoXhDRpYMMlVwE/+9ziTuW7hbTh6cjmRcLV
X-Gm-Gg: ASbGncv1iNFZpmI5vzYi/3Plgzbi61TvpoWAYNYqOQFGYEfhLpwWW47h6/es3WQG6ze
	wqY6FEJcLnasD0Wyqbla6klKsIrpIUsUr/wsZOsMpgLAavbu9K9wPCvgKTeYcnInHDmNNBPnUk+
	kR35FCJHgOSPNkJp4QddFRgQrsvYCAqHRytdgkhGhqIOc0+npoqovthtvsqhjUnJ4pzGwUKYbKj
	BUOEaxKtNLrjOXWRWGz8mT/HO2U/HK9m7/Pjl/GxXLf3+EgeB7QaRbjdif3AbtzRV+j+dVa+BL6
	FMgRrgakbP/+YeA6nEP3NtOzWmEJ/JCHfRWJCy7VltkDMwuZfkiokSfx4HYi9d4KcerFSx/H
X-Google-Smtp-Source: AGHT+IE6flqDwVsTpGpc3YTvZ/iHfBKBaGrBtHop4poOhkkBMwzDiFwM8gvHelDmDsGXIxZ3B+QX9g==
X-Received: by 2002:a17:903:32c3:b0:220:e7ae:dbcf with SMTP id d9443c01a7336-22104039c9cmr81807265ad.23.1739746240046;
        Sun, 16 Feb 2025 14:50:40 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536733fsm60448195ad.77.2025.02.16.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 14:50:39 -0800 (PST)
Date: Mon, 17 Feb 2025 07:50:29 +0900 (JST)
Message-Id: <20250217.075029.1780115689208398996.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CEF87294-8580-4C84-BEA3-EB72E63ED7DF@collabora.com>
References: <3F610447-C8B9-4F9D-ABDA-31989024D109@collabora.com>
	<20250214.131330.2062210935756508516.fujita.tomonori@gmail.com>
	<CEF87294-8580-4C84-BEA3-EB72E63ED7DF@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 09:19:02 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

>>>> +/// Polls periodically until a condition is met or a timeout is reached.
>>>> +///
>>>> +/// ```rust
>>>> +/// use kernel::io::poll::read_poll_timeout;
>>>> +/// use kernel::time::Delta;
>>>> +/// use kernel::sync::{SpinLock, new_spinlock};
>>>> +///
>>>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>>>> +/// let g = lock.lock();
>>>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>>>> +/// drop(g);
>>>> +///
>>>> +/// # Ok::<(), Error>(())
>>> 
>>> IMHO, the example section here needs to be improved.
>> 
>> Do you have any specific ideas?
>> 
>> Generally, this function is used to wait for the hardware to be
>> ready. So I can't think of a nice example.
> 
> Just pretend that you’re polling some mmio address that indicates whether some hardware
> block is ready, for example.
> 
> You can use “ignore” if you want, the example just has to illustrate how this function works, really.

Ah, you use `ignore` comment. I was only considering examples that
would actually be tested.


> Something like
> 
> ```ignore
>  /* R is a fictional type that abstracts a memory-mapped register where `read()` returns Result<u32> */
>  fn wait_for_hardware(ready_register: R) {
>      let op = || ready_register.read()?
> 
>      // `READY` is some device-specific constant that we are waiting for.
>      let cond =  |value: &u32| { *value == READY }
> 
>      let res = io::poll::read_poll_timeout (/* fill this with the right arguments */);
> 
>      /* show how `res` works, is -ETIMEDOUT returned on Err? */
> 
>      match res {
>        Ok(<what is here?>) => { /* hardware is ready */}
>        Err(e) => { /* explain that *value != READY here? */ }
> 
>      /* sleep is Option<Delta>, how does this work? i.e.: show both None, and Some(…) with some comments. */
>  } 
> ```
> 
> That’s just a rough draft, but I think it's going to be helpful for users.

I'll add an example based on the code QT2025 PHY (8th patch). It's
similar to the above.

Thanks,

