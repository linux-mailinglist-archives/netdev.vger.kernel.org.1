Return-Path: <netdev+bounces-121622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2695DBF2
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 07:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48761F222CB
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 05:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C141938FA1;
	Sat, 24 Aug 2024 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ojDwj3WG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1670DF71
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 05:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724477569; cv=none; b=Kf6AtQ7Ni3iYIlFutu1n5e6yQQ7GPlZB89Cq6pdgxkNEgCXeasAOPT7rP0V7OEN0Nc0DEnoJNVM0g5IMmEYI34VBllLmeStI7dUU95Wvk4LmE+7AkoFC5L0Fnn7ER6/bgHubAaFKvtJSPPjPbKwTozbQVn2H+cyaSbJrF8OTcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724477569; c=relaxed/simple;
	bh=Cvw1K4vQwHce68PQHEUY32CPqLH+/gHJ1jF4cQ7qxNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hT+Y+vLOTeqchumKGAeWBTyoPKorGJg1R6CLny6n/CAmY5ddRq0JImKyfBH3xc13SCVARgEEw/Pq7mJIlxqjbenocpzojOGNHqGhNx+dbEJhydqfgz+/wTwimrk8dv8EgnK/AFA6oGW2dd2ND0gWpomUT3MgbSTEwlpW++XHQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=ojDwj3WG; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e04196b7603so2716670276.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 22:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724477565; x=1725082365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2YU53Qa28Il1Dv/pHeK75LfNR6pv6rnLC0NS995GjQ=;
        b=ojDwj3WGvEZFMBLC8+vkS08EVJPTK8xJnOJ1eccDDo/34Y5IWdPe0b9BUQjv1XUXAf
         /l/hI6Lh2k0F1x5L5xp925SRvEjQfK0U1wuOmXSsQofO9S/G/ke3amrOD2b8pvnzHl/a
         3aCgcY0owzG1o2lwgz7yEe0lMN0r4prMxfDNl9cDBhtE0xqy2rjUZFixkJpflocX+JDe
         X6w8Fg9N7s+kzzS9Minsd6W5pgGQT7KmSRoHigfB+n0JGFkPf4KOttS4V5tlZxepoGoN
         +sk0EV1SuCphtXPZ/etoXnVvTurLPblGH9YoyQ4iM1Cw/MNxXInxUWBobAYV98Typ9TQ
         /42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724477565; x=1725082365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2YU53Qa28Il1Dv/pHeK75LfNR6pv6rnLC0NS995GjQ=;
        b=xPrsV/VsP96rkCN4kwazPMpM8WDJnRbxFGWKX0+OQ7hgnALlbO2NdRfFxklAir/TcX
         9Ren0jwKB50sFYN6u2HpHYC0rZ7Z3EloLIr9w/t2V9olwBcIVra5DP0OxVz3CS+mnMmC
         niudnYLX1imv6gTazFFVEqUDsIaZ/KtJ1OWl5/9yW3jcEzzqcs0xlEzivxFq2ao+lbOO
         oVSOrbCuEadd0zLTFQ8l5w8UgXwez2/Y+EIJ1W5zJSjadLvwwmQIrSaL6WopLhLHc2KC
         kyrIFSqWxpE1bOE0EgSoVmnM50miuav4x9ejUJK/exsR5ajHAiz5zQ+l08cLmq2w7GL1
         dhNA==
X-Gm-Message-State: AOJu0Yx5uyCh+9Erkp6buBQr4b4dXbyB83x3ngj+x8jx22EUSNS9syGL
	PBkLgD4pUoWRtKyQz9FmgSfkKMuPtUtPTUvEcq6RRtj/gTm4M1JpXNP9wtF7gs6X3t1JN4TOp2p
	Jl09kT6+Jy1ykGCWOJ/tTIDxdFfOu3qQhX3PLbQ==
X-Google-Smtp-Source: AGHT+IHxhrVJ1SFncjf+cy1obp0h6/s+XJHGdllJP3Yr5Hemw8ZgH+v7gC0O9jo3J1BfQZvJGQGVLtjAsCrtPkthXxI=
X-Received: by 2002:a05:690c:6611:b0:6bd:8b0a:98b2 with SMTP id
 00721157ae682-6c62538d701mr58172557b3.5.1724477565626; Fri, 23 Aug 2024
 22:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824020617.113828-1-fujita.tomonori@gmail.com> <20240824020617.113828-7-fujita.tomonori@gmail.com>
In-Reply-To: <20240824020617.113828-7-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 00:32:34 -0500
Message-ID: <CALNs47tiPK-TWX8w9abdam=WJBGari3prYCiXZtWHdtgmGzHDA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 6/6] net: phy: add Applied Micro QT2025 PHY driver
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, aliceryhl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:08=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> This driver supports Applied Micro Circuits Corporation QT2025 PHY,
> based on a driver for Tehuti Networks TN40xx chips.
> [...]
> +APPLIED MICRO QT2025 PHY DRIVER
> +M:     FUJITA Tomonori <fujita.tomonori@gmail.com>
> +R:     Trevor Gross <tmgross@umich.edu>

Ack (discussed offline)

> +L:     netdev@vger.kernel.org
> +L:     rust-for-linux@vger.kernel.org
> +S:     Maintained
> +F:     drivers/net/phy/qt2025.rs

> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> new file mode 100644
> index 000000000000..28d8981f410b
> --- /dev/null
> +++ b/drivers/net/phy/qt2025.rs
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) Tehuti Networks Ltd.
> +// Copyright (C) 2024 FUJITA Tomonori <fujita.tomonori@gmail.com>
> +
> +//! Applied Micro Circuits Corporation QT2025 PHY driver
> +//!
> +//! This driver is based on the vendor driver `QT2025_phy.c`. This sourc=
e
> +//! and firmware can be downloaded on the EN-9320SFP+ support site.
> +//!
> +//! The QT2025 PHY integrates an Intel 8051 micro-controller.

I think the current state of this driver looks pretty good. Thanks for
working on this Tomo.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

