Return-Path: <netdev+bounces-168503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B568EA3F2D6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105F2421890
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7520767A;
	Fri, 21 Feb 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0fi/GNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F420767D;
	Fri, 21 Feb 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136823; cv=none; b=Gj7qZbFVMVVQEt8eSzWshzRHwHF42eTjMlJWlKDwPVDlXnI1AFV1tzEkyyY3HkgDEnrDV4OBHIlheHBPv0l6Qt0cKBwsDf+OXmL+ZoH6z6UjXSGHqGyXcVbiHHn08Ueo8jNyK9Nm0TQlGbF/28vq1RqOf78vAVedsh695ulP2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136823; c=relaxed/simple;
	bh=WXdkwW007G1m6bXm6oWmOyrzWJ4nJAdxR87vpm3yhA8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tVDNQ/4XXrQAXqO946I5CIWHV5JNBnH0xt29wjBPpt0iekxy5FocOGX+RQMDIwonxFLwICVmCxbThBKy5q9odIyqtipzZxFwOAzNLwDFqD3pRPNOy+Zc5zAUUrxLoKnhVdhJMrDjN2I7v1+o7dvFSW2TpbFMvUwTaogMWwVM9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0fi/GNW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220c8cf98bbso42477895ad.1;
        Fri, 21 Feb 2025 03:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740136821; x=1740741621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxYnX2yXJwlCWmyGjuQOEIXaM/3gJvdyhgH8qf3cr0s=;
        b=j0fi/GNWo0qIugZzNEAMYv4Dec5DAC54MIdgCNcOEMyQTlnA5OU8s/8CA7+soUCnZl
         NACtVKC2TUgYQ4wVfipHQc1MvhAHLjLp+bJ+qeQK+QOb+N5UZlYCdh5MwcdNBUBAnFHx
         qHDNE1YG/2y8Auc7oy9MTbSBq+uX9mqJIUA1B8CJoH7xc98N0RrlmMkXzjPMqhliHe9/
         dxTSd6IFlH2WDp2xEKfzoLRNlZCe35bzteFFMPfbY2hHABBGyOjGRjo7p1ST13Qw5T2E
         gQxFommhPi3rpHK04RnRdzX4YHsv+gLQp88cYh7EZFei+1TeFg5oxVaaMH/dSCcahdh0
         gx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740136821; x=1740741621;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxYnX2yXJwlCWmyGjuQOEIXaM/3gJvdyhgH8qf3cr0s=;
        b=sUvGpdYUKV/VzlmZKQIy+HH94uSr8clLeCdbGawMCDIYR6SZQMs8+uMS2ipi4RR/He
         peSyuJS/eDccSxK6L5A28qIHsr9ibvB0ZSFSxxEzI6Z70Kb2a7Jz9fdEc4bO7IFvf/yD
         0furyX9GQ44WIWtCUIdGmKppVDJZqrpOPQbmGmqHQ9w37LAjXTwCqviarZ+AF/irIrGV
         7kwP3Kcwv/BtcLgL6E/IBPk192kc0cEy/lOHXB2efZ3+XetPFsFJhp/cBy4FfnbXe3pd
         Tw95t9zjyjPaa/dn4smj+v3p5Bo3J4xPpeCerGnuJtCO4C3BudjaYz1yhfz5dgMXA2Ow
         qCEA==
X-Forwarded-Encrypted: i=1; AJvYcCUlmNCWGrKAmG3vqQHaG4h71hVsF0jbb6gr1Pm1ftKVrgjteoAclrgn5s1SEKXbHokVv5ryzwgUAbCGt78TpG0=@vger.kernel.org, AJvYcCVGRLtqBaqTp9H93sz+tYHovSW5zJFp/Xr1dMyI/j3DvFTtcygMzgpHxQWOfBWPGkquAWPPEYDsW2SgVDs=@vger.kernel.org, AJvYcCXl0AzyDe1KugBL1Z8qwjhVP2OHUAIkv1dsefyXVA9abDbw1aQHxnkMTXloLG/n00cexLthmfJQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzavc2QsUqjLQR67abLO/fl3ZqpVUoE2Bdse7pyrY9IMkCr2/VZ
	rcHrOuOzO5PptFYXGJyQpv++94oEW0UEv2t8DE87zP3bwCNV6g+V9oGyxVVy
X-Gm-Gg: ASbGnctL2fA8pefcO1fAEcJW0J158HLlhTqyVNXghtY/v7blaNcWW9rcQIWBeo3Vojr
	181mjKlR5QV9e37CAOMZT1KahnUG1zuaHYzfnU0DPNe6IxbLQL6FIim9pvYNOEtuXQMSfWUsF99
	/ZdgQUJsvO2TcWJK2A0qIy2TidtOLDoyYHHMlCd1rHT+iGeFphMa7MiZodW+RIpQKMbhDJNeAnB
	KuiNwdVUh7ywh9dXQBGH0LWtnezCSjIjjNjNezSKRgYb4IVR+YDLsMCqlW8xPA3TdcVQEujDPtJ
	ea7lZBkooTVZDf+Ud31NsGs5Kmz4/wkA/IwGw/bVnnQJc5N+rQ/R8SlYmPnchTpck1NAcrPAARV
	OeNUrOZQ=
X-Google-Smtp-Source: AGHT+IH/wICrOV8ksf5vgqn6VZpXkj00d1t4t3svm8K3W+EkQEizLgzbwSaFrJqlyDj9UeKS6DKytw==
X-Received: by 2002:a17:903:32c9:b0:216:4cc0:aa4e with SMTP id d9443c01a7336-221a118c6famr40048875ad.47.1740136820741;
        Fri, 21 Feb 2025 03:20:20 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559614dsm135518745ad.256.2025.02.21.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 03:20:20 -0800 (PST)
Date: Fri, 21 Feb 2025 20:20:10 +0900 (JST)
Message-Id: <20250221.202010.155344232451640447.fujita.tomonori@gmail.com>
To: me@kloenk.dev
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
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <878qq064j1.fsf@kloenk.dev>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-8-fujita.tomonori@gmail.com>
	<878qq064j1.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 16:04:50 +0100
Fiona Behrens <me@kloenk.dev> wrote:

>> Add read_poll_timeout functions which poll periodically until a
>> condition is met or a timeout is reached.
>>
>> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
>> macro and a simple wrapper for Rust doesn't work. So this implements
>> the same functionality in Rust.
>>
>> The C version uses usleep_range() while the Rust version uses
>> fsleep(), which uses the best sleep method so it works with spans that
>> usleep_range() doesn't work nicely with.
>>
>> The sleep_before_read argument isn't supported since there is no user
>> for now. It's rarely used in the C version.
>>
>> read_poll_timeout() can only be used in a nonatomic context. This
>> requirement is not checked by these abstractions, but it is intended
>> that klint [1] or a similar tool will be used to check it in the
>> future.
>>
>> Link: https://rust-for-linux.com/klint [1]
>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Reviewed-by: Fiona Behrens <me@kloenk.dev>

Thanks!


>> +#[track_caller]
>> +pub fn read_poll_timeout<Op, Cond, T>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    sleep_delta: Delta,
>> +    timeout_delta: Option<Delta>,
> 
> Fun idea I just had, though not sure it is of actuall use (probably not).
> Instead of `Option<Delta> we could use `impl Into<Option<Delta>>`,
> that enables to use both, so not having to write Some if we have a value.

Either is fine by me. I couldn't find any functions under the
rust/kernel that use impl Into<Option<T>> as an argument. Any
rules regarding this?

