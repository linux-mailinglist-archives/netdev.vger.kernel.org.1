Return-Path: <netdev+bounces-159441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F5FA157B5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF26A3A20E0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8571F1A3AB8;
	Fri, 17 Jan 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJLLmxV8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194B1A83E0;
	Fri, 17 Jan 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140371; cv=none; b=L0QxBvOsbZV+w0ZK7LlnYjQyZ9K07z071AasiFY8JVzH0F4nhdxynfOjk3rXsVfkhG5BjjcNw1Ie0QZBg4zU6Tkj7YdCmoeD5HLD6hqVBuF6WztByTdnXWQBLvVb5qtqRdPqlzrRxrmBrzsx3oJGBmzELX8n2aknRjdspiO8T4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140371; c=relaxed/simple;
	bh=eXYNr/48i/aaYksD9OzMxyZSyXsx3MIUMhnS4fyk6Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV4NFtbhZO/Sb6c2u9cBB3ymbl+dVq1Fba0qe+U3WJ4gZ2R0O+Jq/89sTa8fCDA5CJK3bhRQehcMoBng3WIHo3wlPxTcqbd9vmIvtOMHsjDgnNDqnyuI6YiEyi8NlSwx82Fh86TFBFFFhKdscQ9NRgfq06lJRGsTDL/kvXAqbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJLLmxV8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161a4f86a3so5173705ad.1;
        Fri, 17 Jan 2025 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737140369; x=1737745169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqFBXydFnLhZM4frEu4cymiWTyJgjozk//5gsSaQ+Fs=;
        b=bJLLmxV80TfuMqNeyIBCwYB4QvWG1m2qjno9JeJG95KvHaQ7CcB/hr7/AS910tbZUQ
         FsnHsljBXTvUtBLhR7mQEhp/gJhQ8aNr0/wNAiUXX2uPMSGg01a/P0HQBdCT+mmTWQWC
         CP2yFLNq5AL2l2Hn4X2oDXzX7qt8k1VgIEoMfvLtle8ZbVug5aNF3LE5pPzKSJBLzGzv
         oAm1G0D2nkWdt5VVSEbVNSTVSdl0ryv2lIgQIJD2w1pGlM/nB4sWfBLgC/11QC8aLU1J
         d2FBnfOonkpMxasSYMBL2/kyhaNRnxqBBVUF1CZNPS1ZZt6Ban/FclFk4Z7wGttvTKBE
         7xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737140369; x=1737745169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqFBXydFnLhZM4frEu4cymiWTyJgjozk//5gsSaQ+Fs=;
        b=PO0OB0Ri7p7VeZoLR5RfZ/Xxf7i2LlDX+mC0sZP0COQuGyJEwFdg52sZfHq3VczPEU
         idfbTR/CzpUKw6xy+XL0PzdKAkEQLwS9ewc6bkovh2m78zXJqhWAc8wY8mqXYR4u7CC4
         SvyIvFoJnny7vFVLZYmEw3BIHbUA6s4g2UNHj1amuVUD/Ib18RLKJ3JTEffuVyRlu/cL
         gHA0DzA+J2ue2t9kTDrM4w4NJjlA8VmAq0dAT1JdtQ2XAEnQO374IVjL2jYXPhWec5bw
         kdqQ9c4Aw/OhpYHcoPP2RmOLL/9s8Mg/G2Kza5+98KPZIaBF0vz/+hbI7jv24m1KrBlf
         8srg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6RPMRm5AVi3NXRX1PN9qAw6GgPjTWYsYXnXuq6jLcJQxYMNlP7507DG9n9JRRGftwTpL4wtKs/eoR7JOfy8=@vger.kernel.org, AJvYcCVzNhDvysEAPJnuRc6V6NFnf7mCJjIpiHaGtM2eTBKpLxDehO5nneL66ww6xtazzwu/a14YDr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPXuXkAcJwYOHxVS/PXsWdOhaKQYTmMo6IzET5ydsbRT5yOsp
	DXrIcqp1xJYBnsBCDlF+30iWir0Wyh8fqQaFNNTrj2j460AXUU5tCrSM3mAx6U0jBp3im0hPbAv
	+twp5ZNNoWoR+8syxwNDca1x6Hks=
X-Gm-Gg: ASbGncs3iW7vJWgctk7+AHOdKDnUWp48o6jFe2rcZ016hlSis24h4Ld5sAZT1soKZqF
	UJuOWe17LLwFBNNHoB6NVl1Yj/iwzudvlaMhkeA==
X-Google-Smtp-Source: AGHT+IHnyqsxERIH281CNhfuF6aMltGraei5kNhX1Qo6K+ndkZPeJ1YS9sP1Awf6jAUaMo3MxorxuqMuSpoLG3aGBtA=
X-Received: by 2002:a17:902:ec8f:b0:215:a57e:88d6 with SMTP id
 d9443c01a7336-21c34cc5dc0mr19878875ad.0.1737140369211; Fri, 17 Jan 2025
 10:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-5-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-5-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Jan 2025 19:59:15 +0100
X-Gm-Features: AbW1kvYZY1LzSO_FSmJ660_EhBSD71Q0--c8IzXuHIQIJoosuhQDRNT-Q2J_dfU
Message-ID: <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
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

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> +/// `delta` must be 0 or greater and no more than `u32::MAX / 2` microse=
conds.
> +/// If a value outside the range is given, the function will sleep
> +/// for `u32::MAX / 2` microseconds (=3D ~2147 seconds or ~36 minutes) a=
t least.

I would emphasize with something like:

    `delta` must be within [0, `u32::MAX / 2`] microseconds;
otherwise, it is erroneous behavior. That is, it is considered a bug
to call this function with an out-of-range value, in which case the
function will sleep for at least the maximum value in the range and
may warn in the future.

In addition, I would add a new paragraph how the behavior differs
w.r.t. the C `fsleep()`, i.e. IIRC from the past discussions,
`fsleep()` would do an infinite sleep instead. So I think it is
important to highlight that.

> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit arch=
itectures.
> +    // Considering that fsleep rounds up the duration to the nearest mil=
lisecond,
> +    // set the maximum value to u32::MAX / 2 microseconds.

Nit: please use Markdown code spans in normal comments (no need for
intra-doc links there).

> +    let duration =3D if delta > MAX_DURATION || delta.is_negative() {
> +        // TODO: add WARN_ONCE() when it's supported.

Ditto (also "Add").

By the way, can this be written differently maybe? e.g. using a range
since it is `const`?

You can probably reuse `delta` as the new bindings name, since we
don't need the old one after this step.

Thanks!

Cheers,
Miguel

