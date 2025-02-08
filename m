Return-Path: <netdev+bounces-164278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA6A2D358
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 04:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DDD3ABFDB
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 03:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858929D0E;
	Sat,  8 Feb 2025 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4F0oBfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76102913;
	Sat,  8 Feb 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738983679; cv=none; b=B2C4zUP4AdaaVPK7HHIKJbpwcG/imu72rogijVgHmc/la+XXvKq851vBQKOzMmQdcKmPRyFFXBuDahLR9gr2ZhZg0zfvdTRDq1aPrPidskFZw9mrzHnElLGrcuX1FtrvchzCFBWgJcZnJ2607kvsAWfgAXgiSm/dh2x7jikWp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738983679; c=relaxed/simple;
	bh=nqpBlydxKobQ/cURbEJgsLrhdk+IEA8jA8MlvsXzBb0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e8zZf1s1E4zJwj1gUZcSFDJ40k0mqKJKJ1Uwlr5KlYVnmCWb33ObBX+7llJZv2U9eT57OTVDK9NKNUnMJhP9jR2ZKHlMx2ZrQOkdaI10vOFMjK2pi4CDLRhwiz7wXFXG57z12KC2WV+kcH4Se45NDaqoXiE6YvY+IT8He1C9YTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4F0oBfS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21634338cfdso67876445ad.2;
        Fri, 07 Feb 2025 19:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738983674; x=1739588474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXzRRz14yqpIHofV/zFebh3y188Exztn/L4hTgRQI5c=;
        b=I4F0oBfS9q32sTW2rD6hPODZ5A6FMg3e7ajBi80RVVWObSZVsz1PqUXM1irYqwnmzy
         DOGsv+oa8deQ7gPgr3OWOQf0T20/M2sq4uGvfX8RzxS4NKL062WJMmdYpLkuXYrE6Qk8
         t0rkaeunDpJXs5tEE8IWvF0YqrVcS8eiq24+OgvMRsTtWQSscV/giC8DcFlupZArbd9z
         xXUL5lGf/1nj+J2Mms5B9miGMx99XMpcCo48rokcUlm4psCdoWSIMfs3AymLPKJ8HTRU
         YARfvDkGMTzx8RNmtee0NsYWw76/ayQ7DCWabB+uEhewKR1JXBHc+C4YHO+/ArmQvCpi
         jdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738983674; x=1739588474;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXzRRz14yqpIHofV/zFebh3y188Exztn/L4hTgRQI5c=;
        b=Z1x65kK+hSqcSB8JZDaZizeke3sxzI5Z5inU+Tixs7tEw4wtFWx2ONLfWV2mGsIqc3
         aWqiv7IZXJYWsV8M1I2v8R42TwMBQd6jxXKFHE/Mmn8il810wYZF26VSCWpFUkiYuXnH
         tL2GCSonf7RSHMlIrOl7qvliyMAfcPAmZY3X1dy9+hLbuxu4EZhmx2Ccq4/tev6WxVv5
         Eo2LFuLfFxaQudGBtTmBe8PU+9CCgr00slUOZfrWPm91Sv6vRwbUU8CTkeLxdO274pyc
         VJMVAH4KHt07nnywtbNeQQVaYntebsyCNLIkFr8MJAp0G1+CNlSgVrJcsyRAiECWqoj3
         MugQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj/w6iv9e32/dvoaMwC0yHja3l54rUmwQVTT3ZVDux98OisEQc7m3YHTvMWt21glHhIDxD1IwsiAweEOL8NVo=@vger.kernel.org, AJvYcCXhe7oF+6ylh6n0TzOFZ9cSb2oyjBTejTvNg1AdwUhOn6YNa+mKO4eRIE3vAy2cWsrNLf61Sevl@vger.kernel.org, AJvYcCXk3aG9tYiTds8yIrGQle1UXRuU2yq5LLqN+Bpe5/5mDV/taYd2Eb9x4u8Kfz8tLpH5GnsxDmiHgmCq7I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9SN7Ox268N30e5zTjEa8c/ARmVUfiKeQjtms1hVmXLFcdjSa
	uH/qCmnwkQaKg/UU3xq4iuIPJeY+r9ILeVohkl8aQ4x4iuE9ZZnR
X-Gm-Gg: ASbGncvZE9xPEM+8Phg/SSdqhzFotlatjfOHNHqiatVUKq4j7QCaev3GZGq5smgV1u+
	OP8LEOvCPHyZZOAocN4cWklD/104LBYGhfADszlHSMkHR50RtB5Xn0tqLjJdn5cVTEE3Cvh4I13
	xnFpCmHbn7E8T3srpAXPR7VFIBHdhxxsXXEFHVmXHPLhBGiU4vBqmxwCIpSd0q+8JdQfTY/OPD4
	teR2z2fHgF/ncXjRRuabVSKGr/pHtgVU8gCQLx1OMe65lnN/jjXuYe5nKHUAPO0ft7GrF4hQaHV
	KBBQAhVkgjj67fpRkxIB3NzQQuMfAk8hy+CTu3y1b0TUOxQzwpweaY9Tjl2+La1ZNjq0Vkw/
X-Google-Smtp-Source: AGHT+IHN/+0/7nmDB66q1zqOa1jqJWOSI2wBvJ26ODCFMTLzQXppEZWJ/plqUGTPn9EYqJl/M+dNwQ==
X-Received: by 2002:a17:903:2984:b0:21f:135e:76bf with SMTP id d9443c01a7336-21f4e6a9978mr87627755ad.12.1738983673897;
        Fri, 07 Feb 2025 19:01:13 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653babfsm37704355ad.68.2025.02.07.19.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 19:01:13 -0800 (PST)
Date: Sat, 08 Feb 2025 12:01:03 +0900 (JST)
Message-Id: <20250208.120103.2120997372702679311.fujita.tomonori@gmail.com>
To: david.laight.linux@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 1/8] sched/core: Add __might_sleep_precision()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250207181258.233674df@pumpkin>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-2-fujita.tomonori@gmail.com>
	<20250207181258.233674df@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 18:12:58 +0000
David Laight <david.laight.linux@gmail.com> wrote:

>>  static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
>>  {
>>  	if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
>> @@ -8717,7 +8699,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
>>  	return nested == offsets;
>>  }
>>  
>> -void __might_resched(const char *file, int line, unsigned int offsets)
>> +static void __might_resched_precision(const char *file, int len, int line,
> 
> For clarity that ought to be file_len.

Yeah, I'll update.

>> +				      unsigned int offsets)
>>  {
>>  	/* Ratelimiting timestamp: */
>>  	static unsigned long prev_jiffy;
>> @@ -8740,8 +8723,10 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>>  	/* Save this before calling printk(), since that will clobber it: */
>>  	preempt_disable_ip = get_preempt_disable_ip(current);
>>  
>> -	pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
>> -	       file, line);
>> +	if (len < 0)
>> +		len = strlen(file);
> 
> No need for strlen(), just use a big number instead of -1.
> Anything bigger than a sane upper limit on the filename length will do.

Ah, that's right. Just passing the maximum precision (1<<15-1) works.

The precision specifies the maximum length. vsnprintf() always
iterates through a string until it reaches the maximum length or
encounters the null terminator. So strlen() here is useless.

Alice and Boqun, the above change is fine? Can I keep the tags?

