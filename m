Return-Path: <netdev+bounces-239036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8B6C62B6C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 029FF4E729A
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99C317712;
	Mon, 17 Nov 2025 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR+v8Zu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F4156661
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364371; cv=none; b=RRwkO4hXIQM6k/CQxNvb5n9HjTLkbsCSiXHM6lq8eqVWUuY976++vOI9imDZGoFsnBbwURzPXQTmczi8WFRni8NDsDdhg39jWzFJIRQZ72ZRj7B1J9uU7qHtVIu2uaoPfP7DwT9mbhnm8vMx1X1tE8kZZEaSoOnzqRE4Sf9WNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364371; c=relaxed/simple;
	bh=+vhgx0R2+nwdQ0jhqDjY7+bnmgnFuoC37OlpyAX2iS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6gPDurRz2tR29VOi27BtIDF8M/WA4YOZKACGt6N70VNb7hBBvxhv4arncFJfQwG4/vBkbrrnqRqi7P2toRqqCaD9HPfpwb6rFDBwkI6opxvJyIDIj9rSolTbRWPBJ+sdgDmsnwi3rm8W6108KNycugruC5PuWcBrXpYJzlCn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR+v8Zu1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297ea4c2933so2644015ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 23:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763364370; x=1763969170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hi18ADCLMdmNrGkhvncpabdBE25t2pUlhbnTlAMD3k=;
        b=OR+v8Zu1KqtuZuCaHVvodxsUV+Lh2vC/g3p+gAvaRZiaGr494hK0l7f+xJH50Z+HRT
         QLH1Do1pd5q+tlBHcZ2ePzx48UCnu6WzpaJh6CWPzhk8NzhHtlK54Y3zOXsPLGsTyTaD
         k8GMfnUYkJof30V82UMqLZJQeBqwb8+3VUv0+O19Xtx/5KhlAOkT/5GYNOJsUNHpzvdK
         cYTBOSCUbAjzpZVZmTlu51D0oqmaLH+heMc6fXBHNcnW6G7UegT5yoQfi52NAPys+MjD
         XD+6HuSW3ES3N50ibzLHy6b02fIFaZ+F8RyqUYCuo2yhsefSdo0MUyjMg7d2J1bKZHNF
         gp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763364370; x=1763969170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hi18ADCLMdmNrGkhvncpabdBE25t2pUlhbnTlAMD3k=;
        b=LiRfsl3WDOsIVt2IaXCNoHWBODbclFP3u5cuTiNYyDV25hrUHwn8PpEp8+6lkMADNi
         UlUGnC3qi/FQcR7A0gIxUuaXkFkON29CCr6gy/4kdJH8o0VD7wqyVnPFZKP6RvtUjKIu
         wMa7082D+xAyMfryudl5GeXcqQmcZLQxAPqpH/d1UjYVYlhU1HHPvSlIHnuGmw4JE0Tz
         sPX+duYQa4fkR9fgp0v41HEfrl+d/prQr8WDmk7GZWapwj6FImXiB4o+sd1EPrBWsL6h
         L9fuWO1MyEy68vUYKPjwBWqYNtLOG97BBHAKlzPDOFOsLtf++0/ZiSHnFbgLWb2kosQV
         1qZA==
X-Forwarded-Encrypted: i=1; AJvYcCVHlTOkPAmBlFu4K+IOtIMT5yCoAjmM8gSvXE78pfbSzilGHtzXB0UdCcKwKr32/RLhOGimNfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFg6SASSz1pkXj+xvafvBpK6FfhpouqF5+lsWTdg2dh97UxYzO
	EabAEdbBuLbxlZy38CUv0iJ7glqZhDZYwQJA7pOJfC1xyzMjbOSfZo2A0CLHgMWk5/Pr9fr/X/v
	GJG0R8NjzRxR/GKQzFpW382hk8uWYwvE=
X-Gm-Gg: ASbGncujX1tEuDR/tEB0Kpe6XnA80AD3MhtXa6zwgNZCkkDngREJTosFb6JbkMzXGhJ
	NCwrOevD8DmxiV3fxWYVdY5kPZpNJTQxo/+goYRjq2EzKxb6UNPyJ8VDWZD0SmqKowrz+BfTIrH
	q2tKc35yCIJjNuZMUKfQe2I49s9lCVH5oOP676AMXNM7szWfI4AZ4CGLf/SoL3ouYcgHiEj8RjE
	ULbt/hARw3OH/yznOEoB8WmnEba8pC4gaHOfZ5GzLTN+MWX5gFvEctTW5Bky7PfindfFIkx9GWm
	0cGe1L9WcyLlpbB1wycZiIuMGs1bhL8FYN5DuqkBlwGsuOiE44eu3C/hnCuC4phXcDPgNS61i3S
	qEcw=
X-Google-Smtp-Source: AGHT+IF/PIYQj3gjc7VlpoF69ig9CzVeFN3TyJZEsBlNeiFlQfYqKERjgC4a6WV9Yx8KiSnMrhRF9MgfZc32gGYqcwY=
X-Received: by 2002:a05:7300:d0a7:b0:2a4:3593:5fc7 with SMTP id
 5a478bee46e88-2a4ab8a954cmr3839409eec.1.1763364369738; Sun, 16 Nov 2025
 23:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
In-Reply-To: <20251113-core-cstr-cstrings-v3-0-411b34002774@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Nov 2025 08:25:57 +0100
X-Gm-Features: AWmQ_blfzP7tgtY8Fku5O9Ya-p4__2p5hyhk5bTEZBAj4wCrgnbPLXyOe9G6FRM
Message-ID: <CANiq72=aqJYSqqDkkn3v0F1N26rv+z_1+1+WgmU0Yg8_S-+Oqg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rust: replace `kernel::c_str!` with C-Strings
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

On Thu, Nov 13, 2025 at 11:58=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
>       rust: firmware: replace `kernel::c_str!` with C-Strings
>       rust: str: replace `kernel::c_str!` with C-Strings
>       rust: macros: replace `kernel::c_str!` with C-Strings

Applied (these three only) to `rust-next` -- thanks everyone!

    [ Removed unused `c_str` import in doctest. - Miguel ]

Given how many transformations there were, perhaps the Reviewed-by's
should have been reset at some point, but given they are simple
patches and you carried them and nobody complained, I kept them.

Cheers,
Miguel

