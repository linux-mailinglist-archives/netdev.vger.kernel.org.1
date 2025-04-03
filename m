Return-Path: <netdev+bounces-178960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CA9A79ADE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 06:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9452116CAF6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 04:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA37158858;
	Thu,  3 Apr 2025 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxPhKV/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CE291E;
	Thu,  3 Apr 2025 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743655261; cv=none; b=UM7AbNnechfSddzQ4my82cVv9Z/r5MEiWsK+v+VragG46l0yDpe/YFOd5rU25PVaAN6GKEeHDTibkuZZDCWRcNsQjK897wQoYiBYWGd+cgdh9dIHLhrLGXnRoo9veH1lMIM2Gj9x02EraczzBLeNY9zW2/uZ41dmoSJZcSK4ze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743655261; c=relaxed/simple;
	bh=7iWBNAI/+CExTBdUuMSTH+Xqb/9jtb1WR0tmAWGV63o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sidDoePr23SQaF5IsJpMSsBS9pwUeB51hy8DGHOTwqFkMdNE+s2DPtjCzZcEfvOXEgAirG8KuWgWphCzF+1qjAAARIZugoIPI7IURCW9vyMcpsPNiiElKe90pBXqFvTrTf940rhqjEFjeO2Kebl9cH9eCiVsb97XpW18uqOGtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxPhKV/n; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ae727e87c26so351928a12.0;
        Wed, 02 Apr 2025 21:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743655257; x=1744260057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsNUEEOO2eyC/ozsW0Lb6009jV8VrjHo2FIvGisJgxM=;
        b=IxPhKV/n2PKGKwKl/41zxO3c6RS6MbPItV1CHGHBYqVIGYnceuhdhbL0r0xz36h6un
         9rrn961XjRlb5wCvkXCXmJU5SwZgx3b01xFLqIlghYgRmnsK8jiVJdYB7lWF60bwcfyn
         A1NjEwS1D1MwxfnxnAg2eCnhSJLzJ85kWsN0RPxkEqTyHj88BrjCZQvVMbHmjEheA41w
         ekEKQPTqPt4Pe5whk7W7ebZxq74XJ7cK5FH2iI8EWbzS3Gl9zAiBCRvnK0ZHH3d8lj0p
         axlnchLEVIzhclcJCVVv4td3mTyCvl02QRQy5O41KPBX4ZU+QAQjOJh5NpjhuVTcTCXZ
         dW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743655257; x=1744260057;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KsNUEEOO2eyC/ozsW0Lb6009jV8VrjHo2FIvGisJgxM=;
        b=xHl4eRVgWMLvudcvIAHnpZyo78O1ccW2zrsLNxLNSkunuq8a9KPPeRo+0DrO4dx6R4
         IHdLHDY+wzJBetTCnOApXQiATNVtvWWdWGH/TcU//ampPq6pedLJSQbrtZRfffuHyIuA
         bdX5abVxk/ry35YcEkRgNuiGw2mCr+CoqYWPHLQ/ApBaJlivpM5+1lSHXW0wwc8kVqII
         7jKq6F92xhFjL3I5zaY6Xsi2RHmoJTW++Wi3LMPL0z4BZS5PdISp0pVsQ3BZzXpk/B0x
         vk52km0fSZtVaY81uU6e6pJng67o4TxV5BhZqHX9o2fRz+PoOxlDgw3c+3oFy2nqYYaE
         P5VA==
X-Forwarded-Encrypted: i=1; AJvYcCVpYGJtIk/JWb1tEvFD7zutlcSeoY6OsFpaV8kQQorBQCesCgGflacTQx9S9MVtWnyK2JVV0tZ7r04/Hroplsc=@vger.kernel.org, AJvYcCWKes3Ebeag08uOdF03lDQdqcB2RiQjzDpcsUdMDCLjuvGHiBiY+uTH+V4tAxWYxQ0jRYTjjGPQ@vger.kernel.org, AJvYcCXo24B9wy2nvN3t1xPZk4b3gFa4YKMp6BG7VbZJTxvkFn7e8pijGOcinVa+XmB+kpAUsDEGsLRR4v2jszI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvmY4zkmWkU+pRSAb2geEI9EA5yQyjK7v4dWnWESh9UGeGcbc
	p2uVC6QKY+vz9PKj3nJllWe6nJ+3Lk1cEAk/bc4n/qdo0aHlqNzj
X-Gm-Gg: ASbGncs3h73D8KwSL3oSVSTx7nsKsTGBFekjmazL8KowMoXAWLvx3JXP0vDjUO9zxWw
	O0QFTw82YjrXKVbxTGpi2iQlwIwdO728hDOtgPojFegLV1Yqwpd/1ARhFSjtqPv6l5TInZa/fO6
	pFlX9Xrkn/Aq/EJ9Rkz9JHO1fpjE9ySGu2xddl9ly2wCVFn5MiEQFq2LJboxJxIjO2kbYhjJP1H
	nXiG6Npi2+sTZpYqe/a6w1ELdNMeSjmEKmiEmMp+eoiVQtSaNfhcFkGo7WptIxMGkOVO5ZoxmCw
	LBuiQk7jXI+AiKoC/A1i+oXiXbNjIJ4j2bOiTGTtjGUjl26xScmA2kPddrEKO389kSJpOAWDstf
	PBH0q3W4EDSfNwPmdys0ooH4ubxv4EQZHo7Mc7g==
X-Google-Smtp-Source: AGHT+IHyo1NpjXY1BAIu2wxqeQNoZN2Gt6qoO6RTDu/Lyjjbv4pUP2sWS4FFj5LxJ3Mjf80VgL2BRw==
X-Received: by 2002:a17:90b:5205:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-3057de47ce2mr1368138a91.30.1743655257220;
        Wed, 02 Apr 2025 21:40:57 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a2f6b2sm410564a91.24.2025.04.02.21.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 21:40:56 -0700 (PDT)
Date: Thu, 03 Apr 2025 13:40:38 +0900 (JST)
Message-Id: <20250403.134038.2188356790179825602.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 daniel.almeida@collabora.com, boqun.feng@gmail.com, gary@garyguo.net,
 me@kloenk.dev, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 4/8] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87iko1b213.fsf@kernel.org>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-5-fujita.tomonori@gmail.com>
	<87iko1b213.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 14:58:16 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> 
>> Introduce a type representing a specific point in time. We could use
>> the Ktime type but C's ktime_t is used for both timestamp and
>> timedelta. To avoid confusion, introduce a new Instant type for
>> timestamp.
>>
>> Rename Ktime to Instant and modify their methods for timestamp.
>>
>> Implement the subtraction operator for Instant:
>>
>> Delta = Instant A - Instant B
>>
>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> 
> 
> As Boqun mentioned, we should make this generic over `ClockId` when the
> hrtimer patches land.

Seems that I overlooked his mail. Can you give me a pointer?

I assume that you want the Instance type to vary depending on the
clock source.


>> -/// Returns the number of milliseconds between two ktimes.
>> -#[inline]
>> -pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
>> -    (later - earlier).to_ms()
>> -}
>> -
>> -impl core::ops::Sub for Ktime {
>> -    type Output = Ktime;
>> +impl core::ops::Sub for Instant {
>> +    type Output = Delta;
>>  
>> +    // By the type invariant, it never overflows.
>>      #[inline]
>> -    fn sub(self, other: Ktime) -> Ktime {
>> -        Self {
>> -            inner: self.inner - other.inner,
>> +    fn sub(self, other: Instant) -> Delta {
>> +        Delta {
>> +            nanos: self.inner - other.inner,
> 
> If this never overflows by invariant, would it make sense to use
> `unchecked_sub` or `wraping_sub`? That would remove the overflow check.

Yeah, I think that it can. But I prefer to keep the code as is to
catch a bug.

