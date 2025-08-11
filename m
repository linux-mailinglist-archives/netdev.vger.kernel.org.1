Return-Path: <netdev+bounces-212395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4ADB1FD8C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 03:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC35F173C36
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DAE2264D3;
	Mon, 11 Aug 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irEeSlYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BE1581F8;
	Mon, 11 Aug 2025 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754877221; cv=none; b=quqRfzjHWOT6yptA3otHycEGukkhWBW6yA0ziekLtW+dWrFIbyyJICgzYkhYKq/GCCPCD3Dmj+PGutdpnv/FXJovb0LJvyfbbHKPN5nXbC2af4AUdaTYovs765oc6M32Qry727AIuA58A1GjOyati+htS/+ttcxFGeOb9XkHRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754877221; c=relaxed/simple;
	bh=4DvNoUFhbxlMFcdamXwbz2OHDWNZVfjnAN9mIvUd224=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FW5YTA66az01wllfvL8mQvrTCC9gXZ+0gGOhlGRL5SH47Nhy4qAK8/30UNpIxo822+qlpgAc5HSeAkupJu7KXlykwD4LioSpFh7AQMIlwtS9IUYGkquEL+CtGLyWIudgrIpNK80VbQoq/zHu1CwYH94SbMfCD7cHeVEDKwCBdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irEeSlYz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24003ed822cso21926395ad.1;
        Sun, 10 Aug 2025 18:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754877219; x=1755482019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziBLjYfFtJCisSNX2VUBvLqzkZm7Ob1xtTc3XAKbHy8=;
        b=irEeSlYz86vXv+gVVCRRPnijV0dDTZK8OzR/PH6WeZ0cAEKMqaOml3nNd7DqOTydy8
         G7ueIGA8xUB8KBcdww8OK+44x/dBEXn3Ue/lZKVWOnsunS9iF9kFJtFLzt8V7ZN3W8Cw
         Ds3B3PSR6xyizdySN/nwCd633m8PGUpCcRTLziMgtJwqj5Uj9pGEfDSbknJRIWTSD/GE
         ULpFK1ZngWAKQkYrDGSukjTfxC+FNNwH9sQvCNoZ/TYu1d9lXPFtTZDJuRZSFw2ZQl16
         zk7Fq4m8jM0UxJt6s+g0FrulHIXqdDtwe35ZQjnqie6DVcwQDeu34NpT/RZ2j9CmyoMF
         aBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754877219; x=1755482019;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ziBLjYfFtJCisSNX2VUBvLqzkZm7Ob1xtTc3XAKbHy8=;
        b=kuX8BcOAEYy5UEXnuCUiCk8M4sURQ8jNKxe4yhzoEocUCIA2ojU9GcVcrhlVtL2AjL
         5YTTkz+h2bDDasMBV9XcPN4vEchG6dUcXwvbmj3HNmGRcUEO5xaaUjBkHOAjpdfSghk5
         Sz/9WvOIac5xOEvkl4GIwpYXy2DOGSyejIZkSG+XjcPJxma5QCLagHFkup5FkGSTkcXV
         96jAhfvzeVkkftVgYMhhC7A/9+L0fLphw+Mn9VxubDaBflFqhrNUaVBTRHusoepZ7XjZ
         n7h8Dq3Sfxv8IpaDnevQF82HIxVfu+RDrxcblIFxjbY0n4PQvjk/+ljxHop5FrMd5ldi
         5/dg==
X-Forwarded-Encrypted: i=1; AJvYcCUgy6NFJ20b4w0KPXSbtDWgrs+JtKYuJvcl5Swj6xcmblDC+LUU5try2WWjs+V0MsVxI26usQxtZHk6GuD4maw=@vger.kernel.org, AJvYcCUlSE3h9uYfi6mB0DunKeKBQ+ARU1VDdz3zLBCoxSzP4M3Qwmdu2uT+NxtzLuhv0OhvI98dzlpF@vger.kernel.org, AJvYcCW3AG2lRDzTCeIF8FjA9DNUa4BF8RsCF00UX7aviduMzURc2mWrstjL3IoKkv8eiepxwsDZR6InyaZTQmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46LL2hFrSxRt/b2W/5KZkPrMJDj7cmvznyECWGlrQuKBFt+0x
	wOt8qMgCtQCmskXmNy1QARy6xU7ZOeBtNgSDPwC43CB5YaDXPI/2bdJf
X-Gm-Gg: ASbGncseXXw/pouLAA2ijX4d4MkLWzxoDmg6Ly8QnJzFIFKzb2w3tuWn0w8mplINzLc
	n0ZlN3UPsolKUw4IzrPzzoP38nG2CLBjh12q227VcnOlc0rrtyRUps7gTfoxruhVKxT4ppQY1T+
	qwT8hwZvMTlWJAj7k0mq5iI7CGh5PeI2R8KDhqDYNkHFKYgWnebMs6xB3gXKVqIkq9SY6JBQhDw
	EMJa8JfAeOLzN5o+dqrfS/ZPXi5HsHD3gOJ9kcrQGpkEU7fxloPzCP36zA28/GyQyhTq4iPHmkS
	McERWAcRQ0WAOkEKjivZU35RK134KykNFa2xlBSKrJYr49ZYGxfkihBmpQs8xIK660E5umLnePm
	O5kkwPwXNQ71yuesLul265dvVpG/0pc6xh/2WXRMJXMFD6Jz8hVuFKjxRfKHKALBLkfkE3ZoDE8
	yL
X-Google-Smtp-Source: AGHT+IGxJNlNVh+bHpFl4YYFftkqDi9J35S5pIRmYVj7AzYswK6YLiSL/gwFEdmTOk3P8LHeejf3Qw==
X-Received: by 2002:a17:902:dace:b0:240:3e41:57bf with SMTP id d9443c01a7336-242c2003f68mr158953465ad.13.1754877219372;
        Sun, 10 Aug 2025 18:53:39 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaf87csm258762345ad.176.2025.08.10.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 18:53:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:53:20 +0900 (JST)
Message-Id: <20250811.105320.1421518245611388442.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87y0wx9hpk.fsf@kernel.org>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-8-fujita.tomonori@gmail.com>
	<87y0wx9hpk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sorry, I somehow missed this email.

On Sat, 22 Mar 2025 17:02:31 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

>> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
>> +///
>> +/// It also happens to serve as a compiler barrier.
>> +pub fn cpu_relax() {
>> +    // SAFETY: FFI call.
> 
> I don't think this safety comment is sufficient. There are two other
> similar comments further down.

Updated the comment.

>> +/// ```rust
>> +/// use kernel::io::poll::read_poll_timeout;
>> +/// use kernel::time::Delta;
>> +/// use kernel::sync::{SpinLock, new_spinlock};
>> +///
>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>> +/// let g = lock.lock();
>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>> +/// drop(g);
>> +///
>> +/// # Ok::<(), Error>(())
>> +/// ```
> 
> I am guessing this example is present to test the call to `might_sleep`.

I also guess so. Boqun wrote this test, IIRC.

> Could you document the reason for the test. As an example, this code is
> not really usable. `#[test]` was staged for 6.15, so perhaps move this
> to a unit test instead?
> 
> The test throws this BUG, which is what I think is also your intention:

might_sleep() doesn't throw BUG(), just a warning. Can the test
infrastructure handle such?


