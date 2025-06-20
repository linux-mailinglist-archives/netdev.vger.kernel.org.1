Return-Path: <netdev+bounces-199849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F5AAE20D7
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 19:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900201C2435A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A01FFC7E;
	Fri, 20 Jun 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu37dXfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF844E56A;
	Fri, 20 Jun 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440370; cv=none; b=eY6yVgaVo81CjP8yaTRDkgEwCMv3ZG5bDNGjgkP6BW+AXgaehzhLEKB/fBSGkSZ6E4KPmRK+Prdub3L+9PTc5/nPRE/1gkjelEohHGKZPqDjiCXHmrnBG2m+R/5A5TXNLuSULj+sEPnEYO7shB5/XaekRS3NqDRVbJqHqx2Kbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440370; c=relaxed/simple;
	bh=1GJLN+aSgHB5kDHzgDzSMRMTM28do7yo+RBsf+cjyuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGAE7nQNvyjtXi25DxjvcbzlOgxPsP2JyFREr/FuRFUUaQiyAADv1zwCau4hQ1cDdBEiUHdanHZOjRZD3MOpje9OGrnzgeSN7lMp9ukTVou9A+xnXqs315Gu1g9rRnmemhSPem4TVHNOFHk8m/+Ytxge3WlimwizzHa00qlq3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu37dXfv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31c9d96bcbso341726a12.3;
        Fri, 20 Jun 2025 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750440368; x=1751045168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GJLN+aSgHB5kDHzgDzSMRMTM28do7yo+RBsf+cjyuY=;
        b=Iu37dXfvrQeVznVF0OcxPduFkd7i6lvCPEEpy+//4S1jSsLaeGXWIPA/nr8WjjMGT4
         JrsxoFKYbcOqV9Hvr/7FrPcMcavRGFxID9j1o2Gwpk2AJmj0+2v71NAptoZ/b92R4uOC
         Ld7XAHoGyF1982iLoq+dDR8q6D9HH6vr6pxWjyrbCtrv3EZL79a+A7dr20U3ntBf3k6V
         /wcM8P64CILzLoHgOp+6q72+BbEsNuoE7wWni03TQJdsdtZOhnWhscnFd9QkGAOlz6wt
         USYrZFEH9uqhDoWLF7+bTgyGJYiSnI0+s2x8Ig2xYCXC+FGiuoeYZhExKbcrm1aHBNGh
         9Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750440368; x=1751045168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GJLN+aSgHB5kDHzgDzSMRMTM28do7yo+RBsf+cjyuY=;
        b=wbzXIhEHnV6T3B2xYNpkcVNAt1yMYiAdhN9HyVKBm6DDBQ8pimfxaQLfybMGl2pM8k
         w+fv/emzd9r+OcdbToLNvCowOM2VuB19zqJV9tRqKLdoOaoLo76ovN5OhwFLblTbtLlW
         ija7w7jnuHkXU7haP1hBItdRw5mRGqUGhliJEd8O1WcXGHwMs86VsN7WZro7dkOmIKDS
         /R1Fk2gA+4c3wd4bS5JvFgbwBDQ4CMYkd1C+ryxJn7JXhRJpuLVqN9R13npcXWr4zpJz
         7+US23SQRGhZWP/cZXLhsnchdeTxJ673uh1wsCDf9VdVmhsAxZJGm0kKNOwPL5nGm5qx
         343w==
X-Forwarded-Encrypted: i=1; AJvYcCUfX3HvrsB4Ox3I1ce58wwF/vCw+74YChvBb3wa6QJcMiLDYSco2BY5RRMZrZtsx4z7dm7u5wL5PB3j9NU=@vger.kernel.org, AJvYcCWWDh5HUGlf0AbAu7AYIdxy+GBcBghW6HEh/veg3M4KYU5NWzI/gob0lag4Td21KgOCJlpnF3huGeDpNCN368Q=@vger.kernel.org, AJvYcCX1KN4TAdv6i92Y302y1fIroUFUiP+9nVt82FLEZjvMGxhePF/rHNvGo0cd85nnux13eUXIMDtb@vger.kernel.org
X-Gm-Message-State: AOJu0YzochrQthq4FTnluJju2jK8AKwt4UkPZ4yMJuNnL84T9lOZWw7v
	GFEK6fuPU+GPpXdMdjuGUtlRCmS7fEwYfuFso1YgrVyp9RkH6cPNxqCI+KnQSNjyR6gX2dt08e8
	sgv6Q2Gz6XqZAg7Ae8mHoMRkmEdzjH18=
X-Gm-Gg: ASbGncsYn51XIJGPPhfCmE2wKtORBLcZLf2KgU04pITZHy8Wuz56kr285E8bHmstXT7
	VFZr3ODNiy824UO4y+VOp3XeRjnIX5wDMrK2DD5X62wMTUeOOKyyGz1P5+aOtpzlEQzBcUx8fmI
	d7dHflex6Kerfv0f1k+vaxKFLdnWqhzhAadIIwXeEGlDMQM4LbLIrxPg==
X-Google-Smtp-Source: AGHT+IFfbmplBHvbHaFiKNC87qzTe7B1C05hqspv3Fk4CreaROvbg/PcMTllXCXpIodUbd/uk7dh+D3aVXQkeK3BSwc=
X-Received: by 2002:a17:90b:2dd0:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-3159d577a7bmr2283296a91.0.1750440367956; Fri, 20 Jun 2025
 10:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9mazp=gSqDEzUuh0eTvj6pBET-z2zz7XQzmu9at=4V03A@mail.gmail.com>
 <20250620.075443.1954975894369072064.fujita.tomonori@gmail.com>
 <CAJ-ks9n-iQAiwN3CVnJP164kPEgwq5nj-E5S7BnZrYdBWoo16g@mail.gmail.com> <20250620.100539.89068405138839860.fujita.tomonori@gmail.com>
In-Reply-To: <20250620.100539.89068405138839860.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Jun 2025 19:25:53 +0200
X-Gm-Features: Ac12FXxNpfpq-RxxpQaS8W4C6ZgjUq7qMNX1ENHm2lv65fLGv9-ZiK1x6jApYr4
Message-ID: <CANiq72=R=wM2Xoj1B5gOZGBGj3RWYdUN1DEwVZjTrqPL4DmJ1Q@mail.gmail.com>
Subject: Re: [PATCH] rust: cast to the proper type
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: tamird@gmail.com, aliceryhl@google.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, dakr@kernel.org, davem@davemloft.net, andrew@lunn.ch, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 3:05=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> With the tag dropped,
>
> Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

I guess this will go via netdev, but if you want me to pick it up,
please let me know.

Cheers,
Miguel

