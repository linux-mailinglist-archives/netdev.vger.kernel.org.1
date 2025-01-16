Return-Path: <netdev+bounces-159097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82D9A1455C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BA5188BC99
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B408242261;
	Thu, 16 Jan 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGQyeJJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDED1CEAD3;
	Thu, 16 Jan 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069471; cv=none; b=hFeocsQUFZECckcpWReKn50j/DAXeQTYDpArVr//fLFRpP//35WkGQmN7aRDhNBH92ZnM65WKeVQ+5Rpiavd1xBCDSblt+rHEfoM6zdlmqPUqYgu+dHb3MtE9+2mgsSA07ddIcYuK1RuHR/onOrYAXg4aFctfaj+h+wDxT15uo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069471; c=relaxed/simple;
	bh=FfUq54H03xjexAUIe51Syc546vxz1uVbAHyNgZAfTyU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MByMh7PRoqoR1opxF7/0eshruDrVzcGuEC/oCAo/Mv8djjxlWgE0v1v8ow5I6nlKENo9aCrag0dorqWPESsS36yW3Fz2j7ONbQJI3L3LZvVvu7bPkNxGrNXNjV0vMVebsE9of4OauzL5K4VXm40fXtSfJ7nRgn1Z1cvl/muoMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGQyeJJD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f441791e40so2150742a91.3;
        Thu, 16 Jan 2025 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737069469; x=1737674269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VtWgIUdBoCsFOaUo/x/+qW/JCRHugt233b8azu8aiY=;
        b=XGQyeJJD3dBEVcmvga+L7MuLxqYqGky5NRP/ghMACixzGOpLeG6p/scbm6XaivCYe0
         IKozN9HeDW4bSUKjww6XJuTp5rbZWgjWbLaITSELHoleOsgymncQdJTTPi1P8djVfoNP
         nFMYgPs0LA9+arlV7VBiNor28ixr6OuR++xa/LgT7xnzRFU2DQwmwaARoSGMl8rH2mFf
         1mugJawHuMNInnvQHejLySKcIfPn5hmNvS5dqJKQKPPqs1XaVQCYMjXeJKvjrhTKnOwr
         OQzHPIOtYEzAMrKdnn9nNMWyuEOG7ruo4aSANbibcx9PRA1i3QOCD902apF9ZtnH8/Aq
         hF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069469; x=1737674269;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4VtWgIUdBoCsFOaUo/x/+qW/JCRHugt233b8azu8aiY=;
        b=UxEgGp9njJ9b2dlBlDcT/g5lprr3jwWLv0FdA28EQKezgKxiXf1SplLP7mH0rEHf9l
         jz/BJngko42L674Rpp7ea1PHSUi2TuWLaIf5gqe/Gq0cxeTwMaoSaHvveIuAT4QJt02k
         3Jw6Glw7vL8y889Bmy5JTAptzwI5nFNHVqpcYmnGyhz5FPG/NsL9ifqlsJ91KtGoeqOk
         ZDtsA5wEoxCM9ykUoT25yY0hzbgukS8Q9twGmhRmSUWuZL2wQq18bBkIfnmPasG/HHxY
         8VYzhYGO5XS2yuB78ihuhETm8znQXKBmKNXn/2qmmJLGJNrrI8qn6Gj5ju6u4wjPjl9p
         kC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjEMWkfv6CQdFPp9aBeCD76VvvrPFNn1rFsc1FfGDtSEUuADG4JASvdW7BvDjNOPEWdPvUbJgV7uNFdBw=@vger.kernel.org, AJvYcCVcBIb7aEO/074Hi35a5gPS97vhcFVJiD+fCqT/MlknXdF/JbTConKgrsXvkeHqthik5CsILXckGMFgecpiiV8=@vger.kernel.org, AJvYcCWKEOkYE6iiiFNnZxVsO7YihgqveRO0k7H4RNj4CWmk/GOa6naFUWC0+7NYKbb/nE+Mq9hX8cAD@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJqW/TJsFlRUWEVEVCO4PFPKUVo6Zkz5tFe0VbJS6qcm7d5y2
	nkvO6BvtG6pRjNcxtQifW4zqYOf9A6PdZyXCWdt5m0GS+MvzrnPO
X-Gm-Gg: ASbGncv9+N/po4fcR7ut9YqABMgXUiAPsGJ4SwJjeo7Wl5IvtIUSXvbqSi4SR7dh7vI
	hslbM3QxNdZBD4/mLT5OwEA+zY5gVOSoqVtzf9I62NJmLjr1vrC5KIy5XJQKLTg/ZgEE9Wxmlh/
	YiNHeHT1gmhIGI9Cdd5Qit46JmloHHtBLS7YZFNkBlqe2zv9fDE0P8ixodtloP465LTzweAbYVA
	/2F7zLx2sYIMbYbMSoFyYLi7bN4T6K1rM9KaWiK6YcLR/XqPkc3qqRryE32F7Tc2ott5sZQcfpV
	H/2VLTWeECMI951e0T5vj6PEVQaky+QEOWKO/g==
X-Google-Smtp-Source: AGHT+IGWMCut7HqX0AyGnAll4X5fhXNPN/yJXecnwe2sVan7vi1V+MoWrYw2UrtY4PbzvH0HBWAUFQ==
X-Received: by 2002:a17:90b:2809:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-2f782c92bd9mr631024a91.10.1737069469089;
        Thu, 16 Jan 2025 15:17:49 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77629ac59sm655268a91.33.2025.01.16.15.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:17:48 -0800 (PST)
Date: Fri, 17 Jan 2025 08:17:39 +0900 (JST)
Message-Id: <20250117.081739.728610723513479492.fujita.tomonori@gmail.com>
To: tgunders@redhat.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAKdorCq9R-Agco1LwfRdbRGaK5gkQebb2ks_4sHf2SBCw8PmbA@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-4-fujita.tomonori@gmail.com>
	<CAKdorCq9R-Agco1LwfRdbRGaK5gkQebb2ks_4sHf2SBCw8PmbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 12:17:15 +0000
Tom Gundersen <tgunders@redhat.com> wrote:

>> -/// A Rust wrapper around a `ktime_t`.
>> +/// A specific point in time.
>>  #[repr(transparent)]
>>  #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
>> -pub struct Ktime {
>> +pub struct Instant {
>> +    // Range from 0 to `KTIME_MAX`.
>>      inner: bindings::ktime_t,
>>  }
>>
>> -impl Ktime {
>> -    /// Create a `Ktime` from a raw `ktime_t`.
>> +impl Instant {
>> +    /// Create a `Instant` from a raw `ktime_t`.
>>      #[inline]
>> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
>> +    fn from_raw(inner: bindings::ktime_t) -> Self {
>>
> 
> How do we know inner is between 0 and KTIME_MAX?

In my understanding, the kernel assumes that the range of the ktime_t
type is from 0 to KTIME_MAX. The ktime APIs guarantees to give a valid
ktime_t. The Rust abstraction creates ktime_t via ktime_get() so it's
fine now.

However, if we makes from_raw() public, a caller can create invalid
ktime_t by not using ktime APIs. Then from_raw() needs ceiling like
C's ktime_set(), I think.


>          Self { inner }
>>      }
>>
>>      /// Get the current time using `CLOCK_MONOTONIC`.
>>      #[inline]
>> -    pub fn ktime_get() -> Self {
>> +    pub fn now() -> Self {
>>          // SAFETY: It is always safe to call `ktime_get` outside of NMI
>> context.
>>
> 
> Similarly, should there be a comment here about the range being guaranteed
> to be correct?
> 
>          Self::from_raw(unsafe { bindings::ktime_get() })

We could add something like "The ktime API guarantees a valid
ktime_t". But adding similar comments to all the places where the
ktime API is called is redundant?

The comment on Instant struct must be improved instead, I think.

