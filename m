Return-Path: <netdev+bounces-135420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7A99DCE0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 05:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11482836C5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A819170A0B;
	Tue, 15 Oct 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcJDX5y7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6591170826;
	Tue, 15 Oct 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963431; cv=none; b=IZu0PN2maJoJtwtkFtLoQt9usHeY8fOPsJmd+U4eY+H5h2rPpwwPM7YFt8fLLiSzA7eTz6KgrdwRnyarRli+T884lQvGnqD917jzSM4dJ2uJssvTD19IvWyeaAzP5hxasYmJ5m2pNVfGD+4ISqOMK32pvGA1dsB5okPC3EC+E1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963431; c=relaxed/simple;
	bh=p8eCL8zTOrNqLHveTmywiY+WV2Z/TywYrJw+64IWD2o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U/XgpwgtJUs+UF2bOGQB4wvjq9g20F2X59r00cLlTXFXCO0BxtFHRxTv4spSXQfQnamkzXyd0b/ESkkvCPqidXzxmyynYUG+oa+2noUQ3khhP/Fwlya7wQdyRmJetSfhoA33FUz0W0mWDX6u80Iw32Al5F2V0GW3E6UG099cejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcJDX5y7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db54269325so4277691a12.2;
        Mon, 14 Oct 2024 20:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728963429; x=1729568229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMA7BZ9l18xTiRWfHB7bGR9DrxFbDaKU8n+tQGbmUBc=;
        b=GcJDX5y76KPUjj7ZOhtICPidWHlOCIjiKqySiB4bvhdnBCAZ8WtQ3eg8vu3DewHoFl
         yRNSvMoecw5LsTL9muaqtFs77dxeoe3JYlz47oRbP8kRY9HKSjZIm3yIpYy5CYGOeyWJ
         2dyEggIG3tmTyDH2B6RgCFyAo7B7b3e/Zac8b+ZapRYjwZ8P9rSQAiFFSnNdB2ojndoL
         UH0GRTXy+FA6bBHS3uxQ3QNRj4WOhqdiGR49E18ozJy2cUgK90AxWJ7gN2gxejD5HzY2
         Zj8WsHi5GbD5Vo0PD4aV0ToxiFtZ5kzPUGCtLk+kD15z1zo8GvXL1I1yHLKaguvU8pD9
         JqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728963429; x=1729568229;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MMA7BZ9l18xTiRWfHB7bGR9DrxFbDaKU8n+tQGbmUBc=;
        b=ZH8jnf/vapPjxAacryYaXh0iy4iq36F5brZa2ulbQzR/LeCnONxYK9b5/9nSdo2k8n
         dr7LonzsSU06/ABTAxry8sAJyKiQdWV9mj1liu1spq2XnTokkN8aotZ0DxejWebAUJf9
         gtpCJBAQGezKvlYrZZya//GnKYdHFxupXwvJ6OSyxQQsXe0wa9QQpEdNtlvnkuPU4bB0
         tmCuH1uVWjyuTCltp2BqdmvSboOPReXWGo7VqnN/Urx0dJn7EyIBf6Cp4fBeWtia92je
         PVzcRIertmt9vVseWJGWzcStJfnDSpp4iBSKOQhPlqSQxdCL+AWC8bj3YM4ZEhqvfyS8
         V0nA==
X-Forwarded-Encrypted: i=1; AJvYcCUZjlsGdfrK7fHhbxjmbU9sxtghuFkNXtjgmKAy0WQ54MEPtlKTHENw1SwnPSAwrjZARcp7khgE@vger.kernel.org, AJvYcCV4SzOT8NJ17LZNgJ4oh4y1O0IIxuhRSzw+7uyQQZPqqIkB0ia+Aer4ORaFcYL9YcQMIebb9LB34OPvmig=@vger.kernel.org, AJvYcCWfnVr55dATlkrpboybJ1P52MId/WcvpcnIfJyfH9UAYyhM0BrVYO4SAVsot7wW7IOwPoP9hUPLHpLBH464RGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4G/L+f5rncVHsnJ5pV+edma5MVqb8p6NJma9i7UbnnMtXQqZI
	OMvT/WKQ1YuftKrMxVkdyC2HQPFvrFwjZmxH3uFXd2I3JHjmV0km
X-Google-Smtp-Source: AGHT+IECQLHPiL9iDHyCf5oLwaH4Zy5gaAZOKFXnr/rJ2ec2pNxYmES4Jurmuzz/vFvQClYxa3bI4w==
X-Received: by 2002:a05:6a20:cfa5:b0:1d8:aa64:874f with SMTP id adf61e73a8af0-1d8c96bbbf8mr17325555637.43.1728963429035;
        Mon, 14 Oct 2024 20:37:09 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774cbcf1sm302353b3a.157.2024.10.14.20.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:37:08 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:36:53 +0900 (JST)
Message-Id: <20241015.123653.216260102436009448.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZwG8H7u3ddYH6gRx@boqun-archlinux>
References: <20241005122531.20298-6-fujita.tomonori@gmail.com>
	<06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
	<ZwG8H7u3ddYH6gRx@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 15:22:23 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Oct 05, 2024 at 08:32:01PM +0200, Andrew Lunn wrote:
>> > might_sleep() is called via a wrapper so the __FILE__ and __LINE__
>> > debug info with CONFIG_DEBUG_ATOMIC_SLEEP enabled isn't what we
>> > expect; the wrapper instead of the caller.
>> 
>> So not very useful. All we know is that somewhere in Rust something is
>> sleeping in atomic context. Is it possible to do better? Does __FILE__
>> and __LINE__ exist in Rust?
>> 
> 
> Sure, you can use: 
> 
> 	https://doc.rust-lang.org/core/macro.line.html

To get the proper file name and line number with those macros, we need
to use __might_sleep() instead of might_sleep(). We could also call to
might_resched() there to emulate might_sleep() but fsleep() works
without it so I call only __might_sleep() in the next version.

