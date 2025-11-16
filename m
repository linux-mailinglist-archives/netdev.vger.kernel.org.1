Return-Path: <netdev+bounces-238996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D891DC61EB7
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 23:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6090A35C73E
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 22:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5D30B519;
	Sun, 16 Nov 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDbCBZb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33194289340
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763333701; cv=none; b=eNKht+4tvQD0PW+7yEVov3LUdBHgKvFuQaTizP/dCfGJr2N+5l9gPfEYlSVkjQu9QR9lk/WgjoQ8XuwOrt1HzSRxdcVoU5L/bTqw3+9VvEx9PbV3n+RBtOpZ81oXOGUxpBYYWjBUXr90gODGv0Bkw9HfTcsG9rxy4BxPbdvdVGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763333701; c=relaxed/simple;
	bh=u8rw8igxH15SPPt51q+eBjZC3lVn7st6YgN8bjWkSXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7+VHdVx9dPKcGw4qRzsaCQsLPgjI/GkwPLoiovYJ1BCpG7A9dgM3qChl4Z9qWAtVkaKRYF3cFKRLN0Xly6ZqT7vQrudAUJL41f3m8DOF73HCj2Q/oUnlJWRTnulCSLSD0SHECpKmWDgqYeAfAcMnrxB/HzNVFBqejXs/wPYRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDbCBZb8; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso281962a12.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 14:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763333699; x=1763938499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8rw8igxH15SPPt51q+eBjZC3lVn7st6YgN8bjWkSXE=;
        b=YDbCBZb8p+nwhYAK/IZLGxXBfMIYSRHAj2LmrfcWShmJe+hk44ALJ6tH2BEa4luPeL
         MJpZLl+/sFjCP5uxH2tP2IBk9Uzh6jqOWZMMzLKf8xFo5XZylI3ZxxaXi5gJALzpJTvD
         6PoM/dKQzzo13tPWfxHEREJPHZPGgpkq/scLfEdi0jH/AK+DtSQm0oQ03HwOr2euWv1h
         Uuxip5NaiorJFywsgo4p+uMYHuoJjbo1GsCUwYSm/sVXqLGx7VZbXdKz8lgaJ4luw8Jk
         0O+Q5wcScpCkHfDf5GS3zwF/zdJ9AoSG4Ul5DWnW2pUtiT+NkXAi4axZ5jz913Z9y3YX
         RelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763333699; x=1763938499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8rw8igxH15SPPt51q+eBjZC3lVn7st6YgN8bjWkSXE=;
        b=G9zR/mA4odcw0emfCR7kBc/rHTCYjau8mZg3xM6Ouwa0URZSoaYKV4fVAWI4N0CgBx
         hF4TBpjHAjXPS2RFeW02Z3y2BXooJdFS9aiwLbR922oyDJZfrjzCcFbowzy2XZnW94Te
         LHLQ0TKNVqefxHKNC6zKrGU7OrDSfRsOgG4LggNnnSfKqXvHZjHE5Y7aY4qcNVt/fj5U
         DUeJDTS5wlaDO3nKjN/5s299zVafJquDdcowYsr4M4FP6X1Jd35ixeYcQv/EB4nCGeL6
         Yq8wOUuW+x+nfVj9RrfxvIhietJaJROMxgyJ9kI5ZRNT7z1WAn9VlDZuVYILSBGyotwY
         4vvw==
X-Forwarded-Encrypted: i=1; AJvYcCVkSHvrKvsO91hdNfYd3eDExFFAhcKUdiN4Oiw2anwvGdPVF4m1IjizsbG3kHsO7kcpfzEKGrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZeygEE0GLFmo7OXdaxrrMRQT5OAVhoYIc1cfS85SASWLxBHm
	XX1dpDjaktvElAH1xE6nM9GjgiOVhaEL0aAf5B9kGX6F4HGXw6B4+hX/thGeswIXmnzw1e7o7sK
	Bcv07SpkuWMkOU2L3QbBC30aexA4eUX0=
X-Gm-Gg: ASbGnctY0upvC0J4oC9AyCs8VMocsCYvbzGzfqsaTlspZgwP2ZnOSW39WVfdH2TSvzF
	qPZb9eu1MSJckoEZWzmNAfC3Xo5Jv+WyJJrczUW9QF1Zvbxor1ee0Io/R5Eucurb9IsRgVvTVT5
	581Nw1oGE8oEZVwT7cTjwUuGAa4aPmrDiDj0m9Wz65lfvQieV805Swm2ry9d02ApKJZ0RSfu9qS
	LP6x83EI6iGEwiscG0MWjvl7pdkWemALJINwMTnxs0ZdtJkyEY3lACGIoius0VTjwIruUCdZ4Kt
	vk/wcDRHZsAoKyCUYWMBWSt+KG2wU58vSQirywdVPUp2t+831iUgXHFgiC2vpBo3hw6yyTlUau3
	bh3Iu2Z33vKmboutOSXeRovuh
X-Google-Smtp-Source: AGHT+IHhWib2hbofO5AR585vQ/ehlpO7iragqRX0aN65j4kw3Yrtel7mxi5ENuehJqXIVsBQ+2eAsjKmwhzfo+kLQSo=
X-Received: by 2002:a05:7022:e0d:b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11b493dbc02mr3486565c88.3.1763333699366; Sun, 16 Nov 2025
 14:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com> <20251113-core-cstr-cstrings-v3-2-411b34002774@gmail.com>
In-Reply-To: <20251113-core-cstr-cstrings-v3-2-411b34002774@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Nov 2025 23:54:47 +0100
X-Gm-Features: AWmQ_bk9od_BMaTJXEDsnPofuZ0-9K2n3ZCa9h8ue8i5g17ewbCUg6ZfYeY1qAs
Message-ID: <CANiq72m0w8HkVmD46UrAEn8nVvR=U5tft=GUBLSMqDWGk9m64w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] rust: net: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, 
	Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:58=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Tomo, do you want me to pick this up?

Thanks!

Cheers,
Miguel

