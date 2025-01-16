Return-Path: <netdev+bounces-158877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EFBA13A04
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2B6188AF9F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3451DE4DA;
	Thu, 16 Jan 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9sn7ncD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BB24A7F8;
	Thu, 16 Jan 2025 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031076; cv=none; b=Yfdlecofpm5ypmUliceGMt9O9GJBebX8E2Wvo/a45PCEeAc1ZOS1qXPXctNkpEoFhhZzmGzY0AUqGCJ2E6GQ031x3HnSwmsZgXSspHD1ZZp0g8aRnVGoVkv0tFTSdBMSv5DP7/nNYyJNH4Suor4gbStHNVYGnMytVubhjYsagco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031076; c=relaxed/simple;
	bh=bnEqEX+MAfj7+VeyF/2JEQyOue0+pDQ7DR0eMGkm2pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYHl9kXKT81a9A2CC0paR4wFYphyVFfCqWXaTSQL1ryvDfvScqfzwm/wN7Fq9AMjdSkdlj5cMzjnfVAnH3kHecyvMT4do/wOE+6+8E6N+PqPM3kl2+jQiAA30f3pDrzbScQsYil66/cWqA09Wy+fnwCykY3wHywybWZZ2iCZBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9sn7ncD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee94a2d8d0so178671a91.2;
        Thu, 16 Jan 2025 04:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737031074; x=1737635874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9R+Pk0aHXXpiAhR4vEIRTl9sluVZzFwXWiO3bzv8qo=;
        b=e9sn7ncDbiFSH31x7nvt1Pzvqlh0yevKXhfdSiL5olxQfU5cquT+Jeqv2w/N5ZuhJE
         u07iwSP7476AiUjH2aVQbvUYkbmU++50CwAs+JB/vyGdCq0P+l21mZzt6afyKLbWtBMO
         7nrhYW//iYlNriFWoiAn8/cn0gL0z86z4BKV5aVQwbrfqNCximuQtCo2MRrrPsStDVcR
         R0MrsI339hJpqw4PRLy2IbVdaS1NaTFQPDpuG5qL4Qe1Ogs55dtUyoOlGFw+mVVuCSoD
         4IY9C5lDufkH++oURyi5RVTicFNZAGuZ5XzYOHU13zAQ1M6/udUxBR8R4uo9IICFcHz3
         PG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737031074; x=1737635874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9R+Pk0aHXXpiAhR4vEIRTl9sluVZzFwXWiO3bzv8qo=;
        b=gtJh7H8dVO+JU8oaJsVWbxIi84ln8tlXeGWdS6gdodznFwe7ig9/MYt52ppZRgjqZr
         pVheoyJnREq3Ury/52xX9BlZlvIDecz7kDJ318dQ8gS3nDZH8SDYey0iK9bfmri4X3cB
         d+1yMecEi9fyx7/8BzSuwPk3Kd4RevJ0nKkNKyE8HznMkwdSw1ctVQPbQPgFh4w2iNE8
         Wxgt4chL2xq9wgtQT0LX3hapxe5qsmUb5h3eBjUr49wx0SyjYs0IJaW+qxbaiWJgS2G7
         bU3xqFo5SN78GquztuYEGZJ9sK/uqfo/euMocSmmCqfdooqjSDI/Q5EAkJo/XU8AnqLA
         Onjg==
X-Forwarded-Encrypted: i=1; AJvYcCUGjo0i49EmAtBrdZwLOAi3okjYgn0Wg8Qmzmk3LhSkZ8JX+T5egxuX3pBcm5GMLlm2h3b2GHlYGRdvqnYj9sw=@vger.kernel.org, AJvYcCW036vQDkWKsKbx0n5KuKkPtNUejs0ybqs3xhmImyhKmxL3o/TQ0PtHJbFN2p7DBnyHNCGujgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM24JhQeVl4BiZa9bNHDd0jZkEwTRzK9iAsxsaW9vIMZrK2wwA
	KX9yaE0w/CdhfslrBrDmxlrxYjY9Gh1wQFh3HcP1gMSrevHz1TDYWI+sBAsF/Z87eoGZ+29SmtS
	B/L1SSBRSLT10IBPu4w/CFC0Yfg4BCpWt5w4=
X-Gm-Gg: ASbGncs9/MNwla5CohcCrLOfv4CVkoC6SjZ0WyWm0fCiSF3AypeNg1mjgC9XBpFhQ79
	ur5xs1LLiWlToZ284e0DAPbH49pN+fCtORAgi+w==
X-Google-Smtp-Source: AGHT+IFE4XCsez9Msxvxl0Nl8G94hgUYlPTl4zgqCmdZzIXqbjgojxz8FPJ+BNtrBPYSqRGKq/2ozAqcd/Az3UIsE88=
X-Received: by 2002:a17:90b:2e03:b0:2ee:e518:c1d4 with SMTP id
 98e67ed59e1d1-2f548f1a2cemr18883556a91.1.1737031074448; Thu, 16 Jan 2025
 04:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116044100.80679-1-fujita.tomonori@gmail.com> <20250116044100.80679-4-fujita.tomonori@gmail.com>
In-Reply-To: <20250116044100.80679-4-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jan 2025 13:37:42 +0100
X-Gm-Features: AbW1kvYEBSu9eRhYq5gSpRi0HKVf-XB8bWbv90Ijfiw-ecFIIJ8_ueQPJrdC5jE
Message-ID: <CANiq72m++27i+=H0KUaf=6fn=p29iueEV-+g8toctp0O0zEW+A@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:42=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> -/// A Rust wrapper around a `ktime_t`.
> +/// A specific point in time.
>  #[repr(transparent)]
>  #[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
> -pub struct Ktime {
> +pub struct Instant {
> +    // Range from 0 to `KTIME_MAX`.

On top of what Tom mentioned: is this intended as an invariant? If
yes, then please document it publicly in the `Instant` docs in a `#
Invariants` section. Otherwise, I would clarify this comment somehow,
since it seems ambiguous.

Thanks!

Cheers,
Miguel

