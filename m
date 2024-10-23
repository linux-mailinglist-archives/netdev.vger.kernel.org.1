Return-Path: <netdev+bounces-138236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC0C9ACAC1
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1FCB20CB5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCCB1ADFE6;
	Wed, 23 Oct 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQLj9tyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC12156C72;
	Wed, 23 Oct 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688980; cv=none; b=ViD9NuSqsPtBq6fIpKqSwX9OfmT/3MehLG5XSrzkm5PhguTl5uAUB56j7hJiQ99NId0WA5T/tZHFt82LDcYkTgCcefzVPMu6FTzTHEOk5IGDVv88XFaqZS/tKNMKn++sn/6f3Wk9amL7DsRNxPnyZVXMoanG9aTcpX4rixThfLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688980; c=relaxed/simple;
	bh=jQ9/9WH7ZrEsfOMIYmLQONL2CsFM8pn1Cwr67WOtQU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmbHDVeSvzj8Yzn4Yqaf8lEvBtoYAM82uxSqKP2bEwWxsCV3eRnAkitfJFmFfy/sM1WxYOMCTCfbN7bcS9JQs4+sHReB37djnXafVMlxIpyjSrYiGHDObb/G5uHYZx8a9aV8VHZu40tUIE+Se94CxXE9/eeGKwBGdcSBXOWVM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQLj9tyb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso874148a91.3;
        Wed, 23 Oct 2024 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729688978; x=1730293778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ9/9WH7ZrEsfOMIYmLQONL2CsFM8pn1Cwr67WOtQU4=;
        b=FQLj9tyboy0LtEcVg/uuHl4TmZHzjEx5ITi0CA99ME0NqWOY5b82kUx/n5OKXp0N7v
         dcUfiYgUHePeJn+hhz5AY0Zw7nc7RrYJHWp4sm+ncw64b7bw1RKwctQNFt3ER68u478D
         YRRJwXsuVAZs1fa3rfY13whQ1demvmAhxqAwpGWsYqe1zXAoHxLTdZJ0Y2lHPAq6UZx6
         Bf2w+wDvuoU8nfmEcnxZslDBfq9K1ffxAKfejkE00PH8TO3YjQZAGuGJAUPHtxOczXuf
         xXFRjg62OImX7sZrCiZSy2DdQQiKodCEZwAxHLeoORRW9BrYCzhX7sG1a0RDsNa9Tpva
         9kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688978; x=1730293778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ9/9WH7ZrEsfOMIYmLQONL2CsFM8pn1Cwr67WOtQU4=;
        b=VOgC6LdLXIKEW4yH5JjJqtdDQT1GpB1/CPnd1iomWCrMV8rrVZoQWq/rvcsUhfL1sk
         ObaY2apN+x9SVpi1moe0ifhHOA39CTk3EScpVDk/rcdp700/Sl5ISdQrXB4a+uo0e3T5
         VQK0v4wE1V3HvIs2zRVaA1jo+ml4dvoic8MXvwD36rG9hQ29dhKUoUaevnqTr8JYpMzk
         dGYSW7rJw68ILB8iT4Kq7b5Jm/4g4IUpVXHUI31pZfGp0r7ppWc6+x3eHfngtFEuYMxl
         Ak6wqWxKTp6t4IhiQPYok0U9bOGK/tCHrbPFE0kIte1n8aPPX2p922EYywc6iwI+E9pF
         76gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5y2Z+p8nVJMd3OUdf/k/sPsVfy/u6fxxA5xyGBRh858Sw6mcTJR9Y5BBTpi39lY/fc8XFvUz48sPFtRc=@vger.kernel.org, AJvYcCXE9OkiH1PEmL2K9pvCRTTGNZMVMXNsF2RDjsJdIUX9frv3lW1XBjJCbfHsrJ4F47H65WPJNV+p@vger.kernel.org, AJvYcCXcvucG06vGcP3IQunbJP0ZHgdZ75bkLLzWBVUhvVvR40JK9VeP4VnvZ8SWrSyrvUs2wBqaNP9llvPfAoHhcqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDSHYk/WRfvluSN3NyjnoJygANlOcmgqMq3ArXXm2MRA/aFFb
	VtuOBl0jWpy9GvyKHNrImuCaau5xQunx7qW8ar7UkgcEUNP5wLY0d8L0j9duy2wlU+ZqAM+LOaV
	mhHBzBdmoEJ70nkFzj00SgXceOBc=
X-Google-Smtp-Source: AGHT+IG7BBsy1SQ2iDld34NBmrRkFzKTk4ypPLV9Be2XK/RQ+YiKHayD4gm6vhh+LZZmCe2i/VOdGtkG6w3uPBw5QEU=
X-Received: by 2002:a17:90a:fe85:b0:2db:60b:eec with SMTP id
 98e67ed59e1d1-2e76b7116e2mr1215907a91.7.1729688978503; Wed, 23 Oct 2024
 06:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch> <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
 <CANiq72=SDN89a8erzWdFG4nekGie3LomA73=OEM8W7DJPQFj0g@mail.gmail.com> <20241023.205310.480345328758576061.fujita.tomonori@gmail.com>
In-Reply-To: <20241023.205310.480345328758576061.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Oct 2024 15:09:25 +0200
Message-ID: <CANiq72kk=c_KqXi_V9HgeiLQ7BV37iU+viCEoqs2qM3yoy3zQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:53=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Should use &self for as_*() instead?

I don't think there is a hard rule, so taking `self` is fine even if uncomm=
on.

But probably we should discuss eventually if we want more concrete
guidelines here (i.e. more concrete than Rust usual ones).

Thanks!

Cheers,
Miguel

