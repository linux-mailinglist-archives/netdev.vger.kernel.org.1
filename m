Return-Path: <netdev+bounces-137217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771829A4DD3
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B272868BE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336D41DFDBF;
	Sat, 19 Oct 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4oaRV1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7E1E4A4;
	Sat, 19 Oct 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341682; cv=none; b=m/F4I+cfinCAh1kP8P99hKgB0lfDMQet83OUDCrmG2rdHTwd6H+g24/K0m9mfFmwIO7LaKIvsutXhf8iNHwWa6OMnYFo5YFIqgZDXxViM2JI5qY51ZlYQSEROptYCgLK87grsl+LEkTAc85p8c931uRUe1REiFS5x5sSZua2MNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341682; c=relaxed/simple;
	bh=pDRq5XUeT1FKJulbVFabG+bdLxp/YKnBhoGRLsjHd9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjXNNKDcTsSb+x3Yjvw73bfQsMjxRmvpYAeF6GhWAdTRl3y25AKOILU2Wde27c3bz1WkqVSHMvEdKdJIdfcCUPaVhV+2HqvEK33+sL8y2B4GwtrjYdKyeE7auqE9/8v0bzuA930NZZ4gRk6p+PA0pxlYnDpcFF+fQcDzxHWm/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4oaRV1Z; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso556097a91.1;
        Sat, 19 Oct 2024 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729341679; x=1729946479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDRq5XUeT1FKJulbVFabG+bdLxp/YKnBhoGRLsjHd9k=;
        b=B4oaRV1ZPiUztkGjps8xtjhqmaqXhFCPmmT8auKTc1Ew6Mfi/Xc1aIPX0sWSqmmF3X
         CiaVy2rWj74Hbee1zG4FsWqqHX0KZD3QdeyXHd9SngyDH0rKNgR2R0zXN5znYFrOpsrW
         Mui0uOrWW1XnUN97X+fC4wqsFUC/oobE9yYUD6tVpFjivhGzvzz0zGuSf2ZWnWQjfT6z
         Qe0NehvwgnCVKG4rOucN6tkCCqg1FcSps+IgjBYVbpozZ2pGSpq0tdpnGH8w+o0KfL5a
         7Y/0jKIYnluPFlc/3Ce3HqfjQ/41Ue8boWi2Rql10zv6i6DOe1s4vRKq3+B2/LfRngBL
         bXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729341679; x=1729946479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDRq5XUeT1FKJulbVFabG+bdLxp/YKnBhoGRLsjHd9k=;
        b=LLljfw44ph8vEDZy6qgU0nLJgYxb6XJJaWGo9uFP6vydX8sTgfP+r8mwww37vxojfp
         JYzjsJEsWp6fbPJW8s5PLGcDiWWEz94KlWPsXHAz9yuPdjxQIruzdbW4A4BzZ067RWYL
         2EhOHDm1sPe+1UyQhvXsq5d7oFf5uUnTwwM6jA5eRBR6uktJ0NKTuQRXoAVCUUdY4uJB
         2X3fGItnnP1Cbpl+Aeg2oaAITp9AlHWkG4brC1fZIi+w7ShBygXVXLpya2PePWsyTEH8
         uaJ7d5/Z6r/6RasLeQc/lVh22psjHf6fCzwU5mmV5R76j+5GTRnFe+fG35Hu8L6gNJNR
         WAEw==
X-Forwarded-Encrypted: i=1; AJvYcCV0VXiTKPQyC7vmsdIuw3VzY7FXMLh1RhRSzBeNGyIk3zDD4iAH34lrnIWgq1ZRDwOW142l818q@vger.kernel.org, AJvYcCVYXJwp+SYrZ6zxa6UP40Q+hk9JJ9NuucreqnOPatkM6QMYrCL8LCEBSz1VGD2nbEEE/EM8gNkcX2rxFSgLyiQ=@vger.kernel.org, AJvYcCW7p03gup4Kdfgdsx5D2qlBTU3U1fT0rS5Le4A3AXFO5PFA6XYQ/eW2azVUHzYIenJO/WH8RmriAC2Dbk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLl1ZOXPcLoooxxEGxmLsxlE7vbe9v9Lnirm9rr5kai5kXE+ZL
	m8yneLi2m8tPS7++yp8zrsmgeJAAg3J0awDdwMt5XfXPzCwbEUKC//H+o/Alqrlb62s+Tw3Sf3f
	6+S/7GOIALQ8H7S5NrBu5LbCBVAQ=
X-Google-Smtp-Source: AGHT+IFfblkHjtkpy89oqgoQVHtlbxXiTCQwLk37nU1+Im4GK/deocfjEDtgV7/8pSS3SaHG8xGssNNgpDF2aImWS8k=
X-Received: by 2002:a17:90a:f485:b0:2d8:9f4e:1c3d with SMTP id
 98e67ed59e1d1-2e5618efbaemr2720209a91.5.1729341679619; Sat, 19 Oct 2024
 05:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-3-fujita.tomonori@gmail.com> <6bc68839-a115-467f-b83e-21be708f78d7@lunn.ch>
 <CANiq72=_9cxkife3=b7acM7LbmwTLcXMX9LZpDP2JMvy=z3qkA@mail.gmail.com>
 <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch> <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
In-Reply-To: <CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Oct 2024 14:41:07 +0200
Message-ID: <CANiq72=SDN89a8erzWdFG4nekGie3LomA73=OEM8W7DJPQFj0g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 2:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> differently, e.g. `to_micros_ceil`: `to_` since it is not "free"

Well, it is sufficiently free, I guess, considering other methods. I
noticed `as_*()` in this patch take `self` rather than `&self`, though.

Cheers,
Miguel

