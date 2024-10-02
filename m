Return-Path: <netdev+bounces-131188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA1998D23D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800FA1F2264B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148801EBFE5;
	Wed,  2 Oct 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euiWZPpY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB16912E1EE;
	Wed,  2 Oct 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868858; cv=none; b=IFVX22yuxdnLgHcq4cYMovPj9miLOi+prfQgPA3MBy4+H6rrHaacbYDB2mjjX4AvlmEx6o2FdPBMg6UH7VCuH5gTvwEF3smMsTY5jSTfCGBvSEyL4+Q63qUEezJ3oB7ij/dGejzop2I6ZdiUf0MdPXmDlzgytnYDtgIxrYe2ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868858; c=relaxed/simple;
	bh=xrbL4f0Csau8AQoU70hljc8anDPpL3BNCAFkjP/f4iQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HppcHodMQOuPhwHFVBBpAAUzi7TvHNgJ95ORsFdkNZg5sCMTxDueaJEe9mL3MUh9K7STaCQZ1zJGei+QlIfttatLSxeOXpUPt5zzESps8N3eSIKLx7EK67LkeZNS0P+E8k3Aty+L2I3oWB65he/onmAsBG7CB7C4fljP/0Z7RYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euiWZPpY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71957eb256bso5946234b3a.3;
        Wed, 02 Oct 2024 04:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727868856; x=1728473656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZbwF2h7bz9vSKjQPPkyuS+APH+Edec4tdIc4cAhkcQ=;
        b=euiWZPpYd5mSaCJ/8W1C5wHGa9L9mU1sjMWr0DHBz1/e8dl85b4QKscxyyRjLSrbo/
         YHk8tQIr+V8N2NL5Uvz0sF2pk9lblxxrutIX02rykp6egYiUFaISEdjTClFwqTZbPY0N
         Pe8gnvw9ZG6vO5+cf+hbfL61Sa+7iQpal81MfFnGhD7PkIN5atm8F/k8rwrZXuA2vcp1
         xgx4XqeVNNqEbBbtkN6NBSpiVmnvz1YAEopIxNau6EQLv4+ZbshqN5xVw3GNWSOIC7CW
         g2a8a/wTteRaZpJAu9Bi8nseQFXIbf8TAPCxjVyUgoklezp1s7WjS8uHeG1Ft5FlBrQZ
         67ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727868856; x=1728473656;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZbwF2h7bz9vSKjQPPkyuS+APH+Edec4tdIc4cAhkcQ=;
        b=NMbkP0xKx/XhD/skX1q2e0H8M59OqwmX4bbkQjKJMpXQ6dAhSgTTezIm/CI4RFdEWI
         7H8dWmBe8FH1hQ2eTRYPieDsbYtDB56hWsTQ2xAK3JP2dUFwz7c/MQBJKru5kTfbjoRl
         Hv8d31XS9rupb9pbt3JLpaEd4/jU0adQDEYqCin2j5kbd3ygXefrqmSS4cuRqbmgpTtx
         ooN9sCUxEEqrEU/DJNA6kLaU08IXL4KVwmOOue3SBjc9ZGJIizPDXY3Ern5+IOzppHYK
         ot9EQsz1kWAMJFTJFlWfjoZYybtaM66E5pyowheL7eHLRhSIuOrJm+EX7wx7vjiO38IV
         1gIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5tUJLSBtmPcY/llT/ff5eisi3Fg56bjGcX9UyTTZ2tz911CaAqWAWP5XAxHpfxbqlhJFRkr0=@vger.kernel.org, AJvYcCX+QZ48DRuPteXcBsP8cBYDzVgRBc/Ul1+pYYZDnQj8cCfl0LZ0A1H7nKvD3wgzqYo1assEBTFIp9X/xHDGlHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfS9+bDyFkY5CGM9biTKXWmi09VQcbp50AuTNYgFOM4slkzX7
	jj3Qkpb4w2m/XwDgdWiLfzMbKHt6fEel1vXSUb3WAntx8YQDsw4Z
X-Google-Smtp-Source: AGHT+IHTi4JN3GPUWmR/KppZrgLXt4FTlkCXFTdwqrUoVxSW4L7SWZupf8dBCpekkwauxz0hnlsaZA==
X-Received: by 2002:a05:6a00:2ea2:b0:717:87d6:fdd2 with SMTP id d2e1a72fcca58-71dc5c4c31cmr4610939b3a.4.1727868855902;
        Wed, 02 Oct 2024 04:34:15 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b7decsm9567796b3a.47.2024.10.02.04.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:34:15 -0700 (PDT)
Date: Wed, 02 Oct 2024 11:34:01 +0000 (UTC)
Message-Id: <20241002.113401.1308475311422708175.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
References: <20241001112512.4861-1-fujita.tomonori@gmail.com>
	<20241001112512.4861-2-fujita.tomonori@gmail.com>
	<b47f8509-97c6-4513-8d22-fb4e43735213@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 14:31:39 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Oct 01, 2024 at 11:25:11AM +0000, FUJITA Tomonori wrote:
>> Add an abstraction for sleep functions in `include/linux/delay.h` for
>> dealing with hardware delays.
>> 
>> The kernel supports several `sleep` functions for handles various
> 
> s/for/which

Oops, thanks.

>> +/// Sleeps for a given duration.
>> +///
>> +/// Equivalent to the kernel's [`fsleep`] function, internally calls `udelay`,
>> +/// `usleep_range`, or `msleep`.
> 
> Is it possible to cross reference
> Documentation/timers/timers-howto.rst ?  fsleep() points to it, so it
> would e good if the Rust version also did.
> 
> I would also document the units for the parameter. Is it picoseconds
> or centuries?

Rust's Duration is created from seconds and nanoseconds.

