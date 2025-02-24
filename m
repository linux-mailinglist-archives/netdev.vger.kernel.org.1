Return-Path: <netdev+bounces-168873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E19A412BD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 02:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F486171225
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5D156F39;
	Mon, 24 Feb 2025 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmOWCz1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B42747B;
	Mon, 24 Feb 2025 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361238; cv=none; b=Q+1KZOjXQqn7cuP8MIzrcLzoojZvWBrVk5RxBDAziICIMDwADYjmJEHKaSGc0U7YKfPt6Spkwy72+DdJ+XHGJyAsur66kb8W0ZGFu0GOoaT4DyoS3UtsFGWwmlrelatJK2tI8VuXGvlb4F8JZxwed7tKCMKxHRKj6o5COSwTQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361238; c=relaxed/simple;
	bh=3IUTZmFWM7/bE7zsQEmlvs6HW+7+545qgn3Ky5CMvnc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CjMMMpj3J2kJXGZe6OiC5/FfGg6wymioctnp2haVEBJkuXbXlMtO1Rb/D8MBOge9dtqq2vjN4pyBArcgwQ2B/+Webt9ynptCOHfJbSNwKQ7luXiV9i8GzxKvx53Ukr3onUs++N29K4S6kkxNDAXwJKNEC86DH27PjzxFs78CbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmOWCz1f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so7815052a91.3;
        Sun, 23 Feb 2025 17:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740361236; x=1740966036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4iFAlpXooA80lhqQNHi8N3JDWtHvtfY51ovaQDKNWA=;
        b=ZmOWCz1fxIDPKbPgB7IW8XPVuS0uKKHaGrGgzbCvgYQftG2cnUC0OCp/XJ/3rdRBbl
         fRuT65AnHLpBim6KR0epdgPnyighyHskBSsGUJrHbRTfoE2l/huI/hSvCnIr780pVNon
         YL5JeAOqyyjn+XLTFLTAX5VXXxnFjkV3Ywl5zMhDw4hQOQv+q/lxpRI8sJO+4K5O1aXc
         ystkkFNDlTmf206Qhve7NApA5IPQSIRCchAU9I/GN1YjNohVG4GduMTAjFVUoNPZy8Sd
         mPlfHfGPPr7s4M5VtkQ1iSn6cdiI1JhTIcL5mF22ohDCV9gWn4K0RSXXvM54DyvM/Tr0
         Ox+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740361236; x=1740966036;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P4iFAlpXooA80lhqQNHi8N3JDWtHvtfY51ovaQDKNWA=;
        b=gosGJvr3s7hhyc80hOn1VxPbUZT1ipw1D80EO/pMJ0QvN/NJJzrUORa3S+glqzrNPd
         cADrMbnzdepVZOnp6WLxHF7dR8LLnYDWZ4YjxwcuGP8B5U/SQBMBjt9L6ogkDR8Ivh8Y
         nKgJSqOj7qWcWiqCF0ij5YE/0ylnbCG7hds99Hb7DEULrTxTGwg6mqbY/0C+HlGFOXPm
         ATWfiQ1tAInhI3Qvgtw8FE38tNQtknU903XaUl8PaNSjbulB/X0tkkoNetJHSg7v6OEF
         jHKoz7ONUVRXKyOGu/uythpciXPxoyaHwWzpxPnCFCl31yf8lnfsDJcyIZfDKA0PK4F3
         +H3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBOqXEKHpLxo87+Yy+MPJTp+gd9AzjwGLvuyQwxR5w24KKrcSRP6g7VQVbxULWYDjfYTO4bfla1bgTuj0VRLM=@vger.kernel.org, AJvYcCX2IkMwpVu903iezfnD0esOZcfapN5ahX+t0J22yJU1hx/3wiHXckwC7MlaMCcXXDP/4JNhcmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLuJ6hj+vWf0P+aEk5u402CJUdQiRR1DJbukAP259f5QDV9z8
	iPSHX3HA7bQX5X1bzPbAj+sQHRrKU68/4UMxjZ+tjCHNEYyVoJn0
X-Gm-Gg: ASbGncuWRTP5Suj8Pdi4649VtAuXECLFbeqrJvGgQIRkTbyAKY6rt+VyeIOpRh/0Bkd
	mG0r7fkLwAbVkjeSmezcbdmIBdRSi3i51ZOftr7OlGbFdArhoilOZtivRi6zo11uMkNDGQ5cpnU
	qPnroYIA1wzDdEIzS09tMFDlSUFzvq0t7PXrY+Uj/kQhmKhamLW686uSf3rCSnrmIaTV8xSI04n
	yCtiptpk4h+ITd59FvjKGBJ6DvHdwACMt4mCiIBY0sonn4ORshbIk2ynZSZk6ibqOdYZT6ZRkmj
	I7HGd5sFAztXaILwabC0U/vHqu9BB3HzL4pGfCg9oe/+hCTnq9Q3Pp5WTSPn/mphvzQl3zyj+6Y
	GxAB7aEg=
X-Google-Smtp-Source: AGHT+IHZ03r/R6ZSzFCsSoO99TzAkfJFcDQZ64v+Ptlgu3TSFxuhkakn95yNTkit3rWqPwXFA4Y2lg==
X-Received: by 2002:a17:90b:3807:b0:2ee:d63f:d71 with SMTP id 98e67ed59e1d1-2fce86ae672mr22731055a91.14.1740361235981;
        Sun, 23 Feb 2025 17:40:35 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5596394sm170286095ad.250.2025.02.23.17.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 17:40:35 -0800 (PST)
Date: Mon, 24 Feb 2025 10:40:25 +0900 (JST)
Message-Id: <20250224.104025.43839253856223839.fujita.tomonori@gmail.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org, daniel.almeida@collabora.com,
 aliceryhl@google.com, boqun.feng@gmail.com,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 1/8] sched/core: Add __might_sleep_precision()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250220070611.214262-2-fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 16:06:03 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add __might_sleep_precision(), Rust friendly version of
> __might_sleep(), which takes a pointer to a string with the length
> instead of a null-terminated string.
> 
> Rust's core::panic::Location::file(), which gives the file name of a
> caller, doesn't provide a null-terminated
> string. __might_sleep_precision() uses a precision specifier in the
> printk format, which specifies the length of a string; a string
> doesn't need to be a null-terminated.
> 
> Modify __might_sleep() to call __might_sleep_precision() but the
> impact should be negligible. When printing the error (sleeping
> function called from invalid context), the precision string format is
> used instead of the simple string format; the precision specifies the
> the maximum length of the displayed string.
> 
> Note that Location::file() providing a null-terminated string for
> better C interoperability is under discussion [1].
> 
> [1]: https://github.com/rust-lang/libs-team/issues/466
> 
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  include/linux/kernel.h |  2 ++
>  kernel/sched/core.c    | 61 +++++++++++++++++++++++++++---------------
>  2 files changed, 42 insertions(+), 21 deletions(-)

SCHEDULER maintainers,

Can I get an ack for this? Or you prefer a different approach?

