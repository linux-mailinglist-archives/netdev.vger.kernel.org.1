Return-Path: <netdev+bounces-147177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DB9D81F1
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBADC282D3B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16344190058;
	Mon, 25 Nov 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3K5WG7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695018FC9D
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525885; cv=none; b=Eb3TGvmqhQGGpo4/f/MdqyZVfTZddGnbE+W+HQSeSuTRxOLR8zwq3/Tvwqk4FMge+mtxRnH///3Y3cvo3qxyUEFoyyBZ+jUX7Ma67FN4JSKCc/AjXcZOR9gM6qv1h+qzHDNC0+qaPGMAulb5bcdPlWtq3NQdq5bzsZemXloSCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525885; c=relaxed/simple;
	bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTLgi7U49iHOR7JJAjNAGVETgb9FmmD7srTPi2oNqqqOKx85fA0HX1oLJgrg7h+M5p8AFJ1hWR/1YA2ZTMpRFY9EjlzPkad//5ANBYBQUg2e6zl8WTU0IrA6O1029BxkUVfwrDV/GtGX+DWj6imr/bNOjpvewElLTbGyTYEHfyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3K5WG7m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382588b7a5cso2672129f8f.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525882; x=1733130682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
        b=O3K5WG7mm/Wg/xhuw1n88U8ZiYPFBM/huCT0K5mNdAogN2McMQsT2l0xXqf0My0Qbe
         eFVsvzo+258sVQZricwUkvpxasVigyhIWqIiOiFIDAK8crBnZx8Ie5YsHAJlJbhLXjA2
         TaTCroHUd9zHLcbScwLaQtD1h/ohYJ+n7tBO/9qALh8HSLFq9566ftL87J8QjyCVEvdh
         Da1QY8jCqeg5Ncp3LSMET5i8jXvCyrCfDpFHEAxX78DgavFVpkEHgf2lK37YDS4alq7Q
         eiUOxHfxF1mnP4HsKmzJonJzGSRsrCdr4vb0DtiyO+6gzlyiYQbqR+LDR7ZIAQd/ms55
         c3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525882; x=1733130682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT2QX0BLl+SGVNLChvroK93Yxa+Mm8ft6/n++IH3SKg=;
        b=L+YU4XHvY6qFMRYEjOoHa32150w7XzdtCq3vKBl/pnSif7Bl1D6iiGrIT7iXQ4DU0z
         xaHInu1d7SWYZah64J15rDAyFwasC44G0FgKhA+xpvlEehqk+Acy+fPAAuBXFvk9HDfu
         n7vxdrxCIooOuJBktVYvDcRVIi4UjsqWXoo58wzR/U71rrJL3RVlf9E7B4MeBOiSWehZ
         +0XDipLmJ8Hs+wTojv6VlWiX+1Lp8FGuYLzX9XBy6lUAWsqENj/6rO+7W8ilYJlegTex
         sjhoC8ob4behPSjz7se44mgVe8IaQPlY12tJj8gGbdelEwimrW0X5Ck94vSXsJL08VjH
         wG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeYfq+Lz0UGxrSUQiqnRLjRnzuFouHTdbKhHlV2WHJwb1RP72tOzl1v7gJtQcsDpk2gBa7/A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYa7NP19O9NGb3SrVqc2bkYZXA/t2++125hlbZParercePr1EI
	uk0cBlY9A6wxxAuaV2xmvY8zEpIhEK1T4qZ3HWC4h/qXgkHezhsBpg4dw7QAUAv4lCilzKUTHRp
	1siMZ6wHgEetr00Peaady9qQBjQ0ZX/c3kcZQ
X-Gm-Gg: ASbGncvjPHa1I0uMlzKuaAUVpg1HG89kndP/p0UdPiw8L1cKUVrWvV8uVLURhMDgUw/
	JLG7X4OKKbgvv4OsYYjCJxwO9S2QhpFBoJGCeXgn1qBjSxS7eRQ4WK7NyRs1qFQ==
X-Google-Smtp-Source: AGHT+IH8xUhObePFMXX+6uJ4DZH46fnDECSOgfgui5FdlJfDvg099oVJfy7l8jGXt9Hpo3OEBqlpkGLGHf9ruibw67E=
X-Received: by 2002:a5d:5849:0:b0:382:59c1:ccdf with SMTP id
 ffacd0b85a97d-38260bcbb70mr8904576f8f.46.1732525881617; Mon, 25 Nov 2024
 01:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:11:09 +0100
Message-ID: <CAH5fLgiOHnX14CtN2rtC8ssUT03ECLOAGNLYPfA5ELSch9fONg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: use the `build_error!` macro, not the hidden function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:29=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Code and some examples were using the function, rather than the macro. Th=
e
> macro is what is documented.
>
> Thus move users to the macro.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I've introduced a few more instances of this in the miscdevices
series, so you probably want to amend this to also fix those.

Either way:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

