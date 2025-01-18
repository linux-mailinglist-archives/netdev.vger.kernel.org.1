Return-Path: <netdev+bounces-159560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07BA15CA4
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115F7160F7F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B468189BAC;
	Sat, 18 Jan 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDew4kng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF32B9BF;
	Sat, 18 Jan 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202664; cv=none; b=mAhpRjzXuMDPzD/1HNIIyqrb4Vt/zme8j4zkp6ic1nDOliwmVZhoanlYAZtoOSZUNDDelYIK/Aj8jybXoE/yLh9V87amRIwGE97ECGoNik8RxYhGbldMMwV8FP62ZZJb52mXERNqn6EqxtkFvHBcScrfLIAzNJfJfr87EbtxqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202664; c=relaxed/simple;
	bh=ihm0UxWKzF1rC0GGG0B5bgPcdvYDyAFNI2T44k0eZl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPopymPj0GWRRwmU8v/iDsun2RvHu7E6eUhLbMunaZ7QWm4o/TaBkpr/A9r667cCOQxsVK0qJu92WVj7xBZVTd7vyOcJ1OivqqBPlfIDp4kbN6xR05v0AFAnxeSbz9hupRb7uTelnOFSpT2lZ46b9ieoguokCkS9Zm0hXaNo/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDew4kng; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso643439a91.2;
        Sat, 18 Jan 2025 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737202662; x=1737807462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihm0UxWKzF1rC0GGG0B5bgPcdvYDyAFNI2T44k0eZl4=;
        b=ZDew4kng+nTpsxwDzmCOBHB8bnd9RPK2o7heWI+3ymDvnXExsmYvQv1U1x2HTBeLms
         8ExsJPpF07Q5lwcfKUIanEz/3qONizZg7MQZKb75wyf64T+gl1A5RShogT0eTG81VocF
         PfjYOlN+vSGobQyIdcZzLA1oya2g8iNd72CstdBn2l2Qzw3EJoEjE2d14oP7bDqhccv/
         3djJd71n9E+Gq2vXBzA0d5GPxScaleDo3dKrPq5n1xAErNZIa8kev6hC/ruwnI1ae2JV
         k/mOK7h2STudpCvPYy4MS1rS7jj7mb2NExtgVFsNyBEQlAzi18VWE9/n8fksBMYQAIOF
         l/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737202662; x=1737807462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihm0UxWKzF1rC0GGG0B5bgPcdvYDyAFNI2T44k0eZl4=;
        b=JIVmcqA7eUHtG0eiJw8Axm/UT3RF8blMa8E6BdrVBVwZOcmwPsiyU3anOYswha2JLF
         h8D6g0NH7kbWws3ArEiG0RbsOAyH+cX4QBNhbKPKvtox8/AapNgc6DHPheB6/MGmwJa9
         il6JROLlaoKSrNvUW5xMumORx9FWeCzLoZ03K0BGNfStUdWBOwXRXswS1TPMcL39bCtu
         fdZK9AEhskn1IARLELboydMkS0Sn1d0joOtPfAvEG4WNSlnHCRFX4svqe4gGJm+XJjXG
         MGc6v03uXAqCF53Y5+Z06aevVYMb93OVbL+xd7odxdZEtQ+/kvyxEyb5fDvOPNdiwBhe
         5lbA==
X-Forwarded-Encrypted: i=1; AJvYcCVLmIyt2I9xdLEI9ZLUC3v0IUsp5bELFWqtCsr47fXOliRk/uuG5Y3gVkDVCS9JfM064D17ZGL7uRD5vMp/Fpw=@vger.kernel.org, AJvYcCVT7nU0zpmObIWzMIbehtBPDx5yaJvoyrMdOpjZ3KQVdO6K30RXoL341/PENbgZiSlaWuMFgGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRw4zA2GdFROy98TLCX5Xc1jhnTAYevv646+yfVam5uDbQxOPq
	8+VvoGmo473/ce7Zl+6CddpZEg0X3I6uDPTI/VZUB1dpBJ3AGrQZuJKHMRBnj88iSBkYu4txfoW
	1lIv72b+kpiFRUNd2zB8sTp+zdONUUwyh867GBA==
X-Gm-Gg: ASbGncvYNp/Lk8PJ9ENnM9nqxad6pn4bvvQB1k+qDJvRdICxEOiI3kkjEqDe8lYJ+mZ
	mlvXDDnqtai7O9+aN8YGAk8CwKkIhpVSOe6qCYezc5G09fZW9rpQ=
X-Google-Smtp-Source: AGHT+IGfy5X4NQDlQ9sQmpFx4RlFkvpaHRQOhXxey8SgEhO1W9hhA2fdpvYyFhRJIESL80JsHKyy+9SbGs+uc9VIRjE=
X-Received: by 2002:a17:90b:3bcb:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f782c82684mr3533168a91.1.1737202662193; Sat, 18 Jan 2025
 04:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
 <20250116044100.80679-5-fujita.tomonori@gmail.com> <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
 <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
In-Reply-To: <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Jan 2025 13:17:29 +0100
X-Gm-Features: AbW1kvaVVLx4EbunUuPPM9AAoCqd6Z1_vbg-tWHqZwvyn3GXxEK8yLA96FoONNU
Message-ID: <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 9:02=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> /// The above behavior differs from the kernel's [`fsleep`], which could =
sleep
> /// infinitely (for [`MAX_JIFFY_OFFSET`] jiffies).
>
> Looks ok?

I think if that is meant as an intra-doc link, it would link to this
function, rather than the C side one, so please add a link target to
e.g. https://docs.kernel.org/timers/delay_sleep_functions.html#c.fsleep.

I would also say "the C side [`fsleep()`] or similar"; in other words,
both are "kernel's" at this point.

And perhaps I would simplify and say something like "The behavior
above differs from the C side [`fsleep()`] for which out-of-range
values mean "infinite timeout" instead."

> A range can be used for a custom type?

I was thinking of doing it through `as_nanos()`, but it may read
worse, so please ignore it if so.

> Do you mean something like the following?

Yeah, I just meant using `let delta`.

Cheers,
Miguel

