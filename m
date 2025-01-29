Return-Path: <netdev+bounces-161441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF8A2171E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 05:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD60F1888839
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 04:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642ED18FDAA;
	Wed, 29 Jan 2025 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzYhvM8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC89EAF6;
	Wed, 29 Jan 2025 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738126406; cv=none; b=DwqX3phR5e+gucyVbwVYuiwF9XOUyIQV5zFURhIstiwktteaNx6oB356oMoUhl6uxXuTWM/FcUwsfSvIFj4Rq6ggwAR+g/6OVx1eTa7ogSeZNVfKvGcipPaxHl1C+m+M1U5fr6krpMIu5IcjPvhIjEiPJrKlBdf+G1Oz9bukSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738126406; c=relaxed/simple;
	bh=PQrwViPX+P4KorQFpt18OZJgQREgC+pam/1I93JdGAo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ApPwmIrUdaagXqibyHU+hGUlK4zfYI8ysrRp7XKnHw8vqM7FXAUhL/cdhFrlpwa+vvAXQM/lXA+SEXjb6K/XjyqBTu4vKVBdfWbKr3vujd1CNyd1pEugXVk/rVkf1FvVkapYzfB7tfuIeCGhRYcCOP+jF7muMl8mCRmyFn+BNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzYhvM8f; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso8684617a91.0;
        Tue, 28 Jan 2025 20:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738126404; x=1738731204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wj68xuMpyc8eeajKO6rM3brzonqTP4tUeDdeWnfedzY=;
        b=mzYhvM8fptF4tkqGrWEqm3/sqWj46IOz44wHAHTdD54qj5lDOZZY50kKoLOycMVscG
         i6RXfiKlciCOI24tsi3v9ylh6wr2Wb0ze/ZoHJEUSTOh/r7pa685b4KBvbJ6oewON0Xv
         O28BPILqVfx2KuRMAxluKYacq6P7NdTrKTNcXTxOdJLLK61OFTQ6rrWOANKjcNYTEMDP
         brgyFatUwwa6YPs1wZh/zGrA4mafTCj7b+kpoFvRPVUYOgMqS5CjKbzXUbFgh1OBUCew
         HXcr01sDoYwAipQ/jRwiGVDsCNqrWhAicBuwSOxOSvafvVBk7I7wRMrRT/nBdrfNzVMV
         gmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738126404; x=1738731204;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wj68xuMpyc8eeajKO6rM3brzonqTP4tUeDdeWnfedzY=;
        b=vWFzKwflke0jEaIKKtc77mQAAL224OEWKLyZ+54WYXSzb4Ip4OthVj4seRoLkxz9sr
         tJnlVetI43HrOO4X1dedozhFHby4bPPx3v9mD9s33RTglFS10z166UfoG2NESgJSj96z
         oawrWb+kQrN+PCDsMvxGUO9b99amxQ9ZbyuoLU9wdEok8U8jE2Q8FHaLhNeB0rEJqImV
         n5f2cdStvtkXYaaUWSlkYWkiyZ4g1MnD2wZvkDSSGW/Rv2av8zn8gv+KhnEh/NzAALH5
         HMnnspxJ23E4RkV8n26ROZDMRdafctXwDNZu2ZvtjvM2MQs3VWBw8m7L3Jngebv3Sb2V
         WgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0zZrZ3rDM25kR0DlzjHB7k77pBLR4hm4UjFE0oOvla09zlUa/oIVO7RKFHCG9nSoPU2gCAvMlyf6ELamgm1Q=@vger.kernel.org, AJvYcCVKZK6sU+4E8FWJR1FLES0FZg7wqaqnEdvS8RCNTuE234jXT17b/bvD1INb6iQ0x3J2tFEyHolRx70fqEI=@vger.kernel.org, AJvYcCXV5DTvHGxWVIEj8BvZoawIBVlxpsU9exFaG9foRQRNALQzDiPzCqzVyEPif1LUNOQIRy3gi8Ff@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXIJKTVsL48yMDFlfzdOsZ1Oz0qM4YjFaKoqqMuW2C5eH5F57
	VsFJEdPGTftkTl1tV39R7Cm+Ivkr08/noHBD4btPnT3Ybp5PMfi+
X-Gm-Gg: ASbGncuqkC6EgFOxHhZ9K7LbvU7zjhsJVebV1vhoLwzcctr5ALENOcx4aK6izqOEhuw
	5JaEuRbOqFovUiJBg9tByFgPq6AroyWg/lH5+Ua8pHYLAWHXJCQ9RfDLckPC95K1YrjlMxDwMJj
	w6mg+PF8Y9XrUkITRwd5ZiM0B461OmstxA1+KMaqt91InBVXWObu7rkuNWPvAXtEGdSJA7lvITl
	aOTgBYfvXPoBOCSceV0vf9hxPgQzP5GxvjfTtOVAg/gJtzVaf9KiO605YjQEZg4p1GOt+gjXL6I
	woWNyBDWnZBTEMcltyJbv2uYV/D9f4FICgJ7OPX16N3hrt+/pvz0i214KIu8FBl98bFAQiZx
X-Google-Smtp-Source: AGHT+IE+6GDySKLWFehtg5BU3TEoK/x+oFSoNDQf7kBqlMoTTGBISDwj216EkhVDT8Gu0ojB1c/hrQ==
X-Received: by 2002:a17:90b:2c85:b0:2ee:3cc1:793a with SMTP id 98e67ed59e1d1-2f83ac89f6dmr2515150a91.29.1738126403991;
        Tue, 28 Jan 2025 20:53:23 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd0ce4dsm518576a91.27.2025.01.28.20.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 20:53:23 -0800 (PST)
Date: Wed, 29 Jan 2025 13:53:14 +0900 (JST)
Message-Id: <20250129.135314.187500982981537852.fujita.tomonori@gmail.com>
To: me@kloenk.dev
Cc: fujita.tomonori@gmail.com, gary@garyguo.net,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com
Subject: Re: [PATCH v9 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <64335523-D12A-4E65-9518-64FC08C26D39@kloenk.dev>
References: <20250128084937.2927bab9@eugeo>
	<20250128.152957.202492012529466658.fujita.tomonori@gmail.com>
	<64335523-D12A-4E65-9518-64FC08C26D39@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 11:49:48 +0100
Fiona Behrens <me@kloenk.dev> wrote:

>> +#[track_caller]
>> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    sleep_delta: Delta,
>> +    timeout_delta: Option<Delta>,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: FnMut(&T) -> bool,
>> +{
>> +    let start = Instant::now();
>> +    let sleep = !sleep_delta.is_zero();
>> +
>> +    if sleep {
>> +        might_sleep(Location::caller());
>> +    }
>> +
>> +    loop {
>> +        let val = op()?;
>> +        if cond(&val) {
>> +            // Unlike the C version, we immediately return.
>> +            // We know the condition is met so we don't need to check again.
>> +            return Ok(val);
>> +        }
>> +        if let Some(timeout_delta) = timeout_delta {
>> +            if start.elapsed() > timeout_delta {
>> +                // Unlike the C version, we immediately return.
>> +                // We have just called `op()` so we don't need to call it again.
>> +                return Err(ETIMEDOUT);
>> +            }
>> +        }
>> +        if sleep {
>> +            fsleep(sleep_delta);
>> +        }
>> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
>> +        cpu_relax();
>> +    }
>> +}
> 
> I wonder if it makes sense to then switch `Delta` to wrap a  `NonZeroI64` and forbid deltas with 0 nanoseconds with that and use the niche optimization. Not sure if we make other apis horrible by that, but this would prevent deltas that encode no time passing.

I think that there are valid use casese for a zero Delta type.

About this function, using zero Delta for sleep_delta means busy
polling. Sevaral drivers use the C version of this function in that
manner.

Using zero Delta for timeout_delta means checking a condition only
once.

