Return-Path: <netdev+bounces-136085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869509A042C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C622822EE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189F1D131D;
	Wed, 16 Oct 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulGuSHs/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF11862AE
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067171; cv=none; b=duCACEofSvwa6573MJdioryk2BMDatDvD22VQ76i/+pMpr8BJ0u9ij3uF3G3MIODri3QJumMVbOdIibctSStpwx0JEJJqfrjspIdVGE9iytkScyIrkHcGpBdWCykMBkGapPErZ8PQHqSWKTaA+G11JcanYpG2zaG1jqKkCFK3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067171; c=relaxed/simple;
	bh=tygiRFqbv+djzCkWAvjrXrySmhBjmetaHW6CXjdEyUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXpBb5ufYmoMvbwR8rY+E5LfmwKEDXcUUpixH5ZakD1WFDb+962xXJYDmzifXD8EYj5ClUqTEDAaa6j7Lrj7NaSm7DqFqbXIz/lnPzufMBQQdDpEWFBqm6TWgk/RJ6LnQbphGi1Ht4SIV5fvC3XwraGfQoKDUgbRYChw0IBP2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulGuSHs/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4ba20075so4143981f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067169; x=1729671969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+7LwnnrTbH3RKt7BRM7LcBiqKf9Vi4DwjUCj0Z2Cpc=;
        b=ulGuSHs/Zgf6jxgwGsWmkoTkCwt/2B9NgJ87CrKY+390dJsev3nit0AVgnF+YGhFxA
         XXI4pPseYdHmZ56BQvw1y0HpUbKAmtgwewC9E8UJnmoTYkgP+F4vVjMC4B0jXlt/QdZo
         UnVmJWQDflxVlHN38kKjp+ngP3LZ+ZRLCn8vr7ntt2HzS46029vs0ZWM7R1co3s6I5uA
         GvR8lG2yeAtsmp/XgT5P5lP5b7ZsjgX6gDRfjdn5FF3PxWL8Tcob7oFSMWIVC5rfSI92
         /nUuNmzFyZFguapVJ9zzGeXJtiuzRAEw4GONVAofLwZ28xj+dBz+ouhnXmjt8qW4BD8k
         80aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067169; x=1729671969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+7LwnnrTbH3RKt7BRM7LcBiqKf9Vi4DwjUCj0Z2Cpc=;
        b=rhiWQ3snIrmS+Eb1KqFrafiCFPjPk68684jfnhRSwegquKPXGoddvMSl17U6NHqCBe
         eLpspmo/UagDQIRAJmVdGhsbgd5GRM9+KG+gF78Sal857kJtfKZCTYS9kj/VxEObQ6hY
         QMc0ZdlznmV3qu6RnSRM1VrjMUhr4NYyHm40xsIlxwGJdsHqxL5juP61CzFu8brOpsrf
         PYS79n3u2DgAvf7kE26nrWjAtfiE3hFvhetCoKjmktC5LTg69nQuXMDY5J0sb8afReDD
         rINqaO1BtXltqxRjZsvEm+c8NaKOJVtbgT14VfMiQh1JZCtYwANvGTQawri/mEzRmF9l
         yOWQ==
X-Gm-Message-State: AOJu0YxDvHaIgxL9DIgzhueGVEY2XxVszSHdIIORciBDWV4ZeoxTOA9+
	dvZAKzESvtKtMY0dax4ycVMjr49JW1O7letORHFNY95INx8NTR6a3zwj+ZwHwa70ou9GU05THib
	53Y5HsewyDMB6rbQUyIVGvvE5QzbMNqubacch
X-Google-Smtp-Source: AGHT+IG3IXPeMudvkdrtSejG9A2Vrc5kJHuxJRzENV1HoWLFGAnZtzhqRbbC+l/e1CT7Jq8syro7lAXEjkQOMCt5MBo=
X-Received: by 2002:a5d:6b83:0:b0:37d:395a:bb7 with SMTP id
 ffacd0b85a97d-37d551fc5ffmr10919996f8f.31.1729067168659; Wed, 16 Oct 2024
 01:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-5-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-5-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:25:56 +0200
Message-ID: <CAH5fLgjHtRJg9E7Xjxt+Xgt_0=7zk2jFYLiuzJSeibdx2yHrWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
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
> Implement Add<Delta> for Ktime to support the operation:
>
> Ktime =3D Ktime + Delta
>
> This is typically used to calculate the future time when the timeout
> will occur.
>
> timeout Ktime =3D current Ktime (via ktime_get()) + Delta;
> // do something
> if (ktime_get() > timeout Ktime) {
>     // timed out
> }
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/time.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 8c00854db58c..9b0537b63cf7 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
>          self.nanos / NSEC_PER_SEC
>      }
>  }
> +
> +impl core::ops::Add<Delta> for Ktime {
> +    type Output =3D Ktime;
> +
> +    #[inline]
> +    fn add(self, delta: Delta) -> Ktime {
> +        Ktime {
> +            inner: self.inner + delta.as_nanos(),

You don't want to do `delta.inner` here?

Alice

