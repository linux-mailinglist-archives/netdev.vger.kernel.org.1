Return-Path: <netdev+bounces-145863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01D9D12F2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B60A1F21A5B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722031A0B0C;
	Mon, 18 Nov 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="DqaK7Ec+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83E0DDC1
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940117; cv=none; b=IeFx2aw+iTQBy7nXO+Rs09fJm7UsTryl4Dm9/pu2C9D4vIwZnCeAio5371hIL871iTsoNDL9LSOND6pAmP9fq6p2jJm7ZTjAyVSJZeRNEp8MCzoR6nzG09LBwAlBCCQpcU8oFEldFCc9J+DDG+ItdC6CFkqlYkEEQ9i30i9TYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940117; c=relaxed/simple;
	bh=wdVLGAc1XWsSG5qAPwHUk3JBsnbEkFb8CKQE2ZmKQ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWRPgk84Y62zlBra0KQsmXY0NV/tXNj2o1Pjm23WveDCjE5AUFxn55g3icoVo0LHHSd8p4BmsqwzJApneR2RPHe9PmVsV4Eva/egCc23biG3RGLsO+won7Fpe9HISv/SFvERlHLdEoejTkmgzOg5sdXeTuacbnVMf0xXlQ8Yb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=DqaK7Ec+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7206304f93aso1574459b3a.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731940115; x=1732544915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ/OAdBG5AB8YI4ghzNAiU9cnKHlbBpEeuCaXgo24T0=;
        b=DqaK7Ec+QPGHa9mZI8jSXmw36b84sEyxgiJHXIb0mxWunVs4sHZsF7zovfcCbg+6ts
         2qjQG6oniC9lf2bS36I+MH4GIHZbd/436ZM4G6rMJ1OsSQya62CbsbkEeoL/t1umk9Cz
         mQSZrum4UqIgPU3ndJhh2CPYa3+W3dzVNtVqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940115; x=1732544915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ/OAdBG5AB8YI4ghzNAiU9cnKHlbBpEeuCaXgo24T0=;
        b=iV9TaUMApx38U8abtSDUetxt8z1m8qmMrMqIEfQQdkM2t9TcRp5nGEhHO/evuwmGMf
         SKYm8xzHa6+4Y3e8W1M9UNQ1fvCzRxjZ6kBdE9aSFbvLWqNyfLhKTteEY53tIHHtzCux
         wckW2xLgzMeg0o9y5EsXkkTEZ6kZ+w9grdexdmC3HW51VxzWMoNKyvYBMnJ8Q1+xaDMb
         I99PCvvR1rcS0viQc3KsoHrHngj0PL6yElVr861qix+D7g1hPV9zmRf4YYvyVnnhpZGn
         R4kxWCQiscRwQD8w4ogxY7+sBks2BvnNkbgPe7JNG7UGiJ6Vv2BnWbhfevZM1YgPsLEW
         GjnA==
X-Forwarded-Encrypted: i=1; AJvYcCVVjPYHc8gqSx7ox9tpCaDSunEgqINiF98+4Qq1zuNzt8+2q3LaYdV2eg7d7ZLznHeHKIsfL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwycgwMlnSb18YJ6c7CLtdOXnE7LQ2veIuUbV9igp1gTPlO2iJ6
	G6/pvRv0/ES6JhwUOtdJayIWnoW7QwJz5RS8MvURKtc9klHPtA+Pj4+gIL+p5P4=
X-Google-Smtp-Source: AGHT+IGmrSwC5OOr5CGGm+qfWv1p8qUdKfi5IPTRczbzTJTNgxVyziglqADNl9EoIejb73uMCQdBzg==
X-Received: by 2002:a05:6a00:1488:b0:71e:104d:6316 with SMTP id d2e1a72fcca58-7247709d4c1mr15508159b3a.21.1731940115150;
        Mon, 18 Nov 2024 06:28:35 -0800 (PST)
Received: from fedora ([103.3.204.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d37sm6431267b3a.104.2024.11.18.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:28:34 -0800 (PST)
Date: Mon, 18 Nov 2024 19:58:24 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qt2025: simplify Result<()> in probe
 return
Message-ID: <otjcobbaclrdv4uz3oikh5gdtusvxdoczopgfnf6erz5kdlsto@mgpf4mne3uqb>
References: <20241118-simplify-result-qt2025-v1-1-f2d9cef17fca@iiitd.ac.in>
 <2f3b1fc2-70b1-4ffe-b41c-09b52ce21277@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <2f3b1fc2-70b1-4ffe-b41c-09b52ce21277@lunn.ch>

On 18.11.2024 15:15, Andrew Lunn wrote:
>On Mon, Nov 18, 2024 at 06:39:34PM +0530, Manas via B4 Relay wrote:
>> From: Manas <manas18244@iiitd.ac.in>
>>
>> probe returns a `Result<()>` type, which can be simplified as `Result`,
>> due to default type parameters being unit `()` and `Error` types. This
>> maintains a consistent usage of `Result` throughout codebase.
>>
>> Signed-off-by: Manas <manas18244@iiitd.ac.in>
>
>Miguel has already pointed out, this is probably not sufficient for a
>signed-off-by: You need a real name here, in order to keep the lawyers happy.
>
Hi Andrew, I did clarify that "Manas" is my real name, (as in what the official
documents have). It is not a pseudonym. I am unsure if I am missing something
here.

>Also, each subsystem has its own way of doing things. Please take a
>read of:
>
>https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
>    Andrew
>
>---
>pw-bot: cr
I did take a look at the subsystem docs. I added target tree `net-next` and
added all prefixes. I thought `Fixes:` tag wouldn't be appropriate here.

I missed the Link: and Suggested by: tags as I was moving from v1. I will add
those.

-- 
Manas

