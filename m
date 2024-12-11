Return-Path: <netdev+bounces-150905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3519EC091
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010E9188BB13
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D02A1D1;
	Wed, 11 Dec 2024 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPiv9jQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C929429;
	Wed, 11 Dec 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876104; cv=none; b=ntLI0C14msat2TkDFcjLpG9jEYVzgm36qbNfXyAKQhME/6PaQetzTZkg6fjBgB155/7EccKCa5YEAtgiJX6rXQGV9OSacKW4odLrvEB0KeZekv69lmTfwGCI6jz4DfxcmyWmydYY2Gss2ZiHY1MMPK2MKglGWDPevoaFi91I9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876104; c=relaxed/simple;
	bh=HJ+qr4n9qbZDCwn+xF+Vopc7w856gIqQvLHjH+D1hbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM4nRRw4JPhf8IcarHlK3U5XENL1Qg3ijOa6Yiz6wT/rRJVKExJ30XQlq6TR1oD9KMsdwBZhgojOXwU5y1Ji3CUZy1PkOBGG6qHndhUkP9MpXIL6rG/JYSxFpXRjrfvGbpsMRJo8mimQVX/qGRVhh2u90b1XG08to3SzN7rYxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPiv9jQp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216325f516fso3149645ad.3;
        Tue, 10 Dec 2024 16:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733876102; x=1734480902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBVdwKlLaYGxi/QGz2w6Qngx3O8Ek49qub5WSebJONk=;
        b=nPiv9jQpyxr9/NiVYU+VvyBUJSXzgBqvsv1oA98copOEyObtLFABVEQxVYHNB2gQY7
         9GXw8yB9ONq034jSCSjmuk52Sx4kVc8FHNh7CPRlrIf5HvBkIJj3EL3xvMIjGanqrcok
         hzo9qN/AIwGJUEpA2hplrlHVHsivogq3SQZTmkPOS2Bx97tDgqChnCZ9WTOKxO+wBNNw
         +KkkNR9mm084SOAxjI54BDdt3NEVc1XwOqpFiq7wp5Tto4CrRC2rVPLpTOkor78VNb8l
         Tm/LwUqGf4Jn4D6Pl71ns83H0p8lPqq9V31+5Zk5Z8fZgD7YfbqJcLh/7UcD/Le30yY0
         8Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876102; x=1734480902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBVdwKlLaYGxi/QGz2w6Qngx3O8Ek49qub5WSebJONk=;
        b=Lh0MpzeNgL1Db4QrrGcwDBcHPZyaxS1tgln1PX16GyxFWaU3f6lin5UqnjFD0aoyPQ
         ODOdM72XgV1zU5mzVlErjZDFC6mmPfeOLOkt7jCfdYntFMThcYpfgbB4Puw9EWqC1G4q
         RV9OxixZ9hRLWL3CUGVxyRrbYlD+p4veHOcTM3x4EYOTOjXEna0F6q67/NpKoS8sDU2Y
         z1UFgZhYDrjyxUYBu1IXkHG5tU/ZvmaMMaU65IwaVLIXiOsJo/vcb81oOV2XD8KMNb6b
         bi6CcgVTtKe49EVBqlSk2H9BCHkCIBj3qEe2qSLn66WFxqhQJv6B+pNZ5QEKUWsQIYIF
         yD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc9lqvjnXSbnnW9V0jDofTNABELXu/uPBiHCGkOPiuSEkfXmu/jWNaxud8XHO3GB/7Px02huzqxhbGa8xPzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgopVGJ3AXqNou5lXAmMKOEspcFjixMG3/lNJi9BiHMEvPaNZs
	p0OoZlTir0mhD2A9+tCjhnDSrBKBTIS6UZJ8xXAYl+gGL0IttN7sb0uZNvdBQ3p5Dtb/WZS0Rj1
	jFFDsm3q2Cdjl20rAStYi8Z2bGkrIBAgUxA8=
X-Gm-Gg: ASbGnctFpEqGLFHZn15kr5hJ0swsfqYzJnPtI4hpk90qcCsLrXJ/UQlNX1rnIcKC4ZJ
	/oeu0uidgaLylCSH92UIMOQkux4CYIaEvufY=
X-Google-Smtp-Source: AGHT+IGfx/vZOVVcJ3GV7BNC5k32CbyWv46xn14cbl/pnBXDga866oaOB6iwbuSL+1X9HzIuFQAUvB7qTYzLvg3yXE4=
X-Received: by 2002:a17:90b:38c5:b0:2ee:a558:b6bf with SMTP id
 98e67ed59e1d1-2f1280836d0mr528991a91.8.1733876101966; Tue, 10 Dec 2024
 16:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211000616.232482-1-fujita.tomonori@gmail.com>
In-Reply-To: <20241211000616.232482-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Dec 2024 01:14:49 +0100
Message-ID: <CANiq72kYQvuwX5biW8CRh8DAo-7bnudEUfV18V7StD_1LqrOBQ@mail.gmail.com>
Subject: Re: [PATCH net v1] rust: net::phy fix module autoloading
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:08=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> The alias symbol name was renamed by the commit 054a9cd395a7("modpost:
> rename alias symbol for MODULE_DEVICE_TABLE()").

Should this be:

    Fixes: 054a9cd395a7 ("modpost: rename alias symbol for
MODULE_DEVICE_TABLE()")

?

I guess this will go through netdev -- thanks!

Cheers,
Miguel

