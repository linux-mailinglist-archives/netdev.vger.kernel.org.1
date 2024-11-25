Return-Path: <netdev+bounces-147180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1625C9D8205
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF64F281A63
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAF19049A;
	Mon, 25 Nov 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8xcS+tT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBD1531E8
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526156; cv=none; b=gebKNrR5sek+Sl14jT1bb3xHzZLjlaXb+rlvEVUYwheqBuMOZD2b3J1BDLpHe6r5txw+pW3xp54wltO+sVxGotuYD/Gvm8hmRFGrkrFxXPxGf5Er7roGJTBYVYFglzxp7CltXTxIGhJ7NH3FCEfqESFzfmNqpi+GvhaHJ4LmS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526156; c=relaxed/simple;
	bh=0ha3COx0DHOj8uxVj0+IXNOyCOzZMIKeCo7cSFiOZo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzTHPfn37Jjq7M0rRVNH2XgNjA07A9KQXrxRatV4ZMXDzFYk6WV9BEeJR5y10wN5Cg1VMIfLh8O6R+cFngBou9oEhUVaEzgPJyd/tqqqyCYTY40U6B5NIOJ3QHJRyiuYIrTIuXdvIxr+06vhXL0ueodJTw8u3L1Yz602cSAEqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8xcS+tT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so3270311f8f.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 01:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732526152; x=1733130952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ha3COx0DHOj8uxVj0+IXNOyCOzZMIKeCo7cSFiOZo0=;
        b=Y8xcS+tTTWlf9/6R6RcIHXDyFyLx0NYP3v7Qp6LDlZunXveUB+nNcRMOOfqG46QacO
         ZJ1W6+WVTekrxD/lQNa11Zbi/JXVsDCXDKCK6yoyavqdXqXdsAUDl2VnEIzLD37Wj8Pt
         GEm22mlGlq8ivVDu0ituahMFRO063vyyqE0QWCo/RavTB3ELTaLIRAXvignghtCUiNh3
         3QSgcbiYVtmOQIyxm4zFXtCaX6H4BF5z12TbaxeLaeT0xeLV9u3ZJm8O/FXnNqBVqNwA
         Z3S7E6HBzLA9MD0Y18ePo5gKdixPMhbCQTqhQPAjYpdwFHyKaTRqQQj4uN5MmMiPYDGJ
         OszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526152; x=1733130952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ha3COx0DHOj8uxVj0+IXNOyCOzZMIKeCo7cSFiOZo0=;
        b=m2uaCj0uaRa1e7kq9IuDdglgnZzz653/DNtpC8+n78mxAtvl6Z7GclNdY/rshswFUQ
         kCq5z0s1gXWCEtAJUEpHt0bL77vML099nIyXRXqdDahAM+dORM/JH3UJX4k4/WvS8zu7
         0fBesRZpAR9lwClY10k1PdUrxDqORY+s3lnFjRiktA8YDUPNX7nKRw7VP84DqLrr5mx4
         uoynooYY3LFKhWfYBWSPV7l9uokWSvUdX8YRD6GHWGCuAOVF9a7VtYrarRkmMNd+qAuO
         MfAV2C4uRgXzx5NixaL7PC5K7g53YYa0iUS4JzcywKg6XJ+UHg1wWsfBJfxODdfnYMOq
         4QXA==
X-Forwarded-Encrypted: i=1; AJvYcCV3HXwAiu4wkCZLiTP3T70lmbpDlNB/BVB8sDGnY8w0YjGe2EB0hCNqZeoGMtHY7b1FnJiK49U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8PPyFTQaaSOlrXnKlRMZLsRtsysbii8HhCOaT5OsL4of939M
	ZSFYBDcdWAkOzDbngyVoOBg1+dAyrV+foAyLsr9y3SikB2trYGdDgRDMfDdxq6w9zI7Xrx+cG0M
	AuWFGrob6enq0JMKVpJeQwk4cm0tW6pVZkwvy
X-Gm-Gg: ASbGnctmQSQIaDq2GDUCV8MzUwYuub/QmGfQIfD/m93aLZK/Jq/2TesBjiN3qWwoxCP
	+Ws93oWNIU3AEK7aP0TTOw6b+ck3EQ++KRruRKYjjFF5PdsHxpMklJuMqHM726Q==
X-Google-Smtp-Source: AGHT+IH8NglVha/cRO2EUsWas5pT6+KPbdrlOa1Qfc0/+y2Ov2H+tjMFSpQ12N28tn+7P/9GBO4emIZVFBM59ocV130=
X-Received: by 2002:a05:6000:1fab:b0:382:4a15:6928 with SMTP id
 ffacd0b85a97d-38260b5715fmr10344321f8f.14.1732526152020; Mon, 25 Nov 2024
 01:15:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123222849.350287-1-ojeda@kernel.org> <20241123222849.350287-3-ojeda@kernel.org>
In-Reply-To: <20241123222849.350287-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:15:39 +0100
Message-ID: <CAH5fLgjoC7=gBBnohf4GPLPrk+wpR7P5KMm25EAmTspdTjg=4g@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add `build_error!` to the prelude
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
> The sibling `build_assert!` is already in the prelude, it makes sense
> that a "core"/"language" facility like this is part of the prelude and
> users should not be defining their own one (thus there should be no risk
> of future name collisions and we would want to be aware of them anyway).
>
> Thus add `build_error!` into the prelude.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

