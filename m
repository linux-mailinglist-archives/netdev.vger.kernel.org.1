Return-Path: <netdev+bounces-158879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F2A13A1E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866843A6F29
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46B1DE8BE;
	Thu, 16 Jan 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0djM7Ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD201DE8B3;
	Thu, 16 Jan 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031431; cv=none; b=D5t0Hc1sYFRks0rCozIA/AJ2EUqO2UNWUoixdl2U6QLke3gTcHAhZME8qamg8LNc+KAioH0KYwrN4Qn5rxaTIm2fO/0GIDwWY9ltzwcPeImzq7Bi3qCIQbxOMmv/txh16BLBSmySjOnIwYSFV/XSWqg7gY81pPIysANP7IX+IDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031431; c=relaxed/simple;
	bh=WoJ9k0ovv7c0fS6XG4Hj3N5BBIiZMl051ko8Cx3eDQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbQES9tBlwEkhu5SlDKpLG7xWtotIkjH9FiJkYMwWGYFy3L7SkrAHFRhNZEz8WtXF8A6XFJ8FcH2DtLAo/9TlhAUGzvRV/46psFCWPZlgU+n/nyEf4Z7TN0QL21Fp5JyFUgc8ewRtiqL/5o8GSgGGTMO1j7VKcLgD1YGcovrsf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0djM7Ql; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so181497a91.0;
        Thu, 16 Jan 2025 04:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737031429; x=1737636229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAla99EF+lE4J49BPtpp3sgXhpvQK3wvKJlWksPRik8=;
        b=F0djM7QlCUxiX5z8X5zOsCshEH835seVQWlLvQhjYCBinQEgYwxFpRqbUwz5aYHHwP
         zk1Eg3jvY1lnZ3hDS/sua9W0Th1mHLvxRTGcbAvCURCnaa4N9HSBhQHSWQyJpDupsJ00
         CsBA3WVseE/wjd+NwZYK0x3g0WAZs/2BYolryZm2ovNSipmWOpJPKHn9Ejfa80IBRa8a
         ag7VaRNO3MEjp7BWhwi8f3lH+NqqhXVsVH7V1YHRZ7LJ138IfzyqjcHGleI7xO4TnmkN
         Tt9WseAtw27pp+YxZ3Pr4s+qSqdvQsyZzuv9kbJivq+ZGUKknONSTHDVwoCrTLyXKEVq
         Oejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737031429; x=1737636229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAla99EF+lE4J49BPtpp3sgXhpvQK3wvKJlWksPRik8=;
        b=Pw1yBSi0aAROReta2GzOXcvh2RxkDKfy8wTrVCnshTbiTPXdbrtZkdXaQnh+CzdFOX
         Dm2CAugboUF1e1t38ZUOSqDgzf+ZxibvNGyORoloORtsx5d7c9rAPdM4Hf3TEHjAKf5h
         SAY9XJjnU/ELKxW4X4MUqhSwhcQAVh1JopTu2KQsF+NUCtf5IPRegrugMgQCZYWYOU4a
         5aaf9AAhpfHQzr3qfsJXZ8+zMG9SmgGjYnkP1g6GtantEKxRpbB3tFd1yPquo1VeL37g
         TF018+kWF7Gu7e9Ql9XkfoG1S/882JHiI+OBeb1h2zaslow/aLs7HZu3E3BA5RXjo4yI
         wlPg==
X-Forwarded-Encrypted: i=1; AJvYcCVFrcbgw9q4TD6s0tV01HDonQEUx04SrmtXa0xDDfynEnerEKJLw8Sy+hwptaEOJnPMTWC3J/uD9otfe6tPZZE=@vger.kernel.org, AJvYcCWc8V46hPi6G17WXVoMAo3wlYF7HLeQpgsCHrrKepIN2vLNNaAowze7GLyfqbD0KVd+RGTFJUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFT7wtmmiHRBZdZ5YkOTviAaZwxnCioYctGDqi7R60OsSbg9hz
	pZ8bn74KhLICDeutk+tc3Io4zLnxwGTkV2fIXdDuKoCnBPGzJki/cjQ3Vtb/PBOCdblUWLI8xYx
	Rk7I4rVu0s8ZbTbwSM5vbl9HXqXY=
X-Gm-Gg: ASbGncsJPJKOD7NJAAICfJTBs0LcKosZzw4YtdS0N+OmO9OdnxpMtuQpk0ijJRxCC/b
	l78J9mGPSg/VCMOmxMAcUr1Qyz4kCWUjv+GzD6g==
X-Google-Smtp-Source: AGHT+IEk2SdJf/x/jrlGmfy0i+3wnEUdP53NKojC05VjRt1s3jD37b7hp11CGoqIGnfbmRw1BXDId7Zc5Z6ChwWE5WE=
X-Received: by 2002:a17:90a:c2c8:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f548ea2bffmr17329803a91.1.1737031429214; Thu, 16 Jan 2025
 04:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-3-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jan 2025 13:43:36 +0100
X-Gm-Features: AbW1kvYfEi82rpNDLg7mGMQh8qXq1FRsb8WRNRGT-GZ3Gu91j9iqNfpm2RCekB0
Message-ID: <CANiq72=pm4L_eU74S8_-SBpQWGbFM208FNTP_Vm0bSLEp3rjPg@mail.gmail.com>
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

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +    /// Return `true` if the `Detla` spans no time.

Typo: `Delta` (here and another one).

By the way, please try to use intra-doc links (i.e. unless they don't
work for some reason).

Thanks!

Cheers,
Miguel

