Return-Path: <netdev+bounces-160495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8991A19EE0
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875BC1881548
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBB20B21B;
	Thu, 23 Jan 2025 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx/z1QSc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFDD20B1FD;
	Thu, 23 Jan 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617132; cv=none; b=CLaenUIxIcaCUls63kF6p/cY53FJGMbO8YSf/BhrARVBHNMMJH9KTVPFwEb5Z/AwrVq4A/lvQqUS0kmdMo4V4vVZKYAb+bNnPw8gnnROdJiqE8oI7OZ0M6O1ZRXYP7mvMpdlPHG+NZFoqJuN6289qfYilzGo/cSrZKLgcnHE5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617132; c=relaxed/simple;
	bh=zMv/TiG+ah/03Csaypc7gUgqfNDfS6VRfIl8Xy9TzZA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FO/sD5w3KzhN157ceMcYdq1rraJfNNRFxuZJttSvjEEtiJgIpvxNVNAHxA39kfPyXYUQUjRqExufb0AZFdIp+8ymWAQR5mjfY4KY0d16QqVaIKV9Kwf9+VcH7WvyFWl7F0fpXMUHxiRwis1yFHzu95qIUcAFhYSKUt2nNGgz1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx/z1QSc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2156e078563so7256965ad.2;
        Wed, 22 Jan 2025 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737617130; x=1738221930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mglLasBQ6UAhjc7fwRWJg6n/lLTMQwudiiJlW3FCDz8=;
        b=Nx/z1QScXKIyqYq9DXhb91qGg2ArOK7ZGRDLxkL26+qQ3wNisJeRbQQ4JN6lXNxWgZ
         i8tJpltseOCa4n6K5WKJHwRl7Flrd01MkUuJts6xaNW9ZNpvdhMByFE8bMNIlcYwA8+2
         2VWXAi0Br+oUjSqJvppWdyHqhLgTaPrkJPqy/Nbqdm0T7ZWsJGSLX02MaG6C6F+vwgJM
         Z869/DhZnVfayo6foux2wHl5QZ3xrDEsBXiE1Vg+zyjY2uh514WkCtycgKeW6H43+NTF
         nLdkGOl7NkcrrsSmhdh0hDb/EktV6kXsi9bXu7kpR9i3Lxb1D+NHAmLgSKHUeeZP8ZOV
         42TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737617130; x=1738221930;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mglLasBQ6UAhjc7fwRWJg6n/lLTMQwudiiJlW3FCDz8=;
        b=N23164FT2o1yAlSP4zqShFNnquU65yiZSE+g8hOmnc/pNJVow503pu8pvK93v0LHGX
         te6nQ7OcnIPnTyu6nTBmDbHlIVf0Q+5bmjvDDDTwVZm/HLSa4uO+KEmXOLa6kk6PJWKo
         1hVixPswjblxk/d3oT7zL96r2hQEZjqZUnYSGvAoC/6Oh0AAg6un0tmyf4Zk+/2ZgyYK
         FQGD3KWLsjTm+MaadZAd1jLmEwgpzBH2213Ml1/CN2jdTJfp+hqoBsXhgKJNqLojKiR/
         eGiL4JcFKuvQ8J7ly+uMpFR+kE7/0kUJwIiGgmq/OR6USY96BLGnW+APZcyYalcGasMv
         Dqkg==
X-Forwarded-Encrypted: i=1; AJvYcCWxOKF4VuTqHYPGhoHGa4xJAVobrjprESK/oQDgiU6sP100LudG4ZmiTgYc1MZJqH+QzSxrCkQVLBK2+Xc=@vger.kernel.org, AJvYcCWySmm6W3iHPMpvkOt7YHZMksl7FMA21iMZzVV1BKLq2tAFJJZ6fS/sJmIKR4N8EsGu96gq1ANo@vger.kernel.org, AJvYcCXEKqVLenDBISJZ8ZyoWoJMZBQWoGb40v3jh7pR6B2jB3QW/WV+szyHBpT+RUuOXHjnbLSuSl99FTDe2dQ5cq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1R24lRgC1fcVEntrN9EUlX2jVAd82yhFy+aau9yHHQiLGR0ig
	1w8GtoLUJHtuQ/9daqOgSRK9PDX6geER1vfjhckFuK9lSAWbLtvA
X-Gm-Gg: ASbGncuO8sbh8bs6r6x4NX8dDPJZGOBMzPCEs7IAoQw6nA6srS2RoR0oVQriUul4C8w
	s2J8bX8zZG3YC8iKX/DjQGGuZnF4tL4mBb22QoqgAUDY5FA8PfeXi+MUB376yvk8rD2F1bZMiYF
	GTMRY+vWYewHuo6J/p0fkgZczZuQzl7WRPhxa6dpXXauxvovZ4kEafgMiQxbj8Z7Bl8F+XqjnVa
	rGiVqeDLVXm2omk5MU7zwPQrZzcx2VunYHRczHp5CaHItyFxKIDsy+jHDec1nfXcv/657uHUmJw
	s+RWJ2hq2we2W/pVEkQT8Gr4A9EFT1T/sBA+E9NChW3bt8CUpndrMPs2+BW+aQ==
X-Google-Smtp-Source: AGHT+IEH/Wi3WdaSKzSPl0LEqkocaSd8XuIkzat23e7beAx1OP2VoOnLU1WfnqycivkxABnI19OnRQ==
X-Received: by 2002:a05:6a00:448a:b0:728:eb32:356c with SMTP id d2e1a72fcca58-72daf97a62emr35484219b3a.11.1737617129851;
        Wed, 22 Jan 2025 23:25:29 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba4895csm12693767b3a.130.2025.01.22.23.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:25:29 -0800 (PST)
Date: Thu, 23 Jan 2025 16:25:20 +0900 (JST)
Message-Id: <20250123.162520.1427672620079645345.fujita.tomonori@gmail.com>
To: gary@garyguo.net
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250122183612.60f3c62d.gary@garyguo.net>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-7-fujita.tomonori@gmail.com>
	<20250122183612.60f3c62d.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 18:36:12 +0000
Gary Guo <gary@garyguo.net> wrote:

>> +#[track_caller]
>> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> 
> I wonder if we can lift the `T: Copy` restriction and have `Cond` take
> `&T` instead. I can see this being useful in many cases.
> 
> I know that quite often `T` is just an integer so you'd want to pass by
> value, but I think almost always `Cond` is a very simple closure so
> inlining would take place and they won't make a performance difference.

Yeah, we can. More handy for the users of this function. I'll do.

>> +    mut op: Op,
>> +    cond: Cond,
>> +    sleep_delta: Delta,
>> +    timeout_delta: Delta,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: Fn(T) -> bool,
>> +{
>> +    let start = Instant::now();
>> +    let sleep = !sleep_delta.is_zero();
>> +    let timeout = !timeout_delta.is_zero();
>> +
>> +    might_sleep(Location::caller());
> 
> This should only be called if `timeout` is true?

Oops, I messed up this in v6 somehow. I'll fix.

>> +    let val = loop {
>> +        let val = op()?;
>> +        if cond(val) {
>> +            // Unlike the C version, we immediately return.
>> +            // We know a condition is met so we don't need to check again.
>> +            return Ok(val);
>> +        }
>> +        if timeout && start.elapsed() > timeout_delta {
>> +            // Should we return Err(ETIMEDOUT) here instead of call op() again
>> +            // without a sleep between? But we follow the C version. op() could
>> +            // take some time so might be worth checking again.
>> +            break op()?;
> 
> Maybe the reason is `ktime_get` can take some time (due to its use of
> seqlock and thus may require retrying?) Although this logic breaks down
> when `read_poll_timeout_atomic` also has this extra `op(args)` despite
> the condition being trivial.

ktime_get() might do retrying (read_seqcount) but compared to the op
function, I think that ktime_get() is fast (usually an op function
waits for hardware).

> So I really can't convince myself that this additional `op()` call is
> needed. I can't think of any case where this behaviour would be
> depended on by a driver, so I'd be tempted just to return ETIMEOUT
> straight.

As I commented in the code, I just mimic the logic of the C version,
which has been used for a long time. But as you said, looks like we
can return Err(ETIMEOUT) immediately here. I'll do that in the next
version.

