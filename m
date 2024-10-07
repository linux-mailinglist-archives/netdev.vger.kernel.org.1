Return-Path: <netdev+bounces-132587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7299245C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AC31F22A1C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010B136354;
	Mon,  7 Oct 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ6H+DAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CB13E898;
	Mon,  7 Oct 2024 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282287; cv=none; b=KanOrRU5tNunvfFJMscgQiIHUnUUuG0c7qhTOZ8v1y+9LMPAUxPZmyJzZTp90+6Dn9fclMvtvSQCY3qOEbfy+3CJj4oIzf3lamgbfuBhw7obtmUAluxAedHkJHPsbCiELzuqpbpSO8MPYle4oXJM8ZwHIdubsaUBhvIzObHzkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282287; c=relaxed/simple;
	bh=vVx6vw6p04ZuzWeCVho/g2C+DdXaqDarfOAqlHlcMaU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MkTaXglmZhvMwLkifOZEBOTdrs/ZfG7QuXel4YkhItZf1BI2ARQJd59cIkhBDnZYBP9VTTpBZVVzBMN/bK91E8K5jrVehr/wYzNpPLhx4ZWc+wAobbN83TTflqaRV4lwQJNnCiw2irLCNv3qAl0aHF5+FnrfIhXgjtv1hLq+wBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ6H+DAE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71df468496fso1541634b3a.1;
        Sun, 06 Oct 2024 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728282285; x=1728887085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rTG3xH/+Bc1tN97bVF5g+Nz5hBEmPnUqIhfBD3zpkk=;
        b=aJ6H+DAEQdIU6AxAj7NlYciIr1bYv5qP4RPpFDQr65uMpA4gooXXykj/z6xbtUWRRR
         jjX3YWCmYpBZIcVZ9ETgufA7DTsz5i/jj5Jch0+MHYj/ehTVj9poCn3TMqYlpNH143Qc
         pQV9waeaB9MkTyfZbvXCj8T5NxKYTuoR9UScaV/BA4r9bJLJQUx9F+2GLGzBAPHhAEC3
         aIv4nR+XgjA6If2+cimrBeT7WT/WQsY2p22StLlakVcax+blB6V8yd31AqFEm9A0q/zr
         wSxvTdGW1gocOIt0LauqkeuMBRQwNhZelL8Emb7W+YJlpMzAJ3jQ7tUKkwS38JK9fR2P
         tazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728282285; x=1728887085;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7rTG3xH/+Bc1tN97bVF5g+Nz5hBEmPnUqIhfBD3zpkk=;
        b=JDfpiobssJkJtJ1rFDhG3uTVotcv73ir3lQz/t4fUKfGW4E1Gf2pWhY/Jxm4mZ1LFy
         0nCp8AO8PXJCothEwKl8qYr3xqGfNJ8GdgN5w2m2t2rVJm0aFFVwCUYjVDAofz+UNRIT
         yvMsT0Q0EyqDyDT3RLYYqeamkguBaBqktOTC539NsKmWXcbv7zzM49RZJMe3B7SAFCdx
         aSc99iR09orRh1ALyHdPtQ4o2V69mR21miCTJeG5yIZHLGh5u7Jng0PUb+Y9Uy1jhqR+
         6lQyCd3XgXTOYQ+RBZxrutx4JbSzXZs7KVTQyC/EahHq7vu3lTnib5m3ggJlBRy2C1F9
         VKHw==
X-Forwarded-Encrypted: i=1; AJvYcCWWsBXakHvlPx1A+Tr4SN2NXNiL6ul8ZLmaT2S+UcaB8OPnKLwZ/FFUGzGczeWxjrhyQISevi7Ol6mHnGaTx1Y=@vger.kernel.org, AJvYcCXH7Vo/irnPklnce777dIS6cW2mokf0CCpcvqMY7E8A6wOyvlVipvU+7m1Jxi0ouTlzu7rotsrQycg+LHQ=@vger.kernel.org, AJvYcCXVslpT4O2o7GQfnm9UqoSJ7FAfB+ZAAiACefdixN7Tm8iSeBTfj2xxtiSIvYvAkIzr3uOOiQZ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26wt1dFSx7DBLYp6Vly19tl4s131+ots44dUTMUzvzv9G/hul
	heLDc6lxvn0DCmgdYvLtxYhSCS3GbBG3tefsgNcMbyXrXo4xto9A
X-Google-Smtp-Source: AGHT+IH/c34EHU+LsPdI6du6yf4SIYqk9lMxCoeMkVYb8PkKAc1OFlmIQ5N2gvMnR+zGznmjvy2x2Q==
X-Received: by 2002:a05:6a00:3e06:b0:71e:c6b:3b38 with SMTP id d2e1a72fcca58-71e0c6b3e1bmr437842b3a.27.1728282285207;
        Sun, 06 Oct 2024 23:24:45 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680d8ddsm4211423a12.4.2024.10.06.23.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:24:44 -0700 (PDT)
Date: Mon, 07 Oct 2024 15:24:32 +0900 (JST)
Message-Id: <20241007.152432.1129805535833902448.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
References: <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
	<ZwG8H7u3ddYH6gRx@boqun-archlinux>
	<e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2024 16:45:21 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Sat, Oct 05, 2024 at 03:22:23PM -0700, Boqun Feng wrote:
>> On Sat, Oct 05, 2024 at 08:32:01PM +0200, Andrew Lunn wrote:
>> > > might_sleep() is called via a wrapper so the __FILE__ and __LINE__
>> > > debug info with CONFIG_DEBUG_ATOMIC_SLEEP enabled isn't what we
>> > > expect; the wrapper instead of the caller.
>> > 
>> > So not very useful. All we know is that somewhere in Rust something is
>> > sleeping in atomic context. Is it possible to do better? Does __FILE__
>> > and __LINE__ exist in Rust?
>> > 
>> 
>> Sure, you can use: 
>> 
>> 	https://doc.rust-lang.org/core/macro.line.html
> 
> So i guess might_sleep() needs turning into some sort of macro, calling
> __might_sleep(__FILE__, __LINE__); might_resched();

Yeah, I think we could do such.

Or we could drop the might_sleep call here? We might be able to expect
the improvement C support in Rust in the future.

