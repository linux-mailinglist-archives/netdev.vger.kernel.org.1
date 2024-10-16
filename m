Return-Path: <netdev+bounces-136084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638A9A0429
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B90B1F22585
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F521D1305;
	Wed, 16 Oct 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZKWlFK3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23E1C07E3
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067128; cv=none; b=Mnv9qveWq55m2AHPZbJEWX64HBuV4kRLdF6evyWLkvh3FhNfgNzGG8uDuN9bI7Idl3lQKyoPKq+IaU5attsp7OoXWbdh1NdSez5YAP4rlrc3fgA+lz2V1Egix/Ifz7xZH1wkM3igDqy47621LRl6bTbLslwjCOfa7QPlHElcQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067128; c=relaxed/simple;
	bh=GdAyAonw0lhETMxgs5zFKVxDfwdt0gZ2m2246xw34ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R04PkVkWVANwgZ3XIEIGa0vDaE3cnUhGwZ3JvJMKIu24V5V/l2mwCjS+W0CSFrRgqh+hB2qkgYT5UNEMTbnHGC4velE/4JiiE8o7+eUDzYcNmFhgoc/g41DtFnWk+CUWz6pSqIzFfA4JOkl+WDx8aIgDFPqTuM/SrLXUgdRQSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZKWlFK3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314311959aso11800605e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067125; x=1729671925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdAyAonw0lhETMxgs5zFKVxDfwdt0gZ2m2246xw34ro=;
        b=rZKWlFK3Xwm5lj3ojiOxX+gQ3IT1PWqEHPdOB2/+wntq2GEmJ8kWJTjt2VyOI2IVuH
         ORfeuyRiYRh+jJ62sPu+DAVJND+l96QvKMOUHDuizozSlhoRN/yhbjV5UhUamGtf+6PZ
         VfHdCqyjNX0zouv1WwkVRLq0F6HMcCFqd70zFbE+R7b5ts8id3ammLeCo9scfGdAZfLM
         9lBK6/iPWXlA0Zsdi6yhPyoDdc9UTU7yLILiVmBxqxVi6uYezTgUnhTnn+3igfwq0jvS
         yE2PXimnu+NIlNYrIRrr0EnRR/ybVqPg/piaEynBekLUa6ehKufeIGUP3gLZ8Dauw8Yf
         sqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067125; x=1729671925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdAyAonw0lhETMxgs5zFKVxDfwdt0gZ2m2246xw34ro=;
        b=Nr0ZeWuSwWCxNrgg3551Syakdw6YXrdyaXKU9Ssona6WPAhdc4YWS+kZ54MovBNTb7
         IcKUH64Re2wYwzvqPfTunna0fVR4aAHJi7Kgez5kWRNLXOaWv4S6t1e25APLcYryPF/J
         J7KxAvZCE3rtUAgsIdmvPWkMt6ZRB4eiaDRBQ/8d+r966hJKuOgjAdkcFCvyE5VNE4IF
         Zhq3vSwd96fQwaNfL+SEpA52YKSPVLZ0nnPEp2z96SOF7dke1ni5hGNoWGyuw6K0ix2W
         Wi0vULdhBG5Q1bbl1zZNZdQBrfn4dXyYRagGTSKs+lemXqJAHfq2j6npp56XwEj+Ak+a
         FczQ==
X-Gm-Message-State: AOJu0YzgNzfMQrL5X2/JPRv91wGii22OGwAafYm8cQHScw3M9ScJmEse
	GcBnpYiHSYbxBkSCw0MrDVrByQzN3hp6H1M16JD3oII3lW6Hk7R2H0tY+CIWkzc4gDB852elPx4
	oee4ntd0+BdYrBmAtJLzm1Ia3A8zeE1FqcPVM
X-Google-Smtp-Source: AGHT+IEApi9dCVmH+iFfN2VYbxBm8PF+pe38gGf01vU4SF+ykoiE21dcj6paXzZPtBxSH+8uzj9i0Ryw/Y5uTcsq2ik=
X-Received: by 2002:a5d:4f8a:0:b0:37c:d53a:6132 with SMTP id
 ffacd0b85a97d-37d5fefa845mr9658199f8f.31.1729067125280; Wed, 16 Oct 2024
 01:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-4-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-4-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:25:11 +0200
Message-ID: <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's sub
 operation to Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:53=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Change the output type of Ktime's subtraction operation from Ktime to
> Delta. Currently, the output is Ktime:
>
> Ktime =3D Ktime - Ktime
>
> It means that Ktime is used to represent timedelta. Delta is
> introduced so use it. A typical example is calculating the elapsed
> time:
>
> Delta =3D current Ktime - past Ktime;
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

So this means that you are repurposing Ktime as a replacement for
Instant rather than making both a Delta and Instant type? Okay. That
seems reasonable enough.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

