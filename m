Return-Path: <netdev+bounces-159561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3EA15CA9
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC921888A7B
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711318C337;
	Sat, 18 Jan 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkx8yPBU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB2187561;
	Sat, 18 Jan 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202776; cv=none; b=RDpWXekYLpKjq3Aqkc/bZVC3Uemf7SK4N/oAB8UfogNn6JEQDaQxqJUd6BQUab6UpUcinqncBn/xaeyHVg6g8dNga8n4i+g+Vt9n6qfS3B4gSZa+v673SncwQz0tkCHHGt5YK8bjbfmhrDFYcKyWQvOkCP5YgBefvcw0A2zmJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202776; c=relaxed/simple;
	bh=gHJLdutOpMAGTQ1cvfyZSRPMdBh+1WrBD11xhDVfgVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIFJZ/mqxPI4CWgeZmYpYGZjNnJdQE06HBnHROm3molaSKh9T2lK3Oalpotw/frglF//TyRMIlGJ7VnFOBcv1JGBilMoiILNZ8KX0cE2Vllw274hmfE2kQFLGNQHqyAqhO4focNaN9rDVGb2Dv1PTjFx7wni37qnnNCt6j3UpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rkx8yPBU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f45244a81fso644973a91.1;
        Sat, 18 Jan 2025 04:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737202773; x=1737807573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+PUx7cNFQ3GmO5/T8zmEcEmgaKl/wU3pevyyfI2JoQ=;
        b=Rkx8yPBUl+Miwy9SIrxkzJQTJL7uOM7DHVvo2mt1I3rlqDvRet0MRTpgy7dp5NjDIq
         TzrMJuGQzodwbh+/c7ww4B09tDUAzm5v7NWkzvt9X74qhZOu/3Lsixm/DOhzTGUDPci8
         v+dwgDKYnUyol5XbQ1bvfshersnn7n8ef1BqAX0ZHPGOU5UJedMlbnyHi7LH0Z+2c77d
         Jpt0hCkSHQGkSRRReDuZt9EMyil0/SdRlW9ulsaGgsKnE+i6zQHiTNp2+U1+ATIFWCYA
         PIG3WZrySNqEjYbH2zCTNuSnImg5dQY447zudK+DssTld8lB7fBdjcUQeKE7F7JH0+cw
         3+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737202773; x=1737807573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+PUx7cNFQ3GmO5/T8zmEcEmgaKl/wU3pevyyfI2JoQ=;
        b=A9AaVeJzMq4HiRir7Te5ZrtjrFlpVrOO1fVI0QQy/onODtAzRPNLFL8IFrG5ClkRF/
         P69Zjl9+fGrwTNPfSpo/+cdH/oh6OGPTXPo9QbdzigTNDwVF6E/7iBmGuvJ2nmSTXNm7
         US6knGIrsGtVJOyGmg41GmCytB9UHe8TEbURFTdkAufRfGz2I8xTKTUrD2STUr/l7WbD
         6hMr47raqAsUNExCtvddajW5XBVHDp8GQRqgZHue4PxqqFfQy9Sjr574YGKDp+akKeJ0
         +A1XV5Dwi908Bc2RDjpDzUEyNn2dzmUivNWK9a/xt2BH/ogiTzwauD2WWStIdDrwlfK5
         R5UA==
X-Forwarded-Encrypted: i=1; AJvYcCUZQhfZUKApwwL3sLPrHU6o5tDJ1/gst0XRwgUAgBlLTWltOb1vNlN9lloIGwd4MnaWxAy7EYQMYBfISBik70M=@vger.kernel.org, AJvYcCUd7KecYR4ccwKMmA4hw53CujU1CCMbZ70ZAOGw0KT1s+hdilC3K5X/K0+c0iE58X/mhrA/6+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLf66WxeenleLZDcpToEStFe8DHT/wONQ2yZTmMJCSIpdX6DhR
	GPxXsuBwbEKKOeuwfNrkte96HwRxkph7zd1+2d73zM590W+PxxUH3pHFy4cHclEnS6fDEoCThna
	f5xcKo6kiQ6vfAaLNw0tG6OAvzzE=
X-Gm-Gg: ASbGnctfXJU5YlsavPWD8tZXNXwmPq/VJxRlrLEdX6SsI2ho6AX4KAfsTlVe0QOzgxY
	UFCSJNqA3L2Afu9HGmT7sK0igMQ84CGrrST/27Ts/Eg0+rOBevSc=
X-Google-Smtp-Source: AGHT+IEDO93hikpzTDtrUhQ4GU+YT0lGqGX331IX66gKNUZqlCx3TffwiTmZuIUsafI+8zXZS80lkFwsOeXPQIfSH8g=
X-Received: by 2002:a17:90a:d64c:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f782d8ff0amr3422899a91.3.1737202773352; Sat, 18 Jan 2025
 04:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-3-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Jan 2025 13:19:21 +0100
X-Gm-Features: AbW1kvaitRMxUrUps9DRsGkigAY3cA71L3VFU2CiTeo-Alj01RmRhwu2WsdLYsE
Message-ID: <CANiq72=kuZcLCgsSkKa6MrYCJY9UsWSV9VLvj2TcVOQEf0Cnmg@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tomonori,

Since you started getting Reviewed-bys, I don't want to delay this
more (pun unintended :), but a couple quick notes...

I can create "good first issues" for these in our tracker if you
prefer, since these should be easy and can be done later (even if, in
general, I think we should require examples and good docs for new
abstractions).

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> i64 is used instead of bindings::ktime_t because when the ktime_t
> type is used as timestamp, it represents values from 0 to
> KTIME_MAX, which different from Delta.

Typo: "is different ..."?

> Delta::from_[millis|secs] APIs take i64. When a span of time
> overflows, i64::MAX is used.

This behavior should be part of the docs of the methods below.

> +/// A span of time.
> +#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord, Debug)]
> +pub struct Delta {
> +    nanos: i64,
> +}

Some more docs here in `Delta` would be good, e.g. some questions
readers may have could be: What range of values can it hold? Can they
be negative?

Also some module-level docs would be nice relating all the types (you
mention some of that in the commit message for `Instant`, but it would
be nice to put it as docs, rather than in the commit message).

> +    /// Create a new `Delta` from a number of microseconds.
> +    #[inline]
> +    pub const fn from_micros(micros: i64) -> Self {
> +        Self {
> +            nanos: micros.saturating_mul(NSEC_PER_USEC),
> +        }
> +    }

For each of these, I would mention that they saturate and I would
mention the range of input values that would be kept as-is without
loss.

And it would be nice to add some examples, which you can take the
chance to show how it saturates, and they would double as tests, too.

Thanks!

Cheers,
Miguel

