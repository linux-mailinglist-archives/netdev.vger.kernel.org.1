Return-Path: <netdev+bounces-178988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12EBA79DDA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 10:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041491890BEE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571C241690;
	Thu,  3 Apr 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E673gJFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20501854;
	Thu,  3 Apr 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668308; cv=none; b=P38asBp6Ecpg7T9ZcHTiFLh5Hw7a4w7OqBAHwS48sOGAyno8m1Bbi+4YMDWWqiV11EyoBefnBvCCQfqTHwkdVjYCYgoBe9MHPA+UH/4On1SRcECPybWZZZRAvQQJpHA+neXxstLeQSxtLsx/rh0o3BeDUzuOq8nETm1j1MNkl8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668308; c=relaxed/simple;
	bh=0I7n8T2Xw/5A+xGujo1SuJ10MG6MtVU4rlBZLisvIwc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WBKfLFdiObsPvFwM5nm5Lo5lXBkGvw7ByCVwtxlT93N61S5qF6wXbFftow6NxJLxkCcnv34G6wMPGIHGm9y4yIVPCpLWvjLhf7U5YQEYfWV8Sq9mTguMyUs4Py+BL0l6u+nU++0g/sBTyTHaxcP8ca0TL/IH19c6qK2Q/afpsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E673gJFe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22401f4d35aso6525155ad.2;
        Thu, 03 Apr 2025 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743668306; x=1744273106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoQiVDYJvAvzWCWcfK67WGk1iw1Tha7jczmy8QUPbMg=;
        b=E673gJFeEMFp0YKO3CPohE6YVagnp+XCTPU3iCD4hYBdRMzfrfeNJY4uZMQEuN8R0w
         Vv+pUfoDMGKpuJ77SvQKskXueJQbW5KvI/B7bPGMFC4DOFpnssrMIBkvT0XRH7WfNCip
         Yd5qS4FfgCRandyKRLhsCMyCRCoyrfGeCtx/jfKqFkgQuAWI4izbPdzkEKttmabdPmfu
         lvgCmYL9AliTwsuwEPe0N3tum3c+zJ1XBuQrjwSGCsbneWkffhzNFYsGSASD6fi1/sGZ
         9elgxI/FceHcaTsXwjQqXDsWAuGEjhaj3V9Xjjy+3gV5kpsERPV8/FPSpWeLHJiMwMiF
         mZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743668306; x=1744273106;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RoQiVDYJvAvzWCWcfK67WGk1iw1Tha7jczmy8QUPbMg=;
        b=My2/Tv/dKof8iZBDZEj84hHEuaJa234kyiFqZp/WNY0UpiNYqJDZmoukOTTzkvLrkT
         B1hUR3oicSs9I1766KvrmcuHYeZG5lEN24hlyWKdm1d31mE1MsaVG6E6hreElck2LvWB
         CCyIHnInAawu2/A2VyVmab3pCDXLJGb2nYtaAZZdub4VRescfCsr2L2TO0Unztrm+M1g
         odUV7y3+fwFrIsrXBgfC78Bt66oPdz9EbSemGb2bnJQEzZi+XeZWXuA5u5GLfVn1DsSY
         Nu3Iq0KD3/5tIFONJLt4TB7/nl8TuLNZHOAbcIVAYqhv74Gh+ZjjtReVB2uyZCrybA/8
         wFxA==
X-Forwarded-Encrypted: i=1; AJvYcCU1+9r2oUCqtEGwPeBsqnyamHUJMovqVYLRnVV+5YlhNSl5pkW4eeAL1Qf0q8+5PkhmPuhE4UE2A7BXF+NSNkc=@vger.kernel.org, AJvYcCUrKsCrG3yrIzV5ttACWAWA3HU+aKPmSzGiPGFYJ/FZ4joV6UrKx7+iwdp9+3hrCb/SQmjYBCAB@vger.kernel.org, AJvYcCXE6jzXXROUWBYu1IsLlYi6jmpu0XciIm8LNQXSww28UfANCzorl5L3TikIulDR6DZjrBZSU+kb/e8cw0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnLRaHGk9QrFFe0S5v188+JE9NyTAKHPoKhmOj1oMQYfwcsnp
	n8xJ3BgcrKzaIfX2AFABWsZuNQpqpPB+sIudkQB3dduY10OAreVc15es2YH9
X-Gm-Gg: ASbGnctYUxpkQFbYxTnKHFqY/DWYVvqmBmG2QetVwQ7hDno5k+LugqmXkPVlnnwN9Rx
	U8XwVUOZwp+wgDZbi8OPJOSS9HO7Lc7A1vOYCUZ6GBlqs2wBSSj87M0a7jd4Tww79S6Y+HNOjLn
	HXh5SZVFPaIjTOoYukEO8ax3+iIUpKC2fnBgXj7LoIXNSANjb8og7xN91oVPeh8rX9S1yCwL7kR
	C8S5T3jXVGQ4hGB1MPcKsg2bezpB8w1H+ygohR4rs4Vn8Vb/WPsH7/tvXwuV4xSW6I8ufT1Ow/t
	lna/fHqq89TJNGLSvOnRikrAZj+Y/OBVI+aRoNGD9mFcih3uG6Mb4RxccuHDIPWrUdTLzKol+19
	Lw/uSY8GBn9+4l2ejvTHo1CBLfL557xONWlCfxQ==
X-Google-Smtp-Source: AGHT+IHM0dK/CpadJel6XcHmo4OhKC1pr6HOLwIlhR7w4LsvgQpg3fMZtfMeebUstJnEdbcKq9w+3w==
X-Received: by 2002:a17:903:3b84:b0:227:e980:919d with SMTP id d9443c01a7336-2296c86863dmr64173195ad.47.1743668306104;
        Thu, 03 Apr 2025 01:18:26 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada37sm8761335ad.32.2025.04.03.01.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:18:25 -0700 (PDT)
Date: Thu, 03 Apr 2025 17:18:09 +0900 (JST)
Message-Id: <20250403.171809.1101736852312477056.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87ecyd3s09.fsf@kernel.org>
References: <RGjlasf3jfs3sL9TWhGeAJxH0MNvvn0DDqGl9FVo2JNvwTDpUqrr_V515QzLaEp0T4B1m6PJ0z7Jpw1obiG58w==@protonmail.internalid>
	<Z-qgo5gl6Qly-Wur@Mac.home>
	<87ecyd3s09.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 21:43:50 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

>>> If that is acceptable to everyone, it is very likely that I can pick 2-6
>>> for v6.16.
>>>
>>
>> You will need to fix something because patch 2-6 removes `Ktime` ;-)
> 
> Yea, but `Instant` is almost a direct substitution, right? Anyway, Tomo
> can send a new spin and change all the uses of Ktime, or I can do it. It
> should be straight forward. Either way is fine with me.

`Delta`? Not `Instant`.

All Ktime in hrtimer are passed to hrtimer_start_range_ns(), right?

I'll send a new version shortly.

