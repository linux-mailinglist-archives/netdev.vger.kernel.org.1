Return-Path: <netdev+bounces-238999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 144CBC61F08
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 00:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5AF3B3B3A
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65F24DCE5;
	Sun, 16 Nov 2025 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdweU4ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D605221F12
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763337157; cv=none; b=hDkQj87kxJJHATdCqwfB0wlwAk4eWubhejQ9U3G8Vn0sU+O2HM0AEIGuT310JQO4zPZAnvURcyHqyGsu1Lx4L7frtyhag2N1TlIT5HfAnlADtNQ42jkqod+3u74h9pWM+/FZWgwQtmdp71pbey+7KWkO8/GsP01bI44da2FSEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763337157; c=relaxed/simple;
	bh=FpQG44YCiDoDEKjDbtFB1mxhp/Sh4UsuhIkn68oXA4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bckKcA4uYH97+gdi3eZ7peJu6OqEi1tqbzs9WUV3gyvPDQCTc11zW2gdR7bjuM715gfpiFztn2q6VbyeRNIq8PKYzJvKDvzsbiQFfxIEK6cOZIqxI71uZBzjGJ3xvSWOE9jc3GH2pghRVB3txOpZfNKBMHKNp/FLiqhbxKyF+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdweU4ij; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29800ac4ef3so10031315ad.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763337155; x=1763941955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knEPjdoRUKiLfnKO7GGFzIEEDEiEdL0akD0BsikWeWM=;
        b=JdweU4ijx6R29LhGY+MBds5EZIif60Z1mfdcvCDIycoE8XTNSk+r/IbLinBrXby8dz
         ZwkdkYZJmFNd+LUcxzH/HpU/bHx22/ax2Oibb+SnkdY0LZji+Yz0xFexlM2GF6lKagH6
         ih+GbDtbtb/3XdOif0bH1mY8QVZvUgz9CaZVpMbEkyUSnn0Jvejkpl6RXZ/7ZH4Pf6u6
         5uH2PHpcYrE5wMCKi7WKY5dT9qswWMjbPcf+cbE26+9eNeq2a5IUnWg8HCqDyIoXut28
         9zODW0+rXnigLFOyjybL01PXGMF25A8HA+wPfTQchSgU+UyKDh+//nSoL7Tpbav9NsZe
         ZZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763337155; x=1763941955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knEPjdoRUKiLfnKO7GGFzIEEDEiEdL0akD0BsikWeWM=;
        b=IbksdlyihV/fvJ+7+yEFlE7B+k3F9I0LBEsUIRlUUDj6BcM8KpDUOwDM1mgCZQu/KT
         WllpkFaoEkqWsdAn63FP5nSZBV1zXkbd3lZQy6Bt1S4M+1m5L7EGPtQFdsds3rKPeBNu
         fygC5amjdJcaYWSziwvQoEAhl1gwHDPXrnJB/oX0wKoy+f4qwSPmzzHZESure7/HxQ/7
         MQb7+aTEe2QTa7Kj5N70ivpHgmEhASojiI5EppDWCvpt8or+Uwliqjd+PRNkv/Vq3/vI
         xx81lYU0bNx/BBpy0Hw8/E+3wQfhjmSA++G0xjOUN/i9amxYQblyXxatpY6V0xlbUJ+9
         MeGA==
X-Forwarded-Encrypted: i=1; AJvYcCUXfbSeWwCYJx5nm42/oX8nFhvFaJDQ6x4sXyLJE2TGhghbhCd/nwERjPqzULZ6ZUj43F//Q4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkcfsmY3GpEffKcqKUdVDuIbQc5bb8VJ5rffSfR66fHktnZB0x
	nzAv8jFL6HrMcPtj0DmxJqp/9B9Mz5eVj9h1MER1KnN/Az+KzyAS2Ke3zmjW9kTu4unMfQqoT21
	HaJLYy3d4UCPa2wJNfKkNbnGlQcLis7g=
X-Gm-Gg: ASbGncs5l1LndNcPnr9DKQ1CgoKDeyqkc9MHLHl1FibBDgagVV/oICVE2gRMgGokfcj
	aBEiyhW/t90uKq+gGbA6vB3oagOREX3+Pik/qx3rKImzT8qMFhEykHbkcsxG1LGLIzK4qLkKHx5
	NzHZUYfdgIJE9sxJCvjjvjtvOnf3l9FlpjpCq589tGOWF2d/2ubSmYO0fitssewzvhaQmKeJwMa
	wyAySCZmPYx+kdj3Cqm/2V72ShkOgNBifMns5ul5WB+thrgBVU4YsTNyPldQv6ZptCI/4bD61EY
	UVEc6Qi2VrhpTSAkjolIU5c8aQ0zI6xWwry7UWfkyx7wteDLg9uhm2Rzzr+FLNo7ZX9iA4bEWQv
	pM1c=
X-Google-Smtp-Source: AGHT+IEPP5GQJGpkQvAHm/n2E8E4oeg3mkqFHU5A9snFx2FAUhtXE2SCjstCrw+QoGTLtYsyGouZt0iiD1TQn51UTAY=
X-Received: by 2002:a05:7022:248e:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-11b493eca20mr3590028c88.4.1763337155289; Sun, 16 Nov 2025
 15:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
 <20251113-core-cstr-cstrings-v3-4-411b34002774@gmail.com> <CANiq72mBfKwXEbyaw=pBAw37d7gCLVJqHcLcd6H7vNKey1UXfA@mail.gmail.com>
In-Reply-To: <CANiq72mBfKwXEbyaw=pBAw37d7gCLVJqHcLcd6H7vNKey1UXfA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 00:52:22 +0100
X-Gm-Features: AWmQ_bl-gNkTicpVObYCtSZ3F4-M6vnWSG4nKwGWGeOhtqUYQwGBsAi9iRsUdj4
Message-ID: <CANiq72nQhR2iToP8ZauwAjM2p1OWEK1G5cjsEXqs=91s7jOxMQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] rust: sync: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:09=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> This requires the next commit plus it needs callers of `new_spinlock!`
> in Binder to be fixed at the same time.

Actually, do we even want callers to have to specify `c`?

For instance, in the `module!` macro we originally had `b`, and
removed it for simplicity of callers:

    b13c9880f909 ("rust: macros: take string literals in `module!`")

Cheers,
Miguel

